Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 376DBC433F5
	for <linux-block@archiver.kernel.org>; Mon,  6 Dec 2021 11:27:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242468AbhLFLbY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 Dec 2021 06:31:24 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:31852 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242461AbhLFLbQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 Dec 2021 06:31:16 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20211206112746euoutp019aaa85a2c97b7cdb694fb44bac7035d0~_JuHxDy3D0575405754euoutp01U
        for <linux-block@vger.kernel.org>; Mon,  6 Dec 2021 11:27:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20211206112746euoutp019aaa85a2c97b7cdb694fb44bac7035d0~_JuHxDy3D0575405754euoutp01U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1638790066;
        bh=2yoPtiO7xD8fkUSuudIhPxJK1b0c2gLXUuc2YCY6aAs=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=YzW2CPyQVo9i49rElqAOQ/lrL1ZZ2zFNYcJevifiO3/bfjwlzVYGHOoLhpzzm7i00
         Cx0GXkZ9Vtps1+0LtFEKTmxHXvAGMrUg8XiU1shAnFSFyr94Po+nLyjzG4DxhdGreR
         3Oh1r5JBzMxTbP5EaIlVrBRdCt4C91IZaWaW6R/k=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20211206112746eucas1p19287b2c6e7bb887f3287b06a8f97b440~_JuHlCZr11116911169eucas1p1p;
        Mon,  6 Dec 2021 11:27:46 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 20.1F.10260.1B3FDA16; Mon,  6
        Dec 2021 11:27:46 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20211206112745eucas1p1881bf46dd5cf9e27fe37c4e8199560dd~_JuHAm79K3063730637eucas1p13;
        Mon,  6 Dec 2021 11:27:45 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20211206112745eusmtrp273dee9f9af3fbffd50126736fda5e656~_JuHABVyD3205132051eusmtrp2T;
        Mon,  6 Dec 2021 11:27:45 +0000 (GMT)
X-AuditID: cbfec7f5-bf3ff70000002814-f5-61adf3b17a43
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id CF.EA.09522.1B3FDA16; Mon,  6
        Dec 2021 11:27:45 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20211206112745eusmtip2f0708439b5ba78d24412c506bb22f331~_JuGpuyne0753707537eusmtip2Y;
        Mon,  6 Dec 2021 11:27:45 +0000 (GMT)
Message-ID: <8953a7af-b9ab-0a04-0e0e-b0f2811c0598@samsung.com>
Date:   Mon, 6 Dec 2021 12:27:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
        Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH 1/4] blk-mq: remove hctx_lock and hctx_unlock
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <Ya3wDS/UNzQXoYpQ@T590>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNIsWRmVeSWpSXmKPExsWy7djP87qbPq9NNFhaZrH6bj+bxd5b2haH
        JjczOTB7XD5b6vF+31U2j8+b5AKYo7hsUlJzMstSi/TtErgyzi55yVYwQaHi3buHbA2MHyW7
        GDk4JARMJJ5vCe5i5OQQEljBKPH9pUIXIxeQ/YVRYu/JGawQzmdGiVnPtzKBVIE03N52kAki
        sZxR4uTZLWwQzkdGiflTl7CDVPEK2Ek8edfMAmKzCKhIHLm8AyouKHFy5hOwuKhAksSEE7vB
        pgoLOEqcu7WHFcRmFhCXuPVkPlhcREBJ4u7d1ewQcVuJ30eOgvWyCRhKdL3tYgOxOYHmX1/w
        mA2iRl6ieetsZpCDJATWckjc27GGBeJsF4mTS1dB2cISr45vYYewZST+75zPBNHQzCjx8Nxa
        dginh1HictMMRogqa4k7536xgUKMWUBTYv0ufUjgOUrcW8wFYfJJ3HgrCHEDn8SkbdOZIcK8
        Eh1tQhAz1CRmHV8Ht/XghUvMExiVZiGFyiwk389C8s0shLULGFlWMYqnlhbnpqcWG+ellusV
        J+YWl+al6yXn525iBKaP0/+Of93BuOLVR71DjEwcjIcYJTiYlUR41R6uTRTiTUmsrEotyo8v
        Ks1JLT7EKM3BoiTOK/KnIVFIID2xJDU7NbUgtQgmy8TBKdXA5HhtosQabe7T6tNr6quNnrgc
        n7PfqCl2GqvfpEjXPM6Ww7e0qhU213WcW7Fgus7qXVNyZ3xvb1L4vvRxeJbm6Vxhu7oFh00z
        BEL326SG350S+/NYOceNnJQvl/nkSx/3bsmIu6nZ9Ppgw+k78+5O3/V4qsR0Bh22a0775O2C
        6tlj7juUvHA4GjBloaCCWrj+5bPXzzYant3/uOFFzKUi3YalX39NSfj2siLjzxmN+3sfZfUL
        /HS9fvl3TNjUm90+18wkrjKnPNY/d9RMTWYqx4vDf30ky71W/MxZHr592X/7af1tDO9ik0MP
        72GsLC0rPa2X9PDZp9Z5mTtOvjSfOvdKu9WUzy9tHs+6+OHdvflKLMUZiYZazEXFiQAsvvvS
        jgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAIsWRmVeSWpSXmKPExsVy+t/xe7obP69NNPj5Ttxi9d1+Nou9t7Qt
        Dk1uZnJg9rh8ttTj/b6rbB6fN8kFMEfp2RTll5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZGpvH
        WhmZKunb2aSk5mSWpRbp2yXoZZxd8pKtYIJCxbt3D9kaGD9KdjFyckgImEjc3naQqYuRi0NI
        YCmjxN9d/9ggEjISJ6c1sELYwhJ/rnWxQRS9Z5Q4cr2TGSTBK2An8eRdMwuIzSKgInHk8g52
        iLigxMmZT8DiogJJEk8PdIINFRZwlDh3aw/YUGYBcYlbT+YzgdgiAkoSd++uZoeI20r8PnIU
        rFdIoIdJYv4VVRCbTcBQouttF9gcTqBd1xc8ZoOoN5Po2trFCGHLSzRvnc08gVFoFpIzZiFZ
        NwtJyywkLQsYWVYxiqSWFuem5xYb6hUn5haX5qXrJefnbmIERs22Yz8372Cc9+qj3iFGJg7G
        Q4wSHMxKIrxqD9cmCvGmJFZWpRblxxeV5qQWH2I0BYbFRGYp0eR8YNzmlcQbmhmYGpqYWRqY
        WpoZK4nzehZ0JAoJpCeWpGanphakFsH0MXFwSjUw7Tf4+rBmm4d+1pP/KqnB+ms2Gu51XSds
        21yxzu84zxLtrnL27R+Oa77lWf95tsO+mimi985fvpjxyHfX+p5dZzeHfgnQYKuz3Ocyz/vO
        lTXLq3KvrOW/anfcg0VKSzL4BrfJ19s3w45aKlkGRE15pu/+MKl348Iy6TPfVKX38uvEXbcJ
        Ypsnd7ztuOQNszft5bmRd9+zBgmn/9j97XkfQ3X546OKk5/1u4ow/7b5a3PNSuvkOjWviTtF
        N7DYvHW39z/39Ffq5p9RXeku77cUbP3599yJRQfjLylNemR49dHBxz+Db19XnnopiSvCW8Ay
        bK+hQpvhjWimExmWq1MelT5ebe7PdC7796KvH4RFpymxFGckGmoxFxUnAgDIlkZmIwMAAA==
X-CMS-MailID: 20211206112745eucas1p1881bf46dd5cf9e27fe37c4e8199560dd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20211206103121eucas1p2ac12934f15129fe77d7f8d95c02fe447
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20211206103121eucas1p2ac12934f15129fe77d7f8d95c02fe447
References: <20211203131534.3668411-1-ming.lei@redhat.com>
        <20211203131534.3668411-2-ming.lei@redhat.com>
        <CGME20211206103121eucas1p2ac12934f15129fe77d7f8d95c02fe447@eucas1p2.samsung.com>
        <8b6e48b0-c55d-1583-1146-b18bf4eaf94a@samsung.com> <Ya3wDS/UNzQXoYpQ@T590>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

On 06.12.2021 12:12, Ming Lei wrote:
> On Mon, Dec 06, 2021 at 11:31:21AM +0100, Marek Szyprowski wrote:
>> On 03.12.2021 14:15, Ming Lei wrote:
>>> Remove hctx_lock and hctx_unlock, and add one helper of
>>> blk_mq_run_dispatch_ops() to run code block defined in dispatch_ops
>>> with rcu/srcu read held.
>>>
>>> Compared with hctx_lock()/hctx_unlock():
>>>
>>> 1) remove 2 branch to 1, so we just need to check
>>> (hctx->flags & BLK_MQ_F_BLOCKING) once when running one dispatch_ops
>>>
>>> 2) srcu_idx needn't to be touched in case of non-blocking
>>>
>>> 3) might_sleep_if() can be moved to the blocking branch
>>>
>>> Also put the added blk_mq_run_dispatch_ops() in private header, so that
>>> the following patch can use it out of blk-mq.c.
>>>
>>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
>> This patch landed in linux next-20211206 as commit 2a904d00855f
>> ("blk-mq: remove hctx_lock and hctx_unlock"). It introduces a following
>> 'BUG' warning on my test systems (ARM/ARM64-based boards with rootfs on
>> SD card or eMMC):
>>
>> BUG: sleeping function called from invalid context at block/blk-mq.c:2060
>> in_atomic(): 1, irqs_disabled(): 128, non_block: 0, pid: 249, name:
>> kworker/0:3H
>> preempt_count: 1, expected: 0
>> RCU nest depth: 0, expected: 0
>> 4 locks held by kworker/0:3H/249:
>>    #0: c1d782a8 ((wq_completion)mmc_complete){+.+.}-{0:0}, at:
>> process_one_work+0x21c/0x7ec
>>    #1: c3b59f18 ((work_completion)(&mq->complete_work)){+.+.}-{0:0}, at:
>> process_one_work+0x21c/0x7ec
>>    #2: c1d7858c (&mq->complete_lock){+.+.}-{3:3}, at:
>> mmc_blk_mq_complete_prev_req.part.3+0x2c/0x234
>>    #3: c1f7a1b4 (&fq->mq_flush_lock){....}-{2:2}, at:
>> mq_flush_data_end_io+0x68/0x124
> It should be fixed by the attached patch.
>
> >From bce4d1bf7ab4ac4c04a65eca67705567e9d5f0c0 Mon Sep 17 00:00:00 2001
> From: Ming Lei <ming.lei@redhat.com>
> Date: Mon, 6 Dec 2021 15:54:11 +0800
> Subject: [PATCH] blk-mq: don't run might_sleep() if the operation needn't
>   blocking
>
> The operation protected via blk_mq_run_dispatch_ops() in blk_mq_run_hw_queue
> won't sleep, so don't run might_sleep() for it.
>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Confirmed, this fixed the issue.

Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

> ---
>   block/blk-mq.c | 2 +-
>   block/blk-mq.h | 7 +++++--
>   2 files changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 537295f6e0e9..0bf3523dd1f5 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2048,7 +2048,7 @@ void blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async)
>   	 * And queue will be rerun in blk_mq_unquiesce_queue() if it is
>   	 * quiesced.
>   	 */
> -	blk_mq_run_dispatch_ops(hctx->queue,
> +	__blk_mq_run_dispatch_ops(hctx->queue, false,
>   		need_run = !blk_queue_quiesced(hctx->queue) &&
>   		blk_mq_hctx_has_pending(hctx));
>   
> diff --git a/block/blk-mq.h b/block/blk-mq.h
> index d62004e2d531..948791ea2a3e 100644
> --- a/block/blk-mq.h
> +++ b/block/blk-mq.h
> @@ -375,7 +375,7 @@ static inline bool hctx_may_queue(struct blk_mq_hw_ctx *hctx,
>   }
>   
>   /* run the code block in @dispatch_ops with rcu/srcu read lock held */
> -#define blk_mq_run_dispatch_ops(q, dispatch_ops)		\
> +#define __blk_mq_run_dispatch_ops(q, check_sleep, dispatch_ops)	\
>   do {								\
>   	if (!blk_queue_has_srcu(q)) {				\
>   		rcu_read_lock();				\
> @@ -384,11 +384,14 @@ do {								\
>   	} else {						\
>   		int srcu_idx;					\
>   								\
> -		might_sleep();					\
> +		might_sleep_if(check_sleep);			\
>   		srcu_idx = srcu_read_lock((q)->srcu);		\
>   		(dispatch_ops);					\
>   		srcu_read_unlock((q)->srcu, srcu_idx);		\
>   	}							\
>   } while (0)
>   
> +#define blk_mq_run_dispatch_ops(q, dispatch_ops)		\
> +	__blk_mq_run_dispatch_ops(q, true, dispatch_ops)	\
> +
>   #endif

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

