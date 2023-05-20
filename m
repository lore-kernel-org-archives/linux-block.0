Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 050E3C77B7F
	for <linux-block@archiver.kernel.org>; Sat, 20 May 2023 15:12:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbjETPMg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 20 May 2023 11:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjETPMf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 20 May 2023 11:12:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBC18EE
        for <linux-block@vger.kernel.org>; Sat, 20 May 2023 08:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684595508;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=NcFayYwwQD+mu8+fru3CrVrepvfa+QmvwNXxfXB0i5Y=;
        b=F41GaOWEcjoyBMKNpN+8rgjyVRtHLOX76uRF0hkleJ19LmDRk+o2D6hzkt9Nf84HpwFE/L
        7wH2EE0sdMpWknHQ79Z8AZkcKoRKp4uzR2ThTfqK7C8XpN57seKuYH4oiLCuRHlbn5rHAg
        K8Qno/ZqMfmq/plesep6z+L6kSCiubg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-662-w6dsjjRsM5mcoKWLvIqzDg-1; Sat, 20 May 2023 11:11:45 -0400
X-MC-Unique: w6dsjjRsM5mcoKWLvIqzDg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A1E79800B2A;
        Sat, 20 May 2023 15:11:44 +0000 (UTC)
Received: from localhost (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9CFA07B7C;
        Sat, 20 May 2023 15:11:43 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        kernel test robot <lkp@intel.com>,
        Julia Lawall <julia.lawall@inria.fr>
Subject: [PATCH] ublk: fix build warning on iov_iter_get_pages2
Date:   Sat, 20 May 2023 23:11:34 +0800
Message-Id: <20230520151134.459679-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Return type of iov_iter_get_pages2() is ssize_t instead of size_t, so
fix it.

Fixes: 981f95a571e3 ("ublk: cleanup ublk_copy_user_pages")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Julia Lawall <julia.lawall@inria.fr>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index e00733b6fea8..539eada32861 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -564,7 +564,8 @@ static size_t ublk_copy_user_pages(const struct request *req,
 
 	while (iov_iter_count(uiter) && iter.bio) {
 		unsigned nr_pages;
-		size_t len, off;
+		ssize_t len;
+		size_t off;
 		int i;
 
 		len = iov_iter_get_pages2(uiter, iter.pages,
-- 
2.38.1

