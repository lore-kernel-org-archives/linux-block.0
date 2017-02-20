Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-vk0-f67.google.com ([209.85.213.67]:36248 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750868AbdBTSxz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Feb 2017 13:53:55 -0500
MIME-Version: 1.0
From: Ilya Dryomov <idryomov@gmail.com>
Date: Mon, 20 Feb 2017 19:45:42 +0100
Message-ID: <CAOi1vP8M91kiF-FnT=EoJgTxfstMEsC-nhLY5KtRkrKROjWPWA@mail.gmail.com>
Subject: blk_integrity_revalidate() clears BDI_CAP_STABLE_WRITES
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>,
        linux-block@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hello,

rbd requires stable pages if ceph message data CRCs are enabled.  To
that end we set BDI_CAP_STABLE_WRITES in rbd_init_disk(), but since
commit 25520d55cdb6 ("block: Inline blk_integrity in struct gendisk",
went into 4.4) this bit is almost immediately cleared:

add_disk
  register_disk
    blkdev_get
      rescan_partitions
        blk_integrity_revalidate

void blk_integrity_revalidate(struct gendisk *disk)
{
        struct blk_integrity *bi = &disk->queue->integrity;

        if (!(disk->flags & GENHD_FL_UP))
                return;

        if (bi->profile)
                disk->queue->backing_dev_info.capabilities |=
                        BDI_CAP_STABLE_WRITES;
        else
                disk->queue->backing_dev_info.capabilities &=
                        ~BDI_CAP_STABLE_WRITES;
}

ceph messenger is responsible for generating/verifying CRCs, so we
don't call blk_integrity_register() -- bi->profile is NULL.

Martin, could you please explain blk_integrity_revalidate() and its
GENHD_FL_UP check in particular?  We have the queue, bi->profile can't
be NULL after blk_integrity_register(), and since the latter "must" be
used for registering the profile with the block layer, wouldn't the
following be sufficient for blk_integrity users?

diff --git a/block/blk-integrity.c b/block/blk-integrity.c
index d69c5c79f98e..319f2e4f4a8b 100644
--- a/block/blk-integrity.c
+++ b/block/blk-integrity.c
@@ -417,7 +417,7 @@ void blk_integrity_register(struct gendisk *disk,
struct blk_integrity *template
        bi->tuple_size = template->tuple_size;
        bi->tag_size = template->tag_size;

-       blk_integrity_revalidate(disk);
+       disk->queue->backing_dev_info.capabilities |= BDI_CAP_STABLE_WRITES;
 }
 EXPORT_SYMBOL(blk_integrity_register);

@@ -430,26 +430,11 @@ EXPORT_SYMBOL(blk_integrity_register);
  */
 void blk_integrity_unregister(struct gendisk *disk)
 {
-       blk_integrity_revalidate(disk);
+       disk->queue->backing_dev_info.capabilities &= ~BDI_CAP_STABLE_WRITES;
        memset(&disk->queue->integrity, 0, sizeof(struct blk_integrity));
 }
 EXPORT_SYMBOL(blk_integrity_unregister);

blk_integrity_revalidate() can then go away -- I can send the full
patch later.

The alternative seems to be to set up a bogus blk_integrity_profile
(nop_profile won't do -- this one would have to be truly bogus w/ NULL
->*_fn) under BLK_DEV_INTEGRITY ifdefs and hope that nothing breaks.
That can't be the right thing to do here...

Thanks,

                Ilya
