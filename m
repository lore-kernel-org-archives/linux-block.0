Return-Path: <SRS0=yWSg=4X=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0613FC10DCE
	for <linux-block@archiver.kernel.org>; Fri,  6 Mar 2020 12:28:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6BDE2072A
	for <linux-block@archiver.kernel.org>; Fri,  6 Mar 2020 12:28:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ShIPKgee"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbgCFM2T (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 6 Mar 2020 07:28:19 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51753 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbgCFM2S (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 6 Mar 2020 07:28:18 -0500
Received: by mail-wm1-f65.google.com with SMTP id a132so2204283wme.1;
        Fri, 06 Mar 2020 04:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Rf+ut+vZ0rkmAH/Rce7x5xKiOiWUHGb8d9Igi14P9Lw=;
        b=ShIPKgeeGOieT6zOaPe7N1NG1+rDBuRiuiFsuB2sNIxLmjxU9SVQI4d5nMsN1AbIVS
         Vj77ogg71rIo51YRkAdwbdDOmP+FWH2OvCvPbbjly0b3JNScZFUdVpvifLABRMIdHsRs
         AgeuXspkx0YFf8DeEY1JgjOBFXWe7GMl40w1X8BDvK2HSZLkny2GA3w3vuyzqUkd+Acl
         qy8fbSC3OlK/xw2XRYiwMGLBrHkXzEskdV9DOmDB9m8LnoE+rSzCce4SWfMg3xyBhGCM
         2O5fFRiPd6QYwyZxzPzqx5VRlefFdTggo6oGEdf3kX9uMaNFbEJTuc2VeWshTgWVn4y2
         dbZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Rf+ut+vZ0rkmAH/Rce7x5xKiOiWUHGb8d9Igi14P9Lw=;
        b=X1pPTR/F/Zek1c1eO/Z95iAWMUmeT1HLoCQ+8lfI9MKqZisVW7l1G6AfPs29TDdkof
         ObXZ1fkaJ6+HwiPbLh6Wyk9D7rcOSmhT4AF5IglnERZVc929ZgjVN5tecfTmtLPqW/Yl
         oHKp1AfiJ12hYmT2EX4zlkBwPZg8p16fzW2ZeUjyrjrdCOJA2URMNpnBv+u+NsQzkp+8
         y4juGsJ2qU7ZkpLJNruhG6dcpUTpmZfOVrYJSmGONp7KdDH5vBQv3hTFzN6scXBlEm3E
         UQYRhFcycvBo2B8X8fJ6z3ERYP27ItGRzo7wN2U5Fguuq8PF8iIpUgopqoycQ7QAIVkE
         WJuQ==
X-Gm-Message-State: ANhLgQ1YJLBNnMQz59ABNee1wkQSmyVzItYXQzd+Cy39Oe4nFI4e15es
        kpUnSgFydPNdC5K/57Ou+xw=
X-Google-Smtp-Source: ADFU+vundmXwCIOo1hsTfe/Ixwo+XAdsK/Si1RgR3BqBdiUhttzsZkQCvxzoZMNDXR/i7Il3mpTZ7Q==
X-Received: by 2002:a7b:cc6a:: with SMTP id n10mr3829347wmj.170.1583497696717;
        Fri, 06 Mar 2020 04:28:16 -0800 (PST)
Received: from carlo-arch.lan ([2001:b07:6469:6bad:29c8:57ea:bea1:b9b1])
        by smtp.gmail.com with ESMTPSA id c62sm13763876wmd.7.2020.03.06.04.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2020 04:28:16 -0800 (PST)
From:   Carlo Nonato <carlo.nonato95@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
        Kwon Je Oh <kwonje.oh2@gmail.com>
Subject: [PATCH BUGFIX] block, bfq: fix overwrite of bfq_group pointer in bfq_find_set_group()
Date:   Fri,  6 Mar 2020 13:27:31 +0100
Message-Id: <20200306122731.5945-1-carlo.nonato95@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The bfq_find_set_group() function takes as input a blkcg (which represents
a cgroup) and retrieves the corresponding bfq_group, then it updates the
bfq internal group hierarchy (see comments inside the function for why
this is needed) and finally it returns the bfq_group.
In the hierarchy update cycle, the pointer holding the correct bfq_group
that has to be returned is mistakenly used to traverse the hierarchy
bottom to top, meaning that in each iteration it gets overwritten with the
parent of the current group. Since the update cycle stops at root's
children (depth = 2), the overwrite becomes a problem only if the blkcg
describes a cgroup at a hierarchy level deeper than that (depth > 2). In
this case the root's child that happens to be also an ancestor of the
correct bfq_group is returned. The main consequence is that processes
contained in a cgroup at depth greater than 2 are wrongly placed in the
group described above by BFQ.

This commits fixes this problem by using a different bfq_group pointer in
the update cycle in order to avoid the overwrite of the variable holding
the original group reference.

Reported-by: Kwon Je Oh <kwonje.oh2@gmail.com>
Signed-off-by: Carlo Nonato <carlo.nonato95@gmail.com>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-cgroup.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index 09b69a3ed..f0ff6654a 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -610,12 +610,13 @@ struct bfq_group *bfq_find_set_group(struct bfq_data *bfqd,
 	 */
 	entity = &bfqg->entity;
 	for_each_entity(entity) {
-		bfqg = container_of(entity, struct bfq_group, entity);
-		if (bfqg != bfqd->root_group) {
-			parent = bfqg_parent(bfqg);
+		struct bfq_group *curr_bfqg = container_of(entity,
+						struct bfq_group, entity);
+		if (curr_bfqg != bfqd->root_group) {
+			parent = bfqg_parent(curr_bfqg);
 			if (!parent)
 				parent = bfqd->root_group;
-			bfq_group_set_parent(bfqg, parent);
+			bfq_group_set_parent(curr_bfqg, parent);
 		}
 	}
 
-- 
2.25.1

