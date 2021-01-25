Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A69DFC433DB
	for <linux-block@archiver.kernel.org>; Mon, 25 Jan 2021 04:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BF2822B42
	for <linux-block@archiver.kernel.org>; Mon, 25 Jan 2021 04:29:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbhAYE2r (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 24 Jan 2021 23:28:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726855AbhAYE2p (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 24 Jan 2021 23:28:45 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D474C061574
        for <linux-block@vger.kernel.org>; Sun, 24 Jan 2021 20:28:05 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id b8so6791569plh.12
        for <linux-block@vger.kernel.org>; Sun, 24 Jan 2021 20:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6dXiISuywEBuazI4xj4yFxY1nkp6ZflUiyorvnDifvs=;
        b=Pq81h34KvrPTQiyWomze+Gw0KOD9of/oGveHh8B5C5f5Sw4seL+lndqGq/fAjIrD+J
         05Cx+85/WkzFyXxhTM5yroL3dsKGbDYim/4ymqHmdb7IR3xzTBf3w2oGIBTQFsDm1st3
         hHEDn3TsvNVeMQ3/2qwteLe7YDeG/gE+x/cn6aO3UAHsIa7MF1h9DPFeoaf2sCEvujnO
         6JaptvWLA7TZRWpvpkGFFG4C6yh9Hy5FZUS1NW8LBIQbROK31BVgszsAhQZK9qtmOJzX
         WqSFtCAH8vAZvmoCr00LoAGUqYUtjbSl418ug6Cav3y2Loqs5rsA09FKY4BJumwuwhQa
         d0VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6dXiISuywEBuazI4xj4yFxY1nkp6ZflUiyorvnDifvs=;
        b=XuHI9WM9bZVKY7EpttRRV6kcyNixrI+gjiuPTiJ1NPQRRht2wvwQh1Gih7DuRHJWPn
         Es6SybAL4x5IkoH9ddm2lfFf8UyllsYLd+49SB61QMOzotr8qvfA7LTfcuAJXSeDxkrQ
         zqCEVGa5ZvHG/Gg5/bZk1wSjE1FzWI2crXF4pFK49/b96VjI64+PstQWD/B26eVAW+Tw
         XpeqKNqhE9d807aDF9uZXu0WyJmPUC7oiSF/vGAxBqWXtF2rQHt6R+NOzRTW4Pj8AMzU
         YXD6nvYLrSa4rKZXOUufdsfEkQ1ZnyUYQsPgNHsZpNk58pdvnessglwBu4TzvV96U4lI
         WLbg==
X-Gm-Message-State: AOAM532mzgu3YmwhY1MZqNmAePjgo4CMU1MU8j7i7Chj9qAZpbTRym99
        8EPbQgAItnHUAUHSIwwKvFzxuA==
X-Google-Smtp-Source: ABdhPJw/2/1B5rytSzbIS7zdfgAkoF4oaB/9PLp8Tj4sfje42S00tsY6WtySESAMMoXHwKIe7NHOoQ==
X-Received: by 2002:a17:902:ed88:b029:de:86f9:3e09 with SMTP id e8-20020a170902ed88b02900de86f93e09mr17759813plj.38.1611548885148;
        Sun, 24 Jan 2021 20:28:05 -0800 (PST)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id gv22sm16102738pjb.56.2021.01.24.20.28.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Jan 2021 20:28:04 -0800 (PST)
Subject: Re: [PATCH v3 0/3] blk-mq: Don't complete in IRQ, use llist_head
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
References: <20210123201027.3262800-1-bigeasy@linutronix.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4e703284-2f75-6030-f697-aa2d362c3949@kernel.dk>
Date:   Sun, 24 Jan 2021 21:27:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210123201027.3262800-1-bigeasy@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/23/21 1:10 PM, Sebastian Andrzej Siewior wrote:
> Patch 2+3 were applied and then dropped by Jens due to a NOHZ+softirq
> related warning [0]. Turns out a successful wakeup via
> set_nr_if_polling() will not process any softirqs and the CPU may go
> back to idle. This is addressed by patch #1.
> 
> smpcfd_dying_cpu() will also invoke SMP-functions calls via
> flush_smp_call_function_queue() but the block layer shouldn't queue
> anything because the CPU isn't online anymore.
> The two caller of flush_smp_call_function_from_idle() look fine with
> opening interrupts from within do_softirq().
> 
> [0] https://lkml.kernel.org/r/1ee4b31b-350e-a9f5-4349-cfb34b89829a@kernel.dk

I can queue up the block side once the IPI fix is in some stable branch
that I can pull in.

-- 
Jens Axboe

