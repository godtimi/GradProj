const fs = require('fs');
const path = require('path');

// 需要修复的文件列表
const filesToFix = [
  'src/components/common/product-list/productList.vue',
  'src/components/common/price-range/priceRange.vue',
  'src/views/list/product-list/productList.vue',
  'src/views/list/price-range/priceRange.vue',
  'src/views/productDetail/productDetail.vue',
  'src/views/member/member-menu.vue',
  'src/views/list/list-sort/listSort.vue'
];

// 替换规则
const replacements = [
  { from: /\+zoom:1;?/g, to: 'zoom:1;' },
  { from: /\+margin-right/g, to: 'margin-right' },
  { from: /\+margin-left/g, to: 'margin-left' },
  { from: /\+padding-right/g, to: 'padding-right' },
  { from: /\+padding-left/g, to: 'padding-left' }
];

// 修复文件
filesToFix.forEach(filePath => {
  const fullPath = path.join(__dirname, filePath);
  
  if (fs.existsSync(fullPath)) {
    let content = fs.readFileSync(fullPath, 'utf8');
    
    // 应用所有替换规则
    replacements.forEach(({ from, to }) => {
      content = content.replace(from, to);
    });
    
    // 写回文件
    fs.writeFileSync(fullPath, content, 'utf8');
    console.log(`Fixed: ${filePath}`);
  } else {
    console.log(`File not found: ${filePath}`);
  }
});

console.log('CSS fixes completed!'); 