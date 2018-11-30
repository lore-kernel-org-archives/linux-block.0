Return-Path: <SRS0=+5f8=OJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16874C04EB8
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 17:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCA662145D
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 17:29:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="1O6IX665"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCA662145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbeLAEj6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Nov 2018 23:39:58 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:46434 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbeLAEj6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Nov 2018 23:39:58 -0500
Received: by mail-io1-f65.google.com with SMTP id v10so5131429ios.13
        for <linux-block@vger.kernel.org>; Fri, 30 Nov 2018 09:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=L3ffWXSQfoWYbtHdx3QARGhDzdYYciJiJZaU8ikGqC8=;
        b=1O6IX665MothrtEB2AUHxcOAoN0tw9OgPzarKAn4lLqhg9h1CsyWUrYyEzgcgp/vz7
         xSvrAl/bVMnrz0t+VbwwHMpcULcOWGA7gxPAGh9TGIGtSwPlBKVjV8AP3NBXzY7xyjKE
         c2RBVRIMM7RNoffajJU2YEO61x2KKuhDwVa7Nyx507QEcarzZrZ8aHmlG7pWdvXHzymi
         zzVlvQQNjHYHk7ou9fubry+q/FN++hXe0MmHwMV4PXfsR9Zf1neewbPxyh9I2NXQdV96
         PE16Nzy/SNmTcmSQAjaOXV9dssdje2JBS7WubVnPOFbb8iZmSVsYl1rv/H23olTKvkF/
         MITw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=L3ffWXSQfoWYbtHdx3QARGhDzdYYciJiJZaU8ikGqC8=;
        b=JZP1ceMEKiykSmm78umwAUdAQKs5GnyTDKOWIJy8nCH/DaMrS3mTxtgWHdiEfUFw17
         Je4yCk8jrd51Bjm2ggblPr9XVGLtm/hs9JkUXgaIX5o3FjvoLrBoXSn6O7ENsgLSPlQr
         thC2Zbud8doEawDj1IZBjx0u+C05gtCdCtpLyZ5yEEzmLCzgsulmojJFmBI+j0eWalOE
         nNjX0juJBPBFr4gWfqCirkXJon/llM4CAgYTN8Jm5vUAXlCf+0y7x+PTi5cBgIX8Lgvb
         bEScxhQ+lMLLRXnmh3sdcLd/5utERwBespTiW+bZ7li5AsYyOmmIrVqSEzCfbOG1T2P4
         CvZQ==
X-Gm-Message-State: AA+aEWZNfnf9SY3Yd/tUQELpS1L3WKjIlM/3sREJojpbcA2ErUAEgQCa
        GcZBdNOfSVW9/Ld9/gVz9EW/Whh0uU4=
X-Google-Smtp-Source: AFSGD/Ui/ORzm5DtjtKpn5WtgV/uBUJ/a2kH5DCnccDKk7jviuaeSW4KimtKWw6jIdCrQCeDQ14ikg==
X-Received: by 2002:a6b:900b:: with SMTP id s11mr5578490iod.159.1543598996399;
        Fri, 30 Nov 2018 09:29:56 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id 125sm2646965itk.28.2018.11.30.09.29.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 09:29:55 -0800 (PST)
Subject: Re: [PATCH] blk-mq: don't call ktime_get_ns() if we don't need it
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <51a1cb7b-6136-a220-6cac-9bccd2262ca3@kernel.dk>
 <20181130172704.GA16952@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2f4b6ca1-23e5-b7fd-286a-e3a76cfc411e@kernel.dk>
Date:   Fri, 30 Nov 2018 10:29:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181130172704.GA16952@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/30/18 10:27 AM, Christoph Hellwig wrote:
> On Fri, Nov 30, 2018 at 08:56:25AM -0700, Jens Axboe wrote:
>> We only need the request fields and the end_io time if we have stats
>> enabled, or if we have a scheduler attached as those may use it for
>> completion time stats.
>>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>> ---
>>  block/blk-mq.c | 13 ++++++++++---
>>  1 file changed, 10 insertions(+), 3 deletions(-)
>>
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index 7dcef565dc0f..2b458e9da946 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -316,7 +316,8 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
>>  	RB_CLEAR_NODE(&rq->rb_node);
>>  	rq->rq_disk = NULL;
>>  	rq->part = NULL;
>> -	rq->start_time_ns = ktime_get_ns();
>> +	if (data->q->elevator)
>> +		rq->start_time_ns = ktime_get_ns();
> 
> We also seem to use start_time_ns it in blk_account_io_done.

But only if RQF_STATS is set, in which case we are passing it in correctly.

> Also update it in attempt_merge, which might have some odd results
> for completly uninitialized fields.

I did notice these, but it's pointless to change those, as you'd then have
to check validity. Nobody cares at that point...

-- 
Jens Axboe

