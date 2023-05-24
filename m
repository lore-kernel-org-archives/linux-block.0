Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD405C7EE23
	for <linux-block@archiver.kernel.org>; Wed, 24 May 2023 07:01:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239794AbjEXHBj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 May 2023 03:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235635AbjEXHBN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 May 2023 03:01:13 -0400
Received: from out-16.mta0.migadu.com (out-16.mta0.migadu.com [IPv6:2001:41d0:1004:224b::10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA9CE54
        for <linux-block@vger.kernel.org>; Wed, 24 May 2023 00:00:55 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1684911654;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4ImUoWNfHiDMTThV5A3Tkhe51pCtq/F+3ONtYC8UNZE=;
        b=gK0Hak1M5LMRNqX4hC+ETCbL6gdeiv8jO1t5922Ir5PCRvv+687Kl368w9ifnsWjYOhYav
        L1SUUR8cPvjG3ho26JcCSOj6fC3YRmKHHOvkCqZcpIaLqfeckpLEn5A1D6JuCNChrEC6R+
        QEbdLpFHbl4zq7MJsJJerXhjDZ36n94=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     haris.iqbal@ionos.com, jinpu.wang@ionos.com, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH V2 6/8] block/rnbd-srv: init ret with 0 instead of -EPERM
Date:   Wed, 24 May 2023 15:00:24 +0800
Message-Id: <20230524070026.2932-7-guoqing.jiang@linux.dev>
In-Reply-To: <20230524070026.2932-1-guoqing.jiang@linux.dev>
References: <20230524070026.2932-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Let's always set errno after pr_err which is consistent with
default case.

Acked-by: Jack Wang <jinpu.wang@ionos.com>
Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
---
 drivers/block/rnbd/rnbd-srv.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.c
index ac2dc692bdc0..a9a506f4f33f 100644
--- a/drivers/block/rnbd/rnbd-srv.c
+++ b/drivers/block/rnbd/rnbd-srv.c
@@ -467,34 +467,33 @@ static int rnbd_srv_check_update_open_perm(struct rnbd_srv_dev *srv_dev,
 					    struct rnbd_srv_session *srv_sess,
 					    enum rnbd_access_mode access_mode)
 {
-	int ret = -EPERM;
+	int ret = 0;
 
 	mutex_lock(&srv_dev->lock);
 
 	switch (access_mode) {
 	case RNBD_ACCESS_RO:
-		ret = 0;
 		break;
 	case RNBD_ACCESS_RW:
 		if (srv_dev->open_write_cnt == 0)  {
 			srv_dev->open_write_cnt++;
-			ret = 0;
 		} else {
 			pr_err("Mapping device '%s' for session %s with RW permissions failed. Device already opened as 'RW' by %d client(s), access mode %s.\n",
 			       srv_dev->name, srv_sess->sessname,
 			       srv_dev->open_write_cnt,
 			       rnbd_access_modes[access_mode].str);
+			ret = -EPERM;
 		}
 		break;
 	case RNBD_ACCESS_MIGRATION:
 		if (srv_dev->open_write_cnt < 2) {
 			srv_dev->open_write_cnt++;
-			ret = 0;
 		} else {
 			pr_err("Mapping device '%s' for session %s with migration permissions failed. Device already opened as 'RW' by %d client(s), access mode %s.\n",
 			       srv_dev->name, srv_sess->sessname,
 			       srv_dev->open_write_cnt,
 			       rnbd_access_modes[access_mode].str);
+			ret = -EPERM;
 		}
 		break;
 	default:
-- 
2.35.3

