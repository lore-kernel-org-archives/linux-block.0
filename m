Return-Path: <SRS0=/NKK=RL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D48FC43381
	for <linux-block@archiver.kernel.org>; Fri,  8 Mar 2019 21:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5092E20855
	for <linux-block@archiver.kernel.org>; Fri,  8 Mar 2019 21:59:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbfCHV7e (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Mar 2019 16:59:34 -0500
Received: from mga07.intel.com ([134.134.136.100]:37684 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726258AbfCHV7e (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 8 Mar 2019 16:59:34 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Mar 2019 13:59:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,456,1544515200"; 
   d="scan'208";a="132763291"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.112.69])
  by fmsmga007.fm.intel.com with ESMTP; 08 Mar 2019 13:59:33 -0800
From:   Keith Busch <keith.busch@intel.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <keith.busch@intel.com>
Subject: [PATCH fio] t/io_uring: add depth options
Date:   Fri,  8 Mar 2019 14:59:59 -0700
Message-Id: <20190308215959.5575-1-keith.busch@intel.com>
X-Mailer: git-send-email 2.13.6
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Make depth options command line parameters so a recompile isn't
required to see how it affects performance.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 t/io_uring.c | 70 ++++++++++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 52 insertions(+), 18 deletions(-)

diff --git a/t/io_uring.c b/t/io_uring.c
index c7139f87..36aede9b 100644
--- a/t/io_uring.c
+++ b/t/io_uring.c
@@ -44,7 +44,6 @@ struct io_cq_ring {
 };
 
 #define DEPTH			128
-
 #define BATCH_SUBMIT		32
 #define BATCH_COMPLETE		32
 
@@ -67,7 +66,6 @@ struct submitter {
 	struct drand48_data rand;
 	struct io_sq_ring sq_ring;
 	struct io_uring_sqe *sqes;
-	struct iovec iovecs[DEPTH];
 	struct io_cq_ring cq_ring;
 	int inflight;
 	unsigned long reaps;
@@ -81,11 +79,15 @@ struct submitter {
 	struct file files[MAX_FDS];
 	unsigned nr_files;
 	unsigned cur_file;
+	struct iovec iovecs[];
 };
 
-static struct submitter submitters[1];
+static struct submitter *submitter;
 static volatile int finish;
 
+static int depth = DEPTH;
+static int batch_submit = BATCH_SUBMIT;
+static int batch_complete = BATCH_COMPLETE;
 static int polled = 1;		/* use IO polling */
 static int fixedbufs = 1;	/* use fixed user buffers */
 static int register_files = 1;	/* use fixed files */
@@ -100,7 +102,7 @@ static int io_uring_register_buffers(struct submitter *s)
 		return 0;
 
 	return syscall(__NR_sys_io_uring_register, s->ring_fd,
-			IORING_REGISTER_BUFFERS, s->iovecs, DEPTH);
+			IORING_REGISTER_BUFFERS, s->iovecs, depth);
 }
 
 static int io_uring_register_files(struct submitter *s)
@@ -139,7 +141,7 @@ static int gettid(void)
 
 static unsigned file_depth(struct submitter *s)
 {
-	return (DEPTH + s->nr_files - 1) / s->nr_files;
+	return (depth + s->nr_files - 1) / s->nr_files;
 }
 
 static void init_io(struct submitter *s, unsigned index)
@@ -295,18 +297,18 @@ static void *submitter_fn(void *data)
 	do {
 		int to_wait, to_submit, this_reap, to_prep;
 
-		if (!prepped && s->inflight < DEPTH) {
-			to_prep = min(DEPTH - s->inflight, BATCH_SUBMIT);
+		if (!prepped && s->inflight < depth) {
+			to_prep = min(depth - s->inflight, batch_submit);
 			prepped = prep_more_ios(s, to_prep);
 		}
 		s->inflight += prepped;
 submit_more:
 		to_submit = prepped;
 submit:
-		if (to_submit && (s->inflight + to_submit <= DEPTH))
+		if (to_submit && (s->inflight + to_submit <= depth))
 			to_wait = 0;
 		else
-			to_wait = min(s->inflight + to_submit, BATCH_COMPLETE);
+			to_wait = min(s->inflight + to_submit, batch_complete);
 
 		/*
 		 * Only need to call io_uring_enter if we're not using SQ thread
@@ -377,7 +379,7 @@ submit:
 static void sig_int(int sig)
 {
 	printf("Exiting on signal %d\n", sig);
-	submitters[0].finish = 1;
+	submitter->finish = 1;
 	finish = 1;
 }
 
@@ -411,7 +413,7 @@ static int setup_ring(struct submitter *s)
 		}
 	}
 
-	fd = io_uring_setup(DEPTH, &p);
+	fd = io_uring_setup(depth, &p);
 	if (fd < 0) {
 		perror("io_uring_setup");
 		return 1;
@@ -466,7 +468,7 @@ static int setup_ring(struct submitter *s)
 
 static void file_depths(char *buf)
 {
-	struct submitter *s = &submitters[0];
+	struct submitter *s = submitter;
 	char *p;
 	int i;
 
@@ -482,24 +484,56 @@ static void file_depths(char *buf)
 	}
 }
 
+static void usage(char *argv)
+{
+	printf("%s [options] -- [filenames]\n"
+		" -d <int> : IO Depth, default %d\n"
+		" -s <int> : Batch submit, default %d\n"
+		" -c <int> : Batch complete, default %d\n",
+		argv, DEPTH, BATCH_SUBMIT, BATCH_COMPLETE);
+	exit(0);
+}
+
 int main(int argc, char *argv[])
 {
-	struct submitter *s = &submitters[0];
+	struct submitter *s;
 	unsigned long done, calls, reap, cache_hit, cache_miss;
-	int err, i, flags, fd;
+	int err, i, flags, fd, opt;
 	char *fdepths;
 	void *ret;
 
 	if (!do_nop && argc < 2) {
-		printf("%s: filename\n", argv[0]);
+		printf("%s: filename [options]\n", argv[0]);
 		return 1;
 	}
 
+	while ((opt = getopt(argc, argv, "d:s:c:h?")) != -1) {
+		switch (opt) {
+		case 'd':
+			depth = atoi(optarg);
+			break;
+		case 's':
+			batch_submit = atoi(optarg);
+			break;
+		case 'c':
+			batch_complete = atoi(optarg);
+			break;
+		case 'h':
+		case '?':
+		default:
+			usage(argv[0]);
+			break;
+		}
+	}
+
+	submitter = malloc(sizeof(*submitter) * depth * sizeof(struct iovec));
+	s = submitter;
+
 	flags = O_RDONLY | O_NOATIME;
 	if (!buffered)
 		flags |= O_DIRECT;
 
-	i = 1;
+	i = optind;
 	while (!do_nop && i < argc) {
 		struct file *f;
 
@@ -543,7 +577,7 @@ int main(int argc, char *argv[])
 
 	arm_sig_int();
 
-	for (i = 0; i < DEPTH; i++) {
+	for (i = 0; i < depth; i++) {
 		void *buf;
 
 		if (posix_memalign(&buf, BS, BS)) {
@@ -560,7 +594,7 @@ int main(int argc, char *argv[])
 		return 1;
 	}
 	printf("polled=%d, fixedbufs=%d, buffered=%d", polled, fixedbufs, buffered);
-	printf(" QD=%d, sq_ring=%d, cq_ring=%d\n", DEPTH, *s->sq_ring.ring_entries, *s->cq_ring.ring_entries);
+	printf(" QD=%d, sq_ring=%d, cq_ring=%d\n", depth, *s->sq_ring.ring_entries, *s->cq_ring.ring_entries);
 
 	pthread_create(&s->thread, NULL, submitter_fn, s);
 
-- 
2.14.4

