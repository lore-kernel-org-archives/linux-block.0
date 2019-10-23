Return-Path: <SRS0=PMby=YQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D81CA9EAE
	for <linux-block@archiver.kernel.org>; Wed, 23 Oct 2019 06:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E112021925
	for <linux-block@archiver.kernel.org>; Wed, 23 Oct 2019 06:51:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728697AbfJWGvj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Oct 2019 02:51:39 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4747 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725796AbfJWGvj (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Oct 2019 02:51:39 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 8227979B08628A330F5A;
        Wed, 23 Oct 2019 14:51:35 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Wed, 23 Oct 2019
 14:51:27 +0800
From:   "zhangyi (F)" <yi.zhang@huawei.com>
To:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>
CC:     <yi.zhang@huawei.com>, <yangerkun@huawei.com>
Subject: [PATCH liburing 1/2] test/timeout: add multi timeout reqs test with different timeout
Date:   Wed, 23 Oct 2019 15:12:58 +0800
Message-ID: <20191023071259.15045-1-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add multi timeout reqs test case which want to test submitting timeout
reqs with different timeout value, check the return sequence and the
status of each req.

Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
---
 test/timeout.c | 97 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/test/timeout.c b/test/timeout.c
index e2a5a30..5b2a30a 100644
--- a/test/timeout.c
+++ b/test/timeout.c
@@ -511,6 +511,97 @@ err:
 	return 1;
 }
 
+/*
+ * Test multi timeouts waking us up
+ */
+static int test_multi_timeout(struct io_uring *ring)
+{
+	struct io_uring_sqe *sqe;
+	struct io_uring_cqe *cqe;
+	struct __kernel_timespec ts[2];
+	unsigned int timeout[2];
+	unsigned long long exp;
+	struct timeval tv;
+	int ret, i;
+
+	/* req_1: timeout req, count = 1, time = (TIMEOUT_MSEC * 2) */
+	timeout[0] = TIMEOUT_MSEC * 2;
+	msec_to_ts(&ts[0], timeout[0]);
+	sqe = io_uring_get_sqe(ring);
+	if (!sqe) {
+		fprintf(stderr, "%s: get sqe failed\n", __FUNCTION__);
+		goto err;
+	}
+	io_uring_prep_timeout(sqe, &ts[0], 1, 0);
+	sqe->user_data = 1;
+
+	/* req_2: timeout req, count = 1, time = TIMEOUT_MSEC */
+	timeout[1] = TIMEOUT_MSEC;
+	msec_to_ts(&ts[1], timeout[1]);
+	sqe = io_uring_get_sqe(ring);
+	if (!sqe) {
+		fprintf(stderr, "%s: get sqe failed\n", __FUNCTION__);
+		goto err;
+	}
+	io_uring_prep_timeout(sqe, &ts[1], 1, 0);
+	sqe->user_data = 2;
+
+	ret = io_uring_submit(ring);
+	if (ret <= 0) {
+		fprintf(stderr, "%s: sqe submit failed: %d\n", __FUNCTION__, ret);
+		goto err;
+	}
+
+	gettimeofday(&tv, NULL);
+	for (i = 0; i < 2; i++) {
+		unsigned int time;
+		__u64 user_data;
+
+		ret = io_uring_wait_cqe(ring, &cqe);
+		if (ret < 0) {
+			fprintf(stderr, "%s: wait completion %d\n", __FUNCTION__, ret);
+			goto err;
+		}
+
+		/*
+		 * Both of these two reqs should timeout, but req_2 should
+		 * return before req_1.
+		 */
+		switch (i) {
+		case 0:
+			user_data = 2;
+			time = timeout[1];
+			break;
+		case 1:
+			user_data = 1;
+			time = timeout[0];
+			break;
+		}
+
+		if (cqe->user_data != user_data) {
+			fprintf(stderr, "%s: unexpected timeout req %d sequece\n",
+				__FUNCTION__, i+1);
+			goto err;
+		}
+		if (cqe->res != -ETIME) {
+			fprintf(stderr, "%s: Req %d timeout: %s\n",
+				__FUNCTION__, i+1, strerror(cqe->res));
+			goto err;
+		}
+		exp = mtime_since_now(&tv);
+		if (exp < time / 2 || exp > (time * 3) / 2) {
+			fprintf(stderr, "%s: Req %d timeout seems wonky (got %llu)\n",
+				__FUNCTION__, i+1, exp);
+			goto err;
+		}
+		io_uring_cqe_seen(ring, cqe);
+	}
+
+	return 0;
+err:
+	return 1;
+}
+
 int main(int argc, char *argv[])
 {
 	struct io_uring ring;
@@ -530,6 +621,12 @@ int main(int argc, char *argv[])
 	if (not_supported)
 		return 0;
 
+	ret = test_multi_timeout(&ring);
+	if (ret) {
+		fprintf(stderr, "test_single_timeout failed\n");
+		return ret;
+	}
+
 	ret = test_single_timeout_abs(&ring);
 	if (ret) {
 		fprintf(stderr, "test_single_timeout_abs failed\n");
-- 
2.17.2

