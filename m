Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE97FC636C9
	for <linux-block@archiver.kernel.org>; Thu, 15 Jul 2021 20:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5C4F613D4
	for <linux-block@archiver.kernel.org>; Thu, 15 Jul 2021 20:30:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235059AbhGOUdg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Jul 2021 16:33:36 -0400
Received: from mail-pf1-f172.google.com ([209.85.210.172]:39891 "EHLO
        mail-pf1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232418AbhGOUdf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Jul 2021 16:33:35 -0400
Received: by mail-pf1-f172.google.com with SMTP id b12so6631334pfv.6;
        Thu, 15 Jul 2021 13:30:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m6aGqo/4LoEvB6VK2Me4DE4EY0pXu1Ka4Io47Q+9STw=;
        b=mudBnqKZIKURj1FzngUW4UdIsbTQeuqKzvNnrYEZ/B9FIPcANGBrlldNYV9ROtUc4g
         MPUw4dErJMphcGpFJFBp+ZyK5G+xYlrdi3X0EfIaeviqlJu6k0g94MOYjjY0i9O/cZ7E
         zcya+ykpAbLVy8wTETtPHgyX4Ox8E1n/WxKzpif10glK9TOpX1RATS30+yAcmg/+1Kwt
         om4fkXF3v0Gc0UqFA43TZC/0syg8SRHtaaqBohC46wWuVzamM5QgaJdptZYVNt9D7mwU
         mNWO+v9c3ZUjiX+VLzlvvFCq7dPcEM2/p8i2GyomDX9VnqJbDSnL3jHF9BYRM43mOf0W
         Z6Jg==
X-Gm-Message-State: AOAM533L9Zh2RPx29T4izWgcFMkrO9kxPFG0qqevAiHCsw6Sx/uVYq3r
        2ZXJAjNqFepugebSQRrM5zw=
X-Google-Smtp-Source: ABdhPJxTu1u2WFOL5qZ0r1fXhYI/Qfz97b5CFS2lVSuTSQyw0zxv0gWLf5I3MVY5IM58AkzR6c+Gtw==
X-Received: by 2002:a63:494d:: with SMTP id y13mr6474195pgk.248.1626381040676;
        Thu, 15 Jul 2021 13:30:40 -0700 (PDT)
Received: from localhost ([191.96.120.37])
        by smtp.gmail.com with ESMTPSA id y9sm6774604pfa.197.2021.07.15.13.30.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jul 2021 13:30:39 -0700 (PDT)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk
Cc:     hare@suse.de, bvanassche@acm.org, ming.lei@redhat.com,
        hch@infradead.org, jack@suse.cz, osandov@fb.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [RFC 4/5] block/sx8: add helper carm_free_all_disks()
Date:   Thu, 15 Jul 2021 13:30:24 -0700
Message-Id: <20210715203025.2018218-5-mcgrof@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210715203025.2018218-1-mcgrof@kernel.org>
References: <20210715203025.2018218-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Share the code of unregistering disks in a common helper.
Code is shifted a above so that we can later re-use this
helper in other places.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/block/sx8.c | 42 +++++++++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 19 deletions(-)

diff --git a/drivers/block/sx8.c b/drivers/block/sx8.c
index e4dfee5acf08..6a6dc3fffa5c 100644
--- a/drivers/block/sx8.c
+++ b/drivers/block/sx8.c
@@ -1092,6 +1092,27 @@ static irqreturn_t carm_interrupt(int irq, void *__host)
 	return IRQ_RETVAL(handled);
 }
 
+static void carm_free_disk(struct carm_host *host, unsigned int port_no)
+{
+	struct carm_port *port = &host->port[port_no];
+	struct gendisk *disk = port->disk;
+
+	if (!disk)
+		return;
+
+	del_gendisk(disk);
+	blk_cleanup_disk(disk);
+}
+
+static void carm_free_all_disks(struct carm_host *host)
+{
+	unsigned int i;
+
+	for (i = 0; i < CARM_MAX_PORTS; i++)
+		carm_free_disk(host, i);
+	unregister_blkdev(host->major, host->name);
+}
+
 static void carm_fsm_task (struct work_struct *work)
 {
 	struct carm_host *host =
@@ -1365,18 +1386,6 @@ static int carm_init_disk(struct carm_host *host, unsigned int port_no)
 	return 0;
 }
 
-static void carm_free_disk(struct carm_host *host, unsigned int port_no)
-{
-	struct carm_port *port = &host->port[port_no];
-	struct gendisk *disk = port->disk;
-
-	if (!disk)
-		return;
-
-	del_gendisk(disk);
-	blk_cleanup_disk(disk);
-}
-
 static int carm_init_shm(struct carm_host *host)
 {
 	host->shm = dma_alloc_coherent(&host->pdev->dev, CARM_SHM_SIZE,
@@ -1520,9 +1529,7 @@ static int carm_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 err_out_free_irq:
 	free_irq(pdev->irq, host);
 err_out_blkdev_disks:
-	for (i = 0; i < CARM_MAX_PORTS; i++)
-		carm_free_disk(host, i);
-	unregister_blkdev(host->major, host->name);
+	carm_free_all_disks(host);
 err_out_free_majors:
 	if (host->major == 160)
 		clear_bit(0, &carm_major_alloc);
@@ -1546,7 +1553,6 @@ static int carm_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 static void carm_remove_one (struct pci_dev *pdev)
 {
 	struct carm_host *host = pci_get_drvdata(pdev);
-	unsigned int i;
 
 	if (!host) {
 		printk(KERN_ERR PFX "BUG: no host data for PCI(%s)\n",
@@ -1555,9 +1561,7 @@ static void carm_remove_one (struct pci_dev *pdev)
 	}
 
 	free_irq(pdev->irq, host);
-	for (i = 0; i < CARM_MAX_PORTS; i++)
-		carm_free_disk(host, i);
-	unregister_blkdev(host->major, host->name);
+	carm_free_all_disks(host);
 	if (host->major == 160)
 		clear_bit(0, &carm_major_alloc);
 	else if (host->major == 161)
-- 
2.27.0

