Return-Path: <SRS0=MRnn=WT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 356A3C3A5A1
	for <linux-block@archiver.kernel.org>; Fri, 23 Aug 2019 00:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07EE823401
	for <linux-block@archiver.kernel.org>; Fri, 23 Aug 2019 00:15:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="rIwVyH8T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728309AbfHWAPg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Aug 2019 20:15:36 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:30884 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728297AbfHWAPf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Aug 2019 20:15:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1566519335; x=1598055335;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=1/sXotb39VxftqsUW6LppcYGmJszREq2zKKiqRbq4T0=;
  b=rIwVyH8TVo8sm5PAtjs5bh/ObAt/Wr/vLRlZDmZEWKz9iwi7qjLdTK2w
   c8gvbNC3CiTd4ULhC+tNuXCzcAM9ak8IzES6TD+DMxF0N3djSbzexYGj7
   EC5AT3ZAduh/dtz3LX8l66QLZNqsks86vctJpoG6K6MRoumVNQwboB25x
   XfjhURD3LAl29+AJ4kgXKzAXiRKcdmltEXnvyMl+YjQQYmwQMn8odkFwt
   tpMN8517Vgk5EL1yfOTZT40v6/ht7SLVuixoOJtsP9UvgweRuZv/TZdds
   nLF2AxEv5PwvA160+qE/3UwrQZEibsZPWISowgfECl5yfAC8IFD7iwEtX
   g==;
IronPort-SDR: ur/3BZhYUbmuTH9aCMLNELu7xjfAMfsh1YJeg9k7AKtWRNO6paZc1foARjLcRm5Flxjt8A6gk3
 rpNGEigT+ri/PNdHUntCaitZ+tBKXA7bQYdGG3p/JJrZmvNkW2dwK1uFyf7ehgqc3ST8q76CW5
 9FzcuXrvVnL0p+Dw+XskRj7zpjq9B9b8wsKkuCDMyj96Ar/TDo08w7rfSOLlKaC6mBQS711bC3
 go9ggCeMUPxUzKuAWxIWYoWZ/ZZYmE47ZeoMV7HrSxWX2eFUSRuAG/9vnNB6Lcm3OK0aZGKKdJ
 +P4=
X-IronPort-AV: E=Sophos;i="5.64,419,1559491200"; 
   d="scan'208";a="121063672"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Aug 2019 08:15:34 +0800
IronPort-SDR: S+VjhqF77i/bskYajMCfikb/2DoQjI83FCi84X2YPY2UV7lwud6VXmNjEr34bVzmvwZjGdCi82
 yAzn8S/Ww8pCq25eG1gbNlo1gNN0Uh26KdARFbFQ0/fAeLI3TVTaVOXBNF5MV/En4EAvWq8AMZ
 KwvopRfjD5CcIXd3YHXegYjztxmSIko5NhUFdNISba0fgwnze816znhss3A5QN2177Kbl5k7kj
 0rkY+yCZDny9exkHX4PLRNYP87C5pndO5r1v7Tncqm4kqe/xNFDeZSxbLF7Zwd/ZhWAsPUaAtj
 kiIQv0446VF49BRgFdjr86V9
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2019 17:12:53 -0700
IronPort-SDR: 6Cn9DR2qGuiJxq+052IiwcBG8ldiHkyGCFxCdsxGDK+mRb6ZqtMGEpyrEERh2AMf5MbXs/Rp7d
 bPU8BOJ5ScZTktiX2pA+jsCZXxk4zFvJlVSZh1KmSr2FbQHPfXgiqD6PZsGuaqewlQnZjhWZnc
 QZspxzuwRuqkH8nvLPH8CWFwm3qzgP1yJa97C6xM73KNawYCtFvxK5uWoMabSk3KwxLDn5bVG3
 mTyVfHO2iDtpjJYmZIOHm2ht8HzXgn7ptyqkDCma4D1gbZI06wwkSzRKeClEtr1GiSd1qO3VYN
 j1s=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip01.wdc.com with ESMTP; 22 Aug 2019 17:15:34 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 7/7] block: Delay default elevator initialization
Date:   Fri, 23 Aug 2019 09:15:28 +0900
Message-Id: <20190823001528.5673-8-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190823001528.5673-1-damien.lemoal@wdc.com>
References: <20190823001528.5673-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When elevator_init_mq() is called from blk_mq_init_allocated_queue(),
the only information known about the device is the number of hardware
queues as the block device scan by the device driver is not completed
yet. The device type and the device required features are not set yet,
preventing to correctly choose the default elevator most suitable for
the device.

This currently affects all multi-queue zoned block devices which default
to the "none" elevator instead of the required "mq-deadline" elevator.
These drives currently include host-managed SMR disks connected to a
smartpqi HBA and null_blk block devices with zoned mode enabled.
Upcoming NVMe Zoned Namespace devices will also be affected.

Fix this by moving the execution of elevator_init_mq() from
blk_mq_init_allocated_queue() into __device_add_disk() to allow for the
device driver to probe the device characteristics and set attributes
of the device request queue prior to the elevator initialization.

Also to make sure that the elevator initialization is never done while
requests are in-flight (there should be none when the device driver
calls device_add_disk()), freeze and quiesce the device request queue
before executing blk_mq_init_sched().

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 block/blk-mq.c   | 2 --
 block/elevator.c | 7 +++++++
 block/genhd.c    | 3 +++
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 274e168c8535..34e9541945dc 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2906,8 +2906,6 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 	blk_mq_add_queue_tag_set(set, q);
 	blk_mq_map_swqueue(q);
 
-	elevator_init_mq(q);
-
 	return q;
 
 err_hctxs:
diff --git a/block/elevator.c b/block/elevator.c
index ec75dfee7e96..9218bc86845f 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -688,7 +688,14 @@ void elevator_init_mq(struct request_queue *q)
 	if (!e)
 		return;
 
+	blk_mq_freeze_queue(q);
+	blk_mq_quiesce_queue(q);
+
 	err = blk_mq_init_sched(q, e);
+
+	blk_mq_unquiesce_queue(q);
+	blk_mq_unfreeze_queue(q);
+
 	if (err) {
 		pr_warn("\"%s\" elevator initialization failed, "
 			"falling back to \"none\"\n", e->elevator_name);
diff --git a/block/genhd.c b/block/genhd.c
index 54f1f0d381f4..d2114c25dccd 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -734,6 +734,9 @@ static void __device_add_disk(struct device *parent, struct gendisk *disk,
 				    exact_match, exact_lock, disk);
 	}
 	register_disk(parent, disk, groups);
+
+	elevator_init_mq(disk->queue);
+
 	if (register_queue)
 		blk_register_queue(disk);
 
-- 
2.21.0

