Return-Path: <SRS0=9mBv=RD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CCE6C43381
	for <linux-block@archiver.kernel.org>; Thu, 28 Feb 2019 15:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2CAD218AE
	for <linux-block@archiver.kernel.org>; Thu, 28 Feb 2019 15:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551366564;
	bh=pLV/v2lvF82r6/IdQ8/R2cT6HYFG1XDstLvWJ6mdoI4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BFVHVP+2mWoPcZFiOSudHD+fLe5uHVsUHJzE88qZcDn8C2xkgqmrftqOf7YhfMqwZ
	 cVp3bj11xWGDsIO0BGlABnhUdqZw/UurPeNBaR1m0XAIC0egV5hfDgqVvJOrVSbsg0
	 WQ6tSR8Qcgh6ovfmsysuDOv6JgLNI/Mtx9m0AwQs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387523AbfB1PJX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:09:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:41974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731575AbfB1PJX (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Feb 2019 10:09:23 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D60D6218C3;
        Thu, 28 Feb 2019 15:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551366562;
        bh=pLV/v2lvF82r6/IdQ8/R2cT6HYFG1XDstLvWJ6mdoI4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EmfNuvZwyRztJFVZkTvRjr7bNFYyhTwWVa4jx6JrQQKdgZjdfbD5R3tTxwym5auvF
         FbR5hbpv9B7gJFkHCDxsTPhl9iGS16e9JHbZQYLUg1sCQnzPV1iWtMpOySPVTVJ0hI
         rUSI4DHrFP7kdp/1DzeV3tdMjm5qNbfLkwKBjLcQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 43/81] blk-mq: protect debugfs_create_files() from failures
Date:   Thu, 28 Feb 2019 10:07:35 -0500
Message-Id: <20190228150813.10256-43-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190228150813.10256-1-sashal@kernel.org>
References: <20190228150813.10256-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

[ Upstream commit 36991ca68db9dd43bac7f3519f080ee3939263ef ]

If debugfs were to return a non-NULL error for a debugfs call, using
that pointer later in debugfs_create_files() would crash.

Fix that by properly checking the pointer before referencing it.

Reported-by: Michal Hocko <mhocko@kernel.org>
Reported-and-tested-by: syzbot+b382ba6a802a3d242790@syzkaller.appspotmail.com
Reported-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-mq-debugfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 10b284a1f18d7..ecdc6f07a37cd 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -812,6 +812,9 @@ static const struct blk_mq_debugfs_attr blk_mq_debugfs_ctx_attrs[] = {
 static bool debugfs_create_files(struct dentry *parent, void *data,
 				 const struct blk_mq_debugfs_attr *attr)
 {
+	if (IS_ERR_OR_NULL(parent))
+		return false;
+
 	d_inode(parent)->i_private = data;
 
 	for (; attr->name; attr++) {
-- 
2.19.1

