Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F263EC77B71
	for <linux-block@archiver.kernel.org>; Sat, 15 Apr 2023 03:41:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjDODlT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Apr 2023 23:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjDODlT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Apr 2023 23:41:19 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C27F23C27
        for <linux-block@vger.kernel.org>; Fri, 14 Apr 2023 20:41:17 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-63b781c9787so152749b3a.1
        for <linux-block@vger.kernel.org>; Fri, 14 Apr 2023 20:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1681530077; x=1684122077;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8sNozpdx31abguSyVSF9qhZOX9oqhbNtIPjBrNvBDXo=;
        b=zAR6U9OfcJXl1UaLi7zKV0pyJWH68PG7A2zCVyQ3Nz98G3D1UJKVT6Y8AxFfIv4Vh9
         6h2y7QQmjhH7EpFX4I9/P89YUuJ852u3YDTXy5QvEIgw3Nx4fG3s3Ljb+WyYafBDPqh4
         hiioLy5rL6WtE2jKn3GMZJRDvLWggcuKr0uk/uUmkbaMbHlO25/yw5dIWN1e8HbTI58+
         507XvL5aSoWjIDFhKpIKnxB60tedQwfnp3S+eii5Jd4+wklElzbxOgU391kzDGjfsDx6
         kwAxBkDF+tsyYjvDGkXzGOXcDAYFGrnnLBiH/c75BH0zrrG9JIxrvakjHllJCxuKMQcm
         qAxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681530077; x=1684122077;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8sNozpdx31abguSyVSF9qhZOX9oqhbNtIPjBrNvBDXo=;
        b=Z5OvC4BmmzZ9TPt0OrblIr/LLW8XX1Mm95NLD63qL5WpqGv9jkHv38pUlOlu4/dhFr
         k5yfCvTh4UE4KRmgU4mX16me6jfoLuGGDycCV4bUsAX+tEMV1r4snOUcbttqjg3IpnxR
         xX1NqQaZNM7tclbgm/ryhNXg67d5SElRFrJg3XQm+DZAcfAY+rxY2501Tr1grCC4fYHv
         ETPPRdOZjt6iJR+jIWhEi4xsZtsc0lgXXDB3o+pAKaKAICvvKm+Y5g3eKxpYs15HBOYZ
         aXqhVbvhdXrahYqUmb72fVxhzGAfUfGjx+cOQjDjEBy6DrZXRlHpSsTuzD7Vl3NAZhLp
         5WyQ==
X-Gm-Message-State: AAQBX9fqHxyeSwpgfE3jHTuT3PcPvP1+9duqwk6nD7PyewUmnUaCeA02
        Jw2/ynjJoC4ymnsunkBbD40+t6Tgud2afVGCFP8=
X-Google-Smtp-Source: AKy350aOJKVvcKfczURlqvns5/ZWq7cfl1FIrXQVS84Wc9q/0eAu9VYrxkqIdAqpEVlyUOw5Z0i/2Q==
X-Received: by 2002:a17:903:2308:b0:19a:a815:2877 with SMTP id d8-20020a170903230800b0019aa8152877mr5468822plh.6.1681530077021;
        Fri, 14 Apr 2023 20:41:17 -0700 (PDT)
Received: from [192.168.4.201] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id i7-20020a17090aee8700b00246eea97f0dsm5299529pjz.47.2023.04.14.20.41.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Apr 2023 20:41:16 -0700 (PDT)
Message-ID: <d790086e-1bfe-6882-2e84-8110d7b9bc28@kernel.dk>
Date:   Fri, 14 Apr 2023 21:41:15 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 2/2] block: store bdev->bd_disk->fops->submit_bio state in
 bdev
Content-Language: en-US
To:     Damien Le Moal <dlemoal@kernel.org>, linux-block@vger.kernel.org
References: <20230414134848.91563-1-axboe@kernel.dk>
 <20230414134848.91563-3-axboe@kernel.dk>
 <61ee258c-b330-ba93-cab5-83e7bd9cd105@kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <61ee258c-b330-ba93-cab5-83e7bd9cd105@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/14/23 8:43?PM, Damien Le Moal wrote:
> On 4/14/23 22:48, Jens Axboe wrote:
>> We have a long chain of memory dereferencing just to whether or not
>> this disk has a special submit_bio helper. As that's not necessarily
>> the common case, add a bd_submit_bio state in the bdev to avoid
>> traversing this memory dependency chain if we don't need to.
>>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>> ---
>>  block/bdev.c              | 1 +
>>  block/blk-core.c          | 8 ++++----
>>  block/genhd.c             | 4 ++++
>>  include/linux/blk_types.h | 1 +
>>  4 files changed, 10 insertions(+), 4 deletions(-)
>>
>> diff --git a/block/bdev.c b/block/bdev.c
>> index 1795c7d4b99e..31a5d25b2b44 100644
>> --- a/block/bdev.c
>> +++ b/block/bdev.c
>> @@ -419,6 +419,7 @@ struct block_device *bdev_alloc(struct gendisk *disk, u8 partno)
>>  	bdev->bd_inode = inode;
>>  	bdev->bd_queue = disk->queue;
>>  	bdev->bd_stats = alloc_percpu(struct disk_stats);
>> +	bdev->bd_submit_bio = 0;
> 
> "= false;" would be better to match bd_submit_bio type.

Done

>> diff --git a/block/genhd.c b/block/genhd.c
>> index 02d9cfb9e077..07736c5db988 100644
>> --- a/block/genhd.c
>> +++ b/block/genhd.c
>> @@ -420,6 +420,10 @@ int __must_check device_add_disk(struct device *parent, struct gendisk *disk,
>>  	 */
>>  	elevator_init_mq(disk->queue);
>>  
>> +	/* Mark bdev as having a submit_bio, if needed */
>> +	if (disk->fops->submit_bio)
>> +		disk->part0->bd_submit_bio = 1;
> 
> "= true;" would be better to match the type.
> 
> Note that this could also be:
> 
> disk->part0->bd_submit_bio = disk->fops->submit_bio;
> 
> thus removing the if.

I made it:

disk->part0->bd_submit_bio = disk->fops->submit_bio != NULL;

instead to make it explicit, I don't think that assignment would be
happy otherwise.

-- 
Jens Axboe

