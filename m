Return-Path: <SRS0=7fUu=SB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B98C43381
	for <linux-block@archiver.kernel.org>; Sat, 30 Mar 2019 01:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDAE9217F5
	for <linux-block@archiver.kernel.org>; Sat, 30 Mar 2019 01:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553909959;
	bh=1uXLSVwugs05PSpMTKuoCQNQvsOMw9m4vQmpMn+0Q9I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=h+YrdMbVMrTIrBqJg1nF58mb0suuZRxuwDcXkLXKqaeblWsliy+bFmlKUjiigbP51
	 SPGRFlrDYR5zn5o77JBnwrXijYR5IzvRJ0I+9nRFu2LU+flPRu92p2KVcOe3u70ZCM
	 T6j7jnmCKp14Q0Umdpc/nzOX3p3+xPLyJscD1oeU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731292AbfC3BaH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 Mar 2019 21:30:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:37080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731313AbfC3BaF (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Mar 2019 21:30:05 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9EBE21773;
        Sat, 30 Mar 2019 01:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553909405;
        bh=1uXLSVwugs05PSpMTKuoCQNQvsOMw9m4vQmpMn+0Q9I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w63GBYyWBrDEfWahgOUu4nV6y9nlQckkxMQJslpFN18SNyFAMkX9lQQTgUZI9aJk7
         kbSVnE3ADyckIRn1JnH4jOVLTsN7ZvKBWRkVMspvU/R/4glGbFM4+8yGFVkGGre2o/
         6/XxV8gx9dPqTqGZtWfM8FaRrlSCWlDH0rtlJXeU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 33/57] blk-mq: protect debugfs_create_files() from failures
Date:   Fri, 29 Mar 2019 21:28:26 -0400
Message-Id: <20190330012854.32212-33-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190330012854.32212-1-sashal@kernel.org>
References: <20190330012854.32212-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
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
index cb1e6cf7ac48..9dc3a0896462 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -806,6 +806,9 @@ static const struct blk_mq_debugfs_attr blk_mq_debugfs_ctx_attrs[] = {
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

