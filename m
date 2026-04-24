Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65F43F660E
	for <linux-block@vger.kernel.org>; Fri, 24 Apr 2026 18:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777056361; cv=none; b=Nmc3C+SNNaDarIByfkPDGD+W6Qm8fwPz9X70EqExY8Sie+jEbC5BIYrFaSHIYzMsk4TLk5AZkNXpLWh1WkXfYEzcQcFN1r4XIWhXyervy4Xjut8PSGXRtbIYEyRQj3FC0h+RsRgne3t4VTVWCFK7ATByN2ctS35VX/srZxMZcaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777056361; c=relaxed/simple;
	bh=iuT50PCTIzt5Qr39Yc/GiDs0jWq06cSgdbrQb2HHbfM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PyR3mjgfzq4ofFfeV3S+Y+lpmoIx26bmR8tyAC1sb7TDxRYQ8nNZCFYTMr0fNA0bniDOw5FY2tnfFxngKaHLxlzUwFh1b4bGlf+AuYS/ZXLYfRw3J5aIcdr5QbPhwqCvIdnBkp4oWVXjf+GnUj2gHYVQLO2I00pI4co3z7f7MMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=Bx6mCHUF; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="Bx6mCHUF"
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63O5ZNIk3707945
	for <linux-block@vger.kernel.org>; Fri, 24 Apr 2026 11:45:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=7gZ5HuQhUAohAJ1AoV
	n8otKYTNoMHGeCgeiQKaR3d7U=; b=Bx6mCHUF0r7H51mKe3UYa2FZSdow9icPpL
	iAEIrW90hxBQWrT/4cmzcbfVsPWKCDyFAZGQqkz/nm4q4j39wB37Y4kPvcVnQb/r
	EV9LjkbAL0knZHp2TzaNZVXDvyZIbj5tnjLqAUTVX9L/qbjOTyAjdzukpyWZbXfe
	MEtXmw5wSpANPhEl4EaMiw7ATAeNtRTxLxkSCZTuaJa2Dr514lsXCsSGBBoIErX3
	ugeESuPrUt9iu9Ud/t5hQvecwJFwYCqkq1VSownghoi/w6j5t/GRpD4xnlog7b/d
	f57DVU9xjWOFlAoAiAK3UPuq7UVHR/9djUk8hV8SUvhUgLXqjOpg==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4dpepb8r36-9
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Fri, 24 Apr 2026 11:45:57 -0700 (PDT)
Received: from twshared10186.03.snb1.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.37; Fri, 24 Apr 2026 18:45:56 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 5FA23137371B8; Fri, 24 Apr 2026 11:45:52 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <axboe@kernel.dk>, <hch@lst.de>, <linux-block@vger.kernel.org>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCH] blk-mq: recover from stale cached request in blk_mq_submit_bio
Date: Fri, 24 Apr 2026 11:45:51 -0700
Message-ID: <20260424184551.1540062-1-kbusch@meta.com>
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
X-Proofpoint-GUID: TDeSPhw66RRS4mVQzqFYekK09YFtZgwf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDE4MSBTYWx0ZWRfX8KXTSQhI+sK1
 5JMgqOzT1KNBCas+gmrTzAkOUZpsqhw4jgiPOuHdEeBh5zuEIsOnHiIFjA7qSK878M0J0E2kgLz
 fvbnl+xPM3E1tAs6nPdQYTXyfeob5ze3amzeOUdINrlQaN+GwZ4R5lINbgMmFkZmpV+ALiT/EBt
 1mZ0T9TBEth0U9lHPFweR1xaqJqrQrmBmhFoI24pha1Sdy5Z7aVTEVpTrh+W/8rODorLt0JtrI8
 Emsik3BveKsoyY6jAh0uxXzkLwqXrvbOqGz91T4j+hii6SuyStI1BBiPKR+XG6ESQloNZMlIJ5K
 aVag8cPIp2SC2DxRs9jEDf5UEIvRui9CUyMcAmzu4OM/xNJSgqzckMqMQs5VnwWtLBXVNXaThWp
 FoFuW9Ya4ZSyyOCVJ+sBJhYGTvFxBovTXnQzVEk7kINx4Lmbn3RcrmIvvkgy3l1CLwL2c89VTaL
 188Gnk0Is53Sc8ZA6LA==
X-Proofpoint-ORIG-GUID: TDeSPhw66RRS4mVQzqFYekK09YFtZgwf
X-Authority-Analysis: v=2.4 cv=GcknWwXL c=1 sm=1 tr=0 ts=69ebba65 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=wpfVPzegXHpEFt3DAXn9:22 a=VwQbUJbxAAAA:8 a=20MqeiG0cJqsOoDxsYMA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-24_02,2026-04-21_02,2025-10-01_01

From: Keith Busch <kbusch@kernel.org>

When submitting a bio to blk-mq, if the task should sleep after peeking
a cached request, but before it pops it, the plug is flushed and calls
blk_mq_free_plug_rqs, freeing the cached_rqs.

The code had already warned of this possibility, and specifically popped
the request before other known blocking calls, but it didn't handle a
blocking GFP_NOIO alloc. Allocating the split bio or the integrity
payload are two such cases that can block under high memory pressure.
The blk-mq submit_bio function continues with the peeked request that
was just freed and re-initialized, so the driver receives that request
with a NULL'ed mq_hctx, and inevitably panics.

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
 CPU: 4 UID: 36666 PID: 80820 Comm: IOUringThread0 Kdump: loaded Tainted:=
 G S      W           6.16.1-0_fbk3_0_gd6c130b80483 #1 NONE
 Tainted: [S]=3DCPU_OUT_OF_SPEC, [W]=3DWARN
 Hardware name: Quanta Twin Lakes MP/Twin Lakes Passive MP, BIOS F09_3A23=
 12/08/2020
 RIP: 0010:nvme_queue_rqs+0x93/0x180
 Code: 44 24 48 00 00 00 00 4d 85 f6 74 19 49 8b 44 24 10 4c 3b b0 00 01 =
00 00 74 0b 4c 89 f7 4c 89 fe e8 c2 62 cd ff 49 8b 44 24 10 <4c> 8b b0 00=
 01 00 00 49 f7 46 78 01 00 00 00 74 1a 49 8b 3e 8b 8f
 RSP: 0018:ffffc9004a8f34a8 EFLAGS: 00010246
 RAX: 0000000000000000 RBX: ffff888c12b92920 RCX: 0000000000000020
 RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff888c12b92920
 RBP: 0000000000000000 R08: 000000000000000b R09: ffffffffffffffff
 R10: 0000000000092800 R11: 000000000002e000 R12: ffff88828e325c00
 R13: 0000000000000000 R14: 0000000000000000 R15: ffffc9004a8f34a8
 FS:  00007f7cf30e6640(0000) GS:ffff8890fa908000(0000) knlGS:000000000000=
0000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000000000000100 CR3: 00000006bb387006 CR4: 00000000007726f0
 PKRU: 55555554
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
 RIP: 0033:0x95d621e
 Code: 8b 12 f6 c2 01 75 2a 84 c9 74 22 44 0f b6 d1 41 09 c2 8b bf cc 00 =
00 00 41 b9 08 00 00 00 b8 aa 01 00 00 31 d2 45 31 c0 0f 05 <48> 89 c6 89=
 f0 5d c3 83 c8 02 eb d5 cc cc cc cc cc cc 55 48 89 e5
 RSP: 002b:00007f7cf30dc630 EFLAGS: 00000246 ORIG_RAX: 00000000000001aa
 RAX: ffffffffffffffda RBX: 00007f7d18907000 RCX: 00000000095d621e
 RDX: 0000000000000000 RSI: 0000000000000006 RDI: 00000000000004cf
 RBP: 00007f7cf30dc630 R08: 0000000000000000 R09: 0000000000000008
 R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
 R13: 0000000000000001 R14: 00007f7d18907320 R15: 0000000000000009
  </TASK>

Fixes: b0077e269f6c1 ("blk-mq: make sure active queue usage is held for b=
io_integrity_prep()")
Fixes: 7b4f36cd22a65 ("block: ensure we hold a queue reference when using=
 queue limits")
Signed-off-by: Keith Busch <kbusch@kernel.org>
---

 block/blk-mq.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4c5c16cce4f8f..ea44bd73a94b7 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3096,22 +3096,23 @@ static struct request *blk_mq_peek_cached_request=
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
+	 * well if anything had blocked. Pop this entry before we throttle if
+	 * the entry is still valid.
 	 */
+	if (rq_list_pop(&plug->cached_rqs) !=3D rq)
+		return false;
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
@@ -3211,8 +3212,13 @@ void blk_mq_submit_bio(struct bio *bio)
=20
 new_request:
 	if (rq) {
-		blk_mq_use_cached_rq(rq, plug, bio);
-	} else {
+		if (!blk_mq_use_cached_rq(rq, plug, bio)) {
+			rq =3D NULL;
+			if (unlikely(bio_queue_enter(bio)))
+				return;
+		}
+	}
+	if (!rq) {
 		rq =3D blk_mq_get_new_requests(q, plug, bio);
 		if (unlikely(!rq)) {
 			if (bio->bi_opf & REQ_NOWAIT)
--=20
2.52.0

