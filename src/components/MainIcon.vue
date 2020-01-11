<template>
  <div>
    <b-img
      id="mainIcon"
      class="shadow mainIcon"
      rounded="circle"
      center
      :src="require('../assets/logo.svg')"
      alt=""
    >
    </b-img>

    <b-popover
      target="mainIcon"
      variant="danger"
      triggers="hover"
      placement="top"
    >
      <b-list-group-item variant="info">
        <b-button block v-b-toggle.accordion-1 variant="info">
          donner
        </b-button>
        <b-collapse id="accordion-1" class="textCenter" visible>
          <b-table striped hover :items="donors" :fields="fields"></b-table>
          <h5>Anypay</h5>
          <b-img class="shadow m1" rounded :src="anypayData" alt=""> </b-img>
          <h5>Wechatpay</h5>
          <b-img class="shadow m1" rounded :src="wechatpayData" alt=""> </b-img>
        </b-collapse>
      </b-list-group-item>

      <b-list-group-item variant="info">
        <b-button block v-b-toggle.accordion-3 variant="info">
          help
        </b-button>
        <b-collapse id="accordion-3">
          <H4>如何获得我想要的资源? </H4>
          资源搜索：在主控室输入你想搜索的资源名称，点击dig按钮发动挖掘。
          你会发现关键字会出现在'我的搜索'列表,同时你将收到三种可能的提示
          1.提示已挖到xxx条资源，此时查看资源储存箱界面，这些资源都陈列这这里！
          2.提示已将关键字加入引擎的任务列表，此时你可以在任务列表看到你的关键字，你可以选择等待直到完成或者过会再来查看'我的搜索'列表(引擎会自动完成挖掘)，同时你也可继续搜索其他资源。
          3.提示翻遍n个网页也没有挖到资源，那不好意思，有两种可能
          （1）可能是您搜索的是正在上映的电影，电影在上映时一般是不可能有资源的！即使有那基本上是枪版资源，我们应强烈抵制这种垃圾资源！
          （2）可能是您搜索的是一些违反国家法律法规的东西！我们坚决反对这样的行为！我们将在后面的开发中逐渐引入关键字检测机制！
          <h4>挖到的资源在哪？如何使用这些链接？</h4>
          获取到资源后将把资源储存到资源储存箱界面，在此界面你就可以看到你所搜索的关键字的资源链接，分为
          迅雷下载链接、种子下载链接、ed2k下载链接、百度网盘链接(附有原网址，以便得到资源共享密钥)。
          1、对于
          迅雷下载链接、种子链接、ed2k链接，点击链接调出迅雷(或者复制去迅雷新建任务,迅雷开启时批量复制有惊喜偶!)，使用迅雷等下载器进行下载。
          2、对于
          百度云链接，你可以转存到自己网盘(如有密钥访问原网址查找密码)，然后在百度云在线观看或者下载(ed2k链接也可使用百度网盘离线下载到自己空间在线观看，以安卓端百度云APP为例，先复制链接，打开百度云点击更多--离线下载--新建链接任务)。
          3、桌面端也可使用爱奇艺万能播放器进行播放。(使用方式很多，欢迎在控制室留言板分享)
          4、如果遇到问题，请直接在本页面上方提交反馈。
          <h4>我对搜索结果不满意怎么办？</h4>
          如发现多数链接失效，或者搜索时间过早，你可以点击资源储存箱页面最下面，扔给挖掘机，重新挖掘。
          然后查看任务列表,关键字将会出现在那儿!
          如果提示有人在xx月xx日xx时搜索过!这是正常的,一个关键字一天之内只能发动挖掘机一次,因为一天之内网络上的资源是不会有太大变化的,即使再发动一次挖掘也不会获得更多的资源,所以为了提高效率优化体验,我们将一个关键字的挖掘间隔限定在一天!您可以改日再试!
        </b-collapse>
      </b-list-group-item>
    </b-popover>
  </div>
</template>

<script>
export default {
  name: "MainIcon",
  props: ["donors"],
  created: function() {},
  methods: {},
  data() {
    return {
      fields: ["name", "msg"],
      wechatpayData:
        "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAJQAAACUCAYAAAB1PADUAAAERUlEQVR4nO2ZS4rkMBAF6/6XntkaF7RI4mVKdkWAV7JffhQFDf35JxLks7sBeRcKJVEUSqIolERRKImiUBJFoSSKQkkUhZIoCiVRFEqiKJREUSiJolASRaEkChbq8/mMPqv6aWj99HzT+y3vCwcolEJd+8UBCqVQ135xgEIp1LVfHHDYhaYXSOun89Mo1OJcoWoo1OJcoWoo1OJcoWo8Tih6wdMXlBa0e/7p/a5QKNjv7vkVSqEU6s+AwwZWKIVqXWh3PzTv9P2W+8UBCqVQ1zwcoFAKdc3DAQqlUNc8HHDYwN39dOdNz6NQm/vpzpueR6E299OdNz2PQm3upztvep7HCbU7Py1k9fu0sGkUqvl7hYJ5pzWUzleo2XyFaq6nULCh7mdV/+3n0/utolAPO1cohVKoUoBCKdS1X5ywGSogXWj6B/B0Hj+RQp3F4ydSqLN4/EQKdRbb/zlcfb96Iem8KrQ+nbfaD54XByhUa32FWpwrlEL9HaBQrfV/Xqj0hXdDL3R63rSQChVGoRQqikIpVBSFOlyo1Tl9f/cFpEnPtxuFKs6TRqHuAQqFUKh7gEIhFGoV2Hzh1Xpp4avQvOoPbLeQCqVQClWpp1C9/X3l4YR7oEKV6le/V6jFOX1/Om9aEEp3/le9eKBClfajUKtAhSrtR6FWgQpV2o9CpRuAA1cFqp6n+0//4Kbzl/VxAm1AoVDedP6yPk6gDSgUypvOX9bHCbQBhUJ50/nL+jjhHrhomF5A+gKr9ar5dB+791dFoYr1qvkKRQMPW4hCKRTKW31P+6/mK1SYaQG6+4lfwPSFh/O+8uOJ9wIKhfpRqHsBhUL9KNS9gEKhfn5OqNMEoPWrF0x/IN37G8+bbkihsvugKJRCKVTyfYV6uVDLAmEhaD4VqrufbgHT+/+qF0+8F1AohYoWUCiFihZQKIUqBQwLQp9qveq8aSHT++pGoRQqikIpVBSFUqgox/1RTs+782g92h99v1s4hVIohVIohVKoUH8/JxRtcFrAbuHoBU8/FIVSKIWq1FMohVIohdoHFbD7++4LpXkKdUOhFCqKQilUFIV6mVDdC+4WZJWXhs5H+22fDwcoVHRf1X6Omw8HKFR0X9V+jpsPByhUdF/Vfo6bDwcMXwA93y0ozaPzdaNQxfcVatEPDlCoUv8KtQpQqFL/CrUKaL4geoHT73cL1/1QFEqhFIr00/2+QtEAhYrm7X4ojxeK1q/Od9wFNu+v3A8OUCiFuubhAIVSqGseDlAohbrm4YDDhNotIIXWS++jXB8HKFQUhVKoKAqlUFEUqnnh1fz0hUz3c1r/5fo4QKFe3X+5Pg5QqFf3X66PAxTq1f2X6+OAW4PdD63f/X33vigKpVAKpVB9+6IolEL9llAiVxRKoiiURFEoiaJQEkWhJIpCSRSFkigKJVEUSqIolERRKImiUBJFoSSKQkkUhZIo/wHduoquiCbq5AAAAABJRU5ErkJggg==",
      anypayData:
        "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAJQAAACUCAYAAAB1PADUAAAEZUlEQVR4nO2Y0YojSRAD5/9/eve1zwNbCElZ2b4I8FOXlcrqMAzz8wcgyM/tAvBdIBREQSiIglAQBaEgCkJBFISCKAgFURAKoiAUREEoiIJQEAWhIApCQRSEgii2UD8/P6Of0/zpvmr+2+5X7msHIJSU/7b7lfvaAQgl5b/tfuW+dgBCSflvu1+5rx0QLqTmtwWov4DwDyY9X87bVkjNR6jufDlvWyE1H6G68+W8bYXUfITqzpfz2oXSL7z9PC3Q9P7pfHlfOwChpPtBqFMAQkn3g1CnAISS7gehTgHLF3YFmf4BuHkIhVDSfLUfQon5aj+E8voc+9oByxdGKISy8t35t/tsu18VhFrWZ9v9qiDUsj7b7lcFoZb12Xa/KnWhpvPdC1W/n+7j7u/2s/O2FXLzEcrrZ+dtK+TmI5TXz87bVsjNRyivn52XLtT+nOZ/+/Pp+1VBqJc9RyiEQigpAKEQ6tnXTngZ6gWmL3w6f5r3byCCUF3ev4EIQnV5/wYiCNVl/B+bt//IvP1HbTuvPe/Yxw5AKIR6zrMDEAqhnvPsAIRCqOc8O+E0oL1AWKjT+Wmmf2B2XzvhNAChLBDqcwBCWSDU5wCEsvjfC6UW3H5ht38A7T5pECq8j7vvdJ80CBXex913uk8ahArv4+473SdN/R+b2wRIC397fnsfFYQS8xDqkG8HINTV+QiFUAhlDRAvxH2B6Rcev/Dyfm4fO89OOA1AqGhfhEKoaF+EQqho368XatsFneapz6f7nM4jlHk+3U99Pt3ndB6hzPPpfurz6T6n8whlnk/3U59P9zmd/3qh0rQFvX3eFRyhRG6/8PZ5hBrm9gtvn0eoYW6/8PZ5hDILpS/IPe9+2v3bfdsgFEJFQSiEioJQCBVlnVDbBEh/X90/ndcWEKHC+7p5CIVQFgh1WMB9jlAIVb3g9vcRJAtCIVQUhEKoKAiFUFHiQrkLu+fb/dt9233awiHUsr4IhVAI9ZxvByAUQj3n2wFhodR5ap/2+fT+bWHTIBRCRUEohIqCUAgVpS6U+v30c7Vv+4W7fdofF4RCKIRSnqt9EcoDoRBql1C3aQvXnu++UFWQtEC/8uOJwyAUQkVBKISKglBfJtRpofTnNF99ns67Pc+9TxeECufdnodQCIVQ/wlAqFXzvk6oNO0Ld/dJv3CV2wL96mMHIBRCPfvYAQiFUM8+dgBCIdSzjx1QvtB0/jZB3f6uQGnhECo8b7o/Qi17Iel50/0RatkLSc+b7o9Q5Rcy3d9lWoh0/1/5dgBCWSDUZwBCWSDUZwBCWSDUZ8Blodw+at50n237HPPtAISq9tm2zzHfDkCoap9t+xzz7QCEqvbZts8x3w4IF2rnq4KnX0D7B3gbhEKoKAiFUFEQCqGixIVqf6bnu/dxm2khEQqhsvPsAIT6Z5/bIBRCRXmdUABPEAqiIBREQSiIglAQBaEgCkJBFISCKAgFURAKoiAUREEoiIJQEAWhIApCQRSEgih/AUSh6k4hoPvNAAAAAElFTkSuQmCC"
    };
  }
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped></style>
