Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56055314D16
	for <linux-block@vger.kernel.org>; Fri,  1 May 2026 17:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777657313; cv=none; b=k1nmHpjcvY+F7FAiOufKHWE+cFaGSmT2CRBSBbqUAB3yLtweW5N903e9o95bDyzbwqbTstAP2Rp6U9W0u6Y1haMJ8orQ6m3jRCnY7YzrQaKeydRG104NEEcxK4quv72VbJjr+5/t+p/eQ1VX4uzR7gV/ihmJftOjHFodUnXHHUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777657313; c=relaxed/simple;
	bh=t2chcCgoTeGFtqMKgBeuImUIZQj1uYHzWSu12BrGW6I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NgQUrH3+GQoZlVPPW64L2A89kDRlpuH7P3EXgdYaUtesLgsrH5QXaP5uIHo/xhHDv9iQoWzbEyQaNSwiknlP0H0+efXFNQbUK35AncxCdLkM2fKdP9mmeZj3R/KK3VGuNbhkIQe7ktfErnSumIoMPrrX3Qa2VU0SvMvQIXd1KP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=MJ2ge+V7; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="MJ2ge+V7"
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6415vTqW1606281
	for <linux-block@vger.kernel.org>; Fri, 1 May 2026 10:41:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=ANYsRFX4VkTyvrPvtX
	605rK4sdQRy3Hf3owEiWUmSFY=; b=MJ2ge+V7L6G0JhguIcxyQUXQ1Px07cRwxn
	of7ZGG3Pbz7qGKJG8AuHvp85jknDyWzG0ERRRfAJdpfT7LQUxnWV8Uk6gf4wzFYD
	JCven7rFzeG3MzewH44VorJcUyTAeQgYUnzBNx+6KRdv0vIl9S2Bk4eAD3vCetmt
	k8tfpf9f2WMDkEQp8bEMnSHZY2OHKkcqvdRu5P3wceTrguiB+pcOZ0vAKzRyJiSh
	bmaG25d0U7MjF6h3jLemjqU36w2v8+uUQQUL1QIyR6oLpSV9P4dnJ4fHxaVoalT1
	RFW0BWFRpnlmPhmigQ6qEK3DrlYJYDfl8gvzeDPizEu9MFe/h5IA==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4dvgxgvqus-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Fri, 01 May 2026 10:41:50 -0700 (PDT)
Received: from twshared15933.04.frc1.facebook.com (2620:10d:c0a8:fe::f072) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.37; Fri, 1 May 2026 17:41:48 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id DF1CA15625C53; Fri,  1 May 2026 10:41:22 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <axboe@kernel.dk>, <hch@lst.de>, <linux-block@vger.kernel.org>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2] blk-mq: check for stale cached request in blk_mq_submit_bio
Date: Fri, 1 May 2026 10:41:19 -0700
Message-ID: <20260501174120.403960-1-kbusch@meta.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTAxMDE3MyBTYWx0ZWRfXzUCAD+/rY69t
 blwuyiaZqEexImMiydCKQehGmju1nXF+rB4EoNSaEKZPCyfJCEWfAPvYOXRow2jbYW6m1mE1vGV
 OM5t2J6XpeyiiR+PmRJHhOa4waquZO2qGpPCpV8Ca2IdLZANr3Esy/Gh99iBge5+zqZL3ELa+nz
 W9bNunNxKciohRj2ju1WfSnSmpNYWQ8eIzUoc8Mm1kddB+UZQFBZYaLdLXN90welDZc5nXcsfwD
 c/o9orQTBv8OZNbn7f5bfodHjd2vI6SmMTgZg3mZ3kQAQTyHjBcjASPThfn6KDToheb2nv932im
 SSAfhMaD9CMSVCTVlBYw1zaMgUR4ry1encg35XnVWRDaFs4CUg4t9K1MWAMCqxmudplO1Q99jrH
 8Jz2xbJdzjVAVAkIyllNeDNaUfvaMSuOzUhuonD67jWabPQMGGo1WpHruTjtvPRLPqXhV+Qka2x
 AxS0eQZIxEkDImhrqrw==
X-Authority-Analysis: v=2.4 cv=G+Ys1dk5 c=1 sm=1 tr=0 ts=69f4e5de cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=JnKecZnUtZousrUlYMGU:22 a=VwQbUJbxAAAA:8 a=20MqeiG0cJqsOoDxsYMA:9
X-Proofpoint-GUID: NJd4BUWCU8bbhhYMw7HD7Q6OhwSlpgLi
X-Proofpoint-ORIG-GUID: NJd4BUWCU8bbhhYMw7HD7Q6OhwSlpgLi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-01_05,2026-04-30_02,2025-10-01_01

From: Keith Busch <kbusch@kernel.org>

When submitting a bio to blk-mq, if the task should sleep after peeking
a cached request, but before it pops it, the plug flushes and calls
blk_mq_free_plug_rqs, freeing the cached_rqs. This creates a
use-after-free bug. Fix this by ensuring the cached_rqs still contains
our peeked request, and retry the bio submission without it if the
request had been freed.

The code had already warned of this possibility, and specifically popped
the request before other known blocking calls, but it didn't handle a
blocking GFP_NOIO alloc. Under memory pressure, allocating the split bio
or the integrity payload are two such cases that can block. The blk-mq
submit_bio function continues using the peeked request that was already
freed and re-initialized, so the driver receives that request with a
NULL'ed mq_hctx, and inevitably panics.

Relevant kernel messages if you should encounter this condition, where
the "WARNING" is the harbinger of the panic about to happen:

------------[ cut here ]------------
 WARNING: CPU: 4 PID: 80820 at block/blk-mq.c:3071 blk_mq_submit_bio+0x2c=
f/0x5b0
...
 BUG: kernel NULL pointer dereference, address: 0000000000000100
 #PF: supervisor read access in kernel mode
 #PF: error_code(0x0000) - not-present page
 PGD 6b367b067 P4D 6b367b067 PUD 6bb5eb067 PMD 0
 Oops: Oops: 0000 [#1] SMP
...
 Call Trace:
  <TASK>
  blk_mq_dispatch_queue_requests+0x46/0x120
  blk_mq_flush_plug_list+0x38/0x130
  blk_add_rq_to_plug+0xa2/0x160
  blk_mq_submit_bio+0x3ab/0x5b0
  __submit_bio+0x3a/0x260
  submit_bio_noacct_nocheck+0xc6/0x2b0
  btrfs_submit_bbio+0x14d/0x520
  ? btrfs_get_extent+0x43f/0x640
  submit_extent_folio+0x31f/0x340
  btrfs_do_readpage+0x2d7/0xac0
  btrfs_readahead+0x142/0x200
  ? clear_state_bit+0x520/0x520
  read_pages+0x57/0x200
  ? folio_alloc_noprof+0x10c/0x310
  page_cache_ra_unbounded+0x28c/0x480
  ? asm_sysvec_call_function+0x16/0x20
  ? blk_cgroup_congested+0xa/0x50
  ? page_cache_sync_ra+0x41/0x2d0
  filemap_get_pages+0x347/0xd50
  filemap_read+0xd3/0x500
  ? 0xffffffff81000000
  __io_read+0x111/0x440
  io_read+0x23/0x90
  __io_issue_sqe+0x40/0x120
  io_issue_sqe+0x3f/0x3a0
  io_submit_sqes+0x2bd/0x790
  __se_sys_io_uring_enter+0x100/0xc10
  ? eventfd_read+0x100/0x1f0
  ? futex_wake+0x1b9/0x260
  ? syscall_trace_enter+0x34/0x1d0
  do_syscall_64+0x6a/0x250
  entry_SYSCALL_64_after_hwframe+0x4b/0x53

Fixes: b0077e269f6c1 ("blk-mq: make sure active queue usage is held for b=
io_integrity_prep()")
Fixes: 7b4f36cd22a65 ("block: ensure we hold a queue reference when using=
 queue limits")
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
v1->v2:

  Warn if the cached_rqs is not NULL when the peeked request isn't the
  top. This should never happen, but such a bug would be difficult to
  figure out was happening without the warning. The previous warn was
  essential to figure out the bug this patch is addressing.

  If the peeked request was freed, rerun the entire bio setup. The first
  version potentially performed operations outside the queue usage
  counter protection, so may have resulted in an invalid bio if it was
  racing against a driver updating queue limites. This retry also
  required clearing the integrity allocation if it was done since
  updated limits may make any previous setup invalid.

 block/blk-mq.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4c5c16cce4f8f..73ef3e4be5123 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3096,22 +3096,27 @@ static struct request *blk_mq_peek_cached_request=
(struct blk_plug *plug,
 	return rq;
 }
=20
-static void blk_mq_use_cached_rq(struct request *rq, struct blk_plug *pl=
ug,
+static bool blk_mq_use_cached_rq(struct request *rq, struct blk_plug *pl=
ug,
 		struct bio *bio)
 {
-	if (rq_list_pop(&plug->cached_rqs) !=3D rq)
-		WARN_ON_ONCE(1);
-
 	/*
-	 * If any qos ->throttle() end up blocking, we will have flushed the
-	 * plug and hence killed the cached_rq list as well. Pop this entry
-	 * before we throttle.
+	 * We will have flushed the plug and hence killed the cached_rq list as
+	 * well if anything had scheduled. Pop this entry before we throttle if
+	 * the entry is still valid.
 	 */
+	struct request *popped =3D rq_list_pop(&plug->cached_rqs);
+
+	if (popped !=3D rq) {
+		WARN_ON_ONCE(popped);
+		return false;
+	}
+
 	rq_qos_throttle(rq->q, bio);
=20
 	blk_mq_rq_time_init(rq, blk_time_get_ns());
 	rq->cmd_flags =3D bio->bi_opf;
 	INIT_LIST_HEAD(&rq->queuelist);
+	return true;
 }
=20
 static bool bio_unaligned(const struct bio *bio, struct request_queue *q=
)
@@ -3154,6 +3159,7 @@ void blk_mq_submit_bio(struct bio *bio)
 	 */
 	rq =3D blk_mq_peek_cached_request(plug, q, bio->bi_opf);
=20
+retry:
 	/*
 	 * A BIO that was released from a zone write plug has already been
 	 * through the preparation in this function, already holds a reference
@@ -3211,7 +3217,14 @@ void blk_mq_submit_bio(struct bio *bio)
=20
 new_request:
 	if (rq) {
-		blk_mq_use_cached_rq(rq, plug, bio);
+		if (!blk_mq_use_cached_rq(rq, plug, bio)) {
+			struct bio_integrity_payload *bip =3D bio_integrity(bio);
+
+			if (bip && (bip->bip_flags & BIP_BLOCK_INTEGRITY))
+				bio_integrity_free(bio);
+			rq =3D NULL;
+			goto retry;
+		}
 	} else {
 		rq =3D blk_mq_get_new_requests(q, plug, bio);
 		if (unlikely(!rq)) {
--=20
2.52.0

