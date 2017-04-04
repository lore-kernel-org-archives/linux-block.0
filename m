Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:35995 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755478AbdDDS5G (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Apr 2017 14:57:06 -0400
From: Dmitry Monakhov <dmonakhov@openvz.org>
To: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        martin.petersen@oracle.com
Cc: Dmitry Monakhov <dmonakhov@openvz.org>
Subject: [PATCH 6/9] T10: Move opencoded contants to common header
Date: Tue,  4 Apr 2017 22:56:38 +0400
Message-Id: <1491332201-26926-7-git-send-email-dmonakhov@openvz.org>
In-Reply-To: <1491332201-26926-1-git-send-email-dmonakhov@openvz.org>
References: <1491332201-26926-1-git-send-email-dmonakhov@openvz.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Signed-off-by: Dmitry Monakhov <dmonakhov@openvz.org>
---
 block/t10-pi.c                   | 9 +++------
 drivers/scsi/lpfc/lpfc_scsi.c    | 5 +++--
 drivers/scsi/qla2xxx/qla_isr.c   | 8 ++++----
 drivers/target/target_core_sbc.c | 2 +-
 include/linux/t10-pi.h           | 2 ++
 5 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/block/t10-pi.c b/block/t10-pi.c
index 2c97912..485cecd 100644
--- a/block/t10-pi.c
+++ b/block/t10-pi.c
@@ -28,9 +28,6 @@
 
 typedef __be16 (csum_fn) (void *, unsigned int);
 
-static const __be16 APP_ESCAPE = (__force __be16) 0xffff;
-static const __be32 REF_ESCAPE = (__force __be32) 0xffffffff;
-
 static __be16 t10_pi_crc_fn(void *data, unsigned int len)
 {
 	return cpu_to_be16(crc_t10dif(data, len));
@@ -82,7 +79,7 @@ static int t10_pi_verify(struct blk_integrity_iter *iter, csum_fn *fn,
 		switch (type) {
 		case 1:
 		case 2:
-			if (pi->app_tag == APP_ESCAPE)
+			if (pi->app_tag == T10_APP_ESCAPE)
 				goto next;
 
 			if (be32_to_cpu(pi->ref_tag) !=
@@ -95,8 +92,8 @@ static int t10_pi_verify(struct blk_integrity_iter *iter, csum_fn *fn,
 			}
 			break;
 		case 3:
-			if (pi->app_tag == APP_ESCAPE &&
-			    pi->ref_tag == REF_ESCAPE)
+			if (pi->app_tag == T10_APP_ESCAPE &&
+			    pi->ref_tag == T10_REF_ESCAPE)
 				goto next;
 			break;
 		}
diff --git a/drivers/scsi/lpfc/lpfc_scsi.c b/drivers/scsi/lpfc/lpfc_scsi.c
index 54fd0c8..6f6b40e 100644
--- a/drivers/scsi/lpfc/lpfc_scsi.c
+++ b/drivers/scsi/lpfc/lpfc_scsi.c
@@ -26,6 +26,7 @@
 #include <linux/export.h>
 #include <linux/delay.h>
 #include <asm/unaligned.h>
+#include <linux/t10-pi.h>
 #include <linux/crc-t10dif.h>
 #include <net/checksum.h>
 
@@ -2934,8 +2935,8 @@ lpfc_calc_bg_err(struct lpfc_hba *phba, struct lpfc_scsi_buf *lpfc_cmd)
 				 * First check to see if a protection data
 				 * check is valid
 				 */
-				if ((src->ref_tag == 0xffffffff) ||
-				    (src->app_tag == 0xffff)) {
+				if ((src->ref_tag == T10_REF_ESCAPE) ||
+				    (src->app_tag == T10_APP_ESCAPE)) {
 					start_ref_tag++;
 					goto skipit;
 				}
diff --git a/drivers/scsi/qla2xxx/qla_isr.c b/drivers/scsi/qla2xxx/qla_isr.c
index 3203367..ed4b302 100644
--- a/drivers/scsi/qla2xxx/qla_isr.c
+++ b/drivers/scsi/qla2xxx/qla_isr.c
@@ -1950,9 +1950,9 @@ qla2x00_handle_dif_error(srb_t *sp, struct sts_entry_24xx *sts24)
 	 * For type     3: ref & app tag is all 'f's
 	 * For type 0,1,2: app tag is all 'f's
 	 */
-	if ((a_app_tag == 0xffff) &&
+	if ((a_app_tag == T10_APP_ESCAPE) &&
 	    ((scsi_get_prot_type(cmd) != SCSI_PROT_DIF_TYPE3) ||
-	     (a_ref_tag == 0xffffffff))) {
+	     (a_ref_tag == T10_REF_ESCAPE))) {
 		uint32_t blocks_done, resid;
 		sector_t lba_s = scsi_get_lba(cmd);
 
@@ -1994,9 +1994,9 @@ qla2x00_handle_dif_error(srb_t *sp, struct sts_entry_24xx *sts24)
 			spt = page_address(sg_page(sg)) + sg->offset;
 			spt += j;
 
-			spt->app_tag = 0xffff;
+			spt->app_tag = T10_APP_ESCAPE;
 			if (scsi_get_prot_type(cmd) == SCSI_PROT_DIF_TYPE3)
-				spt->ref_tag = 0xffffffff;
+				spt->ref_tag = T10_REF_ESCAPE;
 		}
 
 		return 0;
diff --git a/drivers/target/target_core_sbc.c b/drivers/target/target_core_sbc.c
index c194063..927ef44 100644
--- a/drivers/target/target_core_sbc.c
+++ b/drivers/target/target_core_sbc.c
@@ -1446,7 +1446,7 @@ sbc_dif_verify(struct se_cmd *cmd, sector_t start, unsigned int sectors,
 				 (unsigned long long)sector, sdt->guard_tag,
 				 sdt->app_tag, be32_to_cpu(sdt->ref_tag));
 
-			if (sdt->app_tag == cpu_to_be16(0xffff)) {
+			if (sdt->app_tag == T10_APP_ESCAPE) {
 				dsg_off += block_size;
 				goto next;
 			}
diff --git a/include/linux/t10-pi.h b/include/linux/t10-pi.h
index 9fba9dd..f892442 100644
--- a/include/linux/t10-pi.h
+++ b/include/linux/t10-pi.h
@@ -33,6 +33,8 @@ struct t10_pi_tuple {
 	__be32 ref_tag;		/* Target LBA or indirect LBA */
 };
 
+#define T10_APP_ESCAPE cpu_to_be16(0xffff)
+#define T10_REF_ESCAPE cpu_to_be32(0xffffffff)
 
 extern struct blk_integrity_profile t10_pi_type1_crc;
 extern struct blk_integrity_profile t10_pi_type1_ip;
-- 
2.9.3
