Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F592EF289;
	Fri, 25 Jul 2025 16:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753461858; cv=none; b=qrMFaDqB510QuRRuYOft5B9MziGnea3NQVGEtrpuE47mOQSDeJWdYMUqZheHZG8dIeDcQbbfBBujs8tB0mExyL5WOxuwg1gJgpid3JyPfRY+oUEio4pqnPpxSAodVY7lsZheA3FK0WyXqY26zxfdVZLrARYlqkAm3cd2WXHigqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753461858; c=relaxed/simple;
	bh=h78yE1DkQ3fTjlceS0tehFkgWYsLhUQn3uH2GMwQ9s4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f30i0CAg2LOMlKlAK2Z8K94xjBWmecBvdkJ37nHBuQIM5BYlP0mmHH3g0RaURnV966vliGbbI1Kc9+ONAooLCfpkgfwGFZInvcGMAtR5pPG9yHaCUO67h/MvloIGuAC6cSz1RTb5ILP6ii1PiTBRzVS5xTZnyFHWG6Tc5Mb9UmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cpDQEuvn; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cpDQEuvn"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-32cd0dfbdb8so22597411fa.0;
        Fri, 25 Jul 2025 09:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753461855; x=1754066655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2jkkxxr1tvEIQXkKkETdG3gEvMrEI02eI/QjeRb314U=;
        b=cpDQEuvn3aP5NKHwLpPp7WEmSjy2HOd3f3gYBnFU9YkdTgXqPe3D9BV8bbVz5Q+lw9
         Ph8s5u+VCoKlcwAW9cESgUyLxpZWiu9F/RbQyM42aKHNmiCL6xfqtGoCJFn53DwVh+K1
         zGhHY9aZ+T/Uvy8xVqrT/6UE0NRx+55fBd1zkkdCs/bIjwB1HZyjZ7mTypr+IqzOSJNU
         aDl5PAQHjbfoKuMqnmmZSeL8xsUwn/gT5ioLfV9aIO6lt74hS24OInIK98hYvdgqYAR/
         O61pm9RFE94uWK5LdHaZm4fte5M48jqI+QfUjFS8cZXBpSRoLSpkgTl6NzgnzKYWaRLE
         cnRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753461855; x=1754066655;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2jkkxxr1tvEIQXkKkETdG3gEvMrEI02eI/QjeRb314U=;
        b=ukoxS7AqoMeV/9Enx4qw4RuqdyNiIbhc16g1v95eNUMBvPAd8RlJZMXk955zaIsGal
         fwpPVXdwW2SX8kTGwjSKKJN6qrsbkQ4HWxTgrENokEHvK8hL1/nrJ61TW7sIKcT6bpzx
         Nugqg7NIoaLnlH2cFYjO8YViJ9PEGdHpXrawswKwnfFfFjAEqPSn25zGHOcwzWrSF3SM
         +ju9Sle3TZnRM+nP5UR0KjoFVhw5WU08q2OkISmdxvo50/SJgu/kZ8XPRFJZfDzJlEXo
         L/Nw0cIjU7Ynv2r+j69TobHS/cmErtmJRjPw61sxUMkABJOSytsAXtF9rPK/AD7cXyeB
         ZROw==
X-Forwarded-Encrypted: i=1; AJvYcCUBzTSwJFlE038Gqm5Z/qCiR7KVPqwuH1SOqjsGLe1yifffMnXrewlrPqd/EjCyn7P7jbkcWyOrLQbe/+3E@vger.kernel.org, AJvYcCXrLOxE2gWqfD1QyT8PLzqSdDTaLX4I3OiJs1xxR2AJ/Epy3Q8cCFgaL6IInGFUPNgoVa7ojl+toYP4Aw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwJQwCoUHiDkzs4yENRegK58VVZcfGoxJN2sbVXCbVvWi7/6HWO
	/TBS8evKKiN39Z8IUSQAUQXwFxiwyTgaqJxjTrA/sz37k3EAj+7SMltS
X-Gm-Gg: ASbGncsYyxHb47/LWOGqZtksSj7OzUB1+xnfsQh26gFJG749hbRmdMItTizJdzNps89
	bZ2gJWh7E+SEbTecsGm9n6Vsm1F9YkOHaeXdhCQ1U87yHLzoFoSitnFtLlZ95V4CfJiG8846ub/
	3VkW6cL3nE3fTrD/ObOdd13mVlgZ8VTyXJV2wyvWQH69aao3z8My9EGZg8zgyA4G8njW2nT75aT
	xQoHXM1EnL9oJt96PfqMSNVxK3QIbWqIMOpCGYsw1tBEQihM84y3eLmSmpgysUfpSij0/0zdI5Z
	ybFFfl+Xau/kHyFwOCq0SdBrNKoqpGD9XmpjNLavA7NbTRj23ZNd/BieuZx3BPDKbsOl82frHbE
	jXi+6SiEKLPSAR/YPgMQEz7BfisvEB73Kz1Tm+nA2E4lnX3Y=
X-Google-Smtp-Source: AGHT+IE8hXJ25wF8ru+MlHrYUzqY59qEsX0o5q6j4nN8guTvq6nc+6mXIb/PIJqdE5luSZTran9WEg==
X-Received: by 2002:a05:651c:31c3:b0:330:4f46:9467 with SMTP id 38308e7fff4ca-331ee819570mr9244521fa.27.1753461854815;
        Fri, 25 Jul 2025 09:44:14 -0700 (PDT)
Received: from soda.int.kasm.eu (soda.int.kasm.eu. [2001:678:a5c:1202:4fb5:f16a:579c:6dcb])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-331f407b023sm705931fa.6.2025.07.25.09.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 09:44:14 -0700 (PDT)
From: Klara Modin <klarasmodin@gmail.com>
To: brauner@kernel.org,
	anuj20.g@samsung.com,
	arnd@kernel.org
Cc: martin.petersen@oracle.com,
	joshi.k@samsung.com,
	hch@infradead.org,
	arnd@arndb.de,
	naresh.kamboju@linaro.org,
	anders.roxell@linaro.org,
	axboe@kernel.dk,
	kbusch@kernel.org,
	csander@purestorage.com,
	asml.silence@gmail.com,
	adobriyan@gmail.com,
	djwong@kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Klara Modin <klarasmodin@gmail.com>
Subject: [PATCH] block: change blk_get_meta_cap() stub return -ENOIOCTLCMD
Date: Fri, 25 Jul 2025 18:43:34 +0200
Message-ID: <20250725164334.9606-1-klarasmodin@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When introduced in commit 9eb22f7fedfc ("fs: add ioctl to query metadata
and protection info capabilities") the stub of blk_get_meta_cap() for
!BLK_DEV_INTEGRITY always returns -EOPNOTSUPP. The motivation was that
while the command was unsupported in that configuration it was still
recognized.

A later change instead assumed -ENOIOCTLCMD as is required for unknown
ioctl commands per Documentation/driver-api/ioctl.rst. The result being
that on !BLK_DEV_INTEGRITY configs, any ioctl which reaches
blkdev_common_ioctl() will return -EOPNOTSUPP.

Change the stub to return -ENOIOCTLCMD, fixing the issue and better
matching with expectations.

Link: https://lore.kernel.org/lkml/CACzX3AsRd__fXb9=CJPTTJC494SDnYAtYrN2=+bZgMCvM6UQDg@mail.gmail.com
Fixes: 42b0ef01e6b5 ("block: fix FS_IOC_GETLBMD_CAP parsing in blkdev_common_ioctl()")
Signed-off-by: Klara Modin <klarasmodin@gmail.com>
---
 include/linux/blk-integrity.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/blk-integrity.h b/include/linux/blk-integrity.h
index e04c6e5bf1c6..e67a2b6e8f11 100644
--- a/include/linux/blk-integrity.h
+++ b/include/linux/blk-integrity.h
@@ -97,7 +97,7 @@ static inline struct bio_vec rq_integrity_vec(struct request *rq)
 static inline int blk_get_meta_cap(struct block_device *bdev, unsigned int cmd,
 				   struct logical_block_metadata_cap __user *argp)
 {
-	return -EOPNOTSUPP;
+	return -ENOIOCTLCMD;
 }
 static inline int blk_rq_count_integrity_sg(struct request_queue *q,
 					    struct bio *b)

base-commit: bc5b0c8febccbeabfefc9b59083b223ec7c7b53a
-- 
2.50.1

