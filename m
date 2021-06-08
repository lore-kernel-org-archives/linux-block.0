Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C11C4743F
	for <linux-block@archiver.kernel.org>; Tue,  8 Jun 2021 21:13:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C4CC6044F
	for <linux-block@archiver.kernel.org>; Tue,  8 Jun 2021 21:13:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbhFHVPI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Jun 2021 17:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbhFHVPI (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Jun 2021 17:15:08 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADCFAC061574
        for <linux-block@vger.kernel.org>; Tue,  8 Jun 2021 14:12:59 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id n12so17546260pgs.13
        for <linux-block@vger.kernel.org>; Tue, 08 Jun 2021 14:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kavbhkV/CORp2/ogdB7Rtj7eAxktrXq37FhU19x+nUk=;
        b=KBB/iKjh3n+I7dWpm/bbRMzFGylRHvlUJnpGGDzQn9hQPT/1v7BuDyRtaCFGDKsSZ/
         SRRD+GY8TuRx1wgYJ3SRVc5v1Ag1KqgrPh1waNhykvt68RxtIsq/robvfeAPC3r7Oq6L
         WEvRA8PBW42xemmkJkwsvPK9rKm7VDGZeeS+gjiBUXfGDtsK2CKptCOPrlakKqK/Fl9K
         +17fXokO4vcrugo4LOrIh5ot/kmLgVjs0fhf+ZCwRxaB2RfiugsyFgiFPIB7xR+rtWCk
         HL3lFxRDtXGzjXg3c0sP4rFGJ3baV4MU2YQ5PpkQIzdlC6U8NtT6KpfvPwlfairR12AA
         k2ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kavbhkV/CORp2/ogdB7Rtj7eAxktrXq37FhU19x+nUk=;
        b=AW2uhgRdQXS7+IwJhORb0tvYycbaGv/E4bR57/+YwXZ1hCGiuaNvYHxr3+Wp/9PVwe
         S50JVaLDkFvQUFEmNmGLfYVct2B+bqyApy+M9TDuf3IlonnJn/z6K0xG2Q3XmTAWL6Pv
         hNWvsk7y6r2m5kb8ULxuoQ+KxZlR0DLKwPNmxtxB5qNj+4kztuMe86WJKWQWFkjm625a
         /j8WzHaMYos+bXDWJsv6o2S4C6TXxcMb3GxIb/cVcPrsB2Z67qrQMlOQRZz8EbSvesHT
         nZIfv+Jz0tJIkzV8zd7wzZ7qrqPZrVm7k+ATb3rDLViXMd7Tj3jJLkpR60HiXKXrihea
         XSuA==
X-Gm-Message-State: AOAM530Xa65OpMf814X9FogpHw5Ul/mWhlcAQq4hmtxci13YMBnjq/vt
        J33AgiM1+rMboR7/BWNKnGtIGA==
X-Google-Smtp-Source: ABdhPJztTQV6zqfvIRBqvDAZKkQMbx3QWBPtGYGL9c7JROWyN/H0l4/bHq1BZ7/QpT4C3oZu1RTidQ==
X-Received: by 2002:a62:3344:0:b029:28c:6f0f:cb90 with SMTP id z65-20020a6233440000b029028c6f0fcb90mr1727257pfz.58.1623186779130;
        Tue, 08 Jun 2021 14:12:59 -0700 (PDT)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id c20sm3036209pjr.35.2021.06.08.14.12.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jun 2021 14:12:58 -0700 (PDT)
Subject: Re: [PATCH] rq-qos: fix missed wake-ups in rq_qos_throttle try two
To:     Jan Kara <jack@suse.cz>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        Oleg Nesterov <oleg@redhat.com>, linux-block@vger.kernel.org,
        stable@vger.kernel.org
References: <20210607112613.25344-1-jack@suse.cz>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e14aeaa7-45a3-b2f0-7738-3613189ae1d4@kernel.dk>
Date:   Tue, 8 Jun 2021 15:13:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210607112613.25344-1-jack@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/7/21 5:26 AM, Jan Kara wrote:
> Commit 545fbd0775ba ("rq-qos: fix missed wake-ups in rq_qos_throttle")
> tried to fix a problem that a process could be sleeping in rq_qos_wait()
> without anyone to wake it up. However the fix is not complete and the
> following can still happen:
> 
> CPU1 (waiter1)		CPU2 (waiter2)		CPU3 (waker)
> rq_qos_wait()		rq_qos_wait()
>   acquire_inflight_cb() -> fails
> 			  acquire_inflight_cb() -> fails
> 
> 						completes IOs, inflight
> 						  decreased
>   prepare_to_wait_exclusive()
> 			  prepare_to_wait_exclusive()
>   has_sleeper = !wq_has_single_sleeper() -> true as there are two sleepers
> 			  has_sleeper = !wq_has_single_sleeper() -> true
>   io_schedule()		  io_schedule()
> 
> Deadlock as now there's nobody to wakeup the two waiters. The logic
> automatically blocking when there are already sleepers is really subtle
> and the only way to make it work reliably is that we check whether there
> are some waiters in the queue when adding ourselves there. That way, we
> are guaranteed that at least the first process to enter the wait queue
> will recheck the waiting condition before going to sleep and thus
> guarantee forward progress.

Applied, thanks.

-- 
Jens Axboe

