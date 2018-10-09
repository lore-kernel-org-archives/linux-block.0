Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39019 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbeJISab (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Oct 2018 14:30:31 -0400
Received: by mail-pf1-f193.google.com with SMTP id c25-v6so674829pfe.6
        for <linux-block@vger.kernel.org>; Tue, 09 Oct 2018 04:14:05 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@javigon.com>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 15/45] lightnvm: pblk: guarantee emeta on line close
Date: Tue,  9 Oct 2018 13:11:45 +0200
Message-Id: <20181009111215.7653-16-mb@lightnvm.io>
In-Reply-To: <20181009111215.7653-1-mb@lightnvm.io>
References: <20181009111215.7653-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Javier González <javier@javigon.com>

If a line is recovered from open chunks, the memory structures for
emeta have not necessarily been properly set on line initialization.
When closing a line, make sure that emeta is consistent so that the line
can be recovered on the fast path on next reboot.

Also, remove a couple of empty lines at the end of the function.

Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-core.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 36ac9eff8ebd..a31417682c90 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -1775,6 +1775,17 @@ void pblk_line_close_meta(struct pblk *pblk, struct pblk_line *line)
 	wa->pad = cpu_to_le64(atomic64_read(&pblk->pad_wa));
 	wa->gc = cpu_to_le64(atomic64_read(&pblk->gc_wa));
 
+	if (le32_to_cpu(emeta_buf->header.identifier) != PBLK_MAGIC) {
+		emeta_buf->header.identifier = cpu_to_le32(PBLK_MAGIC);
+		memcpy(emeta_buf->header.uuid, pblk->instance_uuid, 16);
+		emeta_buf->header.id = cpu_to_le32(line->id);
+		emeta_buf->header.type = cpu_to_le16(line->type);
+		emeta_buf->header.version_major = EMETA_VERSION_MAJOR;
+		emeta_buf->header.version_minor = EMETA_VERSION_MINOR;
+		emeta_buf->header.crc = cpu_to_le32(
+			pblk_calc_meta_header_crc(pblk, &emeta_buf->header));
+	}
+
 	emeta_buf->nr_valid_lbas = cpu_to_le64(line->nr_valid_lbas);
 	emeta_buf->crc = cpu_to_le32(pblk_calc_emeta_crc(pblk, emeta_buf));
 
@@ -1792,8 +1803,6 @@ void pblk_line_close_meta(struct pblk *pblk, struct pblk_line *line)
 	spin_unlock(&l_mg->close_lock);
 
 	pblk_line_should_sync_meta(pblk);
-
-
 }
 
 static void pblk_save_lba_list(struct pblk *pblk, struct pblk_line *line)
-- 
2.17.1
