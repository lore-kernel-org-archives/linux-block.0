Return-Path: <SRS0=T2Jf=2X=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B328C2D0DD
	for <linux-block@archiver.kernel.org>; Thu,  2 Jan 2020 07:53:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B67F217F4
	for <linux-block@archiver.kernel.org>; Thu,  2 Jan 2020 07:53:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="wEv2x8t7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbgABHxZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Jan 2020 02:53:25 -0500
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:35797 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbgABHxZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Jan 2020 02:53:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1577951605; x=1609487605;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=bFqvuHtUJ2uTuBGE5u3MI0p2QpGGNs+AUqkx0RpdLvY=;
  b=wEv2x8t7KYv9Lih6EHzXMF8++oG5ZlHqJuhW7PJFSmIh+2pAmL8sRShl
   jij0QyEyazFcn7sOYjZ3kpDPw4VnqyO9QFKokfWvJbTRWJFi62nU/r4UE
   HHeHojS0EzWkrKWzxbIEUUM7W6gXLAaLYwj8BV2PSQDMR3m8mTl/UWm/c
   k=;
IronPort-SDR: RNTC/4q3xGWHPIh9vssYnvrzBZGJuP19UJzRbqvoIonGLncvhmcp0JXo+YaHAWgnXjsCY0bewp
 oZ4tNqPWAC5A==
X-IronPort-AV: E=Sophos;i="5.69,386,1571702400"; 
   d="scan'208";a="9797737"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-e7be2041.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 02 Jan 2020 07:53:22 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-e7be2041.us-west-2.amazon.com (Postfix) with ESMTPS id 438D1A1E23;
        Thu,  2 Jan 2020 07:53:21 +0000 (UTC)
Received: from EX13D11UWB003.ant.amazon.com (10.43.161.206) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 2 Jan 2020 07:53:20 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13D11UWB003.ant.amazon.com (10.43.161.206) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 2 Jan 2020 07:53:20 +0000
Received: from localhost (172.23.204.141) by mail-relay.amazon.com
 (10.43.61.243) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Thu, 2 Jan 2020 07:53:19 +0000
From:   Balbir Singh <sblbir@amazon.com>
To:     <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>
CC:     <axboe@kernel.dk>, <ssomesh@amazon.com>, <jejb@linux.ibm.com>,
        <hch@lst.de>, <mst@redhat.com>, <Chaitanya.Kulkarni@wdc.com>,
        Balbir Singh <sblbir@amazon.com>
Subject: [resend v1 2/5] drivers/block/virtio_blk.c: Convert to use disk_set_capacity
Date:   Thu, 2 Jan 2020 07:53:12 +0000
Message-ID: <20200102075315.22652-3-sblbir@amazon.com>
X-Mailer: git-send-email 2.16.5
In-Reply-To: <20200102075315.22652-1-sblbir@amazon.com>
References: <20200102075315.22652-1-sblbir@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

block/genhd provides disk_set_capacity() for sending
RESIZE notifications via uevents.

Signed-off-by: Balbir Singh <sblbir@amazon.com>
---
 drivers/block/virtio_blk.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index fbbf18ac1d5d..9848c94a7eb4 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -479,18 +479,16 @@ static void virtblk_update_capacity(struct virtio_blk *vblk, bool resize)
 		   cap_str_10,
 		   cap_str_2);
 
-	set_capacity(vblk->disk, capacity);
+	disk_set_capacity(vblk->disk, capacity);
 }
 
 static void virtblk_config_changed_work(struct work_struct *work)
 {
 	struct virtio_blk *vblk =
 		container_of(work, struct virtio_blk, config_work);
-	char *envp[] = { "RESIZE=1", NULL };
 
 	virtblk_update_capacity(vblk, true);
 	revalidate_disk(vblk->disk);
-	kobject_uevent_env(&disk_to_dev(vblk->disk)->kobj, KOBJ_CHANGE, envp);
 }
 
 static void virtblk_config_changed(struct virtio_device *vdev)
-- 
2.16.5

