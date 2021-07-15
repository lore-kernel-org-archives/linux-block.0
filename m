Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DEB2C636CB
	for <linux-block@archiver.kernel.org>; Thu, 15 Jul 2021 20:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF4DF613D2
	for <linux-block@archiver.kernel.org>; Thu, 15 Jul 2021 20:30:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233213AbhGOUdi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Jul 2021 16:33:38 -0400
Received: from mail-pg1-f174.google.com ([209.85.215.174]:46770 "EHLO
        mail-pg1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235562AbhGOUdg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Jul 2021 16:33:36 -0400
Received: by mail-pg1-f174.google.com with SMTP id w15so7680535pgk.13;
        Thu, 15 Jul 2021 13:30:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AfqEur0D3iK3wyEW51FZ1fhyTp8fBt0DR6t9c5iQRFU=;
        b=LJTI+yPMYraA7gtyGtl01g2cptfLkGFKeTSHj9npWGA7OH+LR58+7XjnVQqIRiIun4
         OYqmm8nvCpdBnBpR1sbrOkb8t7MlQpSwSJ7zNQpus+qUbGW3gX4Y59yZ2jZecyNvlUJP
         xQANE89GvjQRiGfKTdygdej0tTAuVRkteQyErmkS1U6n9bLzJGxaqEnmpkCV51apk2dT
         dlSHRgcT6XK2iVaROnvReibsahWpibfV1nuh7jwktUwqny779HfB2PN+STD/KmjNttwt
         5tJBzIBbfWRoS+SgXLr9i0f+T/m3o9iKjCoJvdSFp4HMC/6pGxZLBWxvcyY5d6n75MlU
         3yuw==
X-Gm-Message-State: AOAM530p1x84YNbJOVFGZqf6b6rw6BkpQjiz7TyCU7fcG38TvEvg3RtF
        kQvGOLJh/UqYppTKUNfM1XI=
X-Google-Smtp-Source: ABdhPJzLLk9/HVBihINhuBBcs6/6TX0zKV3W5XGbbD/4A0NdvuGBJ+D6kaoExAX9KjjzyvAm94yIgg==
X-Received: by 2002:a62:7c16:0:b029:329:8d4c:d12d with SMTP id x22-20020a627c160000b02903298d4cd12dmr6510253pfc.47.1626381042892;
        Thu, 15 Jul 2021 13:30:42 -0700 (PDT)
Received: from localhost ([191.96.120.37])
        by smtp.gmail.com with ESMTPSA id a22sm7476719pfv.113.2021.07.15.13.30.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jul 2021 13:30:42 -0700 (PDT)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk
Cc:     hare@suse.de, bvanassche@acm.org, ming.lei@redhat.com,
        hch@infradead.org, jack@suse.cz, osandov@fb.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [RFC 5/5] block/sx8: add error handling support for add_disk()
Date:   Thu, 15 Jul 2021 13:30:25 -0700
Message-Id: <20210715203025.2018218-6-mcgrof@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210715203025.2018218-1-mcgrof@kernel.org>
References: <20210715203025.2018218-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We never checked for errors on add_disk() as this function
returned void. Now that this is fixed, use the shiny new
error handling.

A completion is used to notify the initial probe what is
happening and so we must defer error handling on completion.
Do this by remembering the error and using the shared cleanup
function.

The tags are shared and so are hanlded later for the
driver already.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/block/sx8.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/block/sx8.c b/drivers/block/sx8.c
index 6a6dc3fffa5c..34bbd033e2fd 100644
--- a/drivers/block/sx8.c
+++ b/drivers/block/sx8.c
@@ -297,6 +297,7 @@ struct carm_host {
 
 	struct work_struct		fsm_task;
 
+	int probe_err;
 	struct completion		probe_comp;
 };
 
@@ -1202,8 +1203,11 @@ static void carm_fsm_task (struct work_struct *work)
 				struct gendisk *disk = port->disk;
 
 				set_capacity(disk, port->capacity);
-				add_disk(disk);
-				activated++;
+				host->probe_err = add_disk(disk);
+				if (!host->probe_err)
+					activated++;
+				else
+					break;
 			}
 
 		printk(KERN_INFO DRV_NAME "(%s): %d ports activated\n",
@@ -1213,11 +1217,9 @@ static void carm_fsm_task (struct work_struct *work)
 		reschedule = 1;
 		break;
 	}
-
 	case HST_PROBE_FINISHED:
 		complete(&host->probe_comp);
 		break;
-
 	case HST_ERROR:
 		/* FIXME: TODO */
 		break;
@@ -1515,7 +1517,10 @@ static int carm_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto err_out_free_irq;
 
 	DPRINTK("waiting for probe_comp\n");
+	host->probe_err = -ENODEV;
 	wait_for_completion(&host->probe_comp);
+	if (host->probe_err)
+		goto err_out_disks;
 
 	printk(KERN_INFO "%s: pci %s, ports %d, io %llx, irq %u, major %d\n",
 	       host->name, pci_name(pdev), (int) CARM_MAX_PORTS,
@@ -1526,6 +1531,8 @@ static int carm_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 	pci_set_drvdata(pdev, host);
 	return 0;
 
+err_out_disks:
+	carm_free_all_disks(host);
 err_out_free_irq:
 	free_irq(pdev->irq, host);
 err_out_blkdev_disks:
-- 
2.27.0

