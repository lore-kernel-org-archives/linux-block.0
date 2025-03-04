Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3BE2857E9
	for <linux-block@vger.kernel.org>; Tue,  4 Mar 2025 15:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741102740; cv=none; b=frgN/OWrb/VNADvHnRs94EzDq/Ey+8IZFHZ60MGIplEQqNA/mJPd3Ebk5+ovYMD9abmCA/RJEIFKTOUtRelSXu1AdcjIxXZrz2oCb8Aubv2CZupwXaoBXCMOlSQHpfCZZo0l3Q+B33zqcPo4bpaGrPKnB9WZTE3dMTUD8k8EAz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741102740; c=relaxed/simple;
	bh=cHns8fqxRp7euip5mPfMcCQkmw1AJFKlvqhDmvw49+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FXyAaTaEt/nb9fbn4crXT9FNsVuKpaBMfTjwKObflSbqcvQRK+kR7jp1GjVOpJItO+rHM6TFMcBMFhmzlezfx1h301R5Nj9urdPqeHpUzrhbgs7+QNi+LujgM7TcpqEzj28l7V2ZVX440JnoRSv3OBmREOhiHd/sR3a724ADgLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MSKlbFbn; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MSKlbFbn"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4394a823036so54473425e9.0
        for <linux-block@vger.kernel.org>; Tue, 04 Mar 2025 07:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741102736; x=1741707536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wBPZZxD2lIKyHp8wqmCpoZT9q9nUxOdWhcx01NnsOjw=;
        b=MSKlbFbnpfmgz5nTwVs4Oufvas/KA4uM8n/f8oKuhd0j8Cwhhr6BwiXr9DWVb5PqaX
         uY+3ytvDvyPecRbxdLSJW08F3hJ59jTE4HIBM1p295lyRMQhUvBrZfRbtdaSA4H0IEEN
         AzPXgGtJZAuHmpWFDWmX7vw8fUayakPRoU2j+gPF1Y7R/0HWxSF9p4xGonAqC8Zb9fm7
         WifCTiRhX8J4re/aRNwWYFHhSAKSaVIz9LnzB1Mn97OUs2OejYMZdWdSgCYobWz8Hhod
         C5KmKSam97nGoHYyfD9EBpXjhFXrUqnShXakh8FYTp4n6C48JTohRc2cw67bf067eug1
         fFdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741102736; x=1741707536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wBPZZxD2lIKyHp8wqmCpoZT9q9nUxOdWhcx01NnsOjw=;
        b=lSdUk1Oaq4LDhZidp3YR7/T+TacnhC9zCr5VzqDj9U0oiVaLJ7Wt0W8dm5yPZEQNKi
         oZnBldJl4aPRXp3ksWH2xN1fH6lQkAwpb/O9XRBfXnic4XyIvIj591QsGJFpWzJqEI2p
         9NKDuc1Uu3P+OmOEd1Cr01nbtz7e5N6cXJ8Q77cs2sNY6zs7pVnNFEOUA0UbWHYGa2AW
         /st3fzUW6UMVPmVkWA2tftKw9cqnlzlqQ7UQELqqG7vYiPcIUAWPWJWnQ3QLYimqnW/i
         N15Mj/bfPYPyTg2GC+WWGy9n5hdnqCgCQBnUI8EKCZfS6BKvdsFvCeutKLZebgXmjVJJ
         76zw==
X-Forwarded-Encrypted: i=1; AJvYcCVpOcRGXPbsetATYm/JN6g05J9e6glfHY7IC3D11uuqGvn4XJHJ2gaSgmX8zWAXPcVJk95cy4/MkE4rRQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4bY67xI6XvjpyUY/10R1YX6yfXaa65/V7KVKeai8kzP3cdHOc
	i6wJ+k7j8PYmqM8scV8BcQC3dtD0vtEBUKhrUW2P4EB2H1r1XBnBS8MHOagEOBE=
X-Gm-Gg: ASbGncvfyaIKe8c4xFyyzNT3+ALPUq/Ib463NqjAvhmoxuj6qGaG6cg0jz7o+hYIlD1
	1onxmt7dIDLNh0GZXst43eglRsQdAer++N6uMFSbh7NR8dppdOq8R02V2YQCjR47cBhFBKlkABC
	tdhdCegnBwgnADWl/gDyio0jrwgu4TIv5gLuV06BpOzGD0bGNvkqLmqLNTeWc+Ah48x9XvrNSWd
	pl7JjFc+SWQd2jNFp8OEuXRC86Qp+1vprBzFLWdBTDh02VGzeY18hWZGBV5gsnPMn1rhAUIIGD5
	WRPFt3nZwAE9lUhefc197bsgUfF9TBy51UnwBrrFMv5VcVQ=
X-Google-Smtp-Source: AGHT+IFobiCmJ5R4HiRsL7pd40Q47J6t9IkNByEpgJJ+za6Nh1z2wpG/Yd/Pf+T6IGoi+Jf+ap0SAA==
X-Received: by 2002:a05:600c:a47:b0:439:969e:d80f with SMTP id 5b1f17b1804b1-43ba6773869mr156464875e9.31.1741102735859;
        Tue, 04 Mar 2025 07:38:55 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba5710ebsm238670625e9.26.2025.03.04.07.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 07:38:55 -0800 (PST)
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
	Paul Menage <menage@google.com>,
	Paul Jackson <pj@sgi.com>
Subject: [PATCH 5/9] RFC cgroup/cpuset-v1: Add deprecation warnings to mem_exclusive and mem_hardwall
Date: Tue,  4 Mar 2025 16:37:57 +0100
Message-ID: <20250304153801.597907-6-mkoutny@suse.com>
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

The concept of exclusive memory affinity may require complex approaches
like with cpuset v2 cpu partitions. There is so far no implementation in
cpuset v2.
Specific kernel memory affinity may cause unintended (global)
bottlenecks like kmem limits.

Cc: Paul Menage <menage@google.com>
Cc: Paul Jackson <pj@sgi.com>
Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 kernel/cgroup/cpuset-v1.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/cgroup/cpuset-v1.c b/kernel/cgroup/cpuset-v1.c
index 9aae6dabb0b56..05d3622ea41e5 100644
--- a/kernel/cgroup/cpuset-v1.c
+++ b/kernel/cgroup/cpuset-v1.c
@@ -424,9 +424,11 @@ static int cpuset_write_u64(struct cgroup_subsys_state *css, struct cftype *cft,
 		retval = cpuset_update_flag(CS_CPU_EXCLUSIVE, cs, val);
 		break;
 	case FILE_MEM_EXCLUSIVE:
+		pr_warn_once("cpuset.%s is deprecated\n", cft->name);
 		retval = cpuset_update_flag(CS_MEM_EXCLUSIVE, cs, val);
 		break;
 	case FILE_MEM_HARDWALL:
+		pr_warn_once("cpuset.%s is deprecated\n", cft->name);
 		retval = cpuset_update_flag(CS_MEM_HARDWALL, cs, val);
 		break;
 	case FILE_SCHED_LOAD_BALANCE:
-- 
2.48.1

