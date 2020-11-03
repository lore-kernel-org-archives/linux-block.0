Return-Path: <SRS0=cbU1=EJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6177CC388F2
	for <linux-block@archiver.kernel.org>; Tue,  3 Nov 2020 01:25:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 107A42225E
	for <linux-block@archiver.kernel.org>; Tue,  3 Nov 2020 01:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604366759;
	bh=qcbdQJkPEzwCb7hg1LS9ez+BtB+G8ki/aIpW5rjdbdc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ojGYevU0PYtDNGzeOYaYreDUjQlviFftG/lbiowJi9pn5DflibGkx+zmaSGbRSM5m
	 vGgQ4umOZhGx1FELtPIc0wzeLgm2uMXbRHm2v71OEpui13Nu+nCP8uTOdf6n2Im+nY
	 TY7HhRaoOky8+LbV1qUEFlronPDReLgL3yzMqnQ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbgKCBTu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 2 Nov 2020 20:19:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:34008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727128AbgKCBTu (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 2 Nov 2020 20:19:50 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9DA4B22264;
        Tue,  3 Nov 2020 01:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604366388;
        bh=qcbdQJkPEzwCb7hg1LS9ez+BtB+G8ki/aIpW5rjdbdc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=00Ve/23aWEkt7X7OY+pM86TCCWcnQWhMkUyVo2aGhtlLu3ywi0p5SjubHarGRSfyh
         KUWmDqmtGp8HlCp3IfGTplmMxXRP6+oDNLgk5k2qdrWxENS2H6RtfazhbTadmz3HSL
         tc+nQKrwbehJJFRfoWXUPYxEnLR2TaN/lIjy1/08=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 5.8 15/29] blk-cgroup: Fix memleak on error path
Date:   Mon,  2 Nov 2020 20:19:14 -0500
Message-Id: <20201103011928.183145-15-sashal@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201103011928.183145-1-sashal@kernel.org>
References: <20201103011928.183145-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Gabriel Krisman Bertazi <krisman@collabora.com>

[ Upstream commit 52abfcbd57eefdd54737fc8c2dc79d8f46d4a3e5 ]

If new_blkg allocation raced with blk_policy change and
blkg_lookup_check fails, new_blkg is leaked.

Acked-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-cgroup.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 6e8f5e60b0982..67619f4e24907 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -682,6 +682,7 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 		blkg = blkg_lookup_check(pos, pol, q);
 		if (IS_ERR(blkg)) {
 			ret = PTR_ERR(blkg);
+			blkg_free(new_blkg);
 			goto fail_unlock;
 		}
 
-- 
2.27.0

