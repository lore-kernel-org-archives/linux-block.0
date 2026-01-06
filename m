Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29782DF128
	for <linux-block@vger.kernel.org>; Tue,  6 Jan 2026 14:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767709633; cv=none; b=qClMQ2lQS1ZF40HzgxEPkwpuEAtR9RnMhMmTClo8WDw/Jy/eXQ18N3aXcfdlJX4HAI8pie3DFvLmomtM4veL9G5hByREpNBXH9G2FrT+9rvbGgx3/r1hoxrBN+jd7dDup6aj41T0+3G/KOEHkWN4hYzcmrhq6yMQYtu+YFOFrkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767709633; c=relaxed/simple;
	bh=vV0mvS4Jnm2xZ3ntnOC7IJN7wlIZlMsfOIIsKVUA/to=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=nGleF9HHzOWskGxkW37fdk1wtxaqxQNBjejL29ulHjXFnGiYSR5uQ9ZFlxKpVQGMDvbMOOK2PEXFI+mgyOnxodHU2s94HXr7PBdaqg8vMnw6ak4cLRH7Y44Trb+4qa8PaUT1nYJ8sIUObqahlHXYTMy4Rd9qin7fLm0Hx7X9/WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-3fa11ba9ed5so690929fac.0
        for <linux-block@vger.kernel.org>; Tue, 06 Jan 2026 06:27:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767709631; x=1768314431;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+3qd01S9PP2+OLCSEIsQdXiiXsFMzjeQSYIxX2JGNCE=;
        b=VOjemtdm9OGDwlWIf+E6FBH/+tChDBaBmHD3X6BBV0tI94XrfB45jJlPZPG73kloOT
         HBCrcK1RlZAfIfiUjcxpPU+0ri/7OS4bPeIequR840mUNAxehbvteDGTkoB6bcMQ0BhF
         fIVpupWOMhtLOT2WYy18yOjzhKeZ325CpDL46i7cXFuoZMxYTDK0UJFmldhB/iF57ftz
         ntYno2g9z5PkhqM3dSLDWCkbJ6fuRtk4QIRVYfVNj0KIahxHdJyGvxQrOD0mJn/0AXmj
         Blez/x10ryXPlEhe7OBI3BXk9VS1TOwWFx2O9PhxeIHMyc2gzQMks/IElilY/1D0o9nq
         D3Tg==
X-Gm-Message-State: AOJu0YzEHk+R8qG+elNMp06s4bqtY7micfXeKSnwxYnMB1wBY8gKNRfR
	mIZ/hT6mMOK3b2rv1tzGBq/ZNqmQ2lFQEriAHIWM0KLznE6wjoVfhgjM
X-Gm-Gg: AY/fxX4Qy7a4JvfFJWsFxObXzysA+FDwE6BMDwI722J/4ifWoV43SVJIMu2S8Wd2wQO
	fpqlD9SSC0InIunu8YAeYY8e95o96NuNc/davMyyDuxK4ew/tq3W3aqTO2ihGmZH/kyu3OXS2t3
	qyAgi9UFIL9kmrbO33pZ0ykoBfhcCBqNaGzN85ym4GeRpY2X1wPKOWfZkPyLaMg9zXQ8bFctz0I
	huQbFEpCpoS2kn2eOWWVc0W6vhveI4YkV362bhw+F8paRINcbHy15fBPshPH701hk9BBM23n93h
	vH2qJA3TpIuQCV/c2AEl4ymQqXjZ7OlHRXZfKcil1N7eMSQ35ucWf+KEa9TpjAaQ2uHZn2omyet
	a3Z39lX9SYNIjIXPgqFGX58gQhRtWHpCJRVXmt+vGCynEb0oYrW6g2kYPRyhDZ/QRy///+krO+s
	RAxZSH5sMjRPrPLC7syYJaHSWM
X-Google-Smtp-Source: AGHT+IED2Gwv/rYRU8OuPikMe18KRTzt/416cCB+x5CYYikPcYVGf68I6GEJ88NpybGUFPEiq8Dqew==
X-Received: by 2002:a05:6870:f14f:b0:3ec:3b3e:4f38 with SMTP id 586e51a60fabf-3ffa0c6b5cemr1746241fac.36.1767709630794;
        Tue, 06 Jan 2026 06:27:10 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:52::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3ffa4deae43sm1394643fac.1.2026.01.06.06.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 06:27:10 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Tue, 06 Jan 2026 06:26:57 -0800
Subject: [PATCH] blk-rq-qos: Remove unlikely() hints from QoS checks
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260106-blk_unlikely-v1-1-90fb556a6776@debian.org>
X-B4-Tracking: v=1; b=H4sIALAbXWkC/yXMQQqDMBAF0KsMf20gEUkhV5FSTDq2U0NaEhVFv
 HtRl2/zNhTOwgWONmSepcg3wZGpCOHdpRcrecIRal1bbbRVPg6PKUUZOK7KcteE/ma90Q0qwi9
 zL8vZtffLZfIfDuNxYN//YPdCanAAAAA=
X-Change-ID: 20260106-blk_unlikely-6ea4cf76b104
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 tj@kernel.org, josef@toxicpanda.com, kernel-team@meta.com, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=3757; i=leitao@debian.org;
 h=from:subject:message-id; bh=vV0mvS4Jnm2xZ3ntnOC7IJN7wlIZlMsfOIIsKVUA/to=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpXRu9Fd50a83G9ZgMg3oXgeowUcIVdLtQ5P3j6
 S7if+yCV42JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaV0bvQAKCRA1o5Of/Hh3
 bdzHEACnvGlRYnTRfUQaQ60ZDw2d/qcHz7HXgSyPHC04T9R93ajP3iDb1b8TH+sr8gTgl5iKLrR
 RYAYSkdBIKHIFGapj9U57zkR7c3Cc/n1Y4hVukG9ZwStFSWYXSDCpdr6NGOzOw4tHVYjDHGwiHA
 VsmzU8bJSIJnQtX5ynBRikqhW2+90hGzesTST9tXgv/sDC/yyFdYWvgvPouQLq++TIfL0p9nvn9
 gVZioVm1DJQn+17ba9Ga5qmpTzpmcEwQ8b5IiCfN8lVkm7nbCsx8cfASlhxODTlRPxfRTrILOpL
 +N0KrnS4dE4yvMZd7uzfUVAMsOfFcYgjeed+Gc/rmM1zcIz9zo7dvhIB7X+zIQ/1zDUrqm3TXMa
 GphO91GEk/ZU93mRYY7uCQsB672NZVDtMLCsT9qlo+t24i9a0+Nbryjc14FL4Xc4cyPB/AgEhvc
 HyOCEk5U/zNrIIxXFRGtrFpgIxlWAMeMzZvY5tS6VbZc9F8ssc0OhSshgMbRScpbtSvv73OvgXM
 6HeoWG3pjXV/PYTB2jGwIYq5Jzo6iYWHpSR2XW+EHO1/O/w0trqcBjYNXt0h5pB1ec19WD9y3M9
 6RAewEepqt4MbierniH4rXvLbx+29vOVu770Lbwod8QO/DZXh1VIkev1OOULI/D6c7TQPEBfpSF
 MU2Oo3+pAecEAUQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

The unlikely() annotations on QUEUE_FLAG_QOS_ENABLED checks are
counterproductive. Writeback throttling (WBT) might be enabled by
default, mainly because CONFIG_BLK_WBT_MQ defaults to 'y'.

Branch profiling on Meta servers, which have WBT enabled, confirms 100%
misprediction rates on these checks.

Remove the unlikely() annotations to let the CPU's branch predictor
learn the actual behavior, potentially improving I/O path performance.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 block/blk-rq-qos.h | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/block/blk-rq-qos.h b/block/blk-rq-qos.h
index b538f2c0febc..a747a504fe42 100644
--- a/block/blk-rq-qos.h
+++ b/block/blk-rq-qos.h
@@ -112,29 +112,26 @@ void __rq_qos_queue_depth_changed(struct rq_qos *rqos);
 
 static inline void rq_qos_cleanup(struct request_queue *q, struct bio *bio)
 {
-	if (unlikely(test_bit(QUEUE_FLAG_QOS_ENABLED, &q->queue_flags)) &&
-			q->rq_qos)
+	if (test_bit(QUEUE_FLAG_QOS_ENABLED, &q->queue_flags) && q->rq_qos)
 		__rq_qos_cleanup(q->rq_qos, bio);
 }
 
 static inline void rq_qos_done(struct request_queue *q, struct request *rq)
 {
-	if (unlikely(test_bit(QUEUE_FLAG_QOS_ENABLED, &q->queue_flags)) &&
-			q->rq_qos && !blk_rq_is_passthrough(rq))
+	if (test_bit(QUEUE_FLAG_QOS_ENABLED, &q->queue_flags) &&
+	    q->rq_qos && !blk_rq_is_passthrough(rq))
 		__rq_qos_done(q->rq_qos, rq);
 }
 
 static inline void rq_qos_issue(struct request_queue *q, struct request *rq)
 {
-	if (unlikely(test_bit(QUEUE_FLAG_QOS_ENABLED, &q->queue_flags)) &&
-			q->rq_qos)
+	if (test_bit(QUEUE_FLAG_QOS_ENABLED, &q->queue_flags) && q->rq_qos)
 		__rq_qos_issue(q->rq_qos, rq);
 }
 
 static inline void rq_qos_requeue(struct request_queue *q, struct request *rq)
 {
-	if (unlikely(test_bit(QUEUE_FLAG_QOS_ENABLED, &q->queue_flags)) &&
-			q->rq_qos)
+	if (test_bit(QUEUE_FLAG_QOS_ENABLED, &q->queue_flags) && q->rq_qos)
 		__rq_qos_requeue(q->rq_qos, rq);
 }
 
@@ -162,8 +159,7 @@ static inline void rq_qos_done_bio(struct bio *bio)
 
 static inline void rq_qos_throttle(struct request_queue *q, struct bio *bio)
 {
-	if (unlikely(test_bit(QUEUE_FLAG_QOS_ENABLED, &q->queue_flags)) &&
-			q->rq_qos) {
+	if (test_bit(QUEUE_FLAG_QOS_ENABLED, &q->queue_flags) && q->rq_qos) {
 		bio_set_flag(bio, BIO_QOS_THROTTLED);
 		__rq_qos_throttle(q->rq_qos, bio);
 	}
@@ -172,16 +168,14 @@ static inline void rq_qos_throttle(struct request_queue *q, struct bio *bio)
 static inline void rq_qos_track(struct request_queue *q, struct request *rq,
 				struct bio *bio)
 {
-	if (unlikely(test_bit(QUEUE_FLAG_QOS_ENABLED, &q->queue_flags)) &&
-			q->rq_qos)
+	if (test_bit(QUEUE_FLAG_QOS_ENABLED, &q->queue_flags) && q->rq_qos)
 		__rq_qos_track(q->rq_qos, rq, bio);
 }
 
 static inline void rq_qos_merge(struct request_queue *q, struct request *rq,
 				struct bio *bio)
 {
-	if (unlikely(test_bit(QUEUE_FLAG_QOS_ENABLED, &q->queue_flags)) &&
-			q->rq_qos) {
+	if (test_bit(QUEUE_FLAG_QOS_ENABLED, &q->queue_flags) && q->rq_qos) {
 		bio_set_flag(bio, BIO_QOS_MERGED);
 		__rq_qos_merge(q->rq_qos, rq, bio);
 	}
@@ -189,8 +183,7 @@ static inline void rq_qos_merge(struct request_queue *q, struct request *rq,
 
 static inline void rq_qos_queue_depth_changed(struct request_queue *q)
 {
-	if (unlikely(test_bit(QUEUE_FLAG_QOS_ENABLED, &q->queue_flags)) &&
-			q->rq_qos)
+	if (test_bit(QUEUE_FLAG_QOS_ENABLED, &q->queue_flags) && q->rq_qos)
 		__rq_qos_queue_depth_changed(q->rq_qos);
 }
 

---
base-commit: c92f16e43c48f367af2f63956eb8385cb05816f3
change-id: 20260106-blk_unlikely-6ea4cf76b104

Best regards,
--  
Breno Leitao <leitao@debian.org>

