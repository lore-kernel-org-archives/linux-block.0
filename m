Return-Path: <SRS0=ZsbB=C7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBC87C4363D
	for <linux-block@archiver.kernel.org>; Tue, 22 Sep 2020 14:19:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F1512395C
	for <linux-block@archiver.kernel.org>; Tue, 22 Sep 2020 14:19:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="UuJWSHLN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbgIVOT0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Sep 2020 10:19:26 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:29598 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbgIVOT0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Sep 2020 10:19:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1600784365; x=1632320365;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=o7irTIbRXOJQafppIl9QY5dF6CNyW4qaMo6zKmMJeVI=;
  b=UuJWSHLN7X9GKJEwZJ9Jp/deCje3pK+WDYjRzmOnH6mx3wUIka6uiXfX
   2Fm2YsF0mUV27Ipaf1B9DhJI9BwZ4hevHvl3FeOF435clIEUYHF4vZU80
   H52M8RrINeAXp0IXum9A1gyvFgR8blEYLS7ihlxJ2GHVmdM9B1Y3PTD5w
   I=;
X-IronPort-AV: E=Sophos;i="5.77,291,1596499200"; 
   d="scan'208";a="70117581"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2b-8cc5d68b.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 22 Sep 2020 14:16:33 +0000
Received: from EX13D31EUA004.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2b-8cc5d68b.us-west-2.amazon.com (Postfix) with ESMTPS id 3B241A1C02;
        Tue, 22 Sep 2020 14:16:32 +0000 (UTC)
Received: from u3f2cd687b01c55.ant.amazon.com (10.43.160.137) by
 EX13D31EUA004.ant.amazon.com (10.43.165.161) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 22 Sep 2020 14:16:25 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <konrad.wilk@oracle.com>, <roger.pau@citrix.com>, <jgross@suse.com>
CC:     SeongJae Park <sjpark@amazon.de>, <axboe@kernel.dk>,
        <aliguori@amazon.com>, <amit@kernel.org>, <mheyne@amazon.de>,
        <pdurrant@amazon.co.uk>, <linux-block@vger.kernel.org>,
        <xen-devel@lists.xenproject.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 3/3] xen-blkfront: Apply changed parameter name to the document
Date:   Tue, 22 Sep 2020 16:15:49 +0200
Message-ID: <20200922141549.26154-4-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200922141549.26154-1-sjpark@amazon.com>
References: <20200922141549.26154-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.137]
X-ClientProxiedBy: EX13D12UWC001.ant.amazon.com (10.43.162.78) To
 EX13D31EUA004.ant.amazon.com (10.43.165.161)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

Commit 14e710fe7897 ("xen-blkfront: rename indirect descriptor
parameter") changed the name of the module parameter for the maximum
amount of segments in indirect requests but missed updating the
document.  This commit updates the document.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 Documentation/ABI/testing/sysfs-driver-xen-blkfront | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-driver-xen-blkfront b/Documentation/ABI/testing/sysfs-driver-xen-blkfront
index 9c31334cb2e6..28008905615f 100644
--- a/Documentation/ABI/testing/sysfs-driver-xen-blkfront
+++ b/Documentation/ABI/testing/sysfs-driver-xen-blkfront
@@ -1,4 +1,4 @@
-What:           /sys/module/xen_blkfront/parameters/max
+What:           /sys/module/xen_blkfront/parameters/max_indirect_segments
 Date:           June 2013
 KernelVersion:  3.11
 Contact:        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
-- 
2.17.1

