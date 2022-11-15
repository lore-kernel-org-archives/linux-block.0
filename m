Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B433C43217
	for <linux-block@archiver.kernel.org>; Tue, 15 Nov 2022 13:16:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232437AbiKONQw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Nov 2022 08:16:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbiKONQu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Nov 2022 08:16:50 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C533129344;
        Tue, 15 Nov 2022 05:16:48 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id cl5so24195866wrb.9;
        Tue, 15 Nov 2022 05:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PBoJDQnhlmWZlV1VrcsZgizsnIm6qCYmmX9Ncnb4i4Y=;
        b=dkckIW1PVglmNO6MtTydvtrSHdn8XftgrOE0/j3P3C0l90RJJG+MFkv5wPUKQVyCvL
         ZqsdfvMEgw250jSUd7Yg89ETICa1EpJqkZgH/4lhiF34kqRmCHO76VhmZtIXHLg5jMZo
         ttixW1zvox8Z+GdXVEPHQ9Fqy9HZAhnRT5NjO2elAb/2a+lHYAWvFKvK4XlVZFWKBGrM
         VRlGlVyOgsDPrEzh/Wv4QEk2gR/5j4Z3MR8ZUZsU1C5AjAUWoFWZXvcYQRdC+Wrm2bvj
         J4X6cslSnS7fTd89LOBpxInv/HP8H9xSs51/Zj9oAKaZK6gFTyUHeVVPaAjt+JeV8tiU
         hUeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PBoJDQnhlmWZlV1VrcsZgizsnIm6qCYmmX9Ncnb4i4Y=;
        b=H9eheFE3NnFBCvP0/sxBFmJL54gdaqpVOoxZrgK2SSdASD39nU1FBTaH5GmMS6/FOy
         dV1gfKBPhCwu8yO3UWycmnpdpzYipuVkvqoc+BQ0EIER239snh9CObSAmcz6TvgI7KF9
         sUQ1jn5lgDhkKCqQ/Z+TLWLnurCDuDMWajJU6XR1BRAyyEvJJhA/dKzHVx+d1YwNWAU/
         rafoD2Dzc/JAsfqyaTfMNSDr+YpCEsLbVWgmPf1SDN24e+c4UYsaYxA9TFoUVdtY3zwO
         uQH9dVC6I1Xz9uypt0SumeYnnHiQeLeMOc6XfZpT2McRUzaab+oxk7KJLBLS6zWhlaSb
         ZgdA==
X-Gm-Message-State: ANoB5pnFdwegCertKCI+5/jn7442z6hmGE54mDhaBT3NHFi+9aVPKFhR
        RabeLqN2Yn5tBXLMIL14eNc=
X-Google-Smtp-Source: AA0mqf4oQzxbBTQYDlzEXnGARcEIi7wxDyi7MBe1ZuPB1+4ZO4/fj69rdF4JEloD5NtpcD7tQQqBGg==
X-Received: by 2002:adf:a3de:0:b0:236:5655:13a5 with SMTP id m30-20020adfa3de000000b00236565513a5mr10625325wrb.477.1668518207324;
        Tue, 15 Nov 2022 05:16:47 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id n18-20020a7bcbd2000000b003cf9bf5208esm20580871wmi.19.2022.11.15.05.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 05:16:47 -0800 (PST)
Date:   Tue, 15 Nov 2022 16:16:43 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Philipp Reisner <philipp.reisner@linbit.com>
Cc:     Lars Ellenberg <lars.ellenberg@linbit.com>,
        Christoph =?iso-8859-1?Q?B=F6hmwalder?= 
        <christoph.boehmwalder@linbit.com>, Jens Axboe <axboe@kernel.dk>,
        Andreas Gruenbacher <agruen@linbit.com>,
        drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] drbd: use after free in drbd_create_device()
Message-ID: <Y3Jd5iZRbNQ9w6gm@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The drbd_destroy_connection() frees the "connection" so use the _safe()
iterator to prevent a use after free.

Fixes: b6f85ef9538b ("drbd: Iterate over all connections")
Signed-off-by: Dan Carpenter <error27@gmail.com>
---
Smatch assumes that kref_put() generally calls the free function so it
gets very confused by drbd_delete_device() which calls:

	kref_put(&device->kref, drbd_destroy_device);

Four times in a row.  (Smatch has some checking for incremented
reference counts but even there it assumes that people are going to hold
one reference and not four).

drivers/block/drbd/drbd_main.c:2831 drbd_delete_device() error: dereferencing freed memory 'device'
drivers/block/drbd/drbd_main.c:2833 drbd_delete_device() warn: passing freed memory 'device'
drivers/block/drbd/drbd_main.c:2835 drbd_delete_device() error: dereferencing freed memory 'device'

The drbd_adm_get_status_all() function makes me itch as well.  It seems
like we drop a reference and then take it again?

drivers/block/drbd/drbd_nl.c:4019 drbd_adm_get_status_all() warn: 'resource' was already freed.
drivers/block/drbd/drbd_nl.c:4021 drbd_adm_get_status_all() warn: 'resource' was already freed.

 drivers/block/drbd/drbd_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index f3e4db16fd07..8532b839a343 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -2672,7 +2672,7 @@ static int init_submitter(struct drbd_device *device)
 enum drbd_ret_code drbd_create_device(struct drbd_config_context *adm_ctx, unsigned int minor)
 {
 	struct drbd_resource *resource = adm_ctx->resource;
-	struct drbd_connection *connection;
+	struct drbd_connection *connection, *n;
 	struct drbd_device *device;
 	struct drbd_peer_device *peer_device, *tmp_peer_device;
 	struct gendisk *disk;
@@ -2789,7 +2789,7 @@ enum drbd_ret_code drbd_create_device(struct drbd_config_context *adm_ctx, unsig
 	return NO_ERROR;
 
 out_idr_remove_from_resource:
-	for_each_connection(connection, resource) {
+	for_each_connection_safe(connection, n, resource) {
 		peer_device = idr_remove(&connection->peer_devices, vnr);
 		if (peer_device)
 			kref_put(&connection->kref, drbd_destroy_connection);
-- 
2.35.1

