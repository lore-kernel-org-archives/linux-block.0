Return-Path: <tom.leiming@gmail.com>
MIME-Version: 1.0
In-Reply-To: <87wp9yq462.fsf@notabene.neil.brown.name>
References: <149369628671.5146.4865312503373040039.stgit@noble>
 <149369654434.5146.15331164625586213889.stgit@noble> <87wp9yq462.fsf@notabene.neil.brown.name>
From: Ming Lei <tom.leiming@gmail.com>
Date: Wed, 3 May 2017 11:24:51 +0800
Message-ID: <CACVXFVOL1G44gmNxQrV5V6PZXOoZWGj_beoQaxQXZWntZEoVsg@mail.gmail.com>
Subject: Re: [PATCH 03/13 V2] blk: make the bioset rescue_workqueue optional.
To: NeilBrown <neilb@suse.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block <linux-block@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

On Wed, May 3, 2017 at 6:34 AM, NeilBrown <neilb@suse.com> wrote:
> From 09017acf74ec4df674b78ca66f0924187f10d8a4 Mon Sep 17 00:00:00 2001
> From: NeilBrown <neilb@suse.com>
> Date: Fri, 10 Mar 2017 13:59:50 +1100
> Subject: [PATCH] blk: make the bioset rescue_workqueue optional.
>
> This patch converts bioset_create() to not create a workqueue by
> default, so alloctions will never trigger punt_bios_to_rescuer().  It
> also introduces a new flag BIOSET_NEED_RESCUER() which tells
> bioset_create() to preserve the old behavior.
>
> All callers of bioset_create() that are inside block device drivers,
> are given the BIOSET_NEED_RESCUER().
>
> biosets used by filesystems or other top-level users do not
> need rescuing as the bio can never be queued behind other
> bios.  This includes fs_bio_set, blkdev_dio_pool,
> btrfs_bioset, xfs_ioend_bioset, and one allocated by
> target_core_iblock.c.
>
> biosets used by md/raid do not need rescuing as
> their usage was recently audited and revised to never
> risk deadlock.
>
> It is hoped that most, if not all, of the remaining biosets
> can end up being the non-rescued version.
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Credit-to: Ming Lei <ming.lei@redhat.com> (minor fixes)
> Signed-off-by: NeilBrown <neilb@suse.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming
