Return-Path: <SRS0=DoUd=BU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0143FC433DF
	for <linux-block@archiver.kernel.org>; Mon, 10 Aug 2020 19:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD4F22080C
	for <linux-block@archiver.kernel.org>; Mon, 10 Aug 2020 19:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597087797;
	bh=UnMzxSx1bFTza18KxTSF0DkGaDImt48XwHIJpKEOgLk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Vq44dUvgW8Qvt+FBU0SF5mqgto85gVi/ZtdUSz/Fw0gsBcPMr4GZ0ErrV8MUqQksm
	 78lak12+ONmzudobPwcT5XmNpTXS2J6HLLkHNdk+3c0diAllrqKTVjmimWFxOSoB+E
	 kDCvULDxPibfK29jpN7jXxJVqN9n40lIp0vhN06Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729032AbgHJT3e (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Aug 2020 15:29:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:38058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729012AbgHJTKk (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Aug 2020 15:10:40 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71ABE207FF;
        Mon, 10 Aug 2020 19:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597086637;
        bh=UnMzxSx1bFTza18KxTSF0DkGaDImt48XwHIJpKEOgLk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LLK7MvFVrBEjbi1Oa+ogKOS5xUANGJx3hywgW+isCo+eZyzWzK2YJUT1udMLT0Ai7
         HaEAAIHz8vxLOAQAjCbIe2sIQBkgozSHoRmOPPPtCyeiKm7VQQJH1dObSuQkrkjRHQ
         M9INbNY5GCimkI2uBIwSO5Ca6qjEebDUi7mnTBo4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 5.7 06/60] loop: be paranoid on exit and prevent new additions / removals
Date:   Mon, 10 Aug 2020 15:09:34 -0400
Message-Id: <20200810191028.3793884-6-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200810191028.3793884-1-sashal@kernel.org>
References: <20200810191028.3793884-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Luis Chamberlain <mcgrof@kernel.org>

[ Upstream commit 200f93377220504c5e56754823e7adfea6037f1a ]

Be pedantic on removal as well and hold the mutex.
This should prevent uses of addition while we exit.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/loop.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 418bb4621255a..6b36fc2f4edc7 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -2333,6 +2333,8 @@ static void __exit loop_exit(void)
 
 	range = max_loop ? max_loop << part_shift : 1UL << MINORBITS;
 
+	mutex_lock(&loop_ctl_mutex);
+
 	idr_for_each(&loop_index_idr, &loop_exit_cb, NULL);
 	idr_destroy(&loop_index_idr);
 
@@ -2340,6 +2342,8 @@ static void __exit loop_exit(void)
 	unregister_blkdev(LOOP_MAJOR, "loop");
 
 	misc_deregister(&loop_misc);
+
+	mutex_unlock(&loop_ctl_mutex);
 }
 
 module_init(loop_init);
-- 
2.25.1

