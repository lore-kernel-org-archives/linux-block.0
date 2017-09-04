Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:33624 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753354AbdIDJSR (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Sep 2017 05:18:17 -0400
Received: by mail-wm0-f45.google.com with SMTP id f145so3146785wme.0
        for <linux-block@vger.kernel.org>; Mon, 04 Sep 2017 02:18:16 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: Memory leak in BFQ?
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <1504212121.31872.44.camel@wdc.com>
Date: Mon, 4 Sep 2017 11:18:13 +0200
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Message-Id: <3009D2F3-D230-4A7B-A7CE-2CC4374F53BE@linaro.org>
References: <1504212121.31872.44.camel@wdc.com>
To: Bart Van Assche <bart.vanassche@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


> Il giorno 31 ago 2017, alle ore 22:42, Bart Van Assche =
<bart.vanassche@wdc.com> ha scritto:
>=20
> Hello Paolo,
>=20
> If I run the following commands:
>=20
> # echo bfq > /sys/block/sda/queue/scheduler=20
> # echo 3 >/proc/sys/vm/drop_caches; find / -xdev >/dev/null
> # echo none > /sys/block/sda/queue/scheduler
> # echo scan > /sys/kernel/debug/kmemleak
>=20
> Then kmemleak reports the following:
>=20
> unreferenced object 0xffff880405149158 (size 4096):
>  comm "bash", pid 1716, jiffies 4294960386 (age 75256.970s)
>  hex dump (first 32 bytes):
>    48 a5 f4 a3 04 88 ff ff 01 00 00 00 00 00 00 00  H...............
>    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>  backtrace:
>    [<ffffffff8165a50a>] kmemleak_alloc+0x4a/0xa0
>    [<ffffffff811f5114>] kmem_cache_alloc_node_trace+0x154/0x310
>    [<ffffffffa07087bc>] bfq_pd_alloc+0x3c/0x3f0 [bfq]
>    [<ffffffff8130e4bc>] blkcg_activate_policy+0xac/0x170
>    [<ffffffffa0709b4c>] bfq_create_group_hierarchy+0x1c/0x66 [bfq]
>    [<ffffffffa070277b>] bfq_init_queue+0x28b/0x350 [bfq]
>    [<ffffffff8130223b>] blk_mq_init_sched+0xbb/0x150
>    [<ffffffff812e6b42>] elevator_switch+0x62/0x210
>    [<ffffffff812e7ca2>] elv_iosched_store+0xe2/0x180
>    [<ffffffff812f23a9>] queue_attr_store+0x59/0x90
>    [<ffffffff812ac715>] sysfs_kf_write+0x45/0x60
>    [<ffffffff812abfd4>] kernfs_fop_write+0x124/0x1c0
>    [<ffffffff8121d218>] __vfs_write+0x28/0x150
>    [<ffffffff8121e7e7>] vfs_write+0xc7/0x1b0
>    [<ffffffff8121fd69>] SyS_write+0x49/0xa0
>    [<ffffffff81667c2a>] entry_SYSCALL_64_fastpath+0x18/0xad
>=20
> Could this indicate a memory leak in the BFQ code?
>=20

I guess so.  But I've been trying to reproduce it at no avail.  Is it
readily reproducible in your system?  If so, did you happen, by chance,
to find also some other way to reproduce it?

Thanks,
Paolo

> Thanks,
>=20
> Bart.
