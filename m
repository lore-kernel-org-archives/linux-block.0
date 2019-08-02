Return-Path: <SRS0=5K92=V6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAA59C32750
	for <linux-block@archiver.kernel.org>; Fri,  2 Aug 2019 19:08:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC7F320B7C
	for <linux-block@archiver.kernel.org>; Fri,  2 Aug 2019 19:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564772897;
	bh=CsffykniwlTR3rvuw5e4RdykOop71bDHLXneOB9IolA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kGhKiF7PNKrmQJ3QT7nspkvpRtwJNSyxeQJGlGrluj0Q4d88JLy/F/s1JKc8N4kxq
	 +R4w/QRYewEcFt2gYsa/62TrZXpWSMwxPqVIl3MVdFeg5asBsvHjNkwgySmVWY2gmo
	 TjqsCSfu/duUySu/RFHSJb/N7WC0PwLE79nS/udw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbfHBTIR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 2 Aug 2019 15:08:17 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:35040 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbfHBTIQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 2 Aug 2019 15:08:16 -0400
Received: by mail-qk1-f194.google.com with SMTP id r21so55700912qke.2;
        Fri, 02 Aug 2019 12:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bg0IYF6s1vKTQqCOaTbUbf6y5ZEAOUzglk0PVhrL/38=;
        b=glnSl1NWmZ0mA06pxO5NHcGHYLGSDwCYCk/lpygM3hxebdjzwZ5c9BT/0rVS0KRQSO
         vqi0RMww/iVfyDm53cDgznuv6lJmZSUElxWkFtkwGBC7HXv3MauHjfH1kZBfVno4qqNq
         Y/5L6tSxXegWmVMoAF0PLhqqO3NaA7vZqe3ZDaEmNZAMRViBgsk1i7sHYjxg4jXlzglN
         WRkJ1GC+jvZEpr424Rs9LV5Fa6L6Se02pQ8Dkpy4UeuLVvaOmsMnhyY4rrwIr4Cu/34D
         XatcJnT31nWYAqOxuQhEGnwi/uBE6DuFDvgUaJkBgkrtbHkKL4UG5rFY42lGVPdLUqce
         OZmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=bg0IYF6s1vKTQqCOaTbUbf6y5ZEAOUzglk0PVhrL/38=;
        b=JIQyOYoBxwwCNCrndDlVUm/zFOiJv8xu8REDo9TBH/QFAwtVxYaq2QUhYmmmE5QR+a
         drbFc72oYjUBzNe61pnNLNZCittnoRswO/EzyQ16Q5zuo7MVRF2HzEp7E+1gvONf96uk
         Ebtu7SIa+6219eyRU+VYdfc2y4BmBNWxRjcMaxoW+qZ0aZefGGKSaFlhaB63LHHW6reo
         K6slMZCxn/REinQFhF/OeFX4FO2e1lxWbK8jyMd2Z2/Gx4oBOnZfaaK3g1vRuZXAPnu0
         uOuLOc3G81P+V7Og5Aa4wsEqOwbaUtSH2L+84M9QbqLtrY1N78L3jTeMVgUlVDkZUNdt
         +Rbw==
X-Gm-Message-State: APjAAAUx8tmiuD0i9R6u2QZwmbSCKZSQEM3ngAy8y9H5oW2khjWyQQOv
        7f94xBEtJ6sNNs73e9VpTfI=
X-Google-Smtp-Source: APXvYqxgawn9tHsWo/hnfD4MDtBAftgnXje7tfHbQ08P5aSqCvzWjxnLHZsE1oZzyNlm82t1vBerUg==
X-Received: by 2002:a37:a142:: with SMTP id k63mr8115850qke.278.1564772895730;
        Fri, 02 Aug 2019 12:08:15 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::38f0])
        by smtp.gmail.com with ESMTPSA id f25sm38408246qta.81.2019.08.02.12.08.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Aug 2019 12:08:15 -0700 (PDT)
Date:   Fri, 2 Aug 2019 12:08:13 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>
Cc:     linux-block@vger.kernel.org, kernel-team@fb.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH block 2/2] writeback, cgroup: inode_switch_wbs() shouldn't
 give up on wb_switch_rwsem trylock fail
Message-ID: <20190802190813.GC136335@devbig004.ftw2.facebook.com>
References: <20190802190738.GB136335@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190802190738.GB136335@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

As inode wb switching may make sync(2) miss some inodes, they're
synchronized using wb_switch_rwsem so that no wb switching happens
while sync(2) is in progress.  In addition to synchronizing the actual
switching, the rwsem is also used to prevent queueing new switch
attempts while sync(2) is in progress.  This is to avoid queueing too
many instances while the rwsem is held by sync(2).  Unfortunately,
this is too agressive and can block wb switching for a long time if
sync(2) is frequent.

The goal is avoiding expolding the number of scheduled switches, not
avoiding scheduling anything.  Let's use wb_switch_rwsem only for
synchronizing the actual switching and sync(2) and use
isw_nr_in_flight instead for limiting the maximum number of scheduled
switches.  The limit is set to 1024 which should be more than enough
while still avoiding extreme situations.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 fs/fs-writeback.c |   17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -237,6 +237,7 @@ static void wb_wait_for_completion(struc
 					/* if foreign slots >= 8, switch */
 #define WB_FRN_HIST_MAX_SLOTS	(WB_FRN_HIST_THR_SLOTS / 2 + 1)
 					/* one round can affect upto 5 slots */
+#define WB_FRN_MAX_IN_FLIGHT	1024	/* don't queue too many concurrently */
 
 static atomic_t isw_nr_in_flight = ATOMIC_INIT(0);
 static struct workqueue_struct *isw_wq;
@@ -489,18 +490,13 @@ static void inode_switch_wbs(struct inod
 	if (inode->i_state & I_WB_SWITCH)
 		return;
 
-	/*
-	 * Avoid starting new switches while sync_inodes_sb() is in
-	 * progress.  Otherwise, if the down_write protected issue path
-	 * blocks heavily, we might end up starting a large number of
-	 * switches which will block on the rwsem.
-	 */
-	if (!down_read_trylock(&bdi->wb_switch_rwsem))
+	/* avoid queueing a new switch if too many are already in flight */
+	if (atomic_read(&isw_nr_in_flight) > WB_FRN_MAX_IN_FLIGHT)
 		return;
 
 	isw = kzalloc(sizeof(*isw), GFP_ATOMIC);
 	if (!isw)
-		goto out_unlock;
+		return;
 
 	/* find and pin the new wb */
 	rcu_read_lock();
@@ -534,15 +530,12 @@ static void inode_switch_wbs(struct inod
 	call_rcu(&isw->rcu_head, inode_switch_wbs_rcu_fn);
 
 	atomic_inc(&isw_nr_in_flight);
-
-	goto out_unlock;
+	return;
 
 out_free:
 	if (isw->new_wb)
 		wb_put(isw->new_wb);
 	kfree(isw);
-out_unlock:
-	up_read(&bdi->wb_switch_rwsem);
 }
 
 /**
