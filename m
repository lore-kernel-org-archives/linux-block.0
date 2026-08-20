Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70E3379C28
	for <linux-block@vger.kernel.org>; Thu, 20 Aug 2026 16:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787241956; cv=none; b=UHgwUMWM3nWD7KI9NHuwnR1k1tQdPWmgQqMS55i4hj/py1uP0OoKB5T/OWSaG7xky60RgqcfoLbYUD5/VgHjMEE2ZAYy1HYbUwV6706yJHGLu805EYbip90DdXelDV2s3QC7O0spPGs9h60ndV2EmwXnBf5qOvXV5cBPNVS+BDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787241956; c=relaxed/simple;
	bh=ocY4xAl8KTcSa9Lp6Zr9McDe1eZy3H0hSEQWeqOtlQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AKXH0djKXXzl3MJJKr0M0Toow8a6Gw0lhPnShdE7e5/HIZcswm4DIIbWb3g0QVQLIpldY0URsXjYGFk3+DG1lSvCHCgI1ZMv3tezKE3ldDt03meI3yhxvJL8zPxVPxY2u6c6nqguCYjd7uYcCAAw/+zpIlLAjIBRmtqBMmq3uhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=Mr2rLnyT; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="Mr2rLnyT"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2d58efc7356so498465ad.1
        for <linux-block@vger.kernel.org>; Thu, 20 Aug 2026 09:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1787241954; x=1787846754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mlfgi87PnjLpHGyk5E+2mv3sr7KAbB8WjHuaKC5SzIE=;
        b=Mr2rLnyTkPncNFUAGGrQQA2jHOmzOvTNl54ujgwaHD4N/3fokBxzP2y/2R2HCg9jyo
         aIpqKT4HChvjYEZTqmbsDmfDqpm79W3gFkQ3SgRilnRwfM5HLwQWxLckAbmE7wkOIHOL
         gPErGOnI1xqFHuNJVGXTdUWLv9Kyzfm7B5ek7/1NFn2MD8VEUheOBIDB7sjarroM/duE
         b1tZ2pfmnITaZxRHgl9yMYJN5asdLOHhp6RyC4xVtlTtFHHU3i4N0gfB4KWRxJ4SHnl9
         SSLynOHndiVLE3IQtASGnHoCTKHyU/8bDSHOE+3s0Ba4B0teivPbEesPIPePUDzqIH0a
         VKzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787241954; x=1787846754;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mlfgi87PnjLpHGyk5E+2mv3sr7KAbB8WjHuaKC5SzIE=;
        b=icUAIQzK7kBVwTML9Tey/RWA5UWRgHSxwwx2FZjOXpx9OX0odqq4aThWgR0mO34roF
         DhOoks/wuLbF2V6hACH3eRyZnI8I0fbFv77XybAbunDkuW+pjdx/iVgxoisAJ7tfJACW
         mf0d+ZdLhYUJr2aua8w3n3l5Ub3PjI7SloDk8pC5LN3IvbslRKIJXOq48as+qZ3rqwEu
         DzeSphBjGIvmLDqKjN8kZ3hT9CTKSxOWdzcOWn4o1IETS1IZDjseMiQ9zEwlBp01//jJ
         aWB1ixgwKFN7x039o+QUUj0jn9p0X2TFkte1x1oqUcs0Uup5P32a5U3BDWfSinCNxkwV
         J5tA==
X-Gm-Message-State: AFuF++mx87Gi9q2vjrNnoYdPb08AmkkJu1qapOMt2iZwscts/h95jjny
	5QrilU0hOMX8eFRFI37/llFQefleIDj2+NRTYmimSk/3ql2zZf5cHMBWeHPO/rJOVtkAF7ccIt4
	4cPfw
X-Gm-Gg: AR+sD11JMzsTzXNAelECYsoamJcs71Jbw0tEHYIW30EQD2oHzk/CfFKxDTozF357gar
	dkOPXLWeLVVKLbr8TgEhY1a1JrgRj+g33rQfF1toGxE1Vr9C/vZBdDne2y3KseVdXYaad+8enXd
	rAX+K+FfndeQdcXNecsOxj2PsJ+3FPj1Dc9OSfDwpS5rtXs40CqrGCpHzM993AWWjX//kqXmvNC
	TtiQzVvMqwQdFyOFqkdhnvDu2nEqS9vFoCobrrm3JCeChZh8ZZw2WJ260Ku7gVOWGBL8MMm4Sc2
	DRTSsxQscKve3Q9R7cAjTS17i7tyekIsr+vS+rJv2rePWWChgvkPTa2aBFs8CT9Itsy7ioUK67l
	1kPIvCwNFAf3KW7b6UkzSt8Ol72sp5SFWBc6jtvlX2syzzAR24ID0+I7cm1F9yNxJnMZxiMNNZH
	QeWC72CYzKjO3ldmV5ydhmI1CIUOvum7IN+T0Mp4GqACt2HA==
X-Received: by 2002:a17:902:f682:b0:2d5:c099:16e2 with SMTP id d9443c01a7336-2d5fd6fbc91mr229316135ad.13.1787241954030;
        Thu, 20 Aug 2026 09:05:54 -0700 (PDT)
Received: from localhost.localdomain ([147.136.157.3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d62e36e20fsm9343015ad.48.2026.08.20.09.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 09:05:53 -0700 (PDT)
From: Tang Yizhou <yizhou.tang@shopee.com>
X-Google-Original-From: Tang Yizhou
To: yukuai@fygo.io,
	tj@kernel.org,
	axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tang Yizhou <yizhou.tang@shopee.com>
Subject: [PATCH] blk-throttle: Remove dead check in tg_conf_updated()
Date: Fri, 21 Aug 2026 00:05:47 +0800
Message-ID: <20260820160547.357682-1-yizhou.tang@shopee.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tang Yizhou <yizhou.tang@shopee.com>

The check in tg_conf_updated() was introduced for io.low, so remove it.

global ? tg->td->queue->root_blkg : tg_to_blkg(tg) was introduced in
commit 9bb67aeb9678 ("blk-throttle: respect 0 bps/iops settings for
io.low"). Remove it, too.

Fixes: bf20ab538c81 ("blk-throttle: remove CONFIG_BLK_DEV_THROTTLING_LOW")
Signed-off-by: Tang Yizhou <yizhou.tang@shopee.com>
---
 block/blk-throttle.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index ffc3b70065d4..fa742e63807d 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -1267,7 +1267,7 @@ static int tg_print_conf_uint(struct seq_file *sf, void *v)
 	return 0;
 }
 
-static void tg_conf_updated(struct throtl_grp *tg, bool global)
+static void tg_conf_updated(struct throtl_grp *tg)
 {
 	struct throtl_service_queue *sq = &tg->service_queue;
 	struct cgroup_subsys_state *pos_css;
@@ -1286,16 +1286,8 @@ static void tg_conf_updated(struct throtl_grp *tg, bool global)
 	 * restrictions in the whole hierarchy and allows them to bypass
 	 * blk-throttle.
 	 */
-	blkg_for_each_descendant_pre(blkg, pos_css,
-			global ? tg->td->queue->root_blkg : tg_to_blkg(tg)) {
-		struct throtl_grp *this_tg = blkg_to_tg(blkg);
-
-		tg_update_has_rules(this_tg);
-		/* ignore root/second level */
-		if (!cgroup_subsys_on_dfl(io_cgrp_subsys) || !blkg->parent ||
-		    !blkg->parent->parent)
-			continue;
-	}
+	blkg_for_each_descendant_pre(blkg, pos_css, tg_to_blkg(tg))
+		tg_update_has_rules(blkg_to_tg(blkg));
 	rcu_read_unlock();
 
 	/*
@@ -1388,7 +1380,7 @@ static ssize_t tg_set_conf(struct kernfs_open_file *of,
 	else
 		*(unsigned int *)((void *)tg + of_cft(of)->private) = v;
 
-	tg_conf_updated(tg, false);
+	tg_conf_updated(tg);
 	ret = 0;
 
 unprep:
@@ -1610,7 +1602,7 @@ static ssize_t tg_set_limit(struct kernfs_open_file *of,
 	tg->iops[READ] = v[2];
 	tg->iops[WRITE] = v[3];
 
-	tg_conf_updated(tg, false);
+	tg_conf_updated(tg);
 	ret = 0;
 unprep:
 	blkg_conf_unprep(&ctx);
-- 
2.43.0

