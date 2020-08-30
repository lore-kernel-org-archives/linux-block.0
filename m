Return-Path: <SRS0=wgWW=CI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 921E9C433E6
	for <linux-block@archiver.kernel.org>; Sun, 30 Aug 2020 08:46:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68A422078D
	for <linux-block@archiver.kernel.org>; Sun, 30 Aug 2020 08:46:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k8Lxdr43"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728721AbgH3Iqk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 30 Aug 2020 04:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgH3Iqk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 30 Aug 2020 04:46:40 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C00C061573
        for <linux-block@vger.kernel.org>; Sun, 30 Aug 2020 01:46:40 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id d190so2196332iof.3
        for <linux-block@vger.kernel.org>; Sun, 30 Aug 2020 01:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h3w1yjIrGV5uG9yyuRm0twJT0Zd2/unCCmClMtzDTT0=;
        b=k8Lxdr43Vtm1djicIG2IEN+ngb6ViU80UdtlefUZ8nd9sDlmFYIhvMlkcB8PYpEiDz
         cga34VioWrHtaIXIJepyM/Q8TDoCD3avnZfyHgiQKs/JTefpsrztQPLRiwyVk5cV4fnE
         VT/FD1GTr4agXBEHrzh4J5XG/vf+UAF5IsZZEpCwCUsZTlQWjRbI4BoYEnjANyyOU5gF
         EEWxb8pyMBILWs5yYL1ixFrWxCY7ORJTjF4dB6IO2xHG0UMuQf+5skrCoJhFvq28QIDP
         MgNHxS252WPBq5IPpb+jq3TIbbzG5mHldywLSFdqXRgmennLa5E0WxaPL2/EZaR7E+QB
         xSCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h3w1yjIrGV5uG9yyuRm0twJT0Zd2/unCCmClMtzDTT0=;
        b=rPmaVgHBEMuQdnt8RVt0KpOXPMUSSkhwfjHOtDlu5Y4Le75upQsjMR2dVfID/Zxc7W
         7+uPuDNHR1kmT2h44G8vHLPxyBqh8Y37BNaZ1rzDAqXZZHAne0C7mxNWcU2gpFdhNe4B
         yQdTj2Mjo4MMMq5LiaIA3024ejk114xNbDwHUXOvxLtZ8U9epko3rcS6OBDwFmBokAXH
         IrYJR69YlSalbBlzuQaT38NleeaEjsrE0gN67531jBV3JpWa9wXgDU42NmtscqwL+AC4
         cfArgZbMlkEAxc2A0pssondyw2eKLo5uj94Z39DDnZ6X8fpakXfTKTKPYgAkyjDZeypK
         hwWg==
X-Gm-Message-State: AOAM531GrrLUQ+WaQV0dS7BvjUlsTUgVWpAheZXukW4StFr64ldXrG6J
        GEEMGU6c0b7+hJFBY/OTD+hT6szGUHvE0sg33pY=
X-Google-Smtp-Source: ABdhPJwxEhT56fpWwSuH/cojcWmJfPGV22iXWtOAIOZoqBkgjx9RgGHkQlxRsgiW1ja8GmU7HtN3rNABfxtXvyO5ZMw=
X-Received: by 2002:a6b:7f0b:: with SMTP id l11mr4788002ioq.182.1598777199331;
 Sun, 30 Aug 2020 01:46:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAOi1vP9t1VL-JXj9ETdU_B1kMLjKGcW6wZss6bmxoH5UCAcK7Q@mail.gmail.com>
 <20200828130514.GA236174@T590>
In-Reply-To: <20200828130514.GA236174@T590>
From:   Ilya Dryomov <idryomov@gmail.com>
Date:   Sun, 30 Aug 2020 10:46:27 +0200
Message-ID: <CAOi1vP95ZWx1uXvqSJmjS54Wdp-icGNk+OzQ_E9gDhNpfk4sVw@mail.gmail.com>
Subject: Re: Sleeping while atomic regression around hd_struct_free() in 5.9-rc
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Yufen Yu <yuyufen@huawei.com>, Hou Tao <houtao1@huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Aug 28, 2020 at 3:05 PM Ming Lei <ming.lei@redhat.com> wrote:
>
> Hi Ilya,
>
> Thanks for your report!
>
> On Fri, Aug 28, 2020 at 12:32:48PM +0200, Ilya Dryomov wrote:
> > Hi Ming,
> >
> > There seems to be a sleeping while atomic bug in hd_struct_free():
> >
> > 288 static void hd_struct_free(struct percpu_ref *ref)
> > 289 {
> > 290         struct hd_struct *part = container_of(ref, struct hd_struct, ref);
> > 291         struct gendisk *disk = part_to_disk(part);
> > 292         struct disk_part_tbl *ptbl =
> > 293                 rcu_dereference_protected(disk->part_tbl, 1);
> > 294
> > 295         rcu_assign_pointer(ptbl->last_lookup, NULL);
> > 296         put_device(disk_to_dev(disk));
> > 297
> > 298         INIT_RCU_WORK(&part->rcu_work, hd_struct_free_work);
> > 299         queue_rcu_work(system_wq, &part->rcu_work);
> > 300 }
> >
> > hd_struct_free() is a percpu_ref release callback and must not sleep.
> > But put_device() can end up in disk_release(), resulting in anything
> > from "sleeping function called from invalid context" splats to actual
> > lockups if the queue ends up being released:
> >
> >   BUG: scheduling while atomic: ksoftirqd/3/26/0x00000102
> >   INFO: lockdep is turned off.
> >   CPU: 3 PID: 26 Comm: ksoftirqd/3 Tainted: G        W
> > 5.9.0-rc2-ceph-g2de49bea2ebc #1
> >   Hardware name: Supermicro SYS-5018R-WR/X10SRW-F, BIOS 2.0 12/17/2015
> >   Call Trace:
> >    dump_stack+0x96/0xd0
> >    __schedule_bug.cold+0x64/0x71
> >    __schedule+0x8ea/0xac0
> >    ? wait_for_completion+0x86/0x110
> >    schedule+0x5f/0xd0
> >    schedule_timeout+0x212/0x2a0
> >    ? wait_for_completion+0x86/0x110
> >    wait_for_completion+0xb0/0x110
> >    __wait_rcu_gp+0x139/0x150
> >    synchronize_rcu+0x79/0xf0
> >    ? invoke_rcu_core+0xb0/0xb0
> >    ? rcu_read_lock_any_held+0xb0/0xb0
> >    blk_free_flush_queue+0x17/0x30
> >    blk_mq_hw_sysfs_release+0x32/0x70
> >    kobject_put+0x7d/0x1d0
> >    blk_mq_release+0xbe/0xf0
> >    blk_release_queue+0xb7/0x140
> >    kobject_put+0x7d/0x1d0
> >    disk_release+0xb0/0xc0
> >    device_release+0x25/0x80
> >    kobject_put+0x7d/0x1d0
> >    hd_struct_free+0x4c/0xc0
> >    percpu_ref_switch_to_atomic_rcu+0x1df/0x1f0
> >    rcu_core+0x3fd/0x660
> >    ? rcu_core+0x3cc/0x660
> >    __do_softirq+0xd5/0x45e
> >    ? smpboot_thread_fn+0x26/0x1d0
> >    run_ksoftirqd+0x30/0x60
> >    smpboot_thread_fn+0xfe/0x1d0
> >    ? sort_range+0x20/0x20
> >    kthread+0x11a/0x150
> >    ? kthread_delayed_work_timer_fn+0xa0/0xa0
> >    ret_from_fork+0x1f/0x30
> >
> > "git blame" points at your commit tb7d6c3033323 ("block: fix
> > use-after-free on cached last_lookup partition"), but there is
> > likely more to it because it went into 5.8 and I haven't seen
> > these lockups until we rebased to 5.9-rc.
>
> The pull-the-trigger commit is actually e8c7d14ac6c3 ("block: revert back to
> synchronous request_queue removal").
>
> >
> > Could you please take a look?
>
> Can you try the following patch?
>
> diff --git a/block/partitions/core.c b/block/partitions/core.c
> index e62a98a8eeb7..b06fc3425802 100644
> --- a/block/partitions/core.c
> +++ b/block/partitions/core.c
> @@ -278,6 +278,15 @@ static void hd_struct_free_work(struct work_struct *work)
>  {
>         struct hd_struct *part =
>                 container_of(to_rcu_work(work), struct hd_struct, rcu_work);
> +       struct gendisk *disk = part_to_disk(part);
> +
> +       /*
> +        * Release the reference grabbed in delete_partition, and it should
> +        * have been done in hd_struct_free(), however device's release
> +        * handler can't be done in percpu_ref's ->release() callback
> +        * because it is run via call_rcu().
> +        */
> +       put_device(disk_to_dev(disk));
>
>         part->start_sect = 0;
>         part->nr_sects = 0;
> @@ -293,7 +302,6 @@ static void hd_struct_free(struct percpu_ref *ref)
>                 rcu_dereference_protected(disk->part_tbl, 1);
>
>         rcu_assign_pointer(ptbl->last_lookup, NULL);
> -       put_device(disk_to_dev(disk));
>
>         INIT_RCU_WORK(&part->rcu_work, hd_struct_free_work);
>         queue_rcu_work(system_wq, &part->rcu_work);

This patch fixes it for me.

Thanks,

                Ilya
