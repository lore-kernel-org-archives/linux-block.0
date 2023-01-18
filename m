Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94000C00A5A
	for <linux-block@archiver.kernel.org>; Wed, 18 Jan 2023 02:22:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbjARCWb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Jan 2023 21:22:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjARCWa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Jan 2023 21:22:30 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BBED53574
        for <linux-block@vger.kernel.org>; Tue, 17 Jan 2023 18:22:29 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id k18so11435655pll.5
        for <linux-block@vger.kernel.org>; Tue, 17 Jan 2023 18:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UyxeS9oQOODP8SELR2uJe0F1y/SrJQ+greOxtnkfjIY=;
        b=v9l6SBK8OHBDeK/HCxBbpds5/0w0I0Qhwkkp4MmAwcKj2bxcwKwGhaaXYz6pHUK45P
         8gQER5QhtNkL1eaMIg6zWclLqW3GOKeoMEGiW4SxMQ3p8zvUcuKWFDs8qAyk0nZ3dzV1
         RXxLrmyJ2kQrPehLdvimjtS4ug40Ms/Ovo1YLTSItjHIM+0BFED6uLcbT1FSXICn6ITa
         V/oqP9qA8qsWNnPGuc3pVi5p1zrlRod+4nNGbSqhhcmYExi9SmkN+3R7I5Ob5+HQXJIA
         ZnAhAFW2SYCWu+UZ8fAoy8DvJq+ubi69D1P4JK7Han34fgSmGScDsxJfXSZUya//3XY1
         O5Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UyxeS9oQOODP8SELR2uJe0F1y/SrJQ+greOxtnkfjIY=;
        b=4hVcxJXwA72syZeoG4WbWWNMUDHEGfwxi2dkXzAqO3PO+tKyYjR7tl3Zsok3/kjrvZ
         DkwFszNiapZoJyAITSW3p/P8c2fuopO0N08qf1M+7XdbWayhgdDGhQr0ABB97FjsiXbb
         yrFLHoaLzFmeYIFdu7WyLNssN3p3kCBy9+4J+Jk/7Tx2q3W3cgDm32tppDNwhsQEKrO4
         V2iJhTZjCbaQ7ZMHBBzty+tvJNcXD8zZiPq/ra/eoD5o/W/yDOaHaV8EVhPDu9fNsoLR
         wUlNECsYcGn9lF7Dl6hFu+L/u7UAROfDqVoM24h2yw9AWNzQ7Uzl6RFzV2R3xSj1i/m3
         zsGA==
X-Gm-Message-State: AFqh2krIOmYic86y1stOnWdtoDJNGeVDpCiOwsEQSdQQzMgPuO52uHZn
        QcsYlC6o+XteittMSS/Cw2hsSA==
X-Google-Smtp-Source: AMrXdXsI+9uih7cXIRwsieE+Cqws52DIAdhYBMJsGlq/FShrddCeLE2HVcs/bPTfI/aAoz/3BmNV6g==
X-Received: by 2002:a05:6a20:158e:b0:b6:5687:17b1 with SMTP id h14-20020a056a20158e00b000b6568717b1mr1482734pzj.4.1674008548684;
        Tue, 17 Jan 2023 18:22:28 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id b37-20020a631b25000000b0047917991e83sm12335970pgb.48.2023.01.17.18.22.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jan 2023 18:22:28 -0800 (PST)
Message-ID: <98e06a63-2b76-4454-d6d1-8586424e1206@kernel.dk>
Date:   Tue, 17 Jan 2023 19:22:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 1/2] block: handle bio_split_to_limits() NULL return
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org, mikelley@microsoft.com
References: <20230104160938.62636-1-axboe@kernel.dk>
 <20230104160938.62636-2-axboe@kernel.dk> <Y70t2r+fOadEnDpE@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Y70t2r+fOadEnDpE@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/10/23 2:20 AM, Christoph Hellwig wrote:
> On Wed, Jan 04, 2023 at 09:09:37AM -0700, Jens Axboe wrote:
>> This can't happen right now, but in preparation for allowing
>> bio_split_to_limits() returning NULL if it ended the bio, check for it
>> in all the callers.
>>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>> ---
>>  block/blk-merge.c             | 4 +++-
>>  block/blk-mq.c                | 5 ++++-
>>  drivers/block/drbd/drbd_req.c | 2 ++
>>  drivers/block/ps3vram.c       | 2 ++
>>  drivers/md/dm.c               | 2 ++
>>  drivers/md/md.c               | 2 ++
>>  drivers/nvme/host/multipath.c | 2 ++
>>  drivers/s390/block/dcssblk.c  | 2 ++
>>  8 files changed, 19 insertions(+), 2 deletions(-)
>>
>> diff --git a/block/blk-merge.c b/block/blk-merge.c
>> index 35a8f75cc45d..071c5f8cf0cf 100644
>> --- a/block/blk-merge.c
>> +++ b/block/blk-merge.c
>> @@ -358,11 +358,13 @@ struct bio *__bio_split_to_limits(struct bio *bio,
>>  	default:
>>  		split = bio_split_rw(bio, lim, nr_segs, bs,
>>  				get_max_io_size(bio, lim) << SECTOR_SHIFT);
>> +		if (IS_ERR(split))
>> +			return NULL;
> 
> Can we decide on either passing an ERR_PTR or NULL and do it through
> the whole stack? 

We need the error return here as we could just return NULL and it not
be an error, but for further down the stack I feel like returning an
error that you can't do anything with (as it's already been dealt with)
would be confusing. That's why I did it that way.

>> diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
>> index eb14ec8ec04c..e36216d50753 100644
>> --- a/drivers/block/drbd/drbd_req.c
>> +++ b/drivers/block/drbd/drbd_req.c
>> @@ -1607,6 +1607,8 @@ void drbd_submit_bio(struct bio *bio)
>>  	struct drbd_device *device = bio->bi_bdev->bd_disk->private_data;
>>  
>>  	bio = bio_split_to_limits(bio);
>> +	if (!bio)
>> +		return;
> 
> So for the callers in drivers, do we need thee checks for drivers
> that don't even support REQ_NOWAIT? 

Good point, probably not, we should be erroring these out before they
reach the driver.

Doesn't hurt though, it would not necessarily be obvious that you'd
now need to start checking bio_split_to_limits() return values when
you set NOWAIT on the queue.

-- 
Jens Axboe


