Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A85C6C433F5
	for <linux-block@archiver.kernel.org>; Wed, 20 Apr 2022 04:59:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359363AbiDTFCA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Apr 2022 01:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359362AbiDTFB7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Apr 2022 01:01:59 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D45DC1FA7F
        for <linux-block@vger.kernel.org>; Tue, 19 Apr 2022 21:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1650430752; x=1681966752;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KYQyovQyksbNpHDMld625g6lj6DMhyFdjeMPfDpgCng=;
  b=TaReLXktFglt0v4tWlxo95pEcgIm3xLv8iBw9ZClGKLBw2HkOycxBq+p
   OGkPJzM2SXec4MesK/zwk+ZKEbIFp7SFhkK2okNiQSkwnt1FkRYzoSqal
   doY8nTA5j3A+M5PYYtozz71T/T+vLpGpbdp3Yz8NIQtAScJ/C8bxoF3lH
   GMM2yQ44TRueT4UGxufaOosCIoO7qHW4WaAIxyzP0W8UrnJrSpT2AhVvC
   3ogUF3DH2Ca8BDYeWY7gdYJ2j8ENDY29gCwWlMizGpoFRwyByUndl7JR+
   xbRM6MtP8oo2c8oFL22qKJKnDTMcu+At1aIj9k1KCZyyXVP41HJ3vvq2A
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,274,1643644800"; 
   d="scan'208";a="198327693"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 Apr 2022 12:59:11 +0800
IronPort-SDR: +5LWOv2ftWEYW82ZnPOMGENQXN8rTRn9C4OTIkYqwXRAzZ7J7r7/Dxnq6vtXt3gJvv6JwWsWIr
 a5l8QHu+egEpy/KOuXl+I3+TAyT8nVctPUnk23KybJO+V8pjzufCteHBR7B/jNeuvMuSFBy2mH
 nokkPbB+g0HR/KzRnD12buA9AefMkS14ZlXCHhsdj973is2YN1McyxHPmVV/eFsU1IYak8cJKZ
 xnqFf/DPXu1CtDKYT1EKfT3yB6yXaPk1V8CwY7EAZuOJ1CofPQMVb7mjpr4Ayt3J5SrkE17CsK
 pzgBf5uqd6JwAM1nTLepyJ+1
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Apr 2022 21:30:17 -0700
IronPort-SDR: 9k9P/OcxxNkOIwwmnrOI0eOmC4todTYZl902WN2fa91PywDbruG4Z7jMm2HyY0Y2o4z3xpXM1A
 4XXhelsW+lvzFwcdJ1vV4VJL+Rvfm9CZOzBipT6qkhKfoiX+mKl16HNH95C/gJO12bfFAR0HVz
 3Dl1FAlvEdVKp3F2oryUHGOH4+SOgBWZ7QaoEvv7km6StoWlXpuUb3DSSaD6hQRuWI/qzzC+rk
 8NjYdW/0hJEVjlVjg5OpcHhtcMeOnFr1O3stgDXvTxwF3jmXk3nuieKXAGH0XFk/lSomV0moQ8
 bvk=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.173])
  by uls-op-cesaip01.wdc.com with ESMTP; 19 Apr 2022 21:59:11 -0700
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org, Omar Sandoval <osandov@osandov.com>
Cc:     Omar Sandoval <osandov@fb.com>, Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests] block/002: delay debugfs directory check
Date:   Wed, 20 Apr 2022 13:59:11 +0900
Message-Id: <20220420045911.914393-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The test case block/002 checks that device removal during blktrace run
does not leak debugfs directory. The Linux kernel commit 0a9a25ca7843
("block: let blkcg_gq grab request queue's refcnt") triggered failure of
the test case. The commit delayed queue release and debugfs directory
removal then the test case checks directory existence too early. To
avoid this false-positive failure, delay the directory existence check.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/block/002 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/block/002 b/tests/block/002
index 9b183e7..8061c91 100755
--- a/tests/block/002
+++ b/tests/block/002
@@ -29,6 +29,7 @@ test() {
 		echo "debugfs directory deleted with blktrace active"
 	fi
 	{ kill $!; wait; } >/dev/null 2>/dev/null
+	sleep 0.5
 	if [[ -d /sys/kernel/debug/block/${SCSI_DEBUG_DEVICES[0]} ]]; then
 		echo "debugfs directory leaked"
 	fi
-- 
2.35.1

