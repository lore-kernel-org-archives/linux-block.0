Return-Path: <SRS0=aWxv=TB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DADF1C43219
	for <linux-block@archiver.kernel.org>; Wed,  1 May 2019 04:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB73F20866
	for <linux-block@archiver.kernel.org>; Wed,  1 May 2019 04:33:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="VCegtAsg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726022AbfEAEdg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 May 2019 00:33:36 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:63464 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbfEAEdg (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 May 2019 00:33:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1556685216; x=1588221216;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WpReDyaaRaxg+6XhstJs3f/exDS12ahEFhY2353rdRY=;
  b=VCegtAsg2+RHVx4rJCcavAIqmQQRApSpbxZz65/XznAICqEIBa1+oK0Y
   IeaMNPULf7OnFnGG921UaqovqoaJMVQC2WM5s+WzImSUvqm+BfNHzpiWg
   N+B5X8U0/uFov9R+RfPHVjL5MYRrYNAdgVt3S+JX4X0mR5fNH66gga3Wz
   cgMYCgx930ijQ+BwCsrI5wxDtAc4d/OlN6HiGeZJ3VLkiHLkHfUWTN45t
   XkTrwPZ+xahPrY7P02mSVS98VWj1pdjgtCWE9AFky4balvKyffXIrBqq8
   N9V/gLcsIy6mjBzanj8q6lSjCiI0NIk9RLE2kYmsutu9s9cWoq/he06Ur
   g==;
X-IronPort-AV: E=Sophos;i="5.60,416,1549900800"; 
   d="scan'208";a="107229729"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 01 May 2019 12:33:36 +0800
IronPort-SDR: PWtzPwUMTYaQp+ufdRpusMgjcuLrWcpqO/iuqYMzCZWeT1zv3t9KROgdYIB0CpdZteqMvVIr2I
 dm9/7XHKnKCJt8T7cVaO2QO08ByFCcQdiRicMEIoqVFTuf5kfUHh49DLX4Baassi224BmmG9An
 dDsuDsawz2fR4jTHkESnmX2JicnfXc9IqpMZRSBkaS/ny/rb7ZlyFUnGN5iO4bl0DUz7SvKqRC
 idxKamFCOCQyFE8utxIIsQkUhalw4CHl3Eb3tHi6RwIrYm0/mNSuOpz51Sdmr+1xCgz5/Jc/LE
 eXXs6kLczmaQ3xS2AaRteiQK
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP; 30 Apr 2019 21:12:04 -0700
IronPort-SDR: gfErVIHnNVtuTvKPs3ITsw0yIR73LJvIhYhVtAYvKPWk7Dj7mYqi6t3h0qyZ18OhWAajbnJg0f
 76r1NI2KPiPg1QGaABfdy2sNcczLR0XZXYBxqsJvBM2tWlFhTseKTbpWK8LuKb+U8ed8xHX3LA
 s9AsoFDw0NR3e5gGs9PZLgOYkyjfz8IJLroJdRinbQUc651xFBQmxwmcOQ0pY9Hk4EtlRKYiTH
 ea124oDseuvwfQ7Z7zZBkHYEOTksmuaCfIZnreMEAgEIRT3dAL9i9GaWSWXitiO2ok+JZ+xGVo
 0vQ=
Received: from cmercuryqemu.hgst.com ([10.202.65.32])
  by uls-op-cesaip01.wdc.com with ESMTP; 30 Apr 2019 21:33:36 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [RFC PATCH blktrace-tools 05/10] blkparse.c: add support for extensions
Date:   Tue, 30 Apr 2019 21:33:12 -0700
Message-Id: <20190501043317.5507-6-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190501043317.5507-1-chaitanya.kulkarni@wdc.com>
References: <20190501043317.5507-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch adds support for blkparse tool to use the blktrace extension.
Here we also add the support for priority tracking and using priority
mask from the command line just like action mask.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 blkparse.c | 85 ++++++++++++++++++++++++++++++++++++++++++++++++++++--
 blktrace.h |  1 +
 2 files changed, 83 insertions(+), 3 deletions(-)

diff --git a/blkparse.c b/blkparse.c
index 227cc44..228c8d6 100644
--- a/blkparse.c
+++ b/blkparse.c
@@ -105,7 +105,7 @@ static struct per_process_info *ppi_list;
 static int ppi_list_entries;
 
 static struct option l_opts[] = {
- 	{
+	{
 		.name = "act-mask",
 		.has_arg = required_argument,
 		.flag = NULL,
@@ -177,6 +177,26 @@ static struct option l_opts[] = {
 		.flag = NULL,
 		.val = 'O'
 	},
+#ifdef CONFIG_BLKTRACE_EXT
+	{
+		.name = "track-priority",
+		.has_arg = no_argument,
+		.flag = NULL,
+		.val = 'p'
+	},
+	{
+		.name = "prio-mask",
+		.has_arg = required_argument,
+		.flag = NULL,
+		.val = 'x'
+	},
+	{
+		.name = "prio-set-mask",
+		.has_arg = required_argument,
+		.flag = NULL,
+		.val = 'X'
+	},
+#endif /* CONFIG_BLKTRACE_EXT */
 	{
 		.name = "quiet",
 		.has_arg = no_argument,
@@ -273,9 +293,21 @@ static int per_device_and_cpu_stats = 1;
 static int track_ios;
 static int ppi_hash_by_pid = 1;
 static int verbose;
+
+#ifdef CONFIG_BLKTRACE_EXT
+static uint64_t act_mask = -1ULL;
+/* by default don't trace priority */
+uint32_t blkparse_prio_mask;
+#else
 static unsigned int act_mask = -1U;
+#endif /* CONFIG_BLKTRACE_EXT */
+
 static int stats_printed;
 static int bin_output_msgs = 1;
+
+#ifdef CONFIG_BLKTRACE_EXT
+int bparse_track_prio;
+#endif /* CONFIG_BLKTRACE_EXT */
 int data_is_native = -1;
 
 static FILE *dump_fp;
@@ -1614,7 +1646,11 @@ static void dump_trace_fs(struct blk_io_trace *t, struct per_dev_info *pdi,
 			/* dump to binary file only */
 			break;
 		default:
+#ifdef CONFIG_BLKTRACE_EXT
+			fprintf(stderr, "Bad fs action %llx\n", t->action);
+#else
 			fprintf(stderr, "Bad fs action %x\n", t->action);
+#endif /* CONFIG_BLKTRACE_EXT */
 			break;
 	}
 }
@@ -2730,7 +2766,11 @@ static int is_pipe(const char *str)
 	return 0;
 }
 
+#ifdef CONFIG_BLKTRACE_EXT
+#define S_OPTS  "a:A:b:D:d:f:F:hi:o:Oqstw:vVMpx:X:"
+#else
 #define S_OPTS  "a:A:b:D:d:f:F:hi:o:Oqstw:vVM"
+#endif /* CONFIG_BLKTRACE_EXT */
 static char usage_str[] =    "\n\n" \
 	"-i <file>           | --input=<file>\n" \
 	"[ -a <action field> | --act-mask=<action field> ]\n" \
@@ -2746,6 +2786,9 @@ static char usage_str[] =    "\n\n" \
 	"[ -q                | --quiet ]\n" \
 	"[ -s                | --per-program-stats ]\n" \
 	"[ -t                | --track-ios ]\n" \
+	"[ -p                | --track-prio ]\n" \
+	"[ -x <ioprio field> | --act-mask=<ioprio field> ]\n" \
+	"[ -X <ioprio mask>  | --set-mask=<ioprio mask> ]\n" \
 	"[ -w <time>         | --stopwatch=<time> ]\n" \
 	"[ -M                | --no-msgs\n" \
 	"[ -v                | --verbose ]\n" \
@@ -2762,6 +2805,9 @@ static char usage_str[] =    "\n\n" \
 	"\t-i Input file containing trace data, or '-' for stdin\n" \
 	"\t-o Output file. If not given, output is stdout\n" \
 	"\t-O Do NOT output text data\n" \
+	"\t-p Track indivisual I/Os priority.\n" \
+	"\t-x Only trace specified priority.\n" \
+	"\t-X Give priority class mask as a single value.\n" \
 	"\t-q Quiet. Don't display any stats at the end of the trace\n" \
 	"\t-s Show per-program io statistics\n" \
 	"\t-t Track individual ios. Will tell you the time a request took\n" \
@@ -2780,9 +2826,9 @@ static void usage(char *prog)
 int main(int argc, char *argv[])
 {
 	int i, c, ret, mode;
-	int act_mask_tmp = 0;
 	char *ofp_buffer = NULL;
 	char *bin_ofp_buffer = NULL;
+	unsigned int act_mask_tmp = 0;
 
 	while ((c = getopt_long(argc, argv, S_OPTS, l_opts, NULL)) != -1) {
 		switch (c) {
@@ -2797,7 +2843,7 @@ int main(int argc, char *argv[])
 			break;
 
 		case 'A':
-			if ((sscanf(optarg, "%x", &i) != 1) || 
+			if ((sscanf(optarg, "%x", &i) != 1) ||
 							!valid_act_opt(i)) {
 				fprintf(stderr,
 					"Invalid set action mask %s/0x%x\n",
@@ -2833,6 +2879,31 @@ int main(int argc, char *argv[])
 		case 't':
 			track_ios = 1;
 			break;
+#ifdef CONFIG_BLKTRACE_EXT
+		case 'p':
+			bparse_track_prio = 1;
+			break;
+		case 'x':
+			i = find_prio_mask_map(optarg);
+			if (i < 0) {
+				fprintf(stderr,"Invalid priority mask %s\n",
+					optarg);
+				return 1;
+			}
+			blkparse_prio_mask |= i;
+			break;
+
+		case 'X':
+			if ((sscanf(optarg, "%x", &i) != 1) ||
+							!valid_prio_opt(i)) {
+				fprintf(stderr,
+					"Invalid set priority mask %s/0x%x\n",
+					optarg, i);
+				return 1;
+			}
+			blkparse_prio_mask = i;
+			break;
+#endif /* CONFIG_BLKTRACE_EXT */
 		case 'q':
 			per_device_and_cpu_stats = 0;
 			break;
@@ -2884,6 +2955,14 @@ int main(int argc, char *argv[])
 
 	if (act_mask_tmp != 0)
 		act_mask = act_mask_tmp;
+#ifdef CONFIG_BLKTRACE_EXT
+	/*
+	 * When track-priority is on and user didn't specify prio_mask then trace
+	 * all the ioprio classes.
+	 */
+	if (bparse_track_prio && !blkparse_prio_mask)
+		blkparse_prio_mask = TRACE_ALL_IOPRIO;
+#endif /* CONFIG_BLKTRACE_EXT */
 
 	memset(&rb_sort_root, 0, sizeof(rb_sort_root));
 
diff --git a/blktrace.h b/blktrace.h
index c860bf9..8473951 100644
--- a/blktrace.h
+++ b/blktrace.h
@@ -57,6 +57,7 @@ enum {
 #define TRACE_ALL_IOPRIO ((1 << IOPRIO_CLASS_NONE) | (1 << IOPRIO_CLASS_RT) | \
 		(1 << IOPRIO_CLASS_BE) | (1 << IOPRIO_CLASS_IDLE))
 
+extern int bparse_track_prior;
 #endif /* CONFIG_BLKTRACE_EXT */
 
 typedef __u32 u32;
-- 
2.19.1

