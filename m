Return-Path: <SRS0=kheS=CK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F581C433E2
	for <linux-block@archiver.kernel.org>; Tue,  1 Sep 2020 10:08:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13B8A20C56
	for <linux-block@archiver.kernel.org>; Tue,  1 Sep 2020 10:08:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OtYKAX3q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbgIAKIi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Sep 2020 06:08:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21566 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725848AbgIAKHv (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Sep 2020 06:07:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598954870;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=B/8gIOrLiThN5d6hKb/lc0wFjVdbh9UG2DsyyOvAFwQ=;
        b=OtYKAX3qUDieZzFOs4T8cCNl2SvFOfRFxyLcnlAwAWDJeDeWeN9CZxQkKvVDZywMGR/C1Q
        +V3mrIUXcTnrMmBMPDvAQuiACIRMJ7nC72WknAAow7XcHMSXCGxZGr1zhokLn7OTviLRCl
        +K4VS8VEwjVU/w6laQ//ZvS7Rypx+bk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-524-SUqX7mEzMEK4YD05iD4yUw-1; Tue, 01 Sep 2020 06:07:49 -0400
X-MC-Unique: SUqX7mEzMEK4YD05iD4yUw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ACC6F18BE166;
        Tue,  1 Sep 2020 10:07:47 +0000 (UTC)
Received: from localhost (ovpn-12-80.pek2.redhat.com [10.72.12.80])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1999610027A6;
        Tue,  1 Sep 2020 10:07:43 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH V2] block: release disk reference in hd_struct_free_work
Date:   Tue,  1 Sep 2020 18:07:38 +0800
Message-Id: <20200901100738.317061-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Commit e8c7d14ac6c3 ("block: revert back to synchronous request_queue removal")
stops to release request queue from wq context because that commit
supposed all blk_put_queue() is called in context which is allowed
to sleep. However, this assumption isn't true because we release disk's
reference in partition's percpu_ref's ->release() which doesn't allow
to sleep, because the ->release() is run via call_rcu().

Fixes this issue by moving put disk reference into hd_struct_free_work()

Signed-off-by: Ming Lei <ming.lei@redhat.com>
Fixes: e8c7d14ac6c3 ("block: revert back to synchronous request_queue removal")
Reported-by: Ilya Dryomov <idryomov@gmail.com>
Tested-by: Ilya Dryomov <idryomov@gmail.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Bart Van Assche <bvanassche@acm.org>
---
V2:
	- take Christoph's comment

 block/partitions/core.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/block/partitions/core.c b/block/partitions/core.c
index e62a98a8eeb7..5a18c8edabbc 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -278,6 +278,15 @@ static void hd_struct_free_work(struct work_struct *work)
 {
 	struct hd_struct *part =
 		container_of(to_rcu_work(work), struct hd_struct, rcu_work);
+	struct gendisk *disk = part_to_disk(part);
+
+	/*
+	 * Release the disk reference acquired in delete_partition here.
+	 * We can't release it in hd_struct_free because the final put_device
+	 * needs process context and thus can't be run directly from a
+	 * percpu_ref ->release handler.
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
-- 
2.25.2

