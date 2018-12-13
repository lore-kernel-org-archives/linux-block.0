Return-Path: <SRS0=8pZC=OW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_MIXED_ES,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E15E0C67839
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 15:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9036C20870
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 15:17:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qPd0hZK5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9036C20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728707AbeLMPRn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Dec 2018 10:17:43 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60860 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728696AbeLMPRn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Dec 2018 10:17:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Jgq7xs4Dz5ZsrFjIPDY9MyiQT4lpa9/DagDPBx8CZRk=; b=qPd0hZK5H+r9h2g37dqtPkiICT
        kWEIncneS7I7WvKwB/ovN9k0F+/bY7hhYDeQrWpmFAXusLrLg3grwfvndWuvij4UJ75lxvK7qEcxQ
        P3tjY/MA/8+WYne5Cuoh6ol8eKYj5q0QqVwzg2Rg70dzwr3qOIMLAaEloEzn2DSUCaVioxErhSTxW
        TnUnx95YSVVgEzYiIbjQ9uDo5kLsED3klfWVkaTTThi9kIW6Di+mKoBoGaxD+qHwZmr7iutW0kiC7
        /cBYXfDYuj8upYLaTei7wF3MBcMMMRBiA3rOFO3wnVHNAR2uk8OZ8FoZPK5iH96OGjMvVx6agNQPw
        eQu5wpPg==;
Received: from 089144198147.atnat0007.highway.a1.net ([89.144.198.147] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gXSk6-0001Uw-FM; Thu, 13 Dec 2018 15:17:38 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Juergen Gross <jgross@suse.com>, linux-scsi@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: [PATCH 09/10] scsi: remove the use_clustering flag
Date:   Thu, 13 Dec 2018 16:17:09 +0100
Message-Id: <20181213151710.30036-10-hch@lst.de>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181213151710.30036-1-hch@lst.de>
References: <20181213151710.30036-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The same effects can be achieved by setting the dma_boundary to
PAGE_SIZE - 1 and the max_segment_size to PAGE_SIZE, so shift those
settings into the drivers.  Note that in many cases the setting might
be bogus, but this keeps the status quo.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 Documentation/scsi/scsi_mid_low_api.txt |  2 --
 arch/ia64/hp/sim/simscsi.c              |  2 +-
 drivers/scsi/a2091.c                    |  2 +-
 drivers/scsi/advansys.c                 |  4 ++--
 drivers/scsi/aha152x.c                  |  2 +-
 drivers/scsi/arm/acornscsi.c            |  2 +-
 drivers/scsi/arm/arxescsi.c             |  2 +-
 drivers/scsi/arm/cumana_1.c             |  2 +-
 drivers/scsi/arm/oak.c                  |  2 +-
 drivers/scsi/atari_scsi.c               |  2 +-
 drivers/scsi/cxgbi/cxgb3i/cxgb3i.c      |  2 +-
 drivers/scsi/cxgbi/cxgb4i/cxgb4i.c      |  2 +-
 drivers/scsi/dc395x.c                   |  2 +-
 drivers/scsi/dmx3191d.c                 |  2 +-
 drivers/scsi/g_NCR5380.c                |  2 +-
 drivers/scsi/gvp11.c                    |  2 +-
 drivers/scsi/hosts.c                    |  1 -
 drivers/scsi/ips.c                      |  1 -
 drivers/scsi/iscsi_tcp.c                |  2 +-
 drivers/scsi/mac_esp.c                  |  2 +-
 drivers/scsi/mac_scsi.c                 |  2 +-
 drivers/scsi/mvumi.c                    |  2 +-
 drivers/scsi/nsp32.c                    |  2 +-
 drivers/scsi/pcmcia/nsp_cs.c            |  2 +-
 drivers/scsi/pcmcia/qlogic_stub.c       |  2 +-
 drivers/scsi/qlogicfas.c                |  2 +-
 drivers/scsi/scsi_debug.c               |  3 ++-
 drivers/scsi/scsi_lib.c                 |  3 ---
 drivers/scsi/sgiwd93.c                  |  2 +-
 drivers/scsi/stex.c                     |  2 +-
 drivers/scsi/sun3_scsi.c                |  2 +-
 drivers/scsi/ufs/ufshcd.c               |  2 +-
 drivers/target/loopback/tcm_loop.c      |  2 +-
 drivers/usb/storage/uas.c               |  2 +-
 include/scsi/scsi_host.h                | 13 -------------
 35 files changed, 32 insertions(+), 51 deletions(-)

diff --git a/Documentation/scsi/scsi_mid_low_api.txt b/Documentation/scsi/scsi_mid_low_api.txt
index 177c031763c0..c1dd4939f4ae 100644
--- a/Documentation/scsi/scsi_mid_low_api.txt
+++ b/Documentation/scsi/scsi_mid_low_api.txt
@@ -1098,8 +1098,6 @@ of interest:
     unchecked_isa_dma - 1=>only use bottom 16 MB of ram (ISA DMA addressing
                    restriction), 0=>can use full 32 bit (or better) DMA
                    address space
-    use_clustering - 1=>SCSI commands in mid level's queue can be merged,
-                     0=>disallow SCSI command merging
     no_async_abort - 1=>Asynchronous aborts are not supported
                      0=>Timed-out commands will be aborted asynchronously
     hostt        - pointer to driver's struct scsi_host_template from which
diff --git a/arch/ia64/hp/sim/simscsi.c b/arch/ia64/hp/sim/simscsi.c
index 7e1426e76d96..f86844fc0725 100644
--- a/arch/ia64/hp/sim/simscsi.c
+++ b/arch/ia64/hp/sim/simscsi.c
@@ -347,7 +347,7 @@ static struct scsi_host_template driver_template = {
 	.sg_tablesize		= SG_ALL,
 	.max_sectors		= 1024,
 	.cmd_per_lun		= SIMSCSI_REQ_QUEUE_LEN,
-	.use_clustering		= DISABLE_CLUSTERING,
+	.dma_boundary		= PAGE_SIZE - 1,
 };
 
 static int __init
diff --git a/drivers/scsi/a2091.c b/drivers/scsi/a2091.c
index 61aadc7acb49..c96bc7261a42 100644
--- a/drivers/scsi/a2091.c
+++ b/drivers/scsi/a2091.c
@@ -160,7 +160,7 @@ static struct scsi_host_template a2091_scsi_template = {
 	.this_id		= 7,
 	.sg_tablesize		= SG_ALL,
 	.cmd_per_lun		= CMD_PER_LUN,
-	.use_clustering		= DISABLE_CLUSTERING
+	.dma_boundary		= PAGE_SIZE - 1,
 };
 
 static int a2091_probe(struct zorro_dev *z, const struct zorro_device_id *ent)
diff --git a/drivers/scsi/advansys.c b/drivers/scsi/advansys.c
index 95b4793c33f4..d37584403c33 100644
--- a/drivers/scsi/advansys.c
+++ b/drivers/scsi/advansys.c
@@ -3192,8 +3192,8 @@ static void asc_prt_driver_conf(struct seq_file *m, struct Scsi_Host *shost)
 		   shost->sg_tablesize, shost->cmd_per_lun);
 
 	seq_printf(m,
-		   " unchecked_isa_dma %d, use_clustering %d\n",
-		   shost->unchecked_isa_dma, shost->use_clustering);
+		   " unchecked_isa_dma %d\n",
+		   shost->unchecked_isa_dma);
 
 	seq_printf(m,
 		   " flags 0x%x, last_reset 0x%lx, jiffies 0x%lx, asc_n_io_port 0x%x\n",
diff --git a/drivers/scsi/aha152x.c b/drivers/scsi/aha152x.c
index 301b3cad15f8..97872838b983 100644
--- a/drivers/scsi/aha152x.c
+++ b/drivers/scsi/aha152x.c
@@ -2920,7 +2920,7 @@ static struct scsi_host_template aha152x_driver_template = {
 	.can_queue			= 1,
 	.this_id			= 7,
 	.sg_tablesize			= SG_ALL,
-	.use_clustering			= DISABLE_CLUSTERING,
+	.dma_boundary			= PAGE_SIZE - 1,
 	.slave_alloc			= aha152x_adjust_queue,
 };
 
diff --git a/drivers/scsi/arm/acornscsi.c b/drivers/scsi/arm/acornscsi.c
index 421fe869a11e..d7509859dc00 100644
--- a/drivers/scsi/arm/acornscsi.c
+++ b/drivers/scsi/arm/acornscsi.c
@@ -2890,7 +2890,7 @@ static struct scsi_host_template acornscsi_template = {
 	.this_id		= 7,
 	.sg_tablesize		= SG_ALL,
 	.cmd_per_lun		= 2,
-	.use_clustering		= DISABLE_CLUSTERING,
+	.dma_boundary		= PAGE_SIZE - 1,
 	.proc_name		= "acornscsi",
 };
 
diff --git a/drivers/scsi/arm/arxescsi.c b/drivers/scsi/arm/arxescsi.c
index 3110736fd337..5e9dd9f34821 100644
--- a/drivers/scsi/arm/arxescsi.c
+++ b/drivers/scsi/arm/arxescsi.c
@@ -245,7 +245,7 @@ static struct scsi_host_template arxescsi_template = {
 	.can_queue			= 0,
 	.this_id			= 7,
 	.sg_tablesize			= SG_ALL,
-	.use_clustering			= DISABLE_CLUSTERING,
+	.dma_boundary			= PAGE_SIZE - 1,
 	.proc_name			= "arxescsi",
 };
 
diff --git a/drivers/scsi/arm/cumana_1.c b/drivers/scsi/arm/cumana_1.c
index ae1d809904fb..e2d2a81d8e0b 100644
--- a/drivers/scsi/arm/cumana_1.c
+++ b/drivers/scsi/arm/cumana_1.c
@@ -221,10 +221,10 @@ static struct scsi_host_template cumanascsi_template = {
 	.this_id		= 7,
 	.sg_tablesize		= SG_ALL,
 	.cmd_per_lun		= 2,
-	.use_clustering		= DISABLE_CLUSTERING,
 	.proc_name		= "CumanaSCSI-1",
 	.cmd_size		= NCR5380_CMD_SIZE,
 	.max_sectors		= 128,
+	.dma_boundary		= PAGE_SIZE - 1,
 };
 
 static int cumanascsi1_probe(struct expansion_card *ec,
diff --git a/drivers/scsi/arm/oak.c b/drivers/scsi/arm/oak.c
index 05b7f755499b..8f2efaab8d46 100644
--- a/drivers/scsi/arm/oak.c
+++ b/drivers/scsi/arm/oak.c
@@ -110,7 +110,7 @@ static struct scsi_host_template oakscsi_template = {
 	.this_id		= 7,
 	.sg_tablesize		= SG_ALL,
 	.cmd_per_lun		= 2,
-	.use_clustering		= DISABLE_CLUSTERING,
+	.dma_boundary		= PAGE_SIZE - 1,
 	.proc_name		= "oakscsi",
 	.cmd_size		= NCR5380_CMD_SIZE,
 	.max_sectors		= 128,
diff --git a/drivers/scsi/atari_scsi.c b/drivers/scsi/atari_scsi.c
index 89f5154c40b6..a503dc50c4f8 100644
--- a/drivers/scsi/atari_scsi.c
+++ b/drivers/scsi/atari_scsi.c
@@ -714,7 +714,7 @@ static struct scsi_host_template atari_scsi_template = {
 	.eh_host_reset_handler	= atari_scsi_host_reset,
 	.this_id		= 7,
 	.cmd_per_lun		= 2,
-	.use_clustering		= DISABLE_CLUSTERING,
+	.dma_boundary		= PAGE_SIZE - 1,
 	.cmd_size		= NCR5380_CMD_SIZE,
 };
 
diff --git a/drivers/scsi/cxgbi/cxgb3i/cxgb3i.c b/drivers/scsi/cxgbi/cxgb3i/cxgb3i.c
index bf07735275a4..8a20411699d9 100644
--- a/drivers/scsi/cxgbi/cxgb3i/cxgb3i.c
+++ b/drivers/scsi/cxgbi/cxgb3i/cxgb3i.c
@@ -95,7 +95,7 @@ static struct scsi_host_template cxgb3i_host_template = {
 	.eh_device_reset_handler = iscsi_eh_device_reset,
 	.eh_target_reset_handler = iscsi_eh_recover_target,
 	.target_alloc	= iscsi_target_alloc,
-	.use_clustering	= DISABLE_CLUSTERING,
+	.dma_boundary	= PAGE_SIZE - 1,
 	.this_id	= -1,
 	.track_queue_depth = 1,
 };
diff --git a/drivers/scsi/cxgbi/cxgb4i/cxgb4i.c b/drivers/scsi/cxgbi/cxgb4i/cxgb4i.c
index 064ef5735182..762337de1116 100644
--- a/drivers/scsi/cxgbi/cxgb4i/cxgb4i.c
+++ b/drivers/scsi/cxgbi/cxgb4i/cxgb4i.c
@@ -113,7 +113,7 @@ static struct scsi_host_template cxgb4i_host_template = {
 	.eh_device_reset_handler = iscsi_eh_device_reset,
 	.eh_target_reset_handler = iscsi_eh_recover_target,
 	.target_alloc	= iscsi_target_alloc,
-	.use_clustering	= DISABLE_CLUSTERING,
+	.dma_boundary	= PAGE_SIZE - 1,
 	.this_id	= -1,
 	.track_queue_depth = 1,
 };
diff --git a/drivers/scsi/dc395x.c b/drivers/scsi/dc395x.c
index 8c55ec6e1827..13fbb2eab842 100644
--- a/drivers/scsi/dc395x.c
+++ b/drivers/scsi/dc395x.c
@@ -4631,7 +4631,7 @@ static struct scsi_host_template dc395x_driver_template = {
 	.cmd_per_lun            = DC395x_MAX_CMD_PER_LUN,
 	.eh_abort_handler       = dc395x_eh_abort,
 	.eh_bus_reset_handler   = dc395x_eh_bus_reset,
-	.use_clustering         = DISABLE_CLUSTERING,
+	.dma_boundary		= PAGE_SIZE - 1,
 };
 
 
diff --git a/drivers/scsi/dmx3191d.c b/drivers/scsi/dmx3191d.c
index 003c3d726238..8db1cc552932 100644
--- a/drivers/scsi/dmx3191d.c
+++ b/drivers/scsi/dmx3191d.c
@@ -63,7 +63,7 @@ static struct scsi_host_template dmx3191d_driver_template = {
 	.this_id		= 7,
 	.sg_tablesize		= SG_ALL,
 	.cmd_per_lun		= 2,
-	.use_clustering		= DISABLE_CLUSTERING,
+	.dma_boundary		= PAGE_SIZE - 1,
 	.cmd_size		= NCR5380_CMD_SIZE,
 };
 
diff --git a/drivers/scsi/g_NCR5380.c b/drivers/scsi/g_NCR5380.c
index fc538181f8df..9cdca0625498 100644
--- a/drivers/scsi/g_NCR5380.c
+++ b/drivers/scsi/g_NCR5380.c
@@ -700,7 +700,7 @@ static struct scsi_host_template driver_template = {
 	.this_id		= 7,
 	.sg_tablesize		= SG_ALL,
 	.cmd_per_lun		= 2,
-	.use_clustering		= DISABLE_CLUSTERING,
+	.dma_boundary		= PAGE_SIZE - 1,
 	.cmd_size		= NCR5380_CMD_SIZE,
 	.max_sectors		= 128,
 };
diff --git a/drivers/scsi/gvp11.c b/drivers/scsi/gvp11.c
index a27fc49ebd3a..d2acd0d826e2 100644
--- a/drivers/scsi/gvp11.c
+++ b/drivers/scsi/gvp11.c
@@ -184,7 +184,7 @@ static struct scsi_host_template gvp11_scsi_template = {
 	.this_id		= 7,
 	.sg_tablesize		= SG_ALL,
 	.cmd_per_lun		= CMD_PER_LUN,
-	.use_clustering		= DISABLE_CLUSTERING
+	.dma_boundary		= PAGE_SIZE - 1,
 };
 
 static int check_wd33c93(struct gvp11_scsiregs *regs)
diff --git a/drivers/scsi/hosts.c b/drivers/scsi/hosts.c
index e8148ba414a3..fce0b5d7119e 100644
--- a/drivers/scsi/hosts.c
+++ b/drivers/scsi/hosts.c
@@ -431,7 +431,6 @@ struct Scsi_Host *scsi_host_alloc(struct scsi_host_template *sht, int privsize)
 	shost->sg_prot_tablesize = sht->sg_prot_tablesize;
 	shost->cmd_per_lun = sht->cmd_per_lun;
 	shost->unchecked_isa_dma = sht->unchecked_isa_dma;
-	shost->use_clustering = sht->use_clustering;
 	shost->no_write_same = sht->no_write_same;
 
 	if (shost_eh_deadline == -1 || !sht->eh_host_reset_handler)
diff --git a/drivers/scsi/ips.c b/drivers/scsi/ips.c
index 067725295083..e8bc8d328bab 100644
--- a/drivers/scsi/ips.c
+++ b/drivers/scsi/ips.c
@@ -6677,7 +6677,6 @@ ips_register_scsi(int index)
 	sh->sg_tablesize = sh->hostt->sg_tablesize;
 	sh->can_queue = sh->hostt->can_queue;
 	sh->cmd_per_lun = sh->hostt->cmd_per_lun;
-	sh->use_clustering = sh->hostt->use_clustering;
 	sh->max_sectors = 128;
 
 	sh->max_id = ha->ntargets;
diff --git a/drivers/scsi/iscsi_tcp.c b/drivers/scsi/iscsi_tcp.c
index 23354f206533..0175684a14dc 100644
--- a/drivers/scsi/iscsi_tcp.c
+++ b/drivers/scsi/iscsi_tcp.c
@@ -980,7 +980,7 @@ static struct scsi_host_template iscsi_sw_tcp_sht = {
 	.eh_abort_handler       = iscsi_eh_abort,
 	.eh_device_reset_handler= iscsi_eh_device_reset,
 	.eh_target_reset_handler = iscsi_eh_recover_target,
-	.use_clustering         = DISABLE_CLUSTERING,
+	.dma_boundary		= PAGE_SIZE - 1,
 	.slave_alloc            = iscsi_sw_tcp_slave_alloc,
 	.slave_configure        = iscsi_sw_tcp_slave_configure,
 	.target_alloc		= iscsi_target_alloc,
diff --git a/drivers/scsi/mac_esp.c b/drivers/scsi/mac_esp.c
index 764d320bb2ca..ee741207fd4e 100644
--- a/drivers/scsi/mac_esp.c
+++ b/drivers/scsi/mac_esp.c
@@ -307,7 +307,7 @@ static int esp_mac_probe(struct platform_device *dev)
 		goto fail;
 
 	host->max_id = 8;
-	host->use_clustering = DISABLE_CLUSTERING;
+	host->dma_boundary = PAGE_SIZE - 1;
 	esp = shost_priv(host);
 
 	esp->host = host;
diff --git a/drivers/scsi/mac_scsi.c b/drivers/scsi/mac_scsi.c
index dd6057359d7c..8b4b5b1a13d7 100644
--- a/drivers/scsi/mac_scsi.c
+++ b/drivers/scsi/mac_scsi.c
@@ -333,7 +333,7 @@ static struct scsi_host_template mac_scsi_template = {
 	.this_id		= 7,
 	.sg_tablesize		= 1,
 	.cmd_per_lun		= 2,
-	.use_clustering		= DISABLE_CLUSTERING,
+	.dma_boundary		= PAGE_SIZE - 1,
 	.cmd_size		= NCR5380_CMD_SIZE,
 	.max_sectors		= 128,
 };
diff --git a/drivers/scsi/mvumi.c b/drivers/scsi/mvumi.c
index d0c3f867fc58..dbe753fba486 100644
--- a/drivers/scsi/mvumi.c
+++ b/drivers/scsi/mvumi.c
@@ -2197,7 +2197,7 @@ static struct scsi_host_template mvumi_template = {
 	.eh_timed_out = mvumi_timed_out,
 	.eh_host_reset_handler = mvumi_host_reset,
 	.bios_param = mvumi_bios_param,
-	.use_clustering = DISABLE_CLUSTERING,
+	.dma_boundary = PAGE_SIZE - 1,
 	.this_id = -1,
 };
 
diff --git a/drivers/scsi/nsp32.c b/drivers/scsi/nsp32.c
index 5aac3e801903..00e3cbee55b8 100644
--- a/drivers/scsi/nsp32.c
+++ b/drivers/scsi/nsp32.c
@@ -274,7 +274,7 @@ static struct scsi_host_template nsp32_template = {
 	.sg_tablesize			= NSP32_SG_SIZE,
 	.max_sectors			= 128,
 	.this_id			= NSP32_HOST_SCSIID,
-	.use_clustering			= DISABLE_CLUSTERING,
+	.dma_boundary			= PAGE_SIZE - 1,
 	.eh_abort_handler		= nsp32_eh_abort,
 	.eh_host_reset_handler		= nsp32_eh_host_reset,
 /*	.highmem_io			= 1, */
diff --git a/drivers/scsi/pcmcia/nsp_cs.c b/drivers/scsi/pcmcia/nsp_cs.c
index f3230494a8c9..1bd6825a4f14 100644
--- a/drivers/scsi/pcmcia/nsp_cs.c
+++ b/drivers/scsi/pcmcia/nsp_cs.c
@@ -86,7 +86,7 @@ static struct scsi_host_template nsp_driver_template = {
 	.can_queue		 = 1,
 	.this_id		 = NSP_INITIATOR_ID,
 	.sg_tablesize		 = SG_ALL,
-	.use_clustering		 = DISABLE_CLUSTERING,
+	.dma_boundary		 = PAGE_SIZE - 1,
 };
 
 static nsp_hw_data nsp_data_base; /* attach <-> detect glue */
diff --git a/drivers/scsi/pcmcia/qlogic_stub.c b/drivers/scsi/pcmcia/qlogic_stub.c
index 173351a8554b..828d53faf09a 100644
--- a/drivers/scsi/pcmcia/qlogic_stub.c
+++ b/drivers/scsi/pcmcia/qlogic_stub.c
@@ -72,7 +72,7 @@ static struct scsi_host_template qlogicfas_driver_template = {
 	.can_queue		= 1,
 	.this_id		= -1,
 	.sg_tablesize		= SG_ALL,
-	.use_clustering		= DISABLE_CLUSTERING,
+	.dma_boundary		= PAGE_SIZE - 1,
 };
 
 /*====================================================================*/
diff --git a/drivers/scsi/qlogicfas.c b/drivers/scsi/qlogicfas.c
index 95431d605c24..8f709002f746 100644
--- a/drivers/scsi/qlogicfas.c
+++ b/drivers/scsi/qlogicfas.c
@@ -193,7 +193,7 @@ static struct scsi_host_template qlogicfas_driver_template = {
 	.can_queue		= 1,
 	.this_id		= -1,
 	.sg_tablesize		= SG_ALL,
-	.use_clustering		= DISABLE_CLUSTERING,
+	.dma_boundary		= PAGE_SIZE - 1,
 };
 
 static __init int qlogicfas_init(void)
diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 57d418d7d74e..16cab45c0439 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -5866,7 +5866,8 @@ static int sdebug_driver_probe(struct device *dev)
 
 	sdebug_driver_template.can_queue = sdebug_max_queue;
 	if (!sdebug_clustering)
-		sdebug_driver_template.use_clustering = DISABLE_CLUSTERING;
+		sdebug_driver_template.dma_boundary = PAGE_SIZE - 1;
+
 	hpnt = scsi_host_alloc(&sdebug_driver_template, sizeof(sdbg_host));
 	if (NULL == hpnt) {
 		pr_err("scsi_host_alloc failed\n");
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 2d4fd6b4bd92..966b7cfebdf8 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -2230,9 +2230,6 @@ void __scsi_init_queue(struct Scsi_Host *shost, struct request_queue *q)
 	blk_queue_max_segment_size(q,
 		min(shost->max_segment_size, dma_get_max_seg_size(dev)));
 
-	if (shost->use_clustering == DISABLE_CLUSTERING)
-		q->limits.cluster = 0;
-
 	/*
 	 * Set a reasonable default alignment:  The larger of 32-byte (dword),
 	 * which is a common minimum for HBAs, and the minimum DMA alignment,
diff --git a/drivers/scsi/sgiwd93.c b/drivers/scsi/sgiwd93.c
index 5ed696dc9bbd..713bce998b0e 100644
--- a/drivers/scsi/sgiwd93.c
+++ b/drivers/scsi/sgiwd93.c
@@ -208,7 +208,7 @@ static struct scsi_host_template sgiwd93_template = {
 	.this_id		= 7,
 	.sg_tablesize		= SG_ALL,
 	.cmd_per_lun		= 8,
-	.use_clustering		= DISABLE_CLUSTERING,
+	.dma_boundary		= PAGE_SIZE - 1,
 };
 
 static int sgiwd93_probe(struct platform_device *pdev)
diff --git a/drivers/scsi/stex.c b/drivers/scsi/stex.c
index af9078320d4b..f6bef7ad65e7 100644
--- a/drivers/scsi/stex.c
+++ b/drivers/scsi/stex.c
@@ -1489,7 +1489,7 @@ static struct scsi_host_template driver_template = {
 	.eh_abort_handler		= stex_abort,
 	.eh_host_reset_handler		= stex_reset,
 	.this_id			= -1,
-	.use_clustering			= DISABLE_CLUSTERING,
+	.dma_boundary			= PAGE_SIZE - 1,
 };
 
 static struct pci_device_id stex_pci_tbl[] = {
diff --git a/drivers/scsi/sun3_scsi.c b/drivers/scsi/sun3_scsi.c
index 9492638296c8..95a7ea7eefa0 100644
--- a/drivers/scsi/sun3_scsi.c
+++ b/drivers/scsi/sun3_scsi.c
@@ -500,7 +500,7 @@ static struct scsi_host_template sun3_scsi_template = {
 	.this_id		= 7,
 	.sg_tablesize		= SG_NONE,
 	.cmd_per_lun		= 2,
-	.use_clustering		= DISABLE_CLUSTERING,
+	.dma_boundary		= PAGE_SIZE - 1,
 	.cmd_size		= NCR5380_CMD_SIZE,
 };
 
diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index e5800da0053d..34be397da0f3 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -6982,7 +6982,7 @@ static struct scsi_host_template ufshcd_driver_template = {
 	.max_host_blocked	= 1,
 	.track_queue_depth	= 1,
 	.sdev_groups		= ufshcd_driver_groups,
-	.use_clustering		= DISABLE_CLUSTERING,
+	.dma_boundary		= PAGE_SIZE - 1,
 };
 
 static int ufshcd_config_vreg_load(struct device *dev, struct ufs_vreg *vreg,
diff --git a/drivers/target/loopback/tcm_loop.c b/drivers/target/loopback/tcm_loop.c
index b0991e86587f..7bd7c0c0db6f 100644
--- a/drivers/target/loopback/tcm_loop.c
+++ b/drivers/target/loopback/tcm_loop.c
@@ -324,7 +324,7 @@ static struct scsi_host_template tcm_loop_driver_template = {
 	.sg_tablesize		= 256,
 	.cmd_per_lun		= 1024,
 	.max_sectors		= 0xFFFF,
-	.use_clustering		= DISABLE_CLUSTERING,
+	.dma_boundary		= PAGE_SIZE - 1,
 	.slave_alloc		= tcm_loop_slave_alloc,
 	.module			= THIS_MODULE,
 	.track_queue_depth	= 1,
diff --git a/drivers/usb/storage/uas.c b/drivers/usb/storage/uas.c
index 6c75a0a50b3a..36742e8e7edc 100644
--- a/drivers/usb/storage/uas.c
+++ b/drivers/usb/storage/uas.c
@@ -879,7 +879,7 @@ static struct scsi_host_template uas_host_template = {
 	.this_id = -1,
 	.sg_tablesize = SG_NONE,
 	.skip_settle_delay = 1,
-	.use_clustering = DISABLE_CLUSTERING,
+	.dma_boundary = PAGE_SIZE - 1,
 };
 
 #define UNUSUAL_DEV(id_vendor, id_product, bcdDeviceMin, bcdDeviceMax, \
diff --git a/include/scsi/scsi_host.h b/include/scsi/scsi_host.h
index 834204681ca3..7ba34a0ca8bf 100644
--- a/include/scsi/scsi_host.h
+++ b/include/scsi/scsi_host.h
@@ -44,8 +44,6 @@ struct blk_queue_tags;
 #define MODE_INITIATOR 0x01
 #define MODE_TARGET 0x02
 
-#define DISABLE_CLUSTERING (-1)
-
 struct scsi_host_template {
 	struct module *module;
 	const char *name;
@@ -418,16 +416,6 @@ struct scsi_host_template {
 	 */
 	unsigned unchecked_isa_dma:1;
 
-	/*
-	 * True if this host adapter can make good use of clustering.
-	 * I originally thought that if the tablesize was large that it
-	 * was a waste of CPU cycles to prepare a cluster list, but
-	 * it works out that the Buslogic is faster if you use a smaller
-	 * number of segments (i.e. use clustering).  I guess it is
-	 * inefficient.
-	 */
-	unsigned use_clustering:1;
-
 	/*
 	 * True for emulated SCSI host adapters (e.g. ATAPI).
 	 */
@@ -626,7 +614,6 @@ struct Scsi_Host {
 	
 	unsigned active_mode:2;
 	unsigned unchecked_isa_dma:1;
-	unsigned use_clustering:1;
 
 	/*
 	 * Host has requested that no further requests come through for the
-- 
2.19.2

