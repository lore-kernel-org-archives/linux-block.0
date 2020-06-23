Return-Path: <SRS0=PrCR=AE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1751C433DF
	for <linux-block@archiver.kernel.org>; Tue, 23 Jun 2020 17:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A0DA20781
	for <linux-block@archiver.kernel.org>; Tue, 23 Jun 2020 17:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592933791;
	bh=BXpjKMRjKVDNEazo5/y3JtFBbZ+zFAHaaJVS6tJxJAU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PAKA/8Fc0mAVpgzbugA5bYDszHXmRhWkkA8VQtDHVBPUARKFrFP+gExUwf4K/qv8l
	 fehaPn0EhZ4xtX5GET1OPVK7pJ7eZUxhpKgiAPIdxAUwPIiS3KL0S69YZm1hz4zzk6
	 yj8u21esyuzsTonWYK1Vvb6N/YiAh6hoeAm+kGIw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387585AbgFWRg3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Jun 2020 13:36:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:33720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387579AbgFWRg2 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Jun 2020 13:36:28 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 702F6207D0;
        Tue, 23 Jun 2020 17:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592933788;
        bh=BXpjKMRjKVDNEazo5/y3JtFBbZ+zFAHaaJVS6tJxJAU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=df4uIvQV8WHSzz9yTfCSUuW/6vc4BD6avJuNVgoL47JAS+4YtmVYzBH0DyN/S75sE
         xl/Ew6HSHnBXWMbHylo0XwVRub/lzh1I535ENFhBu82W1nsQ8It+lSitCqKOSbEgk+
         EQL3zA2JCGOidfTA/skZ2IDtgl0LK1nPbhwWVm7w=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Weiping Zhang <zhangweiping@didiglobal.com>,
        Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>, linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 23/24] block: update hctx map when use multiple maps
Date:   Tue, 23 Jun 2020 13:35:58 -0400
Message-Id: <20200623173559.1355728-23-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200623173559.1355728-1-sashal@kernel.org>
References: <20200623173559.1355728-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Weiping Zhang <zhangweiping@didiglobal.com>

[ Upstream commit fe35ec58f0d339221643287bbb7cee15c93a5389 ]

There is an issue when tune the number for read and write queues,
if the total queue count was not changed. The hctx->type cannot
be updated, since __blk_mq_update_nr_hw_queues will return directly
if the total queue count has not been changed.

Reproduce:

dmesg | grep "default/read/poll"
[    2.607459] nvme nvme0: 48/0/0 default/read/poll queues
cat /sys/kernel/debug/block/nvme0n1/hctx*/type | sort | uniq -c
     48 default

tune the write queues to 24:
echo 24 > /sys/module/nvme/parameters/write_queues
echo 1 > /sys/block/nvme0n1/device/reset_controller

dmesg | grep "default/read/poll"
[  433.547235] nvme nvme0: 24/24/0 default/read/poll queues

cat /sys/kernel/debug/block/nvme0n1/hctx*/type | sort | uniq -c
     48 default

The driver's hardware queue mapping is not same as block layer.

Signed-off-by: Weiping Zhang <zhangweiping@didiglobal.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-mq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 0550366e25d8b..f1b930a300a38 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3279,7 +3279,9 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 
 	if (set->nr_maps == 1 && nr_hw_queues > nr_cpu_ids)
 		nr_hw_queues = nr_cpu_ids;
-	if (nr_hw_queues < 1 || nr_hw_queues == set->nr_hw_queues)
+	if (nr_hw_queues < 1)
+		return;
+	if (set->nr_maps == 1 && nr_hw_queues == set->nr_hw_queues)
 		return;
 
 	list_for_each_entry(q, &set->tag_list, tag_set_list)
-- 
2.25.1

