Return-Path: <SRS0=RPGG=PR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D646BC43387
	for <linux-block@archiver.kernel.org>; Wed,  9 Jan 2019 16:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A63C6206BA
	for <linux-block@archiver.kernel.org>; Wed,  9 Jan 2019 16:56:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="qnJ2dEBK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbfAIQ4N (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Jan 2019 11:56:13 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:39695 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbfAIQ4N (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Jan 2019 11:56:13 -0500
Received: by mail-it1-f196.google.com with SMTP id a6so11982755itl.4
        for <linux-block@vger.kernel.org>; Wed, 09 Jan 2019 08:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Obvhgsmnx81N9i1fZJwJJyKTe/UDzFCnl1ec//ZZjfw=;
        b=qnJ2dEBKcK+xn++UaLTnzPvIJTNvu/EeatOmtCQgvO2l5zLNXPeVAbKiMWx/d/B8cW
         U9Mpn65tqm9sinLaIbtBW8l/GBUr6NUp3BV4+HxSwnI/0c1JaVB8g7WgEHwaAn/IOIVY
         akzTm1ei4iOh/uGcMLHgEUAfmp6KDybSnnJNWqLhCaPpOqmW6wn+1Tk9bg/ff4nQ//3b
         j+QK7ZvEShNua4xnsJuCH425CMsG3fAqjfv8F6UMqZvzUG/qMuw+ytbYlU7OywI5VjXQ
         1vM49oMJflPhseplybnHEGxMOYwkL+hy6j2IfJjhcbxb1NZcDO8lKVqbCfRsYQQlgsh6
         zErg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Obvhgsmnx81N9i1fZJwJJyKTe/UDzFCnl1ec//ZZjfw=;
        b=GwOn5K7LAP5SESiv0sodyLCGwUfuW2rArgCiyv7Q6Rk5un7Z0HAix6lz0U68jygiPq
         JWI3tFmB3OdWK01B+1ta/yezMzoKqfFlRpsde4+6oFWxqXLjopKrK9J2iYcuw4bNGn6t
         FgSQeW46G9q1tn6s5WDKyKMwPDaLVcOksGQsRFf60RdwbjILjttG9MypxZfzeB8hLTPT
         jNC0oblcTtorLEeI3vyuwv3GOhWYFZgC0hCTOSXUKp/8xjoZt36AL4PdTBZEnHgU37jg
         GpAnjB+dun196BmiceUbJqoJDJjAPLlgd+n07QVNUqdtu/ShP4tUfA1NcLFbBnMGYAir
         UMqA==
X-Gm-Message-State: AJcUukdOWGSElPZDiAgaf7Gc3eZPNwxn4DENVcWayLXwcNLQ5+OubhtN
        1rYIy46I543/HAK0HK1cnbWM4oKvhgjLAw==
X-Google-Smtp-Source: ALg8bN4N8QYKlzx0WXK7NRskhmvQ+2/qAphrWfWzNE6SHXvsQ/Mq63yv7h1PpcNxD9oYg3w9FVe0kw==
X-Received: by 2002:a02:8904:: with SMTP id o4mr4452128jaj.35.1547052972552;
        Wed, 09 Jan 2019 08:56:12 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id m11sm9250496itb.24.2019.01.09.08.56.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jan 2019 08:56:11 -0800 (PST)
Subject: Re: [PATCH 10/16] io_uring: split kiocb init from allocation
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org, linux-arch@vger.kernel.org,
        jmoyer@redhat.com, avi@scylladb.com
References: <20190108165645.19311-1-axboe@kernel.dk>
 <20190108165645.19311-11-axboe@kernel.dk> <20190109121250.GC13779@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7623e628-28eb-bddf-14e7-f6bf91d639bf@kernel.dk>
Date:   Wed, 9 Jan 2019 09:56:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190109121250.GC13779@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/9/19 5:12 AM, Christoph Hellwig wrote:
> On Tue, Jan 08, 2019 at 09:56:39AM -0700, Jens Axboe wrote:
>> In preparation from having pre-allocated requests, that we then just
>> need to initialize before use.
>>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>> ---
>>  fs/io_uring.c | 13 +++++++++----
>>  1 file changed, 9 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/io_uring.c b/fs/io_uring.c
>> index afbaebb63012..11d045f0f799 100644
>> --- a/fs/io_uring.c
>> +++ b/fs/io_uring.c
>> @@ -202,6 +202,14 @@ static struct io_uring_event *io_peek_cqring(struct io_ring_ctx *ctx)
>>  	return &ring->events[tail & ctx->cq_ring.ring_mask];
>>  }
>>  
>> +static void io_req_init(struct io_ring_ctx *ctx, struct io_kiocb *req)
>> +{
>> +	percpu_ref_get(&ctx->refs);
>> +	req->ki_ctx = ctx;
>> +	INIT_LIST_HEAD(&req->ki_list);
>> +	req->ki_flags = 0;
> 
> We still only have a single caller of this in the final tree, and
> I don't think this function helps.  So I'd just drop the patch.

Dropped

-- 
Jens Axboe

