Received: from mail-pj2-f39.google.com (mail-pj2-f39.google.com [74.125.227.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157764E73AC
	for <linux-block@vger.kernel.org>; Tue, 29 Sep 2026 23:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790724260; cv=none; b=ebvRgoSFW5bc3zvY6TsPXv33fD3mO+yU/ryAcM1r7XlmfyCIBMb2gz7Ipu5iFO1+j5zic1MvbnDHBecKvIpyrxCYhanG58/OUAODEOzzIKl/74BbM4SIzRsqPwrNrMijfugtfNw266quhAI4tmedmcFbD6XsPcFhaERm4IVG3FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790724260; c=relaxed/simple;
	bh=LgWd2u8T3YWbYCyxO85qNd7/8gnpOPW0sYJNS4gdAEk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n9NWERgMBzWNTDCs9YJJbyUDsDHvxqqa5BoZK6iDAFwNXJoigaPh6bQhghn8Jzto65QpcWuIXjbqXt2SqSh24RaxwfGXRTvnlq00gkS0jvbDh/AY1LSRwRW+xa3heYJsoFuM81qbXo88nO16dlxt2aYyHYrvuAkAdn6WzbbXg0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OpLMx7yW; arc=none smtp.client-ip=74.125.227.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OpLMx7yW"
Received: by mail-pj2-f39.google.com with SMTP id 98e67ed59e1d1-3a49b6bb21eso1072989a91.3
        for <linux-block@vger.kernel.org>; Tue, 29 Sep 2026 16:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790724258; x=1791329058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LqO5rqFvyRue6UM+wZoeSHLBr6tsHYDgvKbTW7jcYak=;
        b=OpLMx7yW8t6g48M0kgM7me/z/rrlbS8uv5IdFzZimSnmdXfh2NJh5xUtJ3KPyxPUba
         VnMn7xngHLsFLkXgMhYAH1AtYjnhJKoh0KcbHi75Z+MflHaT/KBYvEpLrrwAOsNz/7lT
         uyVj/O3XDUSswiu6dbWgqCY5fLLHeaWMCXi63jy/uPefjYBTQky4EBWxzw2hxFA9IADq
         RaIAcp6WR6nxuRMjPlUcbf3LPYRqhMzYQSZ2jjz0nN3TvHNAIfdogoY7ZZGlyTk1OL52
         gfP9WXFejO+qKcZszjZlPr3K2727QFTR3xS812Xwnwyw+xUw+KjuWnVLDPP1wTCR7OfV
         IvxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790724258; x=1791329058;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LqO5rqFvyRue6UM+wZoeSHLBr6tsHYDgvKbTW7jcYak=;
        b=yDN+VEXeAAYWKyTXFGlFKpnDhEsFdUzUqA4QzzVQFhlswC9pX3lH1w8glcUht4H1+e
         ml5f+gndkIu88e+qA/5mAYvrBDiCCW8aE53zP0gLDcRBD19JIsduFKLfBXtHTSKm5OMd
         omg1ZXuIRyT6LCI1WMo7pnGznPlxqPIhV6Q+J1ZfMCUf4NuC8xk+Y7DOG5XB2Ogg8gov
         dic2qt5i2xjFiAiFhzueL4NlN/aOev1B6Y6dKWXATZBj7ryABQWH1fGb0Ua6z/A6Eckz
         IYKUqCiDO1/TkuB5YntYJ+qL8bNkQeZW88bnTWYj0/yAkLHoo7rV4Pb7KlrFTh7UNWPa
         tShA==
X-Forwarded-Encrypted: i=1; AKwUvBxo7WCWxcPhyqeJBBA/FhkuEh/sgrFiQW+Eh0adotZX7vmHjmqz9QwcOkuM7Ec+aWkTCZ5iUUPXhJy76A==@vger.kernel.org
X-Gm-Message-State: AFq9FYIjHi6Mc8fcTYYusRqvtl6KRHF2cKqdQwB5incZlI20qieCrdw0
	Ar3B3daQwW1YYczs1JwQJuzmRagAPBcwXIws3MHnCDIy8DbdqnnShzli
X-Gm-Gg: AYBFou2R9WVrpkuDrHizkhMWZpdvUzmf7oo6UVPBI8UbreKhZhTFEUd8ZzFBt7I88Ng
	s3hmNxMsjG9Bxla6ZmV2dbRj9WKCODUDW33ojGrW9ulnJidHydV5uNAQFb7NVoTUL+8MU2vvifv
	KCve4jRTqIkTekNsTtn4fXDF3Ws15/q7pKu4HUv7eD8ejhItfeYXICMUd+fpOy2+ZWqJXGFiU8v
	HXSvnGnO0oLqGpfQUBDJY24WpCPx73VRu54gn6B6ryz+tG7BZk72aEGKeqX80Ixa1kXaBjXMjyT
	CKJJFvBRLn+gJl2KKrdrHci/mGeGBv8OU0Yk39vglTt64zLIQmikuDiEgKJqiZzjcmfJJMLe3B/
	Gy9EpZCXUrQaG4gpqBgwlbFXb7Eqc9rJIxFpxS3oDl1Ssd3kfQAdO7fK7SfzDvURnpQV/mrIMIC
	X1iCcJDi+91eYShZJQuewveAniUwjXamFanaCTQFBqSBGbMl4+PsUwrEtXL7L2OI36LbtMt6Y+2
	a9ctXaqv3aWb0lvXUcdxiHLlvtbqtEBcMkG0P4625/ZVjxtjqoI9orGh0DSGmE4NSNsb1RcoxCH
	ViE=
X-Received: by 2002:a17:90a:d448:b0:3a2:b036:ed62 with SMTP id 98e67ed59e1d1-3a4bff0ef48mr451780a91.37.1790724258206;
        Tue, 29 Sep 2026 16:24:18 -0700 (PDT)
Received: from yupeng-XPS-15-9520.. (c-73-169-192-12.hsd1.wa.comcast.net. [73.169.192.12])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4ca78102csm138700a91.4.2026.09.29.16.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 16:24:17 -0700 (PDT)
From: Peng Yu <yupeng0921@gmail.com>
To: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>,
	Maurizio Lombardi <mlombard@arkamax.eu>,
	cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Peng Yu <yupeng0921@gmail.com>
Subject: [PATCH v7 1/2] cgroup: track the effective css in each cgroup
Date: Tue, 29 Sep 2026 16:24:10 -0700
Message-ID: <20260929232411.101087-2-yupeng0921@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929232411.101087-1-yupeng0921@gmail.com>
References: <20260929232411.101087-1-yupeng0921@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cgroup_e_css() and cgroup_get_e_css() find the effective css by walking
up the hierarchy until they reach a cgroup that has the subsystem
enabled. Per-I/O users such as nvmet need this lookup to be O(1).

Track the effective css in each cgroup and make cgroup_e_css() and
cgroup_get_e_css() use it. When a css is brought online or offline,
update the effective css of its cgroup and of all descendants.

Signed-off-by: Peng Yu <yupeng0921@gmail.com>
Assisted-by: Claude:claude-fable-5 [Claude Code]
Assisted-by: Claude:claude-opus-5-5 [Claude Code]
---
 include/linux/cgroup-defs.h |  8 +++++
 kernel/cgroup/cgroup.c      | 60 ++++++++++++++++++++++++-------------
 2 files changed, 47 insertions(+), 21 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 3754d697854b..cbfe8937647c 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -555,6 +555,14 @@ struct cgroup {
 	/* Private pointers for each registered subsystem */
 	struct cgroup_subsys_state __rcu *subsys[CGROUP_SUBSYS_COUNT];
 
+	/*
+	 * Effective css for each subsystem: the css of the nearest ancestor,
+	 * including this cgroup, that has the subsystem enabled, or the root
+	 * css if the subsystem isn't bound to this hierarchy. Updated under
+	 * cgroup_mutex and read under RCU.
+	 */
+	struct cgroup_subsys_state __rcu *e_css[CGROUP_SUBSYS_COUNT];
+
 	/*
 	 * Keep track of total number of dying CSSes at and below this cgroup.
 	 * Protected by cgroup_mutex.
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 2d532bf2c0c7..54b207d246bd 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -548,20 +548,11 @@ static struct cgroup_subsys_state *cgroup_e_css_by_mask(struct cgroup *cgrp,
 struct cgroup_subsys_state *cgroup_e_css(struct cgroup *cgrp,
 					 struct cgroup_subsys *ss)
 {
-	struct cgroup_subsys_state *css;
-
 	if (!CGROUP_HAS_SUBSYS_CONFIG)
 		return NULL;
 
-	do {
-		css = cgroup_css(cgrp, ss);
-
-		if (css)
-			return css;
-		cgrp = cgroup_parent(cgrp);
-	} while (cgrp);
-
-	return init_css_set.subsys[ss->id];
+	return rcu_dereference_check(cgrp->e_css[ss->id],
+				     lockdep_is_held(&cgroup_mutex));
 }
 
 /**
@@ -585,17 +576,10 @@ struct cgroup_subsys_state *cgroup_get_e_css(struct cgroup *cgrp,
 
 	rcu_read_lock();
 
-	do {
-		css = cgroup_css(cgrp, ss);
-
-		if (css && css_tryget_online(css))
-			goto out_unlock;
-		cgrp = cgroup_parent(cgrp);
-	} while (cgrp);
+	css = cgroup_e_css(cgrp, ss);
+	while (!css_tryget_online(css))
+		css = cgroup_e_css(cgroup_parent(css->cgroup), ss);
 
-	css = init_css_set.subsys[ss->id];
-	css_get(css);
-out_unlock:
 	rcu_read_unlock();
 	return css;
 }
@@ -2131,12 +2115,24 @@ void init_cgroup_root(struct cgroup_fs_context *ctx)
 {
 	struct cgroup_root *root = ctx->root;
 	struct cgroup *cgrp = &root->cgrp;
+	struct cgroup_subsys *ss;
+	int ssid;
 
 	INIT_LIST_HEAD_RCU(&root->root_list);
 	atomic_set(&root->nr_cgrps, 1);
 	cgrp->root = root;
 	init_cgroup_housekeeping(cgrp);
 
+	/*
+	 * A root cgroup's effective css is always the root css in
+	 * init_css_set.subsys[], whichever hierarchy the subsystem is bound
+	 * to, so rebind_subsystems() doesn't need to update e_css[]. For
+	 * cgrp_dfl_root this runs before the root csses exist, and
+	 * online_css() sets the entries when they come online.
+	 */
+	for_each_subsys(ss, ssid)
+		RCU_INIT_POINTER(cgrp->e_css[ssid], init_css_set.subsys[ssid]);
+
 	/* DYNMODS must be modified through cgroup_favor_dynmods() */
 	root->flags = ctx->flags & ~CGRP_ROOT_FAVOR_DYNMODS;
 	if (ctx->release_agent)
@@ -5856,6 +5852,22 @@ static void init_and_link_css(struct cgroup_subsys_state *css,
 	BUG_ON(cgroup_css(cgrp, ss));
 }
 
+static void cgroup_update_e_css(struct cgroup *cgrp, struct cgroup_subsys *ss)
+{
+	struct cgroup_subsys_state *d_css;
+
+	lockdep_assert_held(&cgroup_mutex);
+
+	css_for_each_descendant_pre(d_css, &cgrp->self) {
+		struct cgroup *dsct = d_css->cgroup;
+		struct cgroup_subsys_state *css = cgroup_css(dsct, ss);
+
+		if (!css)
+			css = cgroup_e_css(cgroup_parent(dsct), ss);
+		rcu_assign_pointer(dsct->e_css[ss->id], css);
+	}
+}
+
 /* invoke ->css_online() on a new CSS and mark it online if successful */
 static int online_css(struct cgroup_subsys_state *css)
 {
@@ -5869,6 +5881,7 @@ static int online_css(struct cgroup_subsys_state *css)
 	if (!ret) {
 		css->flags |= CSS_ONLINE;
 		rcu_assign_pointer(css->cgroup->subsys[ss->id], css);
+		cgroup_update_e_css(css->cgroup, ss);
 
 		atomic_inc(&css->online_cnt);
 		if (css->parent) {
@@ -5895,6 +5908,7 @@ static void offline_css(struct cgroup_subsys_state *css)
 
 	css->flags &= ~CSS_ONLINE;
 	RCU_INIT_POINTER(css->cgroup->subsys[ss->id], NULL);
+	cgroup_update_e_css(css->cgroup, ss);
 
 	wake_up_all(&css->cgroup->offline_waitq);
 }
@@ -5966,6 +5980,7 @@ static struct cgroup *cgroup_create(struct cgroup *parent, const char *name,
 {
 	struct cgroup_root *root = parent->root;
 	struct cgroup *cgrp, *tcgrp;
+	struct cgroup_subsys *ss;
 	struct kernfs_node *kn;
 	int i, level = parent->level + 1;
 	int ret;
@@ -6010,6 +6025,9 @@ static struct cgroup *cgroup_create(struct cgroup *parent, const char *name,
 	for (tcgrp = cgrp; tcgrp; tcgrp = cgroup_parent(tcgrp))
 		cgrp->ancestors[tcgrp->level] = tcgrp;
 
+	for_each_subsys(ss, i)
+		RCU_INIT_POINTER(cgrp->e_css[i], cgroup_e_css(parent, ss));
+
 	/*
 	 * New cgroup inherits effective freeze counter, and
 	 * if the parent has to be frozen, the child has too.
-- 
2.53.0

