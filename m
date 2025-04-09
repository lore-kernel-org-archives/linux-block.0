Received: from mail-ot1-f99.google.com (mail-ot1-f99.google.com [209.85.210.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE40250EC
	for <linux-block@vger.kernel.org>; Wed,  9 Apr 2025 02:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744167001; cv=none; b=Q1M/IoMIZuY7iZBH5K+K5q6m5EISwrLE9gA6vmsDLIDI2K99Mc/TafV6ICzxythAK64GMgNovq1g1av4VM01wuAWefxcJo4g4lErR3/ePsCJl5llWXJ7PZxe21GfRVCBlfvfQOm6vXVS6mahnNJ80tRcFsCItqPgKlPDgrSXS38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744167001; c=relaxed/simple;
	bh=oSbcp+HMi37hsvJxb6JgCimDrm0TZ96JAmlZ+5ptdLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aIgogppy2lA7iPV9c58Pihoa0tZzs6Xbo9X5aOKh6iPPsl7J+u6nimvtzWxDwOroGJvL5f6Qqh6bTZtuKiipXcJ86SwMFAry66Lja4zf4b9HAXwxtQvqLbfYgs1hVqTitOds0W+niJ7dPElDIQ/39hVcAawV+nVmAJnDIzrwmtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=fAv7b2G3; arc=none smtp.client-ip=209.85.210.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="fAv7b2G3"
Received: by mail-ot1-f99.google.com with SMTP id 46e09a7af769-72b87587c61so447543a34.0
        for <linux-block@vger.kernel.org>; Tue, 08 Apr 2025 19:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1744166998; x=1744771798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gdepLXKYc4w4R2CT56FvEdADqtoy0OyNwTPs1VSuUO0=;
        b=fAv7b2G3InMoZcIE2R59VhftlhYaslaK+z/fqkRCgHKGgt3nr0dGtxXtqog8q6t1Oy
         5WUpf2KLGZXoEUPtjgnoXEZfogSbLhnkfr3tLP3kJs5R9PuBwhX9zg46lADnvZVNXizo
         fic9CL0SBWSENemTQO3uIhqdm7txp3dFxWqCPV8hIp6dHEhyrW4dkxDRHyBbc+mNB0U+
         a1vkyFxFUK6MuO5tFOe6/cEt/kAE3QV6pm+jg0Bn+iVQQtkGMyersCllz4GPG4qHbg5x
         glhphuR12b1VWbyF3GRFxnhk1VNpZ7icVpsuVwZLLKC43xAwYbRU606skPuRDGnQp+RK
         BcXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744166998; x=1744771798;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gdepLXKYc4w4R2CT56FvEdADqtoy0OyNwTPs1VSuUO0=;
        b=Cn26lEgjMTL53pABZSNlhRqEWWxZCNUrqKxNfDltSVBzYVBF0/GgZp83Vl3lFbLXh0
         eFwy235UB8LObXykL5DF6K6pfenWYF6YUnjNAB4sIe9s8aXZ1kP0BQ2NE0PbT+kZhSlY
         cqocMxuZOBSjNZQZlhWZkIOOsU34C0nhYMOa7CahBoF39Da87U8SE39Bv2gTGIy4CiO/
         GhDXF3WpWZO8LQPqc0qD+Dr8m1xw1szeF0d4Zim0b6wFk1Lf7eEkAn727+8CYw/6X5+c
         VmiWJx0LA9np5X/DU/e3dxB6vl5It7n8y8SW0VvmzWSPZKhZt1qANR6XHE/sgJRUUPAy
         Qm0A==
X-Forwarded-Encrypted: i=1; AJvYcCVVrVVmvNzCHOkykHnnSq00/wwXsw1b287W1lkeH/6n/7KZrd69M/gz/9K0J1IKw8taB+lDcXi3VgzYdw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyIIk8u6THjDzHUzBOId/ozFLpz78yuXpFvjdoHULJV3uP7WW4/
	A5MQa4FjbJIEJa19k2rCaqwIPqzYzbOSp8mBFFySG7D71WGk3uZkQjsUA4V3JwHLrOyi173HBgR
	9dGf6jX0f4G0Y2Oym7opiiTZJgREEhFD5
X-Gm-Gg: ASbGncuZMUmHfx8DbvESuwRbvUQ2rpbQXK6dpjXmyk3Hzk8zH2B6OJsZ8H6gMbdE4dc
	Eczy8WNnK/ghKISS4G5onxlK2x3S+s7okj6CYPm4i+dKM5tUyN+IXa7Uda2E2FYGnr0/bJnntv7
	fgHprv3epGAqE3JEzrD88J29bFGR3MJ/F9mEg5cdd+bHJEGJgKlHMFes0+UeDlW6p2ZeZjyj+Ur
	jCb/C7bT3ri2uOdN6mi3xBOY0I1Qe8h52iH8Jg4w3s/JmFqxTg8RsL3C9N32FHqEkJIIMxwarmX
	zmnAcygaT7YBlRANJO20n+fJdOs3BBP1aUQbvEyNgBFhbRaX
X-Google-Smtp-Source: AGHT+IG7UagWB48dQ9nnghKAGIyqOWWUlJc6F9oTBFsaRfbwlN/GSxnM5gGWRPD8sIhDJq3uUJ8pk+9s/zWO
X-Received: by 2002:a05:6871:a012:b0:29e:6ddf:22d2 with SMTP id 586e51a60fabf-2d091ad46c8mr175604fac.9.1744166997809;
        Tue, 08 Apr 2025 19:49:57 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-2d0969cc5ddsm36518fac.23.2025.04.08.19.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 19:49:57 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id C90863402AD;
	Tue,  8 Apr 2025 20:49:56 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id C3AEBE41459; Tue,  8 Apr 2025 20:49:56 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ublk: skip blk_mq_tag_to_rq() bounds check
Date: Tue,  8 Apr 2025 20:49:54 -0600
Message-ID: <20250409024955.3626275-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ublk driver calls blk_mq_tag_to_rq() in several places.
blk_mq_tag_to_rq() tolerates an invalid tag for the tagset, checking it
against the number of tags and returning NULL if it is out of bounds.
But all the calls from the ublk driver have already verified the tag
against the ublk queue's queue depth. In ublk_commit_completion(),
ublk_handle_need_get_data(), and case UBLK_IO_COMMIT_AND_FETCH_REQ, the
tag has already been checked in __ublk_ch_uring_cmd(). In
ublk_abort_queue(), the loop bounds the tag by the queue depth. In
__ublk_check_and_get_req(), the tag has already been checked in
__ublk_ch_uring_cmd(), in the case of ublk_register_io_buf(), or in
ublk_check_and_get_req().

So just index the tagset's rqs array directly in the ublk driver.
Convert the tags to unsigned, as blk_mq_tag_to_rq() does.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/ublk_drv.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 2fd05c1bd30b..5b07329f5197 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -210,11 +210,11 @@ struct ublk_params_header {
 };
 
 static bool ublk_abort_requests(struct ublk_device *ub, struct ublk_queue *ubq);
 
 static inline struct request *__ublk_check_and_get_req(struct ublk_device *ub,
-		struct ublk_queue *ubq, int tag, size_t offset);
+		struct ublk_queue *ubq, unsigned tag, size_t offset);
 static inline unsigned int ublk_req_build_flags(struct request *req);
 static inline struct ublksrv_io_desc *ublk_get_iod(struct ublk_queue *ubq,
 						   int tag);
 static inline bool ublk_dev_is_user_copy(const struct ublk_device *ub)
 {
@@ -1515,11 +1515,11 @@ static void ublk_commit_completion(struct ublk_device *ub,
 	/* now this cmd slot is owned by nbd driver */
 	io->flags &= ~UBLK_IO_FLAG_OWNED_BY_SRV;
 	io->res = ub_cmd->result;
 
 	/* find the io request and complete */
-	req = blk_mq_tag_to_rq(ub->tag_set.tags[qid], tag);
+	req = ub->tag_set.tags[qid]->rqs[tag];
 	if (WARN_ON_ONCE(unlikely(!req)))
 		return;
 
 	if (req_op(req) == REQ_OP_ZONE_APPEND)
 		req->__sector = ub_cmd->zone_append_lba;
@@ -1533,11 +1533,11 @@ static void ublk_commit_completion(struct ublk_device *ub,
  * blk-mq queue, so we are called exclusively with blk-mq and ubq_daemon
  * context, so everything is serialized.
  */
 static void ublk_abort_queue(struct ublk_device *ub, struct ublk_queue *ubq)
 {
-	int i;
+	unsigned i;
 
 	for (i = 0; i < ubq->q_depth; i++) {
 		struct ublk_io *io = &ubq->ios[i];
 
 		if (!(io->flags & UBLK_IO_FLAG_ACTIVE)) {
@@ -1545,11 +1545,11 @@ static void ublk_abort_queue(struct ublk_device *ub, struct ublk_queue *ubq)
 
 			/*
 			 * Either we fail the request or ublk_rq_task_work_cb
 			 * will do it
 			 */
-			rq = blk_mq_tag_to_rq(ub->tag_set.tags[ubq->q_id], i);
+			rq = ub->tag_set.tags[ubq->q_id]->rqs[i];
 			if (rq && blk_mq_request_started(rq)) {
 				io->flags |= UBLK_IO_FLAG_ABORTED;
 				__ublk_fail_req(ubq, io, rq);
 			}
 		}
@@ -1824,14 +1824,14 @@ static void ublk_mark_io_ready(struct ublk_device *ub, struct ublk_queue *ubq)
 		complete_all(&ub->completion);
 	mutex_unlock(&ub->mutex);
 }
 
 static void ublk_handle_need_get_data(struct ublk_device *ub, int q_id,
-		int tag)
+		unsigned tag)
 {
 	struct ublk_queue *ubq = ublk_get_queue(ub, q_id);
-	struct request *req = blk_mq_tag_to_rq(ub->tag_set.tags[q_id], tag);
+	struct request *req = ub->tag_set.tags[q_id]->rqs[tag];
 
 	ublk_queue_cmd(ubq, req);
 }
 
 static inline int ublk_check_cmd_op(u32 cmd_op)
@@ -1989,11 +1989,11 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 
 		ublk_fill_io_cmd(io, cmd, ub_cmd->addr);
 		ublk_mark_io_ready(ub, ubq);
 		break;
 	case UBLK_IO_COMMIT_AND_FETCH_REQ:
-		req = blk_mq_tag_to_rq(ub->tag_set.tags[ub_cmd->q_id], tag);
+		req = ub->tag_set.tags[ub_cmd->q_id]->rqs[tag];
 
 		if (!(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV))
 			goto out;
 
 		if (ublk_need_map_io(ubq)) {
@@ -2033,18 +2033,18 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 			__func__, cmd_op, tag, ret, io->flags);
 	return ret;
 }
 
 static inline struct request *__ublk_check_and_get_req(struct ublk_device *ub,
-		struct ublk_queue *ubq, int tag, size_t offset)
+		struct ublk_queue *ubq, unsigned tag, size_t offset)
 {
 	struct request *req;
 
 	if (!ublk_need_req_ref(ubq))
 		return NULL;
 
-	req = blk_mq_tag_to_rq(ub->tag_set.tags[ubq->q_id], tag);
+	req = ub->tag_set.tags[ubq->q_id]->rqs[tag];
 	if (!req)
 		return NULL;
 
 	if (!ublk_get_req_ref(ubq, req))
 		return NULL;
-- 
2.45.2

