Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675BA28369E
	for <linux-block@vger.kernel.org>; Tue,  4 Mar 2025 15:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741102730; cv=none; b=juRXIvxZzosTBif8yof3TEvKWib/xoAwO9WXl4T8v/+LXk/JEcw8aLw3RyxZNvziWKi7lRp/EimneFRd/3mIrrAsZgWGu4wNDGil+u+QsVs0RpxDufojz1RixCxzbwIh016wV0MOtt+d25YLiokSYrbzmqfhVvc5pgjs3Z2L1L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741102730; c=relaxed/simple;
	bh=j/4wLCwQln8i7pXmi4m03KiQwQyMuLnJxfUl/0RP5OU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WwTMoEy9IDu2yYRHq8yVO5gGpAWbFDFsCIorxOA6EJ5+b6Dp9Sw0jiajxBHntqwNRKDGUPk7wrENtMNpNx80bqvelv97ZgzheVkb3x4TrowTJj0zuX2OJ4eprdLSM+8aaQVTOyF/ttjt9EfT8r0VUy6fSVm/VtgqeFyxiOtS/E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=N2HYJLli; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="N2HYJLli"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-38a8b17d7a7so3440160f8f.2
        for <linux-block@vger.kernel.org>; Tue, 04 Mar 2025 07:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741102726; x=1741707526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OFPt2CI1XVgWzStHf0nCdXSR4n5UutvMSPTp/cgKSsU=;
        b=N2HYJLliJ9A/Tj6vHsUxVN93UT6Fy84xy/lYFyQ6ldK6DNjsMaczFQGZMBa5eG3til
         TxjVJcEVt109Wx4/gTU7rImxV+PeSWDaAAZPLZ8IF7lrNqPHMhwBqva0pe3wU/rfMRf0
         A0cO8qitFhDk7ArJRt0GzDrNfy+8cUP9v3HdBFeinJIn3MTFE+NMe0BFFgRVbKMb7wEb
         FxJRXU7CFz0yeLT6Xh+yKL+NCGqb2SIO5c7DIq4iKi9ckOJOjXMXuI3AJ0HEAwt8wJ0s
         tUSYJc4nUVdesSKpY99OtF7rygHU51W7uItPGvwpXKmG1aV7Wv57WtRvJ401A80GcQoF
         PVfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741102726; x=1741707526;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OFPt2CI1XVgWzStHf0nCdXSR4n5UutvMSPTp/cgKSsU=;
        b=RugUj5qQ+WHg/yeOCdSxD8FyhpxC3zaUSjO/jaE3PdRztlXswZr3HGYWu24tujgzFd
         mmAheDkEn77oNxXNuBvgqg6okEcfrrSKdTa73eJiJ5daZSt7/N1a9YCidgXci4DvyWLJ
         mE25xSzWNjXwUQnBsGAGfqQMlZou81V6xr24nqLkQPDGq7aBlRdROo5mwD6FcQPG4EIt
         zGYPoAZOCa4Q9MTBR5AjWSQT8WfzxCuE4lAEkmEURgW4xAzwvRVUOqdOHimdzjERekni
         dcfE3+9BPm45KkUclsnYkr+uGQdr1L2eDtFaoK5CLae851WG3Q/M8YQzu5LYR7VYmj44
         0ZnQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/tFC5n1ZB9CNbIdelWp/saEgh3b7QuFVyyT/y3TJ0fyE+fZzGd9p8KBQIK30fCFmOUQRttrYUq/IyLw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyUXy4Q8AT6BRvIt9c44YKKOqQAuR/O15/1C447AanImE4PAFPF
	bB/IRhkUIS9mBtuRzxWR8uFyywGTm0RgN4QZKQikoVzxjEEK5lVIWb1aw4I2EGs=
X-Gm-Gg: ASbGncuvO2smLf/oG0CNRbH/4aRq9DGM4DBnvC4Tr2VGkyRCDVDzHrQPbRT6c7TL014
	suzl2A5UFKXQbqjBTyQ+k8wDtKB2Q9Nal7cLtKgMmyXj8PHUJ8tpJg5W8zaKB8sD3Yl8+z0dzzd
	56/GYzbqEDOSa2koJVGhcMZmLFOBpBC+UBq15Ej1IQ/HOeF3+CbVbJwfQBUV3GLC5+e+Qj8Ry49
	csrnd9niPd+ok/xn9cD8/Wy3O0EuXPA5UqsLEejZVTW6FifzMgFjO6/NJt3ISALK+HGYqq5cOBo
	2TDK1k5TRWtgUUOc/l2NvWMbWr5qvS8m2pjebLqMtIPItpk=
X-Google-Smtp-Source: AGHT+IFzh8tpm5PJ+6KB1qG+RR0gOraUB8vKw1xBf/Zc44nQ/d4j9J/DEIN5yaKw5Z2Ch0s1pQhPNw==
X-Received: by 2002:a5d:5849:0:b0:391:268:6475 with SMTP id ffacd0b85a97d-391026866f1mr5796830f8f.20.1741102725724;
        Tue, 04 Mar 2025 07:38:45 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba5710ebsm238670625e9.26.2025.03.04.07.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 07:38:45 -0800 (PST)
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
Subject: [PATCH 2/9] cgroup/cpuset-v1: Add deprecation warnings to memory_spread_page and memory_spread_slab
Date: Tue,  4 Mar 2025 16:37:54 +0100
Message-ID: <20250304153801.597907-3-mkoutny@suse.com>
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

There is MPOL_INTERLEAVE for user explicit allocations.
Deprecate spreading of allocations that users carry out unwittingly.

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 kernel/cgroup/cpuset-v1.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/cgroup/cpuset-v1.c b/kernel/cgroup/cpuset-v1.c
index 3e81ac76578c7..9aae6dabb0b56 100644
--- a/kernel/cgroup/cpuset-v1.c
+++ b/kernel/cgroup/cpuset-v1.c
@@ -441,9 +441,11 @@ static int cpuset_write_u64(struct cgroup_subsys_state *css, struct cftype *cft,
 		cpuset_memory_pressure_enabled = !!val;
 		break;
 	case FILE_SPREAD_PAGE:
+		pr_warn_once("cpuset.%s is deprecated\n", cft->name);
 		retval = cpuset_update_flag(CS_SPREAD_PAGE, cs, val);
 		break;
 	case FILE_SPREAD_SLAB:
+		pr_warn_once("cpuset.%s is deprecated\n", cft->name);
 		retval = cpuset_update_flag(CS_SPREAD_SLAB, cs, val);
 		break;
 	default:
-- 
2.48.1

