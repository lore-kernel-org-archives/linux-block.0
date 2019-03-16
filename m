Return-Path: <SRS0=01oL=RT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C41BC43381
	for <linux-block@archiver.kernel.org>; Sat, 16 Mar 2019 23:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 287F22186A
	for <linux-block@archiver.kernel.org>; Sat, 16 Mar 2019 23:49:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xTFYEdLZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbfCPXtA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 16 Mar 2019 19:49:00 -0400
Received: from merlin.infradead.org ([205.233.59.134]:48226 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbfCPXtA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 Mar 2019 19:49:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=y+DXStj5c2Xqr9WzdcP1wEOJyGpE6jq16MXzR2t7nyI=; b=xTFYEdLZu+raIcDfqv3/w2TgQi
        91zi/6li1kaAIFv2FUkSWCU/NsLPKetfUMZb2Hoy1UzXgyxzz9IoxtGewQtxJAnPu97Pt2Xu9ioYu
        xuDxt85CnYzow6DO6ZXPoMSKh/dihFMRlOaatwHeXfHaFoONTGpHlMnsIsETREBuY0B6ahoKLy5PR
        Q+G150Sj/e5Pm0WfTSG/P/rcMvEEliYcjuUk9TIzyRl0hB37wcJVKOLWvDyaxI4JiWEGxHVOXTg5C
        Gm8EXv3HNVjvKcj3xQNF2jMxgArl8j/LJBkbs+cvM/yBsTfx5xC8YxwrmLTEbdysjTB8/K2MvTBIO
        pRbW1oSw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h5J2s-0000Tk-WE; Sat, 16 Mar 2019 23:48:55 +0000
Subject: Re: paride/pf.c: blk-mq use-after-free (kernel v5.0)
To:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Tim Waugh <tim@cyberelk.net>,
        linux-parport@lists.infradead.org
References: <30c63b2d-92d2-51be-40f0-62cada110388@infradead.org>
 <7d24a06f-f219-e50a-e8f8-915a6cc1b796@infradead.org>
 <e2a66da2-5433-5b42-1ebe-9f1c135b5471@infradead.org>
 <59cb035e-6880-de5a-33c5-d4db6ed910f4@kernel.dk>
 <4a2adc33-ef38-6a5f-65ee-8fcfaa0948a9@infradead.org>
 <d22bf156-06df-ec67-121d-7dce65088b1a@kernel.dk>
 <55743981-da8f-3211-0650-b143c8fec084@infradead.org>
 <23f48266-0d12-1891-1373-711b63f4f589@kernel.dk>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <21e5a575-8f28-5a14-3916-ab41b4d37734@infradead.org>
Date:   Sat, 16 Mar 2019 16:48:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <23f48266-0d12-1891-1373-711b63f4f589@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/16/19 12:31 PM, Jens Axboe wrote:
> On 3/15/19 6:32 PM, Randy Dunlap wrote:
>> On 3/15/19 9:33 AM, Jens Axboe wrote:
>>> On 3/14/19 5:49 PM, Randy Dunlap wrote:
>>>> On 3/14/19 4:43 PM, Jens Axboe wrote:
>>>>> On 3/13/19 5:09 PM, Randy Dunlap wrote:
>>>>>> On 3/11/19 6:34 PM, Randy Dunlap wrote:
>>>>>>> On 3/11/19 6:25 PM, Randy Dunlap wrote:
>>>>>>>> [Has this already been addressed/fixed?]>>
>>>>>>>
>>>>>>> Same bug occurs with paride/pcd.c driver.
>>>>>>
>>>>>> This still happens (in blk-mq) in v5.0-11053-gebc551f2b8f9 of Mar. 12, 2019,
>>>>>> around 4pm PT.  [caused by paride: pf.c and pcd.c)
>>>>>
>>>>> I'll take a look at this, been busy with other stuff. How are you
>>>>> reproducing this? I'm assuming you don't actually have any hardware :-)
>>>>
>>>> Right.  I just load the module (pf or pcd), unload it, and
>>>> then load it again.
>>>
>>> Does this work?
>>>
>>
>> No.  Just loading the pf module gives this:
> 
> Missing clear of the queue. This one should be more complete.
> 
> To be fair, this was utterly broken since forever. It's just now apparent
> since we complain about it. But pf/pcd was one big leak fest.
> 

OK, this one works for both pf and pcd.
By "works" I mean that the driver init function runs and exits without
causing a BUG or GP fault etc.
Not that I have any such hardware.

Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> 
> diff --git a/drivers/block/paride/pcd.c b/drivers/block/paride/pcd.c
> index 96670eefaeb2..377a694dc228 100644
> --- a/drivers/block/paride/pcd.c
> +++ b/drivers/block/paride/pcd.c
> @@ -749,8 +749,12 @@ static int pcd_detect(void)
>  		return 0;
>  
>  	printk("%s: No CD-ROM drive found\n", name);
> -	for (unit = 0, cd = pcd; unit < PCD_UNITS; unit++, cd++)
> +	for (unit = 0, cd = pcd; unit < PCD_UNITS; unit++, cd++) {
> +		blk_cleanup_queue(cd->disk->queue);
> +		cd->disk->queue = NULL;
> +		blk_mq_free_tag_set(&cd->tag_set);
>  		put_disk(cd->disk);
> +	}
>  	pi_unregister_driver(par_drv);
>  	return -1;
>  }
> diff --git a/drivers/block/paride/pf.c b/drivers/block/paride/pf.c
> index e92e7a8eeeb2..103b617cdc31 100644
> --- a/drivers/block/paride/pf.c
> +++ b/drivers/block/paride/pf.c
> @@ -761,8 +761,12 @@ static int pf_detect(void)
>  		return 0;
>  
>  	printk("%s: No ATAPI disk detected\n", name);
> -	for (pf = units, unit = 0; unit < PF_UNITS; pf++, unit++)
> +	for (pf = units, unit = 0; unit < PF_UNITS; pf++, unit++) {
> +		blk_cleanup_queue(pf->disk->queue);
> +		pf->disk->queue = NULL;
> +		blk_mq_free_tag_set(&pf->tag_set);
>  		put_disk(pf->disk);
> +	}
>  	pi_unregister_driver(par_drv);
>  	return -1;
>  }
> @@ -1047,13 +1051,15 @@ static void __exit pf_exit(void)
>  	int unit;
>  	unregister_blkdev(major, name);
>  	for (pf = units, unit = 0; unit < PF_UNITS; pf++, unit++) {
> -		if (!pf->present)
> -			continue;
> -		del_gendisk(pf->disk);
> +		if (pf->present)
> +			del_gendisk(pf->disk);
> +
>  		blk_cleanup_queue(pf->disk->queue);
>  		blk_mq_free_tag_set(&pf->tag_set);
>  		put_disk(pf->disk);
> -		pi_release(pf->pi);
> +
> +		if (pf->present)
> +			pi_release(pf->pi);
>  	}
>  }
>  
> 


-- 
~Randy
