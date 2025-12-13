Received: from mail-qv1-f98.google.com (mail-qv1-f98.google.com [209.85.219.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACD4256D
	for <linux-block@vger.kernel.org>; Sat, 13 Dec 2025 00:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765585199; cv=none; b=dLgwAMQvMVNFVuTa2B2t3fyw0ePxQ7slJXTLq5AUY4GDeaGcQIZA7p+rILuYITv1NGTJ7JpmoDqoIEFmPjEtnVwuLE5/bupFQlT6RpZPQ40fvHF0qV5968OZ5DGyfjKDSqBuHEUIBtBZ8BfwqMYQJr5imKrmefrzv85H96qCfxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765585199; c=relaxed/simple;
	bh=4nxj9fWTh8u/vSR7WUxAw8mtJOihB2zIXoz2Q6QD3Zw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QNamKqJYxA7kBchV/aSXdj8/aHX97WF2HQSahOD2kSbhW0MAMG67teoIIp32Go32M3elcFAQaav0D1PkeeEvDQq1Y+21pGP6Aom5/HxcaekaesT8ViHIjtkEVrueGWB0BDc9ndFl9anoXDmFqtAUuIj8f4sEtMUCFPm0QljLeWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=OCpO7H5F; arc=none smtp.client-ip=209.85.219.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="OCpO7H5F"
Received: by mail-qv1-f98.google.com with SMTP id 6a1803df08f44-889d80de181so149246d6.0
        for <linux-block@vger.kernel.org>; Fri, 12 Dec 2025 16:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1765585197; x=1766189997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OSG6es0J0cc7VS5khpOgLsO5uiuIwff2vbQ6mje6Gvs=;
        b=OCpO7H5FVFh95vpZa17jY97Jbpmn8AUxFjvMOIJ/x0qn9BsAk5hYHj3ism+38fh4Tb
         scwjixMhlMtsshSRMSTSx6npZDy5Xpte9LuQOHxfcN8M16dLxxDMCHDyr/w8SydptJ38
         AAvGqHHbwIxwQk/tf9MrL/WITA6M0mFXkzG25+rJDuUIz3hjaSv4VGanOunYi5xDyPqw
         YNnDzh8hbvpJ1duKKQxV8xKNf5Jqy3c7r/wcGvMtTB0ztA0WZm5DvnsNQQUJ4vr4/ZLj
         c1bDWX9pPN3Bb+Ho4C4uRRDPoAORwPM8YemGXF31bzG2mLEHg3sAhncjSeNwQNKHIoVT
         mG0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765585197; x=1766189997;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OSG6es0J0cc7VS5khpOgLsO5uiuIwff2vbQ6mje6Gvs=;
        b=MUc69pj0GP7IIkYpyaExd2zz1Oo2RrjdGvsrcC/3NLX6iLjjc6GLiKhI85iBCn03Zq
         ULl5Qw3o8Z3Njo+75Hnjk3zmdJrNJUp8biqdcyPToydwD66WhaUmwq5xZ6mtU1Z2vrzE
         9v7yl0ywUDbQHza/DxUG2okuYFf+cOTJ9NddOD1XGPSXQdhgn8G3LIsaScerx4DiPr0o
         +vdKr708etoNTQlwXWpW+SBOQYNg3tpoZH86WFfHnep7hp1LnTFGTuYxGNgH8lqC7e2W
         d4zV+tHupZ4CsxVknoJ3SWcrC7XtuDP6dQv78ibsEQUSAhuIY/JQ+MQVaZU+/PZ/uXua
         eCUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGKjRSF3xRs8/m4Lf2xirtcM+fExxcrDdr0/ttWxRpvddAIbWnGMaYNyW8ECzjOVX/UmLC/swXSsgjTg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0Xm/H36QCKrljvhze0SX9gZJOBE8Bf+t0mKpUsaW5cNyB3pPi
	qctGqR8FBn0jd5+027/y0KnIT/3V811tR+XVKOZJuadFnjILTY5XHhriB/XbeFkZU3Bv7gLxpNi
	JQO2lVOAbQFPtVVdtSsZ/dWrLKlp+zV+f056UmNl9Ioe3AtTdt4rN
X-Gm-Gg: AY/fxX6fwAvPeRsKyfArUUTgeZPg07XvR4kDKjCcmKrIig0eD/Um7inmnBzVl15fR9D
	JrTD02GnWzcjDCuqmfUKIo699KLq33WbjKLVEx31MHlFXC00H71HzSgRhH3ipbxOgS1xn/G8vsh
	j6CgfqwXbB5UOPPvt3prvnRZhla8S3nmpoRBD+qrffR7xbqDcb0sWLmMO7gzDWbgYbgvWlfK/sK
	/s0U3KOgTcnaxheFMaaagqL+KnHsxEeiBCDILhouTPNSVje2NafEgf5q0EpQiCI0vx0wkePU7CA
	L4k0pX8/vRpM+yATLRwMrL+LahSsx6GO/MA74jU7O/Ubs65UI1/xf5Zwt1DDaf257lUuG2LJODF
	eEEaXXv1+2YsLmYxnGBX6Cxm0Y/Q=
X-Google-Smtp-Source: AGHT+IFZ2DBVpOqAAbHT521TfS4EEsrCsl84UBX25d4y729HKZPVq461pjAQhlhPCUyOXEFpgIbN86WHLEru
X-Received: by 2002:a05:620a:4416:b0:89f:5a1b:1ec9 with SMTP id af79cd13be357-8bb398d9574mr434257785a.1.1765585196820;
        Fri, 12 Dec 2025 16:19:56 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-8bab5c04048sm84427685a.6.2025.12.12.16.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 16:19:56 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (unknown [IPv6:2620:125:9007:640:ffff::1199])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id DAE3634027F;
	Fri, 12 Dec 2025 17:19:55 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id D4DCAE41AC3; Fri, 12 Dec 2025 17:19:55 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ublk: clean up user copy references on ublk server exit
Date: Fri, 12 Dec 2025 17:19:49 -0700
Message-ID: <20251213001950.2103303-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If a ublk server process releases a ublk char device file, any requests
dispatched to the ublk server but not yet completed will retain a ref
value of UBLK_REFCOUNT_INIT. Before commit e63d2228ef83 ("ublk: simplify
aborting ublk request"), __ublk_fail_req() would decrement the reference
count before completing the failed request. However, that commit
optimized __ublk_fail_req() to call __ublk_complete_rq() directly
without decrementing the request reference count.
The leaked reference count incorrectly allows user copy and zero copy
operations on the completed ublk request. It also triggers the
WARN_ON_ONCE(refcount_read(&io->ref)) warnings in ublk_queue_reinit()
and ublk_deinit_queue().
Commit c5c5eb24ed61 ("ublk: avoid ublk_io_release() called after ublk
char dev is closed") already fixed the issue for ublk devices using
UBLK_F_SUPPORT_ZERO_COPY or UBLK_F_AUTO_BUF_REG. However, the reference
count leak also affects UBLK_F_USER_COPY, the other reference-counted
data copy mode. Fix the condition in ublk_check_and_reset_active_ref()
to include all reference-counted data copy modes. This ensures that any
ublk requests still owned by the ublk server when it exits have their
reference counts reset to 0.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Fixes: e63d2228ef83 ("ublk: simplify aborting ublk request")
---
 drivers/block/ublk_drv.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index df9831783a13..78f3e22151b9 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1581,12 +1581,11 @@ static void ublk_set_canceling(struct ublk_device *ub, bool canceling)
 
 static bool ublk_check_and_reset_active_ref(struct ublk_device *ub)
 {
 	int i, j;
 
-	if (!(ub->dev_info.flags & (UBLK_F_SUPPORT_ZERO_COPY |
-					UBLK_F_AUTO_BUF_REG)))
+	if (!ublk_dev_need_req_ref(ub))
 		return false;
 
 	for (i = 0; i < ub->dev_info.nr_hw_queues; i++) {
 		struct ublk_queue *ubq = ublk_get_queue(ub, i);
 
-- 
2.45.2

