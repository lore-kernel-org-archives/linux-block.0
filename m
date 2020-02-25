Return-Path: <SRS0=qPv+=4N=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF481C35E04
	for <linux-block@archiver.kernel.org>; Tue, 25 Feb 2020 20:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7E9321556
	for <linux-block@archiver.kernel.org>; Tue, 25 Feb 2020 20:01:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="vaotqlGj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731449AbgBYUB5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Feb 2020 15:01:57 -0500
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:10808 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730793AbgBYUB5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Feb 2020 15:01:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1582660916; x=1614196916;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=88Zx2T7WCBJVENwjrv8btKUmZjU2WnlNsWj7L+qkaVc=;
  b=vaotqlGj6oIu4fQ0U1rNUzlpYabl+HgJ6nI5Nb06MMTI93Y1oIPDhcvP
   5FLWx4D3OL2Q0yRLFGvC4yDyEFitexs984ccLXZn3c74Awr9ucu2bJeKa
   STwoCY9akYxfjcVgMhtjl5I29cvQqnMZndPisDEoPrW9YcyBCQMZyNagJ
   Y=;
IronPort-SDR: 5CLN0VWdABdktqWY1FUB1mol1m/QEG+VE+D1kMB8M7JKZ4KRriFR/v+hbZ54hcgqxSD9dWjnEe
 R1LxXjDB2sbw==
X-IronPort-AV: E=Sophos;i="5.70,485,1574121600"; 
   d="scan'208";a="19630616"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2c-2225282c.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 25 Feb 2020 20:01:43 +0000
Received: from EX13MTAUWC001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2c-2225282c.us-west-2.amazon.com (Postfix) with ESMTPS id 32F2FA1D85;
        Tue, 25 Feb 2020 20:01:42 +0000 (UTC)
Received: from EX13D11UWC003.ant.amazon.com (10.43.162.162) by
 EX13MTAUWC001.ant.amazon.com (10.43.162.135) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 25 Feb 2020 20:01:41 +0000
Received: from EX13MTAUWC001.ant.amazon.com (10.43.162.135) by
 EX13D11UWC003.ant.amazon.com (10.43.162.162) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 25 Feb 2020 20:01:41 +0000
Received: from localhost (10.2.75.237) by mail-relay.amazon.com
 (10.43.162.232) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Tue, 25 Feb 2020 20:01:41 +0000
From:   Balbir Singh <sblbir@amazon.com>
To:     <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>
CC:     <axboe@kernel.dk>, <Chaitanya.Kulkarni@wdc.com>, <mst@redhat.com>,
        <jejb@linux.ibm.com>, <hch@lst.de>,
        Balbir Singh <sblbir@amazon.com>,
        Someswarudu Sangaraju <ssomesh@amazon.com>
Subject: [PATCH v2 1/5] block/genhd: Notify udev about capacity change
Date:   Tue, 25 Feb 2020 20:01:25 +0000
Message-ID: <20200225200129.6687-2-sblbir@amazon.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20200225200129.6687-1-sblbir@amazon.com>
References: <20200225200129.6687-1-sblbir@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Allow block/genhd to notify user space (via udev) about disk size changes
using a new helper set_capacity_revalidate_and_notify(), which is a wrapper
on top of set_capacity(). set_capacity_revalidate_and_notify() will only
notify via udev if the current capacity or the target capacity is not zero
and iff the capacity changes.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Someswarudu Sangaraju <ssomesh@amazon.com>
Signed-off-by: Balbir Singh <sblbir@amazon.com>
Reviewed-by: Bob Liu <bob.liu@oracle.com>
---
 block/genhd.c         | 24 ++++++++++++++++++++++++
 include/linux/genhd.h |  2 ++
 2 files changed, 26 insertions(+)

diff --git a/block/genhd.c b/block/genhd.c
index ff6268970ddc..6a60131baffa 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -46,6 +46,30 @@ static void disk_add_events(struct gendisk *disk);
 static void disk_del_events(struct gendisk *disk);
 static void disk_release_events(struct gendisk *disk);
 
+/*
+ * Set disk capacity and notify if the size is not currently
+ * zero and will not be set to zero
+ */
+void set_capacity_revalidate_and_notify(struct gendisk *disk, sector_t size,
+					bool revalidate)
+{
+	sector_t capacity = get_capacity(disk);
+
+	set_capacity(disk, size);
+
+	if (revalidate)
+		revalidate_disk(disk);
+
+	if (capacity != size && capacity != 0 && size != 0) {
+		char *envp[] = { "RESIZE=1", NULL };
+
+		kobject_uevent_env(&disk_to_dev(disk)->kobj, KOBJ_CHANGE, envp);
+	}
+}
+
+EXPORT_SYMBOL_GPL(set_capacity_revalidate_and_notify);
+
+
 void part_inc_in_flight(struct request_queue *q, struct hd_struct *part, int rw)
 {
 	if (queue_is_mq(q))
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 6fbe58538ad6..f77f5095f20b 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -461,6 +461,8 @@ static inline int get_disk_ro(struct gendisk *disk)
 extern void disk_block_events(struct gendisk *disk);
 extern void disk_unblock_events(struct gendisk *disk);
 extern void disk_flush_events(struct gendisk *disk, unsigned int mask);
+extern void set_capacity_revalidate_and_notify(struct gendisk *disk,
+			sector_t size, bool revalidate);
 extern unsigned int disk_clear_events(struct gendisk *disk, unsigned int mask);
 
 /* drivers/char/random.c */
-- 
2.16.6

