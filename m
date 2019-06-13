Return-Path: <SRS0=P8f/=UM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DDAEC31E45
	for <linux-block@archiver.kernel.org>; Thu, 13 Jun 2019 22:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 419F421721
	for <linux-block@archiver.kernel.org>; Thu, 13 Jun 2019 22:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560465070;
	bh=PkAdJEEYl25Ep8Dtb0M3Q+8CbkQxM/4Dbif7qWytSQI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QOVMQpLbGdrDTwe7GzhuhuXH5zrzWm4OZDZ2Z5egzErnICZwLnTxjMaL+IT/XRNzO
	 OmeJZCSiCMUEvfh8gcLNU+YM+w8rNgu9J3BOMiANwwos1WVHmVlOXuTrf/Ba2Agts+
	 875pBdCBnb8ZeW0zVvn7sHMvyLrH/QsYfSJl56pw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbfFMWbB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Jun 2019 18:31:01 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40348 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbfFMWbA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Jun 2019 18:31:00 -0400
Received: by mail-pl1-f196.google.com with SMTP id a93so121294pla.7;
        Thu, 13 Jun 2019 15:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SW004P2kUZFhq26joJF3aZTb2ovRGvIncM6yZ2HqmDc=;
        b=P3TDFl+tAqBFM8496Jwc336A96WWau7dy/XVEIlZt5uRlyL8jReC6uRnXOtBTEtBGT
         AgxpjF5YqLRTfJFqIJ2hPPY16H6j9W5GXZbwJXWYZC/Sh74zdh6drtw+KZ2R1d461//C
         rXicRohQ9x8UbJGoALL5SyMAtjIpwxyx08qqFK65Q/lycd2Zm1jhzNbxWW9LCUoaI+v/
         FlwButjb3nUeNM9LDeIUiQqY4JxSQ/lC4icM01OHYueUdPbMETf1KSIEdjHTJN6ITeEb
         N4kB5rdx3yUrPpeEj24Qo/PEu87UFBJdXtRHSJkk9LfNjVy/0cakDcpT9OgmKMBByXV3
         d2kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=SW004P2kUZFhq26joJF3aZTb2ovRGvIncM6yZ2HqmDc=;
        b=JwO4vKoaMtC2xCr7wpSw7vt7L4H+4QUeUwZ8ZNNc2NEZTLIkj8v759zp8fe0uVtyDA
         wrQAPI8tYjNVuzRIMQeJPkC1bTBDSWNUvNJInVP4MNL8GSCONJ1ELR9EBtow2FTgHPGy
         6Y7tOZAsRapml1Wri40/BIZv8lTnYjwqPGV1iz6iY7tTtqDOBUr5J+LLi716MtCLs7jc
         /wq2VAsMIhmAHPAgf2GYYhGFqtsHLF8yHolPsD/nkth5yD2lIkY+VDXarwqO+wLuxwE8
         Mq+gUOnNbVpXBmeWZafIqUlePwggirpt/SVsMiA7kK1hwpAAY2L4vDkYPIvIXEjgETFI
         mgNA==
X-Gm-Message-State: APjAAAVyRNt1bWXlfUxoczLUWkIRj5lxXw1CQX+axhh4ogz2U00Xud/H
        Pk4NBGl5JlKJi4Thx512xF0=
X-Google-Smtp-Source: APXvYqxnao7H/n6B+XShXOd03Mre/F8ZkzymGqNfNyfhgt472pOZPOSkN6RMgpDo2hoDy4nf+DuENg==
X-Received: by 2002:a17:902:9041:: with SMTP id w1mr76775412plz.132.1560465059545;
        Thu, 13 Jun 2019 15:30:59 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::2:9d14])
        by smtp.gmail.com with ESMTPSA id l8sm749127pgb.76.2019.06.13.15.30.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 15:30:59 -0700 (PDT)
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk, jbacik@fb.com
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        kernel-team@fb.com, dennis@kernel.org, jack@suse.cz,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 4/5] blkcg: blkcg_activate_policy() should initialize ancestors first
Date:   Thu, 13 Jun 2019 15:30:40 -0700
Message-Id: <20190613223041.606735-5-tj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190613223041.606735-1-tj@kernel.org>
References: <20190613223041.606735-1-tj@kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When blkcg_activate_policy() is creating blkg_policy_data for existing
blkgs, it did in the wrong order - descendants first.  Fix it.  None
of the existing controllers seem affected by this.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 block/blk-cgroup.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 04d286934c5e..440797293235 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1390,7 +1390,8 @@ int blkcg_activate_policy(struct request_queue *q,
 
 	spin_lock_irq(&q->queue_lock);
 
-	list_for_each_entry(blkg, &q->blkg_list, q_node) {
+	/* blkg_list is pushed at the head, reverse walk to init parents first */
+	list_for_each_entry_reverse(blkg, &q->blkg_list, q_node) {
 		struct blkg_policy_data *pd;
 
 		if (blkg->pd[pol->plid])
-- 
2.17.1

