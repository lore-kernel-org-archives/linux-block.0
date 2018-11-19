Return-Path: <SRS0=iXKq=N6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D982AC43441
	for <linux-block@archiver.kernel.org>; Mon, 19 Nov 2018 15:21:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E3E720831
	for <linux-block@archiver.kernel.org>; Mon, 19 Nov 2018 15:21:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="DVlRVN2u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E3E720831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729587AbeKTBp3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Nov 2018 20:45:29 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:42056 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729483AbeKTBp3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Nov 2018 20:45:29 -0500
Received: by mail-io1-f68.google.com with SMTP id x6so500758ioa.9
        for <linux-block@vger.kernel.org>; Mon, 19 Nov 2018 07:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0d6lk7q6Sw0DQdJIkNT60ziIJtxW4POdUJNIyEe978w=;
        b=DVlRVN2uWFbw2r4scqDUEqOvcegiS7XTVxyt1kXCA02j3ugQiTsSqig4PvrpkJZ02r
         rw2hzxwmG70b/DAsPPd2t6kphz7aSWXGjybEt8ldO/IAEzmXIXbqlZ+0k0EOMPur8D3o
         AiMEtEHrTHh1Mdq6fOui++1fZfGCdCZabhaIJeQQqmv6c4G56R/QHwh3XG9uoQDzmCF9
         BKuU6/6KCP0kF5JUxZlWlR3Qhi3wx1iRhdOZDBDB4luexnCV/rGi0iKu8+iqDGUT3gcy
         HbjyLEdlL/fQFBqYXRAQmM4fwMSMmOwel1zFsX/3B9IGL/sCND0W2gLJzk59ajfjl4GA
         OHLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0d6lk7q6Sw0DQdJIkNT60ziIJtxW4POdUJNIyEe978w=;
        b=JvYgXoNqwl2a/7C6revRqm+I9EwaxjyWDW7kf+RRKxYqHaQDhgnJ3YwNGko+nhUN9Y
         fSHcF/gJxyhCvsFUysEtYrM8M3qEAzTvDlZyeLh566AX6zsrCefWZ5PwVhye54sNFZpG
         A4Eew+YQRjUVcqXSHxblNh227qqVzbFe+0d71o+qXpacF5c0weZQocH/h3Mp2BxcLFdM
         vnPht0cbYsDRGYTtMoYTAQqnNDu1VL+gV98GawKbjEbobcAnyPGdjYSqd1W7ISnHvpas
         e4MmzibRMbsYMwmKdrl0jnMff9TYzCStt9DZOvVffqzi0ed/bN+IO/LlbKPNLuXuvogv
         RmHQ==
X-Gm-Message-State: AGRZ1gKWkvL3srEpi7VsHeDboNXvgrBqrVgfxqyUfoYSfNLUU5xrTHV4
        MDmIFkpYl/3QYvhXKSMq6KoCwg==
X-Google-Smtp-Source: AJdET5dUxpWdSplHEBFcZjCFdV2C09CPaiVAr7qzYUk0UdU5xJmv3dgn3DzCdfwpj0Rvs9dbwCbM0g==
X-Received: by 2002:a6b:c948:: with SMTP id z69mr19510236iof.161.1542640894412;
        Mon, 19 Nov 2018 07:21:34 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id b2-v6sm12890171ioq.78.2018.11.19.07.21.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 07:21:33 -0800 (PST)
Subject: Re: [PATCH 6/7] block: make blk_poll() take a parameter on whether to
 spin or not
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20181117214354.822-1-axboe@kernel.dk>
 <20181117214354.822-7-axboe@kernel.dk> <20181119080544.GF9622@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <04b6015e-2949-750d-01a0-640373b406ea@kernel.dk>
Date:   Mon, 19 Nov 2018 08:21:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181119080544.GF9622@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/19/18 1:05 AM, Christoph Hellwig wrote:
>> -bool blk_poll(struct request_queue *q, blk_qc_t cookie)
>> +bool blk_poll(struct request_queue *q, blk_qc_t cookie, bool spin)
> 
> I find the paramter name a little confusing.  Maybe wait_for_request,
> although I don't particularly like that one either.  But we really need
> to document the parameter well here, no matter what we end up naming
> it.  And we should use a consistent name through the whole stack.

spin_until_found? I don't like using 'wait*' as we're not waiting.

>> index c1ec3475a140..f6971b45bc54 100644
>> --- a/drivers/nvme/target/io-cmd-bdev.c
>> +++ b/drivers/nvme/target/io-cmd-bdev.c
>> @@ -116,7 +116,7 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
>>  
>>  	cookie = submit_bio(bio);
>>  
>> -	blk_poll(bdev_get_queue(req->ns->bdev), cookie);
>> +	blk_poll(bdev_get_queue(req->ns->bdev), cookie, true);
> 
> This opportunistic poll is pretty bogus now as we never set the HIPRI
> flag and it should probably be removed in a prep patch.  We should then
> later try to use a scheme similar to your aio polling for the nvme
> target as well.

I'll kill it in a pre-patch.

-- 
Jens Axboe

