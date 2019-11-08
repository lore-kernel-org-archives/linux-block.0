Return-Path: <SRS0=T+5Q=ZA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4DECC17440
	for <linux-block@archiver.kernel.org>; Fri,  8 Nov 2019 23:38:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B5BF215EA
	for <linux-block@archiver.kernel.org>; Fri,  8 Nov 2019 23:38:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="EH7Hd4Z+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbfKHXi0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Nov 2019 18:38:26 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:45942 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbfKHXi0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 Nov 2019 18:38:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1573256327; x=1604792327;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=z6jXcAoAVxEv3Xj+PfN1AdixiFHMQqQQP0u6ygOmyk4=;
  b=EH7Hd4Z+ka5rltGWmp4W/zbqjbuzcVghaBXb7RH3qtL+0hvrQu+pEXUM
   ATt9u67eDQ0jkKO6C4HIMWhmpznZy5tROUnJt56qNHc3CHyHiVPJNeHQ+
   baMyciHS1Bo5IVIoc7hphGzrCy4ck+6J8k9E8fe2ZwrH+b3Dsenv0Jg2c
   17eX0fei1JeR1tZWBnJTSNkAAeNfiN0yrxUWrlk0AvKhWx3JbUYeGGnGF
   tduRfmmGoeShY/Dd1ltKWTicGSqFJ6e4bJuMW4yPhvpZI5HCQYF1DKUfB
   inlFnwd5/RMbTWTir1I1GwNuPLlzx/gsl1y9CmuepVcXxh32RzhxIpN4J
   Q==;
IronPort-SDR: Ge7eO9DCE+Lw1fOfog2VIbuqK6lH8D6tiI8qR8aGOhOT9maytwx2T4hW5N1USvsobG9Tj9BtBT
 slnIoWSSt5vE1YVkc7TRopIYVSDb3zGiKWxwdl1eWNLoUg/4I3/bwxODu3c3QRdZeog/35Kb0Y
 j1dk+Q5zVkdVkfsp+TYZQuyKNSM1OceG6QECkEH97NrWMSePAh1DqbpihFGEttuV6Dw++haCv1
 riJxfo6fcLwKNwYX54G3mvn89B+v91T6Vx2GQd0pgp3XwMAJckcl7//MItj5lwyxvM2/BHeXAR
 CN8=
X-IronPort-AV: E=Sophos;i="5.68,283,1569254400"; 
   d="scan'208";a="223767037"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 09 Nov 2019 07:38:41 +0800
IronPort-SDR: mErifeLVoVoXE1XU9EezJcw4TmgREu8xXzt9ayjpXAW5fGjt3RdxgdIPckHSc9TgirbzXdrVJU
 3xWvmSkG4wK7j7W/DbXZcHXf1rpBEYGIOuu1pVWkP7qIVqR9S2B8i3KoFjykCyyTdY3nBcjacB
 CjEtQx1jaTcS5BZDJwey1a2cQBWJUkX47YAHecW1yOxMyuYC8xsy5dkJnTe21qz6hiyGk7cSgp
 ueaubKbJqIJ85dr/G2ik7unbWyO1LC96cUyBYSlod3JjWVK2Njzd7QGh18DQ6hkSXZk0SCkq3y
 I1wR6eoT5QLpn4LzdYRI9QdI
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2019 15:33:30 -0800
IronPort-SDR: ZZW2JbaK6I6i/yffH195K3LB8f8F+GtgWFdFj9glndUo8OQP+g7a8qL4yYRRzLEkHoEFBMfrEk
 Cqm76M7rglI9P7OVyUwY+ofipwKT9h0CrAbF5sBG4aFHQEu4GrQDlquV1Smy18/yR+8zPJRuFY
 7KnIfuAAtH1AZ5FB+VIAnCfMb2aAOvF8HBDMfSGwBgrkahwtgv4W2lVD13WPTfkSjXQydT9UaM
 nLHsYpImeRUMDdU9edoskX7WQDApGqdMnfzjsal2vNV7IXgogYdK+sbVMWi9I7LnawiQ8+ywxq
 GFY=
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com) ([10.6.138.107])
  by uls-op-cesaip01.wdc.com with ESMTP; 08 Nov 2019 15:38:22 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     damien.lemoal@wdc.com,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH] block: allow zone_mgmt_ops to bail out on SIGKILL
Date:   Fri,  8 Nov 2019 15:38:20 -0800
Message-Id: <20191108233820.4325-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch is on the similar concept which is posted earlier:-
https://marc.info/?l=linux-block&m=157321402002207&w=2.

This allows zone-mgmt ops to handle SIGKILL.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---

In case someone is interested here is the test on null blk with
added prints for zoneid.

Without this patch :-

# blkzone reset -o 0 -c 1000 /dev/nullb0 
^C^C^C^C^C^C^C^C^C^C^C^C^C^C^C

[  174.115065] null_blk: null_zone_mgmt 163 zoneid 993
[  174.125071] null_blk: null_zone_mgmt 163 zoneid 994
[  174.135076] null_blk: null_zone_mgmt 163 zoneid 995
[  174.145082] null_blk: null_zone_mgmt 163 zoneid 996
[  174.155087] null_blk: null_zone_mgmt 163 zoneid 997
[  174.165091] null_blk: null_zone_mgmt 163 zoneid 998
[  174.175096] null_blk: null_zone_mgmt 163 zoneid 999

With this patch :-
 # blkzone reset -o 0 -c 1000 /dev/nullb0
^C

[  211.889379] null_blk: null_zone_mgmt 163 zoneid 191
[  211.899420] null_blk: null_zone_mgmt 163 zoneid 192
[  211.909424] null_blk: null_zone_mgmt 163 zoneid 193

---
 block/blk-zoned.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 481eaf7d04d4..07ff2b75e6d7 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -17,6 +17,7 @@
 #include <linux/mm.h>
 #include <linux/vmalloc.h>
 #include <linux/sched/mm.h>
+#include <linux/sched/signal.h>
 
 #include "blk.h"
 
@@ -287,6 +288,8 @@ int blkdev_zone_mgmt(struct block_device *bdev, enum req_opf op,
 
 		/* This may take a while, so be nice to others */
 		cond_resched();
+		if (fatal_signal_pending(current))
+			break;
 	}
 
 	ret = submit_bio_wait(bio);
-- 
2.22.1

