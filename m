Return-Path: <SRS0=+4Fh=VV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3925C76186
	for <linux-block@archiver.kernel.org>; Wed, 24 Jul 2019 17:37:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDA4B21926
	for <linux-block@archiver.kernel.org>; Wed, 24 Jul 2019 17:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563989879;
	bh=HU+UJEwKj7oJ8yx1arDBtwt//GkoHkAe1Tgtv1vNwIE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PVLOtDo3reov6LhjvNfvYusPlOf3+0aa9vGtpbkdnqoOlLIzRGxVpsKLwSSok6rbP
	 ynz/EE3MIOiQdJdf1Jn1z+QSXRuD7pfGVo+PEhhiW43FUtzfNooUhM5K6nlzZqJOgR
	 6EDjZaYJfRkftjfazg3fqFzIEtJt8SPM20kkhRbs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbfGXRh7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Jul 2019 13:37:59 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44995 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbfGXRh6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Jul 2019 13:37:58 -0400
Received: by mail-pl1-f196.google.com with SMTP id t14so22248469plr.11;
        Wed, 24 Jul 2019 10:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=210jieYj6x4iDn+RzSO4QMxbDZOJTaHp79XKUEHy4po=;
        b=hEIOZzj60rL78OaSsU8W3pEv0nJLPBgdwJhBm+OTrlPQ4Dd28EfK2xeqNvC+YGG1iS
         o7+D047hKFmZkjPSVvrcm81oE1rDcz+IZmg6FJ/axEGwNDZR95o5vSzbXgpbwrf2/mfc
         z8SddeI9szOe6KIUJ7vMY/XhgwLeyq8qXJzegLuhJRZrhtXpnYfG93bp8qHbj5Z5m+BC
         eGqOrfAFGREptDwpyg3OOnPOGiQK1kk2OIYuZ8WwuEv+wR1kuDyJz5E4YTlRTomysIRU
         LP0OHdDIafKLY5KlYpdPJE9e41tYkm7y46iWC3NOVLtZveI4poFnX5aOg9hOiMzgpwn/
         +9/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=210jieYj6x4iDn+RzSO4QMxbDZOJTaHp79XKUEHy4po=;
        b=P/C3R4isLq1o+mFXfYrNrFyhzJb4hVbwYxGkWIXXSZE598Jfs1hsROXWBnMwkpWtI2
         yqJgLry+LuF+QAUoCEkKV7uobc+mZGOiT9I65ptD8lRgnGUyvLHN0+15nT+taQMwQBs1
         BgUizfAy2AFkgqul34xw8HkSZ+MaOv4adeBKduTBZRGvv6f+LrTIcwYAFEDKmbISm0vl
         I8++DR39U/1mS9MSdnO1GWXRIszaMWugCZUPNSFR7NtTwf5hUCBvAJrT/F/N50IX/MJQ
         z6CPnJ2z4ir7JdZFcs/JZQo4ETGnFZP4W9RI1krTU9vQ1oPEgdHQedi4ju/EFP3AnTRA
         cACQ==
X-Gm-Message-State: APjAAAWiN4LFYeCtgy40kANFvRQOEp1iBEw0ZZxTKFZ/blGdbFaGhhP8
        Iv5eTZAVAekj7ABpOejp6V+sY54+
X-Google-Smtp-Source: APXvYqz22Xp4Bha/kHcoUHwURa5oH9/WA3W1Js1+o3th/+U8OIMfM61Tbdg9ifuIT2cMuqk1plKZQA==
X-Received: by 2002:a17:902:6a87:: with SMTP id n7mr85600071plk.336.1563989877739;
        Wed, 24 Jul 2019 10:37:57 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::2:c91a])
        by smtp.gmail.com with ESMTPSA id d15sm82710266pjc.8.2019.07.24.10.37.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jul 2019 10:37:57 -0700 (PDT)
Date:   Wed, 24 Jul 2019 10:37:55 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 2/2] blkcg: don't offline parent blkcg first
Message-ID: <20190724173755.GB569612@devbig004.ftw2.facebook.com>
References: <20190724173517.GA559934@devbig004.ftw2.facebook.com>
 <20190724173722.GA569612@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190724173722.GA569612@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blkcg->cgwb_refcnt is used to delay blkcg offlining so that blkgs
don't get offlined while there are active cgwbs on them.  However, it
ends up making offlining unordered sometimes causing parents to be
offlined before children.

Let's fix this by making child blkcgs pin the parents' online states.

Note that pin/unpin names are chosen over get/put intentionally
because css uses get/put online for something different.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 block/blk-cgroup.c         |   16 ++++++++++++++++
 include/linux/blk-cgroup.h |    6 +++++-
 2 files changed, 21 insertions(+), 1 deletion(-)

--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1158,6 +1158,21 @@ unlock:
 	return ret;
 }
 
+static int blkcg_css_online(struct cgroup_subsys_state *css)
+{
+	struct blkcg *blkcg = css_to_blkcg(css);
+	struct blkcg *parent = blkcg_parent(blkcg);
+
+	/*
+	 * blkcg_pin_online() is used to delay blkcg offline so that blkgs
+	 * don't go offline while cgwbs are still active on them.  Pin the
+	 * parent so that offline always happens towards the root.
+	 */
+	if (parent)
+		blkcg_pin_online(parent);
+	return 0;
+}
+
 /**
  * blkcg_init_queue - initialize blkcg part of request queue
  * @q: request_queue to initialize
@@ -1300,6 +1315,7 @@ static void blkcg_exit(struct task_struc
 
 struct cgroup_subsys io_cgrp_subsys = {
 	.css_alloc = blkcg_css_alloc,
+	.css_online = blkcg_css_online,
 	.css_offline = blkcg_css_offline,
 	.css_free = blkcg_css_free,
 	.can_attach = blkcg_can_attach,
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -455,8 +455,12 @@ static inline void blkcg_pin_online(stru
  */
 static inline void blkcg_unpin_online(struct blkcg *blkcg)
 {
-	if (refcount_dec_and_test(&blkcg->online_pin))
+	do {
+		if (!refcount_dec_and_test(&blkcg->online_pin))
+			break;
 		blkcg_destroy_blkgs(blkcg);
+		blkcg = blkcg_parent(blkcg);
+	} while (blkcg);
 }
 
 /**
