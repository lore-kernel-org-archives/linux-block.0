Return-Path: <SRS0=Mrne=CG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC22C433E6
	for <linux-block@archiver.kernel.org>; Fri, 28 Aug 2020 10:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E60B62086A
	for <linux-block@archiver.kernel.org>; Fri, 28 Aug 2020 10:33:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JAUbd1/A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729036AbgH1KdJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Aug 2020 06:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728362AbgH1KdC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Aug 2020 06:33:02 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C55DAC061264
        for <linux-block@vger.kernel.org>; Fri, 28 Aug 2020 03:33:01 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id t13so424674ile.9
        for <linux-block@vger.kernel.org>; Fri, 28 Aug 2020 03:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=PLxXJYd4LEAKANbzRKRQK4gFdQtPTN3mlgLvw5tAkRc=;
        b=JAUbd1/Ad9cvSj/laanK7YkYrmdNSuJmxPtojn7T5MmEvMsy6Y6y/auKhab96sqdwD
         KUkEzE3nMyRzSEm3bC5wfsB+OKG9DEeb+KyAdTok8uujZU9F5O684tXgtNjYvApIhxLy
         OBE4vRNPIEKNuft9j6A9iNJ4EpFIl/v8OtQtntIY6TmS+5tpxwYxwZWKWce5+EMc4way
         L4gHHHqED4dYLmdb99aM87F9i1qS/uRY+EslqHpX7eSsj1VLBn0zO0R4DnVWKdJ6xO8g
         o4FAW8CQvTVEVf8egvk5ypT2MlMNT3sk9zcYOZiHu7PlfJbQFuHpEm6RWSGGdXDY6FU1
         XkrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=PLxXJYd4LEAKANbzRKRQK4gFdQtPTN3mlgLvw5tAkRc=;
        b=AdkxW2fM4Q6bzlmedselBvGcizURifPIRmn0xbsDEkm3C9Fk1tRam2Vvbby154PULs
         tDpbNChHdb9BUwN4zsE5s4SUBqHSuZjdzI2Xop8kyvviAdU4Nr8PtUP17l0gmGs7H4Jh
         tEhJDyX60sGDLGNNel1lzHgUyfOD0Oz7l47C/YFsFYzWigWouIPA/U+EU6bz8WfUf17J
         E6JbKTFxAd8uZHaxu8UdgN6zNbXcO6ayuaHasKmPEkJETPGqpKGMWeXYwMqirX7GFYwS
         R5+h0re6gyEFiWa6SVa7kRo3rh5WLnL//cONUAvRnDUE6qWDD7L/GdnyWjorfhrX7rrb
         4G7A==
X-Gm-Message-State: AOAM531Q3AANwawb9S6WgMkG7BXzCwviptXGMPEW3thhhtfpFooYGOyW
        UcuLH+MsDW/R/Dt+3EkD98AsAYy+QqL/MmV5i7o=
X-Google-Smtp-Source: ABdhPJzWwc5fkA6vOtTrkGJLSonIafetm7okuyBgYyPhvPdtfRC+8JocmRBvySwO9gF+XppZqIB3L0tL+58eD6S0uzE=
X-Received: by 2002:a92:8708:: with SMTP id m8mr928247ild.19.1598610779908;
 Fri, 28 Aug 2020 03:32:59 -0700 (PDT)
MIME-Version: 1.0
From:   Ilya Dryomov <idryomov@gmail.com>
Date:   Fri, 28 Aug 2020 12:32:48 +0200
Message-ID: <CAOi1vP9t1VL-JXj9ETdU_B1kMLjKGcW6wZss6bmxoH5UCAcK7Q@mail.gmail.com>
Subject: Sleeping while atomic regression around hd_struct_free() in 5.9-rc
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

Hi Ming,

There seems to be a sleeping while atomic bug in hd_struct_free():

288 static void hd_struct_free(struct percpu_ref *ref)
289 {
290         struct hd_struct *part = container_of(ref, struct hd_struct, ref);
291         struct gendisk *disk = part_to_disk(part);
292         struct disk_part_tbl *ptbl =
293                 rcu_dereference_protected(disk->part_tbl, 1);
294
295         rcu_assign_pointer(ptbl->last_lookup, NULL);
296         put_device(disk_to_dev(disk));
297
298         INIT_RCU_WORK(&part->rcu_work, hd_struct_free_work);
299         queue_rcu_work(system_wq, &part->rcu_work);
300 }

hd_struct_free() is a percpu_ref release callback and must not sleep.
But put_device() can end up in disk_release(), resulting in anything
from "sleeping function called from invalid context" splats to actual
lockups if the queue ends up being released:

  BUG: scheduling while atomic: ksoftirqd/3/26/0x00000102
  INFO: lockdep is turned off.
  CPU: 3 PID: 26 Comm: ksoftirqd/3 Tainted: G        W
5.9.0-rc2-ceph-g2de49bea2ebc #1
  Hardware name: Supermicro SYS-5018R-WR/X10SRW-F, BIOS 2.0 12/17/2015
  Call Trace:
   dump_stack+0x96/0xd0
   __schedule_bug.cold+0x64/0x71
   __schedule+0x8ea/0xac0
   ? wait_for_completion+0x86/0x110
   schedule+0x5f/0xd0
   schedule_timeout+0x212/0x2a0
   ? wait_for_completion+0x86/0x110
   wait_for_completion+0xb0/0x110
   __wait_rcu_gp+0x139/0x150
   synchronize_rcu+0x79/0xf0
   ? invoke_rcu_core+0xb0/0xb0
   ? rcu_read_lock_any_held+0xb0/0xb0
   blk_free_flush_queue+0x17/0x30
   blk_mq_hw_sysfs_release+0x32/0x70
   kobject_put+0x7d/0x1d0
   blk_mq_release+0xbe/0xf0
   blk_release_queue+0xb7/0x140
   kobject_put+0x7d/0x1d0
   disk_release+0xb0/0xc0
   device_release+0x25/0x80
   kobject_put+0x7d/0x1d0
   hd_struct_free+0x4c/0xc0
   percpu_ref_switch_to_atomic_rcu+0x1df/0x1f0
   rcu_core+0x3fd/0x660
   ? rcu_core+0x3cc/0x660
   __do_softirq+0xd5/0x45e
   ? smpboot_thread_fn+0x26/0x1d0
   run_ksoftirqd+0x30/0x60
   smpboot_thread_fn+0xfe/0x1d0
   ? sort_range+0x20/0x20
   kthread+0x11a/0x150
   ? kthread_delayed_work_timer_fn+0xa0/0xa0
   ret_from_fork+0x1f/0x30

"git blame" points at your commit tb7d6c3033323 ("block: fix
use-after-free on cached last_lookup partition"), but there is
likely more to it because it went into 5.8 and I haven't seen
these lockups until we rebased to 5.9-rc.

Could you please take a look?

Thanks,

                Ilya
