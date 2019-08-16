Return-Path: <SRS0=fyvH=WM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C2BC3A59C
	for <linux-block@archiver.kernel.org>; Fri, 16 Aug 2019 13:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25EA62086C
	for <linux-block@archiver.kernel.org>; Fri, 16 Aug 2019 13:35:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbfHPNfB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Aug 2019 09:35:01 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:54663 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727246AbfHPNfB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Aug 2019 09:35:01 -0400
Received: from mail-qt1-f197.google.com ([209.85.160.197])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <gpiccoli@canonical.com>)
        id 1hycNf-0000oF-3v
        for linux-block@vger.kernel.org; Fri, 16 Aug 2019 13:34:59 +0000
Received: by mail-qt1-f197.google.com with SMTP id k13so5895933qtp.15
        for <linux-block@vger.kernel.org>; Fri, 16 Aug 2019 06:34:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UMgyJz5cP/cLZxpMyAQ6fwneZ+H/SLqNfT4XWYL3XWk=;
        b=qXUdH+dPdNADPsY7qOFIHdyfMJoC70GyM1SytsJKNUJd5MZSKBPx3jphR4yGkULXNQ
         ssHmQqXVP9L4vnGoI7/S5LRV3uvTBEtDYbFn2+5KyQiIVS/pShkCK+t8pH1n0eGGs8tw
         Lp1cC0AMEyisSaHmfyaa/BfRMh0l5cSIBUOSbSYfdS9dppWvyv9tsBHODtdbVoO1L0dS
         TrbaGzoYeJHcXAN5Wju2MhDnzrwmTFdJPGQzNg9hs7POkx3zmq5L7mtN/D51VnYzHZd7
         hfMcJ401/WeSdnCspb6XZGx6m6qk8tcUBv4xrf/w+LiAuaTivG2suxapjtFOPNidkWTg
         4h7w==
X-Gm-Message-State: APjAAAVaL3rHCwC6H64PcfvbkXSGN5QeFCWdJK07t8hNAIS7LeJlWQ0+
        MBWhl9CUVEIrfYsjqNKoMCx4Gf2AohY0iN6O9vkX9PO21kEbornwZ1cfhFSY1dtyEyfaysJeHPL
        A5vdAP4JL2KtIKD7UPV0EV4eHC8LLe2NtlzXnt6zh
X-Received: by 2002:a05:620a:144d:: with SMTP id i13mr8878217qkl.197.1565962497839;
        Fri, 16 Aug 2019 06:34:57 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxpFpAst8B+U+sLZCTK4ARWCT9s7fD0hENh/Bq14SHpaUS2p14lDyvzy6EjpLCi0vDpur/xFg==
X-Received: by 2002:a05:620a:144d:: with SMTP id i13mr8878192qkl.197.1565962497556;
        Fri, 16 Aug 2019 06:34:57 -0700 (PDT)
Received: from localhost ([191.13.19.2])
        by smtp.gmail.com with ESMTPSA id q62sm3226982qkb.69.2019.08.16.06.34.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Aug 2019 06:34:56 -0700 (PDT)
From:   "Guilherme G. Piccoli" <gpiccoli@canonical.com>
To:     linux-raid@vger.kernel.org
Cc:     linux-block@vger.kernel.org, dm-devel@redhat.com,
        gpiccoli@canonical.com, jay.vosburgh@canonical.com,
        NeilBrown <neilb@suse.com>, Song Liu <songliubraving@fb.com>
Subject: [PATCH v2] md raid0/linear: Fail BIOs if their underlying block device is gone
Date:   Fri, 16 Aug 2019 10:34:41 -0300
Message-Id: <20190816133441.29350-1-gpiccoli@canonical.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Currently md raid0/linear are not provided with any mechanism to validate
if an array member got removed or failed. The driver keeps sending BIOs
regardless of the state of array members. This leads to the following
situation: if a raid0/linear array member is removed and the array is
mounted, some user writing to this array won't realize that errors are
happening unless they check dmesg or perform one fsync per written file.

In other words, no -EIO is returned and writes (except direct ones) appear
normal. Meaning the user might think the wrote data is correctly stored in
the array, but instead garbage was written given that raid0 does stripping
(and so, it requires all its members to be working in order to not corrupt
data). For md/linear, writes to the available members will work fine, but
if the writes go to the missing member(s), it'll cause a file corruption
situation, whereas the portion of the writes to the missing device aren't
written effectively.

This patch proposes a small change in this behavior: we check if the block
device's gendisk is UP when submitting the BIO to the array member, and if
it isn't, we flag the md device as broken and fail subsequent write I/Os.
If the array is restored (i.e., the missing array members are back) and
the array is restarted, the flag is cleared and we can submit BIOs normally.

With this patch, the filesystem reacts much faster to the event of missing
array member: after some I/O errors, ext4 for instance aborts the journal
and prevents corruption. Without this change, we're able to keep writing
in the disk and after a machine reboot, e2fsck shows some severe fs errors
that demand fixing. This patch was tested in ext4 and xfs filesystems.

Cc: NeilBrown <neilb@suse.com>
Cc: Song Liu <songliubraving@fb.com>
Signed-off-by: Guilherme G. Piccoli <gpiccoli@canonical.com>
---

v1 -> v2:
* Fail only WRITE requests (thanks Neil for the suggestion);
* Added handling for md-linear failures too (thanks Song for
the suggestion).


 drivers/md/md-linear.c | 6 ++++++
 drivers/md/md.c        | 5 +++++
 drivers/md/md.h        | 3 +++
 drivers/md/raid0.c     | 7 +++++++
 4 files changed, 21 insertions(+)

diff --git a/drivers/md/md-linear.c b/drivers/md/md-linear.c
index 7354466ddc90..ed2297541414 100644
--- a/drivers/md/md-linear.c
+++ b/drivers/md/md-linear.c
@@ -258,6 +258,12 @@ static bool linear_make_request(struct mddev *mddev, struct bio *bio)
 		     bio_sector < start_sector))
 		goto out_of_bounds;
 
+	if (unlikely(!(tmp_dev->rdev->bdev->bd_disk->flags & GENHD_FL_UP))) {
+		set_bit(MD_BROKEN, &mddev->flags);
+		bio_io_error(bio);
+		return true;
+	}
+
 	if (unlikely(bio_end_sector(bio) > end_sector)) {
 		/* This bio crosses a device boundary, so we have to split it */
 		struct bio *split = bio_split(bio, end_sector - bio_sector,
diff --git a/drivers/md/md.c b/drivers/md/md.c
index 24638ccedce4..ba4de55eea13 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -376,6 +376,11 @@ static blk_qc_t md_make_request(struct request_queue *q, struct bio *bio)
 	struct mddev *mddev = q->queuedata;
 	unsigned int sectors;
 
+	if (unlikely(test_bit(MD_BROKEN, &mddev->flags)) && (rw == WRITE)) {
+		bio_io_error(bio);
+		return BLK_QC_T_NONE;
+	}
+
 	blk_queue_split(q, &bio);
 
 	if (mddev == NULL || mddev->pers == NULL) {
diff --git a/drivers/md/md.h b/drivers/md/md.h
index 10f98200e2f8..5d7c1cad4946 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -248,6 +248,9 @@ enum mddev_flags {
 	MD_UPDATING_SB,		/* md_check_recovery is updating the metadata
 				 * without explicitly holding reconfig_mutex.
 				 */
+	MD_BROKEN,              /* This is used in RAID-0/LINEAR only, to stop
+				 * I/O in case an array member is gone/failed.
+				 */
 };
 
 enum mddev_sb_flags {
diff --git a/drivers/md/raid0.c b/drivers/md/raid0.c
index bf5cf184a260..ef896ee7198b 100644
--- a/drivers/md/raid0.c
+++ b/drivers/md/raid0.c
@@ -586,6 +586,13 @@ static bool raid0_make_request(struct mddev *mddev, struct bio *bio)
 
 	zone = find_zone(mddev->private, &sector);
 	tmp_dev = map_sector(mddev, zone, sector, &sector);
+
+	if (unlikely(!(tmp_dev->bdev->bd_disk->flags & GENHD_FL_UP))) {
+		set_bit(MD_BROKEN, &mddev->flags);
+		bio_io_error(bio);
+		return true;
+	}
+
 	bio_set_dev(bio, tmp_dev->bdev);
 	bio->bi_iter.bi_sector = sector + zone->dev_start +
 		tmp_dev->data_offset;
-- 
2.22.0

