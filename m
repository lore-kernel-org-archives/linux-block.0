Return-Path: <SRS0=RRdq=EE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C60BFC55178
	for <linux-block@archiver.kernel.org>; Thu, 29 Oct 2020 07:39:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66BA3218AC
	for <linux-block@archiver.kernel.org>; Thu, 29 Oct 2020 07:39:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="hSnSFvwk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729750AbgJ2HiP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Oct 2020 03:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727785AbgJ2HYx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Oct 2020 03:24:53 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41FDDC0613DD
        for <linux-block@vger.kernel.org>; Wed, 28 Oct 2020 20:24:21 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id w21so1184283pfc.7
        for <linux-block@vger.kernel.org>; Wed, 28 Oct 2020 20:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AY99dTIR5xArErdJb7TTxISTHPHzPEm/KGv1Gl4W14k=;
        b=hSnSFvwkbnPSUgRhzeq/qL3lercy+HgDC6ejmSpBwXjXL5d26pbs0UaorGYhFMMZm4
         bGpFYYMlAlN0jsNFpRZZ1p7L3kIglpJKaqZ33tbqIwztK2YV8WG+E4kTsEcnJ2Yk0jIR
         7TXewiXPFunRSrt8CClpDImx3ZAEY/xhDiEUOI/gHyA31V4M64ShLRWuOm1uVyr9TAm1
         yDnKvZDO6jw4Zn8LcKqA4osyaxK2X2EAQqAiMJ8zE3fTWSmgpYWU8XkgbZOhdQyTt3XV
         IdUaVMJbJJKWxfAnUa7UiVAk5kKFEqpS59TaoHThEiCu9JQWaOY+Wv6XvOw2YJG3uhFw
         cjWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AY99dTIR5xArErdJb7TTxISTHPHzPEm/KGv1Gl4W14k=;
        b=YhELYYzBUfOaoasmFWod6/ckR+2vhZeyvIxV8md/WaoAlmEtXL9574GZR9HOmlusyN
         e77XZ4LfjvKb7k7PGJAMfn3zDjb/uypph6n+7onkAifAZAbyS3Y3vNNWcRgrabhJE9Jj
         Oo5IGIxJ6OQ27IBCpinJCwIM7PG7gTEJAiYGTIwxgmlN4vwmHpW1Yn/9BPSSUmgpLDPn
         +LAzssDijf9b7q7B7q4et6m9aCOCFd6AITLXX7ArnQSclZ7uKuybnyE9JIThgNDk4wCj
         Y/JUZDzl4F2Eifo+fAD3VxGijrSxpM3d6bfN7oLLfus/75h6kmNGvCfcg3BWy1HESSOW
         ZP0Q==
X-Gm-Message-State: AOAM5325wimikfWIb7xBzQW5iN7//f3EA7MvdJRg4vYufa9Vf/2mSYhG
        xM19BaBoVpCV+GKt6onDYv+HQQ==
X-Google-Smtp-Source: ABdhPJyF1jp4Kp2Ngg+sA6UXR2l2y83PMYrf1MC+Luiu64/H/MyGuP7uP5ZsaWU9RNFfzKITrirW2A==
X-Received: by 2002:a17:90a:4b84:: with SMTP id i4mr1993234pjh.132.1603941860690;
        Wed, 28 Oct 2020 20:24:20 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id s23sm725363pgl.47.2020.10.28.20.24.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2020 20:24:20 -0700 (PDT)
Subject: Re: [PATCH] nbd: don't update block size after device is started
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, lining <lining2020x@163.com>,
        Josef Bacik <josef@toxicpanda.com>, Jan Kara <jack@suse.cz>
References: <20201028072434.1922108-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a7ce1cc0-34ab-1725-2a91-a7f3263d7401@kernel.dk>
Date:   Wed, 28 Oct 2020 21:24:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201028072434.1922108-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/28/20 1:24 AM, Ming Lei wrote:
> Mounted NBD device can be resized, one use case is rbd-nbd.
> 
> Fix the issue by setting up default block size, then not touch it
> in nbd_size_update() any more. This kind of usage is aligned with loop
> which has same use case too.

Applied, thanks.

-- 
Jens Axboe

