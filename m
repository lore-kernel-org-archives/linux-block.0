Return-Path: <SRS0=/PDd=CJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0EDDC2BB4D
	for <linux-block@archiver.kernel.org>; Mon, 31 Aug 2020 15:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF82B214D8
	for <linux-block@archiver.kernel.org>; Mon, 31 Aug 2020 15:34:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="vh6lmpO7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728421AbgHaPeB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 31 Aug 2020 11:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728418AbgHaPd6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 31 Aug 2020 11:33:58 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0205C061573
        for <linux-block@vger.kernel.org>; Mon, 31 Aug 2020 08:33:57 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id r9so964237ioa.2
        for <linux-block@vger.kernel.org>; Mon, 31 Aug 2020 08:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=m0rQ/ub226fBny9vG0kZi/Vs8RNhImSClI5T0Qu7I14=;
        b=vh6lmpO7Hu/RsGaLbOa0XLE9dyXi9bkRBum5mD/r5Ca1vx6J3v3wEZk6qbLzyw3h3H
         9E0kDOltEzaYDZqk/gfjN15M7bg1ttpN208EgMvO2sqDbvGYTbJnVFZOtSNy8vmWmtfF
         67pBvUrVCrrIlzJ/MdVi77pWzHOZy2/jgJl8uFd0gBeNcEnswb5oJaVjkqASUh+IxcJD
         pbrb8/rQNwTRTKvB1QLbIGcCGyRPrh9mUUAGbow00rOdnDxgV6bbUsqMgFz+tVhmlCaE
         /9hBbL2wD0R1tmdoR3KeOYOaMjBXU/z1m5eYKGGC9tyvaZgo+dXSBuhztZbO+ExvD989
         kwIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=m0rQ/ub226fBny9vG0kZi/Vs8RNhImSClI5T0Qu7I14=;
        b=IzQaWXc4V3o86Mbi+Fxryba1GQVITXoKasCMBeJUSLgWEhSHj3ZSfdZki1ucNqEDxS
         FfvcAHLM3ud+LHJosq93MutMnCjO+DIpFjQvqplJCmnwXVxmggkNL0RpKGN02AJzBXx/
         ejLnEsq3is2hUpAZQQICgmkXpE91ZJ326CD4jl8/1Fvp8GuuSzQTawmRFTgObIst8xDJ
         qw7AJBlpA/0j+wLDzkgDjohFeJU6cFga4sn1IlIlnk39K9m0nPQJt4pFd4FZhEYbotHT
         tottP7Uw4QbxKgC/yfn+cHv/f3bJmpRJTUJsWlAFc6uWWbpXw++OJoY1JG0zK5sHglyu
         /snA==
X-Gm-Message-State: AOAM532kg7ynrl3wzorCKcTRV+l/TpTBQT/LFhdj68gAgN6U4ubmzPC+
        ZvO8UTTHsNIRQEggY7kI6CFi1zYgQ9Uaqvm+
X-Google-Smtp-Source: ABdhPJzsu4t7oycxwDXSaEx6yM40Ebp9l9oA1+Ybajl1a9i2xRnluudoC1X2vO7M/b6OXYX5KIlUOg==
X-Received: by 2002:a6b:ec17:: with SMTP id c23mr1757349ioh.186.1598888037003;
        Mon, 31 Aug 2020 08:33:57 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id k11sm4151123iof.40.2020.08.31.08.33.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2020 08:33:56 -0700 (PDT)
Subject: Re: [PATCH] block: Fix inflight statistic for MQ submission with
 !elevator
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     linux-block@vger.kernel.org, kernel@collabora.com
References: <20200831153127.3561733-1-krisman@collabora.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7a4669a1-7633-6acc-e06d-86992245dfee@kernel.dk>
Date:   Mon, 31 Aug 2020 09:33:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200831153127.3561733-1-krisman@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/31/20 9:31 AM, Gabriel Krisman Bertazi wrote:
> According to Documentation/block/stat.rst, inflight should not include
> I/O requests that are in the queue but not yet dispatched to the device,
> but blk-mq identifies as inflight any request that has a tag allocated,
> which, for queues without elevator, happens at request allocation time
> and before it is queued in the ctx (default case in blk_mq_submit_bio).
> 
> A more precise approach would be to only consider requests with state
> MQ_RQ_IN_FLIGHT.

We've had some churn here, last change in this area was:

commit 6131837b1de66116459ef4413e26fdbc70d066dc
Author: Omar Sandoval <osandov@fb.com>
Date:   Thu Apr 26 00:21:58 2018 -0700

    blk-mq: count allocated but not started requests in iostats inflight

which your patch basically just reverts. So more testing/explanation
needed on why it's necessary.

-- 
Jens Axboe

