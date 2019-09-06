Return-Path: <SRS0=sY57=XB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C89AC43331
	for <linux-block@archiver.kernel.org>; Fri,  6 Sep 2019 16:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E581C206CD
	for <linux-block@archiver.kernel.org>; Fri,  6 Sep 2019 16:26:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ia9N/Tkg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730858AbfIFQ0V (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 6 Sep 2019 12:26:21 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:33957 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729557AbfIFQ0V (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 6 Sep 2019 12:26:21 -0400
Received: by mail-io1-f65.google.com with SMTP id s21so14085487ioa.1
        for <linux-block@vger.kernel.org>; Fri, 06 Sep 2019 09:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TYNr98of8+in5on9XW6tz20SLhCfZ+SGJ05OSa5BNr4=;
        b=ia9N/TkgVDpzi0usTDyYjsOq1WTcM/IzeYRwaalB/qF3UAzmEe4GKGVcKZhkKaYYHz
         8stJjPdzNtxHnGPkVQb6u9XKo/b33aPrOqyks9hDAjkrLjl8ZuWhQbzou34lcRYJqYHK
         3hTuPB0mp+3h2865ggN9qjcVVo9FvGvcSZdhPqGGwhLPwxsGvH6BwB0AhVL2jIMYQDpd
         1i4or52HRc+fW6Ydh3SnQSWMhSZk4adml9P5RN2OL/NHqq02vmbigWP/GqO66HQCX25a
         qsNAtodjL2QBNm8FzGTfr+RWBdv26Qdgv5YnK+HJfoIusW1NaVY3Szm+bdhCAWmU0V+O
         qE7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TYNr98of8+in5on9XW6tz20SLhCfZ+SGJ05OSa5BNr4=;
        b=F82WzzWhrFxyiRKzijSvN+6wsWC1vEq5wWtxvV2l2+vP9+I3OKAj8LEWQFirJ5EvVf
         0R3vu4WPXAJKVuhPHgLS1KzaS5UM770Fep0lHZ3aZzfIts3wUy41dN0OZqjGhfIRXtnR
         DsfFKzVRDG41sApo65zAs2hKSO5hZYNsrD5Hkol/T14ZjO5Qpujp8kLs3yu/hGMVbkOY
         1xFIbBCmljRqwRFd0Hkq0o8QxB70TSQh8jdbLZXyhUX1IiwpcVKofnwyG1fGfOp5BOAs
         wHzzPe85S5lhN/Jw98cgmQ13A8pDj+x8NwzUR+Sig+t39GnY4+j6gzmiRqzIvzOrwfDl
         fNyg==
X-Gm-Message-State: APjAAAURXGw2KkfoR+lVQJqerd2/rSliHI4TdrBQ71rF0v+ZzU0ceoHW
        qXDehlJogp+SO3S/8oZgny8dVUiqIMV6Yg==
X-Google-Smtp-Source: APXvYqy3fmAluznF4tfOS22HdXNeNekL70tkl5TG0gH8s4FPbzuocc0FvjBhhGFraOb4laKw3E/7RA==
X-Received: by 2002:a6b:c8cf:: with SMTP id y198mr11417513iof.179.1567787179869;
        Fri, 06 Sep 2019 09:26:19 -0700 (PDT)
Received: from [192.168.1.50] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id f7sm4452311ioc.31.2019.09.06.09.26.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Sep 2019 09:26:18 -0700 (PDT)
Subject: Re: [PATCH] io_uring: allocate the two rings together
From:   Jens Axboe <axboe@kernel.dk>
To:     Hristo Venev <hristo@venev.name>
Cc:     linux-block@vger.kernel.org
References: <20190826172346.8341-1-hristo@venev.name>
 <80e0e408-f602-4446-d244-60f9d4ce9c71@kernel.dk>
 <2f409a14ea27516a97cb7a7f1d70de7fe45c7c69.camel@venev.name>
 <dec45613-ab82-24b2-71bb-69693a22ee46@kernel.dk>
Message-ID: <c0ab3b6a-3e30-8a91-512e-aed9218015a7@kernel.dk>
Date:   Fri, 6 Sep 2019 10:26:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <dec45613-ab82-24b2-71bb-69693a22ee46@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/29/19 9:04 AM, Jens Axboe wrote:
> On 8/27/19 1:35 PM, Hristo Venev wrote:
>> Sorry for the duplicate reply, I forgot to CC the mailing list.
>>
>> On Tue, 2019-08-27 at 09:50 -0600, Jens Axboe wrote:
>>> Outside of going for a cleanup, have you observed any wins from this
>>> change?
>>
>> I haven't ran any interesting benchmarks. The cp examples in liburing
>> are running as fast as before, at least on x86_64.
>>
>> Do you think it makes sense to tell userspace that the sq and cq mmap
>> offsets now mean the same thing? We could add a flag set by the kernel
>> to io_uring_params.
> 
> Not sure, there isn't a whole lot of overhead associated with having
> to do two mmaps vs just one.
> 
> If you wanted to, the best approach would be to change one of the
> io_uring_params reserved fields to be a feature field or something
> like that. As features get added, we could flag them there. Then
> the app could do:
> 
> io_uring_setup(depth, &params);
> if (params.features & IORING_FEAT_SINGLE_MMAP)
> 	....
> else
> 	mmap rings individually
> 
> and so forth.

This would do it for the kernel side. I'd suggest integrating the
feature check into liburing, which means that applications get
the optimization for free.

Do you want to do it?


diff --git a/fs/io_uring.c b/fs/io_uring.c
index 17dfe57c57f8..be24596e90d7 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -3391,6 +3391,8 @@ static int io_uring_create(unsigned entries, struct io_uring_params *p)
 	p->cq_off.ring_entries = offsetof(struct io_rings, cq_ring_entries);
 	p->cq_off.overflow = offsetof(struct io_rings, cq_overflow);
 	p->cq_off.cqes = offsetof(struct io_rings, cqes);
+
+	p->features = IORING_FEAT_SINGLE_MMAP;
 	return ret;
 err:
 	io_ring_ctx_wait_and_kill(ctx);
diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index 1e1652f25cc1..96ee9d94b73e 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -128,11 +128,17 @@ struct io_uring_params {
 	__u32 flags;
 	__u32 sq_thread_cpu;
 	__u32 sq_thread_idle;
-	__u32 resv[5];
+	__u32 features;
+	__u32 resv[4];
 	struct io_sqring_offsets sq_off;
 	struct io_cqring_offsets cq_off;
 };
 
+/*
+ * io_uring_params->features flags
+ */
+#define IORING_FEAT_SINGLE_MMAP		(1U << 0)
+
 /*
  * io_uring_register(2) opcodes and arguments
  */

-- 
Jens Axboe

