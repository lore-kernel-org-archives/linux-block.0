Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3118C32773
	for <linux-block@archiver.kernel.org>; Fri, 19 Aug 2022 09:39:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348181AbiHSJjo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Aug 2022 05:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348182AbiHSJjc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Aug 2022 05:39:32 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4229A027D
        for <linux-block@vger.kernel.org>; Fri, 19 Aug 2022 02:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1660901971; x=1692437971;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2uAqIfzOKDqs4gxcCMklpEVom5aqGpSZ0EJpRYPFlqY=;
  b=K149mNOUb7ktoEc7MntGESipC13wu/pMn+kShA42jSntnEujnrbmSKfi
   8UtLhNqHoWO4snw+++7v4fYj1PPFUnzdYjspXCvy+rtWTK7XSz5fjIcH/
   lcVhI/kseYf4Fimo0CNEbqpQQ7mXY4h0nMDk01X+rd5Tp5D0bNmr3X0+L
   H+uj+IWLmfeDn3IcBUwEWOtgP71MM4gNVa8q1j0ZpGz+VFbOtJFjGHWzh
   KDVE6nCR3TjLv4on2asD/tkdY3aaZ16jvuHbMxNae/xC3EgpSr6UEl7pc
   Pm3YfErYMGoX4TDYbQ8/JTe0m/iyPW7nLG2sUpOVqn/UfGmX0tYqCctQu
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,247,1654531200"; 
   d="scan'208";a="313411574"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 19 Aug 2022 17:39:30 +0800
IronPort-SDR: NYnlAyrzeLUsPLMShlyVjnh8GkBMayHE69Lx+vFQvNf5X2xW3mY2W2gvRE5kK3evcPRI54xhPH
 MIqvpizae4oLrKzVcjtOPH1V5jk//mpi8WCWk9T9qNmNgDzfgejKXfEN145FhCsf6j7c2mLl+J
 wYh1CSvNFv3L5T0ympNl2GTWQPeXBUAN7pT9i4ihRyt43bb8w/85AaeVUJXcfR+/YvIBVcny4J
 2CtFYdnIt8QTjg3hsAsZ14OXvfq2tXpHHWoChtSpk+10LTHyY1v0f8o8GGC0N75Pb/60HRfLTH
 FGRxuUZryEb2vgeoEOqTLafY
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Aug 2022 01:54:55 -0700
IronPort-SDR: Fbzz4gvkCf9qs8erT0c8dbqkJQEJtBTlf/ZIx+4RZe5GNALQNk8Mbn88ZLX1ucSCkPGZx18azL
 72VEgVTEbuWI/1beIHO4iwAEelOC35/N/iN2DmHx1We64y13Kuog5fZdmPHeNQdG20c+nX6aji
 qYKpb4Q1FGv0HKoSYqJk1xvAG76URmqPc+8qQqP0FCEt/5LjDVde60zOU/0rA2TMeAhCmwsQgn
 X93io/OGrT8TZoyvKmI85CZGOHyQjn26yx4o4xcHmYcaz6orEd3A6RQ/5uFJYyFvyMSatId7bz
 qls=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.207])
  by uls-op-cesaip01.wdc.com with ESMTP; 19 Aug 2022 02:39:29 -0700
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v3 6/6] srp/rc: allow test with built-in sd_mod and sg drivers
Date:   Fri, 19 Aug 2022 18:39:20 +0900
Message-Id: <20220819093920.84992-7-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220819093920.84992-1-shinichiro.kawasaki@wdc.com>
References: <20220819093920.84992-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The srp test group can be executed with built-in sd_mod and sg drivers.
Check the drivers with _have_drivers() in place of _have_modules.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/srp/rc | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tests/srp/rc b/tests/srp/rc
index 94ee97c..a3a96a7 100755
--- a/tests/srp/rc
+++ b/tests/srp/rc
@@ -35,6 +35,7 @@ group_requires() {
 		SKIP_REASONS+=("LIO must be unloaded before the SRP tests are run")
 		return
 	fi
+	_have_drivers sd_mod sg
 	required_modules=(
 		dm_multipath
 		dm_queue_length
@@ -51,9 +52,6 @@ group_requires() {
 		scsi_dh_alua
 		scsi_dh_emc
 		scsi_dh_rdac
-		sd_mod
-		sd_mod
-		sg
 		target_core_iblock
 		target_core_mod
 	)
-- 
2.37.1

