Return-Path: <SRS0=9mBv=RD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D06B9C43381
	for <linux-block@archiver.kernel.org>; Thu, 28 Feb 2019 15:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FEA020C01
	for <linux-block@archiver.kernel.org>; Thu, 28 Feb 2019 15:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551367263;
	bh=lATyR0mlQQWdOBzvH8+JIDeWmAKVsEaqfNeWQ8e81X0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=C+PwkmiW9bIYrabw9IJNe45PhYx98RBkn6jJShzWTpvGMC8S295Pg7WKsx6ayVG/I
	 N1uCRgXfOC+HXC/bD0huiWUB6X7SaUJfKalKUJa3nUncBV3ZFw8RleMlMKKbRgPVTS
	 Ldn5JqB+lJgeuqiwR3apHFHef2NgjZwfZ0pj5xeA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730516AbfB1PU5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:20:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:48674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388622AbfB1POK (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Feb 2019 10:14:10 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47C4C218C3;
        Thu, 28 Feb 2019 15:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551366849;
        bh=lATyR0mlQQWdOBzvH8+JIDeWmAKVsEaqfNeWQ8e81X0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jkU9Du8cDsboeDneSEw9ry+R/9bub9OPJPFQqPJomLyJSCuNXd7cDfQ8AO+w4M4IX
         FENBqOIuRbw4cQjzyv7DhJuO2Xp2NEqBlcspXtld9m26u5qW/T+2vBQNk4QUQVrWnT
         HxEWv+BjehNFs68h5HR7cZy/oAfybDv1nXZ1tThY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 17/36] blk-mq: protect debugfs_create_files() from failures
Date:   Thu, 28 Feb 2019 10:13:18 -0500
Message-Id: <20190228151337.12176-17-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190228151337.12176-1-sashal@kernel.org>
References: <20190228151337.12176-1-sashal@kernel.org>
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
index d95439154556d..da0453277f7f2 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -791,6 +791,9 @@ static const struct blk_mq_debugfs_attr blk_mq_debugfs_ctx_attrs[] = {
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

