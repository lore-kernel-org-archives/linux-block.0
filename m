Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CB71C433F5
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 09:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC05E61212
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 09:20:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234840AbhJSJWn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Oct 2021 05:22:43 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:38036
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234764AbhJSJWm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Oct 2021 05:22:42 -0400
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 5D2FD3FFE2
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 09:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1634635229;
        bh=rpgxbiGnzy8DYr2MZRZYdU/1oLQHESx+ODNQvDWuN40=;
        h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type;
        b=JQcbMqXF2Ijg2i9elP37/m4rUOKZdQOEgyvTjrkgbh/nJwYR4nKW7MdvyWOIDOELL
         IG688lw/iijX2vqrmD4u38PVjn7A/KWe+dcHORFzTM9L8/HhD76LiksI8ne2EyHGsp
         JtdZeHODaVMYYK6Bwb+FtSOD+9Vb82+5EavEZgEQkfW+/+anh+C4KKHrILFMSwwq3X
         V/inqGyQQ1UPjMnaJ/etsplTCjjsgba3vSq5sFWYLVQ6/ySyVHnw9y4AwZQbbyYKS2
         /4xk5ZF4xtgzuBsW8iXqfwbINXB4umLAVbVlsLNdpbqqMczrV9G9ITMMO0t08dhMia
         EpsOLtzR+xANQ==
Received: by mail-ed1-f69.google.com with SMTP id p20-20020a50cd94000000b003db23619472so17044035edi.19
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 02:20:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=rpgxbiGnzy8DYr2MZRZYdU/1oLQHESx+ODNQvDWuN40=;
        b=2LeJyZz0DHt+eNXmA84L7BX/AMPmmEm7CTy/5+A3ifoJDK4QTQtDCAjxQHuFhHYKGQ
         Rn7PacwvZB0i3WC34c5ZxmaHyHBUoMTwnfeD7HZz4BfIqS0JmDKArqslm62btFX1LoCx
         6D0genmArV968893/TW/LvHPQJHlT/1F7slrnUiLMv7y5u8YEoydiu//4ndvO5g31MLt
         oiRiD7D41FJM1VZ7TYOwZs5FbAGjNewwXKersUPNMZWQMM8834UQ5Q35OTxLfUZDkUMo
         lnxo7SHgswg+Aw4Af9yPKA2rAJlT1AYTfyNipwIIFl5jbdIrtHOly+Vx4i6oLExPp48d
         YL4A==
X-Gm-Message-State: AOAM533l+cNI9Yw4/AJAXugQDOCsP/gVkL2GzV5Fj+N4VOi6NOaaRtR7
        Os2P/4+GrvfhgbzaKwsk1cXSGpT49P5+eEhfKJPGgmjU4C7tFPOtOZc0+aiZ1R+Z5u8jf2mpoUF
        x7/kjzHH2oy67FxWyRRYpX89BIvhi3IrHXtKOaEeB
X-Received: by 2002:a17:906:c0d:: with SMTP id s13mr36852732ejf.309.1634635228963;
        Tue, 19 Oct 2021 02:20:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwH+/q0Q40JwlqtO5cLdOb2cCV0PlkoAQOYXX01RXfcrhg/kUSi7c4momn7LoyUNaBLjjv5WA==
X-Received: by 2002:a17:906:c0d:: with SMTP id s13mr36852714ejf.309.1634635228744;
        Tue, 19 Oct 2021 02:20:28 -0700 (PDT)
Received: from localhost ([2001:67c:1560:8007::aac:c1b6])
        by smtp.gmail.com with ESMTPSA id 91sm8114459ede.56.2021.10.19.02.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 02:20:28 -0700 (PDT)
Date:   Tue, 19 Oct 2021 11:20:26 +0200
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Dmitry Vyukov <dvyukov@google.com>, Omar Sandoval <osandov@fb.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] blk-wbt: prevent NULL pointer dereference in wb_timer_fn
Message-ID: <YW6N2qXpBU3oc50q@arighi-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The timer callback used to evaluate if the latency is exceeded can be
executed after the corresponding disk has been released, causing the
following NULL pointer dereference:

[ 119.987108] BUG: kernel NULL pointer dereference, address: 0000000000000098
[ 119.987617] #PF: supervisor read access in kernel mode
[ 119.987971] #PF: error_code(0x0000) - not-present page
[ 119.988325] PGD 7c4a4067 P4D 7c4a4067 PUD 7bf63067 PMD 0
[ 119.988697] Oops: 0000 [#1] SMP NOPTI
[ 119.988959] CPU: 1 PID: 9353 Comm: cloud-init Not tainted 5.15-rc5+arighi #rc5+arighi
[ 119.989520] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
[ 119.990055] RIP: 0010:wb_timer_fn+0x44/0x3c0
[ 119.990376] Code: 41 8b 9c 24 98 00 00 00 41 8b 94 24 b8 00 00 00 41 8b 84 24 d8 00 00 00 4d 8b 74 24 28 01 d3 01 c3 49 8b 44 24 60 48 8b 40 78 <4c> 8b b8 98 00 00 00 4d 85 f6 0f 84 c4 00 00 00 49 83 7c 24 30 00
[ 119.991578] RSP: 0000:ffffb5f580957da8 EFLAGS: 00010246
[ 119.991937] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000004
[ 119.992412] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88f476d7f780
[ 119.992895] RBP: ffffb5f580957dd0 R08: 0000000000000000 R09: 0000000000000000
[ 119.993371] R10: 0000000000000004 R11: 0000000000000002 R12: ffff88f476c84500
[ 119.993847] R13: ffff88f4434390c0 R14: 0000000000000000 R15: ffff88f4bdc98c00
[ 119.994323] FS: 00007fb90bcd9c00(0000) GS:ffff88f4bdc80000(0000) knlGS:0000000000000000
[ 119.994952] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 119.995380] CR2: 0000000000000098 CR3: 000000007c0d6000 CR4: 00000000000006e0
[ 119.995906] Call Trace:
[ 119.996130] ? blk_stat_free_callback_rcu+0x30/0x30
[ 119.996505] blk_stat_timer_fn+0x138/0x140
[ 119.996830] call_timer_fn+0x2b/0x100
[ 119.997136] __run_timers.part.0+0x1d1/0x240
[ 119.997470] ? kvm_clock_get_cycles+0x11/0x20
[ 119.997826] ? ktime_get+0x3e/0xa0
[ 119.998110] ? native_apic_msr_write+0x2c/0x30
[ 119.998456] ? lapic_next_event+0x20/0x30
[ 119.998779] ? clockevents_program_event+0x94/0xf0
[ 119.999150] run_timer_softirq+0x2a/0x50
[ 119.999465] __do_softirq+0xcb/0x26f
[ 119.999764] irq_exit_rcu+0x8c/0xb0
[ 120.000057] sysvec_apic_timer_interrupt+0x43/0x90
[ 120.000429] ? asm_sysvec_apic_timer_interrupt+0xa/0x20
[ 120.000836] asm_sysvec_apic_timer_interrupt+0x12/0x20

In this case simply return from the timer callback (no action
required) to prevent the NULL pointer dereference.

BugLink: https://bugs.launchpad.net/bugs/1947557
Link: https://lore.kernel.org/linux-mm/YWRNVTk9N8K0RMst@arighi-desktop/
Fixes: 34dbad5d26e2 ("blk-stat: convert to callback-based statistics reporting")
Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
---

NOTE: I'm not sure if this is more of a bandaid rather than a proper
fix, but I have a reliable reproducer and with this applied I can
prevent the kernel from exploding badly.

---
 block/blk-wbt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index 874c1c37bf0c..0c119be0e813 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -357,6 +357,9 @@ static void wb_timer_fn(struct blk_stat_callback *cb)
 	unsigned int inflight = wbt_inflight(rwb);
 	int status;
 
+	if (!rwb->rqos.q->disk)
+		return;
+
 	status = latency_exceeded(rwb, cb->stat);
 
 	trace_wbt_timer(rwb->rqos.q->disk->bdi, status, rqd->scale_step,
-- 
2.32.0

