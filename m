Return-Path: <SRS0=ppXp=VU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF58EC76186
	for <linux-block@archiver.kernel.org>; Tue, 23 Jul 2019 23:02:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C28972238C
	for <linux-block@archiver.kernel.org>; Tue, 23 Jul 2019 23:02:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z8CkXQHt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389523AbfGWXCM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Jul 2019 19:02:12 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:38138 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392608AbfGWXCG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Jul 2019 19:02:06 -0400
Received: by mail-io1-f67.google.com with SMTP id j6so10304752ioa.5;
        Tue, 23 Jul 2019 16:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=WLivNX+IOU3BF5pVPZ4dT2PGyWr1z46q52x8JkbNVPY=;
        b=Z8CkXQHtW2MsPGieVx6RX8eY6KKzotV/eE19hybmIqhS5dToSWjnczzuz+1Uhz6rrh
         zxz4ZMS9cEwRPfXnSTKOW5vFjehBiljmlg3X5Oymz/MvTObEZ5yIV0dYXCM0cOuYiM47
         0+DQlGJ16dCKLm+K09Sdb6aVtLmafnOddQhhRip9PBFKIb7qv7GjaliBMwqhpP4po6ho
         2bd5iFeZBYllACr5dGiIlaK2i6/PSoPpL6wa1FI+xK2R7S7a/siCQNUhBTukQufvqygC
         aeugjPFBUR4ng4oCJi5khHw2z0OogUaddtLA//mvVhVcIGG4HRoj5TT20nHyXs3rDOX2
         bsdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WLivNX+IOU3BF5pVPZ4dT2PGyWr1z46q52x8JkbNVPY=;
        b=WkFxVBxusoF8J4Rg2YejSuqnlOJCCChR/cjTmBJ/gSDlvad64JjnBgjrfwwt4vqDo+
         66XxGvbr67AERM/eox8lN+7xKiSGYu1OPIGr9jHbmVR2JwyAsrnWd8RBEQ1/P2sedxRS
         7BDKu2GuZRUPB0NjRsxa2dHU2M13NHM2PBPGR4y+P5wUxVOGoR78mgUZNMXycACRjL3Y
         jU5QZjArFc6+xHE2DK5Wg58MPBUyaSbEtaIoz4BukKt+Vf3maPpa4bv5XRhlPVSnEecd
         IhZMQqPSUlYxsHWLnALWLUvy+cLQsWK7tcK5vnOkCWnJnKZf/ZLisKyivn0gCUHaXuOn
         w53g==
X-Gm-Message-State: APjAAAUgH9tKjb7EMCT2Jck0fvnMoyUEK+SrL4nxqbH4KnwkjgwleKu3
        1+ZUOUnI5nmgdlhCqVTCcM0=
X-Google-Smtp-Source: APXvYqx+pftMEVYYB/3f9Gf0UovCtgpLezh4sifw7pJ/oYZWL0Q9aQ7ncsyrdWy5Sdc+AS5N6YhmHw==
X-Received: by 2002:a02:37d6:: with SMTP id r205mr80277850jar.57.1563922925974;
        Tue, 23 Jul 2019 16:02:05 -0700 (PDT)
Received: from cs-dulles.cs.umn.edu (cs-dulles.cs.umn.edu. [128.101.35.54])
        by smtp.googlemail.com with ESMTPSA id m10sm84918390ioj.75.2019.07.23.16.02.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jul 2019 16:02:05 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     emamd001@umn.edu, kjlu@umn.edu, smccaman@umn.edu,
        secalert@redhat.com, Navid Emamdoost <navid.emamdoost@gmail.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        nbd@other.debian.org, linux-kernel@vger.kernel.org
Subject: [PATCH] nbd_genl_status: null check for nla_nest_start
Date:   Tue, 23 Jul 2019 18:01:57 -0500
Message-Id: <20190723230157.14484-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

nla_nest_start may fail and return NULL. The check is inserted, and
errno is selected based on other call sites within the same source code.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 drivers/block/nbd.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 9bcde2325893..dba362de4d91 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -2149,6 +2149,12 @@ static int nbd_genl_status(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	dev_list = nla_nest_start_noflag(reply, NBD_ATTR_DEVICE_LIST);
+
+	if (!dev_list) {
+		ret = -EMSGSIZE;
+		goto out;
+	}
+
 	if (index == -1) {
 		ret = idr_for_each(&nbd_index_idr, &status_cb, reply);
 		if (ret) {
-- 
2.17.1

