Return-Path: <SRS0=cAVD=QH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AF3FC169C4
	for <linux-block@archiver.kernel.org>; Thu, 31 Jan 2019 19:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BB7A218FC
	for <linux-block@archiver.kernel.org>; Thu, 31 Jan 2019 19:51:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="1PshaaEu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727575AbfAaTvB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 31 Jan 2019 14:51:01 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46108 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbfAaTvA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 31 Jan 2019 14:51:00 -0500
Received: by mail-pg1-f194.google.com with SMTP id w7so1783690pgp.13
        for <linux-block@vger.kernel.org>; Thu, 31 Jan 2019 11:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BrWqBFX8Sxzuvb7eYAR/Dr8ZYdGJ8ANkxgVoI0vKZPU=;
        b=1PshaaEuoALyCYV1xYTbjz/ySkbnA0mrjUzdU6d4IkQ+51B0A06ekeKF6+8HgJTTB0
         XbhDmFKn19ha1Ez4PedtOhi7pcgiqukD1jioxgw9yLc9Y0htGm/0cMI6HlTrQGCR1MXt
         iU6PCC5994oYLvBT/3nmU2MeUIw5PzJeTwyzkGOdqAUjzakP79Y8NHBlQcpO0duJ8ZT3
         F+CziaKi079LBRBTgtjKIx6HAys3obRwklk5NCbw1jPJF4nhV5uwD7SGEMjLymLXv3uk
         cv0ChfUlsU65YPhNE/VV6C6p2Twrdb3IeG23FEulgpvhGbUJvFrpyHHH6u8J4M6l0itt
         UxVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BrWqBFX8Sxzuvb7eYAR/Dr8ZYdGJ8ANkxgVoI0vKZPU=;
        b=QK1+Qak+vt4uZsFoWtQNGQWzFz9Dw31vBNXpgWlhcdegK00ek/zkXnFPp4wGdZsC8L
         mzcwXgvanI+sGA7ti6U+qKFwbPQCegzzrYvnpiHHhEdZw8gQPo2tLXTNx8o5g5zD6C+p
         xjfRFCAZRskBp1YMDPyR6lIF8lUqoLlFDzQwUIVjAC+tAb05BGr0UAMCu0M+tMB6bQ9v
         ZQFS+YuJQt/Cxy73C5vSMf38PjLD5gSsBVjgflzoQSKIMT+crFwCHNGak53wnJyPhFed
         2iVCsA+m6gpjTR0WelsolTsNUKkQRCCMaftIxjYtpDiBhhM2qhLRkgYwbwRmyiP3lE8W
         ervg==
X-Gm-Message-State: AJcUukeLwHEphtQzI49144jQ4Nqif0+px+2J6eXO+0V4xbe3NYW6xK+J
        bsX74xYu3G3xJToTAecKNY6D7w==
X-Google-Smtp-Source: ALg8bN4FiTwx/69TlwaH+fRrCoSW9ysBG2KtIqdMykSIyM6GDPQ1r/uwTLCOu4oPYs+YltsjpliN4g==
X-Received: by 2002:a63:d252:: with SMTP id t18mr32992159pgi.133.1548964259231;
        Thu, 31 Jan 2019 11:50:59 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id l74sm10051982pfb.145.2019.01.31.11.50.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 11:50:58 -0800 (PST)
Subject: Re: [PATCH BUGFIX IMPROVEMENT 00/14] batch of patches for next linux
 release
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        broonie@kernel.org, bfq-iosched@googlegroups.com,
        oleksandr@natalenko.name, mancha@tower-research.com
References: <20190129110638.12652-1-paolo.valente@linaro.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6e296dbe-7d3c-39fc-0e80-4e62ad13cc45@kernel.dk>
Date:   Thu, 31 Jan 2019 12:50:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190129110638.12652-1-paolo.valente@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/29/19 4:06 AM, Paolo Valente wrote:
> Hi,
> this batch of patches provides fixes and improvements for throughput
> and latency. Every patch has been under test for at least one month,
> some patches for much longer.
> 
> Thanks,
> Paolo
> 
> Paolo Valente (14):
>   block, bfq: do not consider interactive queues in srt filtering
>   block, bfq: avoid selecting a queue w/o budget
>   block, bfq: make sure queue budgets are not below service received
>   block, bfq: remove case of redirected bic from insert_request
>   block, bfq: consider also ioprio classes in symmetry detection
>   block, bfq: split function bfq_better_to_idle
>   block, bfq: do not plug I/O of in-service queue when harmful
>   block, bfq: unconditionally plug I/O in asymmetric scenarios
>   block, bfq: fix sequential rq detection in rate estimation
>   block, bfq: fix queue removal from weights tree
>   block, bfq: reduce threshold for detecting command queueing
>   block, bfq: port commit "cfq-iosched: improve hw_tag detection"
>   block, bfq: do not overcharge writes in asymmetric scenarios
>   block, bfq: fix in-service-queue check for queue merging
> 
>  block/bfq-iosched.c | 705 ++++++++++++++++++++++++--------------------
>  block/bfq-iosched.h |  11 +-
>  block/bfq-wf2q.c    |  18 +-
>  3 files changed, 400 insertions(+), 334 deletions(-)

Applied, thanks.

-- 
Jens Axboe

