Return-Path: <SRS0=Ukdl=Y7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4DEFC5DF61
	for <linux-block@archiver.kernel.org>; Thu,  7 Nov 2019 19:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EC712085B
	for <linux-block@archiver.kernel.org>; Thu,  7 Nov 2019 19:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573153508;
	bh=MhnpgA7Kq4kbS8LrDMHw1jC0IlfelzPYlfzzoAJqYf0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NTr58avhFuhZj+dmugmAyZ3OAi496k7ZG1tPjEd5QpbJPhMQxFAPFZliU67txCYOY
	 kPb7ByTlZVwgE+nDJjmbmuhkytJ4x9iHVqwruZFBm7IGbK7XxMpfOH6OVHqBqKrlCN
	 eRmrBIx66nca2xtY6auU94a1n8PK5Wj+CvMYGBbs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728373AbfKGTFE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 Nov 2019 14:05:04 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:33453 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730178AbfKGTFE (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 Nov 2019 14:05:04 -0500
Received: by mail-qk1-f195.google.com with SMTP id 71so3026442qkl.0;
        Thu, 07 Nov 2019 11:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=D2aZYGhhhD0fueEZXuZZtBxsPvMYXcl+9GQ42VL43KI=;
        b=QMrL5nCAR853//4IbtMGC+V9cyv4Cci7a5ZLezHlo8P+sBwSZ7sdElMR64J11gVzVy
         +jwOVFRlQ856q0LydViBktS8UwVaYvjFOE8Hshwk2Kg7vFAvvi4cycqMZn6M4UAWCAOk
         PeT1uWVTEy/ffwMqLCnEsdpXLFwX2HCynQx+JcUjU+LUgFlomDNbysXZjfEQjPhC59zw
         O2XpzH5to18sUHc//d8yst74RbREs30kLGGRa/MLmBzkn8XRbti2wLANRh0SLmW0ZnAY
         IQNiOZe+U5oyogrSXJDnBlKz0bgOZnAV3g17MmtlrW7o0HwvJmZA2ABKMPy4EkCZv3fy
         jLpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=D2aZYGhhhD0fueEZXuZZtBxsPvMYXcl+9GQ42VL43KI=;
        b=PK5hs8P2lyeP0ENI0SJmWxb0lSmVUlD2kOy7ThllAhp4CJSkQMGX2fXsW+O6a+8E2f
         7Zg1I9qSpbd0JXrAZhgZR03iCXILa4Lxr4D4ec+wFtEKh4vZhbUbytiHME/6ilD/9/2B
         IGAVH1vmNAPbng0sKfmlAXbDiMXGowClvX+N8VX+4FxROJP9s8mhxPH5kxQXKhkQ9+xP
         QIvPyknFDLAgcLJQual4cqzepl4r+T9yZA1KVz2BYMqg1klF5wSvoSnHpU2ksPkuUq3n
         n3WgLWfV7t1WArgjUrjULui1W4MQfiFcxW5v83pNX1l5ohDI83l/jpKoLatXrwxMXvKm
         1v1Q==
X-Gm-Message-State: APjAAAWFgCxEJHle384Ak6iCZeqgiJympf0iesSWBH7oy2r8pecQoyPA
        fjHI/lMa5qw6HWHLdyAlUJk=
X-Google-Smtp-Source: APXvYqzl96Q5hW2MM5DuIR0U3yR8pKDS3P3ZF244FehkB7rIAWEa59eSpL/t9gsb+/nHA8O5jAi9gg==
X-Received: by 2002:a37:4654:: with SMTP id t81mr4466141qka.0.1573153502452;
        Thu, 07 Nov 2019 11:05:02 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::2:3f13])
        by smtp.gmail.com with ESMTPSA id b2sm1834935qtc.21.2019.11.07.11.05.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Nov 2019 11:05:01 -0800 (PST)
Date:   Thu, 7 Nov 2019 11:04:59 -0800
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, lizefan@huawei.com,
        hannes@cmpxchg.org, kernel-team@fb.com
Subject: [PATCH 0.5/5] bfq-iosched: relocate bfqg_*rwstat*() helpers
Message-ID: <20191107190459.GA3622521@devbig004.ftw2.facebook.com>
References: <20191106215838.3973497-1-tj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106215838.3973497-1-tj@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From a7b9100d72d75a1472bed130b6edd271b734776f Mon Sep 17 00:00:00 2001
From: Tejun Heo <tj@kernel.org>
Date: Thu, 7 Nov 2019 11:01:19 -0800

Collect them right under #ifdef CONFIG_BFQ_CGROUP_DEBUG.  The next
patch will use them from !DEBUG path and this makes it easy to move
them out of the ifdef block.

This is pure code reorganization.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
Jens, this is an extra patch to help fixing the build bug when
!CONFIG_BFQ_CGROUP_DEBUG.  The git tree has been updated accordingly.
Please let me know if you want the whole series reposted.

Thanks.

 block/bfq-cgroup.c | 46 +++++++++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index 86a607cf19a1..d4755d4ad009 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -1058,17 +1058,34 @@ static ssize_t bfq_io_set_weight(struct kernfs_open_file *of,
 }
 
 #ifdef CONFIG_BFQ_CGROUP_DEBUG
-static int bfqg_print_stat(struct seq_file *sf, void *v)
+static int bfqg_print_rwstat(struct seq_file *sf, void *v)
 {
-	blkcg_print_blkgs(sf, css_to_blkcg(seq_css(sf)), blkg_prfill_stat,
-			  &blkcg_policy_bfq, seq_cft(sf)->private, false);
+	blkcg_print_blkgs(sf, css_to_blkcg(seq_css(sf)), blkg_prfill_rwstat,
+			  &blkcg_policy_bfq, seq_cft(sf)->private, true);
 	return 0;
 }
 
-static int bfqg_print_rwstat(struct seq_file *sf, void *v)
+static u64 bfqg_prfill_rwstat_recursive(struct seq_file *sf,
+					struct blkg_policy_data *pd, int off)
 {
-	blkcg_print_blkgs(sf, css_to_blkcg(seq_css(sf)), blkg_prfill_rwstat,
-			  &blkcg_policy_bfq, seq_cft(sf)->private, true);
+	struct blkg_rwstat_sample sum;
+
+	blkg_rwstat_recursive_sum(pd_to_blkg(pd), &blkcg_policy_bfq, off, &sum);
+	return __blkg_prfill_rwstat(sf, pd, &sum);
+}
+
+static int bfqg_print_rwstat_recursive(struct seq_file *sf, void *v)
+{
+	blkcg_print_blkgs(sf, css_to_blkcg(seq_css(sf)),
+			  bfqg_prfill_rwstat_recursive, &blkcg_policy_bfq,
+			  seq_cft(sf)->private, true);
+	return 0;
+}
+
+static int bfqg_print_stat(struct seq_file *sf, void *v)
+{
+	blkcg_print_blkgs(sf, css_to_blkcg(seq_css(sf)), blkg_prfill_stat,
+			  &blkcg_policy_bfq, seq_cft(sf)->private, false);
 	return 0;
 }
 
@@ -1097,15 +1114,6 @@ static u64 bfqg_prfill_stat_recursive(struct seq_file *sf,
 	return __blkg_prfill_u64(sf, pd, sum);
 }
 
-static u64 bfqg_prfill_rwstat_recursive(struct seq_file *sf,
-					struct blkg_policy_data *pd, int off)
-{
-	struct blkg_rwstat_sample sum;
-
-	blkg_rwstat_recursive_sum(pd_to_blkg(pd), &blkcg_policy_bfq, off, &sum);
-	return __blkg_prfill_rwstat(sf, pd, &sum);
-}
-
 static int bfqg_print_stat_recursive(struct seq_file *sf, void *v)
 {
 	blkcg_print_blkgs(sf, css_to_blkcg(seq_css(sf)),
@@ -1114,14 +1122,6 @@ static int bfqg_print_stat_recursive(struct seq_file *sf, void *v)
 	return 0;
 }
 
-static int bfqg_print_rwstat_recursive(struct seq_file *sf, void *v)
-{
-	blkcg_print_blkgs(sf, css_to_blkcg(seq_css(sf)),
-			  bfqg_prfill_rwstat_recursive, &blkcg_policy_bfq,
-			  seq_cft(sf)->private, true);
-	return 0;
-}
-
 static u64 bfqg_prfill_sectors(struct seq_file *sf, struct blkg_policy_data *pd,
 			       int off)
 {
-- 
2.17.1
