Return-Path: <SRS0=4xm9=X2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F12C352AA
	for <linux-block@archiver.kernel.org>; Tue,  1 Oct 2019 15:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98EA32133F
	for <linux-block@archiver.kernel.org>; Tue,  1 Oct 2019 15:38:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="WiIT9lAW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389588AbfJAPiq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Oct 2019 11:38:46 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:37315 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388916AbfJAPip (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Oct 2019 11:38:45 -0400
Received: by mail-io1-f68.google.com with SMTP id b19so21007480iob.4
        for <linux-block@vger.kernel.org>; Tue, 01 Oct 2019 08:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=x4oki5zqaQqD9Lw/LHfcoqYFe2cd/ERA90a/rseIBMo=;
        b=WiIT9lAWvLNqkJPLDmK3wtxUBnf7YlD0Y/kELsZ+76TlnDPSyvunE5wo0RbyKXRFQa
         q5XkTSz7HmMAj2RYgO68VYiCeT4dPWF9dFle0DmUC+RRFWbiqODHQKrf6ih1DOQmL6VS
         9As5ceqbUSx+qr7H1jLjg1uiMSRImQoyzxisdZcAuM6EPQsnNGcvPq442sxIo4wtMvR4
         hEJCIm2A/RAc8xGf197TveBDYPhwudyteTXmi6+ZT4JdJPLzmQvKfMh+wCMgOB/F4ozv
         dib8PFFKWS0wJQNjaZVYrDfvDvdpjICYt5QmdIxLfh0PELHRPwnfMu2bXy85jgG/ND9Y
         /2Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=x4oki5zqaQqD9Lw/LHfcoqYFe2cd/ERA90a/rseIBMo=;
        b=R+OaTC2/D3k2UlwP5ImHL7BXn0DAGBL/ttnDagfXlbIwXpLqgWOtNJUFn4mM5NRAkN
         qvCkZFr4Jh1gKiSzZNx8ZHaNRSnflnnx1wc60zjVVe7FAneTb1mN+is0pDqPJaMTBncG
         R7rMI1jRyIkQXVz75gmDZC0oW9AZynHonM1PSVAfr3IvRaubOeEgSPNOVDqzI3fhxoHx
         seyGmMSf8XXpDDOdCvZJoNPNxdc38UCfU6TomcmatSUWAxRk6hSBVhl5zFYnsYx93WRX
         Ul1OyG4OkaqffDwrCuDnzWtjt2tsJgEA/KpPpKpd1W6XHP6sjI761H5vYHmbHI0idIAi
         ayDQ==
X-Gm-Message-State: APjAAAXekrW0rXeckZRbMw5yPk0FQQKDbJi2bXs5TVPEzhU2ck85ROXc
        p/vjbGbSkgsG+P6uVApYRkMcIQ==
X-Google-Smtp-Source: APXvYqwx+6EDi1cZu8EVpD4waPECZ30FL4SJH4ERBjWjw+ax3CYgRlOg/ieHHI4DCViinpHplbgtRg==
X-Received: by 2002:a6b:9107:: with SMTP id t7mr11078862iod.150.1569944322839;
        Tue, 01 Oct 2019 08:38:42 -0700 (PDT)
Received: from [192.168.1.50] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id t24sm7118469ioi.44.2019.10.01.08.38.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Oct 2019 08:38:41 -0700 (PDT)
Subject: Re: [PATCH] io_uring: use __kernel_timespec in timeout ABI
From:   Jens Axboe <axboe@kernel.dk>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     y2038@lists.linaro.org, linux-api@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        =?UTF-8?Q?Stefan_B=c3=bchler?= <source@stbuehler.de>,
        Hannes Reinecke <hare@suse.com>,
        Jackie Liu <liuyun01@kylinos.cn>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hristo Venev <hristo@venev.name>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190930202055.1748710-1-arnd@arndb.de>
 <8d5d34da-e1f0-1ab5-461e-f3145e52c48a@kernel.dk>
Message-ID: <623e1d27-d3b1-3241-bfd4-eb94ce70da14@kernel.dk>
Date:   Tue, 1 Oct 2019 09:38:40 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <8d5d34da-e1f0-1ab5-461e-f3145e52c48a@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/1/19 8:09 AM, Jens Axboe wrote:
> On 9/30/19 2:20 PM, Arnd Bergmann wrote:
>> All system calls use struct __kernel_timespec instead of the old struct
>> timespec, but this one was just added with the old-style ABI. Change it
>> now to enforce the use of __kernel_timespec, avoiding ABI confusion and
>> the need for compat handlers on 32-bit architectures.
>>
>> Any user space caller will have to use __kernel_timespec now, but this
>> is unambiguous and works for any C library regardless of the time_t
>> definition. A nicer way to specify the timeout would have been a less
>> ambiguous 64-bit nanosecond value, but I suppose it's too late now to
>> change that as this would impact both 32-bit and 64-bit users.
> 
> Thanks for catching that, Arnd. Applied.

On second thought - since there appears to be no good 64-bit timespec
available to userspace, the alternative here is including on in liburing.
That seems kinda crappy in terms of API, so why not just use a 64-bit nsec
value as you suggest? There's on released kernel with this feature yet, so
there's nothing stopping us from just changing the API to be based on
a single 64-bit nanosecond timeout.

diff --git a/fs/io_uring.c b/fs/io_uring.c
index dd094b387cab..de3d14fe3025 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -1892,16 +1892,13 @@ static int io_timeout(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 	unsigned count, req_dist, tail_index;
 	struct io_ring_ctx *ctx = req->ctx;
 	struct list_head *entry;
-	struct timespec ts;
+	u64 timeout;
 
 	if (unlikely(ctx->flags & IORING_SETUP_IOPOLL))
 		return -EINVAL;
 	if (sqe->flags || sqe->ioprio || sqe->buf_index || sqe->timeout_flags ||
 	    sqe->len != 1)
 		return -EINVAL;
-	if (copy_from_user(&ts, (void __user *) (unsigned long) sqe->addr,
-	    sizeof(ts)))
-		return -EFAULT;
 
 	/*
 	 * sqe->off holds how many events that need to occur for this
@@ -1932,9 +1929,10 @@ static int io_timeout(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 	list_add(&req->list, entry);
 	spin_unlock_irq(&ctx->completion_lock);
 
+	timeout = READ_ONCE(sqe->addr);
 	hrtimer_init(&req->timeout.timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	req->timeout.timer.function = io_timeout_fn;
-	hrtimer_start(&req->timeout.timer, timespec_to_ktime(ts),
+	hrtimer_start(&req->timeout.timer, ns_to_ktime(timeout),
 			HRTIMER_MODE_REL);
 	return 0;
 }

-- 
Jens Axboe

