Return-Path: <SRS0=yN0i=YX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF0FCA9EC0
	for <linux-block@archiver.kernel.org>; Wed, 30 Oct 2019 07:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2BFE2087E
	for <linux-block@archiver.kernel.org>; Wed, 30 Oct 2019 07:16:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725855AbfJ3HQd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Oct 2019 03:16:33 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:38238 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726116AbfJ3HQd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Oct 2019 03:16:33 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0TggefMe_1572419790;
Received: from localhost(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0TggefMe_1572419790)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 30 Oct 2019 15:16:30 +0800
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH] liburing/test: fix build errors
Date:   Wed, 30 Oct 2019 15:16:30 +0800
Message-Id: <1572419790-96807-1-git-send-email-joseph.qi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Fix the following errors when make:
  error: ‘for’ loop initial declarations are only allowed in C99 mode
  error: redeclaration of ‘i’ with no linkage

Signed-off-by: Joseph Qi <joseph.qi@linux.alibaba.com>
---
 test/232c93d07b74-test.c | 7 +++++--
 test/defer.c             | 4 ++--
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/test/232c93d07b74-test.c b/test/232c93d07b74-test.c
index b321668..c398de6 100644
--- a/test/232c93d07b74-test.c
+++ b/test/232c93d07b74-test.c
@@ -132,7 +132,9 @@ static void *rcv(void *arg)
 				if (cqe->res < 0)
 					assert(cqe->res == -EAGAIN);
 				else {
-					for (int i = 0; i < cqe->res; i++) {
+					int i;
+
+					for (i = 0; i < cqe->res; i++) {
 						if (buff[i] != expected_byte) {
 							fprintf(stderr,
 								"Received %d, wanted %d\n",
@@ -208,8 +210,9 @@ static void *snd(void *arg)
 
 	while (!done && bytes_written != 33) {
 		char buff[SEND_BUFF_SIZE];
+		int i;
 
-		for (int i = 0; i < SEND_BUFF_SIZE; i++)
+		for (i = 0; i < SEND_BUFF_SIZE; i++)
 			buff[i] = i + bytes_written;
 
 		struct iovec iov;
diff --git a/test/defer.c b/test/defer.c
index db0d904..f103a65 100644
--- a/test/defer.c
+++ b/test/defer.c
@@ -92,7 +92,7 @@ static int test_cancelled_userdata(struct io_uring *ring)
 	if (wait_cqes(&ctx))
 		goto err;
 
-	for (int i = 0; i < nr; i++) {
+	for (i = 0; i < nr; i++) {
 		if (i != ctx.cqes[i].user_data) {
 			printf("invalid user data\n");
 			goto err;
@@ -126,7 +126,7 @@ static int test_thread_link_cancel(struct io_uring *ring)
 	if (wait_cqes(&ctx))
 		goto err;
 
-	for (int i = 0; i < nr; i++) {
+	for (i = 0; i < nr; i++) {
 		bool fail = false;
 
 		if (i == 0)
-- 
1.8.3.1

