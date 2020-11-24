Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8DE3C63798
	for <linux-block@archiver.kernel.org>; Tue, 24 Nov 2020 15:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63BA6206D8
	for <linux-block@archiver.kernel.org>; Tue, 24 Nov 2020 15:30:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="08jMZAO1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389651AbgKXPaa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 Nov 2020 10:30:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388503AbgKXPaa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Nov 2020 10:30:30 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD299C0617A6
        for <linux-block@vger.kernel.org>; Tue, 24 Nov 2020 07:30:28 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id q10so18839818pfn.0
        for <linux-block@vger.kernel.org>; Tue, 24 Nov 2020 07:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eMDUIiphwgQu/Rl/7QXTUEvd8hL5aoXhajraaKwKCps=;
        b=08jMZAO19NC9YGv7ez1yKZVfbZHhH83VeOXbl5BSm1jpFljRj8AfKYBbquA1RFDkPd
         VlraeOIrzu9B5B6/lgakO3mOkna3BHnN3ELg+Z6NC9l5pqZ9HFTP5TPyAEILiEZW9Ucd
         fftOP2GSFWUomHxVtCLr//vdPyaFZafYwCwkvKrjXwT/VeVcTEahuhW7V6ppBKxUDPUI
         PlNZSAZ6RMMC6ayPh9uaYs4fF7QgyMrGLbf80wTTczF/nZjKeQ3ePt0cJeg7IFzSmeim
         6doUr62NdtL/CXelB9IFsVHFom1ra/hsQoRcja0CZdnKBUDdb03bP3h3dRCfvJAqh1bi
         ibSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eMDUIiphwgQu/Rl/7QXTUEvd8hL5aoXhajraaKwKCps=;
        b=rGaF4bl20P8HPQ5+QaQoZjkMOI9Vm8RFooBiI2LsBwPBjeThlxcGH9IxWyqSuFAxFD
         I41UhUuCKZEK3o1PgYsASbksqUP2tFXcdi2MBtgqEj/dPk1zBv1r0hQpKXuoO6UTJYHs
         z9X434iyEhAMemXI4YV64qQQ5k9zJog8VuBPZ4kWqlXP9/ZR8fHYRwwFpT43/vBJTeoR
         o+412hk2VxaTff+I/Yl3K8rIm9pVA71FJgYn3YxnMZX9JampznkzAr5beTXj6I8s6USA
         KF46a6sPjbU/dj0wiVYDfn55oN1lA85Wh/Ku9yJEPugZMmHIWllScVhBOeMm7iur7sRp
         LXKw==
X-Gm-Message-State: AOAM532Gl3WhqBLMNEf+5qtGC063Or15gzv6llaf0/2CBrhgcywstC3Q
        Ukf812xiMc7OYdh9bw11pj+hBg==
X-Google-Smtp-Source: ABdhPJzgTdOGgxS19PCgtmRGESJ4KGJeMYsFILdAGpKHr15AmdL2UFHLUgRjeSs+TeBNwaQM8zLKLQ==
X-Received: by 2002:a17:90a:4601:: with SMTP id w1mr5612148pjg.109.1606231828348;
        Tue, 24 Nov 2020 07:30:28 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id ne22sm3574644pjb.45.2020.11.24.07.30.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2020 07:30:27 -0800 (PST)
Subject: Re: [PATCH 01/29] iov_iter: Switch to using a table of operations
To:     David Howells <dhowells@redhat.com>,
        Pavel Begunkov <asml.silence@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <74f6fb34-c4c2-6a7e-3614-78c34246c6bd@gmail.com>
 <20201123080506.GA30578@infradead.org>
 <160596800145.154728.7192318545120181269.stgit@warthog.procyon.org.uk>
 <160596801020.154728.15935034745159191564.stgit@warthog.procyon.org.uk>
 <516984.1606127474@warthog.procyon.org.uk>
 <1155891.1606222222@warthog.procyon.org.uk>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5b8ce555-7451-d977-22e7-e5d080ef2e1a@kernel.dk>
Date:   Tue, 24 Nov 2020 08:30:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1155891.1606222222@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/24/20 5:50 AM, David Howells wrote:
> Pavel Begunkov <asml.silence@gmail.com> wrote:
> 
>> fio is relatively heavy, I'd suggest to try fio/t/io_uring with nullblk
> 
> no patches:

Here's what I get. nullb0 using blk-mq, and submit_queues==NPROC.
iostats and merging disabled, using 8k bs for t/io_uring to ensure we
have > 1 segment. Everything pinned to the same CPU to ensure
reproducibility and stability. Kernel has CONFIG_RETPOLINE enabled.

5.10-rc5:
IOPS=2453184, IOS/call=32/31, inflight=128 (128)
IOPS=2435648, IOS/call=32/32, inflight=64 (64)
IOPS=2448544, IOS/call=32/31, inflight=96 (96)
IOPS=2439584, IOS/call=32/31, inflight=128 (128)
IOPS=2454176, IOS/call=32/32, inflight=32 (32)

5.10-rc5+all patches
IOPS=2304224, IOS/call=32/32, inflight=64 (64)
IOPS=2309216, IOS/call=32/32, inflight=32 (32)
IOPS=2305376, IOS/call=32/31, inflight=128 (128)
IOPS=2300544, IOS/call=32/32, inflight=128 (128)
IOPS=2301728, IOS/call=32/32, inflight=32 (32)

which looks to be around a 6% drop.

Using actual hardware instead of just null_blk:

5.10-rc5:
IOPS=854163, IOS/call=31/31, inflight=101 (101)
IOPS=855495, IOS/call=31/31, inflight=117 (117)
IOPS=856118, IOS/call=31/31, inflight=100 (100)
IOPS=855863, IOS/call=31/31, inflight=113 (113)
IOPS=856282, IOS/call=31/31, inflight=116 (116)

5.10-rc5+all patches
IOPS=833391, IOS/call=31/31, inflight=100 (100)
IOPS=838342, IOS/call=31/31, inflight=100 (100)
IOPS=839921, IOS/call=31/31, inflight=105 (105)
IOPS=841607, IOS/call=31/31, inflight=123 (123)
IOPS=843625, IOS/call=31/31, inflight=107 (107)

which looks to be around 2-3%, but we're also running at a much
slower rate (830K vs ~2.3M).

-- 
Jens Axboe

