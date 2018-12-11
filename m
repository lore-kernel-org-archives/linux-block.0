Return-Path: <SRS0=ptgV=OU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2171FC67839
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 23:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAAA22084E
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 23:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544569403;
	bh=1X1Y6bYnn1wLPB+e9qEv06RYdQ29/EZdyWQEmkCpwak=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=1KHgEYv6cSI+Fu/1oJvKVYy2MSfU8cnEiwliDNTV79JOCifsyh88/clbF+VqCqnTg
	 gor8TRM7o4CkITVWrZzxJCggTZKMDeuAzKHUL9q2cE41/qpJQ+bkh7NKOpF38rVoTc
	 My9E5xC5uGq/Zo/CfC5MSlJrYH6Do9bULUH3s8cw=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAAA22084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726209AbeLKXDR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Dec 2018 18:03:17 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:45721 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbeLKXDQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Dec 2018 18:03:16 -0500
Received: by mail-qt1-f193.google.com with SMTP id e5so18427009qtr.12;
        Tue, 11 Dec 2018 15:03:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=puxO2IKeuPOawx9ZdsIf28v5dik70E0wmP0rRCpd2u4=;
        b=sFFLNeKk0lznVawoo2awvgk6aGlfQ0JzSzxy+oNYgAZf36KFTRKWEJoT6d1aFXeNVB
         2kEgPiSgMmjuMwow0uSbrnIYKBcq/C6sP2vm8BZHjByeejPfubTZMyJPfk56UNNwul9L
         v1fEYfPDnrNOerzvMMC/rkpLJ8mHS54d4WMi2zy0Liv0mmulK7Y+Cs0P20Dt+qywMw/0
         4DhILTiNAmpnxTiI7W2tlyuo9CPChhzng1EbgAaqFh5JngXujxBm9ZK3vVzi+BAAwYB+
         QJRUF0ZzAbqXtFnygnj7KjB1k+yjFSspzJG9vrwsLhqyqf85peAtadF+/bDVLYvW2t0A
         /VhQ==
X-Gm-Message-State: AA+aEWbxx2wWuMzgGcSb+O8y/3NvtZkumnTdtvKQcxsNHBgTiOBq8vVs
        C6iutY4xGlOMQxfn39fXC8A=
X-Google-Smtp-Source: AFSGD/XqGjsu2dl3unSdGhUM1EHWX8qf9Ss3EF8HxouvyXzbj3rUHmB01s0xwk9Tdic+bN2nTT6m/A==
X-Received: by 2002:ac8:518d:: with SMTP id c13mr17362217qtn.254.1544569395553;
        Tue, 11 Dec 2018 15:03:15 -0800 (PST)
Received: from dennisz-mbp.thefacebook.com ([199.201.65.135])
        by smtp.gmail.com with ESMTPSA id c48sm10640106qtd.9.2018.12.11.15.03.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 11 Dec 2018 15:03:14 -0800 (PST)
From:   Dennis Zhou <dennis@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     kernel-team@fb.com, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>, Dennis Zhou <dennis@kernel.org>
Subject: [PATCH] blkcg: handle dying request_queue when associating a blkg
Date:   Tue, 11 Dec 2018 18:03:08 -0500
Message-Id: <20181211230308.66276-1-dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Between v3 [1] and v4 [2] of the blkg association series, the
association point moved from generic_make_request_checks(), which is
called after the request enters the queue, to bio_set_dev(), which is when
the bio is formed before submit_bio(). When the request_queue goes away,
the blkgs supporting the request_queue are destroyed and then the
q->root_blkg is set to %NULL.

This patch adds a %NULL check to blkg_tryget_closest() to prevent the
NPE caused by the above. It also adds a guard to see if the
request_queue is dying when creating a blkg to prevent creating a blkg
for a dead request_queue.

[1] https://lore.kernel.org/lkml/20180911184137.35897-1-dennisszhou@gmail.com/
[2] https://lore.kernel.org/lkml/20181126211946.77067-1-dennis@kernel.org/

Fixes: 5cdf2e3fea5e ("blkcg: associate blkg when associating a device")
Reported-and-tested-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Dennis Zhou <dennis@kernel.org>
---
 block/blk-cgroup.c         | 6 ++++++
 include/linux/blk-cgroup.h | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 6bd0619a7d6e..c30661ddc873 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -202,6 +202,12 @@ static struct blkcg_gq *blkg_create(struct blkcg *blkcg,
 	WARN_ON_ONCE(!rcu_read_lock_held());
 	lockdep_assert_held(&q->queue_lock);
 
+	/* request_queue is dying, do not create/recreate a blkg */
+	if (blk_queue_dying(q)) {
+		ret = -ENODEV;
+		goto err_free_blkg;
+	}
+
 	/* blkg holds a reference to blkcg */
 	if (!css_tryget_online(&blkcg->css)) {
 		ret = -ENODEV;
diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index bf13ecb0fe4f..f025fd1e22e6 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -511,7 +511,7 @@ static inline bool blkg_tryget(struct blkcg_gq *blkg)
  */
 static inline struct blkcg_gq *blkg_tryget_closest(struct blkcg_gq *blkg)
 {
-	while (!percpu_ref_tryget(&blkg->refcnt))
+	while (blkg && !percpu_ref_tryget(&blkg->refcnt))
 		blkg = blkg->parent;
 
 	return blkg;
-- 
2.17.1

