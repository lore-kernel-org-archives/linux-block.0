Return-Path: <SRS0=zBYI=YO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23CCACA9EAF
	for <linux-block@archiver.kernel.org>; Mon, 21 Oct 2019 11:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAFC220B7C
	for <linux-block@archiver.kernel.org>; Mon, 21 Oct 2019 11:40:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbfJULk5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Oct 2019 07:40:57 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:43328 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727685AbfJULk5 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Oct 2019 07:40:57 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 9CFA98614F2B7073ECD1;
        Mon, 21 Oct 2019 19:40:53 +0800 (CST)
Received: from localhost.localdomain (10.175.124.28) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.439.0; Mon, 21 Oct 2019 19:40:43 +0800
From:   yangerkun <yangerkun@huawei.com>
To:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>
CC:     <yi.zhang@huawei.com>, <houtao1@huawei.com>, <yangerkun@huawei.com>
Subject: [PATCH liburing] Add test for overflow of timeout request's sequence
Date:   Mon, 21 Oct 2019 20:02:17 +0800
Message-ID: <20191021120217.31213-1-yangerkun@huawei.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Before 5da0fb1ab34c ("io_uring: consider the overflow of sequence for
timeout req"). We can meet some situation like below:

1. setup
2. prepare 4 timeout req which expected count is 1,1,2,UINT_MAX, and the
sequence of this 4 requests will be 1,2,4,2, this 4 requests will not
lead the change of cached_cq_tail and sq_dropped until the timeout
really happened. So the tail_index in io_timeout will still be 0.
3. based on the above and before this patch, the order of timeout_list
will be req1->req2->req4->req3, which the right order should be
req1->req2->req3->req4.
4. setup two nop requests. And the timeout requests will return
correctly with the patch.

Add this testcase to cover it.

Signed-off-by: yangerkun <yangerkun@huawei.com>
---
 test/Makefile           |   4 +-
 test/timeout-overflow.c | 184 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 186 insertions(+), 2 deletions(-)
 create mode 100644 test/timeout-overflow.c

diff --git a/test/Makefile b/test/Makefile
index 3ab5f81..89937a3 100644
--- a/test/Makefile
+++ b/test/Makefile
@@ -7,7 +7,7 @@ all_targets += poll poll-cancel ring-leak fsync io_uring_setup io_uring_register
 		917257daa0fe-test b19062a56726-test eeed8b54e0df-test link \
 		send_recvmsg a4c0b3decb33-test 500f9fbadef8-test timeout \
 		sq-space_left stdout cq-ready cq-peek-batch file-register \
-		cq-size 8a9973408177-test a0908ae19763-test
+		cq-size 8a9973408177-test a0908ae19763-test timeout-overflow
 
 include ../Makefile.quiet
 
@@ -22,7 +22,7 @@ test_srcs := poll.c poll-cancel.c ring-leak.c fsync.c io_uring_setup.c \
 	eeed8b54e0df-test.c link.c send_recvmsg.c a4c0b3decb33-test.c \
 	500f9fbadef8-test.c timeout.c sq-space_left.c stdout.c cq-ready.c\
 	cq-peek-batch.c file-register.c cq-size.c 8a9973408177-test.c \
-	a0908ae19763-test.c
+	a0908ae19763-test.c timeout-overflow.c
 
 test_objs := $(patsubst %.c,%.ol,$(test_srcs))
 
diff --git a/test/timeout-overflow.c b/test/timeout-overflow.c
new file mode 100644
index 0000000..8d4763b
--- /dev/null
+++ b/test/timeout-overflow.c
@@ -0,0 +1,184 @@
+/*
+ * Description: run timeout overflow test
+ *
+ */
+#include <errno.h>
+#include <stdio.h>
+#include <limits.h>
+#include <sys/time.h>
+
+#include "liburing.h"
+
+#define TIMEOUT_MSEC	1000
+static int not_supported;
+
+static int check_timeout_support()
+{
+	struct io_uring_sqe *sqe;
+	struct io_uring_cqe *cqe;
+	struct __kernel_timespec ts;
+	struct io_uring ring;
+	int ret;
+
+	ret = io_uring_queue_init(8, &ring, 0);
+	if (ret) {
+		printf("ring setup failed\n");
+		return 1;
+	}
+	sqe = io_uring_get_sqe(&ring);
+	ts.tv_sec = TIMEOUT_MSEC / 1000;
+	ts.tv_nsec = 0;
+	io_uring_prep_timeout(sqe, &ts, 1, 0);
+
+	ret = io_uring_submit(&ring);
+	if (ret < 0) {
+		printf("sqe submit failed: %d\n", ret);
+		goto err;
+	}
+
+	ret = io_uring_wait_cqe(&ring, &cqe);
+	if (ret < 0) {
+		printf("wait completion %d\n", ret);
+		goto err;
+	}
+
+	if (cqe->res == -EINVAL) {
+		not_supported = 1;
+		printf("Timeout not supported, ignored\n");
+		return 0;
+	}
+	io_uring_cqe_seen(&ring, cqe);
+
+	return 0;
+err:
+	return 1;
+
+}
+
+/*
+ * We first setup 4 timeout requests, which require a count value of 1, 1, 2,
+ * UINT_MAX, so the sequence is 1, 2, 4, 2. Before really timeout, this 4
+ * requests will not lead the change of cq_cached_tail, so as sq_dropped.
+ *
+ * And before this patch. The order of this four requests will be req1->req2->
+ * req4->req3. Actually, it should be req1->req2->req3->req4.
+ *
+ * Then, if there is 2 nop req. All timeout requests expect req4 will completed
+ * successful after the patch. And req1/req2 will completed successful with
+ * req3/req4 return -ETIME without this patch!
+ */
+static int test_timeout_overflow()
+{
+	struct io_uring_sqe *sqe;
+	struct io_uring_cqe *cqe;
+	struct __kernel_timespec ts;
+	struct io_uring ring;
+	int i, ret;
+
+	ret = io_uring_queue_init(16, &ring, 0);
+	if (ret) {
+		printf("ring setup failed\n");
+		return 1;
+	}
+
+	ts.tv_sec = TIMEOUT_MSEC / 1000;
+	ts.tv_nsec = 0;
+	for (i = 0; i < 4; i++) {
+		unsigned num;
+		sqe = io_uring_get_sqe(&ring);
+		switch (i) {
+			case 0:
+			case 1:
+				num = 1;
+				break;
+			case 2:
+				num = 2;
+				break;
+			case 3:
+				num = UINT_MAX;
+				break;
+		}
+		io_uring_prep_timeout(sqe, &ts, num, 0);
+	}
+
+	for (i = 0; i < 2; i++) {
+		sqe = io_uring_get_sqe(&ring);
+		io_uring_prep_nop(sqe);
+		io_uring_sqe_set_data(sqe, (void *) 1);
+	}
+	ret = io_uring_submit(&ring);
+	if (ret < 0) {
+		printf("sqe submit failed: %d\n", ret);
+		goto err;
+	}
+
+	i = 0;
+	while (i < 6) {
+		ret = io_uring_wait_cqe(&ring, &cqe);
+		if (ret < 0) {
+			printf("wait completion %d\n", ret);
+			goto err;
+		}
+
+		/*
+		 * cqe1: first nop req
+		 * cqe2: first timeout req, because of cqe1
+		 * cqe3: second timeout req because of cqe1 + cqe2
+		 * cqe4: second nop req
+		 * cqe5~cqe6: the left three timeout req
+		 */
+		switch (i) {
+			case 0:
+			case 3:
+				if (io_uring_cqe_get_data(cqe) != (void *) 1) {
+					printf("nop not seen as 1 or 2\n");
+					goto err;
+				}
+				break;
+			case 1:
+			case 2:
+			case 4:
+				if (cqe->res == -ETIME) {
+					printf("expected not return -ETIME for the "
+					       "%d'th timeout req\n", i - 1);
+					goto err;
+				}
+				break;
+			case 5:
+				if (cqe->res != -ETIME) {
+					printf("expected return -ETIME for the "
+					       "%d'th timeout req\n", i - 1);
+					goto err;
+				}
+				break;
+		}
+		io_uring_cqe_seen(&ring, cqe);
+		i++;
+	}
+
+	return 0;
+err:
+	return 1;
+}
+
+int main(int argc, char *argv[])
+{
+	int ret;
+
+	ret = check_timeout_support();
+	if (ret) {
+		printf("ring setup failed\n");
+		return 1;
+	}
+
+	if (not_supported)
+		return 0;
+
+	ret = test_timeout_overflow();
+	if (ret) {
+		printf("test_timeout_overflow failed\n");
+		return 1;
+	}
+
+	return 0;
+}
-- 
2.17.2

