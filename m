Return-Path: <SRS0=YK6u=OP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE50C04EB8
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 15:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D812222507
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 15:53:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="L2Iks17v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D812222507
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbeLFPxL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Dec 2018 10:53:11 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51510 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbeLFPxI (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Dec 2018 10:53:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=30lBRzYocx9VU1YyykbrDuORixuGmcBTmPzOZDVggio=; b=L2Iks17vpWjnEmo8L3KRXXakAG
        KxzDJBSY/YpdhstKcyTQ5fFiEhRxAFvcknyPQsJGwCeMbZJVgeptYJiXJKOmAbw+frUyAo/GT3fPD
        GNFUdvmRIgfOnQU9jktsPv8tgtd1wazANR4fLr8wgxsYtyDStdsgeNK7i1XN+gq/qGzzn+gJe/bIS
        GPg4x09F60uyFk/BklLGr6p5lb3G5vXAqsbmKSg4MMxvG4p5HFXjhn7ObSyfH3QlS6AixXM0TTCEj
        0uZdU0aKUipucQ6pEKP5yfmRPJJWNZ1VyMVVNubeo40XJu3q49qCsFBiP89Pfwh2++f6cCudbHKmA
        NtO5MjHA==;
Received: from [38.126.112.138] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gUvxT-0008KV-AF; Thu, 06 Dec 2018 15:52:59 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Juergen Gross <jgross@suse.com>, linux-scsi@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: [PATCH 1/9] scsi: flip the default on use_clustering
Date:   Thu,  6 Dec 2018 07:52:50 -0800
Message-Id: <20181206155258.11465-2-hch@lst.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181206155258.11465-1-hch@lst.de>
References: <20181206155258.11465-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Most SCSI drivers want to enable "clustering", that is merging of
segments so that they might span more than a single page.  Remove the
ENABLE_CLUSTERING define, and require drivers to explicitly set
DISABLE_CLUSTERING to disable this feature.  All drivers not setting
use_clustering at all are switched to set DISABLE_CLUSTERING to keep
the current behavior.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/firewire/sbp2.c                         | 1 -
 drivers/infiniband/ulp/iser/iscsi_iser.c        | 1 -
 drivers/infiniband/ulp/srp/ib_srp.c             | 1 -
 drivers/message/fusion/mptfc.c                  | 1 -
 drivers/message/fusion/mptsas.c                 | 1 -
 drivers/message/fusion/mptspi.c                 | 1 -
 drivers/s390/scsi/zfcp_scsi.c                   | 1 -
 drivers/scsi/3w-9xxx.c                          | 1 -
 drivers/scsi/3w-sas.c                           | 1 -
 drivers/scsi/3w-xxxx.c                          | 1 -
 drivers/scsi/53c700.c                           | 1 -
 drivers/scsi/BusLogic.c                         | 1 -
 drivers/scsi/a100u2w.c                          | 1 -
 drivers/scsi/a3000.c                            | 1 -
 drivers/scsi/aacraid/linit.c                    | 1 -
 drivers/scsi/advansys.c                         | 8 --------
 drivers/scsi/aha1542.c                          | 1 -
 drivers/scsi/aha1740.c                          | 1 -
 drivers/scsi/aic7xxx/aic79xx_osm.c              | 1 -
 drivers/scsi/aic7xxx/aic7xxx_osm.c              | 1 -
 drivers/scsi/aic94xx/aic94xx_init.c             | 1 -
 drivers/scsi/arcmsr/arcmsr_hba.c                | 1 -
 drivers/scsi/arm/powertec.c                     | 1 -
 drivers/scsi/atp870u.c                          | 1 -
 drivers/scsi/be2iscsi/be_main.c                 | 1 -
 drivers/scsi/bfa/bfad_im.c                      | 2 --
 drivers/scsi/bnx2fc/bnx2fc_fcoe.c               | 1 -
 drivers/scsi/bnx2i/bnx2i_iscsi.c                | 1 -
 drivers/scsi/csiostor/csio_scsi.c               | 2 --
 drivers/scsi/cxlflash/main.c                    | 1 -
 drivers/scsi/dpt_i2o.c                          | 1 -
 drivers/scsi/esas2r/esas2r_main.c               | 1 -
 drivers/scsi/esp_scsi.c                         | 1 -
 drivers/scsi/fcoe/fcoe.c                        | 1 -
 drivers/scsi/fnic/fnic_main.c                   | 1 -
 drivers/scsi/gdth.c                             | 1 -
 drivers/scsi/hisi_sas/hisi_sas_v1_hw.c          | 1 -
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c          | 1 -
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c          | 1 -
 drivers/scsi/hpsa.c                             | 1 -
 drivers/scsi/hptiop.c                           | 1 -
 drivers/scsi/ibmvscsi/ibmvfc.c                  | 1 -
 drivers/scsi/ibmvscsi/ibmvscsi.c                | 1 -
 drivers/scsi/imm.c                              | 1 -
 drivers/scsi/initio.c                           | 1 -
 drivers/scsi/ipr.c                              | 1 -
 drivers/scsi/ips.c                              | 1 -
 drivers/scsi/isci/init.c                        | 1 -
 drivers/scsi/lpfc/lpfc_scsi.c                   | 4 ----
 drivers/scsi/megaraid.c                         | 1 -
 drivers/scsi/megaraid/megaraid_mbox.c           | 1 -
 drivers/scsi/megaraid/megaraid_sas_base.c       | 1 -
 drivers/scsi/mpt3sas/mpt3sas_scsih.c            | 2 --
 drivers/scsi/mvme147.c                          | 1 -
 drivers/scsi/mvsas/mv_init.c                    | 1 -
 drivers/scsi/mvumi.c                            | 1 +
 drivers/scsi/myrb.c                             | 1 +
 drivers/scsi/myrs.c                             | 1 +
 drivers/scsi/ncr53c8xx.c                        | 1 -
 drivers/scsi/pcmcia/sym53c500_cs.c              | 1 -
 drivers/scsi/pm8001/pm8001_init.c               | 1 -
 drivers/scsi/pmcraid.c                          | 1 -
 drivers/scsi/ppa.c                              | 1 -
 drivers/scsi/ps3rom.c                           | 1 -
 drivers/scsi/qedf/qedf_main.c                   | 1 -
 drivers/scsi/qedi/qedi_iscsi.c                  | 1 -
 drivers/scsi/qla1280.c                          | 1 -
 drivers/scsi/qla2xxx/qla_os.c                   | 1 -
 drivers/scsi/qla4xxx/ql4_os.c                   | 1 -
 drivers/scsi/qlogicpti.c                        | 1 -
 drivers/scsi/scsi_debug.c                       | 5 ++---
 drivers/scsi/scsi_lib.c                         | 2 +-
 drivers/scsi/smartpqi/smartpqi_init.c           | 1 -
 drivers/scsi/snic/snic_main.c                   | 1 -
 drivers/scsi/stex.c                             | 1 +
 drivers/scsi/storvsc_drv.c                      | 1 -
 drivers/scsi/sym53c8xx_2/sym_glue.c             | 1 -
 drivers/scsi/ufs/ufshcd.c                       | 1 +
 drivers/scsi/virtio_scsi.c                      | 1 -
 drivers/scsi/vmw_pvscsi.c                       | 1 -
 drivers/scsi/wd719x.c                           | 1 -
 drivers/staging/rts5208/rtsx.c                  | 6 ------
 drivers/staging/unisys/visorhba/visorhba_main.c | 1 -
 drivers/usb/image/microtek.c                    | 1 -
 drivers/usb/storage/scsiglue.c                  | 7 -------
 drivers/usb/storage/uas.c                       | 1 +
 include/linux/libata.h                          | 2 --
 include/scsi/scsi_host.h                        | 3 +--
 88 files changed, 10 insertions(+), 110 deletions(-)

diff --git a/drivers/firewire/sbp2.c b/drivers/firewire/sbp2.c
index 6bac03999fd4..09b845e90114 100644
--- a/drivers/firewire/sbp2.c
+++ b/drivers/firewire/sbp2.c
@@ -1610,7 +1610,6 @@ static struct scsi_host_template scsi_driver_template = {
 	.eh_abort_handler	= sbp2_scsi_abort,
 	.this_id		= -1,
 	.sg_tablesize		= SG_ALL,
-	.use_clustering		= ENABLE_CLUSTERING,
 	.can_queue		= 1,
 	.sdev_attrs		= sbp2_scsi_sysfs_attrs,
 };
diff --git a/drivers/infiniband/ulp/iser/iscsi_iser.c b/drivers/infiniband/ulp/iser/iscsi_iser.c
index 3fecd87c9f2b..8c707accd148 100644
--- a/drivers/infiniband/ulp/iser/iscsi_iser.c
+++ b/drivers/infiniband/ulp/iser/iscsi_iser.c
@@ -997,7 +997,6 @@ static struct scsi_host_template iscsi_iser_sht = {
 	.eh_device_reset_handler= iscsi_eh_device_reset,
 	.eh_target_reset_handler = iscsi_eh_recover_target,
 	.target_alloc		= iscsi_target_alloc,
-	.use_clustering         = ENABLE_CLUSTERING,
 	.slave_alloc            = iscsi_iser_slave_alloc,
 	.proc_name              = "iscsi_iser",
 	.this_id                = -1,
diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
index eed0eb3bb04c..d27fe970ceba 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.c
+++ b/drivers/infiniband/ulp/srp/ib_srp.c
@@ -3215,7 +3215,6 @@ static struct scsi_host_template srp_template = {
 	.can_queue			= SRP_DEFAULT_CMD_SQ_SIZE,
 	.this_id			= -1,
 	.cmd_per_lun			= SRP_DEFAULT_CMD_SQ_SIZE,
-	.use_clustering			= ENABLE_CLUSTERING,
 	.shost_attrs			= srp_host_attrs,
 	.track_queue_depth		= 1,
 };
diff --git a/drivers/message/fusion/mptfc.c b/drivers/message/fusion/mptfc.c
index b15fdc626fb8..4314a3352b96 100644
--- a/drivers/message/fusion/mptfc.c
+++ b/drivers/message/fusion/mptfc.c
@@ -129,7 +129,6 @@ static struct scsi_host_template mptfc_driver_template = {
 	.sg_tablesize			= MPT_SCSI_SG_DEPTH,
 	.max_sectors			= 8192,
 	.cmd_per_lun			= 7,
-	.use_clustering			= ENABLE_CLUSTERING,
 	.shost_attrs			= mptscsih_host_attrs,
 };
 
diff --git a/drivers/message/fusion/mptsas.c b/drivers/message/fusion/mptsas.c
index 9b404fc69c90..612cb5bc1333 100644
--- a/drivers/message/fusion/mptsas.c
+++ b/drivers/message/fusion/mptsas.c
@@ -1992,7 +1992,6 @@ static struct scsi_host_template mptsas_driver_template = {
 	.sg_tablesize			= MPT_SCSI_SG_DEPTH,
 	.max_sectors			= 8192,
 	.cmd_per_lun			= 7,
-	.use_clustering			= ENABLE_CLUSTERING,
 	.shost_attrs			= mptscsih_host_attrs,
 	.no_write_same			= 1,
 };
diff --git a/drivers/message/fusion/mptspi.c b/drivers/message/fusion/mptspi.c
index 9a336a161d9f..7172b0b16bdd 100644
--- a/drivers/message/fusion/mptspi.c
+++ b/drivers/message/fusion/mptspi.c
@@ -848,7 +848,6 @@ static struct scsi_host_template mptspi_driver_template = {
 	.sg_tablesize			= MPT_SCSI_SG_DEPTH,
 	.max_sectors			= 8192,
 	.cmd_per_lun			= 7,
-	.use_clustering			= ENABLE_CLUSTERING,
 	.shost_attrs			= mptscsih_host_attrs,
 };
 
diff --git a/drivers/s390/scsi/zfcp_scsi.c b/drivers/s390/scsi/zfcp_scsi.c
index 82dbe2677fc1..689bfe1f5cec 100644
--- a/drivers/s390/scsi/zfcp_scsi.c
+++ b/drivers/s390/scsi/zfcp_scsi.c
@@ -425,7 +425,6 @@ static struct scsi_host_template zfcp_scsi_host_template = {
 				     * ZFCP_QDIO_MAX_SBALS_PER_REQ) - 2) * 8,
 				   /* GCD, adjusted later */
 	.dma_boundary		 = ZFCP_QDIO_SBALE_LEN - 1,
-	.use_clustering		 = 1,
 	.shost_attrs		 = zfcp_sysfs_shost_attrs,
 	.sdev_attrs		 = zfcp_sysfs_sdev_attrs,
 	.track_queue_depth	 = 1,
diff --git a/drivers/scsi/3w-9xxx.c b/drivers/scsi/3w-9xxx.c
index 2d655a97b959..a3c20e3a8b7c 100644
--- a/drivers/scsi/3w-9xxx.c
+++ b/drivers/scsi/3w-9xxx.c
@@ -1998,7 +1998,6 @@ static struct scsi_host_template driver_template = {
 	.sg_tablesize		= TW_APACHE_MAX_SGL_LENGTH,
 	.max_sectors		= TW_MAX_SECTORS,
 	.cmd_per_lun		= TW_MAX_CMDS_PER_LUN,
-	.use_clustering		= ENABLE_CLUSTERING,
 	.shost_attrs		= twa_host_attrs,
 	.emulated		= 1,
 	.no_write_same		= 1,
diff --git a/drivers/scsi/3w-sas.c b/drivers/scsi/3w-sas.c
index 480cf82700e9..e8f5f7c63190 100644
--- a/drivers/scsi/3w-sas.c
+++ b/drivers/scsi/3w-sas.c
@@ -1550,7 +1550,6 @@ static struct scsi_host_template driver_template = {
 	.sg_tablesize		= TW_LIBERATOR_MAX_SGL_LENGTH,
 	.max_sectors		= TW_MAX_SECTORS,
 	.cmd_per_lun		= TW_MAX_CMDS_PER_LUN,
-	.use_clustering		= ENABLE_CLUSTERING,
 	.shost_attrs		= twl_host_attrs,
 	.emulated		= 1,
 	.no_write_same		= 1,
diff --git a/drivers/scsi/3w-xxxx.c b/drivers/scsi/3w-xxxx.c
index a58257645e94..4938ba8adc86 100644
--- a/drivers/scsi/3w-xxxx.c
+++ b/drivers/scsi/3w-xxxx.c
@@ -2247,7 +2247,6 @@ static struct scsi_host_template driver_template = {
 	.sg_tablesize		= TW_MAX_SGL_LENGTH,
 	.max_sectors		= TW_MAX_SECTORS,
 	.cmd_per_lun		= TW_MAX_CMDS_PER_LUN,	
-	.use_clustering		= ENABLE_CLUSTERING,
 	.shost_attrs		= tw_host_attrs,
 	.emulated		= 1,
 	.no_write_same		= 1,
diff --git a/drivers/scsi/53c700.c b/drivers/scsi/53c700.c
index 6be77b3aa8a5..128d658d472a 100644
--- a/drivers/scsi/53c700.c
+++ b/drivers/scsi/53c700.c
@@ -318,7 +318,6 @@ NCR_700_detect(struct scsi_host_template *tpnt,
 	tpnt->can_queue = NCR_700_COMMAND_SLOTS_PER_HOST;
 	tpnt->sg_tablesize = NCR_700_SG_SEGMENTS;
 	tpnt->cmd_per_lun = NCR_700_CMD_PER_LUN;
-	tpnt->use_clustering = ENABLE_CLUSTERING;
 	tpnt->slave_configure = NCR_700_slave_configure;
 	tpnt->slave_destroy = NCR_700_slave_destroy;
 	tpnt->slave_alloc = NCR_700_slave_alloc;
diff --git a/drivers/scsi/BusLogic.c b/drivers/scsi/BusLogic.c
index 9cee941f97d6..31afdfd73d41 100644
--- a/drivers/scsi/BusLogic.c
+++ b/drivers/scsi/BusLogic.c
@@ -3857,7 +3857,6 @@ static struct scsi_host_template blogic_template = {
 #endif
 	.unchecked_isa_dma = 1,
 	.max_sectors = 128,
-	.use_clustering = ENABLE_CLUSTERING,
 };
 
 /*
diff --git a/drivers/scsi/a100u2w.c b/drivers/scsi/a100u2w.c
index 00072ed9540b..ff53fd0d12f2 100644
--- a/drivers/scsi/a100u2w.c
+++ b/drivers/scsi/a100u2w.c
@@ -1078,7 +1078,6 @@ static struct scsi_host_template inia100_template = {
 	.can_queue		= 1,
 	.this_id		= 1,
 	.sg_tablesize		= SG_ALL,
-	.use_clustering		= ENABLE_CLUSTERING,
 };
 
 static int inia100_probe_one(struct pci_dev *pdev,
diff --git a/drivers/scsi/a3000.c b/drivers/scsi/a3000.c
index 2427a8541247..dcf435f312dd 100644
--- a/drivers/scsi/a3000.c
+++ b/drivers/scsi/a3000.c
@@ -175,7 +175,6 @@ static struct scsi_host_template amiga_a3000_scsi_template = {
 	.this_id		= 7,
 	.sg_tablesize		= SG_ALL,
 	.cmd_per_lun		= CMD_PER_LUN,
-	.use_clustering		= ENABLE_CLUSTERING
 };
 
 static int __init amiga_a3000_scsi_probe(struct platform_device *pdev)
diff --git a/drivers/scsi/aacraid/linit.c b/drivers/scsi/aacraid/linit.c
index 42defee90eb2..ecf91c827c17 100644
--- a/drivers/scsi/aacraid/linit.c
+++ b/drivers/scsi/aacraid/linit.c
@@ -1540,7 +1540,6 @@ static struct scsi_host_template aac_driver_template = {
 #else
 	.cmd_per_lun			= AAC_NUM_IO_FIB,
 #endif
-	.use_clustering			= ENABLE_CLUSTERING,
 	.emulated			= 1,
 	.no_write_same			= 1,
 };
diff --git a/drivers/scsi/advansys.c b/drivers/scsi/advansys.c
index 223ef6f4e258..95b4793c33f4 100644
--- a/drivers/scsi/advansys.c
+++ b/drivers/scsi/advansys.c
@@ -10808,14 +10808,6 @@ static struct scsi_host_template advansys_template = {
 	 * for non-ISA adapters.
 	 */
 	.unchecked_isa_dma = true,
-	/*
-	 * All adapters controlled by this driver are capable of large
-	 * scatter-gather lists. According to the mid-level SCSI documentation
-	 * this obviates any performance gain provided by setting
-	 * 'use_clustering'. But empirically while CPU utilization is increased
-	 * by enabling clustering, I/O throughput increases as well.
-	 */
-	.use_clustering = ENABLE_CLUSTERING,
 };
 
 static int advansys_wide_init_chip(struct Scsi_Host *shost)
diff --git a/drivers/scsi/aha1542.c b/drivers/scsi/aha1542.c
index a9c29757172f..ef38946bd1a2 100644
--- a/drivers/scsi/aha1542.c
+++ b/drivers/scsi/aha1542.c
@@ -1011,7 +1011,6 @@ static struct scsi_host_template driver_template = {
 	.this_id		= 7,
 	.sg_tablesize		= 16,
 	.unchecked_isa_dma	= 1, 
-	.use_clustering		= ENABLE_CLUSTERING,
 };
 
 static int aha1542_isa_match(struct device *pdev, unsigned int ndev)
diff --git a/drivers/scsi/aha1740.c b/drivers/scsi/aha1740.c
index 786bf7f32c64..da4150c17781 100644
--- a/drivers/scsi/aha1740.c
+++ b/drivers/scsi/aha1740.c
@@ -545,7 +545,6 @@ static struct scsi_host_template aha1740_template = {
 	.can_queue        = AHA1740_ECBS,
 	.this_id          = 7,
 	.sg_tablesize     = AHA1740_SCATTER,
-	.use_clustering   = ENABLE_CLUSTERING,
 	.eh_abort_handler = aha1740_eh_abort_handler,
 };
 
diff --git a/drivers/scsi/aic7xxx/aic79xx_osm.c b/drivers/scsi/aic7xxx/aic79xx_osm.c
index 2588b8f84ba0..57992519384e 100644
--- a/drivers/scsi/aic7xxx/aic79xx_osm.c
+++ b/drivers/scsi/aic7xxx/aic79xx_osm.c
@@ -920,7 +920,6 @@ struct scsi_host_template aic79xx_driver_template = {
 	.this_id		= -1,
 	.max_sectors		= 8192,
 	.cmd_per_lun		= 2,
-	.use_clustering		= ENABLE_CLUSTERING,
 	.slave_alloc		= ahd_linux_slave_alloc,
 	.slave_configure	= ahd_linux_slave_configure,
 	.target_alloc		= ahd_linux_target_alloc,
diff --git a/drivers/scsi/aic7xxx/aic7xxx_osm.c b/drivers/scsi/aic7xxx/aic7xxx_osm.c
index c6be3aeb302b..3c9c17450bb3 100644
--- a/drivers/scsi/aic7xxx/aic7xxx_osm.c
+++ b/drivers/scsi/aic7xxx/aic7xxx_osm.c
@@ -807,7 +807,6 @@ struct scsi_host_template aic7xxx_driver_template = {
 	.this_id		= -1,
 	.max_sectors		= 8192,
 	.cmd_per_lun		= 2,
-	.use_clustering		= ENABLE_CLUSTERING,
 	.slave_alloc		= ahc_linux_slave_alloc,
 	.slave_configure	= ahc_linux_slave_configure,
 	.target_alloc		= ahc_linux_target_alloc,
diff --git a/drivers/scsi/aic94xx/aic94xx_init.c b/drivers/scsi/aic94xx/aic94xx_init.c
index 41c4d8abdd4a..f83f79b07b50 100644
--- a/drivers/scsi/aic94xx/aic94xx_init.c
+++ b/drivers/scsi/aic94xx/aic94xx_init.c
@@ -68,7 +68,6 @@ static struct scsi_host_template aic94xx_sht = {
 	.this_id		= -1,
 	.sg_tablesize		= SG_ALL,
 	.max_sectors		= SCSI_DEFAULT_MAX_SECTORS,
-	.use_clustering		= ENABLE_CLUSTERING,
 	.eh_device_reset_handler	= sas_eh_device_reset_handler,
 	.eh_target_reset_handler	= sas_eh_target_reset_handler,
 	.target_destroy		= sas_target_destroy,
diff --git a/drivers/scsi/arcmsr/arcmsr_hba.c b/drivers/scsi/arcmsr/arcmsr_hba.c
index 11e8e6df50b1..0f6751b0a633 100644
--- a/drivers/scsi/arcmsr/arcmsr_hba.c
+++ b/drivers/scsi/arcmsr/arcmsr_hba.c
@@ -156,7 +156,6 @@ static struct scsi_host_template arcmsr_scsi_host_template = {
 	.sg_tablesize	        = ARCMSR_DEFAULT_SG_ENTRIES,
 	.max_sectors		= ARCMSR_MAX_XFER_SECTORS_C,
 	.cmd_per_lun		= ARCMSR_DEFAULT_CMD_PERLUN,
-	.use_clustering		= ENABLE_CLUSTERING,
 	.shost_attrs		= arcmsr_host_attrs,
 	.no_write_same		= 1,
 };
diff --git a/drivers/scsi/arm/powertec.c b/drivers/scsi/arm/powertec.c
index 79aa88911b7f..759f95ba993c 100644
--- a/drivers/scsi/arm/powertec.c
+++ b/drivers/scsi/arm/powertec.c
@@ -294,7 +294,6 @@ static struct scsi_host_template powertecscsi_template = {
 	.sg_tablesize			= SG_MAX_SEGMENTS,
 	.dma_boundary			= IOMD_DMA_BOUNDARY,
 	.cmd_per_lun			= 2,
-	.use_clustering			= ENABLE_CLUSTERING,
 	.proc_name			= "powertec",
 };
 
diff --git a/drivers/scsi/atp870u.c b/drivers/scsi/atp870u.c
index 802d15018ec0..1267200380f8 100644
--- a/drivers/scsi/atp870u.c
+++ b/drivers/scsi/atp870u.c
@@ -1681,7 +1681,6 @@ static struct scsi_host_template atp870u_template = {
      .can_queue         	= qcnt			/* can_queue */,
      .this_id           	= 7			/* SCSI ID */,
      .sg_tablesize      	= ATP870U_SCATTER	/*SG_ALL*/ /*SG_NONE*/,
-     .use_clustering    	= ENABLE_CLUSTERING,
      .max_sectors		= ATP870U_MAX_SECTORS,
 };
 
diff --git a/drivers/scsi/be2iscsi/be_main.c b/drivers/scsi/be2iscsi/be_main.c
index effb6fc95af4..c4108b17d5ab 100644
--- a/drivers/scsi/be2iscsi/be_main.c
+++ b/drivers/scsi/be2iscsi/be_main.c
@@ -405,7 +405,6 @@ static struct scsi_host_template beiscsi_sht = {
 	.this_id = -1,
 	.max_sectors = BEISCSI_MAX_SECTORS,
 	.cmd_per_lun = BEISCSI_CMD_PER_LUN,
-	.use_clustering = ENABLE_CLUSTERING,
 	.vendor_id = SCSI_NL_VID_TYPE_PCI | BE_VENDOR_ID,
 	.track_queue_depth = 1,
 };
diff --git a/drivers/scsi/bfa/bfad_im.c b/drivers/scsi/bfa/bfad_im.c
index c4a33317d344..394930cbaa13 100644
--- a/drivers/scsi/bfa/bfad_im.c
+++ b/drivers/scsi/bfa/bfad_im.c
@@ -817,7 +817,6 @@ struct scsi_host_template bfad_im_scsi_host_template = {
 	.this_id = -1,
 	.sg_tablesize = BFAD_IO_MAX_SGE,
 	.cmd_per_lun = 3,
-	.use_clustering = ENABLE_CLUSTERING,
 	.shost_attrs = bfad_im_host_attrs,
 	.max_sectors = BFAD_MAX_SECTORS,
 	.vendor_id = BFA_PCI_VENDOR_ID_BROCADE,
@@ -840,7 +839,6 @@ struct scsi_host_template bfad_im_vport_template = {
 	.this_id = -1,
 	.sg_tablesize = BFAD_IO_MAX_SGE,
 	.cmd_per_lun = 3,
-	.use_clustering = ENABLE_CLUSTERING,
 	.shost_attrs = bfad_im_vport_attrs,
 	.max_sectors = BFAD_MAX_SECTORS,
 };
diff --git a/drivers/scsi/bnx2fc/bnx2fc_fcoe.c b/drivers/scsi/bnx2fc/bnx2fc_fcoe.c
index cd160f2ec75d..63f76e20e229 100644
--- a/drivers/scsi/bnx2fc/bnx2fc_fcoe.c
+++ b/drivers/scsi/bnx2fc/bnx2fc_fcoe.c
@@ -2970,7 +2970,6 @@ static struct scsi_host_template bnx2fc_shost_template = {
 	.change_queue_depth	= scsi_change_queue_depth,
 	.this_id		= -1,
 	.cmd_per_lun		= 3,
-	.use_clustering		= ENABLE_CLUSTERING,
 	.sg_tablesize		= BNX2FC_MAX_BDS_PER_CMD,
 	.max_sectors		= 1024,
 	.track_queue_depth	= 1,
diff --git a/drivers/scsi/bnx2i/bnx2i_iscsi.c b/drivers/scsi/bnx2i/bnx2i_iscsi.c
index de0a507577ef..69c75426c5eb 100644
--- a/drivers/scsi/bnx2i/bnx2i_iscsi.c
+++ b/drivers/scsi/bnx2i/bnx2i_iscsi.c
@@ -2263,7 +2263,6 @@ static struct scsi_host_template bnx2i_host_template = {
 	.max_sectors		= 127,
 	.cmd_per_lun		= 128,
 	.this_id		= -1,
-	.use_clustering		= ENABLE_CLUSTERING,
 	.sg_tablesize		= ISCSI_MAX_BDS_PER_CMD,
 	.shost_attrs		= bnx2i_dev_attributes,
 	.track_queue_depth	= 1,
diff --git a/drivers/scsi/csiostor/csio_scsi.c b/drivers/scsi/csiostor/csio_scsi.c
index 8c15b7acb4b7..e67555effdb5 100644
--- a/drivers/scsi/csiostor/csio_scsi.c
+++ b/drivers/scsi/csiostor/csio_scsi.c
@@ -2280,7 +2280,6 @@ struct scsi_host_template csio_fcoe_shost_template = {
 	.this_id		= -1,
 	.sg_tablesize		= CSIO_SCSI_MAX_SGE,
 	.cmd_per_lun		= CSIO_MAX_CMD_PER_LUN,
-	.use_clustering		= ENABLE_CLUSTERING,
 	.shost_attrs		= csio_fcoe_lport_attrs,
 	.max_sectors		= CSIO_MAX_SECTOR_SIZE,
 };
@@ -2300,7 +2299,6 @@ struct scsi_host_template csio_fcoe_shost_vport_template = {
 	.this_id		= -1,
 	.sg_tablesize		= CSIO_SCSI_MAX_SGE,
 	.cmd_per_lun		= CSIO_MAX_CMD_PER_LUN,
-	.use_clustering		= ENABLE_CLUSTERING,
 	.shost_attrs		= csio_fcoe_vport_attrs,
 	.max_sectors		= CSIO_MAX_SECTOR_SIZE,
 };
diff --git a/drivers/scsi/cxlflash/main.c b/drivers/scsi/cxlflash/main.c
index 6637116529aa..6996d15d1463 100644
--- a/drivers/scsi/cxlflash/main.c
+++ b/drivers/scsi/cxlflash/main.c
@@ -3180,7 +3180,6 @@ static struct scsi_host_template driver_template = {
 	.this_id = -1,
 	.sg_tablesize = 1,	/* No scatter gather support */
 	.max_sectors = CXLFLASH_MAX_SECTORS,
-	.use_clustering = ENABLE_CLUSTERING,
 	.shost_attrs = cxlflash_host_attrs,
 	.sdev_attrs = cxlflash_dev_attrs,
 };
diff --git a/drivers/scsi/dpt_i2o.c b/drivers/scsi/dpt_i2o.c
index d5a474d1434f..70d1a18278af 100644
--- a/drivers/scsi/dpt_i2o.c
+++ b/drivers/scsi/dpt_i2o.c
@@ -3569,7 +3569,6 @@ static struct scsi_host_template driver_template = {
 	.slave_configure	= adpt_slave_configure,
 	.can_queue		= MAX_TO_IOP_MESSAGES,
 	.this_id		= 7,
-	.use_clustering		= ENABLE_CLUSTERING,
 };
 
 static int __init adpt_init(void)
diff --git a/drivers/scsi/esas2r/esas2r_main.c b/drivers/scsi/esas2r/esas2r_main.c
index c07118617d89..64397d441bae 100644
--- a/drivers/scsi/esas2r/esas2r_main.c
+++ b/drivers/scsi/esas2r/esas2r_main.c
@@ -250,7 +250,6 @@ static struct scsi_host_template driver_template = {
 		ESAS2R_DEFAULT_CMD_PER_LUN,
 	.present			= 0,
 	.unchecked_isa_dma		= 0,
-	.use_clustering			= ENABLE_CLUSTERING,
 	.emulated			= 0,
 	.proc_name			= ESAS2R_DRVR_NAME,
 	.change_queue_depth		= scsi_change_queue_depth,
diff --git a/drivers/scsi/esp_scsi.c b/drivers/scsi/esp_scsi.c
index ac7da9db7317..465df475f753 100644
--- a/drivers/scsi/esp_scsi.c
+++ b/drivers/scsi/esp_scsi.c
@@ -2676,7 +2676,6 @@ struct scsi_host_template scsi_esp_template = {
 	.can_queue		= 7,
 	.this_id		= 7,
 	.sg_tablesize		= SG_ALL,
-	.use_clustering		= ENABLE_CLUSTERING,
 	.max_sectors		= 0xffff,
 	.skip_settle_delay	= 1,
 };
diff --git a/drivers/scsi/fcoe/fcoe.c b/drivers/scsi/fcoe/fcoe.c
index f46b312d04bc..4961ae442c87 100644
--- a/drivers/scsi/fcoe/fcoe.c
+++ b/drivers/scsi/fcoe/fcoe.c
@@ -286,7 +286,6 @@ static struct scsi_host_template fcoe_shost_template = {
 	.this_id = -1,
 	.cmd_per_lun = 3,
 	.can_queue = FCOE_MAX_OUTSTANDING_COMMANDS,
-	.use_clustering = ENABLE_CLUSTERING,
 	.sg_tablesize = SG_ALL,
 	.max_sectors = 0xffff,
 	.track_queue_depth = 1,
diff --git a/drivers/scsi/fnic/fnic_main.c b/drivers/scsi/fnic/fnic_main.c
index cc461fd7bef1..5b3534b0deda 100644
--- a/drivers/scsi/fnic/fnic_main.c
+++ b/drivers/scsi/fnic/fnic_main.c
@@ -115,7 +115,6 @@ static struct scsi_host_template fnic_host_template = {
 	.this_id = -1,
 	.cmd_per_lun = 3,
 	.can_queue = FNIC_DFLT_IO_REQ,
-	.use_clustering = ENABLE_CLUSTERING,
 	.sg_tablesize = FNIC_MAX_SG_DESC_CNT,
 	.max_sectors = 0xffff,
 	.shost_attrs = fnic_attrs,
diff --git a/drivers/scsi/gdth.c b/drivers/scsi/gdth.c
index 16709735b546..194c294f9b6c 100644
--- a/drivers/scsi/gdth.c
+++ b/drivers/scsi/gdth.c
@@ -4680,7 +4680,6 @@ static struct scsi_host_template gdth_template = {
         .sg_tablesize           = GDTH_MAXSG,
         .cmd_per_lun            = GDTH_MAXC_P_L,
         .unchecked_isa_dma      = 1,
-        .use_clustering         = ENABLE_CLUSTERING,
 	.no_write_same		= 1,
 };
 
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
index d24342bcd072..3f4d72bc8e80 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
@@ -1817,7 +1817,6 @@ static struct scsi_host_template sht_v1_hw = {
 	.this_id		= -1,
 	.sg_tablesize		= SG_ALL,
 	.max_sectors		= SCSI_DEFAULT_MAX_SECTORS,
-	.use_clustering		= ENABLE_CLUSTERING,
 	.eh_device_reset_handler = sas_eh_device_reset_handler,
 	.eh_target_reset_handler = sas_eh_target_reset_handler,
 	.target_destroy		= sas_target_destroy,
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
index e78a97e8c1c6..6b87975a92b0 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
@@ -3572,7 +3572,6 @@ static struct scsi_host_template sht_v2_hw = {
 	.this_id		= -1,
 	.sg_tablesize		= SG_ALL,
 	.max_sectors		= SCSI_DEFAULT_MAX_SECTORS,
-	.use_clustering		= ENABLE_CLUSTERING,
 	.eh_device_reset_handler = sas_eh_device_reset_handler,
 	.eh_target_reset_handler = sas_eh_target_reset_handler,
 	.target_destroy		= sas_target_destroy,
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index 7e2b020c0c69..390f469e4f94 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -2226,7 +2226,6 @@ static struct scsi_host_template sht_v3_hw = {
 	.this_id		= -1,
 	.sg_tablesize		= SG_ALL,
 	.max_sectors		= SCSI_DEFAULT_MAX_SECTORS,
-	.use_clustering		= ENABLE_CLUSTERING,
 	.eh_device_reset_handler = sas_eh_device_reset_handler,
 	.eh_target_reset_handler = sas_eh_target_reset_handler,
 	.target_destroy		= sas_target_destroy,
diff --git a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c
index bc64e8a0449d..ff67ef5d5347 100644
--- a/drivers/scsi/hpsa.c
+++ b/drivers/scsi/hpsa.c
@@ -965,7 +965,6 @@ static struct scsi_host_template hpsa_driver_template = {
 	.scan_finished		= hpsa_scan_finished,
 	.change_queue_depth	= hpsa_change_queue_depth,
 	.this_id		= -1,
-	.use_clustering		= ENABLE_CLUSTERING,
 	.eh_device_reset_handler = hpsa_eh_device_reset_handler,
 	.ioctl			= hpsa_ioctl,
 	.slave_alloc		= hpsa_slave_alloc,
diff --git a/drivers/scsi/hptiop.c b/drivers/scsi/hptiop.c
index dc52b37a0df8..3eedfd4f8f57 100644
--- a/drivers/scsi/hptiop.c
+++ b/drivers/scsi/hptiop.c
@@ -1180,7 +1180,6 @@ static struct scsi_host_template driver_template = {
 	.eh_host_reset_handler      = hptiop_reset,
 	.info                       = hptiop_info,
 	.emulated                   = 0,
-	.use_clustering             = ENABLE_CLUSTERING,
 	.proc_name                  = driver_name,
 	.shost_attrs                = hptiop_attrs,
 	.slave_configure            = hptiop_slave_config,
diff --git a/drivers/scsi/ibmvscsi/ibmvfc.c b/drivers/scsi/ibmvscsi/ibmvfc.c
index b64ca977825d..dbaa4f131433 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc.c
@@ -3100,7 +3100,6 @@ static struct scsi_host_template driver_template = {
 	.this_id = -1,
 	.sg_tablesize = SG_ALL,
 	.max_sectors = IBMVFC_MAX_SECTORS,
-	.use_clustering = ENABLE_CLUSTERING,
 	.shost_attrs = ibmvfc_attrs,
 	.track_queue_depth = 1,
 };
diff --git a/drivers/scsi/ibmvscsi/ibmvscsi.c b/drivers/scsi/ibmvscsi/ibmvscsi.c
index 9df8a1a2299c..1135e74646e2 100644
--- a/drivers/scsi/ibmvscsi/ibmvscsi.c
+++ b/drivers/scsi/ibmvscsi/ibmvscsi.c
@@ -2079,7 +2079,6 @@ static struct scsi_host_template driver_template = {
 	.can_queue = IBMVSCSI_MAX_REQUESTS_DEFAULT,
 	.this_id = -1,
 	.sg_tablesize = SG_ALL,
-	.use_clustering = ENABLE_CLUSTERING,
 	.shost_attrs = ibmvscsi_attrs,
 };
 
diff --git a/drivers/scsi/imm.c b/drivers/scsi/imm.c
index 8c6627bc8a39..cea7f502e8ca 100644
--- a/drivers/scsi/imm.c
+++ b/drivers/scsi/imm.c
@@ -1110,7 +1110,6 @@ static struct scsi_host_template imm_template = {
 	.bios_param		= imm_biosparam,
 	.this_id		= 7,
 	.sg_tablesize		= SG_ALL,
-	.use_clustering		= ENABLE_CLUSTERING,
 	.can_queue		= 1,
 	.slave_alloc		= imm_adjust_queue,
 };
diff --git a/drivers/scsi/initio.c b/drivers/scsi/initio.c
index 0a8d786c84ed..eb2778b5c81b 100644
--- a/drivers/scsi/initio.c
+++ b/drivers/scsi/initio.c
@@ -2817,7 +2817,6 @@ static struct scsi_host_template initio_template = {
 	.can_queue		= MAX_TARGETS * i91u_MAXQUEUE,
 	.this_id		= 1,
 	.sg_tablesize		= SG_ALL,
-	.use_clustering		= ENABLE_CLUSTERING,
 };
 
 static int initio_probe_one(struct pci_dev *pdev,
diff --git a/drivers/scsi/ipr.c b/drivers/scsi/ipr.c
index 271990bc065b..d1b4025a4503 100644
--- a/drivers/scsi/ipr.c
+++ b/drivers/scsi/ipr.c
@@ -6754,7 +6754,6 @@ static struct scsi_host_template driver_template = {
 	.sg_tablesize = IPR_MAX_SGLIST,
 	.max_sectors = IPR_IOA_MAX_SECTORS,
 	.cmd_per_lun = IPR_MAX_CMD_PER_LUN,
-	.use_clustering = ENABLE_CLUSTERING,
 	.shost_attrs = ipr_ioa_attrs,
 	.sdev_attrs = ipr_dev_attrs,
 	.proc_name = IPR_NAME,
diff --git a/drivers/scsi/ips.c b/drivers/scsi/ips.c
index 70a776dc0a02..067725295083 100644
--- a/drivers/scsi/ips.c
+++ b/drivers/scsi/ips.c
@@ -365,7 +365,6 @@ static struct scsi_host_template ips_driver_template = {
 	.this_id		= -1,
 	.sg_tablesize		= IPS_MAX_SG,
 	.cmd_per_lun		= 3,
-	.use_clustering		= ENABLE_CLUSTERING,
 	.no_write_same		= 1,
 };
 
diff --git a/drivers/scsi/isci/init.c b/drivers/scsi/isci/init.c
index d72edbcbb7c6..68b90c4f79a3 100644
--- a/drivers/scsi/isci/init.c
+++ b/drivers/scsi/isci/init.c
@@ -163,7 +163,6 @@ static struct scsi_host_template isci_sht = {
 	.this_id			= -1,
 	.sg_tablesize			= SG_ALL,
 	.max_sectors			= SCSI_DEFAULT_MAX_SECTORS,
-	.use_clustering			= ENABLE_CLUSTERING,
 	.eh_abort_handler		= sas_eh_abort_handler,
 	.eh_device_reset_handler        = sas_eh_device_reset_handler,
 	.eh_target_reset_handler        = sas_eh_target_reset_handler,
diff --git a/drivers/scsi/lpfc/lpfc_scsi.c b/drivers/scsi/lpfc/lpfc_scsi.c
index 4fa6703a9ec9..6d5330e9b2a9 100644
--- a/drivers/scsi/lpfc/lpfc_scsi.c
+++ b/drivers/scsi/lpfc/lpfc_scsi.c
@@ -6036,7 +6036,6 @@ struct scsi_host_template lpfc_template_nvme = {
 	.this_id		= -1,
 	.sg_tablesize		= 1,
 	.cmd_per_lun		= 1,
-	.use_clustering		= ENABLE_CLUSTERING,
 	.shost_attrs		= lpfc_hba_attrs,
 	.max_sectors		= 0xFFFF,
 	.vendor_id		= LPFC_NL_VENDOR_ID,
@@ -6061,7 +6060,6 @@ struct scsi_host_template lpfc_template_no_hr = {
 	.this_id		= -1,
 	.sg_tablesize		= LPFC_DEFAULT_SG_SEG_CNT,
 	.cmd_per_lun		= LPFC_CMD_PER_LUN,
-	.use_clustering		= ENABLE_CLUSTERING,
 	.shost_attrs		= lpfc_hba_attrs,
 	.max_sectors		= 0xFFFF,
 	.vendor_id		= LPFC_NL_VENDOR_ID,
@@ -6088,7 +6086,6 @@ struct scsi_host_template lpfc_template = {
 	.this_id		= -1,
 	.sg_tablesize		= LPFC_DEFAULT_SG_SEG_CNT,
 	.cmd_per_lun		= LPFC_CMD_PER_LUN,
-	.use_clustering		= ENABLE_CLUSTERING,
 	.shost_attrs		= lpfc_hba_attrs,
 	.max_sectors		= 0xFFFF,
 	.vendor_id		= LPFC_NL_VENDOR_ID,
@@ -6113,7 +6110,6 @@ struct scsi_host_template lpfc_vport_template = {
 	.this_id		= -1,
 	.sg_tablesize		= LPFC_DEFAULT_SG_SEG_CNT,
 	.cmd_per_lun		= LPFC_CMD_PER_LUN,
-	.use_clustering		= ENABLE_CLUSTERING,
 	.shost_attrs		= lpfc_vport_attrs,
 	.max_sectors		= 0xFFFF,
 	.change_queue_depth	= scsi_change_queue_depth,
diff --git a/drivers/scsi/megaraid.c b/drivers/scsi/megaraid.c
index 8c7154143a4e..4862f65ec3e8 100644
--- a/drivers/scsi/megaraid.c
+++ b/drivers/scsi/megaraid.c
@@ -4148,7 +4148,6 @@ static struct scsi_host_template megaraid_template = {
 	.this_id			= DEFAULT_INITIATOR_ID,
 	.sg_tablesize			= MAX_SGLIST,
 	.cmd_per_lun			= DEF_CMD_PER_LUN,
-	.use_clustering			= ENABLE_CLUSTERING,
 	.eh_abort_handler		= megaraid_abort,
 	.eh_device_reset_handler	= megaraid_reset,
 	.eh_bus_reset_handler		= megaraid_reset,
diff --git a/drivers/scsi/megaraid/megaraid_mbox.c b/drivers/scsi/megaraid/megaraid_mbox.c
index 3b7abe5ca7f5..77196a6c1de1 100644
--- a/drivers/scsi/megaraid/megaraid_mbox.c
+++ b/drivers/scsi/megaraid/megaraid_mbox.c
@@ -336,7 +336,6 @@ static struct scsi_host_template megaraid_template_g = {
 	.eh_abort_handler		= megaraid_abort_handler,
 	.eh_host_reset_handler		= megaraid_reset_handler,
 	.change_queue_depth		= scsi_change_queue_depth,
-	.use_clustering			= ENABLE_CLUSTERING,
 	.no_write_same			= 1,
 	.sdev_attrs			= megaraid_sdev_attrs,
 	.shost_attrs			= megaraid_shost_attrs,
diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index 9db7aebc3564..0c72c6e07bc3 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -3189,7 +3189,6 @@ static struct scsi_host_template megasas_template = {
 	.eh_timed_out = megasas_reset_timer,
 	.shost_attrs = megaraid_host_attrs,
 	.bios_param = megasas_bios_param,
-	.use_clustering = ENABLE_CLUSTERING,
 	.change_queue_depth = scsi_change_queue_depth,
 	.no_write_same = 1,
 };
diff --git a/drivers/scsi/mpt3sas/mpt3sas_scsih.c b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
index 5b9806d0719e..e4f92597647a 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_scsih.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
@@ -10173,7 +10173,6 @@ static struct scsi_host_template mpt2sas_driver_template = {
 	.sg_tablesize			= MPT2SAS_SG_DEPTH,
 	.max_sectors			= 32767,
 	.cmd_per_lun			= 7,
-	.use_clustering			= ENABLE_CLUSTERING,
 	.shost_attrs			= mpt3sas_host_attrs,
 	.sdev_attrs			= mpt3sas_dev_attrs,
 	.track_queue_depth		= 1,
@@ -10212,7 +10211,6 @@ static struct scsi_host_template mpt3sas_driver_template = {
 	.sg_tablesize			= MPT3SAS_SG_DEPTH,
 	.max_sectors			= 32767,
 	.cmd_per_lun			= 7,
-	.use_clustering			= ENABLE_CLUSTERING,
 	.shost_attrs			= mpt3sas_host_attrs,
 	.sdev_attrs			= mpt3sas_dev_attrs,
 	.track_queue_depth		= 1,
diff --git a/drivers/scsi/mvme147.c b/drivers/scsi/mvme147.c
index 7d1ab414b78f..ca96d6d9c350 100644
--- a/drivers/scsi/mvme147.c
+++ b/drivers/scsi/mvme147.c
@@ -78,7 +78,6 @@ static struct scsi_host_template mvme147_host_template = {
 	.this_id		= 7,
 	.sg_tablesize		= SG_ALL,
 	.cmd_per_lun		= CMD_PER_LUN,
-	.use_clustering		= ENABLE_CLUSTERING
 };
 
 static struct Scsi_Host *mvme147_shost;
diff --git a/drivers/scsi/mvsas/mv_init.c b/drivers/scsi/mvsas/mv_init.c
index 3ac34373746c..030d911ee374 100644
--- a/drivers/scsi/mvsas/mv_init.c
+++ b/drivers/scsi/mvsas/mv_init.c
@@ -59,7 +59,6 @@ static struct scsi_host_template mvs_sht = {
 	.this_id		= -1,
 	.sg_tablesize		= SG_ALL,
 	.max_sectors		= SCSI_DEFAULT_MAX_SECTORS,
-	.use_clustering		= ENABLE_CLUSTERING,
 	.eh_device_reset_handler = sas_eh_device_reset_handler,
 	.eh_target_reset_handler = sas_eh_target_reset_handler,
 	.target_destroy		= sas_target_destroy,
diff --git a/drivers/scsi/mvumi.c b/drivers/scsi/mvumi.c
index 3d2d026d1ccf..d0c3f867fc58 100644
--- a/drivers/scsi/mvumi.c
+++ b/drivers/scsi/mvumi.c
@@ -2197,6 +2197,7 @@ static struct scsi_host_template mvumi_template = {
 	.eh_timed_out = mvumi_timed_out,
 	.eh_host_reset_handler = mvumi_host_reset,
 	.bios_param = mvumi_bios_param,
+	.use_clustering = DISABLE_CLUSTERING,
 	.this_id = -1,
 };
 
diff --git a/drivers/scsi/myrb.c b/drivers/scsi/myrb.c
index aeb282f617c5..f1abe38e3b3a 100644
--- a/drivers/scsi/myrb.c
+++ b/drivers/scsi/myrb.c
@@ -2236,6 +2236,7 @@ struct scsi_host_template myrb_template = {
 	.shost_attrs		= myrb_shost_attrs,
 	.sdev_attrs		= myrb_sdev_attrs,
 	.this_id		= -1,
+	.use_clustering		= DISABLE_CLUSTERING,
 };
 
 /**
diff --git a/drivers/scsi/myrs.c b/drivers/scsi/myrs.c
index 0264a2e2bc19..f47b36382afa 100644
--- a/drivers/scsi/myrs.c
+++ b/drivers/scsi/myrs.c
@@ -1929,6 +1929,7 @@ struct scsi_host_template myrs_template = {
 	.shost_attrs		= myrs_shost_attrs,
 	.sdev_attrs		= myrs_sdev_attrs,
 	.this_id		= -1,
+	.use_clustering		= DISABLE_CLUSTERING,
 };
 
 static struct myrs_hba *myrs_alloc_host(struct pci_dev *pdev,
diff --git a/drivers/scsi/ncr53c8xx.c b/drivers/scsi/ncr53c8xx.c
index 6cd3e289ef99..1a236a3dfd51 100644
--- a/drivers/scsi/ncr53c8xx.c
+++ b/drivers/scsi/ncr53c8xx.c
@@ -8313,7 +8313,6 @@ struct Scsi_Host * __init ncr_attach(struct scsi_host_template *tpnt,
 	tpnt->this_id		= 7;
 	tpnt->sg_tablesize	= SCSI_NCR_SG_TABLESIZE;
 	tpnt->cmd_per_lun	= SCSI_NCR_CMD_PER_LUN;
-	tpnt->use_clustering	= ENABLE_CLUSTERING;
 
 	if (device->differential)
 		driver_setup.diff_support = device->differential;
diff --git a/drivers/scsi/pcmcia/sym53c500_cs.c b/drivers/scsi/pcmcia/sym53c500_cs.c
index a3b63bea0e50..d1e98a6ea28f 100644
--- a/drivers/scsi/pcmcia/sym53c500_cs.c
+++ b/drivers/scsi/pcmcia/sym53c500_cs.c
@@ -680,7 +680,6 @@ static struct scsi_host_template sym53c500_driver_template = {
      .can_queue			= 1,
      .this_id			= 7,
      .sg_tablesize		= 32,
-     .use_clustering		= ENABLE_CLUSTERING,
      .shost_attrs		= SYM53C500_shost_attrs
 };
 
diff --git a/drivers/scsi/pm8001/pm8001_init.c b/drivers/scsi/pm8001/pm8001_init.c
index d71e7e4ec29c..a36060c23b37 100644
--- a/drivers/scsi/pm8001/pm8001_init.c
+++ b/drivers/scsi/pm8001/pm8001_init.c
@@ -84,7 +84,6 @@ static struct scsi_host_template pm8001_sht = {
 	.this_id		= -1,
 	.sg_tablesize		= SG_ALL,
 	.max_sectors		= SCSI_DEFAULT_MAX_SECTORS,
-	.use_clustering		= ENABLE_CLUSTERING,
 	.eh_device_reset_handler = sas_eh_device_reset_handler,
 	.eh_target_reset_handler = sas_eh_target_reset_handler,
 	.target_destroy		= sas_target_destroy,
diff --git a/drivers/scsi/pmcraid.c b/drivers/scsi/pmcraid.c
index 707d766c1ee9..7c4673308f5b 100644
--- a/drivers/scsi/pmcraid.c
+++ b/drivers/scsi/pmcraid.c
@@ -4149,7 +4149,6 @@ static struct scsi_host_template pmcraid_host_template = {
 	.max_sectors = PMCRAID_IOA_MAX_SECTORS,
 	.no_write_same = 1,
 	.cmd_per_lun = PMCRAID_MAX_CMD_PER_LUN,
-	.use_clustering = ENABLE_CLUSTERING,
 	.shost_attrs = pmcraid_host_attrs,
 	.proc_name = PMCRAID_DRIVER_NAME,
 };
diff --git a/drivers/scsi/ppa.c b/drivers/scsi/ppa.c
index ee86a0c62dbf..c182b5458f98 100644
--- a/drivers/scsi/ppa.c
+++ b/drivers/scsi/ppa.c
@@ -978,7 +978,6 @@ static struct scsi_host_template ppa_template = {
 	.bios_param		= ppa_biosparam,
 	.this_id		= -1,
 	.sg_tablesize		= SG_ALL,
-	.use_clustering		= ENABLE_CLUSTERING,
 	.can_queue		= 1,
 	.slave_alloc		= ppa_adjust_queue,
 };
diff --git a/drivers/scsi/ps3rom.c b/drivers/scsi/ps3rom.c
index 4924424d20fe..8d769138c01c 100644
--- a/drivers/scsi/ps3rom.c
+++ b/drivers/scsi/ps3rom.c
@@ -349,7 +349,6 @@ static struct scsi_host_template ps3rom_host_template = {
 	.sg_tablesize =		SG_ALL,
 	.emulated =             1,		/* only sg driver uses this */
 	.max_sectors =		PS3ROM_MAX_SECTORS,
-	.use_clustering =	ENABLE_CLUSTERING,
 	.module =		THIS_MODULE,
 };
 
diff --git a/drivers/scsi/qedf/qedf_main.c b/drivers/scsi/qedf/qedf_main.c
index d5a4f17fce51..e6ec6221dbf7 100644
--- a/drivers/scsi/qedf/qedf_main.c
+++ b/drivers/scsi/qedf/qedf_main.c
@@ -785,7 +785,6 @@ static struct scsi_host_template qedf_host_template = {
 	.name 		= QEDF_MODULE_NAME,
 	.this_id 	= -1,
 	.cmd_per_lun	= 32,
-	.use_clustering = ENABLE_CLUSTERING,
 	.max_sectors 	= 0xffff,
 	.queuecommand 	= qedf_queuecommand,
 	.shost_attrs	= qedf_host_attrs,
diff --git a/drivers/scsi/qedi/qedi_iscsi.c b/drivers/scsi/qedi/qedi_iscsi.c
index 2f0a4f2c5ff8..4da660c1c431 100644
--- a/drivers/scsi/qedi/qedi_iscsi.c
+++ b/drivers/scsi/qedi/qedi_iscsi.c
@@ -61,7 +61,6 @@ struct scsi_host_template qedi_host_template = {
 	.max_sectors = 0xffff,
 	.dma_boundary = QEDI_HW_DMA_BOUNDARY,
 	.cmd_per_lun = 128,
-	.use_clustering = ENABLE_CLUSTERING,
 	.shost_attrs = qedi_shost_attrs,
 };
 
diff --git a/drivers/scsi/qla1280.c b/drivers/scsi/qla1280.c
index 9c5b67304a76..a414f51302b7 100644
--- a/drivers/scsi/qla1280.c
+++ b/drivers/scsi/qla1280.c
@@ -4203,7 +4203,6 @@ static struct scsi_host_template qla1280_driver_template = {
 	.can_queue		= MAX_OUTSTANDING_COMMANDS,
 	.this_id		= -1,
 	.sg_tablesize		= SG_ALL,
-	.use_clustering		= ENABLE_CLUSTERING,
 };
 
 
diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index 518f15141170..f20d14d40426 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -328,7 +328,6 @@ struct scsi_host_template qla2xxx_driver_template = {
 	.map_queues             = qla2xxx_map_queues,
 	.this_id		= -1,
 	.cmd_per_lun		= 3,
-	.use_clustering		= ENABLE_CLUSTERING,
 	.sg_tablesize		= SG_ALL,
 
 	.max_sectors		= 0xFFFF,
diff --git a/drivers/scsi/qla4xxx/ql4_os.c b/drivers/scsi/qla4xxx/ql4_os.c
index 1c702cd22359..949e186cc5d7 100644
--- a/drivers/scsi/qla4xxx/ql4_os.c
+++ b/drivers/scsi/qla4xxx/ql4_os.c
@@ -205,7 +205,6 @@ static struct scsi_host_template qla4xxx_driver_template = {
 
 	.this_id		= -1,
 	.cmd_per_lun		= 3,
-	.use_clustering		= ENABLE_CLUSTERING,
 	.sg_tablesize		= SG_ALL,
 
 	.max_sectors		= 0xFFFF,
diff --git a/drivers/scsi/qlogicpti.c b/drivers/scsi/qlogicpti.c
index 9d09228eee28..e35ce762d454 100644
--- a/drivers/scsi/qlogicpti.c
+++ b/drivers/scsi/qlogicpti.c
@@ -1287,7 +1287,6 @@ static struct scsi_host_template qpti_template = {
 	.can_queue		= QLOGICPTI_REQ_QUEUE_LEN,
 	.this_id		= 7,
 	.sg_tablesize		= QLOGICPTI_MAX_SG(QLOGICPTI_REQ_QUEUE_LEN),
-	.use_clustering		= ENABLE_CLUSTERING,
 };
 
 static const struct of_device_id qpti_match[];
diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 60bcc6df97a9..53ba417bef8a 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -5851,7 +5851,6 @@ static struct scsi_host_template sdebug_driver_template = {
 	.sg_tablesize =		SG_MAX_SEGMENTS,
 	.cmd_per_lun =		DEF_CMD_PER_LUN,
 	.max_sectors =		-1U,
-	.use_clustering = 	DISABLE_CLUSTERING,
 	.module =		THIS_MODULE,
 	.track_queue_depth =	1,
 };
@@ -5866,8 +5865,8 @@ static int sdebug_driver_probe(struct device *dev)
 	sdbg_host = to_sdebug_host(dev);
 
 	sdebug_driver_template.can_queue = sdebug_max_queue;
-	if (sdebug_clustering)
-		sdebug_driver_template.use_clustering = ENABLE_CLUSTERING;
+	if (!sdebug_clustering)
+		sdebug_driver_template.use_clustering = DISABLE_CLUSTERING;
 	hpnt = scsi_host_alloc(&sdebug_driver_template, sizeof(sdbg_host));
 	if (NULL == hpnt) {
 		pr_err("scsi_host_alloc failed\n");
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index c7fccbb8f554..f6900e0b3024 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -2229,7 +2229,7 @@ void __scsi_init_queue(struct Scsi_Host *shost, struct request_queue *q)
 
 	blk_queue_max_segment_size(q, dma_get_max_seg_size(dev));
 
-	if (!shost->use_clustering)
+	if (shost->use_clustering == DISABLE_CLUSTERING)
 		q->limits.cluster = 0;
 
 	/*
diff --git a/drivers/scsi/smartpqi/smartpqi_init.c b/drivers/scsi/smartpqi/smartpqi_init.c
index a25a07a0b7f0..c9a1a4973574 100644
--- a/drivers/scsi/smartpqi/smartpqi_init.c
+++ b/drivers/scsi/smartpqi/smartpqi_init.c
@@ -5779,7 +5779,6 @@ static struct scsi_host_template pqi_driver_template = {
 	.scan_start = pqi_scan_start,
 	.scan_finished = pqi_scan_finished,
 	.this_id = -1,
-	.use_clustering = ENABLE_CLUSTERING,
 	.eh_device_reset_handler = pqi_eh_device_reset_handler,
 	.ioctl = pqi_ioctl,
 	.slave_alloc = pqi_slave_alloc,
diff --git a/drivers/scsi/snic/snic_main.c b/drivers/scsi/snic/snic_main.c
index 5295277d6325..5e824fd6047a 100644
--- a/drivers/scsi/snic/snic_main.c
+++ b/drivers/scsi/snic/snic_main.c
@@ -127,7 +127,6 @@ static struct scsi_host_template snic_host_template = {
 	.this_id = -1,
 	.cmd_per_lun = SNIC_DFLT_QUEUE_DEPTH,
 	.can_queue = SNIC_MAX_IO_REQ,
-	.use_clustering = ENABLE_CLUSTERING,
 	.sg_tablesize = SNIC_MAX_SG_DESC_CNT,
 	.max_sectors = 0x800,
 	.shost_attrs = snic_attrs,
diff --git a/drivers/scsi/stex.c b/drivers/scsi/stex.c
index 95f370ad05e0..af9078320d4b 100644
--- a/drivers/scsi/stex.c
+++ b/drivers/scsi/stex.c
@@ -1489,6 +1489,7 @@ static struct scsi_host_template driver_template = {
 	.eh_abort_handler		= stex_abort,
 	.eh_host_reset_handler		= stex_reset,
 	.this_id			= -1,
+	.use_clustering			= DISABLE_CLUSTERING,
 };
 
 static struct pci_device_id stex_pci_tbl[] = {
diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index f03dc03a42c3..8ab05e93acfa 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -1698,7 +1698,6 @@ static struct scsi_host_template scsi_driver = {
 	.slave_configure =	storvsc_device_configure,
 	.cmd_per_lun =		2048,
 	.this_id =		-1,
-	.use_clustering =	ENABLE_CLUSTERING,
 	/* Make sure we dont get a sg segment crosses a page boundary */
 	.dma_boundary =		PAGE_SIZE-1,
 	.no_write_same =	1,
diff --git a/drivers/scsi/sym53c8xx_2/sym_glue.c b/drivers/scsi/sym53c8xx_2/sym_glue.c
index 6e9b54061d7e..57f6d63e4c40 100644
--- a/drivers/scsi/sym53c8xx_2/sym_glue.c
+++ b/drivers/scsi/sym53c8xx_2/sym_glue.c
@@ -1660,7 +1660,6 @@ static struct scsi_host_template sym2_template = {
 	.eh_bus_reset_handler	= sym53c8xx_eh_bus_reset_handler,
 	.eh_host_reset_handler	= sym53c8xx_eh_host_reset_handler,
 	.this_id		= 7,
-	.use_clustering		= ENABLE_CLUSTERING,
 	.max_sectors		= 0xFFFF,
 #ifdef SYM_LINUX_PROC_INFO_SUPPORT
 	.show_info		= sym_show_info,
diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index b15f5dab0618..1b91240cd442 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -6985,6 +6985,7 @@ static struct scsi_host_template ufshcd_driver_template = {
 	.max_host_blocked	= 1,
 	.track_queue_depth	= 1,
 	.sdev_groups		= ufshcd_driver_groups,
+	.use_clustering		= DISABLE_CLUSTERING,
 };
 
 static int ufshcd_config_vreg_load(struct device *dev, struct ufs_vreg *vreg,
diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
index 1c72db94270e..57c6c585226b 100644
--- a/drivers/scsi/virtio_scsi.c
+++ b/drivers/scsi/virtio_scsi.c
@@ -747,7 +747,6 @@ static struct scsi_host_template virtscsi_host_template = {
 	.slave_alloc = virtscsi_device_alloc,
 
 	.dma_boundary = UINT_MAX,
-	.use_clustering = ENABLE_CLUSTERING,
 	.target_alloc = virtscsi_target_alloc,
 	.target_destroy = virtscsi_target_destroy,
 	.map_queues = virtscsi_map_queues,
diff --git a/drivers/scsi/vmw_pvscsi.c b/drivers/scsi/vmw_pvscsi.c
index 6e491023fdd8..644b0e1862b0 100644
--- a/drivers/scsi/vmw_pvscsi.c
+++ b/drivers/scsi/vmw_pvscsi.c
@@ -1007,7 +1007,6 @@ static struct scsi_host_template pvscsi_template = {
 	.sg_tablesize			= PVSCSI_MAX_NUM_SG_ENTRIES_PER_SEGMENT,
 	.dma_boundary			= UINT_MAX,
 	.max_sectors			= 0xffff,
-	.use_clustering			= ENABLE_CLUSTERING,
 	.change_queue_depth		= pvscsi_change_queue_depth,
 	.eh_abort_handler		= pvscsi_abort,
 	.eh_device_reset_handler	= pvscsi_device_reset,
diff --git a/drivers/scsi/wd719x.c b/drivers/scsi/wd719x.c
index 808ba8e952db..e3310e9488d2 100644
--- a/drivers/scsi/wd719x.c
+++ b/drivers/scsi/wd719x.c
@@ -871,7 +871,6 @@ static struct scsi_host_template wd719x_template = {
 	.can_queue			= 255,
 	.this_id			= 7,
 	.sg_tablesize			= WD719X_SG,
-	.use_clustering			= ENABLE_CLUSTERING,
 };
 
 static int wd719x_pci_probe(struct pci_dev *pdev, const struct pci_device_id *d)
diff --git a/drivers/staging/rts5208/rtsx.c b/drivers/staging/rts5208/rtsx.c
index 69e6abe14abf..c57d66a7405f 100644
--- a/drivers/staging/rts5208/rtsx.c
+++ b/drivers/staging/rts5208/rtsx.c
@@ -237,12 +237,6 @@ static struct scsi_host_template rtsx_host_template = {
 	/* limit the total size of a transfer to 120 KB */
 	.max_sectors =                  240,
 
-	/* merge commands... this seems to help performance, but
-	 * periodically someone should test to see which setting is more
-	 * optimal.
-	 */
-	.use_clustering =		1,
-
 	/* emulated HBA */
 	.emulated =			1,
 
diff --git a/drivers/staging/unisys/visorhba/visorhba_main.c b/drivers/staging/unisys/visorhba/visorhba_main.c
index 4fc521c51c0e..5cf93e8eb77c 100644
--- a/drivers/staging/unisys/visorhba/visorhba_main.c
+++ b/drivers/staging/unisys/visorhba/visorhba_main.c
@@ -645,7 +645,6 @@ static struct scsi_host_template visorhba_driver_template = {
 	.this_id = -1,
 	.slave_alloc = visorhba_slave_alloc,
 	.slave_destroy = visorhba_slave_destroy,
-	.use_clustering = ENABLE_CLUSTERING,
 };
 
 /*
diff --git a/drivers/usb/image/microtek.c b/drivers/usb/image/microtek.c
index 9f2f563c82ed..607be1f4fe27 100644
--- a/drivers/usb/image/microtek.c
+++ b/drivers/usb/image/microtek.c
@@ -632,7 +632,6 @@ static struct scsi_host_template mts_scsi_host_template = {
 	.sg_tablesize =		SG_ALL,
 	.can_queue =		1,
 	.this_id =		-1,
-	.use_clustering =	1,
 	.emulated =		1,
 	.slave_alloc =		mts_slave_alloc,
 	.slave_configure =	mts_slave_configure,
diff --git a/drivers/usb/storage/scsiglue.c b/drivers/usb/storage/scsiglue.c
index e227bb5b794f..fde2e71a6ade 100644
--- a/drivers/usb/storage/scsiglue.c
+++ b/drivers/usb/storage/scsiglue.c
@@ -639,13 +639,6 @@ static const struct scsi_host_template usb_stor_host_template = {
 	 */
 	.max_sectors =                  240,
 
-	/*
-	 * merge commands... this seems to help performance, but
-	 * periodically someone should test to see which setting is more
-	 * optimal.
-	 */
-	.use_clustering =		1,
-
 	/* emulated HBA */
 	.emulated =			1,
 
diff --git a/drivers/usb/storage/uas.c b/drivers/usb/storage/uas.c
index 1f7b401c4d04..6c75a0a50b3a 100644
--- a/drivers/usb/storage/uas.c
+++ b/drivers/usb/storage/uas.c
@@ -879,6 +879,7 @@ static struct scsi_host_template uas_host_template = {
 	.this_id = -1,
 	.sg_tablesize = SG_NONE,
 	.skip_settle_delay = 1,
+	.use_clustering = DISABLE_CLUSTERING,
 };
 
 #define UNUSUAL_DEV(id_vendor, id_product, bcdDeviceMin, bcdDeviceMax, \
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 38c95d66ab12..68133842e6d7 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -135,7 +135,6 @@ enum {
 
 	ATA_SHT_EMULATED	= 1,
 	ATA_SHT_THIS_ID		= -1,
-	ATA_SHT_USE_CLUSTERING	= 1,
 
 	/* struct ata_taskfile flags */
 	ATA_TFLAG_LBA48		= (1 << 0), /* enable 48-bit LBA and "HOB" */
@@ -1360,7 +1359,6 @@ extern struct device_attribute *ata_common_sdev_attrs[];
 	.tag_alloc_policy	= BLK_TAG_ALLOC_RR,		\
 	.this_id		= ATA_SHT_THIS_ID,		\
 	.emulated		= ATA_SHT_EMULATED,		\
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,	\
 	.proc_name		= drv_name,			\
 	.slave_configure	= ata_scsi_slave_config,	\
 	.slave_destroy		= ata_scsi_slave_destroy,	\
diff --git a/include/scsi/scsi_host.h b/include/scsi/scsi_host.h
index 5ea06d310a25..7dc534c794dc 100644
--- a/include/scsi/scsi_host.h
+++ b/include/scsi/scsi_host.h
@@ -44,8 +44,7 @@ struct blk_queue_tags;
 #define MODE_INITIATOR 0x01
 #define MODE_TARGET 0x02
 
-#define DISABLE_CLUSTERING 0
-#define ENABLE_CLUSTERING 1
+#define DISABLE_CLUSTERING (-1)
 
 struct scsi_host_template {
 	struct module *module;
-- 
2.19.1

