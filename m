Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 981F9C433F5
	for <linux-block@archiver.kernel.org>; Mon, 27 Dec 2021 16:41:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbhL0Qlr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Dec 2021 11:41:47 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:45088 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbhL0Qlr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Dec 2021 11:41:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7FB26B810E5
        for <linux-block@vger.kernel.org>; Mon, 27 Dec 2021 16:41:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0A9AC36AEA;
        Mon, 27 Dec 2021 16:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640623305;
        bh=NMZpTEU3icRfs1ElfRY3y8Ulxx03wQHJS6DyTS42Uyw=;
        h=From:To:Cc:Subject:Date:From;
        b=i0D2XQE/qSUFYTjLBn4G9SD5wz3NohQK9lEsHBk+E9FaMJhhUVwGiHZwT2UYw7kvF
         zlqenAJEFzfZdcUjuvA6bRkZz3Wd4hYYpNCQsgxUkgLm9R/j2inijXmbDUQr8ijRi+
         7V+nJUT65X8/umwVjqT/wtjbtFoYusbWDGpoZfeNWiTC+o30jRWRXZJw/2dEeExT3s
         939IiS7U8K4UMVZMLxhmIBQaImxGSG93yO+nyVgZTI9DCazvL86v669UDIN89mJ329
         g44aRtxGmzPXDcn41js8aj5+sBs0D72iTKo9YN4rKwB0o+16rCxeNqsw339d+ypZNt
         PV9nupABeqhhA==
From:   Keith Busch <kbusch@kernel.org>
To:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        axboe@kernel.dk
Cc:     hch@lst.de, sagi@grimberg.me, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2 1/3] block: introduce rq_list_for_each_safe macro
Date:   Mon, 27 Dec 2021 08:41:36 -0800
Message-Id: <20211227164138.2488066-1-kbusch@kernel.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

While iterating a list, a particular request may need to be removed for
special handling. Provide an iterator that can safely handle that.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 include/linux/blkdev.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 22746b2d6825..c4597ccdaf26 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1365,6 +1365,10 @@ struct io_comp_batch {
 #define rq_list_for_each(listptr, pos)			\
 	for (pos = rq_list_peek((listptr)); pos; pos = rq_list_next(pos))
 
+#define rq_list_for_each_safe(listptr, pos, nxt)			\
+	for (pos = rq_list_peek((listptr)), nxt = rq_list_next(pos);	\
+		pos; pos = nxt, nxt = pos ? rq_list_next(pos) : NULL)
+
 #define rq_list_next(rq)	(rq)->rq_next
 #define rq_list_empty(list)	((list) == (struct request *) NULL)
 
-- 
2.25.4

