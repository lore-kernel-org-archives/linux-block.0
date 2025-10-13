Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B5A2D97BD
	for <linux-block@vger.kernel.org>; Mon, 13 Oct 2025 19:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760383708; cv=none; b=eoj/Avh2rdEq/S4FDyzHglVQRjM16rsW83GZqRjy6JNIIWnBnvC/u4i/9mkX1wn0HB+xsiHsBkZ6N70jyyewwYrivYias3TZAFBbds5AX+kyLW5tECO+8u/9tSF7oo2Bei0xjK71wdx1ju4dntequuH9HCTqqBpJ9kUTdOCI3ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760383708; c=relaxed/simple;
	bh=4swSA9ET2K7kM1XdKbpenRzDY883tskWuUYYzprfsBE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O6SaLUF9FdlJ3pYJVTd3DV1fPblCHY8V1oSbCpRZI//4uevW1mEV1JrcsswnusPL0ISnap1rFypOJ+tvknG16wt1XZJ+jEnBjLjRyf7Gk6GQGlJsASLY52xv09rG8ZKm+lOmFvH+4VgiWY1r/bPHP46MN4yFIVR72sbSMBGghtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=dsq5Xy75; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="dsq5Xy75"
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4clnSn1t9tzm0yT9;
	Mon, 13 Oct 2025 19:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1760383703; x=1762975704; bh=EWO6Z
	dy+4MsHImGM7LdlQRTncotLJrjGBd7nqqaAZhM=; b=dsq5Xy75NZagu0L6DCwyn
	KZ05DYKrfDxn4waQsxfuZWPbhLstr2eDm+FYH1rTAsZbcNf/dSHsqWwn2kUrr8kX
	Bg8HQnF4A2F6ahupi56BPuK0XeaIjkzukJkuuRP2nh8TrDQeExlY9TdtaxyCtovk
	jYj+t6TqKjO0gtzN82YMDTmRUc8g/d9YW6zpMMITI1bcUVff+cHj091yS7oI0RzI
	r+6nDq6jhiT1XPV/y3k0fBC4oAiZSVTwKwRQhyh0OwVbXQs69ppv+RO68x4IRyNl
	sjCe/Yp4UfYqmhS6xoKUcyz5NzKRRMnc5vjz0tnt7QDB051VIymEpO0CvVHeamhm
	A==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id QikRJ1bNHR-v; Mon, 13 Oct 2025 19:28:23 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4clnSg3Mfvzm0yTQ;
	Mon, 13 Oct 2025 19:28:18 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Yu Kuai <yukuai@kernel.org>,
	chengkaitao <chengkaitao@kylinos.cn>
Subject: [PATCH 1/2] block/mq-deadline: Introduce dd_start_request()
Date: Mon, 13 Oct 2025 12:28:02 -0700
Message-ID: <20251013192803.4168772-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.51.0.760.g7b8bcc2412-goog
In-Reply-To: <20251013192803.4168772-1-bvanassche@acm.org>
References: <20251013192803.4168772-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Prepare for adding a second caller of this function. No functionality
has been changed.

Cc: Damien Le Moal <dlemoal@kernel.org>
Cc: Yu Kuai <yukuai@kernel.org>
Cc: chengkaitao <chengkaitao@kylinos.cn>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/mq-deadline.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 3e741d33142d..647a45f6d935 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -306,6 +306,19 @@ static bool started_after(struct deadline_data *dd, =
struct request *rq,
 	return time_after(start_time, latest_start);
 }
=20
+static struct request *dd_start_request(struct deadline_data *dd,
+					enum dd_data_dir data_dir,
+					struct request *rq)
+{
+	u8 ioprio_class =3D dd_rq_ioclass(rq);
+	enum dd_prio prio =3D ioprio_class_to_prio[ioprio_class];
+
+	dd->per_prio[prio].latest_pos[data_dir] =3D blk_rq_pos(rq);
+	dd->per_prio[prio].stats.dispatched++;
+	rq->rq_flags |=3D RQF_STARTED;
+	return rq;
+}
+
 /*
  * deadline_dispatch_requests selects the best request according to
  * read/write expire, fifo_batch, etc and with a start time <=3D @latest=
_start.
@@ -316,8 +329,6 @@ static struct request *__dd_dispatch_request(struct d=
eadline_data *dd,
 {
 	struct request *rq, *next_rq;
 	enum dd_data_dir data_dir;
-	enum dd_prio prio;
-	u8 ioprio_class;
=20
 	lockdep_assert_held(&dd->lock);
=20
@@ -411,12 +422,7 @@ static struct request *__dd_dispatch_request(struct =
deadline_data *dd,
 	dd->batching++;
 	deadline_move_request(dd, per_prio, rq);
 done:
-	ioprio_class =3D dd_rq_ioclass(rq);
-	prio =3D ioprio_class_to_prio[ioprio_class];
-	dd->per_prio[prio].latest_pos[data_dir] =3D blk_rq_pos(rq);
-	dd->per_prio[prio].stats.dispatched++;
-	rq->rq_flags |=3D RQF_STARTED;
-	return rq;
+	return dd_start_request(dd, data_dir, rq);
 }
=20
 /*
