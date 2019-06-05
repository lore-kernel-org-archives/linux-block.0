Return-Path: <SRS0=Ij7C=UE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C79C28CC5
	for <linux-block@archiver.kernel.org>; Wed,  5 Jun 2019 18:24:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA41D2075C
	for <linux-block@archiver.kernel.org>; Wed,  5 Jun 2019 18:24:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbfFESYQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Jun 2019 14:24:16 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:56165 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbfFESYQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Jun 2019 14:24:16 -0400
Received: from [192.168.1.110] ([77.2.1.21]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N17gy-1gXZo22HZy-012WRk; Wed, 05 Jun 2019 20:24:08 +0200
Subject: Re: [PATCH] block: Drop unlikely before IS_ERR(_OR_NULL)
To:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
References: <20190605142428.84784-1-wangkefeng.wang@huawei.com>
 <20190605142428.84784-4-wangkefeng.wang@huawei.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <8221bc17-b0bb-da6f-4343-3e73467252d5@metux.net>
Date:   Wed, 5 Jun 2019 18:24:06 +0000
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190605142428.84784-4-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:Y0QXYRfj1pDFaLHuulCV3aQ53CFCLSD47VeOfBiZj/brBBYX0yH
 XPNsNjyRUa68eg8AjCoqPdjWHUiXgGUn97FxC3B/Q9EDhCseqCjzMMFPML7OOWcm8+V9ji1
 Se+WIOh5QglRc7af3tl3m9hBgNPBIF+B5g7Arm7Pmg5/1LAjFOAv5iF0h6D+YUEB5f5VecX
 qyL3R/zcXo+sHfgzJFVcw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:l3dySK4iN1I=:m3RNRdxfUGQ4yBpcFIFwwh
 JgRjk0Uhv/3h0kAZRaosu/08k69o/om82ldoSuG8E8aZMwb5hdUY6PCbyz7mJfxBGLQQXAf28
 EGuGm4wZEyqRsQi3Wq6ZKsKe843DdaKogyvB90wn1GjbbBVU8Cm1gjdlCskCw9QokhCHP4PXi
 Jm8AtlMp1X9otZhrrOvedcPBghNXZfYDvdcW/GHsriBKfi0Y3424YL+IUfcRIhDh6BwARZaFf
 WO91A6ZlPoXR8LL7EVILPb9hhAHm+//JWN24Hd/Dglvnoec8zuyfjqy1vACEH2N8s5Pk6CsuS
 JKndYXkoT5CPV83fv6kr74lMdIBryoZQ8v63KmepFTUE5cNkjLCypiIY5BwYUAZ/TAX0dYoH2
 m+21F/aVdYEQyMlQHyb1FwGYlP98mfBJvi/upfJsAbUMsWOJdejP0AIPpS5hWMKxOjHz0avNo
 bOrkFpR0Qpka2lS9osGYrHL++qh+/DqGmlMJV6hLsIUP9ffIC4/ygFJHGv2oKZvxYB7LNVuJb
 t+rsTV3okwrrUpqbwglmjcToiv3y2Is6I/HwViWV+UXRHejBMTMaouz1aHjT8vnAiBLywQ5Cg
 pNQQSq12yri4De47+hfsyptLmD93q6YuVFAdiKez4pecxnaFYI+A3vcDpxpHLVI+ZI+UPF1G+
 b620kMkaMmusrFJnnFAyX7fZ9RnfQfqJ7toJS+3DtivevsUkGeC2TaIA4ge4PLUW19BSTph9B
 n+wbGvWIDWlmWgD+7/DRLUOQ6PeXsZkMZTAfrsL0NVz9OtNuaALASUEjGA8=
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 05.06.19 14:24, Kefeng Wang wrote:

> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> index b97b479e4f64..1f7127b03490 100644
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -881,7 +881,7 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
>   			blkg_free(new_blkg);
>   		} else {
>   			blkg = blkg_create(pos, q, new_blkg);
> -			if (unlikely(IS_ERR(blkg))) {
> +			if (IS_ERR(blkg)) {
>   				ret = PTR_ERR(blkg);
>   				goto fail_unlock;
>   			}
> 

I think this cocci script should do such things automatically:

virtual patch
virtual context
virtual org
virtual report

@@
expression E;
@@
- unlikely(IS_ERR(E))
+ IS_ERR(E)


Do you already do it this way and have a cocci scrip on the way
to mainline ?


--mtx


-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
