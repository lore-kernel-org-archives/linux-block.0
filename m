Return-Path: <SRS0=h0yA=YL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B38CA9EA0
	for <linux-block@archiver.kernel.org>; Fri, 18 Oct 2019 22:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7581720679
	for <linux-block@archiver.kernel.org>; Fri, 18 Oct 2019 22:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571437032;
	bh=7anIju3GzbRm18JdCkJS7Bg+9lKUk0OQ3BDxqqY5L24=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jVlA5fTxMR0bfBLOyQph3lBMeV7SelGquJNLxUZuquL6WpKA6fwIXkiji71kAQaOf
	 eVTDjl6UODe6EOanIx/2joEvSX3AduUm1V2lJhKMuy99lAUavleO2Zhm5gLG0oMycx
	 KFIMzhxnD0hJPlagTfwnlwXOVxXVTBEeSgdaKAdY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733289AbfJRWHu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Oct 2019 18:07:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:40212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733241AbfJRWHs (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Oct 2019 18:07:48 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D95CE222D1;
        Fri, 18 Oct 2019 22:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571436467;
        bh=7anIju3GzbRm18JdCkJS7Bg+9lKUk0OQ3BDxqqY5L24=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bu2c6ZrzQNAgR6iUWOCpixSD+B04Rsv6aarfMBTMe8KLw9q7Wx2uK/MQyVraFke2I
         UH8guMLvzeUnMb6sox1lEzGI8oKUoucXPhGlKZnPbwVMg7ikEz2U9Bvk6HlqPLRrOf
         G9ys6yR/f1qX27nunWHK5WhWXcguntLWaS2eoS90=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Xiubo Li <xiubli@redhat.com>, Mike Christie <mchristi@redhat.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        linux-block@vger.kernel.org, nbd@other.debian.org
Subject: [PATCH AUTOSEL 4.19 097/100] nbd: fix possible sysfs duplicate warning
Date:   Fri, 18 Oct 2019 18:05:22 -0400
Message-Id: <20191018220525.9042-97-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191018220525.9042-1-sashal@kernel.org>
References: <20191018220525.9042-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Xiubo Li <xiubli@redhat.com>

[ Upstream commit 862488105b84ca744b3d8ff131e0fcfe10644be1 ]

1. nbd_put takes the mutex and drops nbd->ref to 0. It then does
idr_remove and drops the mutex.

2. nbd_genl_connect takes the mutex. idr_find/idr_for_each fails
to find an existing device, so it does nbd_dev_add.

3. just before the nbd_put could call nbd_dev_remove or not finished
totally, but if nbd_dev_add try to add_disk, we can hit:

debugfs: Directory 'nbd1' with parent 'block' already present!

This patch will make sure all the disk add/remove stuff are done
by holding the nbd_index_mutex lock.

Reported-by: Mike Christie <mchristi@redhat.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Xiubo Li <xiubli@redhat.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/nbd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index bc2fa4e85f0ca..d445195945618 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -228,8 +228,8 @@ static void nbd_put(struct nbd_device *nbd)
 	if (refcount_dec_and_mutex_lock(&nbd->refs,
 					&nbd_index_mutex)) {
 		idr_remove(&nbd_index_idr, nbd->index);
-		mutex_unlock(&nbd_index_mutex);
 		nbd_dev_remove(nbd);
+		mutex_unlock(&nbd_index_mutex);
 	}
 }
 
-- 
2.20.1

