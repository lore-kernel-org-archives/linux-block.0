Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f177.google.com ([209.85.192.177]:36306 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752301AbcKRQQn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Nov 2016 11:16:43 -0500
Received: by mail-pf0-f177.google.com with SMTP id 189so55469344pfz.3
        for <linux-block@vger.kernel.org>; Fri, 18 Nov 2016 08:16:43 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.1 \(3251\))
Subject: Re: [PATCH] lightnvm: physical block device (pblk) target
From: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <jg@lightnvm.io>
In-Reply-To: <1479481388-32459-1-git-send-email-javier@cnexlabs.com>
Date: Fri, 18 Nov 2016 17:16:35 +0100
Cc: =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <3D20D2D2-64BF-4C49-9FBA-94263B885603@lightnvm.io>
References: <1479481388-32459-1-git-send-email-javier@cnexlabs.com>
To: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <jg@lightnvm.io>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This patch applies on top of Matias' for-4.10/core [1]. Development is
taking place on [1]; branches named pblk.X are new releases that are
rebased on each new kernel release until merged.

A couple of extra features will be added before posting for merging, but
the core of the functionality is present. Comments on current and
missing functionality, code and style and more than welcome.

Documentation on how to instantiate a lightnvm target can be found in
[2]. After it is instantiated, pblk should behave like a normal block
device. pblk specific documentation in /Documentation will follow on the
merge patch. General information on the Open-Channel SSD project can be
seen in [3].

[1] https://github.com/OpenChannelSSD/linux
[2] http://openchannelssd.readthedocs.io/en/latest/
[3] http://lightnvm.io


Thanks,
Javier

> On 18 Nov 2016, at 16.03, Javier Gonz=C3=A1lez <jg@lightnvm.io> wrote:
>=20
> This patch introduces a new LightNVM target implementing a full
> host-based Flash Translation Layer (FTL): pblk. It differs from the
> existing rrpc target in that rrpc is a hybrid approach, where
> the L2P table is maintained both on the host and on the device.
>=20
> pblk operates around a ring write buffer. Apart from buffering writes,
> this buffer allows to respect controller constrains on how flash pages
> must be written. The write buffer is complemented with a write context
> buffer, which stores metadata for each 4KB write. With regards to the
> mapping strategy, we follow a late-map approach, where the actual
> mapping to flash pages is done when the write buffer is being written =
to
> the media. Logical addresses are mapped physical flash pages in a
> round-robin fashion in relation to the active LUNs on the target.
>=20
> Apart from the typical head an tail pointers, the write buffer =
maintains
> a number of pointers to:
>  - Submission pointer: Keeps track of the last entry submitted to the
>    media.
>  - Sync pointer: Keeps track of entries successfully stored on the
>    flash. It acts as a backpointer that guarantees that I/Os are
>    completed in order. This is necessary to guarantee that flushes are
>    completed when they should. It delegates too some responsibility
>    to the block layer since bios are completed in order.
>  - Sync-point pointer: Guarantees that flushes are respected.
>  - L2p-update pointer: Guarantees that lookups to cache entries will
>    point to their cache line after L2P mapping takes place for as long
>    as they remain in cache.
>=20
> The size of the ring buffer is the closest power-of-2 size to the
> number of active LUNs in the target X the size of a flash block.
>=20
> pblk implements basic FTL functionality:
>  - GC: A simple cost-base garbage collector.
>  - Write recovery: If a block becomes bad after writes have
>    successfully been committed to it, the block is garbage collected,
>    marked as bad and returned to the media manager.
>  - Scan recovery: The last page of each block is used to store
>    metadata that allows to reconstruct the L2P table in case of a
>    crash. This is the current recovery strategy until we implement L2P
>    snapshoting.
>  - Rate limiter: When GC starts, a rate-limiter guarantees that =
entries
>    on the write buffer will be reserved to user I/O and GC I/O.
>  - Sysfs integration: Information about the target and its
>    state is exposed through sysfs. This includes statistics and
>    open, closed and bad blocks.
> ---
> drivers/lightnvm/Kconfig         |  16 +
> drivers/lightnvm/Makefile        |   5 +
> drivers/lightnvm/pblk-cache.c    | 179 ++++++++
> drivers/lightnvm/pblk-core.c     | 757 +++++++++++++++++++++++++++++++
> drivers/lightnvm/pblk-gc.c       | 620 ++++++++++++++++++++++++++
> drivers/lightnvm/pblk-init.c     | 769 =
++++++++++++++++++++++++++++++++
> drivers/lightnvm/pblk-map.c      | 414 +++++++++++++++++
> drivers/lightnvm/pblk-rb.c       | 823 =
++++++++++++++++++++++++++++++++++
> drivers/lightnvm/pblk-read.c     | 614 +++++++++++++++++++++++++
> drivers/lightnvm/pblk-recovery.c | 792 =
++++++++++++++++++++++++++++++++
> drivers/lightnvm/pblk-rl.c       | 262 +++++++++++
> drivers/lightnvm/pblk-sysfs.c    | 828 =
++++++++++++++++++++++++++++++++++
> drivers/lightnvm/pblk-write.c    | 530 ++++++++++++++++++++++
> drivers/lightnvm/pblk.h          | 942 =
+++++++++++++++++++++++++++++++++++++++
> 14 files changed, 7551 insertions(+)
> create mode 100644 drivers/lightnvm/pblk-cache.c
> create mode 100644 drivers/lightnvm/pblk-core.c
> create mode 100644 drivers/lightnvm/pblk-gc.c
> create mode 100644 drivers/lightnvm/pblk-init.c
> create mode 100644 drivers/lightnvm/pblk-map.c
> create mode 100644 drivers/lightnvm/pblk-rb.c
> create mode 100644 drivers/lightnvm/pblk-read.c
> create mode 100644 drivers/lightnvm/pblk-recovery.c
> create mode 100644 drivers/lightnvm/pblk-rl.c
> create mode 100644 drivers/lightnvm/pblk-sysfs.c
> create mode 100644 drivers/lightnvm/pblk-write.c
> create mode 100644 drivers/lightnvm/pblk.h
