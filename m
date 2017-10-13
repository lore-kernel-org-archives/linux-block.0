Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:47443 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758302AbdJMMrv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Oct 2017 08:47:51 -0400
Received: by mail-wm0-f67.google.com with SMTP id t69so21255871wmt.2
        for <linux-block@vger.kernel.org>; Fri, 13 Oct 2017 05:47:51 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [GIT PULL 46/58] lightnvm: pblk: recover partially written lines correctly
Date: Fri, 13 Oct 2017 14:46:35 +0200
Message-Id: <20171013124647.32668-47-m@bjorling.me>
In-Reply-To: <20171013124647.32668-1-m@bjorling.me>
References: <20171013124647.32668-1-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

When recovering partially written lines, the valid sector
count must be decreased by the number of padded sectors
in the line.

Update line recovery to take all ADDR_EMPTY(padded) sectors
into account.

Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
Signed-off-by: Matias Bjørling <m@bjorling.me>
---
 drivers/lightnvm/pblk-recovery.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
index 686bc17..a080cf8 100644
--- a/drivers/lightnvm/pblk-recovery.c
+++ b/drivers/lightnvm/pblk-recovery.c
@@ -133,8 +133,8 @@ static int pblk_recov_l2p_from_emeta(struct pblk *pblk, struct pblk_line *line)
 	struct pblk_emeta *emeta = line->emeta;
 	struct line_emeta *emeta_buf = emeta->buf;
 	__le64 *lba_list;
-	int data_start;
-	int nr_data_lbas, nr_valid_lbas, nr_lbas = 0;
+	int data_start, data_end;
+	int nr_valid_lbas, nr_lbas = 0;
 	int i;
 
 	lba_list = pblk_recov_get_lba_list(pblk, emeta_buf);
@@ -142,10 +142,10 @@ static int pblk_recov_l2p_from_emeta(struct pblk *pblk, struct pblk_line *line)
 		return 1;
 
 	data_start = pblk_line_smeta_start(pblk, line) + lm->smeta_sec;
-	nr_data_lbas = lm->sec_per_line - lm->emeta_sec[0];
+	data_end = lm->sec_per_line - lm->emeta_sec[0];
 	nr_valid_lbas = le64_to_cpu(emeta_buf->nr_valid_lbas);
 
-	for (i = data_start; i < nr_data_lbas && nr_lbas < nr_valid_lbas; i++) {
+	for (i = data_start; i < data_end; i++) {
 		struct ppa_addr ppa;
 		int pos;
 
-- 
2.9.3
