<template>

    <div class="search-options" id="search-options">
    <div class="bd">
        <dl>
            <dt>价格：</dt>
            <dd class="dd-price" style="height: 48px;">
                <div class="items cle w500">
                    <div class="link" v-for="item in priceRange" @click="changePriceRange(item.min,item.max)"> <a class="item">{{item.min}}&nbsp;-&nbsp;{{item.max}}</a> </div>
                    <!-- <div class="link"> <a class="item">20&nbsp;-&nbsp;70</a> </div>
                    <div class="link"> <a class="item">70&nbsp;-&nbsp;120</a> </div>
                    <div class="link"> <a class="item">120&nbsp;-&nbsp;170</a> </div>
                    <div class="link"> <a class="item">170&nbsp;-&nbsp;220</a> </div>
                    <div class="link"> <a class="item">220&nbsp;-&nbsp;270</a> </div> -->
                </div>
                <div class="priceform" id="priceform" v-clickoutside="handleClickOutside">
                    <div class="form-bg">
                        <form id="freepriceform" >
                            <span class="rmb"></span>
                            <input type="text" value="" name="price_min" id="pricemin" v-model="price_min" @focus="focus=true">
                            <span class="rmb rmb2"></span>
                            <input type="text" value="" name="price_max" id="pricemax" v-model="price_max" @focus="focus=true">
                            <input v-show="focus" value="确定" @click="changePriceRange(price_min, price_max)" class="submit">
                        </form>
                    </div>
                </div>
            </dd>
        </dl>

    </div>
</div>

</template>
<script>
import clickoutside from '../../../static/js/clickoutside';
  export default {
    data () {
        return {
            price_min: '',
            price_max: '',
            focus: false //是否获得焦点
        };
    },
    directives: {
            clickoutside
        },
    components: {

    },
    props: {
        priceRange: {
            type: Array,
            default: [],
        }
    },
    created () {

    },
    watch: {

    },
    computed: {

    },
    methods: {
        changePriceRange (min, max) {
            this.$emit('on-change', {min, max});
        },
        handleClickOutside () {
            this.focus = false;

        }
    }
}
</script>
<style>
/* 修复CSS中的不兼容语法 */
.search-options{margin-bottom:10px}
.search-options .bd{border:1px solid #eee;border-bottom:0;zoom:1}
.search-options .list{overflow:hidden;padding:4px 0 0;zoom:1}
.search-options dl{border-top:1px dotted #ccc;overflow:hidden;zoom:1}
.search-options dt{float:left;width:100px;font-weight:700;text-align:right;padding:10px 0}
.search-options dd{float:left;width:620px;padding:5px 0}
.search-options dd .search-option{float:left;width:148px;height:18px;padding:3px 0 2px;overflow:hidden;margin-right:5px;display:inline}
.search-options dd .search-option label{display:block;float:left;height:18px;padding:0 5px 0 0;overflow:hidden;line-height:18px}
.search-options dd .search-option:hover{background:#e4393c;color:#fff}
.search-options dd .search-option:hover a{color:#fff}
.search-options dd .search-option input{float:left;margin:3px 3px 0 0;display:inline}
.search-options dd .search-option a{float:left;white-space:nowrap;overflow:hidden}
.search-options dd .search-option a:hover{color:#fff}
.search-options dd a{color:#005aa0}
.search-options dd a:hover{color:#e4393c}
.search-options-more{text-align:center;position:relative;top:-1px;border-style:solid;border-width:0 1px 1px;border-color:#ddd;background:#f7f7f7}
.search-options-more a{color:#333;padding:0 15px 0 0;position:relative;margin-right:15px;height:24px;line-height:24px;background:url(//misc.360buyimg.com/product/search/1.0.7/css/i/search.ele.png) no-repeat 9999px 9999px;background-position:right -360px;display:inline-block}
.search-options-more a:hover{color:#e4393c}
.search-options-more a.close{background-position:right -381px}
.priceform{overflow:hidden;margin-top:5px;padding-left:3px;float:left}
.priceform .form-bg{width:270px;border:1px solid #fff;border-top-color:#eee;padding:8px 15px;padding-bottom:7px;font-size:0}
.priceform .form-bg:hover{border-color:#e4393c;border-top-color:#e4393c;background:#fff}
.priceform .form-bg input{width:60px;height:17px;border:1px solid #ccc;padding:1px;font:12px/17px verdana;overflow:hidden}
.priceform .form-bg span{padding:0 6px;font-size:12px;display:inline-block;vertical-align:middle}
.priceform .form-bg button{background:#f7f7f7;color:#333;border-radius:2px;text-align:center;text-decoration:none;cursor:pointer;border:1px solid #ddd;padding:4px 13px 5px;display:inline-block;vertical-align:middle;font-size:12px;margin-left:15px}
.priceform .form-bg button:hover{background:#f3f3f3}
</style>
