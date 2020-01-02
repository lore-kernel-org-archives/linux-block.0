Return-Path: <SRS0=T2Jf=2X=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E217C3276F
	for <linux-block@archiver.kernel.org>; Thu,  2 Jan 2020 07:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64B9F20866
	for <linux-block@archiver.kernel.org>; Thu,  2 Jan 2020 07:53:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="pddTFLYH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbgABHxg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Jan 2020 02:53:36 -0500
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:13891 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727781AbgABHxf (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Jan 2020 02:53:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1577951616; x=1609487616;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=x51IhYE1QyMmY3UHAvxQPb23Eyep04ViD2uP480XSao=;
  b=pddTFLYHv8OvDL5cOTlw+D5UVYQ2nuhETA8VXsShHlEMLzFzyCdKKZ2Y
   G/CyksK76UQIZKzft3ywUHX863lO03yMdw6LiphOosVa7I5w/fpf+vp4V
   oShJ6CwpaDO0p+rZ8jFex0XUntpi04kR8qRlrMTIOrAgQ0wNLadlgzVjN
   0=;
IronPort-SDR: bFnmoTpJxJQMchHcpI9J27Stgt9IouSGesc4w8HXeVrR5wfd4SV+365A1W/FeBqf5BPo8Uu4pc
 vV0LIyF28eVg==
X-IronPort-AV: E=Sophos;i="5.69,385,1571702400"; 
   d="scan'208";a="17779141"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1d-5dd976cd.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 02 Jan 2020 07:53:30 +0000
Received: from EX13MTAUWC001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1d-5dd976cd.us-east-1.amazon.com (Postfix) with ESMTPS id D7E14A1DD2;
        Thu,  2 Jan 2020 07:53:26 +0000 (UTC)
Received: from EX13D11UWC004.ant.amazon.com (10.43.162.101) by
 EX13MTAUWC001.ant.amazon.com (10.43.162.135) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 2 Jan 2020 07:53:25 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13D11UWC004.ant.amazon.com (10.43.162.101) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 2 Jan 2020 07:53:24 +0000
Received: from localhost (172.23.204.141) by mail-relay.amazon.com
 (10.43.61.243) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Thu, 2 Jan 2020 07:53:23 +0000
From:   Balbir Singh <sblbir@amazon.com>
To:     <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>
CC:     <axboe@kernel.dk>, <ssomesh@amazon.com>, <jejb@linux.ibm.com>,
        <hch@lst.de>, <mst@redhat.com>, <Chaitanya.Kulkarni@wdc.com>,
        Balbir Singh <sblbir@amazon.com>
Subject: [resend v1 5/5] drivers/scsi/sd.c: Convert to use disk_set_capacity
Date:   Thu, 2 Jan 2020 07:53:15 +0000
Message-ID: <20200102075315.22652-6-sblbir@amazon.com>
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
RESIZE notifications via uevents. This notification is
newly added to scsi sd.

Signed-off-by: Balbir Singh <sblbir@amazon.com>
---
 drivers/scsi/sd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 5afb0046b12a..1a3be30b6b78 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -3184,7 +3184,7 @@ static int sd_revalidate_disk(struct gendisk *disk)
 
 	sdkp->first_scan = 0;
 
-	set_capacity(disk, logical_to_sectors(sdp, sdkp->capacity));
+	disk_set_capacity(disk, logical_to_sectors(sdp, sdkp->capacity));
 	sd_config_write_same(sdkp);
 	kfree(buffer);
 
-- 
2.16.5

