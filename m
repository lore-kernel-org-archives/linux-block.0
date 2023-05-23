Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F53EC7EE23
	for <linux-block@archiver.kernel.org>; Tue, 23 May 2023 07:54:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235813AbjEWHyL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 May 2023 03:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235804AbjEWHyF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 May 2023 03:54:05 -0400
Received: from out-32.mta0.migadu.com (out-32.mta0.migadu.com [IPv6:2001:41d0:1004:224b::20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D805E74
        for <linux-block@vger.kernel.org>; Tue, 23 May 2023 00:53:48 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1684828423;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jznc2RAMnxsq5svyPaZcC7HHIc0Bh3Zogn1eiwDdPGI=;
        b=M33w/BW3/1eDXNgDCustPpRPyyuKLt0FYIL2SW9INnDrkJ8r5zTNUX5N7lo+sSifpq9vVa
        1JO6VigMmQN0KNb2JsHtUWr5knOnY6g0IezPwi1k+UOjAb3f3mIhWJ97CLYMA8Hw1gnZp6
        hYD/vcPQPJlUkSO5fG6GJKylpXUikEc=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     haris.iqbal@ionos.com, jinpu.wang@ionos.com, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 04/10] block/rnbd-srv: no need to check sess_dev
Date:   Tue, 23 May 2023 15:53:25 +0800
Message-Id: <20230523075331.32250-5-guoqing.jiang@linux.dev>
In-Reply-To: <20230523075331.32250-1-guoqing.jiang@linux.dev>
References: <20230523075331.32250-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Check ret is enough since if sess_dev is NULL which also
implies ret should be 0.

Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
---
 drivers/block/rnbd/rnbd-srv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.c
index e9ef6bd4b50c..c4122e65b36a 100644
--- a/drivers/block/rnbd/rnbd-srv.c
+++ b/drivers/block/rnbd/rnbd-srv.c
@@ -96,7 +96,7 @@ rnbd_get_sess_dev(int dev_id, struct rnbd_srv_session *srv_sess)
 		ret = kref_get_unless_zero(&sess_dev->kref);
 	rcu_read_unlock();
 
-	if (!sess_dev || !ret)
+	if (!ret)
 		return ERR_PTR(-ENXIO);
 
 	return sess_dev;
-- 
2.35.3

