Return-Path: <SRS0=ptgV=OU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A2C9C07E85
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 12:08:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB9A12084A
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 12:08:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="U3L2FcAn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB9A12084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbeLKMIa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Dec 2018 07:08:30 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:47647 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbeLKMI3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Dec 2018 07:08:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1544530109; x=1576066109;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=m7Ilg8l5/W3lKaaq4PM14SdgMUkJgZmizLu7wLCWmj4=;
  b=U3L2FcAnstFY5YmNJz8lwvTLsFvC3HIhHgwx1qIZ926JQRkrN/3+WEjA
   NRJPQ0mKRQJ85SZwreAwtRQTjGn2ckRxbRmIfHVlxDRNoZmCVOZUMGZX7
   3LHvZU3aN7bCvfAHCVwLSDShzT9RlNUo4N6zuWKdEjUfacAOag6GMx1id
   kZdPXkZKgDlW1rwfcpy+y6OA6zGz2+/S/3LXFljewFZDxFNtCPnMxeZaO
   U4aNEmxjFMEO5+6ppoqCSvHcCDynsgu0QLCrm34l0eRty+kV48mthObh4
   pH0BgNhzvbFMjTXg0zUsmopqDl3KKz8658VSMqd4MkE6Dncw67lzsKMqC
   Q==;
X-IronPort-AV: E=Sophos;i="5.56,342,1539619200"; 
   d="scan'208";a="97537542"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Dec 2018 20:08:29 +0800
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP; 11 Dec 2018 03:51:04 -0800
Received: from shin_dev.dhcp.fujisawa.hgst.com ([10.149.52.166])
  by uls-op-cesaip01.wdc.com with ESMTP; 11 Dec 2018 04:08:27 -0800
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org
Cc:     Damien.LeMoal@wdc.com, Matias.Bjorling@wdc.com,
        shinichiro.kawasaki@wdc.com
Subject: [PATCH] block: Fix null_blk_zoned creation failure with small number of zones
Date:   Tue, 11 Dec 2018 21:08:26 +0900
Message-Id: <20181211120826.28852-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

null_blk_zoned creation fails if the number of zones specified is equal to or is
smaller than 64 due to a memory allocation failure in blk_alloc_zones(). With
such a small number of zones, the required memory size for all zones descriptors
fits in a single page, and the page order for alloc_pages_node() is zero. Allow
this value in blk_alloc_zones() for the allocation to succeed.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 block/blk-zoned.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 13ba2011a306..a327bef07642 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -378,7 +378,7 @@ static struct blk_zone *blk_alloc_zones(int node, unsigned int *nr_zones)
 	struct page *page;
 	int order;
 
-	for (order = get_order(size); order > 0; order--) {
+	for (order = get_order(size); order >= 0; order--) {
 		page = alloc_pages_node(node, GFP_NOIO | __GFP_ZERO, order);
 		if (page) {
 			*nr_zones = min_t(unsigned int, *nr_zones,
-- 
2.19.2

