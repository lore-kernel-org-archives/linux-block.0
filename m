Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F75C43381
	for <linux-block@archiver.kernel.org>; Thu,  4 Mar 2021 08:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E719B64F32
	for <linux-block@archiver.kernel.org>; Thu,  4 Mar 2021 08:44:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236360AbhCDInl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Mar 2021 03:43:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234547AbhCDInX (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Mar 2021 03:43:23 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA230C061574;
        Thu,  4 Mar 2021 00:42:42 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id u3so27653428ybk.6;
        Thu, 04 Mar 2021 00:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NmRM3sYIpc+JfeFcnqxyssqX3kzXz1bFb3jPIvzSdLI=;
        b=dH55nG50FKKcIOxaEqqn/FpjNQnbFAV3Gu5yWHUOa88BbsbsADU78KJXJvtJ6AWsYj
         vwDlINbI8F0ol3zThwSuspll3yNYnUpMfmeH0qWOylwskbL4szfJkRMkbaDnfrZTAvk+
         S+Z44z6Kl0UmtFXGk0SZ4eLY12q8jBnXqMg08xbt7hpA0Et3ZGBf88gp9NnKlxtRSkfs
         96QEqwrAvu2WnOEMtUhpch9v3Qhrm+ABAP/6Q8+PokpzB4bHAjhmVQKhqdcDBnwmNxwd
         jC3Qdyh/EshvM7V/kRk67c5sEMw6fflO75KhXluF/vWfwODo8IVTY08kxoAkrVqEsMck
         hf8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NmRM3sYIpc+JfeFcnqxyssqX3kzXz1bFb3jPIvzSdLI=;
        b=e1Eepk+xDzl4OFR+IPp+zAaTXVIcTQnSiQ9/JoPnGioSxczG+qy6I26FgobNnijgJa
         LR8gjZ2OmK7cZHa6F0QJwfQ8REq2ojMuJlcBqoQ+FecNVfyiyFtJVKccz7x+lmZWACe4
         oVHGX5Wt8nW7S+4TWwdZJORZV9TrZVdgTLgwjZCpcOKDut8kDXXshqOtEvvFKLEgOecm
         FmNh5Ylycm9ixJ9wpNGszHmBYOuodYvnh5YXvODcNSGz4FgVSOibVSuFTXfvcsVdfibS
         OkBFc01iohzaGm8yN9L8idsNFy4jl6nB06dRvQDAfIdOq7e3gB2T9cMtQGbfrbAQuccx
         V7rA==
X-Gm-Message-State: AOAM532neBzQ+7ziMMnX94vGQIOiXGdNOCM6CQyshT/ck2Cp3Zd9RD/D
        zwVdFtBsyR8l1XdRazjAVL798+Eg9VXbgWqt30s=
X-Google-Smtp-Source: ABdhPJzAP9t4/OaHGhx76NmbSxvIxX80uTL22LyDwlvMGCs1RrGt/GyaXvH+lca2eqjZzmSZZXO2vG/IEI3QtExWt1M=
X-Received: by 2002:a25:b6c3:: with SMTP id f3mr4989236ybm.117.1614847362088;
 Thu, 04 Mar 2021 00:42:42 -0800 (PST)
MIME-Version: 1.0
References: <CABXGCsP63mN+G1xE7UBfVRuDRcJiRRC7EXU2y25f9rXkoU-0LQ@mail.gmail.com>
In-Reply-To: <CABXGCsP63mN+G1xE7UBfVRuDRcJiRRC7EXU2y25f9rXkoU-0LQ@mail.gmail.com>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Thu, 4 Mar 2021 16:42:30 +0800
Message-ID: <CACVXFVOy8928GNowCQRGQKQxuLtHn0V+pYk1kzeOyc0pyDvkjQ@mail.gmail.com>
Subject: Re: [bugreport 5.9-rc8] general protection fault, probably for
 non-canonical address 0x46b1b0f0d8856e4a: 0000 [#1] SMP NOPTI
To:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc:     linux-block <linux-block@vger.kernel.org>,
        Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@fb.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Oct 10, 2020 at 1:40 PM Mikhail Gavrilov
<mikhail.v.gavrilov@gmail.com> wrote:
>
> Paolo, Jens I am sorry for the noise.
> But today I hit the kernel panic and git blame said that you have
> created the file in which happened panic (this I saw from trace)
>
> $ /usr/src/kernels/`uname -r`/scripts/faddr2line
> /lib/debug/lib/modules/`uname -r`/vmlinux
> __bfq_deactivate_entity+0x15a
> __bfq_deactivate_entity+0x15a/0x240:
> bfq_gt at block/bfq-wf2q.c:20
> (inlined by) bfq_insert at block/bfq-wf2q.c:381
> (inlined by) bfq_idle_insert at block/bfq-wf2q.c:621
> (inlined by) __bfq_deactivate_entity at block/bfq-wf2q.c:1203
>
> https://github.com/torvalds/linux/blame/master/block/bfq-wf2q.c#L1203
>
> $ head /sys/block/*/queue/scheduler
> ==> /sys/block/nvme0n1/queue/scheduler <==
> [none] mq-deadline kyber bfq
>
> ==> /sys/block/sda/queue/scheduler <==
> mq-deadline kyber [bfq] none
>
> ==> /sys/block/zram0/queue/scheduler <==
> none
>
> Trace:
> general protection fault, probably for non-canonical address
> 0x46b1b0f0d8856e4a: 0000 [#1] SMP NOPTI
> CPU: 27 PID: 1018 Comm: kworker/27:1H Tainted: G        W
> --------- ---  5.9.0-0.rc8.28.fc34.x86_64 #1
> Hardware name: System manufacturer System Product Name/ROG STRIX
> X570-I GAMING, BIOS 2606 08/13/2020
> Workqueue: kblockd blk_mq_run_work_fn
> RIP: 0010:__bfq_deactivate_entity+0x15a/0x240
> Code: 48 2b 41 28 48 85 c0 7e 05 49 89 5c 24 18 49 8b 44 24 08 4d 8d
> 74 24 08 48 85 c0 0f 84 d6 00 00 00 48 8b 7b 28 eb 03 48 89 c8 <48> 8b
> 48 28 48 8d 70 10 48 8d 50 08 48 29 f9 48 85 c9 48 0f 4f d6
> RSP: 0018:ffffadf6c0c6fc00 EFLAGS: 00010002
> RAX: 46b1b0f0d8856e4a RBX: ffff8dc2773b5c88 RCX: 46b1b0f0d8856e4a
> RDX: ffff8dc7d02ed0a0 RSI: ffff8dc7d02ed0a8 RDI: 0000584e64e96beb
> RBP: ffff8dc2773b5c00 R08: ffff8dc9054cb938 R09: 0000000000000000
> R10: 0000000000000018 R11: 0000000000000018 R12: ffff8dc904927150
> R13: 0000000000000001 R14: ffff8dc904927158 R15: ffff8dc2773b5c88
> FS:  0000000000000000(0000) GS:ffff8dc90e0c0000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000003e8ebe4000 CR3: 00000007c2546000 CR4: 0000000000350ee0
> Call Trace:
>  bfq_deactivate_entity+0x4f/0xc0

Hello,

The same stack trace was observed in RH internal test too, and kernel
is 5.11.0-0.rc6,
but there isn't reproducer yet.


-- 
Ming Lei
