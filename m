Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815A7579806
	for <linux-block@vger.kernel.org>; Tue, 22 Sep 2026 17:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790098053; cv=none; b=JOmAAMJQGBrosnWHl953QDh89sotf0d0f+r7VUMfMUjVC/EsPND36RyfvV54g9aqw4cTbCzKNP5wiSNoqtOOSeXy7hq82LqQ45S1oe28uz1aG3+mw4TmUqlty/XwYBuEPj9LB/wRs3r9qZfGrOkDMvegzrgvpFxYaZhP17l5O+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790098053; c=relaxed/simple;
	bh=XTTsStmTTpH1UdMbAn34Zpy7D2B9GAGap9GcXTkwXFU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nRX+x5XaGMySY2rnOOLrxKXpDubxTwuJi80CgJ2Wv21CknbuAvcozksNRYWmVyzM74tPUeE6g8CW+9vKyp83B31/f3bQZTmbKkH/zpuYeSwUrdIZKDaIrNUgBHoM4d/be1S7Ks04KrtRUvm/UMl0oLZRXeTOeli7FjkgMJwK9KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=LRMR/dAS; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="LRMR/dAS"
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68MH1oM23981876
	for <linux-block@vger.kernel.org>; Tue, 22 Sep 2026 10:27:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps82601-s2048-2026-q3; bh=h710CD/+m
	ZNimAxffx9SesZHz/+Uejm0o+uiL1NsvkI=; b=LRMR/dASqO4EkRu9fL9zEhh6y
	CgT003rUKPhtR6jiwWOAJVVpdywXYahplfGRvH7REmKOxCVW4+sV5IHjh10WFAH0
	2unznhuIeMB9TNdtgCZ0kj7ycc9vu3OazlV+wzxPAe3rEX13do3ButlwfpxY8afI
	oPBksKjEGHcMdZUOO4PEJgumsfzUcnIA3F3HveN32D5S7Vr9JSv6p4uEuq+I5aUh
	FQDooJ6bSZo1t0me85s7I4rCBYEW48yt56Jq6Imc/WdINmjGLwm6LTDsER66HcYx
	FThxmJbz2fofHyu4gail9hY8oyIdng15g9uZB/Nv4NBB91dmgXerik3vcHjQw==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4gsr4cffsb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Tue, 22 Sep 2026 10:27:26 -0700 (PDT)
Received: from twshared15303.01.snb2.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.49; Tue, 22 Sep 2026 17:27:25 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id DD0732C3D7B6C; Tue, 22 Sep 2026 10:27:12 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <axboe@kernel.dk>, <linux-block@vger.kernel.org>
CC: <hare@kernel.org>, <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        Henry Hu
	<huhai@kylinos.cn>
Subject: [PATCHv2 1/2] blk-mq: set RQF_USE_SCHED when the operation is known
Date: Tue, 22 Sep 2026 10:27:10 -0700
Message-ID: <20260922172711.1573186-1-kbusch@meta.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: sYWLmdi54Qq9FaSscJP_5SPkMhhITOLY
X-Authority-Analysis: v=2.4 cv=SKnXx+vH c=1 sm=1 tr=0 ts=6ab2ba7e cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=xtH7KyWI9dI7BmFOsl-x:22 a=VwQbUJbxAAAA:8 a=Byx-y9mGAAAA:8
 a=0RVA0AUJAqKfxIjY3rsA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDI1NSBTYWx0ZWRfX0z4Qpmv/oiQ9
 TQkd6jCnaahhbflEsfAYSsQ0Z05N+9NsKA7wUlvO7sM25VBLrmqpJemitJswh+SQPpTtDuwiGSC
 oAkI/WaMGHZA4suSdwLiNhbBACpYMO4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDI1NSBTYWx0ZWRfXyameRvlOmNvp
 AlHXBL3RoczrnUg0hCJYVr0t+ZbGXm/zoOAre42WVoo4SzAGMk8IeIKsbh9/zJNmVXxMgXM1V9b
 AZrpjAvU8OJ/aXe7RhmOjcfCs+riHLSmqNh/QY6kHzQrt7sTmahJjSioH+5cr5dy+Nz/5Vm14xi
 RibxI8h+aFaxGtmwFV7OpdNgaQexZUGdFbC6OFXudSYVZia5jLzCWZwQdDfVzYxk2xs9ccmi8WN
 TZ60REUrK2SoukwUoyn989iLqiMADY2ZklNIDceohL/BPmZAIDNye7DJIBlzgo2YE8y39pMWbY+
 hQTFaNv/a8xBwYJbitf/rR3v9mVE8gYpye9vRoiOxg+XsDauCkRR6BkqaoAl/tzMUulOntHbEtS
 Mo9K1wPs1Ym7Vbl2ZotKuPGblgvpYfZRUd5OyzOB6xyLIUBJ6NWNCpbZydOYhin73dT51qGb7YV
 TozG5N6yX2v+2Y682Bw==
X-Proofpoint-GUID: sYWLmdi54Qq9FaSscJP_5SPkMhhITOLY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_02,2026-09-21_02,2025-10-01_01

From: Keith Busch <kbusch@kernel.org>

The cached requests are allocated for one operation but can be handed
out for another. A passthrough command has RQF_USE_SCHED cleared, so
using those flags for a subsequent read/write bio will insert it into
the scheduler without ->prepare_request() and frees it without
->finish_request(). For kyber, this leaks the domain token acquired at
dispatch and stalls the queue.

Don't set RQF_USE_SCHED based on the first operation the batch happened
to be allocated for. Instead, set it after the request is claimed by an
operation. Introduce a helper function, blk_mq_rq_late_init() for this,
and absorb blk_mq_rq_time_init() since the two run together.

Fixes: 4b6a5d9cea91 ("block: enable batched allocation for blk_mq_alloc_r=
equest()")
Link: https://lore.kernel.org/linux-block/20260916151655.2588-1-158158270=
59@163.com/
Reported-by: Henry Hu <huhai@kylinos.cn>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
v1->v2:
  Introduced a new helper function for the late request init

  Split off the flush handling into a separate patch.

  Updated mq-deadline comment

 block/blk-mq.c      | 59 ++++++++++++++++++++++++++++-----------------
 block/mq-deadline.c |  2 +-
 2 files changed, 38 insertions(+), 23 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index a26a11c73ee3e..5df6d2244db82 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -447,16 +447,6 @@ static struct request *blk_mq_rq_ctx_init(struct blk=
_mq_alloc_data *data,
 	WRITE_ONCE(rq->deadline, 0);
 	req_ref_set(rq, 1);
=20
-	if (rq->rq_flags & RQF_USE_SCHED) {
-		struct elevator_queue *e =3D data->q->elevator;
-
-		INIT_HLIST_NODE(&rq->hash);
-		RB_CLEAR_NODE(&rq->rb_node);
-
-		if (e->type->ops.prepare_request)
-			e->type->ops.prepare_request(rq);
-	}
-
 	return rq;
 }
=20
@@ -498,6 +488,12 @@ __blk_mq_alloc_requests_batch(struct blk_mq_alloc_da=
ta *data)
 	return rq_list_pop(data->cached_rqs);
 }
=20
+static bool blk_op_bypass_sched(blk_opf_t opf)
+{
+	return (opf & REQ_OP_MASK) =3D=3D REQ_OP_FLUSH ||
+	       blk_op_is_passthrough(opf);
+}
+
 static void blk_mq_limit_depth(struct blk_mq_alloc_data *data)
 {
 	struct elevator_mq_ops *ops;
@@ -518,12 +514,10 @@ static void blk_mq_limit_depth(struct blk_mq_alloc_=
data *data)
 	 * Flush/passthrough requests are special and go directly to the
 	 * dispatch list, they are not subject to the async_depth limit.
 	 */
-	if ((data->cmd_flags & REQ_OP_MASK) =3D=3D REQ_OP_FLUSH ||
-	    blk_op_is_passthrough(data->cmd_flags))
+	if (blk_op_bypass_sched(data->cmd_flags))
 		return;
=20
 	WARN_ON_ONCE(data->flags & BLK_MQ_REQ_RESERVED);
-	data->rq_flags |=3D RQF_USE_SCHED;
=20
 	/*
 	 * By default, sync requests have no limit, and async requests are
@@ -534,6 +528,29 @@ static void blk_mq_limit_depth(struct blk_mq_alloc_d=
ata *data)
 		ops->limit_depth(data->cmd_flags, data);
 }
=20
+/*
+ * Finish initializing a request once it has been claimed for an operati=
on.
+ * Cached requests are allocated before that operation is known.
+ */
+static void blk_mq_rq_late_init(struct request *rq, u64 alloc_time_ns)
+{
+	struct elevator_queue *e;
+
+	blk_mq_rq_time_init(rq, alloc_time_ns);
+
+	if (!(rq->rq_flags & RQF_SCHED_TAGS) || (rq->rq_flags & RQF_RESV) ||
+	    blk_op_bypass_sched(rq->cmd_flags))
+		return;
+
+	rq->rq_flags |=3D RQF_USE_SCHED;
+	INIT_HLIST_NODE(&rq->hash);
+	RB_CLEAR_NODE(&rq->rb_node);
+
+	e =3D rq->q->elevator;
+	if (e->type->ops.prepare_request)
+		e->type->ops.prepare_request(rq);
+}
+
 static struct request *__blk_mq_alloc_requests(struct blk_mq_alloc_data =
*data)
 {
 	struct request_queue *q =3D data->q;
@@ -562,7 +579,7 @@ static struct request *__blk_mq_alloc_requests(struct=
 blk_mq_alloc_data *data)
 	if (data->nr_tags > 1) {
 		rq =3D __blk_mq_alloc_requests_batch(data);
 		if (rq) {
-			blk_mq_rq_time_init(rq, alloc_time_ns);
+			blk_mq_rq_late_init(rq, alloc_time_ns);
 			return rq;
 		}
 		data->nr_tags =3D 1;
@@ -590,7 +607,7 @@ static struct request *__blk_mq_alloc_requests(struct=
 blk_mq_alloc_data *data)
 	if (!(data->rq_flags & RQF_SCHED_TAGS))
 		blk_mq_inc_active_requests(data->hctx);
 	rq =3D blk_mq_rq_ctx_init(data, blk_mq_tags_from_data(data), tag);
-	blk_mq_rq_time_init(rq, alloc_time_ns);
+	blk_mq_rq_late_init(rq, alloc_time_ns);
 	return rq;
 }
=20
@@ -637,8 +654,6 @@ static struct request *blk_mq_alloc_cached_request(st=
ruct request_queue *q,
 		if (plug->nr_ios =3D=3D 1)
 			return NULL;
 		rq =3D blk_mq_rq_cache_fill(q, plug, opf, flags);
-		if (!rq)
-			return NULL;
 	} else {
 		rq =3D rq_list_peek(&plug->cached_rqs);
 		if (!rq || rq->q !=3D q)
@@ -650,11 +665,11 @@ static struct request *blk_mq_alloc_cached_request(=
struct request_queue *q,
 			return NULL;
=20
 		rq_list_pop(&plug->cached_rqs);
-		blk_mq_rq_time_init(rq, blk_time_get_ns());
+		rq->cmd_flags =3D opf;
+		INIT_LIST_HEAD(&rq->queuelist);
+		blk_mq_rq_late_init(rq, blk_time_get_ns());
 	}
=20
-	rq->cmd_flags =3D opf;
-	INIT_LIST_HEAD(&rq->queuelist);
 	return rq;
 }
=20
@@ -766,7 +781,7 @@ struct request *blk_mq_alloc_request_hctx(struct requ=
est_queue *q,
 	if (!(data.rq_flags & RQF_SCHED_TAGS))
 		blk_mq_inc_active_requests(data.hctx);
 	rq =3D blk_mq_rq_ctx_init(&data, blk_mq_tags_from_data(&data), tag);
-	blk_mq_rq_time_init(rq, alloc_time_ns);
+	blk_mq_rq_late_init(rq, alloc_time_ns);
 	rq->__data_len =3D 0;
 	rq->phys_gap_bit =3D 0;
 	rq->__sector =3D (sector_t) -1;
@@ -3163,9 +3178,9 @@ void blk_mq_submit_bio(struct bio *bio)
 new_request:
 	if (rq) {
 		rq_qos_throttle(rq->q, bio);
-		blk_mq_rq_time_init(rq, blk_time_get_ns());
 		rq->cmd_flags =3D bio->bi_opf;
 		INIT_LIST_HEAD(&rq->queuelist);
+		blk_mq_rq_late_init(rq, blk_time_get_ns());
 	} else {
 		rq =3D blk_mq_get_new_requests(q, plug, bio);
 		if (unlikely(!rq)) {
diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 5f643c0ce2a86..e5db1ee097c35 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -685,7 +685,7 @@ static void dd_insert_requests(struct blk_mq_hw_ctx *=
hctx,
 	blk_mq_free_requests(&free);
 }
=20
-/* Callback from inside blk_mq_rq_ctx_init(). */
+/* Callback from inside blk_mq_rq_late_init(). */
 static void dd_prepare_request(struct request *rq)
 {
 	rq->elv.priv[0] =3D NULL;
--=20
2.52.0

