const backgroundColor = '#000000'
const foregroundColor = '#f5f5f5'
const cursorColor = '#ffb473'
const borderColor = backgroundColor

const colors = {
    black: '#616161',
    red: '#ff8373',
    green: '#b4fb73',
    yellow: '#fffdc3',
    blue: '#a5d5fe',
    magenta: '#ff90fe',
    cyan: '#d1d1fe',
    white: '#f1f1f1',
    lightBlack: '#8f8f8f',
    lightRed: '#ffc4be',
    lightGreen: '#d6fcb9',
    lightYellow: '#fffed5',
    lightBlue: '#d5d6ff',
    lightMagenta: '#ffb2fe',
    lightCyan: '#e5e6fe',
    colorCubes: '#ffffff',
    grayscale: foregroundColor
}

exports.decorateConfig = config => {
  return Object.assign({}, config, {
    foregroundColor,
    backgroundColor,
    borderColor,
    cursorColor,
    colors,
    termCSS: `
      ${config.termCSS || ''}
      .cursor-node {
        mix-blend-mode: difference;
      }
    `,
    css: `
      ${config.css || ''}
      .header_header {
        top: 0;
        right: 0;
        left: 0;
      }
      .tabs_list {
        background-color: #333333;
        border-bottom-color: #272727 !important;
      }
      .tab_tab {
        font-weight: 500;
        border-width: 0 1px 0 0;
        border-style: solid;
        border-right-color: #272727 !important;
      }
      .tab_tab:last-of-type {
        border-width: 0;
      }
      .tab_tab.tab_active {
        font-weight: 500;
        background-color: ${backgroundColor};
      }
    `
  })
}
