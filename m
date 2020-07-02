Return-Path: <SRS0=sMug=AN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E56C433DF
	for <linux-block@archiver.kernel.org>; Thu,  2 Jul 2020 12:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7476520772
	for <linux-block@archiver.kernel.org>; Thu,  2 Jul 2020 12:12:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="GqNm4Jys"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728813AbgGBMMS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Jul 2020 08:12:18 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:34909 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbgGBMMR (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Jul 2020 08:12:17 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200702121215euoutp029f3c567d96a3cf99bf3349c2c34ce457~d7l8NDkND0255102551euoutp02y
        for <linux-block@vger.kernel.org>; Thu,  2 Jul 2020 12:12:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200702121215euoutp029f3c567d96a3cf99bf3349c2c34ce457~d7l8NDkND0255102551euoutp02y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1593691935;
        bh=cJ+27zPcRa/hvU7Wd9tYSB1oJlVWoUkGptSeZT1/O8A=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=GqNm4Jysx+Jh0VfjZzz9jGUgivvIVECE1uozDXl2L6J6sn3lTEHt2ST9yO1OzT3IY
         /bUrf3gXJQ1BQ9WWiJu7z+qa1paSUjtNG/lhnLyIB6c0i3+uiaOYePXkIwD07A4Ng2
         tEMsMhYCus+DFcGp2sJ+K3mDBBd4l+ymDIIfYfJM=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200702121214eucas1p1f3fe77b927376e2c50b376de43ba50e5~d7l76Q2i31991319913eucas1p15;
        Thu,  2 Jul 2020 12:12:14 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id C4.14.06456.E1FCDFE5; Thu,  2
        Jul 2020 13:12:14 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200702121214eucas1p15e9717bb09d31a008b223e451fc9b000~d7l7qHqMM2466524665eucas1p1O;
        Thu,  2 Jul 2020 12:12:14 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200702121214eusmtrp130a0777856475257c3f0bc4d4e642e4b~d7l7piNw93245932459eusmtrp1N;
        Thu,  2 Jul 2020 12:12:14 +0000 (GMT)
X-AuditID: cbfec7f2-7efff70000001938-d4-5efdcf1ee521
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 3E.E5.06017.E1FCDFE5; Thu,  2
        Jul 2020 13:12:14 +0100 (BST)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200702121214eusmtip18a0626149bfd78794e8593197852af53~d7l7Rop-h2384723847eusmtip1S;
        Thu,  2 Jul 2020 12:12:14 +0000 (GMT)
Subject: Re: [PATCH] blk-mq: put driver tag when this request is completed
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <e339f9ec-6b0a-dc9b-707b-1f871ac0863b@samsung.com>
Date:   Thu, 2 Jul 2020 14:12:13 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200702114848.GE2452799@T590>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHKsWRmVeSWpSXmKPExsWy7djP87py5//GGaydYGSx+m4/m8XGGetZ
        LVauPspksfeWtsWhyc1MDqwel8+Weuy+2cDm8X7fVTaPvi2rGD0+b5ILYI3isklJzcksSy3S
        t0vgyrh4djZjwU7Vip/3u9gaGLfLdTFyckgImEjsnNHK2MXIxSEksIJR4uGDpewQzhdGidn7
        G6Ccz4wSE2Y8Z+1i5ABreXI1B6RbSGA5o8TiFdYQNe8ZJfYf+M4IkhAW8JJYdOgHC4gtIqAk
        cffuarBBzAJTGSU6+zYygSTYBAwlut52sYEM5RWwk1g81RgkzCKgIrHgQx9Yr6hAnMT6l9vB
        ynkFBCVOznwCFucU0JG4suohmM0sIC+x/e0cZghbXOLWk/lMILskBFaxS+y+/YUF4k8XibP7
        3zBC2MISr45vYYewZSROT+5hgWhoBvr/3Fp2CKeHUeJy0wyoDmuJO+d+gV3KLKApsX6XPkTY
        UaLp6zFGSKjwSdx4KwhxBJ/EpG3TmSHCvBIdbUIQ1WoSs46vg1t78MIl5gmMSrOQvDYLyTuz
        kLwzC2HvAkaWVYziqaXFuempxYZ5qeV6xYm5xaV56XrJ+bmbGIGp5vS/4592MH69lHSIUYCD
        UYmH98XJv3FCrIllxZW5hxglOJiVRHidzp6OE+JNSaysSi3Kjy8qzUktPsQozcGiJM5rvOhl
        rJBAemJJanZqakFqEUyWiYNTqoFxfsqHm4yKzqKfjiks93/w1C+/78SK86bzwkyMj5wXn7vw
        fSCjXcjPPet/3So4oP1h0WXF4zEpl7fnNnLdbuI7+MRupVNxhHDGssPODZfmnn/iaOXGX3Lr
        oq3zyldzFB2aZ65f7rrwaHJV7kVVWc+50W9/rY28/26Ok3bOyZuTc2wEzAMW2M20UGIpzkg0
        1GIuKk4EAC4zXn4xAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAIsWRmVeSWpSXmKPExsVy+t/xu7py5//GGZxfIGex+m4/m8XGGetZ
        LVauPspksfeWtsWhyc1MDqwel8+Weuy+2cDm8X7fVTaPvi2rGD0+b5ILYI3SsynKLy1JVcjI
        Ly6xVYo2tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJzcksSy3St0vQy7h4djZjwU7Vip/3u9ga
        GLfLdTFycEgImEg8uZrTxcjJISSwlFFi6mV2EFtCQEbi5LQGVghbWOLPtS62LkYuoJq3jBLn
        GicygySEBbwkFh36wQJiiwgoSdy9u5odpIhZYDqjxI4T/1ghOl4xS2y/MwdsFJuAoUTXW5BR
        HBy8AnYSi6cag4RZBFQkFnzoAxskKhAnsXzLfLAreAUEJU7OfAIW5xTQkbiy6iGYzSxgJjFv
        80NmCFteYvvbOVC2uMStJ/OZJjAKzULSPgtJyywkLbOQtCxgZFnFKJJaWpybnltspFecmFtc
        mpeul5yfu4kRGFvbjv3csoOx613wIUYBDkYlHt4Jx//GCbEmlhVX5h5ilOBgVhLhdTp7Ok6I
        NyWxsiq1KD++qDQntfgQoynQcxOZpUST84Fxn1cSb2hqaG5haWhubG5sZqEkztshcDBGSCA9
        sSQ1OzW1ILUIpo+Jg1OqgbH4rprg2RRH1o2ppW655dydBSz8M1hXyQtNr9r2Wnv/3/cajnVm
        M39Htm2I2iXNe/jo0eo+pRkLHz80F84/nRdj/+7zvJD/R/mvBIjJzjBKm2t5O1+YS8lQLeDH
        v4Dpl9Y7yz6ZcW6abKvVo6+V6lNn6Ig9UJ+2R+mzRvw+xu5dKfN/C24w8FBiKc5INNRiLipO
        BAATRcjWwwIAAA==
X-CMS-MailID: 20200702121214eucas1p15e9717bb09d31a008b223e451fc9b000
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
        <1dd1fc85-fa46-29fd-5aaa-06f29440e8f4@samsung.com>
        <20200702092320.GD2452799@T590>
        <5acf69fb-04b2-8649-1fc4-2cfe8aa8b9c7@samsung.com>
        <20200702114848.GE2452799@T590>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Ming,

On 02.07.2020 13:48, Ming Lei wrote:
> On Thu, Jul 02, 2020 at 12:19:08PM +0200, Marek Szyprowski wrote:
>> On 02.07.2020 11:23, Ming Lei wrote:
>>> On Thu, Jul 02, 2020 at 10:04:38AM +0200, Marek Szyprowski wrote:
>>>> On 02.07.2020 03:22, Ming Lei wrote:
>>>>> On Wed, Jul 01, 2020 at 04:16:32PM +0200, Marek Szyprowski wrote:
>>>>>> On 01.07.2020 15:45, Ming Lei wrote:
>>>>>>> On Wed, Jul 01, 2020 at 03:01:03PM +0200, Marek Szyprowski wrote:
>>>>>>>> On 29.06.2020 11:47, Ming Lei wrote:
>>>>>>>>> It is natural to release driver tag when this request is completed by
>>>>>>>>> LLD or device since its purpose is for LLD use.
>>>>>>>>>
>>>>>>>>> One big benefit is that the released tag can be re-used quicker since
>>>>>>>>> bio_endio() may take too long.
>>>>>>>>>
>>>>>>>>> Meantime we don't need to release driver tag for flush request.
>>>>>>>>>
>>>>>>>>> Cc: Christoph Hellwig <hch@lst.de>
>>>>>>>>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
>>>>>>>> This patch landed recently in linux-next as commit 36a3df5a4574. Sadly
>>>>>>>> it causes a regression on one of my test systems (ARM 32bit, Samsung
>>>>>>>> Exynos5422 SoC based Odroid XU3 board with eMMC). The system boots fine
>>>>>>>> and then after a few seconds every executed command hangs. No
>>>>>>>> panic/ops/any other message. I will try to provide more information asap
>>>>>>>> I find something to share. Simple reverting it in linux-next is not
>>>>>>>> possible due to dependencies.
>>>>>>> What is the exact eMMC's driver code(include the host driver)?
>>>>>> dwmmc-exynos (drivers/mmc/host/dw_mmc-exynos.c)
>>>>> Hi,
>>>>>
>>>>> Just take a quick look at mmc code, there are only two req->tag
>>>>> consumers:
>>>>>
>>>>> 1) cqhci_tag
>>>>> cqhci_tag
>>>>> 	cqhci_request
>>>>> 		host->cqe_ops->cqe_request
>>>>> 			mmc_cqe_start_req
>>>>> 	cqhci_timeout
>>>>>
>>>>> 2) mmc_hsq_request
>>>>> mmc_hsq_request
>>>>> 	host->cqe_ops->cqe_request
>>>>> 		mmc_cqe_start_req
>>>>>
>>>>> mmc_cqe_start_req() is called before issuing this request to hardware,
>>>>> so completion won't happen when the tag is used in mmc_cqe_start_req().
>>>>>
>>>>> cqhci_timeout() may race with normal completion, however looks the
>>>>> following code can handle the race correctly:
>>>>>
>>>>>            spin_lock_irqsave(&cq_host->lock, flags);
>>>>>            timed_out = slot->mrq == mrq;
>>>>>
>>>>> So still no idea why the commit causes the trouble for mmc.
>>>>>
>>>>> Do you know it is cqhci or mmc_hsh which works for dw_mmc-exynos?
>>>>> And can you apply the following patch and see if warning can be
>>>>> triggered?
>>>>>
>>>>> diff --git a/drivers/mmc/host/cqhci.c b/drivers/mmc/host/cqhci.c
>>>>> index 75934f3c117e..2cb49ecfbf34 100644
>>>>> --- a/drivers/mmc/host/cqhci.c
>>>>> +++ b/drivers/mmc/host/cqhci.c
>>>>> @@ -612,6 +612,7 @@ static int cqhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
>>>>>     		goto out_unlock;
>>>>>     	}
>>>>>     
>>>>> +	WARN_ON_ONCE(cq_host->slot[tag].mrq);
>>>>>     	cq_host->slot[tag].mrq = mrq;
>>>>>     	cq_host->slot[tag].flags = 0;
>>>>>     
>>>>> diff --git a/drivers/mmc/host/mmc_hsq.c b/drivers/mmc/host/mmc_hsq.c
>>>>> index a5e05ed0fda3..11a4c1f3a970 100644
>>>>> --- a/drivers/mmc/host/mmc_hsq.c
>>>>> +++ b/drivers/mmc/host/mmc_hsq.c
>>>>> @@ -227,6 +227,7 @@ static int mmc_hsq_request(struct mmc_host *mmc, struct mmc_request *mrq)
>>>>>     		return -EBUSY;
>>>>>     	}
>>>>>     
>>>>> +	WARN_ON_ONCE(hsq->slot[tag].mrq);
>>>>>     	hsq->slot[tag].mrq = mrq;
>>>>>     
>>>>>     	/*
>>>> None of the above is even compiled for my system (I'm using
>>>> arm/exynos_defconfig), so this must be something else.
>>> Hello Marek,
>>>
>>> Or can you boot the system with one workable disk(usb, nand, ...)?
>>> then run some IO test on this eMMC, and collect debugfs log via the following
>>> command after the hang is triggered:
>>>
>>> (cd /sys/kernel/debug/block/$MMC && find . -type f -exec grep -aH . {} \;)
>>>
>>> $MMC is this mmc disk name.
>>
>> I hope it helps.
> It does help, :-)
>
> Thanks for collecting the log, now I understood the reason: flush
> request's driver tag is leaked in case that request isn't done via
> blk_mq_complete_request(), such as freed via blk_mq_end_request()
> directly.
>
> Please try the following patch, which should have been one two-line
> change if the driver tag cleanup patch isn't merged.


Yes, this fixes the issue on my test system! :)

Feel free to add:

Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

to the final patch.


Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

