Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 060BEC433FE
	for <linux-block@archiver.kernel.org>; Wed,  6 Oct 2021 18:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB04961037
	for <linux-block@archiver.kernel.org>; Wed,  6 Oct 2021 18:05:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239241AbhJFSHH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Oct 2021 14:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232019AbhJFSHH (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Oct 2021 14:07:07 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA98C061753
        for <linux-block@vger.kernel.org>; Wed,  6 Oct 2021 11:05:15 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id m20so3084151iol.4
        for <linux-block@vger.kernel.org>; Wed, 06 Oct 2021 11:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=KTZVEw3WtZ0CQkuZHL86XvO/AV1znNri/6rnugdMVAc=;
        b=0/sgWE0cbyex3+/nmvxaNhTmqPWLoaMZUwigZHXFYjsV3T8Gl5ztzO8U7sQVoQ5IQS
         VOV/n6xg3zTARAr+qMOy+tIErD3owPD5s5q0+HR6M8BPsIOesR3dRfLpTMram4p28uqL
         xf3gLq0BWPNZ8MWtG4gn49h7SG0yKkKuGTCwx+To06H6pBnOlOFXDe6vVAkY9BWmq3WV
         xqVc+2DLvmQplcs+eXVZnParRvDRLYeZpDuoqaOHeIZxW9FsN5pG2eTzyow2T4MPkMbG
         KwY7vzR9m1KbwJaO88I7jiGWJUpXi1/GLNkrh3AkxZ430LZWoOcf9kLGh5nX5ZLFJ4xy
         I51w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KTZVEw3WtZ0CQkuZHL86XvO/AV1znNri/6rnugdMVAc=;
        b=sxT36Yer2s/vju4tW2Wv0oyoA+iNZRpDb9flKzsAkOS3TsmNNqZHKpGkGMd2Msc/5U
         BruUGESh93N6ZX9LgAeTtChrOPyM0dJY3RA2wdZcZ5ExCCD5lVbQRTU3cymgZvLr33iA
         A7oVyiatm1uIHxDn9fIN46Syu+zagJRKOOxQxNkXt5XL0v9SIaJpqHRnckBAhvy4PSFn
         CJlgC6DJq/BNmB9NAx21Gzp2hRAq7Ewrvofica+q4lkIhxjGrJhUzkEFHOA8LYZCEtUw
         Jt440/voyV0edISF7d7V9lVR9aHKIR88CrrwSq9BBOPP9d/ab3vvfvxh5BowxtgoxvNf
         7mMg==
X-Gm-Message-State: AOAM532CTC52ciZUAJAe55+NNq4MUcNShaj93lE4NfUIXGWRCIcmPrnS
        GtuZYQanis6SwejcdDA4FFHxctWA2JvbHfaO9VE=
X-Google-Smtp-Source: ABdhPJyPnoKru+T5qNj1hREfc3JJB1HooVYBUq1PgxidaurRt9aZnRXkwx6IIurvEt+GsO3JIJg24w==
X-Received: by 2002:a05:6638:11c5:: with SMTP id g5mr5497698jas.52.1633543514332;
        Wed, 06 Oct 2021 11:05:14 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id e10sm12172058ili.53.2021.10.06.11.05.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Oct 2021 11:05:13 -0700 (PDT)
Subject: Re: [PATCH 1/3] block: bump max plugged deferred size from 16 to 32
To:     Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org
References: <20211006163522.450882-1-axboe@kernel.dk>
 <20211006163522.450882-2-axboe@kernel.dk>
 <54e098e5-8230-a04f-e4fa-83a9cfa94649@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f92df44f-5cb5-43ef-cbc9-56733fbb7659@kernel.dk>
Date:   Wed, 6 Oct 2021 12:05:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <54e098e5-8230-a04f-e4fa-83a9cfa94649@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/6/21 11:55 AM, Bart Van Assche wrote:
> On 10/6/21 9:35 AM, Jens Axboe wrote:
>> Particularly for NVMe with efficient deferred submission for many
>> requests, there are nice benefits to be seen by bumping the default max
>> plug count from 16 to 32. This is especially true for virtualized setups,
>> where the submit part is more expensive. But can be noticed even on
>> native hardware.
>>
>> Reduce the multiple queue factor from 4 to 2, since we're changing the
>> default size.
>>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>> ---
>>   block/blk-mq.c         | 4 ++--
>>   include/linux/blkdev.h | 2 +-
>>   2 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index a40c94505680..5327abbefbab 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -2145,14 +2145,14 @@ static void blk_add_rq_to_plug(struct blk_plug *plug, struct request *rq)
>>   }
>>   
>>   /*
>> - * Allow 4x BLK_MAX_REQUEST_COUNT requests on plug queue for multiple
>> + * Allow 2x BLK_MAX_REQUEST_COUNT requests on plug queue for multiple
>>    * queues. This is important for md arrays to benefit from merging
>>    * requests.
>>    */
>>   static inline unsigned short blk_plug_max_rq_count(struct blk_plug *plug)
>>   {
>>   	if (plug->multiple_queues)
>> -		return BLK_MAX_REQUEST_COUNT * 4;
>> +		return BLK_MAX_REQUEST_COUNT * 2;
>>   	return BLK_MAX_REQUEST_COUNT;
>>   }
>>   
>> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
>> index b19172db7eef..534298ac73cc 100644
>> --- a/include/linux/blkdev.h
>> +++ b/include/linux/blkdev.h
>> @@ -727,7 +727,7 @@ struct blk_plug {
>>   	bool multiple_queues;
>>   	bool nowait;
>>   };
>> -#define BLK_MAX_REQUEST_COUNT 16
>> +#define BLK_MAX_REQUEST_COUNT 32
>>   #define BLK_PLUG_FLUSH_SIZE (128 * 1024)
>>   
>>   struct blk_plug_cb;
> 
> Since BLK_MAX_REQUEST_COUNT is only used inside the block layer core but 
> not by any block driver, can it be moved from include/linux/blkdev.h 
> into block/blk-mq.h?

Good point, I'll move it in there as part of the patch.

-- 
Jens Axboe

