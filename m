Return-Path: <SRS0=D8nw=PQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDF1FC43387
	for <linux-block@archiver.kernel.org>; Tue,  8 Jan 2019 20:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C26542070B
	for <linux-block@archiver.kernel.org>; Tue,  8 Jan 2019 20:50:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729386AbfAHUu5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Jan 2019 15:50:57 -0500
Received: from ale.deltatee.com ([207.54.116.67]:51906 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728766AbfAHUu4 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 8 Jan 2019 15:50:56 -0500
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1ggyKp-0004i8-Sa; Tue, 08 Jan 2019 13:50:53 -0700
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1ggyKm-0000p5-Uj; Tue, 08 Jan 2019 13:50:48 -0700
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        Intel SCU Linux support <intel-linux-scu@intel.com>,
        Artur Paszkiewicz <artur.paszkiewicz@intel.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Jeff Moyer <jmoyer@redhat.com>
Date:   Tue,  8 Jan 2019 13:50:43 -0700
Message-Id: <20190108205043.3122-1-logang@deltatee.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-scsi@vger.kernel.org, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, logang@deltatee.com, intel-linux-scu@intel.com, artur.paszkiewicz@intel.com, jejb@linux.ibm.com, martin.petersen@oracle.com, hch@lst.de, axboe@kernel.dk, jmoyer@redhat.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH] scsi: isci: initialize shost fully before calling scsi_add_host()
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

scsi_mq_setup_tags(), which is called by scsi_add_host(), calculates
the command size to allocate based on the prot_capabilities. In the
isci driver, scsi_host_set_prot() is called after scsi_add_host()
so the command size gets calculated to be smaller than it needs to be.
Eventually, scsi_mq_init_request() locates the 'prot_sdb' after the command
assuming it was sized correctly and a buffer overrun may occur.

However, seeing blk_mq_alloc_rqs() rounds up to the nearest cache line
size, the mistake can go unnoticed.

The bug was noticed after the struct request size was reduced by
commit 9d037ad707ed ("block: remove req->timeout_list")

Which likely reduced the allocated space for the request by an entire
cache line, enough that the overflow could be hit and it caused a panic,
on boot, at:

  RIP: 0010:t10_pi_complete+0x77/0x1c0
  Call Trace:
    <IRQ>
    sd_done+0xf5/0x340
    scsi_finish_command+0xc3/0x120
    blk_done_softirq+0x83/0xb0
    __do_softirq+0xa1/0x2e6
    irq_exit+0xbc/0xd0
    call_function_single_interrupt+0xf/0x20
    </IRQ>

sd_done() would call scsi_prot_sg_count() which reads the number of
entities in 'prot_sdb', but seeing 'prot_sdb' is located after the end of
the allocated space it reads a garbage number and erroneously calls
t10_pi_complete().

To prevent this, the calls to scsi_host_set_prot() are moved into
isci_host_alloc() before the call to scsi_add_host(). Out of caution,
also move the similar call to scsi_host_set_guard().

Fixes: 3d2d75254915 ("[SCSI] isci: T10 DIF support")
Link: http://lkml.kernel.org/r/da851333-eadd-163a-8c78-e1f4ec5ec857@deltatee.com
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Cc: Intel SCU Linux support <intel-linux-scu@intel.com>
Cc: Artur Paszkiewicz <artur.paszkiewicz@intel.com>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Jeff Moyer <jmoyer@redhat.com>
---
 drivers/scsi/isci/init.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/scsi/isci/init.c b/drivers/scsi/isci/init.c
index 68b90c4f79a3..1727d0c71b12 100644
--- a/drivers/scsi/isci/init.c
+++ b/drivers/scsi/isci/init.c
@@ -576,6 +576,13 @@ static struct isci_host *isci_host_alloc(struct pci_dev *pdev, int id)
 	shost->max_lun = ~0;
 	shost->max_cmd_len = MAX_COMMAND_SIZE;
 
+	/* turn on DIF support */
+	scsi_host_set_prot(shost,
+			   SHOST_DIF_TYPE1_PROTECTION |
+			   SHOST_DIF_TYPE2_PROTECTION |
+			   SHOST_DIF_TYPE3_PROTECTION);
+	scsi_host_set_guard(shost, SHOST_DIX_GUARD_CRC);
+
 	err = scsi_add_host(shost, &pdev->dev);
 	if (err)
 		goto err_shost;
@@ -663,13 +670,6 @@ static int isci_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 			goto err_host_alloc;
 		}
 		pci_info->hosts[i] = h;
-
-		/* turn on DIF support */
-		scsi_host_set_prot(to_shost(h),
-				   SHOST_DIF_TYPE1_PROTECTION |
-				   SHOST_DIF_TYPE2_PROTECTION |
-				   SHOST_DIF_TYPE3_PROTECTION);
-		scsi_host_set_guard(to_shost(h), SHOST_DIX_GUARD_CRC);
 	}
 
 	err = isci_setup_interrupts(pdev);
-- 
2.19.0

