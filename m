Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068A0357CF0
	for <linux-block@vger.kernel.org>; Wed, 13 May 2026 10:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778667607; cv=none; b=GVtNOoDif2Hk8cNkgwm9l6a5FVATC5Azyu3qhd6IiJwV4xHE/zLdOR1mu5LnEwLvjRQsAdZjTm3vuAIHjrHagC4IpGYFuiM+AN5zED/5tkx/rYe/eOATPLVvcdzL5K28Me+zVOBjgKxDnSDMOQuBVD5Rp1LhutDJ/zEkRFmqIZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778667607; c=relaxed/simple;
	bh=9O/ByyTjR5hQcZ8eHedaVJ9XSoFhGhwvsKna6u5iA2o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eteHwBiEaIt8uUDzpSZPv/KSIFZNYBOwQddAF5UcBvDr0o3iwyEi7L/46JcLJpwL3w40r0kHs08iDcOJmjMY5s3WUj2EVBT/wzCpmAU7hqPRj8xAwqtNEPmMVb+COsT/lhd/zaLwqmOgLdH/MqQltEshy+UvKje6CeUwjDALtSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qoHe0+pS; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qoHe0+pS"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-479e4835e26so3843304b6e.3
        for <linux-block@vger.kernel.org>; Wed, 13 May 2026 03:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778667605; x=1779272405; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gR+gtngooxa/nHLqh1DnOE/foegyL9NTKh+M8csAVZI=;
        b=qoHe0+pSR+ymo3SY8wtOQVkCQ8byLiHLdjBhZW9sZGZP4to3Fj+UxbU9FARgviHpvY
         oc8NcdtKw59JbX8wtRY0gHB4ag+eoGORuqtrq++hF08fEZaa8O9vNw99Y2mn8WehtRDD
         hnwPRs1ATrD4ZeZqmb61feH1E2HyV52J6gX+ETnHWP6JOdGMgXoWdkSP0xjwZxDzdu4q
         pclhBMwcHgSByfzbmbi7mSJQXFbT9tbnvYyuq/ZE59VNrQdvqOklVt5shq/DMW7HuDjw
         GowicLaLZOywlqSVsL+XSuveXdq3ed3OQXiXOaU2wJff2fjRtg6j9phC3trGSY99QkOH
         kGYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778667605; x=1779272405;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gR+gtngooxa/nHLqh1DnOE/foegyL9NTKh+M8csAVZI=;
        b=lX8ZSsvTiegAiKouAaGNr4kn76AorV+UAC0cHB62isb09t52ahuDqr9Iw1T+qqMdgu
         t+MvSUj08Ljvas3cYv/VI/r5LstylWQ9xUJ6uCrecLWj465CLWrkxunj9YIKzIAmNsW+
         qK4V8zHOeu1ntotMJCbPVwBxGJV3RWtPJbOT/OdiSZP1izSNGL3F+3OO9XRcBZWiDtET
         hH+NjvEYX/ZKBOrifZFsyxZKX48vGeHARHkn7ybvb71yg7hQS+iDyYH4tyVjEurjAzzl
         FdoAK3aYfQsXL1M9AeHHmcvmxr0ajIDfFvHIV2ZrNwV64F52JGpBkgyy5DUUsyENUnIT
         e9yQ==
X-Forwarded-Encrypted: i=1; AFNElJ8OWEclSO0lVH/BFZ5rm0hxUA1/z3T+GgfJkwKzT2aY2S+4Prt9mY1RkO6Wim43oPh3XmiPMNIBOx/9Hg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwYOHqATXrfL8TXsv2S6ZTKKiM08Grh8OIih0jX0aDuYS4u1kz6
	7yTNNuJcaRYbcGDcunx5GBfnGw4cDv8zl0gAw9ssZnz14Nx9SQhjwRJx
X-Gm-Gg: Acq92OGCCWFmydCz+du+Z6yjCf1FV5CYzCa5s1oUz35PAhjWSyM6RJz8DdI6FkmGZTf
	boq6eLGEPOOUFJFlWW4CR5bNJ3gmGVQSqdXd6wZTJEZRiAJhBNkzng/JaeS3o2sVNltv+ZAw3oa
	dXP5b3BlNHZmMaRvbPE1NYa3ShZrRvauRkmFc2SfQW3f1l9uOQ9Ub7bek5o2Hy3fci5Mg1hcmCD
	xsvQm21R5HujsmUeR4WoVXDHR7L6YcIxCWLmlmTucYTeEip3JZOmk0pDFEmAgkBVrirDXuWc+4I
	LoGH8VFpP8A+rBZa4s38M2TRNPYpRsKEARbTCJbdLCQ6cQgYQZJ/4pZRWhEZozqrESrHLhucnmX
	QXBD0s5BK7tVg7PD9C9KTDeoVg9h6s2b5QxnspP9vytE6oSFnay/B9yI05AsAr0HNIXX6MEgc/w
	SpvhqNLQkE442ua2azbObTTULTy3uUCWTpfp497SCOl11dfuX+g9mSPH+opjIu6sXfnjggM6BNS
	/HnYdmXcKuqyCbOEpEI
X-Received: by 2002:a05:6808:148f:b0:467:281e:3d85 with SMTP id 5614622812f47-482b2cb2ad5mr1810724b6e.29.1778667604798;
        Wed, 13 May 2026 03:20:04 -0700 (PDT)
Received: from fedora ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-47c763b32dbsm24645971b6e.3.2026.05.13.03.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 03:20:04 -0700 (PDT)
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <tom.leiming@gmail.com>
Subject: [PATCH V2] selftests: ublk: cap nthreads to kernel's actual nr_hw_queues
Date: Wed, 13 May 2026 18:19:40 +0800
Message-ID: <20260513101941.1373998-1-tom.leiming@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dev->nthreads is derived from the user-requested queue count before the
ADD command, but the kernel may reduce nr_hw_queues (capped to
nr_cpu_ids). When the VM has fewer CPUs than requested queues, the
daemon creates more handler threads than there are kernel queues.

In non-batch mode, the extra threads access uninitialized queues
(q_depth=0), submit zero io_uring SQEs, and block forever in
io_cqring_wait. In batch mode, the extra threads cause similar hangs
during device removal.

In both cases, the stuck threads prevent the daemon from closing the
char device, holding the last ublk_device reference and causing
ublk_ctrl_del_dev() to hang in wait_event_interruptible().

Fix by capping dev->nthreads to the kernel-returned nr_hw_queues after
the ADD command completes. per_io_tasks mode is excluded because threads
interleave across all queues, so nthreads > nr_hw_queues is valid.

Fixes: abe54c160346 ("selftests: ublk: kublk: decouple ublk_queues from ublk server threads")
Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
V2:
	- fix email address & signed-off-by

 tools/testing/selftests/ublk/kublk.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
index fbd9b1e7342a..0b23c09daea5 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -1735,6 +1735,17 @@ static int __cmd_dev_add(const struct dev_ctx *ctx)
 		goto fail;
 	}
 
+	/*
+	 * The kernel may reduce nr_hw_queues (e.g. capped to nr_cpu_ids).
+	 * Cap nthreads to the actual queue count to avoid creating extra
+	 * handler threads that will hang during device removal.
+	 *
+	 * per_io_tasks mode is excluded: threads interleave across all
+	 * queues so nthreads > nr_hw_queues is valid and intentional.
+	 */
+	if (!ctx->per_io_tasks && dev->nthreads > info->nr_hw_queues)
+		dev->nthreads = info->nr_hw_queues;
+
 	ret = ublk_start_daemon(ctx, dev);
 	ublk_dbg(UBLK_DBG_DEV, "%s: daemon exit %d\n", __func__, ret);
 	if (ret < 0)
-- 
2.53.0

