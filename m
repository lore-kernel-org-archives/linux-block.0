Return-Path: <SRS0=cawq=TY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C618EC072B5
	for <linux-block@archiver.kernel.org>; Fri, 24 May 2019 09:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8989B2175B
	for <linux-block@archiver.kernel.org>; Fri, 24 May 2019 09:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nBmvoo6/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389542AbfEXJGb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 May 2019 05:06:31 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:32886 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389515AbfEXJGb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 May 2019 05:06:31 -0400
Received: by mail-lj1-f196.google.com with SMTP id w1so8028824ljw.0;
        Fri, 24 May 2019 02:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=pMU63N90N2a6pXKwvYAZ7NGX7dlAMOWlTR4hVN71d+g=;
        b=nBmvoo6/aJfUJvIX7emFQp1qUTY/CPD2o5Sf9M/ecdwDcNGFOMTCIcf7dbb9BK8e3N
         7JK3jiAIK6ETrgigaKn4XgxN4VpcNZRLdtawy7ftvEUUfsNb4dNu8Hy84sAE+68H6yg3
         E72Okv2SpISabzjT/Z/MGaGQODbsTg+acHGfhMQePDApbBvcaKt++QCrqfX1+kHlPiJS
         x21xalFnqurGpbb1jlzpYwx9+UjOscmghnFxafukjxFutTcdZR2ZYgSw69lTu0aUWOz7
         78WfA+bRROnwJTXkUNGqCX3KSjkDnuLrIMXvaYzz3s9giWCawojVESQYXKaGS954qB9c
         uoxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pMU63N90N2a6pXKwvYAZ7NGX7dlAMOWlTR4hVN71d+g=;
        b=n/JekZstzhlZLLXWlb+doQccd/Oljzi7YLsz9rdLGkmotpuTvWAh6qr1M9/IFWnxtG
         Cat0bPmTvbAAfH0NPFcz4TFmL67uZ1BorZhFLUQZkTJwN+7rsKf68gMfRdd0FbmmIqlO
         fMLhnrCSAu1tVXZcaD2u+hLNs1HZWLQu1MW9xjdx74t3kKV2f8Z4jzXYJWMxijg7i+zg
         7tAaArYd7RnvGu/VZhjlURtROiG4yMiBZP1Xk7jIyrNBYK9edAWl4rogrpb3OjHLbHMm
         4DbIrNiktahg2WQ5XSFty+HNGcAqd+j3mbhBlfaklh0eG/xQT6bpYbLBa/hDg7v3tNuQ
         3iAA==
X-Gm-Message-State: APjAAAXmklDf5oGAmcl0Kz6QTzq8ZBFqnaXPoYlJN6dWEdkwEE6Xx5uP
        Q4ZQaiPZTWmtB51lmT89H6PBvRg4fcg=
X-Google-Smtp-Source: APXvYqy+y8pjWQek9mnm9deUaxlaSK4qdqmtS4i37KxBnt4vxKxFyj8DuOWLnjawJUkYN8ZDmJ5/2w==
X-Received: by 2002:a2e:6a01:: with SMTP id f1mr51154780ljc.21.1558688789118;
        Fri, 24 May 2019 02:06:29 -0700 (PDT)
Received: from [172.31.190.215] ([86.57.146.226])
        by smtp.gmail.com with ESMTPSA id n8sm480034lfe.15.2019.05.24.02.06.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 02:06:28 -0700 (PDT)
Subject: Re: [PATCH 0/7] Adjust hybrid polling sleep time
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1556609582.git.asml.silence@gmail.com>
From:   Pavel Begunkov <asml.silence@gmail.com>
Message-ID: <28d729ed-1112-501a-a5d4-6d53d6432113@gmail.com>
Date:   Fri, 24 May 2019 12:06:14 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <cover.1556609582.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Any suggestions?

You might also want to consider (and hopefully apply) the first 3
separately as they are bug fixes. (e.g. hybrid polling turned out to be
disabled).
Would it be better for me to split the patchset?


On 4/30/2019 10:34 AM, Pavel Begunkov (Silence) wrote:
> From: Pavel Begunkov <asml.silence@gmail.com>
> 
> Sleep time for adaptive hybrid polling is coarse and can be improved to
> decrease CPU load. Use variation of the 3-sigma rule and runtime
> tuning.
> 
> This approach gives up to 2x CPU load reduction keeping the same latency
> distribution and throughput.
> 
> Pavel Begunkov (7):
>   blk-iolatency: Fix zero mean in previous stats
>   blk-stats: Introduce explicit stat staging buffers
>   blk-mq: Fix disabled hybrid polling
>   blk-stats: Add left mean deviation to blk_stats
>   blk-mq: Precalculate hybrid polling time
>   blk-mq: Track num of overslept by hybrid poll rqs
>   blk-mq: Adjust hybrid poll sleep time
> 
>  block/blk-core.c          |   7 +-
>  block/blk-iolatency.c     |  60 ++++++++++----
>  block/blk-mq-debugfs.c    |  14 ++--
>  block/blk-mq.c            | 163 ++++++++++++++++++++++++++++----------
>  block/blk-stat.c          |  67 +++++++++++++---
>  block/blk-stat.h          |  15 +++-
>  include/linux/blk_types.h |   9 +++
>  include/linux/blkdev.h    |  17 +++-
>  8 files changed, 271 insertions(+), 81 deletions(-)
> 

-- 
Yours sincerely,
Pavel Begunkov
