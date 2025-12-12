import { useMemo, useRef, useState } from 'react'
import Avatar from 'boring-avatars'
import './App.css'

const palette = ['#92A1C6', '#146A7C', '#F0AB3D', '#C271B4', '#C20D90']
const variants = ['marble', 'beam', 'pixel', 'sunset', 'ring', 'bauhaus'] as const

export default function App() {
  const [name, setName] = useState('Ada Lovelace')
  const [variant, setVariant] = useState<(typeof variants)[number]>('pixel')
  const [size, setSize] = useState(72)
  const [square, setSquare] = useState(true)
  const [usePalette, setUsePalette] = useState(true)
  const [downloadFormat, setDownloadFormat] = useState<'svg' | 'png'>('svg')
  const previewRef = useRef<HTMLDivElement | null>(null)

  const avatarColors = useMemo(() => (usePalette ? palette : undefined), [usePalette])

  const handleDownload = async () => {
    const svg = previewRef.current?.querySelector('svg')
    if (!svg) return

    if (downloadFormat === 'svg') {
      const blob = new Blob([svg.outerHTML], { type: 'image/svg+xml;charset=utf-8' })
      const url = URL.createObjectURL(blob)
      const link = document.createElement('a')
      link.href = url
      link.download = `${name || 'avatar'}.svg`
      document.body.appendChild(link)
      link.click()
      link.remove()
      URL.revokeObjectURL(url)
    } else {
      // PNG download
      try {
        const svgData = new XMLSerializer().serializeToString(svg)
        const canvas = document.createElement('canvas')
        const ctx = canvas.getContext('2d')
        const img = new Image()

        canvas.width = size
        canvas.height = size

        img.onload = () => {
          if (ctx) {
            ctx.drawImage(img, 0, 0)
            canvas.toBlob((blob) => {
              if (blob) {
                const url = URL.createObjectURL(blob)
                const link = document.createElement('a')
                link.href = url
                link.download = `${name || 'avatar'}.png`
                document.body.appendChild(link)
                link.click()
                link.remove()
                URL.revokeObjectURL(url)
              }
            }, 'image/png')
          }
        }

        const svgBlob = new Blob([svgData], { type: 'image/svg+xml;charset=utf-8' })
        const url = URL.createObjectURL(svgBlob)
        img.src = url
      } catch (error) {
        console.error('Failed to download PNG:', error)
      }
    }
  }

  return (
    <div className="demo">
      <header className="demo-header">
        <h1>头像生成器</h1>
        <p>输入文字，自定义风格，生成专属头像</p>
      </header>

      <div className="content-layout">
        <div className="avatar-generator-card">
          <div className="generator-preview">
            <div className="preview-label">预览</div>
            <div className="preview-avatar" ref={previewRef}>
              <Avatar name={name || ' '} size={size} variant={variant} square={square} colors={avatarColors} />
            </div>
          </div>

          <div className="generator-controls">
            <div className="control-group">
              <label className="control-label" htmlFor="avatar-name">
                名称
              </label>
              <input
                id="avatar-name"
                type="text"
                value={name}
                onChange={(event) => setName(event.target.value)}
                placeholder="输入名称"
                className="control-input"
              />
            </div>

            <div className="control-group">
              <label className="control-label" htmlFor="variant-select">
                风格
              </label>
              <select
                id="variant-select"
                value={variant}
                onChange={(event) => setVariant(event.target.value as (typeof variants)[number])}
                className="control-select"
              >
                {variants.map((item) => (
                  <option key={item} value={item}>
                    {item.charAt(0).toUpperCase() + item.slice(1)}
                  </option>
                ))}
              </select>
            </div>

            <div className="control-group">
              <label className="control-label" htmlFor="size-input">
                尺寸
              </label>
              <input
                id="size-input"
                type="number"
                min={24}
                max={160}
                step={4}
                value={size}
                onChange={(event) => setSize(Number(event.target.value))}
                className="control-input control-input-number"
              />
            </div>

            <div className="control-group">
              <label className="control-label" htmlFor="format-select">
                下载格式
              </label>
              <select
                id="format-select"
                value={downloadFormat}
                onChange={(event) => setDownloadFormat(event.target.value as 'svg' | 'png')}
                className="control-select"
              >
                <option value="svg">SVG</option>
                <option value="png">PNG</option>
              </select>
            </div>

            <div className="control-group control-group-checkboxes">
              <label className="checkbox-label">
                <input
                  type="checkbox"
                  checked={square}
                  onChange={(event) => setSquare(event.target.checked)}
                  className="checkbox-input"
                />
                <span>方形</span>
              </label>

              <label className="checkbox-label">
                <input
                  type="checkbox"
                  checked={usePalette}
                  onChange={(event) => setUsePalette(event.target.checked)}
                  className="checkbox-input"
                />
                <span>自定义调色板</span>
              </label>
            </div>

            <div className="control-group control-group-download">
              <button className="download-button" type="button" onClick={handleDownload}>
                下载头像 ({downloadFormat.toUpperCase()})
              </button>
            </div>
          </div>
        </div>

        <section className="examples-section">
          <h2 className="section-title">风格示例</h2>
          <div className="avatar-grid">
            <div className="avatar-item">
              <Avatar name="Maria Mitchell" size={72} variant="marble" colors={palette} />
              <span className="avatar-name">Marble</span>
            </div>
            <div className="avatar-item">
              <Avatar name="Alice Paul" size={72} variant="beam" />
              <span className="avatar-name">Beam</span>
            </div>
            <div className="avatar-item">
              <Avatar name="Ada Lovelace" size={72} variant="pixel" square />
              <span className="avatar-name">Pixel</span>
            </div>
            <div className="avatar-item">
              <Avatar name="Helen Keller" size={72} variant="sunset" />
              <span className="avatar-name">Sunset</span>
            </div>
            <div className="avatar-item">
              <Avatar
                name="Grace Hopper"
                size={72}
                variant="ring"
                colors={['#fb6900', '#f63700', '#004853', '#007e80', '#00b9bd']}
              />
              <span className="avatar-name">Ring</span>
            </div>
            <div className="avatar-item">
              <Avatar name="Clara Barton" size={72} variant="bauhaus" />
              <span className="avatar-name">Bauhaus</span>
            </div>
          </div>
        </section>
      </div>
    </div>
  )
}
