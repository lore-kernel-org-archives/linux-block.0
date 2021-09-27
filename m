Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4AE7C433FE
	for <linux-block@archiver.kernel.org>; Mon, 27 Sep 2021 22:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAD43610A2
	for <linux-block@archiver.kernel.org>; Mon, 27 Sep 2021 22:03:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237734AbhI0WFd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Sep 2021 18:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237905AbhI0WFR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Sep 2021 18:05:17 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9EF1C061220;
        Mon, 27 Sep 2021 15:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=04BFNx7N8AagL+vNhaEBLuBBGegCSEgU71z7cal6rBA=; b=ulIkgBxHvBiQPfiUzfBI73LVBB
        tW59nC5MN+TmeDI4ba+dl+lIQkDPOLoSj6w3ZK3ZsWzUG8tB8LthixGIbsVGw+VAGaFbMtE8wAth4
        voe8HQcNuSsilGYW4qElhG7Avo7eMwxXBYrCIZ8kJOiBuzgJngqL4VD0/Cv67MMwhVl2gM3G7mmR8
        MZDmvJ25I5BXolyWjBeUc91YDXHsMA6SUsE7GkGQfBGa4dH0BbTVtf5+nA8phVFWnCd/Q+XeAFWTF
        Tt++kWvg/B4MLwzCqzz9STtEOx95LWDDVVS4eg50ToKZEL+sBZdi30PQPTEcEe44ydNvEv/zVSCcG
        808OVHTw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mUyhC-004UJj-Lk; Mon, 27 Sep 2021 22:01:58 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk, bhelgaas@google.com, liushixin2@huawei.com,
        thunder.leizhen@huawei.com, lee.jones@linaro.org,
        geoff@infradead.org, mpe@ellerman.id.au, benh@kernel.crashing.org,
        paulus@samba.org, jim@jtan.com, haris.iqbal@ionos.com,
        jinpu.wang@ionos.com, josh.h.morris@us.ibm.com,
        pjk1939@linux.ibm.com, tim@cyberelk.net, richard@nod.at,
        miquel.raynal@bootlin.com, vigneshr@ti.com
Cc:     linux-mtd@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v2 08/10] block/sx8: add error handling support for add_disk()
Date:   Mon, 27 Sep 2021 15:01:55 -0700
Message-Id: <20210927220157.1069658-9-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210927220157.1069658-1-mcgrof@kernel.org>
References: <20210927220157.1069658-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
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
 drivers/block/sx8.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/block/sx8.c b/drivers/block/sx8.c
index 420cd952ddc4..1c79248c4826 100644
--- a/drivers/block/sx8.c
+++ b/drivers/block/sx8.c
@@ -297,6 +297,7 @@ struct carm_host {
 
 	struct work_struct		fsm_task;
 
+	int probe_err;
 	struct completion		probe_comp;
 };
 
@@ -1181,8 +1182,11 @@ static void carm_fsm_task (struct work_struct *work)
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
@@ -1192,11 +1196,9 @@ static void carm_fsm_task (struct work_struct *work)
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
@@ -1507,7 +1509,10 @@ static int carm_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto err_out_free_irq;
 
 	DPRINTK("waiting for probe_comp\n");
+	host->probe_err = -ENODEV;
 	wait_for_completion(&host->probe_comp);
+	if (host->probe_err)
+		goto err_out_free_irq;
 
 	printk(KERN_INFO "%s: pci %s, ports %d, io %llx, irq %u, major %d\n",
 	       host->name, pci_name(pdev), (int) CARM_MAX_PORTS,
-- 
2.30.2

