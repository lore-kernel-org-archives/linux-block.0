Return-Path: <SRS0=xoF3=VK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0369C31E40
	for <linux-block@archiver.kernel.org>; Sat, 13 Jul 2019 21:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72AC720838
	for <linux-block@archiver.kernel.org>; Sat, 13 Jul 2019 21:43:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="MsRIz1t3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbfGMVn1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 13 Jul 2019 17:43:27 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40589 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727978AbfGMVn1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 13 Jul 2019 17:43:27 -0400
Received: by mail-pg1-f193.google.com with SMTP id w10so6019922pgj.7
        for <linux-block@vger.kernel.org>; Sat, 13 Jul 2019 14:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ug6OTHhPR0mOl8uCS06o16LbYvopEC7aZITY2k9/paU=;
        b=MsRIz1t3m5OxBpEnN3M4/36zMb78UJsKmDw7ME6x427k/I0rPDEuDrNYolDxb+7A9n
         HWI8t/6QEoBRl7ivajzmeN2fXW58J06FYbt0fBEIj+TH4YhSbQPKwbc/2nQFM5i1C0B2
         9MDmcB0vkfoKB6hbwtLgshv2bnKa1rAyCmymWOwu+6H7gH9Xk0BprpBeEyA429mQcsYG
         8xWLq7KB017YimVlJ0JRd6iZfMihoI/vG6j2XQ63JA0HEJLxxZFlFahGImWCkS9308Es
         TtizQM9o3d2GvQKWxIDRtS+919zmpFk2GXUfDwMdiRbjayxKWpviXKeNGRk9BHUd6lnp
         G4gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ug6OTHhPR0mOl8uCS06o16LbYvopEC7aZITY2k9/paU=;
        b=ciN+L0n+Qig5sGcEyYGceiuj0xu6Y0+zZY8yanSWKiidyU1nRj23bSuED2/sRs1/dw
         YXPNf50UCims0UxdbJ0Q51MIPeKn8VZpc9u2bfXoCcvSHYRbXXIAsqWa3uGtlhnOG3VW
         kSM9pVzH2aTE01CESiUvelHForQM8A7o1puuFqQ6ak6rkX9X9rAgM7zmWOYl5OQLLs0v
         SmLQwway2aW5/DYDOJ4q7zzPln6lRgpFAbNlIJiBioOr4A6HOIjGc2gxKuCD1UnWUssp
         +WxqVOaRcxPt4f/92rqX3rBQH1AGG7LczuQjUL6gjjGeXsog8MvdSYGcmrwqGT9TLUm8
         zqwg==
X-Gm-Message-State: APjAAAV/fQ11EIh6cLHUniZ8UvHVepQLDzPzFpIyhMNcvqryclNk+00a
        v0/9/NwYYScZHbG+qZnDyn4VOX9g1Ok=
X-Google-Smtp-Source: APXvYqyw/imgV7R1SrXlCuyvdxlh4BmUCr02XA4eQAAB8cZtCPWh3z1mpgSsxjIX2RHcw/Ffhddpnw==
X-Received: by 2002:a17:90a:a410:: with SMTP id y16mr20493536pjp.62.1563054206020;
        Sat, 13 Jul 2019 14:43:26 -0700 (PDT)
Received: from [192.168.1.121] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id q7sm16051912pff.2.2019.07.13.14.43.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 Jul 2019 14:43:24 -0700 (PDT)
Subject: Re: [PATCH 2/2] io_uring: fix the judging condition in
 io_sequence_defer
To:     Zhengyuan Liu <liuzhengyuan@kylinos.cn>
Cc:     linux-block@vger.kernel.org
References: <20190713035826.2987-1-liuzhengyuan@kylinos.cn>
 <20190713035826.2987-2-liuzhengyuan@kylinos.cn>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <13f62d22-1a99-0c29-cd4c-8808223fbc68@kernel.dk>
Date:   Sat, 13 Jul 2019 15:43:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190713035826.2987-2-liuzhengyuan@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/12/19 9:58 PM, Zhengyuan Liu wrote:
> sq->cached_sq_head and cq->cached_cq_tail are both unsigned int.
> if cached_sq_head gets overflowed before cached_cq_tail, then we
> may miss a barrier req. As cached_cq_tail moved always following
> cached_sq_head, the NQ should be enough.

This (and the previous patch) looks fine to me, just wondering if
you had a test case showing this issue?

-- 
Jens Axboe

