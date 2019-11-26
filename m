Return-Path: <SRS0=BQu2=ZS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D037C432C0
	for <linux-block@archiver.kernel.org>; Tue, 26 Nov 2019 15:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBE132071E
	for <linux-block@archiver.kernel.org>; Tue, 26 Nov 2019 15:36:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="niBqkuT4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbfKZPgn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Nov 2019 10:36:43 -0500
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:59253 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727028AbfKZPgn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Nov 2019 10:36:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1574782603; x=1606318603;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=W6LVx4gxON2oRR7lI5LBc6xbhhFYl7QITbdcuRcSicE=;
  b=niBqkuT43EgB73IVQQNzJjyAT7TlaocwzwoFyN1NApU1UtlCFUsKxQH8
   CY9rpOEKdDfFnUNH28rQRdIRaXqXMX2h262wHBcVf3k9x1mGu0WmITXxu
   fIW2YCsrrqEdj8V90l6e62zpNrox/dadcHV3lHUzm7i422q3V/a2skQV/
   M=;
IronPort-SDR: 5wWL59AZwO67yqNc5aqVtgEaOhBYBWfL588jw3WwrStdgwZROFHQEOELUJ+fRTE7kLc4lyCuRz
 a7XRWura312g==
X-IronPort-AV: E=Sophos;i="5.69,246,1571702400"; 
   d="scan'208";a="9989878"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2a-1c1b5cdd.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 26 Nov 2019 15:36:33 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-1c1b5cdd.us-west-2.amazon.com (Postfix) with ESMTPS id AC79CA2499;
        Tue, 26 Nov 2019 15:36:31 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 26 Nov 2019 15:36:31 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.162.54) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 26 Nov 2019 15:36:27 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <konrad.wilk@oracle.com>, <roger.pau@citrix.com>
CC:     <axboe@kernel.dk>, <xen-devel@lists.xenproject.org>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        SeongJae Park <sjpark@amazon.de>
Subject: [PATCH] xen/blkback: Avoid unmapping unmapped grant pages
Date:   Tue, 26 Nov 2019 16:36:05 +0100
Message-ID: <20191126153605.27564-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.54]
X-ClientProxiedBy: EX13D01UWB003.ant.amazon.com (10.43.161.94) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

For each I/O request, blkback first maps the foreign pages for the
request to its local pages.  If an allocation of a local page for the
mapping fails, it should unmap every mapping already made for the
request.

However, blkback's handling mechanism for the allocation failure does
not mark the remaining foreign pages as unmapped.  Therefore, the unmap
function merely tries to unmap every valid grant page for the request,
including the pages not mapped due to the allocation failure.  On a
system that fails the allocation frequently, this problem leads to
following kernel crash.

  [  372.012538] BUG: unable to handle kernel NULL pointer dereference at 0000000000000001
  [  372.012546] IP: [<ffffffff814071ac>] gnttab_unmap_refs.part.7+0x1c/0x40
  [  372.012557] PGD 16f3e9067 PUD 16426e067 PMD 0
  [  372.012562] Oops: 0002 [#1] SMP
  [  372.012566] Modules linked in: act_police sch_ingress cls_u32
  ...
  [  372.012746] Call Trace:
  [  372.012752]  [<ffffffff81407204>] gnttab_unmap_refs+0x34/0x40
  [  372.012759]  [<ffffffffa0335ae3>] xen_blkbk_unmap+0x83/0x150 [xen_blkback]
  ...
  [  372.012802]  [<ffffffffa0336c50>] dispatch_rw_block_io+0x970/0x980 [xen_blkback]
  ...
  Decompressing Linux... Parsing ELF... done.
  Booting the kernel.
  [    0.000000] Initializing cgroup subsys cpuset

This commit fixes this problem by marking the grant pages of the given
request that didn't mapped due to the allocation failure as invalid.

Fixes: c6cc142dac52 ("xen-blkback: use balloon pages for all mappings")

Signed-off-by: SeongJae Park <sjpark@amazon.de>
Reviewed-by: David Woodhouse <dwmw@amazon.de>
Reviewed-by: Maximilian Heyne <mheyne@amazon.de>
Reviewed-by: Paul Durrant <pdurrant@amazon.co.uk>
---
 drivers/block/xen-blkback/blkback.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/block/xen-blkback/blkback.c b/drivers/block/xen-blkback/blkback.c
index fd1e19f1a49f..3666afa639d1 100644
--- a/drivers/block/xen-blkback/blkback.c
+++ b/drivers/block/xen-blkback/blkback.c
@@ -936,6 +936,8 @@ static int xen_blkbk_map(struct xen_blkif_ring *ring,
 out_of_memory:
 	pr_alert("%s: out of memory\n", __func__);
 	put_free_pages(ring, pages_to_gnt, segs_to_map);
+	for (i = last_map; i < num; i++)
+		pages[i]->handle = BLKBACK_INVALID_HANDLE;
 	return -ENOMEM;
 }
 
-- 
2.17.1

