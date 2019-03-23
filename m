Return-Path: <SRS0=7zlQ=R2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5410DC43381
	for <linux-block@archiver.kernel.org>; Sat, 23 Mar 2019 19:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04E22218D4
	for <linux-block@archiver.kernel.org>; Sat, 23 Mar 2019 19:31:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Fq/LJxRO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727679AbfCWTbs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 23 Mar 2019 15:31:48 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44891 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727544AbfCWTbr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 23 Mar 2019 15:31:47 -0400
Received: by mail-pf1-f195.google.com with SMTP id a3so3682928pff.11
        for <linux-block@vger.kernel.org>; Sat, 23 Mar 2019 12:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TtXvO2t5VbuatZT1Y8UWmD4czXR168NpO+FrozFDT6A=;
        b=Fq/LJxROnAb3qQ5FaH9JZGvmLMAJJ1hR+vKAFhtdJw+v8g/V3Vt+KRyUyCRa8xxkjd
         sVbKNOj+Ya/s0HXaBVXfjGQDccY++xAZaocOPhNCM/dV/Zt/GtFR1uAFBuLqhsYY5PZS
         fihFF+kq04syS7amxo1mWLjpKzfzBCR/RdInRCaiIXjMp09RL8V1UcYhE7UPK3Tyk9iY
         JcftogVOuAk9CIgBU5W9BAcO68X/4+PD5PqBzxlmd1Vcmgk/NxE572qQpRVV9Xm6qi5W
         MbVLoP/RuLesceFtIoG1+Aig91YrVMUIXGF/hViBao3f3Y3ZgpFNScldtB44CaRb5LLu
         dXyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TtXvO2t5VbuatZT1Y8UWmD4czXR168NpO+FrozFDT6A=;
        b=Tcq4NkeP8pI8fWhjMs9NrbY7NCV4nozEzc/FBWubdHsl1zdjy12QhtyTKPftGFOIEW
         BSq0hOf33Dk467eD98nk5W2Qkrcf4eNxT7NxwZp3tmqNrYpfGQA7wehQwzWZlibu1DMe
         VHdcpbk6rFgnveIklUztKkE8UfLxXK/j/kZcNt2mkb7EyxuwlOEvxIAJLgiQQj1fFI0r
         O1WDCfTbaM94n56r2iRxcMKESXukmJVc5lfCSu1pFAGAFHtwalKORRrCNEQomg1aesM3
         uesuPIvCZTLBxvVqGa/GvNMoPi6OHUSEuOG+JvtF+vktrdIRLl0cEGQQT1G12tP6u0J2
         YtQg==
X-Gm-Message-State: APjAAAVceFIh+jrz6Dvo5nQgYotEUu7sSGBxyIeaxVl/qyJ2dDEL158k
        NhUH8PM1F9+v8OsUdkEGkWwh/Q==
X-Google-Smtp-Source: APXvYqwohWHiUcvhcXfYACNjPo2fOtpk97PFsKMvUWgGK98vWPMFzsmBJPxi7LKXVdrdfMBqlJ/RfA==
X-Received: by 2002:a63:e80d:: with SMTP id s13mr15283505pgh.379.1553369506911;
        Sat, 23 Mar 2019 12:31:46 -0700 (PDT)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id v18sm13962124pfm.165.2019.03.23.12.31.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Mar 2019 12:31:45 -0700 (PDT)
Subject: Re: [PATCH v2 1/3] block: bio: kill BIO_SEG_VALID flag
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     Hannes Reinecke <hare@suse.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        Linux Block Layer Mailinglist <linux-block@vger.kernel.org>,
        Linux FSDEVEL Mailinglist <linux-fsdevel@vger.kernel.org>
References: <20190322131346.20169-1-jthumshirn@suse.de>
 <20190322131346.20169-2-jthumshirn@suse.de>
 <8273b995-01c2-fbf4-b8be-484508c65938@kernel.dk>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1b279b39-310c-b180-a880-79a3f65df48e@kernel.dk>
Date:   Sat, 23 Mar 2019 13:31:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <8273b995-01c2-fbf4-b8be-484508c65938@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/22/19 4:00 PM, Jens Axboe wrote:
> On 3/22/19 7:13 AM, Johannes Thumshirn wrote:
>> @@ -712,7 +714,10 @@ int bio_add_pc_page(struct request_queue *q, struct bio *bio, struct page
>>  	bvec->bv_len = len;
>>  	bvec->bv_offset = offset;
>>  	bio->bi_vcnt++;
>> -	bio->bi_phys_segments++;
>> +	if (bio->bi_phys_segments == -1)
>> +		bio->bi_phys_segments = 1;
>> +	else
>> +		bio->bi_phys_segments++;
>>  	bio->bi_iter.bi_size += len;
> 
> Echo Christophs suggestion here.
> 
>> diff --git a/block/blk-core.c b/block/blk-core.c
>> index 4673ebe42255..53372a16dd7c 100644
>> --- a/block/blk-core.c
>> +++ b/block/blk-core.c
>> @@ -1514,6 +1514,7 @@ void blk_rq_bio_prep(struct request_queue *q, struct request *rq,
>>  	else if (bio_op(bio) == REQ_OP_DISCARD)
>>  		rq->nr_phys_segments = 1;
>>  
>> +	WARN_ON(rq->nr_phys_segments == -1);
>>  	rq->__data_len = bio->bi_iter.bi_size;
>>  	rq->bio = rq->biotail = bio;
> 
> Just make that:
> 
> 	else
> 		rq->nr_phys_segments = 0;
> 
> for the third case?

Would be great if you could spin a v3 with the mentioned changes, against
master since the BIO_NO_PAGE_REF change is now merged there.

-- 
Jens Axboe

