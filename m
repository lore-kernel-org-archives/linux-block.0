Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F396C77B60
	for <linux-block@archiver.kernel.org>; Fri, 28 Apr 2023 19:46:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbjD1TqL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Apr 2023 15:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjD1TqL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Apr 2023 15:46:11 -0400
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E2465275
        for <linux-block@vger.kernel.org>; Fri, 28 Apr 2023 12:46:09 -0700 (PDT)
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1a6762fd23cso3000765ad.3
        for <linux-block@vger.kernel.org>; Fri, 28 Apr 2023 12:46:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682711169; x=1685303169;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MIeV8pQWpAxQ3ouf/ab4YbeUpSGk9VHna3mD3BjRzHQ=;
        b=GvsLOdFnWbKVaknzf1mSM09urfIWbZl2k8Oco9BWOfeeKyDwyO0N46mEuAvxvVNMMS
         3DT6VjU1Nrt3YkHVEFiK3bzXC8X8kTbA6IsNOCELQ78YkKvGp0b5rnRxcpHqYzX/9XN0
         mj2ZR1FGArttIpWs4bb9Ry20FJrfdVGbyFDuUibeGcgPoSRQoVnqa0gig4rRYSKqK8aw
         rzB+RomfjZCNdPlnIm1kyVdAZCadKGTxYsyWjKLJ37O+inz3dUwr3UHZLzb64JPzZWs+
         /XcayCZrk8qyNij/F4mWVjFjFhQDdsLjQe6Q4L2yU8lw8DlxSRa3E8a7Eq202/Rg3J1A
         6tlw==
X-Gm-Message-State: AC+VfDwshb5NGItD43zz8YHnWYL2dxXK4/oHj25fgbjH7fH3uSIykSLW
        imfZKFo9v6xd7XL8phJeO7Q=
X-Google-Smtp-Source: ACHHUZ7VNC/t3IhsyKLjVtLESTacTGljYH5kNJSiCKETvHaL1DXIQN7wgr6M2lExkvbA05lgEgVvfg==
X-Received: by 2002:a17:902:c44c:b0:1a6:a7ac:2ab5 with SMTP id m12-20020a170902c44c00b001a6a7ac2ab5mr5305513plm.45.1682711168660;
        Fri, 28 Apr 2023 12:46:08 -0700 (PDT)
Received: from [192.168.51.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id iz1-20020a170902ef8100b001a987c4d3b9sm6903515plb.290.2023.04.28.12.46.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Apr 2023 12:46:07 -0700 (PDT)
Message-ID: <1c28f0b9-14f1-5fc1-4e15-52c4f6c2c91c@acm.org>
Date:   Fri, 28 Apr 2023 12:46:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v3 2/9] block: Micro-optimize
 blk_req_needs_zone_write_lock()
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>
References: <20230424203329.2369688-1-bvanassche@acm.org>
 <20230424203329.2369688-3-bvanassche@acm.org> <20230428054446.GC8549@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230428054446.GC8549@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/27/23 22:44, Christoph Hellwig wrote:
> On Mon, Apr 24, 2023 at 01:33:22PM -0700, Bart Van Assche wrote:
>> @@ -367,8 +367,9 @@ static inline void blk_mq_clear_mq_map(struct blk_mq_queue_map *qmap)
>>   static inline struct blk_plug *blk_mq_plug( struct bio *bio)
>>   {
>>   	/* Zoned block device write operation case: do not plug the BIO */
>> -	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
>> -	    bdev_op_is_zoned_write(bio->bi_bdev, bio_op(bio)))
>> +	if ((bio_op(bio) == REQ_OP_WRITE ||
>> +	     bio_op(bio) == REQ_OP_WRITE_ZEROES) &&
>> +	    disk_zone_is_seq(bio->bi_bdev->bd_disk, bio->bi_iter.bi_sector))
>>   		return NULL;
> 
> I find this a bit hard to hard to read.  Why not:
> 
> 	if (disk_zone_is_seq(bio->bi_bdev->bd_disk, bio->bi_iter.bi_sector)) {
> 	  	/*
> 		 * Do not plug for writes that require zone locking.
> 		 */
> 		if (bio_op(bio) == REQ_OP_WRITE ||
> 		    bio_op(bio) == REQ_OP_WRITE_ZEROES)
> 			return NULL;
> 	}

In the above alternative the expensive check happens before a check that is not
expensive at all. Do you really want me to call disk_zone_is_seq() before checking
the operation type?

>>   bool blk_req_needs_zone_write_lock(struct request *rq)
>>   {
>> -	if (!rq->q->disk->seq_zones_wlock)
>> -		return false;
>> -
>> -	if (bdev_op_is_zoned_write(rq->q->disk->part0, req_op(rq)))
>> -		return blk_rq_zone_is_seq(rq);
>> -
>> -	return false;
>> +	return rq->q->disk->seq_zones_wlock &&
>> +		(req_op(rq) == REQ_OP_WRITE ||
>> +		 req_op(rq) == REQ_OP_WRITE_ZEROES) &&
>> +		blk_rq_zone_is_seq(rq);
> 
> Similaly here.  The old version did flow much better, so I'd prefer
> something like:
> 
> 
> 	if (!rq->q->disk->seq_zones_wlock || !blk_rq_zone_is_seq(rq))
> 		return false;
> 	return req_op(rq) == REQ_OP_WRITE || req_op(rq) == REQ_OP_WRITE_ZEROES);
> 
> I also wonder if the check that and op is write or write zeroes, that
> is needs zone locking would be useful instead of dupliating it all
> over.  That is instead of removing bdev_op_is_zoned_write
> keep a op_is_zoned_write without the bdev_is_zoned check.

I will introduce an op_is_zoned_write() helper function.

Thanks,

Bart.
