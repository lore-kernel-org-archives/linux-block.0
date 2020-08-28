Return-Path: <SRS0=Mrne=CG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 590F1C433E2
	for <linux-block@archiver.kernel.org>; Fri, 28 Aug 2020 13:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 354B420825
	for <linux-block@archiver.kernel.org>; Fri, 28 Aug 2020 13:06:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RMA7AibI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726904AbgH1NFw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Aug 2020 09:05:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58074 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729123AbgH1NFq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Aug 2020 09:05:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598619931;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ecx9k3rvYpru2po9U3jgFYCT/S2916EODCpUn183XNs=;
        b=RMA7AibIIojZLfe/WFymlZy3GYRdbykto7U3LQlT08Vj6Ra6U9PjCSTopM4ujzNpzDnQuX
        Fkl6N9x9Dg+sHoVtKukDWdB2v+WphDT3hljG2yKnCYFqeDGW0vM+mYNnxROYncFdX3zr0o
        OBML8Ze8S8ydGbzDGi7vtzrDhoGznvg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-554-1m2dBXBkMteBDZLfVsXmIA-1; Fri, 28 Aug 2020 09:05:27 -0400
X-MC-Unique: 1m2dBXBkMteBDZLfVsXmIA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 022B6189E62D;
        Fri, 28 Aug 2020 13:05:26 +0000 (UTC)
Received: from T590 (ovpn-13-119.pek2.redhat.com [10.72.13.119])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 13FA97D679;
        Fri, 28 Aug 2020 13:05:18 +0000 (UTC)
Date:   Fri, 28 Aug 2020 21:05:14 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     Yufen Yu <yuyufen@huawei.com>, Hou Tao <houtao1@huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>
Subject: Re: Sleeping while atomic regression around hd_struct_free() in
 5.9-rc
Message-ID: <20200828130514.GA236174@T590>
References: <CAOi1vP9t1VL-JXj9ETdU_B1kMLjKGcW6wZss6bmxoH5UCAcK7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOi1vP9t1VL-JXj9ETdU_B1kMLjKGcW6wZss6bmxoH5UCAcK7Q@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Ilya,

Thanks for your report!

On Fri, Aug 28, 2020 at 12:32:48PM +0200, Ilya Dryomov wrote:
> Hi Ming,
> 
> There seems to be a sleeping while atomic bug in hd_struct_free():
> 
> 288 static void hd_struct_free(struct percpu_ref *ref)
> 289 {
> 290         struct hd_struct *part = container_of(ref, struct hd_struct, ref);
> 291         struct gendisk *disk = part_to_disk(part);
> 292         struct disk_part_tbl *ptbl =
> 293                 rcu_dereference_protected(disk->part_tbl, 1);
> 294
> 295         rcu_assign_pointer(ptbl->last_lookup, NULL);
> 296         put_device(disk_to_dev(disk));
> 297
> 298         INIT_RCU_WORK(&part->rcu_work, hd_struct_free_work);
> 299         queue_rcu_work(system_wq, &part->rcu_work);
> 300 }
> 
> hd_struct_free() is a percpu_ref release callback and must not sleep.
> But put_device() can end up in disk_release(), resulting in anything
> from "sleeping function called from invalid context" splats to actual
> lockups if the queue ends up being released:
> 
>   BUG: scheduling while atomic: ksoftirqd/3/26/0x00000102
>   INFO: lockdep is turned off.
>   CPU: 3 PID: 26 Comm: ksoftirqd/3 Tainted: G        W
> 5.9.0-rc2-ceph-g2de49bea2ebc #1
>   Hardware name: Supermicro SYS-5018R-WR/X10SRW-F, BIOS 2.0 12/17/2015
>   Call Trace:
>    dump_stack+0x96/0xd0
>    __schedule_bug.cold+0x64/0x71
>    __schedule+0x8ea/0xac0
>    ? wait_for_completion+0x86/0x110
>    schedule+0x5f/0xd0
>    schedule_timeout+0x212/0x2a0
>    ? wait_for_completion+0x86/0x110
>    wait_for_completion+0xb0/0x110
>    __wait_rcu_gp+0x139/0x150
>    synchronize_rcu+0x79/0xf0
>    ? invoke_rcu_core+0xb0/0xb0
>    ? rcu_read_lock_any_held+0xb0/0xb0
>    blk_free_flush_queue+0x17/0x30
>    blk_mq_hw_sysfs_release+0x32/0x70
>    kobject_put+0x7d/0x1d0
>    blk_mq_release+0xbe/0xf0
>    blk_release_queue+0xb7/0x140
>    kobject_put+0x7d/0x1d0
>    disk_release+0xb0/0xc0
>    device_release+0x25/0x80
>    kobject_put+0x7d/0x1d0
>    hd_struct_free+0x4c/0xc0
>    percpu_ref_switch_to_atomic_rcu+0x1df/0x1f0
>    rcu_core+0x3fd/0x660
>    ? rcu_core+0x3cc/0x660
>    __do_softirq+0xd5/0x45e
>    ? smpboot_thread_fn+0x26/0x1d0
>    run_ksoftirqd+0x30/0x60
>    smpboot_thread_fn+0xfe/0x1d0
>    ? sort_range+0x20/0x20
>    kthread+0x11a/0x150
>    ? kthread_delayed_work_timer_fn+0xa0/0xa0
>    ret_from_fork+0x1f/0x30
> 
> "git blame" points at your commit tb7d6c3033323 ("block: fix
> use-after-free on cached last_lookup partition"), but there is
> likely more to it because it went into 5.8 and I haven't seen
> these lockups until we rebased to 5.9-rc.

The pull-the-trigger commit is actually e8c7d14ac6c3 ("block: revert back to
synchronous request_queue removal").

> 
> Could you please take a look?

Can you try the following patch?

diff --git a/block/partitions/core.c b/block/partitions/core.c
index e62a98a8eeb7..b06fc3425802 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -278,6 +278,15 @@ static void hd_struct_free_work(struct work_struct *work)
 {
 	struct hd_struct *part =
 		container_of(to_rcu_work(work), struct hd_struct, rcu_work);
+	struct gendisk *disk = part_to_disk(part);
+
+	/*
+	 * Release the reference grabbed in delete_partition, and it should
+	 * have been done in hd_struct_free(), however device's release
+	 * handler can't be done in percpu_ref's ->release() callback
+	 * because it is run via call_rcu().
+	 */
+	put_device(disk_to_dev(disk));
 
 	part->start_sect = 0;
 	part->nr_sects = 0;
@@ -293,7 +302,6 @@ static void hd_struct_free(struct percpu_ref *ref)
 		rcu_dereference_protected(disk->part_tbl, 1);
 
 	rcu_assign_pointer(ptbl->last_lookup, NULL);
-	put_device(disk_to_dev(disk));
 
 	INIT_RCU_WORK(&part->rcu_work, hd_struct_free_work);
 	queue_rcu_work(system_wq, &part->rcu_work);



Thanks,
Ming

