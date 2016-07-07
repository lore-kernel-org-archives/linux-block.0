Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33872 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756577AbcGGHyn (ORCPT
	<rfc822;linux-block@vger.kernel.org>); Thu, 7 Jul 2016 03:54:43 -0400
Received: by mail-wm0-f67.google.com with SMTP id 187so3534560wmz.1
        for <linux-block@vger.kernel.org>; Thu, 07 Jul 2016 00:54:42 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	axboe@fb.com
Cc: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [PATCH 07/17] lightnvm: fix checkpatch terse errors
Date: Thu,  7 Jul 2016 09:54:13 +0200
Message-Id: <1467878063-22919-8-git-send-email-m@bjorling.me>
In-Reply-To: <1467878063-22919-1-git-send-email-m@bjorling.me>
References: <1467878063-22919-1-git-send-email-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

A couple of small checkpatch fixups to stop it from complaining.

./drivers/lightnvm/core.c:360: WARNING: line over 80 characters
./drivers/lightnvm/core.c:360: ERROR: trailing statements should be on
next line
./drivers/lightnvm/core.c:503: WARNING: Block comments use a trailing */
on a separate line

Signed-off-by: Matias Bjørling <m@bjorling.me>
---
 drivers/lightnvm/core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index 8beb9c0..0da196f 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -373,7 +373,9 @@ int __nvm_submit_ppa(struct nvm_dev *dev, struct nvm_rq *rqd, int opcode,
 	/* Prevent hang_check timer from firing at us during very long I/O */
 	hang_check = sysctl_hung_task_timeout_secs;
 	if (hang_check)
-		while (!wait_for_completion_io_timeout(&wait, hang_check * (HZ/2)));
+		while (!wait_for_completion_io_timeout(&wait,
+							hang_check * (HZ/2)))
+			;
 	else
 		wait_for_completion_io(&wait);
 
@@ -516,7 +518,8 @@ static int nvm_init_mlc_tbl(struct nvm_dev *dev, struct nvm_id_group *grp)
 	/* The lower page table encoding consists of a list of bytes, where each
 	 * has a lower and an upper half. The first half byte maintains the
 	 * increment value and every value after is an offset added to the
-	 * previous incrementation value */
+	 * previous incrementation value
+	 */
 	dev->lptbl[0] = mlc->pairs[0] & 0xF;
 	for (i = 1; i < dev->lps_per_blk; i++) {
 		p = mlc->pairs[i >> 1];
-- 
2.1.4

