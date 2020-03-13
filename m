Return-Path: <SRS0=f2tN=46=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C01C10DCE
	for <linux-block@archiver.kernel.org>; Fri, 13 Mar 2020 05:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE4022073E
	for <linux-block@archiver.kernel.org>; Fri, 13 Mar 2020 05:30:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ehJRsC4k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbgCMFau (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 13 Mar 2020 01:30:50 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:40319 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbgCMFau (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Mar 2020 01:30:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1584077450; x=1615613450;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=pSzW8oLJrcnD5LFaQ7mkfrCb3JwilLPc6w4RiXMWEp4=;
  b=ehJRsC4kIPLmj5QpmBzAK436G3zDc2nRU3wdGMBx96iCJufv7TUXF1J1
   MbGsBdk7VJEfkVYSgugIXbTG1nIEGQdA2gjh8ZkG/mm2vAcXu4KmC04sI
   JxYu5fR9gJ3eApPCkH/B5xLGg5hzAk8M72bI3pgBHmZctSwvg1PHsYxKO
   k=;
IronPort-SDR: tbu8fDwzMo2L54dw4u8oUFZjuSMBpsMjd/2nEqkd1s7pWN4YozZhYfEQ2RTUsNlmPMI5s2HhDK
 yF/ENjhdkgOA==
X-IronPort-AV: E=Sophos;i="5.70,547,1574121600"; 
   d="scan'208";a="20880508"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1a-16acd5e0.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 13 Mar 2020 05:30:49 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1a-16acd5e0.us-east-1.amazon.com (Postfix) with ESMTPS id B3FF5A2E91;
        Fri, 13 Mar 2020 05:30:48 +0000 (UTC)
Received: from EX13D01UWA003.ant.amazon.com (10.43.160.107) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.58) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 13 Mar 2020 05:30:18 +0000
Received: from EX13MTAUWA001.ant.amazon.com (10.43.160.58) by
 EX13d01UWA003.ant.amazon.com (10.43.160.107) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 13 Mar 2020 05:30:18 +0000
Received: from localhost (10.2.75.237) by mail-relay.amazon.com
 (10.43.160.118) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Fri, 13 Mar 2020 05:30:18 +0000
From:   Balbir Singh <sblbir@amazon.com>
To:     <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>
CC:     <axboe@kernel.dk>, <Chaitanya.Kulkarni@wdc.com>, <hch@lst.de>,
        "Balbir Singh" <sblbir@amazon.com>
Subject: [PATCH v3 3/5] xen-blkfront.c: Convert to use set_capacity_revalidate_and_notify
Date:   Fri, 13 Mar 2020 05:30:07 +0000
Message-ID: <20200313053009.19866-4-sblbir@amazon.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20200313053009.19866-1-sblbir@amazon.com>
References: <20200313053009.19866-1-sblbir@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

block/genhd provides set_capacity_revalidate_and_notify() for
sending RESIZE notifications via uevents.

Signed-off-by: Balbir Singh <sblbir@amazon.com>
---
 drivers/block/xen-blkfront.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index 9df516a56bb2..915cf5b6388c 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -2338,7 +2338,6 @@ static void blkfront_connect(struct blkfront_info *info)
 	unsigned long sector_size;
 	unsigned int physical_sector_size;
 	unsigned int binfo;
-	char *envp[] = { "RESIZE=1", NULL };
 	int err, i;
 	struct blkfront_ring_info *rinfo;
 
@@ -2354,10 +2353,7 @@ static void blkfront_connect(struct blkfront_info *info)
 			return;
 		printk(KERN_INFO "Setting capacity to %Lu\n",
 		       sectors);
-		set_capacity(info->gd, sectors);
-		revalidate_disk(info->gd);
-		kobject_uevent_env(&disk_to_dev(info->gd)->kobj,
-				   KOBJ_CHANGE, envp);
+		set_capacity_revalidate_and_notify(info->gd, sectors, true);
 
 		return;
 	case BLKIF_STATE_SUSPENDED:
-- 
2.16.6

