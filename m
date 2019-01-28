Return-Path: <SRS0=89dG=QE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F23C6C282C8
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 16:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C28A82084C
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 16:46:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="D3ISQ97j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389084AbfA1QqV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:46:21 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:53213 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388649AbfA1QqU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Jan 2019 11:46:20 -0500
Received: by mail-it1-f193.google.com with SMTP id d11so21556858itf.2
        for <linux-block@vger.kernel.org>; Mon, 28 Jan 2019 08:46:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/SHCNad2OK3tzpEtHidgNy8N/+erZJ2GM2ZG4pIiafQ=;
        b=D3ISQ97j8I9Zr4MNerdOawO9AIGnS9m/LvIruDA2+pnsbL8FmHgmmICRprc+6iCSgb
         CrCvXSkDJhEhsCMaCsc0NO2gRCzGkKFUjUgiHx3wt1vzZwjDphvn/AjKD4tXhLkf/uB/
         KGMIoWEQ7pxNMqFWst31a9a1SMcn7pQnfQDn2CMS3B4Idqwy/mLGsgUJYutUJCsci6lf
         RBn9Mlkt3FWUd05FJgJ89aWKIxx6PgmpTE8JZke1qLztB+ubykyMfs9/n2lU/Z7pLkOu
         JatvbdRLvCvU4NvcomqZ3YidTHcFOS4cesp4y1MgYWQtoG1pGLWUazWSpNGxHkJbqT0l
         IQ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/SHCNad2OK3tzpEtHidgNy8N/+erZJ2GM2ZG4pIiafQ=;
        b=M12roH8yRM6ixsg93911hJWOhzWnbPRFqyk5auFlLkB7wPdg5WB2UpxKpCrYpOXtG0
         ZqG15T4u/6e1s20HE5fupAan1AxmBW5URz8XyaNM6KPd1UOBdSNUedFFe7JSyEAMt3OS
         YqBrwpIxrd2Cwvtuyg7og7BiHMzfod+LzJ+TcPl/i58Rw+TobZQJw8gc0m4ki2Ljy9Z2
         krrqAsxmJt8chsM+A4C87bH8z6rnsbrcmI9JIfG/EnsXmTaDtnq0Agp4huK13FjqiwK9
         kjbvZVwG8Zs7L0kBNCQGm+5A1ZD4XZA8PDEqdwQBDYjNmN2FoVeTuHINtGyO43Ry7hCt
         8ZGw==
X-Gm-Message-State: AHQUAuZu4MRElgRdPWc0fvJ7t/vmkxf3wbbbtGzegUGRLr5ouY3XNh3W
        kcdYiz6SxjwU2Xqy5MWh4gD99A==
X-Google-Smtp-Source: ALg8bN4SMohVxfMm2GXkJULwHDol5yCZrr2W/jYjDXsb71k1vZJYqBJMCpalEtz3WL1GTCHQFGaovg==
X-Received: by 2002:a24:4016:: with SMTP id n22mr12227617ita.25.1548693979266;
        Mon, 28 Jan 2019 08:46:19 -0800 (PST)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id 81sm911972itz.23.2019.01.28.08.46.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 08:46:18 -0800 (PST)
Subject: Re: [PATCH 07/18] io_uring: support for IO polling
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org, jmoyer@redhat.com, avi@scylladb.com
References: <20190123153536.7081-1-axboe@kernel.dk>
 <20190123153536.7081-9-axboe@kernel.dk> <20190128150240.GA10110@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <faca4aec-bf73-bece-6509-46137c7b7b44@kernel.dk>
Date:   Mon, 28 Jan 2019 09:46:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190128150240.GA10110@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/28/19 8:02 AM, Christoph Hellwig wrote:
>>  	struct {
>>  		spinlock_t		completion_lock;
>> +		unsigned		poll_multi_file;
> 
> This seems to be used as a bool.

Fixed

>> -static void __io_cqring_add_event(struct io_ring_ctx *ctx, u64 ki_user_data,
>> -				  long res, unsigned ev_flags)
>> +static void io_cqring_fill_event(struct io_ring_ctx *ctx, u64 ki_user_data,
>> +				 long res, unsigned ev_flags)
>>  {
>>  	struct io_uring_cqe *cqe;
>>  
>> @@ -206,9 +213,15 @@ static void __io_cqring_add_event(struct io_ring_ctx *ctx, u64 ki_user_data,
>>  		cqe->user_data = ki_user_data;
>>  		cqe->res = res;
>>  		cqe->flags = ev_flags;
>> -		io_commit_cqring(ctx);
>>  	} else
>>  		ctx->cq_ring->overflow++;
>> +}
> 
> Maybe we should have created this low-level helper already in the
> patch introducing the code?

I think that can go both ways. If we create it early, it'll just be a
pointless helper. Don't really care too much about this particular case.

-- 
Jens Axboe

