Return-Path: <SRS0=sMug=AN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 064BBC433E0
	for <linux-block@archiver.kernel.org>; Thu,  2 Jul 2020 08:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFC8120B1F
	for <linux-block@archiver.kernel.org>; Thu,  2 Jul 2020 08:04:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="SQB+C/OT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726042AbgGBIEl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Jul 2020 04:04:41 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:50387 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbgGBIEk (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Jul 2020 04:04:40 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200702080438euoutp02c8c89571601eecafdb94b2e9a335d5a8~d4Nv7QJwH3262932629euoutp02-
        for <linux-block@vger.kernel.org>; Thu,  2 Jul 2020 08:04:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200702080438euoutp02c8c89571601eecafdb94b2e9a335d5a8~d4Nv7QJwH3262932629euoutp02-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1593677078;
        bh=0L9COSD5Sy0BSeZSsZYJm24WnDEEiZ9oJo7w7P2Cixs=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=SQB+C/OT/rNZSco6SsIIe8fQr9TvDPdbYKhyoRaYhH9PJ5gI0KC2KJJPSgfUKUpMr
         xmB2z/pIUjE07UwtbTajwv3l9vCSi9BWplt4XdTLpEP+1N9fXxkpc1dwUqfcKydBp5
         2pRnVv/GMc6LSD+i56fitmnhBPK2Tlya4C1ShR4I=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200702080438eucas1p1105215278418e1284d032c646597ab42~d4Nvpreyl2806728067eucas1p1R;
        Thu,  2 Jul 2020 08:04:38 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id D9.2B.06456.6159DFE5; Thu,  2
        Jul 2020 09:04:38 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200702080437eucas1p258d41827a754c851523205d6c15154c8~d4NvJ3ySL1709517095eucas1p2D;
        Thu,  2 Jul 2020 08:04:37 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200702080437eusmtrp1577fb514996596ea94b94970aed8be0e~d4NvJQtHV3085130851eusmtrp1B;
        Thu,  2 Jul 2020 08:04:37 +0000 (GMT)
X-AuditID: cbfec7f2-809ff70000001938-b3-5efd95168bb9
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id F3.FF.06314.5159DFE5; Thu,  2
        Jul 2020 09:04:37 +0100 (BST)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200702080437eusmtip1b7631e978585af22dfa1581e58f4f36d~d4Nuqo3nS2360023600eusmtip1d;
        Thu,  2 Jul 2020 08:04:37 +0000 (GMT)
Subject: Re: [PATCH] blk-mq: put driver tag when this request is completed
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <1dd1fc85-fa46-29fd-5aaa-06f29440e8f4@samsung.com>
Date:   Thu, 2 Jul 2020 10:04:38 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200702012231.GA2452799@T590>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIKsWRmVeSWpSXmKPExsWy7djP87piU//GGVxo5rdYfbefzWLjjPWs
        FitXH2Wy2HtL2+LQ5GYmB1aPy2dLPXbfbGDzeL/vKptH35ZVjB6fN8kFsEZx2aSk5mSWpRbp
        2yVwZaw68pKtYJdkxdbFi1kaGA+JdDFyckgImEgcPXKErYuRi0NIYAWjxO6375khnC+MEnsW
        /GSBcD4zSpxoW8EO0zKjdQojRGI5o8TWrYehqt4zStzobWQFqRIW8JJYdOgHC4gtIqAkcffu
        anaQImaBqYwSnX0bmUASbAKGEl1vu9hAbF4BO4l9Ey4zgtgsAioSi54+BrNFBeIk1r/czgRR
        IyhxcuYTsKGcAjoShy7eBFvGLCAvsf3tHGYIW1zi1pP5TCDLJAQWsUvse/6NFeJuF4nLH66x
        QdjCEq+Ob4H6R0bi9OQeFoiGZkaJh+fWskM4PYwSl5tmMEJUWUvcOfcLqJsDaIWmxPpd+hBh
        R4mmr8cYQcISAnwSN94KQhzBJzFp23RmiDCvREebEES1msSs4+vg1h68cIl5AqPSLCSvzULy
        ziwk78xC2LuAkWUVo3hqaXFuemqxYV5quV5xYm5xaV66XnJ+7iZGYMI5/e/4px2MXy8lHWIU
        4GBU4uHNqPgTJ8SaWFZcmXuIUYKDWUmE1+ns6Tgh3pTEyqrUovz4otKc1OJDjNIcLErivMaL
        XsYKCaQnlqRmp6YWpBbBZJk4OKUaGNde3PSmc9ov38M/VDYWHTI9orLubV5Efp5a/NK/S40v
        bJktraFaa/3bbsLXpGkvHV65P0mwX/WWPaJ4zeUp4SkZT7oYWiy2LHT3+u6h7Tf1a8nXBymL
        F2Xk9+lMvCZRVnPKuNyA8UI139MXy42PnY7k73w4Y6HVl+dnHvP5HDR+vvZODvO96RpKLMUZ
        iYZazEXFiQADWvkhNAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMIsWRmVeSWpSXmKPExsVy+t/xu7qiU//GGZw7o2Sx+m4/m8XGGetZ
        LVauPspksfeWtsWhyc1MDqwel8+Weuy+2cDm8X7fVTaPvi2rGD0+b5ILYI3SsynKLy1JVcjI
        Ly6xVYo2tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJzcksSy3St0vQy1h15CVbwS7Jiq2LF7M0
        MB4S6WLk5JAQMJGY0TqFsYuRi0NIYCmjxKKPE5ggEjISJ6c1sELYwhJ/rnWxQRS9ZZSY+/o4
        G0hCWMBLYtGhHywgtoiAksTdu6vZQYqYBaYzSuw48Y8VomMPk8SVN41gVWwChhJdb7vAunkF
        7CT2TbjMCGKzCKhILHr6GMwWFYiTWL5lPjtEjaDEyZlPwHo5BXQkDl28CXYSs4CZxLzND5kh
        bHmJ7W/nQNniEreezGeawCg0C0n7LCQts5C0zELSsoCRZRWjSGppcW56brGhXnFibnFpXrpe
        cn7uJkZghG079nPzDsZLG4MPMQpwMCrx8GZU/IkTYk0sK67MPcQowcGsJMLrdPZ0nBBvSmJl
        VWpRfnxRaU5q8SFGU6DnJjJLiSbnA6M/ryTe0NTQ3MLS0NzY3NjMQkmct0PgYIyQQHpiSWp2
        ampBahFMHxMHp1QDY5vQj/1x5yXP9TlWfamOz4pM9DZfLxny+q/zowzV/cV6Py6e5c72vy02
        sWr5lJ8ml13C2Zm/LrWp2tMkNdlIoszj8sdjMfv1S1e/5Pr/U6STq9l2jsfcJv1QdxH1lYdd
        T7puLXnGJ3r25kbesgs6fgaKxVlMfxh+zOY99u3y6vAjH6z/pD78pcRSnJFoqMVcVJwIAMxh
        zuzGAgAA
X-CMS-MailID: 20200702080437eucas1p258d41827a754c851523205d6c15154c8
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
        <2fcd389f-b341-7cd1-692b-8c9d1918198a@samsung.com>
        <20200702012231.GA2452799@T590>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Ming,

On 02.07.2020 03:22, Ming Lei wrote:
> On Wed, Jul 01, 2020 at 04:16:32PM +0200, Marek Szyprowski wrote:
>> On 01.07.2020 15:45, Ming Lei wrote:
>>> On Wed, Jul 01, 2020 at 03:01:03PM +0200, Marek Szyprowski wrote:
>>>> On 29.06.2020 11:47, Ming Lei wrote:
>>>>> It is natural to release driver tag when this request is completed by
>>>>> LLD or device since its purpose is for LLD use.
>>>>>
>>>>> One big benefit is that the released tag can be re-used quicker since
>>>>> bio_endio() may take too long.
>>>>>
>>>>> Meantime we don't need to release driver tag for flush request.
>>>>>
>>>>> Cc: Christoph Hellwig <hch@lst.de>
>>>>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
>>>> This patch landed recently in linux-next as commit 36a3df5a4574. Sadly
>>>> it causes a regression on one of my test systems (ARM 32bit, Samsung
>>>> Exynos5422 SoC based Odroid XU3 board with eMMC). The system boots fine
>>>> and then after a few seconds every executed command hangs. No
>>>> panic/ops/any other message. I will try to provide more information asap
>>>> I find something to share. Simple reverting it in linux-next is not
>>>> possible due to dependencies.
>>> What is the exact eMMC's driver code(include the host driver)?
>> dwmmc-exynos (drivers/mmc/host/dw_mmc-exynos.c)
> Hi,
>
> Just take a quick look at mmc code, there are only two req->tag
> consumers:
>
> 1) cqhci_tag
> cqhci_tag
> 	cqhci_request
> 		host->cqe_ops->cqe_request
> 			mmc_cqe_start_req
> 	cqhci_timeout
>
> 2) mmc_hsq_request
> mmc_hsq_request
> 	host->cqe_ops->cqe_request
> 		mmc_cqe_start_req
>
> mmc_cqe_start_req() is called before issuing this request to hardware,
> so completion won't happen when the tag is used in mmc_cqe_start_req().
>
> cqhci_timeout() may race with normal completion, however looks the
> following code can handle the race correctly:
>
>          spin_lock_irqsave(&cq_host->lock, flags);
>          timed_out = slot->mrq == mrq;
>
> So still no idea why the commit causes the trouble for mmc.
>
> Do you know it is cqhci or mmc_hsh which works for dw_mmc-exynos?
> And can you apply the following patch and see if warning can be
> triggered?
>
> diff --git a/drivers/mmc/host/cqhci.c b/drivers/mmc/host/cqhci.c
> index 75934f3c117e..2cb49ecfbf34 100644
> --- a/drivers/mmc/host/cqhci.c
> +++ b/drivers/mmc/host/cqhci.c
> @@ -612,6 +612,7 @@ static int cqhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
>   		goto out_unlock;
>   	}
>   
> +	WARN_ON_ONCE(cq_host->slot[tag].mrq);
>   	cq_host->slot[tag].mrq = mrq;
>   	cq_host->slot[tag].flags = 0;
>   
> diff --git a/drivers/mmc/host/mmc_hsq.c b/drivers/mmc/host/mmc_hsq.c
> index a5e05ed0fda3..11a4c1f3a970 100644
> --- a/drivers/mmc/host/mmc_hsq.c
> +++ b/drivers/mmc/host/mmc_hsq.c
> @@ -227,6 +227,7 @@ static int mmc_hsq_request(struct mmc_host *mmc, struct mmc_request *mrq)
>   		return -EBUSY;
>   	}
>   
> +	WARN_ON_ONCE(hsq->slot[tag].mrq);
>   	hsq->slot[tag].mrq = mrq;
>   
>   	/*

None of the above is even compiled for my system (I'm using 
arm/exynos_defconfig), so this must be something else.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

