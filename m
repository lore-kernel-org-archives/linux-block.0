Return-Path: <SRS0=gXx0=YU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D2CDCA9EAF
	for <linux-block@archiver.kernel.org>; Sun, 27 Oct 2019 16:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CB4721850
	for <linux-block@archiver.kernel.org>; Sun, 27 Oct 2019 16:27:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="zMPR/Esk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbfJ0Q1v (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 27 Oct 2019 12:27:51 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39306 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbfJ0Q1v (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 27 Oct 2019 12:27:51 -0400
Received: by mail-pg1-f195.google.com with SMTP id p12so4840599pgn.6
        for <linux-block@vger.kernel.org>; Sun, 27 Oct 2019 09:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=3BjnWwp3iraWHcYw6tvnTp+ugdgCwV5CI+A2YLDChKo=;
        b=zMPR/EskDyZVAsb7wAVSGiopjG8fnvhNrnzTxGaU4HWKAkdyUfeBomabEO3xgOT/kZ
         OAS0ddQp2qDe15yY0WZc/W+hyAZSLDqsVU6OuBFHmJqiQf15R0zOkXhWBHwzg+6sv9Yl
         rxAkbOaQj8SyLvYwaPuSgdpT0yVy+i0HPNKuYFjEwtysAC2dQN9KFOFPKcr7GNduXoNa
         sagFUgHm1a8fZJSOF/WtrPG3DLQkhJ9JzgnpOiG7iN6hOdpN65dVcfj4qF7j/JFvL8QL
         Sp7hwpBX7HC75zrLG/iSJEHQzT2mYO4MsWfqod8+PmkfAnP4lHQWkhY/K2yjD3Z5TZoK
         voGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3BjnWwp3iraWHcYw6tvnTp+ugdgCwV5CI+A2YLDChKo=;
        b=c3RtMuiIIhJmdjnXsFQbvqrfSzUscEd0GBNRDd5W1ZtLkXp3cMOaH/1bJJBSRkZmhg
         rBRhj6iF9kaBfXyYy9tbeTO2N2AoZ1wtxij3g9LUCstQbjGbPfha+oI5lI7XWt4lhht9
         /5veTbu5BD4SDI7xtTAjp57TSq+dfvgD0tW2DfXotHVzkmCo6lWX7vbL8lOv3xhVT+08
         FmOJkBq0wJ1Ty6xykIceXeLLwU/6J13hbtOG+AEMLKoaSKQTA2W7kzum3NVAfu/8KRhw
         NSo+BH27fnt0zo5A8KBDghnuwtq4pmwPjM7zIdTuMReV4kChVvCeekXifCdVY4Sk6mfs
         EAYQ==
X-Gm-Message-State: APjAAAVbLu2k2g2XmsKz0dSpkjek2mpMl7vfyuBJcOwhlvzKJkweX8nE
        XVCG8OEKkTHVjCTg91rysSN1Bw==
X-Google-Smtp-Source: APXvYqxTR9u+jBM/zcy5fuYp6nWnvicznxJE6nWXvvc5TA990pdckOsX3ZnfcsC832zl7p6HAXlTvw==
X-Received: by 2002:a63:3281:: with SMTP id y123mr6310407pgy.252.1572193670691;
        Sun, 27 Oct 2019 09:27:50 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id x26sm8446634pfr.110.2019.10.27.09.27.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Oct 2019 09:27:49 -0700 (PDT)
Subject: Re: [PATCH 1/1] io_uring: remove index from sqe_submit
To:     Pavel Begunkov <asml.silence@gmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <b92e51e7ee180f1e31bfef808d8e20535c921f46.1572191466.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f7b3f055-94da-946e-6a8a-588b24ad9123@kernel.dk>
Date:   Sun, 27 Oct 2019 10:27:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <b92e51e7ee180f1e31bfef808d8e20535c921f46.1572191466.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/27/19 9:52 AM, Pavel Begunkov wrote:
> submit->index is used only for inbound check in submission path (i.e.
> head < ctx->sq_entries). However, it always will be true, as
> 1. it's already validated by io_get_sqring()
> 2. ctx->sq_entries can't be changedd inbetween, because of held
> ctx->uring_lock and ctx->refs.

Applied, thanks.

-- 
Jens Axboe

