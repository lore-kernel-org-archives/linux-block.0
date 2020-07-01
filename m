Return-Path: <SRS0=s14/=AM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3696CC433E0
	for <linux-block@archiver.kernel.org>; Wed,  1 Jul 2020 14:05:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18F732068F
	for <linux-block@archiver.kernel.org>; Wed,  1 Jul 2020 14:05:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="fwWoE7od"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731290AbgGAOFr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Jul 2020 10:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731287AbgGAOFo (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Jul 2020 10:05:44 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57EFEC08C5C1
        for <linux-block@vger.kernel.org>; Wed,  1 Jul 2020 07:05:44 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id w2so10969460pgg.10
        for <linux-block@vger.kernel.org>; Wed, 01 Jul 2020 07:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=DS8Kv4Y2KXgOfDSHA4KpPd5LfAuLqzqsI4w9bTH/pd8=;
        b=fwWoE7od+j4gOCbnOmZLrN2K/KUr4b4JGLKH2uKZISgY51i6l9aGOZ9g8ppk1x6fln
         eQFs8fpF3O1Q0QWji7JB+/sonOxe9WBXQgzfvSDTS1m1ADbcwCUVw5afqR/N0hHOONLD
         GIucSMU7EvuxyzyP4wUG2H7HdoePSdoIWtqO4gXklrEyonny9OSRAcwQvClxy1nhEACJ
         RzTCg/Dni+oiXoPu/ubp7+FrnokRnE1GODOAcuTRKmI5+NAmiOiCCuCf69kjLYgpE0z3
         2YFplaPaMfs3V4fHVZ7+kL1U6947JGT0oUuAwgxyAq5NCdQBJuKjmNmCs25ACTn5oOUP
         7mZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DS8Kv4Y2KXgOfDSHA4KpPd5LfAuLqzqsI4w9bTH/pd8=;
        b=sOIgDN5NPb5J280GdHAQKEaD4loaZMgEDBu1Eaxh+0ovtbEkrdlkVJxfPnhzc1HTsu
         WtPgvRCLQGwYHmuQg753Kl+iU94VRRSuRRxhWbbvsroQWIZy0Nxif7kSbyIdH0DPvH/X
         A11fBl+2dhqvuU/C8Kro5k6mvB1H/5c+6TspqgRvYnGszzuJC+sEBS/FK7T1ss3QXPdp
         2Ufbtac1AsKFG4hx8TfpGVo2M6rhYPoGgNQnYjerIheuFfPU8P3SDBFMBnO4cqBXzMZn
         ozfqj0bWYScIsKJ4ynG76Q8tp4ps+Ex39mbMUKxn9amXR6qOR3kDXUFaBvvSRVNTtSQX
         pFyg==
X-Gm-Message-State: AOAM533apFMoXbNBeilRbXaful3Q411YKxtDhqql8h7UxDTY/4vPaPiG
        Sx7nEkF9PqsHnaFA2XFAafDUqZDGg1NXGQ==
X-Google-Smtp-Source: ABdhPJww1Uf5EvUsoqHygJu0ev06xD7d78GM0zADhKMn2bWRb+Snf5eSX3uo+/1mrBfNK98tQa/H7A==
X-Received: by 2002:a62:de81:: with SMTP id h123mr24144711pfg.217.1593612343465;
        Wed, 01 Jul 2020 07:05:43 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:64c1:67b1:df51:2fa8? ([2605:e000:100e:8c61:64c1:67b1:df51:2fa8])
        by smtp.gmail.com with ESMTPSA id az13sm4523999pjb.34.2020.07.01.07.05.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2020 07:05:42 -0700 (PDT)
Subject: Re: [PATCH v2] blk-iolatency: postpone ktime_get() execution until
 blk_iolatency_enabled() return true
To:     Hongnan Li <hongnan.li@linux.alibaba.com>,
        linux-block@vger.kernel.org
References: <1593590978-23382-1-git-send-email-hongnan.li@linux.alibaba.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <bb6e02cb-052c-e94c-e38e-b6d02b55da48@kernel.dk>
Date:   Wed, 1 Jul 2020 08:05:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <1593590978-23382-1-git-send-email-hongnan.li@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/1/20 2:09 AM, Hongnan Li wrote:
> ktime_to_ns(ktime_get()) which is expensive do not need to be executed if
> blk_iolatency_enabled() return false in blkcg_iolatency_done_bio().
> Postponing ktime_to_ns(ktime_get()) execution can reduce CPU usage
> when blk_iolatency was disabled.
> 
> ---
> V2:
>   1.Fix compile warnings.
> 
> Signed-off-by: Hongnan Li <hongnan.li@linux.alibaba.com>

I've applied this (rewrote header+commit message somewhat). But a note for the
future - anything below the first --- is removed, so you'll need to put your
SOB right below the commit message. And the v2 etc info should go here:

> ---
>  block/blk-iolatency.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

instead of having two --- sections.

-- 
Jens Axboe

