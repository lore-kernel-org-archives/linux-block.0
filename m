Return-Path: <SRS0=LW4I=4O=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E121C4BA0E
	for <linux-block@archiver.kernel.org>; Wed, 26 Feb 2020 11:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E119C24689
	for <linux-block@archiver.kernel.org>; Wed, 26 Feb 2020 11:11:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbgBZLLs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Feb 2020 06:11:48 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:38352 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727974AbgBZLLs (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Feb 2020 06:11:48 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 75D36E7D6CF1D35AC168;
        Wed, 26 Feb 2020 19:11:45 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Wed, 26 Feb 2020
 19:11:40 +0800
From:   Yufen Yu <yuyufen@huawei.com>
To:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
CC:     <tj@kernel.org>, <jack@suse.cz>, <bvanassche@acm.org>,
        <tytso@mit.edu>
Subject: [PATCH v2 2/7] fs/ceph: use bdi_dev_name() to get device name
Date:   Wed, 26 Feb 2020 19:18:46 +0800
Message-ID: <20200226111851.55348-3-yuyufen@huawei.com>
X-Mailer: git-send-email 2.16.2.dirty
In-Reply-To: <20200226111851.55348-1-yuyufen@huawei.com>
References: <20200226111851.55348-1-yuyufen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use the common interface bdi_dev_name() to get device name.

Signed-off-by: Yufen Yu <yuyufen@huawei.com>
---
 fs/ceph/debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ceph/debugfs.c b/fs/ceph/debugfs.c
index fb7cabd98e7b..1f8f3b631adb 100644
--- a/fs/ceph/debugfs.c
+++ b/fs/ceph/debugfs.c
@@ -271,7 +271,7 @@ void ceph_fs_debugfs_init(struct ceph_fs_client *fsc)
 				    &congestion_kb_fops);
 
 	snprintf(name, sizeof(name), "../../bdi/%s",
-		 dev_name(fsc->sb->s_bdi->dev));
+		 bdi_dev_name(fsc->sb->s_bdi));
 	fsc->debugfs_bdi =
 		debugfs_create_symlink("bdi",
 				       fsc->client->debugfs_dir,
-- 
2.16.2.dirty

