Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75DD28FFDE
	for <linux-block@vger.kernel.org>; Tue,  4 Mar 2025 15:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741102743; cv=none; b=ESluvRbgVm4hSx8fI4ga+x0gFYRk2e9bpNlX1x7vDDuhd/gL10OM0Z8XRPvsKPmQ3vOl5vRg/ObYFtQ7eNPUs10NTzUp87j+2dKj5oLwCxH2wHi58lsthksRR+MZOv+/vafH6GpL+Fy4Syv5TwU4xZSGpW6tbjdGYXtESvvnA9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741102743; c=relaxed/simple;
	bh=m52peCNVice4dNNY5xbCz5VOoTIMY+0qmJAW8b2N3QY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NTd2fXi+oIGrEdzGFBNLwfC4fAGX1ZH0sjwlGk1xEwlj9GYzM7CaiY5qzlFeY7aP4VvQCAY1/i5/hyhYVWl45BOSlwjEbuELSilefbLyjmFp24G9BZ4PdtCx3Qz6JR7QswYw7dykZ9CJa745UmjW+aClAK0ya2BZnktLGbLI9vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CIjlrGVD; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CIjlrGVD"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4394a0c65fcso62465535e9.1
        for <linux-block@vger.kernel.org>; Tue, 04 Mar 2025 07:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741102740; x=1741707540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K0SMnkypgJ+E0WuuzIPm19tlt9b9dHVVlixZH4mmHVo=;
        b=CIjlrGVD0tl2N1dEl0VymJokuUjMCJi27QUmXaxHeMRaLwon9MBFTUQSJLV9rbUAm9
         avvwf5k/Pc1u5vYR1tpZihY+tzq0nyhjjeP2DmbTdKrEAfkvOSt5S3tZ0jdE3dVMm7DH
         dv6tswX6zFpK7r7/mP+iViWiapeG+9ty+cT4W3kDycLoo+mBRVL52aeWFAwvBUvAZbjC
         3skbz+xMJQjhnrGSZnNIkmXl2Q9RcBhPb3ZG8dXDXe6FgBR7d7J7h/SQicnuPAwPYgZE
         oTlvsQlzzir8ZRPxynCEJreh5tFrBVqRbnLIoYsbgW6HGeAXemeL4RuOKh/T/wKxUbAe
         w4jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741102740; x=1741707540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K0SMnkypgJ+E0WuuzIPm19tlt9b9dHVVlixZH4mmHVo=;
        b=LRaAFD5NQEkO2P1vcTWhpJfE8NSn92VoKKg9S0fMJc48cGzBz+D7/cAePue96WBTll
         2ql6IYOr8LQWhYaHEjqEZJGvhU0XzAZXHYuk9QUyKV2Di13ACg4Yo+8PIZujEnKcJ56p
         V6w5VqzXE9ehKOGHm62L4N+i3plO7y34td61XEGpy4rgzrPeC7Dd5fM0qrjNbdawl53H
         5cnzZOTADSSy+7AEweMbtmS7VwfzWvJlfFZfwOcSTRI6ajNHPjvs7oqtXcmb9YmerYj1
         IKkYgA0s7d+O61W0VT01voZENIIkJdhEkS4dPfkt71LPUgn+7HnjYD9mR8q3KGPnDQF/
         cNkg==
X-Forwarded-Encrypted: i=1; AJvYcCWfFTezicy3V6Snja+FHAMoeotJVQdreuknzbnYTtSP4p1K+RDWXT91D/YqQ3PASF8l4NyQAOVWA0m8QA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxAS+XTewODHXcME+m+eZrGCZYGernzrzeZztCDbnIXu6rxxep7
	bb3nmAGD6cax0oRBAKX1srpAOp59F0rdyUKbOQOEktNRmRVe0R4gByI+ASR1haY=
X-Gm-Gg: ASbGncvBA1AmeEVdtrf1WBSlXQjbEN9dQBzlUNtfi/EFhJwXP9OYEWwesIs3Dfln5QO
	2X3pN+DB74+DH8hejKZCLA8kZNS/7gys7elVBBfuQo4Wr4evCmvIqz1jj0LL6KPzrIbZ1hBnmCL
	o9ovrBjxoQ0fk597xz86tyq+ORs6zCi6VEapbhPCN37fdA5t21wyDitRogH+VDg/7awDoEWt6Z+
	LTvLOtcTQETje8lsTCQF+yaz9wVn0ijrY3vfufDbmXbnlVgVzYvCSkqFJiOFwLUoQvkPpyEiSn3
	q75Ns4PmjDxCSIU3SDBi4uKRv17DtCUGRgEhHDISg3ZcjRE=
X-Google-Smtp-Source: AGHT+IHVsiEQmN3Y21537PIQvBH5PobiQYRSPlH0O79ylXjcUAzUwaUszPliAbCkCArUCFHUG5m/LA==
X-Received: by 2002:a05:600c:4685:b0:439:a0a3:a15 with SMTP id 5b1f17b1804b1-43ba67045camr187495795e9.14.1741102740250;
        Tue, 04 Mar 2025 07:39:00 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba5710ebsm238670625e9.26.2025.03.04.07.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 07:39:00 -0800 (PST)
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Waiman Long <longman@redhat.com>,
	Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Subject: [PATCH 7/9] RFC cgroup/cpuset-v1: Add deprecation warnings to sched_relax_domain_level
Date: Tue,  4 Mar 2025 16:37:59 +0100
Message-ID: <20250304153801.597907-8-mkoutny@suse.com>
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

This is not a properly hierarchical resource, it might be better
implemented based on a sched_attr.

Cc: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 kernel/cgroup/cpuset-v1.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/cgroup/cpuset-v1.c b/kernel/cgroup/cpuset-v1.c
index 6155d890f10a4..ada6fcdffe0b5 100644
--- a/kernel/cgroup/cpuset-v1.c
+++ b/kernel/cgroup/cpuset-v1.c
@@ -175,6 +175,7 @@ static int cpuset_write_s64(struct cgroup_subsys_state *css, struct cftype *cft,
 
 	switch (type) {
 	case FILE_SCHED_RELAX_DOMAIN_LEVEL:
+		pr_warn_once("cpuset.%s is deprecated\n", cft->name);
 		retval = update_relax_domain_level(cs, val);
 		break;
 	default:
-- 
2.48.1

