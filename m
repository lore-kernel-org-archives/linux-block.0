Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D72BC4321E
	for <linux-block@archiver.kernel.org>; Mon, 27 Sep 2021 22:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC60661058
	for <linux-block@archiver.kernel.org>; Mon, 27 Sep 2021 22:02:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237897AbhI0WDp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Sep 2021 18:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237907AbhI0WDb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Sep 2021 18:03:31 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C01C5C061778;
        Mon, 27 Sep 2021 15:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=9EAR2dM9iC7D1FytGy3vTETK1LUd0jxNEcV2YPw5vHw=; b=DgTmAFmzoOT6o9szu1SQMT8/3R
        pNnOwGhGL7lDnadoANDfOdI3eDLJdWhL7ANU6YfKr31Ariuas2/YoOW48oXYv+GgijF5s+yNzGabZ
        iwITAKsF6U8N02Dd61FFi5vRyPpzUkW4THsEIdmhveqjm9OehG21jH+d5oYFI0Hoej42d0oJhXMl9
        l14QcRaqA5bRBZK64CNNFHTm46iDsEy7jeDz3gd0F4HEmlTVLC/jdhDeIts5+3c85NZuCCAiK8MKY
        DPekgxdQKFdGnzqWWvUdNnnLYn4mXUeCZF5WBoZP5SW9h3o0Ejg4wIopQ4l/kgKY38L5fwXBhBxtA
        SBj43BtQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mUygR-004TPM-Pr; Mon, 27 Sep 2021 22:01:11 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk, justin@coraid.com, geert@linux-m68k.org,
        ulf.hansson@linaro.org, hare@suse.de, tj@kernel.org,
        philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
        jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        johannes.berg@intel.com, chris.obbard@collabora.com,
        krisman@collabora.com, zhuyifei1999@gmail.com, thehajime@gmail.com,
        chris@zankel.net, jcmvbkbc@gmail.com, tim@cyberelk.net
Cc:     linux-xtensa@linux-xtensa.org, linux-um@lists.infradead.org,
        linux-m68k@lists.linux-m68k.org, drbd-dev@lists.linbit.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v2 04/15] drbd: add error handling support for add_disk()
Date:   Mon, 27 Sep 2021 15:00:59 -0700
Message-Id: <20210927220110.1066271-5-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210927220110.1066271-1-mcgrof@kernel.org>
References: <20210927220110.1066271-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We never checked for errors on add_disk() as this function
returned void. Now that this is fixed, use the shiny new
error handling.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/block/drbd/drbd_main.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 55234a558e98..19db80a1e409 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -2794,7 +2794,9 @@ enum drbd_ret_code drbd_create_device(struct drbd_config_context *adm_ctx, unsig
 		goto out_idr_remove_vol;
 	}
 
-	add_disk(disk);
+	err = add_disk(disk);
+	if (err)
+		goto out_cleanup_disk;
 
 	/* inherit the connection state */
 	device->state.conn = first_connection(resource)->cstate;
@@ -2808,6 +2810,8 @@ enum drbd_ret_code drbd_create_device(struct drbd_config_context *adm_ctx, unsig
 	drbd_debugfs_device_add(device);
 	return NO_ERROR;
 
+out_cleanup_disk:
+	blk_cleanup_disk(disk);
 out_idr_remove_vol:
 	idr_remove(&connection->peer_devices, vnr);
 out_idr_remove_from_resource:
-- 
2.30.2

