Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B44BEC433F5
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 12:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9350A6115B
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 12:14:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235748AbhJSMQY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Oct 2021 08:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235785AbhJSMQJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Oct 2021 08:16:09 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F16DC061768
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 05:13:56 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id y67so19968802iof.10
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 05:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pk5y5XIMhh/tG68HZxQqkvzMZzS0BORw3x9mVON2B+o=;
        b=na4AN+NihvQEOJ2fjaKAqWgeN2LnuG718wxc4mXri/fs04C/eUG/pg8oOK9ZpllO+Y
         HP/xjbQ3pgZBTFO7tmsc3if2u9KJwTPQTGyK/Xdaj6c4FowqiufFeuamwQKxTpf9MjqO
         d06xXrf9zOElxoz6LZNfKpB6pPClOl3q23kUIdnrfpcF39I3pZ4itr0+nJ6K0b7W49gO
         OBFtc5FvSfmnu/dG2UiHX6a/8gTOBnt4fl+LmIL4HWy1f7A5xxPNTEdzB8M+LNnINo4V
         spoeP19SyeDIwmxgEtTYNGyKVn3avCj+QRe8dC/LMuhoaR6whi+/dBsRYHgjUtYqfkmx
         9jzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pk5y5XIMhh/tG68HZxQqkvzMZzS0BORw3x9mVON2B+o=;
        b=RNuvA/JThLmT3WQPKtvlJh/EqQLDUNlBE9oY/0h6VT9z0Z8SQfrefT3qLHnGHe3++v
         BfgLn7UaiZhDBsXknjuEV/IFI01Hl6DMEvWdB2zSx/pB7fawKXflvQ0URouSU013eecD
         2SdW0p5O972HJ0y6DJymPtDOqdG40rSjr/YpYxAxAoiSOGiEXiChbjlA6oel4vR+g9n9
         Xwlm+PUnFRpDfzn76wEeJ7+0/oJa8VJ767NoeiY2cvbeDwHnoGUORldAKenKj6F3IO0N
         bP8cGGuUczOrZzaC1LM45LMvVlViW/iOlMu3Y7zLbkYjJI3p8F1h1eZhv9IsmNNAZiqV
         rQYg==
X-Gm-Message-State: AOAM530uWsndHmM1BtD6F5BornYG+GXK58wPie+XJvQJT6062tzuhjqO
        emfKuDrZsFxXEqYLHQ8ZTOMVEQ==
X-Google-Smtp-Source: ABdhPJyrkGlgYSptiwUkxsgSjFMRhruX5Ih2RQzOWpEucuDarfLM14sRw4qEsrT7YxIFM1wHljfhOg==
X-Received: by 2002:a6b:dc05:: with SMTP id s5mr18118974ioc.131.1634645635968;
        Tue, 19 Oct 2021 05:13:55 -0700 (PDT)
Received: from localhost.localdomain ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id s7sm6333123iow.31.2021.10.19.05.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 05:13:55 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Andrea Righi <andrea.righi@canonical.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Omar Sandoval <osandov@fb.com>,
        linux-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] blk-wbt: prevent NULL pointer dereference in wb_timer_fn
Date:   Tue, 19 Oct 2021 06:13:52 -0600
Message-Id: <163464562777.598602.10382818884305108379.b4-ty@kernel.dk>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <YW6N2qXpBU3oc50q@arighi-desktop>
References: <YW6N2qXpBU3oc50q@arighi-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 19 Oct 2021 11:20:26 +0200, Andrea Righi wrote:
> The timer callback used to evaluate if the latency is exceeded can be
> executed after the corresponding disk has been released, causing the
> following NULL pointer dereference:
> 
> [ 119.987108] BUG: kernel NULL pointer dereference, address: 0000000000000098
> [ 119.987617] #PF: supervisor read access in kernel mode
> [ 119.987971] #PF: error_code(0x0000) - not-present page
> [ 119.988325] PGD 7c4a4067 P4D 7c4a4067 PUD 7bf63067 PMD 0
> [ 119.988697] Oops: 0000 [#1] SMP NOPTI
> [ 119.988959] CPU: 1 PID: 9353 Comm: cloud-init Not tainted 5.15-rc5+arighi #rc5+arighi
> [ 119.989520] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
> [ 119.990055] RIP: 0010:wb_timer_fn+0x44/0x3c0
> [ 119.990376] Code: 41 8b 9c 24 98 00 00 00 41 8b 94 24 b8 00 00 00 41 8b 84 24 d8 00 00 00 4d 8b 74 24 28 01 d3 01 c3 49 8b 44 24 60 48 8b 40 78 <4c> 8b b8 98 00 00 00 4d 85 f6 0f 84 c4 00 00 00 49 83 7c 24 30 00
> [ 119.991578] RSP: 0000:ffffb5f580957da8 EFLAGS: 00010246
> [ 119.991937] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000004
> [ 119.992412] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88f476d7f780
> [ 119.992895] RBP: ffffb5f580957dd0 R08: 0000000000000000 R09: 0000000000000000
> [ 119.993371] R10: 0000000000000004 R11: 0000000000000002 R12: ffff88f476c84500
> [ 119.993847] R13: ffff88f4434390c0 R14: 0000000000000000 R15: ffff88f4bdc98c00
> [ 119.994323] FS: 00007fb90bcd9c00(0000) GS:ffff88f4bdc80000(0000) knlGS:0000000000000000
> [ 119.994952] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 119.995380] CR2: 0000000000000098 CR3: 000000007c0d6000 CR4: 00000000000006e0
> [ 119.995906] Call Trace:
> [ 119.996130] ? blk_stat_free_callback_rcu+0x30/0x30
> [ 119.996505] blk_stat_timer_fn+0x138/0x140
> [ 119.996830] call_timer_fn+0x2b/0x100
> [ 119.997136] __run_timers.part.0+0x1d1/0x240
> [ 119.997470] ? kvm_clock_get_cycles+0x11/0x20
> [ 119.997826] ? ktime_get+0x3e/0xa0
> [ 119.998110] ? native_apic_msr_write+0x2c/0x30
> [ 119.998456] ? lapic_next_event+0x20/0x30
> [ 119.998779] ? clockevents_program_event+0x94/0xf0
> [ 119.999150] run_timer_softirq+0x2a/0x50
> [ 119.999465] __do_softirq+0xcb/0x26f
> [ 119.999764] irq_exit_rcu+0x8c/0xb0
> [ 120.000057] sysvec_apic_timer_interrupt+0x43/0x90
> [ 120.000429] ? asm_sysvec_apic_timer_interrupt+0xa/0x20
> [ 120.000836] asm_sysvec_apic_timer_interrupt+0x12/0x20
> 
> [...]

Applied, thanks!

[1/1] blk-wbt: prevent NULL pointer dereference in wb_timer_fn
      commit: 480d42dc001bbfe953825a92073012fcd5a99161

Best regards,
-- 
Jens Axboe


