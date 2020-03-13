Return-Path: <SRS0=f2tN=46=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 570E0C10DCE
	for <linux-block@archiver.kernel.org>; Fri, 13 Mar 2020 05:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AB0120749
	for <linux-block@archiver.kernel.org>; Fri, 13 Mar 2020 05:30:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="CWYpmQTs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbgCMFaj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 13 Mar 2020 01:30:39 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:40257 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbgCMFaj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Mar 2020 01:30:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1584077439; x=1615613439;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=+sx6zgKfNvtU+khzgrLABKiu4S2pVtYCOg28mWKSsac=;
  b=CWYpmQTs5xvme34qVpgBImdgzi6ynB0J+HSFkGfbb84fm6SKqSI836ZZ
   F+L/OKhvEllJXbafuwfMQt0oO6oawEQCYqMeRTYXoKaYyFYWoLpxJOKxl
   PE05Tqj4wDzpyJn6JJKa8/Yoe/PfBbDzTMBKQx5QtILLGwecuWetNzrIb
   E=;
IronPort-SDR: sIRAFgLEzf8PaTIoMhqw3HVzHHRlKL2OjpIMVzinRWe6oGpdDdUYgoSqY1d8b3VGr/H+X3K0u9
 Ke2N60Y3NlLA==
X-IronPort-AV: E=Sophos;i="5.70,547,1574121600"; 
   d="scan'208";a="20880414"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1a-67b371d8.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 13 Mar 2020 05:30:21 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1a-67b371d8.us-east-1.amazon.com (Postfix) with ESMTPS id 1B63BA2E92;
        Fri, 13 Mar 2020 05:30:18 +0000 (UTC)
Received: from EX13D01UWA001.ant.amazon.com (10.43.160.60) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.118) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 13 Mar 2020 05:30:18 +0000
Received: from EX13MTAUWA001.ant.amazon.com (10.43.160.58) by
 EX13d01UWA001.ant.amazon.com (10.43.160.60) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 13 Mar 2020 05:30:18 +0000
Received: from localhost (10.2.75.237) by mail-relay.amazon.com
 (10.43.160.118) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Fri, 13 Mar 2020 05:30:18 +0000
From:   Balbir Singh <sblbir@amazon.com>
To:     <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>
CC:     <axboe@kernel.dk>, <Chaitanya.Kulkarni@wdc.com>, <hch@lst.de>,
        "Balbir Singh" <sblbir@amazon.com>
Subject: [PATCH v3 2/5] virtio_blk.c: Convert to use set_capacity_revalidate_and_notify
Date:   Fri, 13 Mar 2020 05:30:06 +0000
Message-ID: <20200313053009.19866-3-sblbir@amazon.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20200313053009.19866-1-sblbir@amazon.com>
References: <20200313053009.19866-1-sblbir@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

block/genhd provides set_capacity_revalidate_and_notify() for sending RESIZE
notifications via uevents.

Signed-off-by: Balbir Singh <sblbir@amazon.com>
---
 drivers/block/virtio_blk.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 0736248999b0..f9b1e70f1b31 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -388,18 +388,15 @@ static void virtblk_update_capacity(struct virtio_blk *vblk, bool resize)
 		   cap_str_10,
 		   cap_str_2);
 
-	set_capacity(vblk->disk, capacity);
+	set_capacity_revalidate_and_notify(vblk->disk, capacity, true);
 }
 
 static void virtblk_config_changed_work(struct work_struct *work)
 {
 	struct virtio_blk *vblk =
 		container_of(work, struct virtio_blk, config_work);
-	char *envp[] = { "RESIZE=1", NULL };
 
 	virtblk_update_capacity(vblk, true);
-	revalidate_disk(vblk->disk);
-	kobject_uevent_env(&disk_to_dev(vblk->disk)->kobj, KOBJ_CHANGE, envp);
 }
 
 static void virtblk_config_changed(struct virtio_device *vdev)
-- 
2.16.6

