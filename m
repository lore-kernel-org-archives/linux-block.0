Return-Path: <SRS0=aWxv=TB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9580EC43219
	for <linux-block@archiver.kernel.org>; Wed,  1 May 2019 04:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6429D20866
	for <linux-block@archiver.kernel.org>; Wed,  1 May 2019 04:33:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="SIKNhdIu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725776AbfEAEdd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 May 2019 00:33:33 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:63464 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfEAEdd (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 May 2019 00:33:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1556685214; x=1588221214;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HFiyCWDxmB3njrOTkqlK+KXLrC9HqciLiQ062ymPrDY=;
  b=SIKNhdIu1DaGl3qq3q8HLGMkrqgTvS0mZxnRRRKVW6RkqjmyX0rI/fzD
   eoVxe1d26Ab0g37+fQ2NgvM+kdTJacvvBE8BpdONcLMnT4uQlfNmRdfdg
   LudLP+P0JE/Yln0iy1kJ3zPBUz+34KdSVD217pleEIzYSQIOMNw49OZyL
   ARsff7lc/Rl+iYLwJwDb/PiQy06rAWrZNIzxwyLPjILFbEaN3XXDmIDWW
   08yvNakWXyFSebiZghvZ6nL986PqkzJliQqxOYZAYth/FT90G4o8aVP7d
   SgL18El+fJ2TeVNF4HJn3/AJvCHBlVVQAwY3EhmOVAK11VVM86Dtqa4Xp
   Q==;
X-IronPort-AV: E=Sophos;i="5.60,416,1549900800"; 
   d="scan'208";a="107229727"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 01 May 2019 12:33:33 +0800
IronPort-SDR: vZ7F3Jns2o7zRZWuQ+NnvOfaYD0tMyReqkNPrGvMjPNywjqfKb/OioUNIgGwSF5L9gkwcGbbHF
 sAfX+U6vxdlxK5+A4toxdEGd13IKzmeYLZwUurpPyHa5DsCLcUj/rxzu6z6ZU73QRo+u61r4ys
 kFdDSDQdAX4kEPMmCXuFja/DdgtGtSZxT8lOcgg2VAuUOfwjpL4nABZA8VBq4jH6FR8aSWx/iQ
 2MXxCgX27iUDOctE6PkZSVWfrFi4RMguAgFi8JygLBjM4AV4R8vY7EHigkbIltre4Bqfrht369
 JVFQNQrBdc3C4TGJ3PJInqa3
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP; 30 Apr 2019 21:12:02 -0700
IronPort-SDR: L1qEvqDKZAM7EOX/dI3s+FoPP044ZSthlSq3dMc4buFXsqGFK+JM+OmW3n4sOpDqdjfWgxEjll
 aHumtCVHx+zLdlMaYT4JLXDcPQ3GBpMfkZE0lF2nu3hK7MCGtVGx+A1XzImBas5kJmKuTov3d1
 6OicO9X/thjkmSiUBHjyDxNBrgoDHEsO0cx5eNpB0R99KXY71fxEKRitlvgqCQuhbqPB5Wk3Ft
 NGEk3CvhdkBw7z9ENsI+LX0rXo7+WfN9XtC2aUYs9817Y66328pP+EDQpoWM/JYhdvca3gANEe
 e50=
Received: from cmercuryqemu.hgst.com ([10.202.65.32])
  by uls-op-cesaip01.wdc.com with ESMTP; 30 Apr 2019 21:33:33 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [RFC PATCH blktrace-tools 04/10] blktrace.c: add support for extensions
Date:   Tue, 30 Apr 2019 21:33:11 -0700
Message-Id: <20190501043317.5507-5-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190501043317.5507-1-chaitanya.kulkarni@wdc.com>
References: <20190501043317.5507-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch adds support for blktrace tool to use the blktrace extension.
Here we also add the support for priority tracking and using priority
mask from the command line just like action mask.

Here we also increase the size of the various bufferes.
We add three new command line options so that user can specify whethere
to track priority and priority mask just like actiom mask.
In order to keep the backward compaibility we by default we turn off
the priority tracking.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 blktrace.c | 85 ++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 80 insertions(+), 5 deletions(-)

diff --git a/blktrace.c b/blktrace.c
index d0d271f..e5105f5 100644
--- a/blktrace.c
+++ b/blktrace.c
@@ -57,10 +57,17 @@
  * You may want to increase this even more, if you are logging at a high
  * rate and see skipped/missed events
  */
+#ifdef CONFIG_BLKTRACE_EXT
+#define BUF_SIZE		(1024 * 1024)
+#define BUF_NR			(4)
+
+#define FILE_VBUF_SIZE		(256 * 1024)
+#else
 #define BUF_SIZE		(512 * 1024)
 #define BUF_NR			(4)
 
 #define FILE_VBUF_SIZE		(128 * 1024)
+#endif /* CONFIG_BLKTRACE_EXT */
 
 #define DEBUGFS_TYPE		(0x64626720)
 #define TRACE_NET_PORT		(8462)
@@ -279,7 +286,15 @@ static int max_cpus;
 static int ncpus;
 static cpu_set_t *online_cpus;
 static int pagesize;
+
+#ifdef CONFIG_BLKTRACE_EXT
+static uint64_t act_mask = -1ULL;
+/* by default don't trace priority */
+static uint32_t blktrace_prio_mask = 0;
+int btrace_track_prio;
+#else
 static int act_mask = ~0U;
+#endif /* CONFIG_BLKTRACE_EXT */
 static int kill_running_trace;
 static int stop_watch;
 static int piped_output;
@@ -329,7 +344,11 @@ static int *cl_fds;
 static int (*handle_pfds)(struct tracer *, int, int);
 static int (*handle_list)(struct tracer_devpath_head *, struct list_head *);
 
+#ifdef CONFIG_BLKTRACE_EXT
+#define S_OPTS	"d:a:A:r:o:kw:vVb:n:D:lh:p:sI:Px:X:"
+#else
 #define S_OPTS	"d:a:A:r:o:kw:vVb:n:D:lh:p:sI:"
+#endif /* CONFIG_BLKTRACE_EXT */
 static struct option l_opts[] = {
 	{
 		.name = "dev",
@@ -427,6 +446,24 @@ static struct option l_opts[] = {
 		.flag = NULL,
 		.val = 'p'
 	},
+	{
+		.name = "track-priority",
+		.has_arg = no_argument,
+		.flag = NULL,
+		.val = 'P'
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
 	{
 		.name = "no-sendfile",
 		.has_arg = no_argument,
@@ -453,6 +490,9 @@ static char usage_str[] = "\n\n" \
         "[ -p <port number>   | --port=<port number>]\n" \
         "[ -s                 | --no-sendfile]\n" \
         "[ -I <devs file>     | --input-devs=<devs file>]\n" \
+        "[ -P                 | --track-priority ]\n" \
+        "[ -x <ioprio field>  | --prio-mask=<ioprio field> ]\n" \
+        "[ -X <ioprio mask>   | --set-mask=<ioprio mask> ]\n" \
         "[ -v <version>       | --version]\n" \
         "[ -V <version>       | --version]\n" \
 
@@ -468,6 +508,9 @@ static char usage_str[] = "\n\n" \
 	"\t-l Run in network listen mode (blktrace server)\n" \
 	"\t-h Run in network client mode, connecting to the given host\n" \
 	"\t-p Network port to use (default 8462)\n" \
+	"\t-P Enable tracking priorites.\n" \
+	"\t-a Only priority specified actions.\n" \
+	"\t-A Give priority mask as a single value.\n" \
 	"\t-s Make the network client NOT use sendfile() to transfer data\n" \
 	"\t-I Add devices found in <devs file>\n" \
 	"\t-v Print program version info\n" \
@@ -633,11 +676,11 @@ static int lock_on_cpu(int cpu)
 	CPU_ZERO_S(size, cpu_mask);
 	CPU_SET_S(cpu, size, cpu_mask);
 	if (sched_setaffinity(0, size, cpu_mask) < 0) {
-		CPU_FREE(cpu_mask);		
+		CPU_FREE(cpu_mask);
 		return errno;
 	}
 
-	CPU_FREE(cpu_mask);		
+	CPU_FREE(cpu_mask);
 	return 0;
 }
 
@@ -1080,7 +1123,9 @@ static int setup_buts(void)
 		buts.buf_size = buf_size;
 		buts.buf_nr = buf_nr;
 		buts.act_mask = act_mask;
-
+#ifdef CONFIG_BLKTRACE_EXT
+		buts.prio_mask = btrace_track_prio ? blktrace_prio_mask : 0;
+#endif /* CONFIG_BLKTRACE_EXT */
 		if (ioctl(dpp->fd, BLKTRACESETUP, &buts) >= 0) {
 			dpp->ncpus = max_cpus;
 			dpp->buts_name = strdup(buts.name);
@@ -2104,7 +2149,7 @@ static int handle_args(int argc, char *argv[])
 {
 	int c, i;
 	struct statfs st;
-	int act_mask_tmp = 0;
+	unsigned int act_mask_tmp = 0;
 
 	while ((c = getopt_long(argc, argv, S_OPTS, l_opts, NULL)) >= 0) {
 		switch (c) {
@@ -2211,6 +2256,29 @@ static int handle_args(int argc, char *argv[])
 		case 'p':
 			net_port = atoi(optarg);
 			break;
+#ifdef CONFIG_BLKTRACE_EXT
+		case 'P': /* enable priority tracking */
+			btrace_track_prio = 1;
+			break;
+		case 'x': /* priority mask values in string */
+			i = find_prio_mask_map(optarg);
+			if (i < 0) {
+				fprintf(stderr,"Invalid prio mask %s\n",
+						optarg);
+				return 1;
+			}
+			blktrace_prio_mask |= i;
+			break;
+		case 'X': /* priority mask values in hex */
+			if ((sscanf(optarg, "%x", &i) != 1) ||
+					!valid_prio_opt(i)) {
+				fprintf(stderr, "Invalid prio mask %s/0x%x\n",
+						optarg, i);
+				return 1;
+			}
+			blktrace_prio_mask = i;
+			break;
+#endif /* CONFIG_BLKTRACE_EXT */
 		case 's':
 			net_use_sendfile = 0;
 			break;
@@ -2243,7 +2311,14 @@ static int handle_args(int argc, char *argv[])
 
 	if (act_mask_tmp != 0)
 		act_mask = act_mask_tmp;
-
+#ifdef CONFIG_BLKTRACE_EXT
+	/*
+	 * When track-priority is on and user didn't specify prio_mask then
+	 * trace all the classes.
+	 */
+	if (btrace_track_prio && !blktrace_prio_mask)
+		blktrace_prio_mask = TRACE_ALL_IOPRIO;
+#endif /* CONFIG_BLKTRACE_EXT */
 	if (net_mode == Net_client && net_setup_addr())
 		return 1;
 
-- 
2.19.1

