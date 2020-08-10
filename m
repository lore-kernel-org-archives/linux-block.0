Return-Path: <SRS0=DoUd=BU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0717FC433DF
	for <linux-block@archiver.kernel.org>; Mon, 10 Aug 2020 19:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6EB52080C
	for <linux-block@archiver.kernel.org>; Mon, 10 Aug 2020 19:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597087334;
	bh=cVwW3JpkPI2yvj2GLbXy1z9Bl6AxSIj5FTixz3QA3ms=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rYoME6WmGVecZVsS1WLCCeSfCxOIhUSV/es+aWf5iDXLpStlyDpwPcBdomewxB6nZ
	 tYlEvl79Rurtx7gxKUXlP8x4X3qxt5BUvyWiFOye23Hf3b7/gCgf+TjweOwz2Xy+Mw
	 CrpXse+3r+91pZvRd/X3HNwu4KsHN3C3DAS/aFsc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728776AbgHJTNH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Aug 2020 15:13:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:43636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729692AbgHJTNG (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Aug 2020 15:13:06 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB0252224D;
        Mon, 10 Aug 2020 19:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597086785;
        bh=cVwW3JpkPI2yvj2GLbXy1z9Bl6AxSIj5FTixz3QA3ms=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L1WhpnkTm+mmNhEYdv2/RdldDSJ5wdTjV0eDGEvPv6805vnkg8rqonA6cMSBIsZAQ
         zVdC1hsWgZyIVXzSogUkzuLafKoQqXEjMZT7Wd8TezxRNUi5fSRhvkYVLtA/l/uF86
         Njms0PQR0jyD+m8jHDLjYsRU8JOZtjK2wGsIRYSk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 04/31] loop: be paranoid on exit and prevent new additions / removals
Date:   Mon, 10 Aug 2020 15:12:32 -0400
Message-Id: <20200810191259.3794858-4-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200810191259.3794858-1-sashal@kernel.org>
References: <20200810191259.3794858-1-sashal@kernel.org>
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
index 728681a20b7f4..da68c42aed682 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -2279,6 +2279,8 @@ static void __exit loop_exit(void)
 
 	range = max_loop ? max_loop << part_shift : 1UL << MINORBITS;
 
+	mutex_lock(&loop_ctl_mutex);
+
 	idr_for_each(&loop_index_idr, &loop_exit_cb, NULL);
 	idr_destroy(&loop_index_idr);
 
@@ -2286,6 +2288,8 @@ static void __exit loop_exit(void)
 	unregister_blkdev(LOOP_MAJOR, "loop");
 
 	misc_deregister(&loop_misc);
+
+	mutex_unlock(&loop_ctl_mutex);
 }
 
 module_init(loop_init);
-- 
2.25.1

