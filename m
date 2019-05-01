Return-Path: <SRS0=aWxv=TB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 716BAC43219
	for <linux-block@archiver.kernel.org>; Wed,  1 May 2019 14:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DBA221743
	for <linux-block@archiver.kernel.org>; Wed,  1 May 2019 14:15:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="KGXeBR11"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbfEAOPf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 May 2019 10:15:35 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:54125 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbfEAOPf (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 May 2019 10:15:35 -0400
Received: by mail-it1-f193.google.com with SMTP id l10so6540160iti.3
        for <linux-block@vger.kernel.org>; Wed, 01 May 2019 07:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Uf9zxJD3nOmFAAA2XsWvLKQfm5aznbbfXuVjOj3vBPg=;
        b=KGXeBR1186hHv+lgxIkcZZH7jzoj2zrJdg5+/wegmdPh+fbyK/u1mq7qZhqnylgIos
         rFCrdluwEIPjRHO/tXwxnqw5k45lExpzbxdFoXC01D34h3I+z38AF0CCKn8p9E2m7Ubg
         PgmaoWSvxi2Uv0wNGZJactewGq49xA8X8Rw3vfW6cQU2M8RkA31u+hcXLIBou/k4NkTi
         3AQY55a4z2i/oNWmcAfW3BlOyV4knnEvCMT1EQ9FDRCg1S00zQDKJH+2Fz/D9saDicIr
         P7eeJGOr2hCcdPNNxvpyHyUwEkI45tGHmNkpTF01gqqmKVyZV2L3lCyg96ChgpXR4co8
         TzCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Uf9zxJD3nOmFAAA2XsWvLKQfm5aznbbfXuVjOj3vBPg=;
        b=Jt9bEmFVh+aBG0h3Kt8QSlMRt5JpeZWUplkCSuGeXLxo3B6fgriE8h/+N8FguM7P05
         YJUFeEUtyMT2wXyL59HYiUAXX6UTB0xtUu6TQvEHFAq3jQWMFeDeCaoAbs0ubZz1WfoR
         0ZQRCLHTWJw3+zUakecr0v8UUEqL/ZASPcw2sR+4tpsIg/4K81I0h0Ok+31RiWfeRdJH
         wefRqgAOABDvMeIzRS9biRTYgenPuGfnw5fJqowRVPunQraneWW/rvqUXZfds0NFFFkd
         nGoH4w/yjOBkd3EXbNyIzUlAqaIVb+CusxoNBS89sb7yaWOFPnhz9KcS86fB9KakcEcG
         4GqQ==
X-Gm-Message-State: APjAAAVDqWZk1ACMvcP2Bbz1tZ84+I9v9dnb0HCpm+jAdMMOMj2zR9cO
        19DberBBsbUDlDJ+4jY+DKSkhw==
X-Google-Smtp-Source: APXvYqwfvLvM/msXkz+gOGNDUFk53nCGYKknhEKcUJC0stOdCTSFgcyU23dVHnV0J1FG9egtpOIfSQ==
X-Received: by 2002:a02:880a:: with SMTP id r10mr27783853jai.67.1556720134814;
        Wed, 01 May 2019 07:15:34 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id t191sm3182738itt.17.2019.05.01.07.15.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 May 2019 07:15:33 -0700 (PDT)
Subject: Re: [PATCH] io_uring: use cpu_online() to check p->sq_thread_cpu
 instead of cpu_possible()
To:     Jeff Moyer <jmoyer@redhat.com>, Shenghui Wang <shhuiw@foxmail.com>
Cc:     viro@zeniv.linux.org.uk, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20190501072430.6674-1-shhuiw@foxmail.com>
 <x49wojaxuaa.fsf@segfault.boston.devel.redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <cd55b1e4-9395-a8b7-707e-ceed9d6c0c15@kernel.dk>
Date:   Wed, 1 May 2019 08:15:33 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <x49wojaxuaa.fsf@segfault.boston.devel.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/1/19 5:56 AM, Jeff Moyer wrote:
> Shenghui Wang <shhuiw@foxmail.com> writes:
> 
>> This issue is found by running liburing/test/io_uring_setup test.
>>
>> When test run, the testcase "attempt to bind to invalid cpu" would not
>> pass with messages like:
>>    io_uring_setup(1, 0xbfc2f7c8), \
>> flags: IORING_SETUP_SQPOLL|IORING_SETUP_SQ_AFF, \
>> resv: 0x00000000 0x00000000 0x00000000 0x00000000 0x00000000, \
>> sq_thread_cpu: 2
>>    expected -1, got 3
>>    FAIL
>>
>> On my system, there is:
>>    CPU(s) possible : 0-3
>>    CPU(s) online   : 0-1
>>    CPU(s) offline  : 2-3
>>    CPU(s) present  : 0-1
>>
>> The sq_thread_cpu 2 is offline on my system, so the bind should fail.
>> But cpu_possible() will pass the check. We shouldn't be able to bind
>> to an offline cpu. Use cpu_online() to do the check.
>>
>> After the change, the testcase run as expected: EINVAL will be returned
>> for cpu offlined.
>>
>> Signed-off-by: Shenghui Wang <shhuiw@foxmail.com>
>> ---
>>  fs/io_uring.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/io_uring.c b/fs/io_uring.c
>> index 0e9fb2cb1984..aa3d39860a1c 100644
>> --- a/fs/io_uring.c
>> +++ b/fs/io_uring.c
>> @@ -2241,7 +2241,7 @@ static int io_sq_offload_start(struct io_ring_ctx *ctx,
>>  	ctx->sqo_mm = current->mm;
>>  
>>  	ret = -EINVAL;
>> -	if (!cpu_possible(p->sq_thread_cpu))
>> +	if (!cpu_online(p->sq_thread_cpu))
>>  		goto err;
>>  
>>  	if (ctx->flags & IORING_SETUP_SQPOLL) {
>> @@ -2258,7 +2258,7 @@ static int io_sq_offload_start(struct io_ring_ctx *ctx,
>>  
>>  			cpu = array_index_nospec(p->sq_thread_cpu, NR_CPUS);
>>  			ret = -EINVAL;
>> -			if (!cpu_possible(p->sq_thread_cpu))
>> +			if (!cpu_online(p->sq_thread_cpu))
>>  				goto err;
>>  
>>  			ctx->sqo_thread = kthread_create_on_cpu(io_sq_thread,
> 
> Hmm.  Why are we doing this check twice?  Oh... Jens, I think you
> braino'd commit 917257daa0fea.  Have a look.  You probably wanted to get
> rid of the first check for cpu_possible.

Added a fixup patch the other day:

http://git.kernel.dk/cgit/linux-block/commit/?h=for-linus&id=362bf8670efccebca22efda1ee5a5ee831ec5efb

-- 
Jens Axboe

