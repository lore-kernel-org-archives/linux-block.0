Return-Path: <SRS0=euq6=B7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1083AC433DF
	for <linux-block@archiver.kernel.org>; Fri, 21 Aug 2020 17:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E48ED20702
	for <linux-block@archiver.kernel.org>; Fri, 21 Aug 2020 17:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598029864;
	bh=ps+HJouMxS0MKhtsq4HA6ltIRrGt1y5G3/30b95tvho=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mdyfZ0m65GNX5TBKcuXWviUyw34iTSsY6QD2xoFKpO43d3ru82/zaN/AeZlXDhwD5
	 dViDwwBh59P8pmNxo5cNRYhKJzLSnpjztFULdOH0GxQM5XjY6PyB8Zm35ZA+Bw9Nuj
	 OVLNrXFSI/CbsPV7SZwqS++VFucKwBfckIPq1peY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728532AbgHURKc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Aug 2020 13:10:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:50640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726884AbgHUQRX (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Aug 2020 12:17:23 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B611F22BED;
        Fri, 21 Aug 2020 16:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598026639;
        bh=ps+HJouMxS0MKhtsq4HA6ltIRrGt1y5G3/30b95tvho=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=haSSifytKtM35Pnc/TmoZQsKhRKRvTUfu8wO1XZnqlgTqVfoIW1sBIhlHBmHU9oOv
         YO6LCXirOOFNFX3/6377Q4F4s6XgFBCQTewzbO2ZfQuQa74pUR1EzAbFakHiaAt8eQ
         pBq4iLWdu9q1SYpAvGE+TVnMqD8qpiCIvBEBNDLM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 12/48] blktrace: ensure our debugfs dir exists
Date:   Fri, 21 Aug 2020 12:16:28 -0400
Message-Id: <20200821161704.348164-12-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821161704.348164-1-sashal@kernel.org>
References: <20200821161704.348164-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Luis Chamberlain <mcgrof@kernel.org>

[ Upstream commit b431ef837e3374da0db8ff6683170359aaa0859c ]

We make an assumption that a debugfs directory exists, but since
this can fail ensure it exists before allowing blktrace setup to
complete. Otherwise we end up stuffing blktrace files on the debugfs
root directory. In the worst case scenario this *in theory* can create
an eventual panic *iff* in the future a similarly named file is created
prior on the debugfs root directory. This theoretical crash can happen
due to a recursive removal followed by a specific dentry removal.

This doesn't fix any known crash, however I have seen the files
go into the main debugfs root directory in cases where the debugfs
directory was not created due to other internal bugs with blktrace
now fixed.

blktrace is also completely useless without this directory, so
this ensures to userspace we only setup blktrace if the kernel
can stuff files where they are supposed to go into.

debugfs directory creations typically aren't checked for, and we have
maintainers doing sweep removals of these checks, but since we need this
check to ensure proper userspace blktrace functionality we make sure
to annotate the justification for the check.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/blktrace.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index a4c8f9d9522e4..884333b9fc767 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -535,6 +535,18 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 #endif
 		bt->dir = dir = debugfs_create_dir(buts->name, blk_debugfs_root);
 
+	/*
+	 * As blktrace relies on debugfs for its interface the debugfs directory
+	 * is required, contrary to the usual mantra of not checking for debugfs
+	 * files or directories.
+	 */
+	if (IS_ERR_OR_NULL(dir)) {
+		pr_warn("debugfs_dir not present for %s so skipping\n",
+			buts->name);
+		ret = -ENOENT;
+		goto err;
+	}
+
 	bt->dev = dev;
 	atomic_set(&bt->dropped, 0);
 	INIT_LIST_HEAD(&bt->running_list);
-- 
2.25.1

