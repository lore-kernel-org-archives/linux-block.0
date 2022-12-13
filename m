Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3C34C4167B
	for <linux-block@archiver.kernel.org>; Tue, 13 Dec 2022 07:18:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234567AbiLMHSA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Dec 2022 02:18:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234447AbiLMHR7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Dec 2022 02:17:59 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84EFF15A19
        for <linux-block@vger.kernel.org>; Mon, 12 Dec 2022 23:17:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670915821;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=+kX2TLdOaOVCcS5sCE8hnRsq9YvNxRgs/Sg5AJ4phAI=;
        b=DIwvEoNrkY24oERq/Dwm9DVHFOxYEPm7BGet7iqo5pJs87IYGiOuUHz2D6jthd5gMBLZlf
        tYYUK8vp6enFSDXHh++WFM1vQdCTdcsA4Yi36Wx8T1BB/lZcqrb+d1rTu9aZ59Yd8braPS
        HVp7GmazxMjcwDLhyWol7MWWQTfy8P8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-159-Kbutt_tGPqOwz4HgJJWUGw-1; Tue, 13 Dec 2022 02:17:00 -0500
X-MC-Unique: Kbutt_tGPqOwz4HgJJWUGw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DCE1A29AA2F8;
        Tue, 13 Dec 2022 07:16:59 +0000 (UTC)
Received: from localhost (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0B4F914152F6;
        Tue, 13 Dec 2022 07:16:58 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>, Shiwei Cui <cuishw@inspur.com>,
        Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>
Subject: [PATCH stable 4.9.y] block: unhash blkdev part inode when the part is deleted
Date:   Tue, 13 Dec 2022 15:16:55 +0800
Message-Id: <20221213071655.1197875-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

v5.11 changes the blkdev lookup mechanism completely since commit
22ae8ce8b892 ("block: simplify bdev/disk lookup in blkdev_get"),
and small part of the change is to unhash part bdev inode when
deleting partition. Turns out this kind of change does fix one
nasty issue in case of BLOCK_EXT_MAJOR:

1) when one partition is deleted & closed, disk_put_part() is always
called before bdput(bdev), see blkdev_put(); so the part's devt can
be freed & re-used before the inode is dropped

2) then new partition with same devt can be created just before the
inode in 1) is dropped, then the old inode/bdev structurein 1) is
re-used for this new partition, this way causes use-after-free and
kernel panic.

It isn't possible to backport the whole big patchset of "merge struct
block_device and struct hd_struct v4" for addressing this issue.

https://lore.kernel.org/linux-block/20201128161510.347752-1-hch@lst.de/

So fixes it by unhashing part bdev in delete_partition(), and this way
is actually aligned with v5.11+'s behavior.

Backported from the following 5.10.y commit:

5f2f77560591 ("block: unhash blkdev part inode when the part is deleted")

Reported-by: Shiwei Cui <cuishw@inspur.com>
Tested-by: Shiwei Cui <cuishw@inspur.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Jan Kara <jack@suse.cz>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/partition-generic.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/block/partition-generic.c b/block/partition-generic.c
index 298c05f8b5e3..434c122cb958 100644
--- a/block/partition-generic.c
+++ b/block/partition-generic.c
@@ -254,6 +254,7 @@ void delete_partition(struct gendisk *disk, int partno)
 {
 	struct disk_part_tbl *ptbl = disk->part_tbl;
 	struct hd_struct *part;
+	struct block_device *bdev;
 
 	if (partno >= ptbl->len)
 		return;
@@ -267,6 +268,11 @@ void delete_partition(struct gendisk *disk, int partno)
 	kobject_put(part->holder_dir);
 	device_del(part_to_dev(part));
 
+	bdev = bdget(part_devt(part));
+	if (bdev) {
+		remove_inode_hash(bdev->bd_inode);
+		bdput(bdev);
+	}
 	hd_struct_kill(part);
 }
 
-- 
2.38.1

