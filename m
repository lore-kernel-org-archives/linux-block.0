Return-Path: <SRS0=s14/=AM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75EABC433E0
	for <linux-block@archiver.kernel.org>; Wed,  1 Jul 2020 14:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BABA2077D
	for <linux-block@archiver.kernel.org>; Wed,  1 Jul 2020 14:16:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="mf2eJF0a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731039AbgGAOQg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Jul 2020 10:16:36 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:48055 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728712AbgGAOQf (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Jul 2020 10:16:35 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200701141634euoutp0101c6e73ed4649853701f16390a14604d~dppMuEynx3168531685euoutp01D
        for <linux-block@vger.kernel.org>; Wed,  1 Jul 2020 14:16:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200701141634euoutp0101c6e73ed4649853701f16390a14604d~dppMuEynx3168531685euoutp01D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1593612994;
        bh=fPqrIifYblfFtIwovzT3R+kmIBeEjOasDM/fbPFy4vg=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=mf2eJF0aHmLse8argzQdDGd0Zw6HtpTLcCqNEk5Mg2Qyi50bv2xuv+Cw4b5qwfT1y
         Sc5UtmAeV+SR1SUmIwXo8V1BaO5Ray813j2/Xw+NrI/sD8CJL7crIkMsaNfc3tirK5
         9IdrWeHthFxzICoOgQDpP7i7/ygYuGOhL/edJ+oQ=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200701141633eucas1p145bf8a165bc5e10c0b2c041fb6a27927~dppMQGw5A0998909989eucas1p1F;
        Wed,  1 Jul 2020 14:16:33 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id D6.08.06456.1CA9CFE5; Wed,  1
        Jul 2020 15:16:33 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200701141633eucas1p2ee702b156fa1ddfba113615a851434f6~dppLypoyK3132631326eucas1p2w;
        Wed,  1 Jul 2020 14:16:33 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200701141633eusmtrp28cd2b0e89417bf0e90aead785fd0edf3~dppLyErEP0392903929eusmtrp2A;
        Wed,  1 Jul 2020 14:16:33 +0000 (GMT)
X-AuditID: cbfec7f2-809ff70000001938-26-5efc9ac1286c
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id C6.92.06314.1CA9CFE5; Wed,  1
        Jul 2020 15:16:33 +0100 (BST)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200701141632eusmtip1c2c2e182b1f4dc27c7565725cf2d3ee1~dppLYeEw40496504965eusmtip1d;
        Wed,  1 Jul 2020 14:16:32 +0000 (GMT)
Subject: Re: [PATCH] blk-mq: put driver tag when this request is completed
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <2fcd389f-b341-7cd1-692b-8c9d1918198a@samsung.com>
Date:   Wed, 1 Jul 2020 16:16:32 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200701134512.GA2443512@T590>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAKsWRmVeSWpSXmKPExsWy7djPc7oHZ/2JM5h4S9Vi9d1+NouNM9az
        WqxcfZTJYu8tbYtDk5uZHFg9Lp8t9dh9s4HN4/2+q2wefVtWMXp83iQXwBrFZZOSmpNZllqk
        b5fAlXH10zmWgl08Fd9X3WFuYGzj6mLk5JAQMJE4s+85YxcjF4eQwApGiSPzXzFBOF8YJbq6
        O9ggnM+MEh82b2XvYuQAa/l1pxAivpxR4s/VH1BF7xkldqy6wQIyV1jAS2LRoR9gtoiAksTd
        u6vZQYqYBaYySnT2bWQCSbAJGEp0ve1iA7F5Bewkfs64xQxiswioSKw7eQIsLioQK9G3dAFU
        jaDEyZlPwIZyCuhItN6ZB1bPLCAvsf3tHChbXOLWk/lgP0gILGKX+Pt0JyPEpy4Sh9d+YoKw
        hSVeHd/CDmHLSPzfCdPQzCjx8Nxadginh1HictMMqG5riTvnfrGBAoBZQFNi/S59iLCjRNPX
        Y4yQcOGTuPFWEOIIPolJ26YzQ4R5JTrahCCq1SRmHV8Ht/bghUvMExiVZiF5bRaSd2YheWcW
        wt4FjCyrGMVTS4tz01OLDfNSy/WKE3OLS/PS9ZLzczcxAtPN6X/HP+1g/Hop6RCjAAejEg9v
        RsWfOCHWxLLiytxDjBIczEoivE5nT8cJ8aYkVlalFuXHF5XmpBYfYpTmYFES5zVe9DJWSCA9
        sSQ1OzW1ILUIJsvEwSnVwKg6+95lh7TIlp9WZr/vhahvY8qI5E77LrJuye/VAfKGzbOzDzuY
        Z2w9cXx+0Y2c57fuFc5Rcv3wrzBtF+8EW80/v9SUQxOYgkoybf2z45e3JqUYx2elXDsjuzwz
        cE+I3E6b54WCnkvDNEP9lnrM1hauSJssvOGizYoP03b/2/TBxsR2q3/KNiWW4oxEQy3mouJE
        AK1piLEzAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEIsWRmVeSWpSXmKPExsVy+t/xu7oHZ/2JM+hexm6x+m4/m8XGGetZ
        LVauPspksfeWtsWhyc1MDqwel8+Weuy+2cDm8X7fVTaPvi2rGD0+b5ILYI3SsynKLy1JVcjI
        Ly6xVYo2tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJzcksSy3St0vQy7j66RxLwS6eiu+r7jA3
        MLZxdTFycEgImEj8ulPYxcjFISSwlFHi7vrv7F2MnEBxGYmT0xpYIWxhiT/Xutggit4ySpx/
        fBUsISzgJbHo0A8WEFtEQEni7t3V7CBFzALTGSV2nPjHCtHxlFFiyaSfbCBVbAKGEl1vu8Bs
        XgE7iZ8zbjGD2CwCKhLrTp4Ai4sKxEp8u7cFqkZQ4uTMJ2AbOAV0JFrvzAOrZxYwk5i3+SGU
        LS+x/e0cKFtc4taT+UwTGIVmIWmfhaRlFpKWWUhaFjCyrGIUSS0tzk3PLTbUK07MLS7NS9dL
        zs/dxAiMr23Hfm7ewXhpY/AhRgEORiUe3oyKP3FCrIllxZW5hxglOJiVRHidzp6OE+JNSays
        Si3Kjy8qzUktPsRoCvTcRGYp0eR8YOznlcQbmhqaW1gamhubG5tZKInzdggcjBESSE8sSc1O
        TS1ILYLpY+LglGpgDF/jHbFuf4TufN4Tpbsm3PDK4zo7LWHyp64Dv1tatD+sNLrPY3D4YJCt
        0yPm87znDy6UrdC8y244afPb2dcWN588/Ub/bLLgz5rk2r9739Vx7Q5aPf1HkHLG4b+/1+VW
        OIqpN79Z6xPNfN/y8gER5kksuQevBXHu6qj5/c1PN+egYWRnS+OmE0osxRmJhlrMRcWJAKvL
        SDbFAgAA
X-CMS-MailID: 20200701141633eucas1p2ee702b156fa1ddfba113615a851434f6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200701130104eucas1p1f8dcce58bf704b726aee1e89980fe19e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200701130104eucas1p1f8dcce58bf704b726aee1e89980fe19e
References: <20200629094759.2002708-1-ming.lei@redhat.com>
        <CGME20200701130104eucas1p1f8dcce58bf704b726aee1e89980fe19e@eucas1p1.samsung.com>
        <57fb09b1-54ba-f3aa-f82c-d709b0e6b281@samsung.com>
        <20200701134512.GA2443512@T590>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Ming,

On 01.07.2020 15:45, Ming Lei wrote:
> On Wed, Jul 01, 2020 at 03:01:03PM +0200, Marek Szyprowski wrote:
>> On 29.06.2020 11:47, Ming Lei wrote:
>>> It is natural to release driver tag when this request is completed by
>>> LLD or device since its purpose is for LLD use.
>>>
>>> One big benefit is that the released tag can be re-used quicker since
>>> bio_endio() may take too long.
>>>
>>> Meantime we don't need to release driver tag for flush request.
>>>
>>> Cc: Christoph Hellwig <hch@lst.de>
>>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
>> This patch landed recently in linux-next as commit 36a3df5a4574. Sadly
>> it causes a regression on one of my test systems (ARM 32bit, Samsung
>> Exynos5422 SoC based Odroid XU3 board with eMMC). The system boots fine
>> and then after a few seconds every executed command hangs. No
>> panic/ops/any other message. I will try to provide more information asap
>> I find something to share. Simple reverting it in linux-next is not
>> possible due to dependencies.
> What is the exact eMMC's driver code(include the host driver)?

dwmmc-exynos (drivers/mmc/host/dw_mmc-exynos.c)

> The usual way for handling completion is that host driver notifies block
> layer via blk_mq_complete_request() after the LLD specific handling for
> this request is done.
>
> However, there might be driver which may use rq->tag in its rq completion
> handler. I will see if the special case can be dealt with once you share
> the driver info.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

