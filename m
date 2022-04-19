Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C486BC43217
	for <linux-block@archiver.kernel.org>; Tue, 19 Apr 2022 11:00:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350816AbiDSLD1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Apr 2022 07:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242912AbiDSLD0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Apr 2022 07:03:26 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE4C1BE91
        for <linux-block@vger.kernel.org>; Tue, 19 Apr 2022 04:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1650366043; x=1681902043;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+oJaf88d92qpqzFJriWCkzPVYda+45p1JlUw5So5umk=;
  b=WkAUo3tDmS54QELhEFXhpz37tsFvFYOCLs3xgb6veWEBaD5ovlFTQ78c
   CLi+5E4LXAiFq3JnmKaDpXIkF3rkcksRunGe1y89ZXe37sFar/LqoCnHe
   7epGK9O7TG152+h9m5DoUvJ3SGuy+TVxs8N7I3oiOd6CM8KRZv7chIWE7
   rXci2WSzk7IL/v+nihxygIrJBxLvx9AkGlo0YxcJWifc+G5T49AcziJSW
   3TQKT+DQtIX95smEwLO4ybKVYHdmIe+XoH+KemRZUMxlvR/tECpAL9zYs
   GynTUkoflJ1PZ+nN7VBnn5Z5eVP74s4+fb+RnmvemnPJrKYgnNqnFcerw
   w==;
X-IronPort-AV: E=Sophos;i="5.90,272,1643644800"; 
   d="scan'208";a="198252960"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Apr 2022 19:00:42 +0800
IronPort-SDR: uDkDOkSRvzuSfbfSQCylHSfQ0rzv/3mtMiUH043KsnryWG7ZUNT1sAMVWmjkdRkcb+ocH/loFU
 IlzVY2o5MGIpy8IJ5z0D3vL1+13kwB9g/lPxb+eIZgAA5v1ROQABWq2VT3879j4AU/k78NXkol
 +kiVFAU/jg5tbjDre3/w+/ML6GPfUOUMurOp8a+rn1i6kzrDXT51dcYo1n35A+ksZemQx+0Ohu
 l5ePjoHWonmNXt7FbK05zEV5/Fl5Xh7UN7kN5Q0TbqW7Mr98HwpE+p3GYXj3u45bpgrLNeiCkO
 a8HRES7kpEAbLVsyhqpfFtqs
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Apr 2022 03:31:49 -0700
IronPort-SDR: k9cPENHuPp19VTHpholr6/e/GInt0lpq/vs4sGOFEozZ6DEeTwIYxEQyLwuYVwZyIrJ3r6eEO8
 tkc5D5p1b956Dfl7jzlnNcVhC7DJBUNfb30r19o4vSb57ou6jNnW2Kclx6B/BMVVcbzG25u5wA
 GJEIF24cDymwwR+xvJCzi8EqtQ5CtUFRzh8Wd5d5P/rB5RsC1VAnznKaw7vhUl1le7ar9EGIoq
 s+eFG9j4Pm7QK5yRIvCFQUVK9Q42WLlyenR298L63D9QUirKG4bVoJHlh0HFRyxKHE93z3J8bk
 AQ0=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Apr 2022 04:00:45 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KjLSW6Vgwz1SVp0
        for <linux-block@vger.kernel.org>; Tue, 19 Apr 2022 04:00:43 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1650366043; x=1652958044; bh=+oJaf88d92qpqzFJri
        WCkzPVYda+45p1JlUw5So5umk=; b=d0jDMqvzd0kQnOCPtF9qSPpnoPtGuiN8k0
        pZ21Qr4IjdI+I9S1Ft1zp1tS/cx13JcSGif0ne7a8/xY997yjQgW2mzghu2KjMUK
        AWS0NLQX1tsvj0QR1LpgLu0FHgvW9VSHwRsJZBy7a2HSxLjwimKq247OR3BJ14QM
        FWGHsda2Fi2qIKZJSVhdrJohoxgssoAnFi7/EbyDDTiENFtojvyMnTtItmWsvOey
        KIZXiMf07w82mCq0WPMLwF3VKK0dNOqOzKzEt2XrD2Ce7y5dURBwmkwbQ2uOMsFA
        ImeAmZFtLdclAUH6ssHF7qWEwyqkWAVezTMcxE0iAVrrnNZGoNIg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id nLe6i39wIwwI for <linux-block@vger.kernel.org>;
        Tue, 19 Apr 2022 04:00:43 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KjLSV4y0bz1Rwrw;
        Tue, 19 Apr 2022 04:00:42 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH 3/4] block: null_blk: Cleanup messages
Date:   Tue, 19 Apr 2022 20:00:37 +0900
Message-Id: <20220419110038.3728406-4-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220419110038.3728406-1-damien.lemoal@opensource.wdc.com>
References: <20220419110038.3728406-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Prefix all null_blk pr_xxx() messages with "null_blk:" to clarify which
module is printing the messages. Also add a pr_info() message in
null_add_dev() to print the name of a newly created disk.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/block/null_blk/main.c  | 29 ++++++++++++++++-------------
 drivers/block/null_blk/zoned.c | 14 +++++++-------
 2 files changed, 23 insertions(+), 20 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.=
c
index 4d6bc94086da..96b6eb4ca60a 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1521,7 +1521,7 @@ static int null_map_queues(struct blk_mq_tag_set *s=
et)
 			submit_queues =3D dev->prev_submit_queues;
 			poll_queues =3D dev->prev_poll_queues;
 		} else {
-			pr_warn("tag set has unexpected nr_hw_queues: %d\n",
+			pr_warn("null_blk: tag set has unexpected nr_hw_queues: %d\n",
 				set->nr_hw_queues);
 			return -EINVAL;
 		}
@@ -1582,7 +1582,7 @@ static enum blk_eh_timer_return null_timeout_rq(str=
uct request *rq, bool res)
 	struct blk_mq_hw_ctx *hctx =3D rq->mq_hctx;
 	struct nullb_cmd *cmd =3D blk_mq_rq_to_pdu(rq);
=20
-	pr_info("rq %p timed out\n", rq);
+	pr_info("null_blk: rq %p timed out\n", rq);
=20
 	if (hctx->type =3D=3D HCTX_TYPE_POLL) {
 		struct nullb_queue *nq =3D hctx->driver_data;
@@ -1754,13 +1754,13 @@ static void null_config_discard(struct nullb *nul=
lb)
=20
 	if (!nullb->dev->memory_backed) {
 		nullb->dev->discard =3D false;
-		pr_info("discard option is ignored without memory backing\n");
+		pr_info("null_blk: discard option is ignored without memory backing\n"=
);
 		return;
 	}
=20
 	if (nullb->dev->zoned) {
 		nullb->dev->discard =3D false;
-		pr_info("discard option is ignored in zoned mode\n");
+		pr_info("null_blk: discard option is ignored in zoned mode\n");
 		return;
 	}
=20
@@ -1932,7 +1932,7 @@ static int null_validate_conf(struct nullb_device *=
dev)
=20
 	if (dev->zoned &&
 	    (!dev->zone_size || !is_power_of_2(dev->zone_size))) {
-		pr_err("zone_size must be power-of-two\n");
+		pr_err("null_blk: zone_size must be power-of-two\n");
 		return -EINVAL;
 	}
=20
@@ -2071,6 +2071,8 @@ static int null_add_dev(struct nullb_device *dev)
 	list_add_tail(&nullb->list, &nullb_list);
 	mutex_unlock(&lock);
=20
+	pr_info("null_blk: disk %s created\n", nullb->disk_name);
+
 	return 0;
 out_cleanup_zone:
 	null_free_zoned_dev(dev);
@@ -2121,30 +2123,31 @@ static int __init null_init(void)
 	struct nullb *nullb;
=20
 	if (g_bs > PAGE_SIZE) {
-		pr_warn("invalid block size\n");
-		pr_warn("defaults block size to %lu\n", PAGE_SIZE);
+		pr_warn("null_blk: invalid block size\n");
+		pr_warn("null_blk: defaults block size to %lu\n", PAGE_SIZE);
 		g_bs =3D PAGE_SIZE;
 	}
=20
 	if (g_max_sectors > BLK_DEF_MAX_SECTORS) {
-		pr_warn("invalid max sectors\n");
-		pr_warn("defaults max sectors to %u\n", BLK_DEF_MAX_SECTORS);
+		pr_warn("null_blk: invalid max sectors\n");
+		pr_warn("null_blk: defaults max sectors to %u\n",
+			BLK_DEF_MAX_SECTORS);
 		g_max_sectors =3D BLK_DEF_MAX_SECTORS;
 	}
=20
 	if (g_home_node !=3D NUMA_NO_NODE && g_home_node >=3D nr_online_nodes) =
{
-		pr_err("invalid home_node value\n");
+		pr_err("null_blk: invalid home_node value\n");
 		g_home_node =3D NUMA_NO_NODE;
 	}
=20
 	if (g_queue_mode =3D=3D NULL_Q_RQ) {
-		pr_err("legacy IO path is no longer available\n");
+		pr_err("null_blk: legacy IO path is no longer available\n");
 		return -EINVAL;
 	}
=20
 	if (g_queue_mode =3D=3D NULL_Q_MQ && g_use_per_node_hctx) {
 		if (g_submit_queues !=3D nr_online_nodes) {
-			pr_warn("submit_queues param is set to %u.\n",
+			pr_warn("null_blk: submit_queues param is set to %u.\n",
 				nr_online_nodes);
 			g_submit_queues =3D nr_online_nodes;
 		}
@@ -2181,7 +2184,7 @@ static int __init null_init(void)
 			goto err_dev;
 	}
=20
-	pr_info("module loaded\n");
+	pr_info("null_blk: module loaded\n");
 	return 0;
=20
 err_dev:
diff --git a/drivers/block/null_blk/zoned.c b/drivers/block/null_blk/zone=
d.c
index dae54dd1aeac..f7114a16a342 100644
--- a/drivers/block/null_blk/zoned.c
+++ b/drivers/block/null_blk/zoned.c
@@ -63,11 +63,11 @@ int null_init_zoned_dev(struct nullb_device *dev, str=
uct request_queue *q)
 	unsigned int i;
=20
 	if (!is_power_of_2(dev->zone_size)) {
-		pr_err("zone_size must be power-of-two\n");
+		pr_err("null_blk: zone_size must be power-of-two\n");
 		return -EINVAL;
 	}
 	if (dev->zone_size > dev->size) {
-		pr_err("Zone size larger than device capacity\n");
+		pr_err("null_blk: Zone size larger than device capacity\n");
 		return -EINVAL;
 	}
=20
@@ -76,7 +76,7 @@ int null_init_zoned_dev(struct nullb_device *dev, struc=
t request_queue *q)
=20
 	if (dev->zone_capacity > dev->zone_size) {
 		pr_err("null_blk: zone capacity (%lu MB) larger than zone size (%lu MB=
)\n",
-					dev->zone_capacity, dev->zone_size);
+		       dev->zone_capacity, dev->zone_size);
 		return -EINVAL;
 	}
=20
@@ -95,24 +95,24 @@ int null_init_zoned_dev(struct nullb_device *dev, str=
uct request_queue *q)
=20
 	if (dev->zone_nr_conv >=3D dev->nr_zones) {
 		dev->zone_nr_conv =3D dev->nr_zones - 1;
-		pr_info("changed the number of conventional zones to %u",
+		pr_info("null_blk: changed the number of conventional zones to %u",
 			dev->zone_nr_conv);
 	}
=20
 	/* Max active zones has to be < nbr of seq zones in order to be enforce=
able */
 	if (dev->zone_max_active >=3D dev->nr_zones - dev->zone_nr_conv) {
 		dev->zone_max_active =3D 0;
-		pr_info("zone_max_active limit disabled, limit >=3D zone count\n");
+		pr_info("null_blk: zone_max_active limit disabled, limit >=3D zone cou=
nt\n");
 	}
=20
 	/* Max open zones has to be <=3D max active zones */
 	if (dev->zone_max_active && dev->zone_max_open > dev->zone_max_active) =
{
 		dev->zone_max_open =3D dev->zone_max_active;
-		pr_info("changed the maximum number of open zones to %u\n",
+		pr_info("null_blk: changed the maximum number of open zones to %u\n",
 			dev->nr_zones);
 	} else if (dev->zone_max_open >=3D dev->nr_zones - dev->zone_nr_conv) {
 		dev->zone_max_open =3D 0;
-		pr_info("zone_max_open limit disabled, limit >=3D zone count\n");
+		pr_info("null_blk: zone_max_open limit disabled, limit >=3D zone count=
\n");
 	}
 	dev->need_zone_res_mgmt =3D dev->zone_max_active || dev->zone_max_open;
 	dev->imp_close_zone_no =3D dev->zone_nr_conv;
--=20
2.35.1

