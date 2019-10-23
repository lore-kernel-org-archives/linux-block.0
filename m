Return-Path: <SRS0=PMby=YQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E93CA9EAE
	for <linux-block@archiver.kernel.org>; Wed, 23 Oct 2019 06:52:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 745BA2064A
	for <linux-block@archiver.kernel.org>; Wed, 23 Oct 2019 06:52:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388077AbfJWGwB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Oct 2019 02:52:01 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:40154 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725796AbfJWGwA (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Oct 2019 02:52:00 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 50F3E1A7D9C880C86A4B;
        Wed, 23 Oct 2019 14:51:35 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Wed, 23 Oct 2019
 14:51:27 +0800
From:   "zhangyi (F)" <yi.zhang@huawei.com>
To:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>
CC:     <yi.zhang@huawei.com>, <yangerkun@huawei.com>
Subject: [PATCH liburing 2/2] test/timeout: add multi timeout reqs test with different count
Date:   Wed, 23 Oct 2019 15:12:59 +0800
Message-ID: <20191023071259.15045-2-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20191023071259.15045-1-yi.zhang@huawei.com>
References: <20191023071259.15045-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add multi timeout reqs test case which want to test submitting timeout
reqs with different count number, check the return sequence and the
status of each req.

Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
---
 test/timeout.c | 105 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 105 insertions(+)

diff --git a/test/timeout.c b/test/timeout.c
index 5b2a30a..ac76789 100644
--- a/test/timeout.c
+++ b/test/timeout.c
@@ -602,6 +602,105 @@ err:
 	return 1;
 }
 
+/*
+ * Test multi timeout req with different count
+ */
+static int test_multi_timeout_nr(struct io_uring *ring)
+{
+	struct io_uring_sqe *sqe;
+	struct io_uring_cqe *cqe;
+	struct __kernel_timespec ts;
+	int ret, i;
+
+	msec_to_ts(&ts, TIMEOUT_MSEC);
+
+	/* req_1: timeout req, count = 2 */
+	sqe = io_uring_get_sqe(ring);
+	if (!sqe) {
+		fprintf(stderr, "%s: get sqe failed\n", __FUNCTION__);
+		goto err;
+	}
+	io_uring_prep_timeout(sqe, &ts, 2, 0);
+	sqe->user_data = 1;
+
+	/* req_2: timeout req, count = 1 */
+	sqe = io_uring_get_sqe(ring);
+	if (!sqe) {
+		fprintf(stderr, "%s: get sqe failed\n", __FUNCTION__);
+		goto err;
+	}
+	io_uring_prep_timeout(sqe, &ts, 1, 0);
+	sqe->user_data = 2;
+
+	/* req_3: nop req */
+	sqe = io_uring_get_sqe(ring);
+	if (!sqe) {
+		fprintf(stderr, "%s: get sqe failed\n", __FUNCTION__);
+		goto err;
+	}
+	io_uring_prep_nop(sqe);
+	io_uring_sqe_set_data(sqe, (void *) 1);
+
+	ret = io_uring_submit(ring);
+	if (ret <= 0) {
+		fprintf(stderr, "%s: sqe submit failed: %d\n", __FUNCTION__, ret);
+		goto err;
+	}
+
+	/*
+	 * req_2 (count=1) should return without error and req_1 (count=2)
+	 * should timeout.
+	 */
+	for (i = 0; i < 3; i++) {
+		ret = io_uring_wait_cqe(ring, &cqe);
+		if (ret < 0) {
+			fprintf(stderr, "%s: wait completion %d\n", __FUNCTION__, ret);
+			goto err;
+		}
+
+		switch (i) {
+		case 0:
+			/* Should be nop req */
+			if (io_uring_cqe_get_data(cqe) != (void *) 1) {
+				fprintf(stderr, "%s: nop not seen as 1 or 2\n", __FUNCTION__);
+				goto err;
+			}
+			break;
+		case 1:
+			/* Should be timeout req_2 */
+			if (cqe->user_data != 2) {
+				fprintf(stderr, "%s: unexpected timeout req %d sequece\n",
+					__FUNCTION__, i+1);
+				goto err;
+			}
+			if (cqe->res < 0) {
+				fprintf(stderr, "%s: Req %d res %d\n",
+					__FUNCTION__, i+1, cqe->res);
+				goto err;
+			}
+			break;
+		case 2:
+			/* Should be timeout req_1 */
+			if (cqe->user_data != 1) {
+				fprintf(stderr, "%s: unexpected timeout req %d sequece\n",
+					__FUNCTION__, i+1);
+				goto err;
+			}
+			if (cqe->res != -ETIME) {
+				fprintf(stderr, "%s: Req %d timeout: %s\n",
+					__FUNCTION__, i+1, strerror(cqe->res));
+				goto err;
+			}
+			break;
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
@@ -657,6 +756,12 @@ int main(int argc, char *argv[])
 		return ret;
 	}
 
+	ret = test_multi_timeout_nr(&ring);
+	if (ret) {
+		fprintf(stderr, "test_multi_timeout_nr failed\n");
+		return ret;
+	}
+
 	ret = test_single_timeout_wait(&ring);
 	if (ret) {
 		fprintf(stderr, "test_single_timeout_wait failed\n");
-- 
2.17.2

