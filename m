Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF951A5B85
	for <linux-block@vger.kernel.org>; Tue, 17 Jun 2025 20:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750193833; cv=none; b=VIvatpCc2+eiMlQv1yTHAKew96Nu4rSDiZFMobHovwMDO2X1GtCAYL4jTag554BOBEw6wBRGEe0gJMguJldm1q6DUH3EObWVmLyD48PvriTSH0W+9OTQFu2rv3IqJu1ilxKBISV1N7Ch1u50KWzI90Poa8sSfz4PkejyADrm2uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750193833; c=relaxed/simple;
	bh=q1WReagZnzvzLf0u6KtZw3grzUy2y3+mQ1XcaFzMDek=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=t3A440ub5tnCz82z6rAeT0TQBZ49ZuR2FmJQZdRYGHmb3X7R1nm3A3xIXWSvtBWrZl/UFXpInBLIz4lKDpGwmC6k2+oDGQXp36FcUPHKo3ryRmU1cqwwo/MP7mOBK1wXoew0EHYTj5objQ6W7AmNvueNtc+2AwVLvYh0xQsV2YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=elijahs.space; spf=pass smtp.mailfrom=elijahs.space; dkim=pass (2048-bit key) header.d=elijahs.space header.i=@elijahs.space header.b=LH5qRhZx; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=F88z+jGS; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=elijahs.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=elijahs.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=elijahs.space header.i=@elijahs.space header.b="LH5qRhZx";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="F88z+jGS"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=LH5qRhZxffljidtb1scdSsxoXb6j6IxM3yZFgue5zSfUnJMaTQYy2rDQK3DD//aHydzxHrHNIPGXoT30EfvT8Q213mjUcQm4Es7WYtOU8qLqHidmh7+JpicH4jsKrhCOhiTAe3xhXHdgIKDZwWZRdhMaq0OGyINDkONggwtC2MFWqHt1QiwwfGtWdmApIBABqRZ8by1x3dO2fUBbW0Uq3OLOsl3zsNBX+zcg9BpQxMdEEc8zSh7jutggi3b2nkeipRUi8W4u8MclCndr7naiI+gm7H6YO9W4Je/y8fqxO7LBlDodm5dL18Yl0r0gzZWPrYxndJlykUQclmrS7ozKeQ==; s=purelymail3; d=elijahs.space; v=1; bh=q1WReagZnzvzLf0u6KtZw3grzUy2y3+mQ1XcaFzMDek=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=F88z+jGSZt41JguVZDcGK3vhgYapyYSJW0thN3+gjrhhr5FqHELWNoX52HA7+cAu/d8wJ3zwWr/KgkbjhPGeKt2eqLWwy3fthnoi6KxxLDoghZWmiF0d5lpRwhSwgcieFJWgsPHZdBGkSgVKP4+5vc/yditfjCX3s3Z6zuRFYLfF/l2ZxEvR8k3Cmam3M+Sen9Ws/Rn79qMiE8+fTL7VCkrfEcxMaM/nDt2cKZDFWu7tlgqEGNfvOTHre1ISN4j97hjzrnkU871MuxE7SpZVcxrXb/NrnchR8866QHSiByKdfIDxfU9Gllls5BwYbDrsKzm+fMnFM2ZHhdVP6A8jMA==; s=purelymail3; d=purelymail.com; v=1; bh=q1WReagZnzvzLf0u6KtZw3grzUy2y3+mQ1XcaFzMDek=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 147366:4866:null:purelymail
X-Pm-Original-To: linux-block@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1931553863;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Tue, 17 Jun 2025 20:56:58 +0000 (UTC)
From: Elijah Wright <git@elijahs.space>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Elijah Wright <git@elijahs.space>
Subject: [PATCH] block: mq-deadline: check if elevator is attached to queue in dd_finish_request
Date: Tue, 17 Jun 2025 13:56:08 -0700
Message-ID: <20250617205630.207696-1-git@elijahs.space>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

in dd_finish_request(), per_prio points to a rq->elv.priv[0], which could b=
e
free memory if an in-flight requests completes after its associated schedul=
er
has been freed

Signed-off-by: Elijah Wright <git@elijahs.space>
---
 block/mq-deadline.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 2edf1cac06d5..4d7b21b144d3 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -751,13 +751,15 @@ static void dd_finish_request(struct request *rq)
 {
 =09struct dd_per_prio *per_prio =3D rq->elv.priv[0];
=20
-=09/*
-=09 * The block layer core may call dd_finish_request() without having
-=09 * called dd_insert_requests(). Skip requests that bypassed I/O
-=09 * scheduling. See also blk_mq_request_bypass_insert().
-=09 */
-=09if (per_prio)
-=09=09atomic_inc(&per_prio->stats.completed);
+=09if (rq->q->elevator) {
+=09=09/*
+=09=09* The block layer core may call dd_finish_request() without having
+=09=09* called dd_insert_requests(). Skip requests that bypassed I/O
+=09=09* scheduling. See also blk_mq_request_bypass_insert().
+=09=09*/
+=09=09if (per_prio)
+=09=09=09atomic_inc(&per_prio->stats.completed);
+=09}
 }
=20
 static bool dd_has_work_for_prio(struct dd_per_prio *per_prio)
--=20
2.43.0

