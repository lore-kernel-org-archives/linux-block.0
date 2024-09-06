Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E591B85E5
	for <linux-block@vger.kernel.org>; Fri,  6 Sep 2024 19:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725651948; cv=none; b=rdfyWa3u0Cs0IxdMROW8++wIBF0Gf2qSAl6TpdJphQQraXrSj3C+GcmseSI0TMz4KggkdqFJfqkQX37opBuryz64nZ+lwzLbbBnCVQfGjPAxvUzO4t52d+eu6J0XYtrA31R5qBSO3L3trNSuoRQCU+uG8upgRIOaKWULv/txpSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725651948; c=relaxed/simple;
	bh=l/jNdiXpLDG0SNsdrXr555BI7x2oH5i/+/iwxmWY6rk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KvmRQiBDvdUO14b8Iju0p2G9kyr0AVjB0FPqfxtgVZU5od4Ufz+JQYQiQuei/o6bi/G+HS6+XYfsg0JmVU2vHrWC07CMab8WHhTS6A1zEHgrYxv9htL0BUXYpPlyX5nyrsYBM2WAs3fl6mqwFauufXITByBgSyl/Kv+TfXw7VMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=ixpI7toT; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="ixpI7toT"
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 486HRVBa011786
	for <linux-block@vger.kernel.org>; Fri, 6 Sep 2024 12:45:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=s2048-2021-q4; bh=8rI
	6CMTj2J3FpDGqCnJP8sUIE2/1c2C05xB4E0tqk+w=; b=ixpI7toT6/4Ju4adUhM
	xuSULpdKahVPHtQdeSfNuAKjmQPWqX8WfdQbagqcw4U9cIkVeJxk2A/ZbwT6CCz6
	EfeVqOW5AikIkPTbmazoozag63av/uENpD9EhbCnptVyKWU3lC6T5N6tUFMd0ZuG
	bfA1DcakeVmxFx/AlXZs63Q0az5bITdSsphVEHBuW8EJbb5kLqfIzdc5t9RVu6lX
	vHnGv1AuXVT2KTpMNt7GhOLvkikcLWTbpPX7LK0R3kWJnHNom4Ce88uPX1q+CZw+
	gh0LE/6KwT63IJTFbr1xq+cG4ic5fq0e43n5jn+vxdRKkHOSK/nhrA+zD/WaOgQn
	s3w==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 41fhy1ymd9-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Fri, 06 Sep 2024 12:45:45 -0700 (PDT)
Received: from twshared8196.02.ash9.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Fri, 6 Sep 2024 19:45:43 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 7C18B12B5B59A; Fri,  6 Sep 2024 12:45:41 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <axboe@kernel.dk>, <linux-block@vger.kernel.org>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCH] blk-mq: add missing unplug trace event
Date: Fri, 6 Sep 2024 12:45:40 -0700
Message-ID: <20240906194540.3719642-1-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 44Kq-8kIlukLeQgOJ-8lLt4wk87oMb5f
X-Proofpoint-ORIG-GUID: 44Kq-8kIlukLeQgOJ-8lLt4wk87oMb5f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_05,2024-09-06_01,2024-09-02_01

From: Keith Busch <kbusch@kernel.org>

The single-queue optimized list flush doesn't have an unplug trace event
to pair with the plug event. Add one.

In the unlikely event an error occurs and falls back to the less
optimized plug flush path, it's possible a 2nd unplug trace event will
be logged, but it will show the remainig count that weren't previously
handled.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/blk-mq.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 79cc66275f1cd..3076019a9e0a7 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2757,6 +2757,7 @@ static void blk_mq_dispatch_plug_list(struct blk_pl=
ug *plug, bool from_sched)
 void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
 {
 	struct request *rq;
+	unsigned int depth;
=20
 	/*
 	 * We may have been called recursively midway through handling
@@ -2767,6 +2768,7 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, =
bool from_schedule)
 	 */
 	if (plug->rq_count =3D=3D 0)
 		return;
+	depth =3D plug->rq_count;
 	plug->rq_count =3D 0;
=20
 	if (!plug->multiple_queues && !plug->has_elevator && !from_schedule) {
@@ -2774,6 +2776,7 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, =
bool from_schedule)
=20
 		rq =3D rq_list_peek(&plug->mq_list);
 		q =3D rq->q;
+		trace_block_unplug(q, depth, true);
=20
 		/*
 		 * Peek first request and see if we have a ->queue_rqs() hook.
--=20
2.43.5

