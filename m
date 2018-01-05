Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:43595 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752036AbeAENRB (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 5 Jan 2018 08:17:01 -0500
Received: by mail-wm0-f65.google.com with SMTP id n138so2399823wmg.2
        for <linux-block@vger.kernel.org>; Fri, 05 Jan 2018 05:17:01 -0800 (PST)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [GIT PULL 20/25] lightnvm: pblk: do not log recovery read errors
Date: Fri,  5 Jan 2018 14:16:16 +0100
Message-Id: <20180105131621.20808-21-m@bjorling.me>
In-Reply-To: <20180105131621.20808-1-m@bjorling.me>
References: <20180105131621.20808-1-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Javier González <javier@cnexlabs.com>

On scan recovery, reads can fail. This happens because the first page
for each line is read in order to determined if the line has been used
(and thus needs to be recovered), or not. This can lead to "empty page"
read errors.

Since these errors are normal, do not log them, as they are confusing
when reviewing the logs.

Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <m@bjorling.me>
---
 drivers/lightnvm/pblk-core.c | 6 +++---
 drivers/lightnvm/pblk.h      | 1 +
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 5ec7ad6..0487b93 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -742,7 +742,7 @@ static int pblk_line_submit_smeta_io(struct pblk *pblk, struct pblk_line *line,
 		cmd_op = NVM_OP_PWRITE;
 		flags = pblk_set_progr_mode(pblk, PBLK_WRITE);
 		lba_list = emeta_to_lbas(pblk, line->emeta->buf);
-	} else if (dir == PBLK_READ) {
+	} else if (dir == PBLK_READ_RECOV || dir == PBLK_READ) {
 		bio_op = REQ_OP_READ;
 		cmd_op = NVM_OP_PREAD;
 		flags = pblk_set_read_mode(pblk, PBLK_READ_SEQUENTIAL);
@@ -802,7 +802,7 @@ static int pblk_line_submit_smeta_io(struct pblk *pblk, struct pblk_line *line,
 	if (rqd.error) {
 		if (dir == PBLK_WRITE)
 			pblk_log_write_err(pblk, &rqd);
-		else
+		else if (dir == PBLK_READ)
 			pblk_log_read_err(pblk, &rqd);
 	}
 
@@ -816,7 +816,7 @@ int pblk_line_read_smeta(struct pblk *pblk, struct pblk_line *line)
 {
 	u64 bpaddr = pblk_line_smeta_start(pblk, line);
 
-	return pblk_line_submit_smeta_io(pblk, line, bpaddr, PBLK_READ);
+	return pblk_line_submit_smeta_io(pblk, line, bpaddr, PBLK_READ_RECOV);
 }
 
 int pblk_line_read_emeta(struct pblk *pblk, struct pblk_line *line,
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index 19e622c..93ec4fd 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -60,6 +60,7 @@ enum {
 	PBLK_READ		= READ,
 	PBLK_WRITE		= WRITE,/* Write from write buffer */
 	PBLK_WRITE_INT,			/* Internal write - no write buffer */
+	PBLK_READ_RECOV,		/* Recovery read - errors allowed */
 	PBLK_ERASE,
 };
 
-- 
2.9.3
