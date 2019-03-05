Return-Path: <SRS0=rLai=RI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EE81C43381
	for <linux-block@archiver.kernel.org>; Tue,  5 Mar 2019 12:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 033F7206DD
	for <linux-block@archiver.kernel.org>; Tue,  5 Mar 2019 12:08:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uUBIDOrl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbfCEMIO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 Mar 2019 07:08:14 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38098 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfCEMIO (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 5 Mar 2019 07:08:14 -0500
Received: by mail-pg1-f195.google.com with SMTP id m2so5505485pgl.5;
        Tue, 05 Mar 2019 04:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=YbX8dohfKhgJbE8sNEjSkJQUgJVWArNRmXMlHOj9N1s=;
        b=uUBIDOrlMfhx/C+YVfkEz/llzgP8/nJkRWrjyO2hAv7LmGCGOPk4FgIrPRjZjmXlCm
         DzOQhlFMGu0lJALifZGbjoTO/rw5BS2nzMSqgAIx+6d6oiMNI+lqMrYp+iGKcGwMQXBp
         6n1xygSPVLI343PxMNAMpy3cmZaMNG7EyNWt9Ug4qg3pQphf5KGRrVr4b9TP4NQSZgRe
         1Bj4Et+qRk5fBqTmQPxxeHeFyHugdaJxp3y+zVLvQZlEjj9qrvBcdwI9OWILB0nSbeSp
         d+8iLjFU2Nb0fY1f3zC8JgYvY5A58u+efoA2t7QhPEeZpLzfA+OQSnMV+cn1IghDp961
         AWEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YbX8dohfKhgJbE8sNEjSkJQUgJVWArNRmXMlHOj9N1s=;
        b=G0L96rByG8XejjM3ks4BsOeKjRfUEpH7dCMEJT+GHRKprUnMs4eF0X7yDAdlh+2QDZ
         auG33r5fmOZ96dYphHD3Nn4HxfnxBgZePFAVHjVV0VHKE/ERZ8P6EFEuW6thLDdyRWSz
         rN7uddfCflVjxlgXc2mReqtVy/mbqstg9itigPTxHq4BlQ5QnYp8KIbPQ0gZpL1/Lp+R
         jgaGxjU5Hb3XHSwoHKx/kZUYtg7duDrMyCPdigz3MPfRgVMjtArSAje+6BpAUWGqoffW
         lkUP8Gzp8zi3sOpAgLKPPIscFUpnGXgBoa+EOK362Fv/Yi1WWrj8Gab8i0X2x9G3s5XF
         45yw==
X-Gm-Message-State: APjAAAVH2R5mP44Z5bhnZPZUNjZkCo5/SmtTHmZ4c3o/bF+1OFcwOSoX
        VdDNDSGIrLBAhUYkYpsLNP0=
X-Google-Smtp-Source: APXvYqylLKSBz527Ma7MPjUV5Ks2nmpqWsOtbJdOYkKF0FjDXKQTZ8XZhksm0IPVhD7UCG77BQHkuw==
X-Received: by 2002:a17:902:1002:: with SMTP id b2mr866776pla.248.1551787689169;
        Tue, 05 Mar 2019 04:08:09 -0800 (PST)
Received: from localhost.localdomain (172.96.249.239.16clouds.com. [172.96.249.239])
        by smtp.gmail.com with ESMTPSA id l7sm35688894pfj.162.2019.03.05.04.08.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Mar 2019 04:08:08 -0800 (PST)
From:   Guoju Fang <fangguoju@gmail.com>
To:     colyli@suse.de
Cc:     kent.overstreet@gmail.com, linux-bcache@vger.kernel.org,
        linux-block@vger.kernel.org, Guoju Fang <fangguoju@gmail.com>
Subject: [PATCH 2/2] bcache: fix inaccurate result of unused buckets
Date:   Tue,  5 Mar 2019 07:07:33 -0500
Message-Id: <1551787653-3115-1-git-send-email-fangguoju@gmail.com>
X-Mailer: git-send-email 1.7.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

To get the amount of unused buckets in sysfs_priority_stats, the code
count the buckets which GC_SECTORS_USED is zero. It's correct and should
not be overwritten by the count of buckets which prio is zero.

Signed-off-by: Guoju Fang <fangguoju@gmail.com>
---
 drivers/md/bcache/sysfs.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/md/bcache/sysfs.c b/drivers/md/bcache/sysfs.c
index 557a8a3..b31c9df 100644
--- a/drivers/md/bcache/sysfs.c
+++ b/drivers/md/bcache/sysfs.c
@@ -959,8 +959,6 @@ static int __bch_cache_cmp(const void *l, const void *r)
 		       !cached[n - 1])
 			--n;
 
-		unused = ca->sb.nbuckets - n;
-
 		while (cached < p + n &&
 		       *cached == BTREE_PRIO)
 			cached++, n--;
-- 
1.8.3.1

