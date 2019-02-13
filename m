Return-Path: <SRS0=Y8Hj=QU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CECFC282C2
	for <linux-block@archiver.kernel.org>; Wed, 13 Feb 2019 04:27:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01F37222B6
	for <linux-block@archiver.kernel.org>; Wed, 13 Feb 2019 04:27:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jUGir3ab"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729234AbfBME13 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Feb 2019 23:27:29 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51027 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbfBME13 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Feb 2019 23:27:29 -0500
Received: by mail-wm1-f67.google.com with SMTP id x7so892819wmj.0
        for <linux-block@vger.kernel.org>; Tue, 12 Feb 2019 20:27:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S27Y/k0YS2Qp4xxodm73GD/YeY7V4Ydz/jo2k+BsWYg=;
        b=jUGir3abyurgE2sx4/fYPLEPZyPZ1+WQFnlvB4XtyDMIkk7Zjy53EfbWPOqc7Ua83x
         fbYTcvsoJlSrxrYbnpTrgiHupGF/ZcQSR3rgBQB/NTLiPJilvyGmy6r0w6MQME+qJSef
         LcHRy6KO/PVdz+SwGVI3QT9cXdHup+Ysl3XivBPzhwjg0Db00zE9bRMo1NfcOXvPQQw9
         BYaZt/SNn2b1bKp4adKE/X/Ar05fWf6TSYplp1A+JqJfxoHr9BRlz2NHM8xmF85bldFT
         upsm44Jize5HLmdgZ8lbWx74B76MMzbL+e+NRRRurlfFOwRE25dszf7DprFLzQv7hK4O
         lU7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S27Y/k0YS2Qp4xxodm73GD/YeY7V4Ydz/jo2k+BsWYg=;
        b=c8NdQ24NT6kNsDQa9gdLWx0lxryDwHN4eTIuBoMHbU28Q5N+a1LkMn6ZL1mXIihjCV
         ybeB938fatISYEC2oPWp4mGUDSS+/rAJjo/5eFvY23vuu+T9QR96ptu+Z8Oaq/TaaxWV
         IaOmQxKzyHxY8k9FFOgmBP/tXqwAOOtLa88T5YEimVYg6ZhPl8T5qGBJr7xmi2HTxdwM
         QZCl3bJxefU9dPi+EThUQbLmKchQ1sEuw3uSCjB6IeONEaGozkbHum4/kDUmDdCD2lTT
         6uvDrXDgERvPUVP7Eg55OiShvqZosMuYN12lN+uUA+WJUZgTgUwsxZ7hdoN4uqH8R62i
         LXgQ==
X-Gm-Message-State: AHQUAuYb7PFz0GKL97BcWANJPSU5p0tKA2iOHhzQNmFyQwsAAAyyGaUR
        aKYejDw5r6EMf3mZmfziD5vQZR/eoTYvc8uyAAM=
X-Google-Smtp-Source: AHgI3Ibmjn3EthIQw1RrqV+yPBMhPu/vRtVKBW1rNvpewKrXqNfsLfMg1GiEGT/ZgLcp481CEFAzHggNqJZV+3Jp/xw=
X-Received: by 2002:a7b:c853:: with SMTP id c19mr1412510wml.61.1550032046978;
 Tue, 12 Feb 2019 20:27:26 -0800 (PST)
MIME-Version: 1.0
References: <20190212163137.GA7701@mit.edu>
In-Reply-To: <20190212163137.GA7701@mit.edu>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Wed, 13 Feb 2019 12:27:14 +0800
Message-ID: <CACVXFVNWK7QC+463cbMKE4T36O72Qvkx6AjbW2RZtJX3H4RM9g@mail.gmail.com>
Subject: Re: blktests nvme/012 triggering LOCKDEP warning
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Feb 13, 2019 at 12:33 AM Theodore Y. Ts'o <tytso@mit.edu> wrote:
>
> Is this a known issue?  nvme/012 is triggering the following lockdep warning:
>
> Thanks,
>
>                                         - Ted
>
> [ 1964.751910] run blktests nvme/012 at 2019-02-11 20:58:31
> [ 1964.977624] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
> [ 1965.006395] nvmet: creating controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:8a58b187-6d09-4c5d-bc03-593896d2d80d.
> [ 1965.011811] nvme nvme0: ANA group 1: optimized.
> [ 1965.011899] nvme nvme0: creating 2 I/O queues.
> [ 1965.013966] nvme nvme0: new ctrl: "blktests-subsystem-1"
>
> [ 1965.282478] ============================================
> [ 1965.287922] WARNING: possible recursive locking detected
> [ 1965.293364] 5.0.0-rc3-xfstests-00015-g1236f7d60242 #841 Not tainted
> [ 1965.299762] --------------------------------------------
> [ 1965.305207] ksoftirqd/1/16 is trying to acquire lock:
> [ 1965.310389] 000000000282032e (&(&fq->mq_flush_lock)->rlock){..-.}, at: flush_end_io+0x4e/0x1d0
> [ 1965.319146]
>                but task is already holding lock:
> [ 1965.325106] 00000000cbadcbc2 (&(&fq->mq_flush_lock)->rlock){..-.}, at: flush_end_io+0x4e/0x1d0
> [ 1965.333957]
>                other info that might help us debug this:
> [ 1965.340615]  Possible unsafe locking scenario:
>
> [ 1965.346664]        CPU0
> [ 1965.349248]        ----
> [ 1965.351820]   lock(&(&fq->mq_flush_lock)->rlock);
> [ 1965.356654]   lock(&(&fq->mq_flush_lock)->rlock);
> [ 1965.361490]
>                 *** DEADLOCK ***
>
> [ 1965.367541]  May be due to missing lock nesting notation
>
> [ 1965.374636] 1 lock held by ksoftirqd/1/16:
> [ 1965.378890]  #0: 00000000cbadcbc2 (&(&fq->mq_flush_lock)->rlock){..-.}, at: flush_end_io+0x4e/0x1d0
> [ 1965.388080]
>                stack backtrace:
> [ 1965.392570] CPU: 1 PID: 16 Comm: ksoftirqd/1 Not tainted 5.0.0-rc3-xfstests-00015-g1236f7d60242 #841
> [ 1965.402002] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> [ 1965.411411] Call Trace:
> [ 1965.413996]  dump_stack+0x67/0x90
> [ 1965.417433]  __lock_acquire.cold.45+0x2b4/0x313
> [ 1965.422194]  lock_acquire+0x98/0x160
> [ 1965.425894]  ? flush_end_io+0x4e/0x1d0
> [ 1965.429817]  _raw_spin_lock_irqsave+0x3b/0x80
> [ 1965.434299]  ? flush_end_io+0x4e/0x1d0
> [ 1965.438162]  flush_end_io+0x4e/0x1d0
> [ 1965.441909]  blk_mq_complete_request+0x76/0x110
> [ 1965.446580]  nvmet_req_complete+0x15/0x110 [nvmet]
> [ 1965.452098]  nvmet_bio_done+0x27/0x50 [nvmet]
> [ 1965.456634]  blk_update_request+0xd7/0x2d0
> [ 1965.460869]  blk_mq_end_request+0x1a/0x100
> [ 1965.465091]  blk_flush_complete_seq+0xe5/0x350
> [ 1965.469660]  flush_end_io+0x12f/0x1d0
> [ 1965.473436]  blk_done_softirq+0x9f/0xd0
> [ 1965.477398]  __do_softirq+0xca/0x440
> [ 1965.481092]  ? smpboot_thread_fn+0x2f/0x1e0
> [ 1965.485512]  ? smpboot_thread_fn+0x74/0x1e0
> [ 1965.489813]  ? smpboot_thread_fn+0x118/0x1e0
> [ 1965.494379]  run_ksoftirqd+0x24/0x50
> [ 1965.498081]  smpboot_thread_fn+0x113/0x1e0
> [ 1965.502399]  ? sort_range+0x20/0x20
> [ 1965.506008]  kthread+0x121/0x140
> [ 1965.509395]  ? kthread_park+0x80/0x80
> [ 1965.513290]  ret_from_fork+0x3a/0x50
> [ 1965.527032] XFS (nvme0n1): Mounting V5 Filesystem
> [ 1965.541778] XFS (nvme0n1): Ending clean mount
> [ 2064.142830] XFS (nvme0n1): Unmounting Filesystem
> [ 2064.171432] nvme nvme0: Removing ctrl: NQN "blktests-subsystem-1"

That is a false positive.

It is caused by calling host request's completion handler from target
IO's completion
handler directly, and this way should be nvme-loop only.

We may need to annotate the locks in .end_io of blk-flush for avoiding
this warning.

BTW, this way of nvme-loop handling IO completion may trigger soft lockup too.

Thanks,
Ming Lei
