Return-Path: <SRS0=GKUn=VJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D58FC742A5
	for <linux-block@archiver.kernel.org>; Fri, 12 Jul 2019 02:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20D1C208E4
	for <linux-block@archiver.kernel.org>; Fri, 12 Jul 2019 02:44:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="yE9iMMiv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729038AbfGLCob (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Jul 2019 22:44:31 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36081 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729015AbfGLCob (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Jul 2019 22:44:31 -0400
Received: by mail-pf1-f195.google.com with SMTP id r7so3633820pfl.3
        for <linux-block@vger.kernel.org>; Thu, 11 Jul 2019 19:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cl7fhg8lBpEQW7dma5LXG4fo5CaaraE0u/K19/WC6D8=;
        b=yE9iMMiv7zZJT8r4F0JF5rJFPdESrYfMgqD7djVbGfs14PywlHkFQDQNGvJegNFfpB
         SRs++D/DwalbNz9W0wWll3A2TUyZUTSThOjQDvHqs6hKDwBakWBYu24fxFk/3BEn34rP
         rWpM9KqSNnYGwaEVx9x7iP9o0vnS6ZbrDk3JH2zPh3GIMDaosx4ZghFD1EQBBGtVggoT
         mhKFnUfCHjlN8gpErbckLXvf2BrERlWLPGz/wIusdVZsqolLtcrug1hYlWU3FJDfdLXz
         ++HkA9Gc+Po6NHD5pOODoyBKA35LQM29rTbnL9LICLYXD60mQRp5t90pIRSjpJGGdzv6
         8K+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cl7fhg8lBpEQW7dma5LXG4fo5CaaraE0u/K19/WC6D8=;
        b=kxAXM7HYk7Xnh4NhCE1v9lm2OMsZunz8VAxbsu5h6inqMMmzwcvSzudgKLsx2smE51
         augy5og+8ELcR/WOjPLwpOgd5Ndsvb6wXaic457k77Vceo988OzPVNHR8IFGeqN9+i3D
         kXrWbZUhSi4QVJmZBAnnLHRBLLla7oC/3ROl+wg077dBQmjSyLKgGGLvFEx5J71t4l1L
         bTcrXRX27t2JA21JePz/3pzq0LsnsC/mMafOAStY6sCv2wwoyR+MaiiDRRNmx6n0Cqq1
         bHOxrypAu4X6192Ud+OSv8/ZOhLE3W37c8SXirxaF1oFTfsf4+Xto0KOmebbYPfLXBBe
         HOGg==
X-Gm-Message-State: APjAAAX02I2iezEnHBYBqm9yhlT7aHsjG8ADiybTm1XzgYdL/2UN5q6/
        ecYU/gzd4m3ZNHJ2kc1HBq519X5c0Yw=
X-Google-Smtp-Source: APXvYqyaF3f8uPJN3uLUR9Lds9jPhhyD6yI6LiLAFCX7DtmWKvthfZUJxoYHeZVNwrRUoMm2JzIf8Q==
X-Received: by 2002:a17:90a:9905:: with SMTP id b5mr8872323pjp.70.1562899470172;
        Thu, 11 Jul 2019 19:44:30 -0700 (PDT)
Received: from [192.168.1.121] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id x67sm9243858pfb.21.2019.07.11.19.44.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Jul 2019 19:44:29 -0700 (PDT)
Subject: Re: [PATCH] block: tidy up blk_mq_plug
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20190711111714.4802-1-hch@lst.de>
 <53c09d04-3f29-2cea-ede4-cdf443539a17@kernel.dk>
 <BYAPR04MB5816B7867433C3A946E7411DE7F20@BYAPR04MB5816.namprd04.prod.outlook.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ff1df7c2-93a8-5233-3873-005817356c27@kernel.dk>
Date:   Thu, 11 Jul 2019 20:44:27 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB5816B7867433C3A946E7411DE7F20@BYAPR04MB5816.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/11/19 8:37 PM, Damien Le Moal wrote:
> On 2019/07/12 3:09, Jens Axboe wrote:
>> On 7/11/19 5:17 AM, Christoph Hellwig wrote:
>>> Make the zoned device write path the special case and just fall
>>> though to the defaul case to make the code easier to read.  Also
>>> update the top of function comment to use the proper kdoc format
>>> and remove the extra in-function comments that just duplicate it.
>>>
>>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>>> ---
>>>    block/blk-mq.h | 14 ++++----------
>>>    1 file changed, 4 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/block/blk-mq.h b/block/blk-mq.h
>>> index 32c62c64e6c2..ab80fd2b3803 100644
>>> --- a/block/blk-mq.h
>>> +++ b/block/blk-mq.h
>>> @@ -233,7 +233,7 @@ static inline void blk_mq_clear_mq_map(struct blk_mq_queue_map *qmap)
>>>    		qmap->mq_map[cpu] = 0;
>>>    }
>>>    
>>> -/*
>>> +/**
>>>     * blk_mq_plug() - Get caller context plug
>>>     * @q: request queue
>>>     * @bio : the bio being submitted by the caller context
>>> @@ -254,15 +254,9 @@ static inline void blk_mq_clear_mq_map(struct blk_mq_queue_map *qmap)
>>>    static inline struct blk_plug *blk_mq_plug(struct request_queue *q,
>>>    					   struct bio *bio)
>>>    {
>>> -	/*
>>> -	 * For regular block devices or read operations, use the context plug
>>> -	 * which may be NULL if blk_start_plug() was not executed.
>>> -	 */
>>> -	if (!blk_queue_is_zoned(q) || !op_is_write(bio_op(bio)))
>>> -		return current->plug;
>>> -
>>> -	/* Zoned block device write operation case: do not plug the BIO */
>>> -	return NULL;
>>> +	if (blk_queue_is_zoned(q) && op_is_write(bio_op(bio)))
>>> +		return NULL;
>>> +	return current->plug;
>>>    }
>>>    
>>>    #endif
>>
>> I agree it's more readable, but probably also means that the path that we
>> care the least about (zoned+write) is now the inline one.
> 
> What about an additional inline function ?
> So something like this is very readable I think and blk_mq_plug() can also be
> optimized with #ifdef for the !CONFIG_BLK_DEV_ZONED case.
> 
> #ifndef CONFIG_BLK_DEV_ZONED
> static inline struct blk_plug *blk_mq_plug(struct request_queue *q,
>    					   struct bio *bio)
> {
> 	return current->plug;
> }
> #else
> static inline struct blk_plug *blk_zoned_get_plug(struct request_queue *q,
>    						  struct bio *bio)
> {
> 	if (op_is_write(bio_op(bio)))
> 		return NULL;
> 
> 	return current->plug;
> }
> 
> static inline struct blk_plug *blk_mq_plug(struct request_queue *q,
>    					   struct bio *bio)
> {
> 	if (!blk_queue_is_zoned(q))
> 		return current->plug;
> 
> 	return blk_zoned_get_plug(q, bio);
> }
> #endif

Let's not go that far into ifdef'ery, please... Besides, that usually
solves nothing, as most/all kernels will have zoned support enabled.

I'm actually fine with the existing setup. Yes, the other variant is
easier to read, but I bet the existing one inlines better.

-- 
Jens Axboe

