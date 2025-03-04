Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31262836B6
	for <linux-block@vger.kernel.org>; Tue,  4 Mar 2025 15:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741102735; cv=none; b=AaE4HqsqXsFH2G6uiak1KB+3PFGNDk1pz3Jkh4nLErAp2rv0cnOCMXy81eg9vufvpyd1GRxIKS/MREF57cs6h/dN1BT0GX4UVmw6hhjR3W/+RXZbmvSqkD+saDWpqBRQrzG6qcMycdnryNatrQv0clE7+NWNwUKDBPww+plWKB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741102735; c=relaxed/simple;
	bh=sBkomMAtTTGImKblWaof3H+sklb+CZPuq62TvsZ9BT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VipyhSIPjsrDuINCzuz6BwolVZ1VeN6s/8UI2c3i+g6eh6bihimNHExUnxyHc81NivJE/N9CsskRI+pKdTJcoQECJW0x565nh3HnP+efaERGifqeBDkxtnWm2KkMF15HKEE7CN2Qn/4q3pUGYLe1LaBYqOLwaz7L1n+Q1rL9P5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ggFXJvHB; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ggFXJvHB"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43bc4b16135so13883755e9.1
        for <linux-block@vger.kernel.org>; Tue, 04 Mar 2025 07:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741102732; x=1741707532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NEhwpcuno0WFjY8t9/+hary0RYULU8RVoeuO+wPInIQ=;
        b=ggFXJvHBhk3FyOTugMTLumv9ejhutG93f2c2njr6QhGBm/HpbSfBjnShqdQnZLjEay
         IrNcwvkou/rQNukBMJ0xRX9qpPYt0lbfP3Zqc0+Czb58++kGoiqZ0zzHFP4BpnjAFFz3
         DV+u0dp/I2Kl9Ru1/GC5+n3M0VIXZh2MPR9mt3614qMuBLatnBZt8YYt02b2XC3BJFY4
         wbyLyU5dWlkDHSg+NU4QAXhVpFYyN8UFtnhX9mSjCU57kiVW/J1bArNbm5hCbsnoF1do
         nk8bih0klWP0Le1l6FCGeBxFwLMSGBp1pQ4b2w0mezqruH2+3tL6wT6VCvV1faX67TqZ
         oSww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741102732; x=1741707532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NEhwpcuno0WFjY8t9/+hary0RYULU8RVoeuO+wPInIQ=;
        b=Olk5imW4lBPYbGVY9dxuVXts0XaJ68/0UI5RcdseizqImtPGu7O9Eo109kin78P9YX
         yp8fFnHQwSAv4SeVdKRnkGOSbrZ0FjmT6/LJhjdoYpvaNaL8P+hn2tYTaoxeAg5fJi6b
         zdR3glBDt5v32eD7+u7n+QMxQue8sVaKDLpWcb1a7qDzq8DiWTAi5TjP1n8oQfY2gS8Y
         XuYoSzyq9FYQx9/MsrVL+EtdJQQP1Prm6ALMdd9ZWMlT7a/1SBk++n/9SKWSYi47Nj8U
         MUE1OG0v8QvprdMdOS8UEH3TS5IUoy/1stfBLGjCr1z2p7d9fCXnBu9b72KK/ClQwrG0
         Vkcw==
X-Forwarded-Encrypted: i=1; AJvYcCU68x1/OR+FVWyEhbIngxRAR9ujL3a9NM6RI3yblbxZtCLk91PmoIuhLzQxaGbpskrr94KFiNMJHXjRoQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwIUEvxoUv675H2YS2zsJBO+o8VmTq+ilF+viial+V83nwxxyqd
	nTo0qVPh5yWfGQyPL4JtiEk0vh0mK7++KYBHM47c61ZqE954hDuFeU9Fh/lQRu8Qm/ROxsS8IHM
	Xt3o=
X-Gm-Gg: ASbGnctYaeIS67sfOZwS8DWZ2lvJV4RrdK+kQaaBdLWLGJhP0BlqvD5ybUPT/UfB2kF
	WN+3GAGfWHS9xEr1zmFN+CGXV/QKmF9xcHaw0mFiPlQC3DWKBghxIZDonq79/mOD4WrM+Z9LJ7Y
	EGVLBLndo930FbO2ydpVLpt/XfUjwDbaJDqNEU10jp8HyW38IX6a9oSwb0qUC/3i1G3K7ZsVo6A
	tdnBnWR7p16ayAQSUm2T6MN2POmWVX788PgqNf5Gj9NQGzjD7Eam0O7cjlXDwaMQGPEBM1DNVla
	cKdaa4UWF9q1JsePJZMZQOzyDUGMNotfkJ7CDXwMoFy4+/8=
X-Google-Smtp-Source: AGHT+IEK7ULJaNBAjTgJI8C4sH5VL3JYp9ZcoPsT94hUTXeN1rzXj0hOcFllyp1216i8WCkMP8FL8A==
X-Received: by 2002:a05:600c:3ca3:b0:439:930a:58aa with SMTP id 5b1f17b1804b1-43ba665e31dmr166089505e9.0.1741102732343;
        Tue, 04 Mar 2025 07:38:52 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba5710ebsm238670625e9.26.2025.03.04.07.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 07:38:52 -0800 (PST)
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH 4/9] cgroup: Print warning when /proc/cgroups is read on v2-only system
Date: Tue,  4 Mar 2025 16:37:56 +0100
Message-ID: <20250304153801.597907-5-mkoutny@suse.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250304153801.597907-1-mkoutny@suse.com>
References: <20250304153801.597907-1-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

As a followup to commits 6c2920926b10e ("cgroup: replace
unified-hierarchy.txt with a proper cgroup v2 documentation") and
ab03125268679 ("cgroup: Show # of subsystem CSSes in cgroup.stat"),
add a runtime message to users who read status of controllers in
/proc/cgroups on v2-only system. The detection is based on a)
no controllers are attached to v1, b) default hierarchy is mounted (the
latter is for setups that neven mount v2 but read /proc/cgroups upon
boot when controllers default to v2).

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 kernel/cgroup/cgroup-internal.h | 1 +
 kernel/cgroup/cgroup-v1.c       | 7 +++++++
 kernel/cgroup/cgroup.c          | 2 +-
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/cgroup/cgroup-internal.h b/kernel/cgroup/cgroup-internal.h
index c964dd7ff967a..95ab39e1ec8f0 100644
--- a/kernel/cgroup/cgroup-internal.h
+++ b/kernel/cgroup/cgroup-internal.h
@@ -168,6 +168,7 @@ struct cgroup_mgctx {
 
 extern struct cgroup_subsys *cgroup_subsys[];
 extern struct list_head cgroup_roots;
+extern bool cgrp_dfl_visible;
 
 /* iterate across the hierarchies */
 #define for_each_root(root)						\
diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index e28d5f0d20ed0..5c59b01024019 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -673,6 +673,7 @@ struct cftype cgroup1_base_files[] = {
 int proc_cgroupstats_show(struct seq_file *m, void *v)
 {
 	struct cgroup_subsys *ss;
+	bool cgrp_v1_visible = false;
 	int i;
 
 	seq_puts(m, "#subsys_name\thierarchy\tnum_cgroups\tenabled\n");
@@ -684,12 +685,18 @@ int proc_cgroupstats_show(struct seq_file *m, void *v)
 	for_each_subsys(ss, i) {
 		if (cgroup1_subsys_absent(ss))
 			continue;
+		cgrp_v1_visible |= ss->root != &cgrp_dfl_root;
+
 		seq_printf(m, "%s\t%d\t%d\t%d\n",
 			   ss->legacy_name, ss->root->hierarchy_id,
 			   atomic_read(&ss->root->nr_cgrps),
 			   cgroup_ssid_enabled(i));
 	}
 
+	if (cgrp_dfl_visible && !cgrp_v1_visible)
+		pr_warn_once("/proc/cgroups lists only v1 controllers, use cgroup.controllers of root cgroup for v2 info\n");
+
+
 	return 0;
 }
 
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index afc665b7b1fe5..3a5af0fc544a6 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -171,7 +171,7 @@ EXPORT_SYMBOL_GPL(cgrp_dfl_root);
  * The default hierarchy always exists but is hidden until mounted for the
  * first time.  This is for backward compatibility.
  */
-static bool cgrp_dfl_visible;
+bool cgrp_dfl_visible;
 
 /* some controllers are not supported in the default hierarchy */
 static u16 cgrp_dfl_inhibit_ss_mask;
-- 
2.48.1

