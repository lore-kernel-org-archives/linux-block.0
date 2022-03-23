Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D90F8C433EF
	for <linux-block@archiver.kernel.org>; Wed, 23 Mar 2022 01:53:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231530AbiCWBzD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Mar 2022 21:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240590AbiCWBzC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Mar 2022 21:55:02 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 810765BE5D
        for <linux-block@vger.kernel.org>; Tue, 22 Mar 2022 18:53:34 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id t5so328358pfg.4
        for <linux-block@vger.kernel.org>; Tue, 22 Mar 2022 18:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=sCOm76y/sh5DspROS7K4wB/idPXNKcfl397QVrN3UP0=;
        b=4kqTY5UEKA1B/GRl4lDGJyRIW4MtRtBEj0uKQhURAA0qbUqH79qnMnMkJcPotZ93An
         L/nV/mxDUsv82hBte87aF9/IVKxhxtq7X3p8yXFnmUfE/b8eXnHzi79l4UYiid6komYf
         MOOS5IJ0uW69H1yxpKkozDpfCtSWdhHwOvfNRC5WbHQZ7jfS5lzWCoRqxqzKRbX4rZyW
         iwRLeEKSWncvd7dm+IXZsAVx/gFKFAx6bGrftXDIAihk1riE84qijcMkPTXLmuH8ydBS
         47sUNKHv3OeiplOvP3Y4IspGa8gCnoQzzt2qXDk90qJ61VYjOZnKRfuUaMtk0BicvG4p
         dAqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=sCOm76y/sh5DspROS7K4wB/idPXNKcfl397QVrN3UP0=;
        b=OZnWH8l0CB9G9EPnKcaXhCNThqiNYFLfjEa6p+uLGnaS16ZELw0hVIcbqZZe1pb7O9
         5bsaNcTtmi/CnDjZKcjin2Utke0F/qbrthXucZf/i/9CD1sHzd7HYyi2XHRmrCMxZn2k
         jFVRsMbpEC8SsMt5vMfXSDFOwsVJB+P280C4CuQxHyRLHlClvnTZ/EkvDZdR+hSgoXwp
         +UjaTRGWACwwnW5mNIjgmKiVL5Jy0NWz0q7n/08tFdUwYawAYjWiHB5mWiFOvMKNMXom
         QI4y7FngWugtgaCkBtpqbIxRF2+2Ai6JVYvzkX7OeEcU/hhUpgczTVXf9sb/9+ak07CG
         Pi+g==
X-Gm-Message-State: AOAM533x4NNHgGVuzDM7fftLnlWcWZ7cfhhj058NCSb+dg2c+ReMa/Am
        vhyRAORUBGHOTMNSYLoeuwLyBA==
X-Google-Smtp-Source: ABdhPJyfJZpN0/NtXoVnZWBeGTDPopXiCW6lJLYlIvbXSKJYUfQTSOe1iA+eiM//RcFU2NTvpMzPoA==
X-Received: by 2002:a05:6a00:18aa:b0:4fa:ac2e:a969 with SMTP id x42-20020a056a0018aa00b004faac2ea969mr10126678pfh.27.1648000413867;
        Tue, 22 Mar 2022 18:53:33 -0700 (PDT)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id u14-20020a056a00124e00b004fab8f3245fsm4278505pfi.149.2022.03.22.18.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 18:53:33 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Christoph Hellwig <hch@lst.de>
In-Reply-To: <20220323011308.2010380-1-ming.lei@redhat.com>
References: <20220323011308.2010380-1-ming.lei@redhat.com>
Subject: Re: [PATCH V2] block: avoid to call blkg_free() in atomic context
Message-Id: <164800041278.696497.7442688779865145159.b4-ty@kernel.dk>
Date:   Tue, 22 Mar 2022 19:53:32 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 23 Mar 2022 09:13:08 +0800, Ming Lei wrote:
> blkg_free() may be called in atomic context, either spin lock is held,
> or run in rcu callback. Meantime either request queue's release handler
> or ->pd_free_fn can sleep.
> 
> Fix the issue by scheduling work function for freeing blkcg_gq instance.
> 
> [  148.553894] BUG: sleeping function called from invalid context at block/blk-sysfs.c:767
> [  148.557381] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 0, name: swapper/13
> [  148.560741] preempt_count: 101, expected: 0
> [  148.562577] RCU nest depth: 0, expected: 0
> [  148.564379] 1 lock held by swapper/13/0:
> [  148.566127]  #0: ffffffff82615f80 (rcu_callback){....}-{0:0}, at: rcu_lock_acquire+0x0/0x1b
> [  148.569640] Preemption disabled at:
> [  148.569642] [<ffffffff8123f9c3>] ___slab_alloc+0x554/0x661
> [  148.573559] CPU: 13 PID: 0 Comm: swapper/13 Kdump: loaded Not tainted 5.17.0_up+ #110
> [  148.576834] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-1.fc33 04/01/2014
> [  148.579768] Call Trace:
> [  148.580567]  <IRQ>
> [  148.581262]  dump_stack_lvl+0x56/0x7c
> [  148.582367]  ? ___slab_alloc+0x554/0x661
> [  148.583526]  __might_resched+0x1af/0x1c8
> [  148.584678]  blk_release_queue+0x24/0x109
> [  148.585861]  kobject_cleanup+0xc9/0xfe
> [  148.586979]  blkg_free+0x46/0x63
> [  148.587962]  rcu_do_batch+0x1c5/0x3db
> [  148.589057]  rcu_core+0x14a/0x184
> [  148.590065]  __do_softirq+0x14d/0x2c7
> [  148.591167]  __irq_exit_rcu+0x7a/0xd4
> [  148.592264]  sysvec_apic_timer_interrupt+0x82/0xa5
> [  148.593649]  </IRQ>
> [  148.594354]  <TASK>
> [  148.595058]  asm_sysvec_apic_timer_interrupt+0x12/0x20
> 
> [...]

Applied, thanks!

[1/1] block: avoid to call blkg_free() in atomic context
      commit: d578c770c85233af592e54537f93f3831bde7e9a

Best regards,
-- 
Jens Axboe


