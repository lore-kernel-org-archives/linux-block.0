Return-Path: <SRS0=aWxv=TB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1362BC43219
	for <linux-block@archiver.kernel.org>; Wed,  1 May 2019 04:33:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D56EB21743
	for <linux-block@archiver.kernel.org>; Wed,  1 May 2019 04:33:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="AJttofdd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726019AbfEAEdo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 May 2019 00:33:44 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:63464 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfEAEdo (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 May 2019 00:33:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1556685224; x=1588221224;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NAkQXqDuxCAxis1X4iOVdJAjpD892SK4eNFybeSk24o=;
  b=AJttofddzasRRxg2IGkTIEbndcrj5agGuMxjXdJuTID4yBxpbucsdwwH
   +CHtUCsTCc11+UTn4dGiD+oYo7rzc+8QaHDWtBIfTJFkrXT6VGDE6jeOP
   V8kKhSzbEZLgtmTjaJ7mWwwhi6+zK3D1wDo7hSa7JQBTPURcX2AOdH6gP
   5RMibNK4ytIiNNgl2u792GvULdoICRL8UG1WSaBPF2daVSO3WFEWhSWNg
   ygFSr+PdVze66Vq0bLGefzE9UgvW+gCmeYnoFYx905dNq3KkyForcSJIc
   sOuZ0dystf7APe5MA3vXeO6+we2d7Jq3tjwaKADhf6ec9HXxoLoW4KtlY
   w==;
X-IronPort-AV: E=Sophos;i="5.60,416,1549900800"; 
   d="scan'208";a="107229736"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 01 May 2019 12:33:44 +0800
IronPort-SDR: j9oUDlMcnOEOTHF8GK65CIRlcp9Tc7uTMyB5uBJ3BwJzfX02qSRZNNAtZMK1c4T2BIvkzu9AB8
 qwCXI+0iVDgi/j0lDpyyBucs131IZJSZQo9WfqynGEH3K1cGNfWL8zCgCt6ofe0gLwEY1NRp9A
 97zALKK/xxax0UQYBffoL9g6GMLsTU6qsrOGSOWErZTAh0USdyG6J/DG57AlBmkAxtjt3p/+PW
 uXLq672E2ZDavwXgrYJPimlOA6pKVaUm8xe8ai2VEgWOCgdstGSQMfeG/nRfmv5Xh8ln4sS+kW
 RXgTmsJ5L3l7BcR0E+sNWPRR
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP; 30 Apr 2019 21:12:12 -0700
IronPort-SDR: jBV2D1JZhRqMt03+CS4FxQVhPNGC1K57QJ2zFlfJlTiijWSM3EYMZw+MTZvF0juomOebW/FM3J
 hDjT49P+EZ0N17PNgtJ0mB3jyiOsdNiU/RlCkoVpwg8c3nUN9cSSwB9IcH5V3VgupRzDJyOG8Z
 6BrxXHcWU/FeHEWVrUv+/IVpk5oTpVFYvuX7FFvBO+Nval1YeFE/jjl1eqt1eSmzaLtCrO8hxz
 GAhOYoWKR+U0Ju3rpgqGgX96ghhtB74i+vneztu5QWbSVc+Tijh18X4bkp0DNdTF2HjUPaWQVZ
 y+I=
Received: from cmercuryqemu.hgst.com ([10.202.65.32])
  by uls-op-cesaip01.wdc.com with ESMTP; 30 Apr 2019 21:33:44 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [RFC PATCH blktrace-tools 08/10] blkiomon: add extension support
Date:   Tue, 30 Apr 2019 21:33:15 -0700
Message-Id: <20190501043317.5507-9-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190501043317.5507-1-chaitanya.kulkarni@wdc.com>
References: <20190501043317.5507-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Update blkiomon to support the blktrace extension.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 blkiomon.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/blkiomon.c b/blkiomon.c
index f8b0c9d..67ef4ac 100644
--- a/blkiomon.c
+++ b/blkiomon.c
@@ -36,6 +36,10 @@
 #include <pthread.h>
 #include <time.h>
 
+#ifdef CONFIG_BLKTRACE_EXT
+#include <inttypes.h>
+#endif /* CONFIG_BLKTRACE_EXT */
+
 #include "blktrace.h"
 #include "rbtree.h"
 #include "jhash.h"
@@ -116,7 +120,11 @@ static void dump_bit(struct trace *t, const char *descr)
 	fprintf(debug.fp, "time     %16ld\n", (unsigned long)bit->time);
 	fprintf(debug.fp, "sector   %16ld\n", (unsigned long)bit->sector);
 	fprintf(debug.fp, "bytes    %16d\n", bit->bytes);
+#ifdef CONFIG_BLKTRACE_EXT
+	fprintf(debug.fp, "action   %"PRIx64"\n", (unsigned long)bit->action);
+#else
 	fprintf(debug.fp, "action   %16x\n", bit->action);
+#endif /* CONFIG_BLKTRACE_EXT */
 	fprintf(debug.fp, "pid      %16d\n", bit->pid);
 	fprintf(debug.fp, "device   %16d\n", bit->device);
 	fprintf(debug.fp, "cpu      %16d\n", bit->cpu);
@@ -142,8 +150,16 @@ static void dump_bits(struct trace *t1, struct trace *t2, const char *descr)
 		(unsigned long)bit1->time, (unsigned long)bit2->time);
 	fprintf(debug.fp, "sector   %16ld %16ld\n",
 		(unsigned long)bit1->sector, (unsigned long)bit2->sector);
+
+#ifdef CONFIG_BLKTRACE_EXT
 	fprintf(debug.fp, "bytes    %16d %16d\n", bit1->bytes, bit2->bytes);
+	fprintf(debug.fp, "action   %"PRIx64" %"PRIx64"\n",
+			(unsigned long) bit1->action,
+			(unsigned long) bit2->action);
+#else
 	fprintf(debug.fp, "action   %16x %16x\n", bit1->action, bit2->action);
+#endif /* CONFIG_BLKTRACE_EXT */
+
 	fprintf(debug.fp, "pid      %16d %16d\n", bit1->pid, bit2->pid);
 	fprintf(debug.fp, "device   %16d %16d\n", bit1->device, bit2->device);
 	fprintf(debug.fp, "cpu      %16d %16d\n", bit1->cpu, bit2->cpu);
-- 
2.19.1

