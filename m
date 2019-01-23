Return-Path: <SRS0=btbQ=P7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F99C282C0
	for <linux-block@archiver.kernel.org>; Wed, 23 Jan 2019 13:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA8732184D
	for <linux-block@archiver.kernel.org>; Wed, 23 Jan 2019 13:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548251338;
	bh=ELiE3gPS8RiO5npZuv3ICzNh1ao0Y+7e0bYWVYrD7Go=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=i6ywkDM1EqFeRkXXI7dopSGeseVAWOgx39DDfEhjCqU9Xi7NCxKD3JXHyz1Sjr884
	 SNb5y7mYjj5Vy0kVcTA2lG8K9NqJMbNJMazd7jEN9zDmAv7w1TJHt0LyUxc1jw89EG
	 RqB8tMvJtxYepkmgveBZbhVlxJEqIZnZypKTpuS0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbfAWNs5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Jan 2019 08:48:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:59100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725995AbfAWNs5 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Jan 2019 08:48:57 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 355D920855;
        Wed, 23 Jan 2019 13:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548251336;
        bh=ELiE3gPS8RiO5npZuv3ICzNh1ao0Y+7e0bYWVYrD7Go=;
        h=Date:From:To:Cc:Subject:From;
        b=CHHibquj3l5ttf9TszKmovObl1oXhD9NvirJwlK0vB+tMNGTFzaubZZxc+nl6efm8
         15+rItX7gNTZTm1TLP4D5kTp8RxX0x5uHG9+LOI/vE/Nv3XX3d3im5QxzCG88+OsMR
         /Pwf8sfMmzvewuiOn3dkc+nY5ZagwdkBWBGOQjqQ=
Date:   Wed, 23 Jan 2019 14:48:54 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Michal Hocko <mhocko@kernel.org>
Subject: [PATCH] blk-mq: protect debugfs_create_files() from failures
Message-ID: <20190123134854.GA25906@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If debugfs were to return a non-NULL error for a debugfs call, using
that pointer later in debugfs_create_files() would crash.

Fix that by properly checking the pointer before referencing it.

Reported-by: Michal Hocko <mhocko@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 block/blk-mq-debugfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 90d68760af08..777638f597aa 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -838,6 +838,9 @@ static const struct blk_mq_debugfs_attr blk_mq_debugfs_ctx_attrs[] = {
 static bool debugfs_create_files(struct dentry *parent, void *data,
 				 const struct blk_mq_debugfs_attr *attr)
 {
+	if (IS_ERR_OR_NULL(parent))
+		return false;
+
 	d_inode(parent)->i_private = data;
 
 	for (; attr->name; attr++) {
-- 
2.20.1

