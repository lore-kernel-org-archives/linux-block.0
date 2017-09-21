Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.mpynet.fi ([82.197.21.85]:46693 "EHLO mx2.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751581AbdIUL2F (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Sep 2017 07:28:05 -0400
Date: Thu, 21 Sep 2017 14:28:03 +0300
From: Rakesh Pandit <rakesh@tuxera.com>
To: Matias =?iso-8859-1?Q?Bj=F8rling?= <mb@lightnvm.io>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Javier =?iso-8859-1?Q?Gonz=E1lez?= <jg@lightnvm.io>
Subject: [PATCH 5/6] lightnvm: pblk: print incompatible line version correctly
Message-ID: <20170921112801.GA28567@dhcp-216.srv.tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Correct it by coverting little endian to cpu endian and also define a
macro for line version so that maintenance is easy.

Signed-off-by: Rakesh Pandit <rakesh@tuxera.com>
---
 drivers/lightnvm/pblk-core.c     | 2 +-
 drivers/lightnvm/pblk-recovery.c | 4 ++--
 drivers/lightnvm/pblk.h          | 1 +
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 74ddb30..57583a1 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -991,7 +991,7 @@ static int pblk_line_init_metadata(struct pblk *pblk, struct pblk_line *line,
 	memcpy(smeta_buf->header.uuid, pblk->instance_uuid, 16);
 	smeta_buf->header.id = cpu_to_le32(line->id);
 	smeta_buf->header.type = cpu_to_le16(line->type);
-	smeta_buf->header.version = cpu_to_le16(1);
+	smeta_buf->header.version = SMETA_VERSION;
 
 	/* Start metadata */
 	smeta_buf->seq_nr = cpu_to_le64(line->seq_nr);
diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
index 1869eef..686bc17 100644
--- a/drivers/lightnvm/pblk-recovery.c
+++ b/drivers/lightnvm/pblk-recovery.c
@@ -876,9 +876,9 @@ struct pblk_line *pblk_recov_l2p(struct pblk *pblk)
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
index eaf5397..87b1d7f 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -318,6 +318,7 @@ enum {
 };
 
 #define PBLK_MAGIC 0x70626c6b /*pblk*/
+#define SMETA_VERSION cpu_to_le16(1)
 
 struct line_header {
 	__le32 crc;
-- 
2.5.0
