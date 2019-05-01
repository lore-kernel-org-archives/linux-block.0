Return-Path: <SRS0=aWxv=TB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2113BC43219
	for <linux-block@archiver.kernel.org>; Wed,  1 May 2019 04:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAD8420866
	for <linux-block@archiver.kernel.org>; Wed,  1 May 2019 04:33:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ZbqY+Icw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726040AbfEAEdj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 May 2019 00:33:39 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:63464 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbfEAEdj (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 May 2019 00:33:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1556685219; x=1588221219;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6c130/ZhUQKaYdauPGcXnvf5mkrOpsfmXIH3FyhVEyI=;
  b=ZbqY+IcwdjYnw7kXR8AzomR+fQsCdsbkHrLehTDkAKONyGj4cc3xx43H
   cUP4l5/YUeP4cys5rxpzXRPhO8Tk2C3oRgGnfZLYizlk7b1GVSuIzhiFW
   XwpGwi3ACFmtCAoqCngA7Ai+CndZ+yqT7gWaqf7gjXKP49ywtCxncOYAL
   7ZTcIsLOb2/d0nNwzyTUYvgC4QcB/xSL022PcEv9bHZfexYeWjh4nzFcG
   lixcm/7x9GKaBkCgVy20d1HsMX+Duni22SHbk609QZlGC+zj31qVHAnTc
   UxrlM5PCn0hGrbiMem32ICA+kk7Hgkor90S8BxXg0TtuKhL6TSWrxHOLL
   Q==;
X-IronPort-AV: E=Sophos;i="5.60,416,1549900800"; 
   d="scan'208";a="107229733"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 01 May 2019 12:33:39 +0800
IronPort-SDR: ObRtwgXoF/K1tbsZkEcy1cylWfsgaGzr1OhYeF1028wEURtyaTWwrimnPY0n/wLDRQ4T8zBYhV
 fA3zN0/EM35+w5mTmxxrN12ll4auHXpML7XHJRoyKDinRlVl+HuDzoxgdvu/HEDkc6BAHrkWiE
 RQygiM+n2E06k08X91D2LIl0hihI184/0Qsq0swARk60uYUuyA/ibEsoxlvW5Cqb9IKOYVY0tP
 pwb4gTUH/St2Q2VDwLqRMpxO0LBw3otGQfO4x84y5KN8JbQNFEppfa9TaHX2Z2/fywRY2vEGH3
 wa4We417xtfiHcO7Aukz7i6o
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP; 30 Apr 2019 21:12:07 -0700
IronPort-SDR: wjuk8BuX/bULP77zl/FjcJpFuGVijG/D0oyHlt2AfrNm5SfDI6WfJRVDiBHwlxXXbL0f6pYTw5
 QGDHqS2oYmIez13C1fGTMxSSQ0w0/cLVXIudsYRWcCEMylJorq5IHvnFFPoM/KbcNZEvjfpF7j
 wJa+RKdV/Hhc5DJDrlhL53tVwDBGrg6PFI4Ny0++udyMV5AKTFeHD5CstRsWzUvlWKAt7tWp7Z
 Ltn4BVKVKiUS90prv2VmexDsuzAifoJQUNfhs3W5LAlYMS0XTE9Vxb+ia3pf1XD/vLkbKc25rC
 03w=
Received: from cmercuryqemu.hgst.com ([10.202.65.32])
  by uls-op-cesaip01.wdc.com with ESMTP; 30 Apr 2019 21:33:39 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [RFC PATCH blktrace-tools 06/10] blkparse-fmt.c: add extension support
Date:   Tue, 30 Apr 2019 21:33:13 -0700
Message-Id: <20190501043317.5507-7-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190501043317.5507-1-chaitanya.kulkarni@wdc.com>
References: <20190501043317.5507-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch adds support for blkparse format to use the blktrace
extension. Here we update the blkparse format processing and add
extension support for handling the priorities.

By default for any command blkparse format only prints the sector
in and bytes transfer if trace has bytes associated with it.
For zone reset command we need to print the sectors even though
it doesn't have bytes associated with it.

1. Using blktrace with blkparse with these changes from command line :-

prio mask F=00001111 -> IDLE BEST REAL NONE

Will produce a following output for the write zeroes command
issued with the blkdiscard -z options (where write-zeroes is
enabled on the null_blk, please see the later patches) :-
#for prio in 0 1 2 3;
> do
> 	echo "$prio"
> 	ionice -c ${prio} blkdiscard -z -o 0 -l 4096 /dev/nullb0
> done

252,0    7        1     0.000000000 11683  Q WZS NONE 0 0 + 8 [blkdiscard]
252,0    7        2     0.000017726 11683  G WZS NONE 0 0 + 8 [blkdiscard]
252,0    7        5     0.000036753 11683  I WZS NONE 0 0 + 8 [blkdiscard]
252,0    7        6     0.000084833   590  D WZS NONE 0 0 + 8 [kworker/7:1H]
252,0    7        7     0.000123823    46  C WZS NONE 0 0 + 8 [0]
252,0    5        1     0.457135696 11685  Q WZS REAL 4 0 + 8 [blkdiscard]
252,0    5        2     0.457149696 11685  G WZS REAL 4 0 + 8 [blkdiscard]
252,0    5        5     0.457168205 11685  I WZS REAL 4 0 + 8 [blkdiscard]
252,0    5        6     0.457213155   526  D WZS REAL 4 0 + 8 [kworker/5:1H]
252,0    5        7     0.457250408    36  C WZS REAL 4 0 + 8 [0]
252,0    7        8     0.715223985 11686  Q WZS BEST 4 0 + 8 [blkdiscard]
252,0    7        9     0.715238045 11686  G WZS BEST 4 0 + 8 [blkdiscard]
252,0    7       12     0.715255462 11686  I WZS BEST 4 0 + 8 [blkdiscard]
252,0    7       13     0.715297718   590  D WZS BEST 4 0 + 8 [kworker/7:1H]
252,0    7       14     0.715330957    46  C WZS BEST 4 0 + 8 [0]
252,0    8        1     0.949218847 11687  Q WZS IDLE 7 0 + 8 [blkdiscard]
252,0    8        2     0.949232970 11687  G WZS IDLE 7 0 + 8 [blkdiscard]
252,0    8        5     0.949250266 11687  I WZS IDLE 7 0 + 8 [blkdiscard]
252,0    8        6     0.949294703   519  D WZS IDLE 7 0 + 8 [kworker/8:1H]
252,0    8        7     0.949330943    51  C WZS IDLE 7 0 + 8 [0]

2. Using blktrace with blkparse with these changes from command line :-

prio mask B=00001011 -> IDEL 0 REAL NONE

Will produce a following output for the write zeroes command
issued with the blkdiscard -z options (where write-zeroes is
enabled on the null_blk, please see the later patches) :-
#for prio in 0 1 2 3;
> do
> 	echo "$prio"
> 	ionice -c ${prio} blkdiscard -z -o 0 -l 4096 /dev/nullb0
> done

252,0    0        1     0.000000000 11584  Q WZS NONE 0 0 + 8 [blkdiscard]
252,0    0        2     0.000031548 11584  G WZS NONE 0 0 + 8 [blkdiscard]
252,0    0        5     0.000054369 11584  I WZS NONE 0 0 + 8 [blkdiscard]
252,0    0        6     0.000109033   517  D WZS NONE 0 0 + 8 [kworker/0:1H]
252,0    0        7     0.000151984     9  C WZS NONE 0 0 + 8 [0]
252,0    0        9     0.656430970 11586  G WZS REAL 4 0 + 8 [blkdiscard]
252,0    0       12     0.656448477 11586  I WZS REAL 4 0 + 8 [blkdiscard]
252,0    0       13     0.656488270   517  D WZS REAL 4 0 + 8 [kworker/0:1H]
252,0    0       14     0.656521240     9  C WZS REAL 4 0 + 8 [0]
252,0    0       15    10.598584665 11587  Q WZS 0 + 8 [blkdiscard]
252,0    0       16    10.598600772 11587  G WZS 0 + 8 [blkdiscard]
252,0    0       19    10.598619039 11587  I WZS 0 + 8 [blkdiscard]
252,0    0       20    10.598670130   517  D WZS 0 + 8 [kworker/0:1H]
252,0    0       21    10.598693597     9  C WZS 0 + 8 [0]
252,0    0       22    10.604513117 11588  Q WZS IDLE 7 0 + 8 [blkdiscard]
252,0    0       23    10.604523031 11588  G WZS IDLE 7 0 + 8 [blkdiscard]
252,0    0       26    10.604535549 11588  I WZS IDLE 7 0 + 8 [blkdiscard]
252,0    0       27    10.604563234   517  D WZS IDLE 7 0 + 8 [kworker/0:1H]
252,0    0       28    10.604586205     9  C WZS IDLE 7 0 + 8 [0]

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 blkparse_fmt.c | 76 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/blkparse_fmt.c b/blkparse_fmt.c
index c42e6d7..2935680 100644
--- a/blkparse_fmt.c
+++ b/blkparse_fmt.c
@@ -5,6 +5,7 @@
 #include <stdio.h>
 #include <string.h>
 #include <stdlib.h>
+#include <stdint.h>
 #include <unistd.h>
 #include <ctype.h>
 #include <time.h>
@@ -15,6 +16,11 @@
 
 #define HEADER		"%D %2c %8s %5T.%9t %5p %2a %3d "
 
+#ifdef CONFIG_BLKTRACE_EXT
+extern uint32_t blkparse_prio_mask;
+extern int bparse_track_prio;
+#endif /* CONFIG_BLKTRACE_EXT */
+
 static char *override_format[256];
 
 static inline int valid_spec(int spec)
@@ -52,6 +58,17 @@ int add_format_spec(char *option)
 
 static inline void fill_rwbs(char *rwbs, struct blk_io_trace *t)
 {
+#ifdef CONFIG_BLKTRACE_EXT
+	uint64_t w = t->action & BLK_TC_ACT(BLK_TC_WRITE);
+	uint64_t a = t->action & BLK_TC_ACT(BLK_TC_AHEAD);
+	uint64_t s = t->action & BLK_TC_ACT(BLK_TC_SYNC);
+	uint64_t m = t->action & BLK_TC_ACT(BLK_TC_META);
+	uint64_t d = t->action & BLK_TC_ACT(BLK_TC_DISCARD);
+	uint64_t f = t->action & BLK_TC_ACT(BLK_TC_FLUSH);
+	uint64_t u = t->action & BLK_TC_ACT(BLK_TC_FUA);
+	uint64_t z = t->action & BLK_TC_ACT(BLK_TC_WRITE_ZEROES);
+	uint64_t r = t->action & BLK_TC_ACT(BLK_TC_ZONE_RESET);
+#else
 	int w = t->action & BLK_TC_ACT(BLK_TC_WRITE);
 	int a = t->action & BLK_TC_ACT(BLK_TC_AHEAD);
 	int s = t->action & BLK_TC_ACT(BLK_TC_SYNC);
@@ -59,6 +76,7 @@ static inline void fill_rwbs(char *rwbs, struct blk_io_trace *t)
 	int d = t->action & BLK_TC_ACT(BLK_TC_DISCARD);
 	int f = t->action & BLK_TC_ACT(BLK_TC_FLUSH);
 	int u = t->action & BLK_TC_ACT(BLK_TC_FUA);
+#endif /* CONFIG_BLKTRACE_EXT */
 	int i = 0;
 
 	if (f)
@@ -66,6 +84,15 @@ static inline void fill_rwbs(char *rwbs, struct blk_io_trace *t)
 
 	if (d)
 		rwbs[i++] = 'D';
+#ifdef CONFIG_BLKTRACE_EXT
+	else if (z) {
+		rwbs[i++] = 'W'; /* write-zeroes */
+		rwbs[i++] = 'Z';
+	} else if (r) {
+		rwbs[i++] = 'Z'; /* zone-reset */
+		rwbs[i++] = 'R';
+	}
+#endif /* CONFIG_BLKTRACE_EXT */
 	else if (w)
 		rwbs[i++] = 'W';
 	else if (t->bytes)
@@ -311,6 +338,35 @@ static void process_default(char *act, struct per_cpu_info *pci,
 		MAJOR(t->device), MINOR(t->device), pci->cpu, t->sequence,
 		(int) SECONDS(t->time), (unsigned long) NANO_SECONDS(t->time),
 		t->pid, act, rwbs);
+#ifdef CONFIG_BLKTRACE_EXT
+	/* XXX: optimize the print format somthing like NN/RT/BT/ID */
+	if (bparse_track_prio) {
+		switch (IOPRIO_PRIO_CLASS(t->ioprio)) {
+		case IOPRIO_CLASS_NONE:
+			if (blkparse_prio_mask & 0x1)
+				fprintf(ofp, "NONE %1lu ",
+						IOPRIO_PRIO_DATA(t->ioprio));
+			break;
+		case IOPRIO_CLASS_RT:
+			if (blkparse_prio_mask & 0x2)
+				fprintf(ofp, "REAL %1lu ",
+						IOPRIO_PRIO_DATA(t->ioprio));
+			break;
+		case IOPRIO_CLASS_BE:
+			if (blkparse_prio_mask & 0x4)
+				fprintf(ofp, "BEST %1lu ",
+						IOPRIO_PRIO_DATA(t->ioprio));
+			break;
+		case IOPRIO_CLASS_IDLE:
+			if (blkparse_prio_mask & 0x8)
+				fprintf(ofp, "IDLE %1lu ",
+						IOPRIO_PRIO_DATA(t->ioprio));
+			break;
+		default:
+			fprintf(ofp, "ERRR   ");
+		}
+	}
+#endif /* CONFIG_BLKTRACE_EXT */
 
 	name = find_process_name(t->pid);
 
@@ -324,7 +380,11 @@ static void process_default(char *act, struct per_cpu_info *pci,
 			fprintf(ofp, "[%d]\n", t->error);
 		} else {
 			if (elapsed != -1ULL) {
+#ifdef CONFIG_BLKTRACE_EXT
+				if (t_sec(t) || t->sector) /* needed for ZR */
+#else
 				if (t_sec(t))
+#endif /* CONFIG_BLKTRACE_EXT */
 					fprintf(ofp, "%llu + %u (%8llu) [%d]\n",
 						(unsigned long long) t->sector,
 						t_sec(t), elapsed, t->error);
@@ -333,7 +393,11 @@ static void process_default(char *act, struct per_cpu_info *pci,
 						(unsigned long long) t->sector,
 						elapsed, t->error);
 			} else {
+#ifdef CONFIG_BLKTRACE_EXT
+				if (t_sec(t) || t->sector) /* needed for ZR */
+#else
 				if (t_sec(t))
+#endif /* CONFIG_BLKTRACE_EXT */
 					fprintf(ofp, "%llu + %u [%d]\n",
 						(unsigned long long) t->sector,
 						t_sec(t), t->error);
@@ -358,7 +422,11 @@ static void process_default(char *act, struct per_cpu_info *pci,
 			fprintf(ofp, "[%s]\n", name);
 		} else {
 			if (elapsed != -1ULL) {
+#ifdef CONFIG_BLKTRACE_EXT
 				if (t_sec(t))
+#else
+				if (t_sec(t) || t->sector) /* needed for ZR */
+#endif /* CONFIG_BLKTRACE_EXT */
 					fprintf(ofp, "%llu + %u (%8llu) [%s]\n",
 						(unsigned long long) t->sector,
 						t_sec(t), elapsed, name);
@@ -366,7 +434,11 @@ static void process_default(char *act, struct per_cpu_info *pci,
 					fprintf(ofp, "(%8llu) [%s]\n", elapsed,
 						name);
 			} else {
+#ifdef CONFIG_BLKTRACE_EXT
+				if (t_sec(t) || t->sector) /* needed for ZR */
+#else
 				if (t_sec(t))
+#endif /* CONFIG_BLKTRACE_EXT */
 					fprintf(ofp, "%llu + %u [%s]\n",
 						(unsigned long long) t->sector,
 						t_sec(t), name);
@@ -380,7 +452,11 @@ static void process_default(char *act, struct per_cpu_info *pci,
 	case 'F':	/* Front merge */
 	case 'G':	/* Get request */
 	case 'S':	/* Sleep request */
+#ifdef CONFIG_BLKTRACE_EXT
+		if (t_sec(t) || t->sector) /* needed for ZR */
+#else
 		if (t_sec(t))
+#endif /* CONFIG_BLKTRACE_EXT */
 			fprintf(ofp, "%llu + %u [%s]\n",
 				(unsigned long long) t->sector, t_sec(t), name);
 		else
-- 
2.19.1

