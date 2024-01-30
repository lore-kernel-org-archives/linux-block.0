Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE26E71B5B
	for <linux-block@vger.kernel.org>; Tue, 30 Jan 2024 20:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706646419; cv=none; b=bOvw9NkL8a2NcwjsKlrFPFZEKwlVt8T+DTm78RTYsvDx5O96W9C4yiyvebVcwLL6Pdz2qZXL5LE3YWX92e0Hsp02dZ/QDFqFHm0gLneTXDTfLswOdcfO6CnItEeHNP6sewjsdJVBpMLufO+T7kNyHO9fSn0He4RbLmRViSP/CJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706646419; c=relaxed/simple;
	bh=kel0RHUbBvs8tO6xKBCk8jeoGiLfvfN2wpXiLo+ZVmU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Hzu/+vmI6IT8KDd2AJAMo0C/TApEq9d51nCfqphZDADv1jpcN8jKEj+Uq2rk5I5JkGQR1ROsK+vvWHbo+bTNc/15Eoq2Pfh8RY2Z8RtMvEqbubwdH8B+zKrMiL+3CWiHyHMVnnFuOueNEpglKl+zEpnj7I4h3NlGetqOhxrvtg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=redhat.com; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-783f0995029so298287585a.1
        for <linux-block@vger.kernel.org>; Tue, 30 Jan 2024 12:26:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706646415; x=1707251215;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W4NzVswFhknsHsE2I73Hxb3OMJY4C5qnGxt15cREUuA=;
        b=iok0wp6ioehcixVr/CctIRObBOvtrRkRhBPWENLnhpDe4n1Jewn5AZ3kZlDCyoo4gh
         wDDRZSk7MYMI737ERxKquYgs8z3pSWz16Tk2dcEgwAF6ffz4FCoL+w07+KlOi56CoZHn
         /5NTYRBp2diwxDFF6uJCHLoKambE75ylJLe5iR+zC187yHMGZ8q9eNCysZFjLaKszU5u
         bHYn5FxCfoAo8AiT3XXn8LpLLXEC0YR4TrU3qm4IleAPps0OKKU+EnIW63hnTJbepAZ5
         sL+XaIPBDPV5WoRyAKIXWsgoye4zxppvKvxmLF5p8jbmUn9+HB/yK7yLe9UT0x74457J
         yuFQ==
X-Gm-Message-State: AOJu0YwIJUBnxXL57HTMmvSH8XlxY7Ccf9iEOx03x0/CvgzrLWPUwQ+o
	DJCVTdrgy9UZqihnz2ngc1ssJ7wxr22pUdgyRuu7Gvd+iYEhhwGnj8GgsL8Cwg==
X-Google-Smtp-Source: AGHT+IFpLIxnrcy4wWyylwYAuCg+jEkWdYtTtMTCpwYkHetNXFTF7GEQRtYLL6vY2tOVCAWUdIvacw==
X-Received: by 2002:a05:620a:4141:b0:783:fbc1:9c2a with SMTP id k1-20020a05620a414100b00783fbc19c2amr6701172qko.29.1706646414878;
        Tue, 30 Jan 2024 12:26:54 -0800 (PST)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id p4-20020a05620a112400b00783f9f6d5b7sm2284443qkk.10.2024.01.30.12.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 12:26:54 -0800 (PST)
From: Mike Snitzer <snitzer@kernel.org>
To: axboe@kernel.dk,
	hongyu.jin.cn@gmail.com
Cc: ebiggers@kernel.org,
	dm-devel@lists.linux.dev,
	linux-block@vger.kernel.org,
	Hongyu Jin <hongyu.jin@unisoc.com>,
	Yibin Ding <yibin.ding@unisoc.com>,
	Eric Biggers <ebiggers@google.com>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>
Subject: [PATCH v9 1/5] block: Fix where bio IO priority gets set
Date: Tue, 30 Jan 2024 15:26:34 -0500
Message-Id: <20240130202638.62600-2-snitzer@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20240130202638.62600-1-snitzer@kernel.org>
References: <20240130202638.62600-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hongyu Jin <hongyu.jin@unisoc.com>

Commit 82b74cac2849 ("blk-ioprio: Convert from rqos policy to direct
call") pushed setting bio I/O priority down into blk_mq_submit_bio()
-- which is too low within block core's submit_bio() because it
skips setting I/O priority for block drivers that implement
fops->submit_bio() (e.g. DM, MD, etc).

Fix this by moving bio_set_ioprio() up from blk-mq.c to blk-core.c and
call it from submit_bio().  This ensures all block drivers call
bio_set_ioprio() during initial bio submission.

Fixes: a78418e6a04c ("block: Always initialize bio IO priority on submit")
Co-developed-by: Yibin Ding <yibin.ding@unisoc.com>
Signed-off-by: Yibin Ding <yibin.ding@unisoc.com>
Signed-off-by: Hongyu Jin <hongyu.jin@unisoc.com>
Reviewed-by: Eric Biggers <ebiggers@google.com>
Reviewed-by: Mikulas Patocka <mpatocka@redhat.com>
[snitzer: revised commit header]
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 block/blk-core.c | 10 ++++++++++
 block/blk-mq.c   | 10 ----------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 11342af420d0..de771093b526 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -49,6 +49,7 @@
 #include "blk-pm.h"
 #include "blk-cgroup.h"
 #include "blk-throttle.h"
+#include "blk-ioprio.h"
 
 struct dentry *blk_debugfs_root;
 
@@ -833,6 +834,14 @@ void submit_bio_noacct(struct bio *bio)
 }
 EXPORT_SYMBOL(submit_bio_noacct);
 
+static void bio_set_ioprio(struct bio *bio)
+{
+	/* Nobody set ioprio so far? Initialize it based on task's nice value */
+	if (IOPRIO_PRIO_CLASS(bio->bi_ioprio) == IOPRIO_CLASS_NONE)
+		bio->bi_ioprio = get_current_ioprio();
+	blkcg_set_ioprio(bio);
+}
+
 /**
  * submit_bio - submit a bio to the block device layer for I/O
  * @bio: The &struct bio which describes the I/O
@@ -855,6 +864,7 @@ void submit_bio(struct bio *bio)
 		count_vm_events(PGPGOUT, bio_sectors(bio));
 	}
 
+	bio_set_ioprio(bio);
 	submit_bio_noacct(bio);
 }
 EXPORT_SYMBOL(submit_bio);
diff --git a/block/blk-mq.c b/block/blk-mq.c
index aa87fcfda1ec..2dc01551e27c 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -40,7 +40,6 @@
 #include "blk-stat.h"
 #include "blk-mq-sched.h"
 #include "blk-rq-qos.h"
-#include "blk-ioprio.h"
 
 static DEFINE_PER_CPU(struct llist_head, blk_cpu_done);
 static DEFINE_PER_CPU(call_single_data_t, blk_cpu_csd);
@@ -2944,14 +2943,6 @@ static bool blk_mq_use_cached_rq(struct request *rq, struct blk_plug *plug,
 	return true;
 }
 
-static void bio_set_ioprio(struct bio *bio)
-{
-	/* Nobody set ioprio so far? Initialize it based on task's nice value */
-	if (IOPRIO_PRIO_CLASS(bio->bi_ioprio) == IOPRIO_CLASS_NONE)
-		bio->bi_ioprio = get_current_ioprio();
-	blkcg_set_ioprio(bio);
-}
-
 /**
  * blk_mq_submit_bio - Create and send a request to block device.
  * @bio: Bio pointer.
@@ -2976,7 +2967,6 @@ void blk_mq_submit_bio(struct bio *bio)
 	blk_status_t ret;
 
 	bio = blk_queue_bounce(bio, q);
-	bio_set_ioprio(bio);
 
 	if (plug) {
 		rq = rq_list_peek(&plug->cached_rq);
-- 
2.40.0

