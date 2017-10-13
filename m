Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:46066 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758090AbdJMMrR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Oct 2017 08:47:17 -0400
Received: by mail-wm0-f67.google.com with SMTP id q124so21259168wmb.0
        for <linux-block@vger.kernel.org>; Fri, 13 Oct 2017 05:47:16 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rakesh Pandit <rakesh@tuxera.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [GIT PULL 10/58] lightnvm: pblk: print incompatible line version correctly
Date: Fri, 13 Oct 2017 14:45:59 +0200
Message-Id: <20171013124647.32668-11-m@bjorling.me>
In-Reply-To: <20171013124647.32668-1-m@bjorling.me>
References: <20171013124647.32668-1-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Rakesh Pandit <rakesh@tuxera.com>

Correct it by converting little endian to cpu endian and also define
a macro for line version so that maintenance is easy.

Signed-off-by: Rakesh Pandit <rakesh@tuxera.com>
Reviewed-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <m@bjorling.me>
---
 drivers/lightnvm/pblk-core.c     | 2 +-
 drivers/lightnvm/pblk-recovery.c | 4 ++--
 drivers/lightnvm/pblk.h          | 1 +
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 027c42b..8536d38 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -978,7 +978,7 @@ static int pblk_line_init_metadata(struct pblk *pblk, struct pblk_line *line,
 	memcpy(smeta_buf->header.uuid, pblk->instance_uuid, 16);
 	smeta_buf->header.id = cpu_to_le32(line->id);
 	smeta_buf->header.type = cpu_to_le16(line->type);
-	smeta_buf->header.version = cpu_to_le16(1);
+	smeta_buf->header.version = SMETA_VERSION;
 
 	/* Start metadata */
 	smeta_buf->seq_nr = cpu_to_le64(line->seq_nr);
diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
index cb556e0..caf1242 100644
--- a/drivers/lightnvm/pblk-recovery.c
+++ b/drivers/lightnvm/pblk-recovery.c
@@ -900,9 +900,9 @@ struct pblk_line *pblk_recov_l2p(struct pblk *pblk)
 		if (le32_to_cpu(smeta_buf->header.identifier) != PBLK_MAGIC)
 			continue;
 
-		if (le16_to_cpu(smeta_buf->header.version) != 1) {
+		if (smeta_buf->header.version != SMETA_VERSION) {
 			pr_err("pblk: found incompatible line version %u\n",
-					smeta_buf->header.version);
+					le16_to_cpu(smeta_buf->header.version));
 			return ERR_PTR(-EINVAL);
 		}
 
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index 67e623b..9ece409 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -310,6 +310,7 @@ enum {
 };
 
 #define PBLK_MAGIC 0x70626c6b /*pblk*/
+#define SMETA_VERSION cpu_to_le16(1)
 
 struct line_header {
 	__le32 crc;
-- 
2.9.3
