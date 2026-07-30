Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AAB23CB2DA
	for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 19:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785441574; cv=none; b=K2ZYa6FUiEw2+yrepogk9r6IdAvY2m7hG+JwTWSQRXEqQ25yEPysNsOBzfj8jmrydL4WDq24E4z52OEV0/pn3CxCk5fk765zYlmAiEXnGOBZ/vMQx06CIg/SPjMmXQ2mxujIKRjT+RJRXQhscQd/jIR7VxJ8KfKUxWB6MA+Ci4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785441574; c=relaxed/simple;
	bh=z4QSGc++7j3AhUlUlzvfZDLJ2q3hKJ/c4wCO7whSUww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L4Jlz0u/Uxc1Pawq/GdkxmE+bZPYrPV9xSBKd60v/k49VvL5HGmvHrPp3dqOps+bab9e1oncqj3OPyywE3EpNQiZffvqbg6+K5hMKbjpnnt4W8SiSpxpaHzgYELqUke/2N+00jmZuVy6bBMz2IoicfGI5sPsnZxjAScbwqhRnes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=F7HGiGMl; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="F7HGiGMl"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4hB0Qm5mhszlfpLv;
	Thu, 30 Jul 2026 19:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1785441564; x=1788033565; bh=M56w1
	h55GyrosYwP96n0SZm7/6/0sWsNAUhzno40MlM=; b=F7HGiGMlVWa8C19IQEhKY
	EYriise8qvD11+Yo1adhvmd13JzfDOyxBEzGfRRWxYFT02ZAvV/N2pajOmVbhQxU
	lULzUwqy52lQUnG/kIv7WaE7egSGX+0jiHDUwKLBobhHSvMdjXSBX0uxhIMRALAh
	P63BMLtkoy8kecIiJMARabmj+D8yKJOqVMe/DUNCiyhybXQRxThSvn75k/VVXKq4
	VJOC99lLfTMIY/knkUC3n64soyU1+lGNKOy3yvQFc7rQmw5LKHwyoMErSZK08meb
	cmFg4ExVy+akAW0ioFWj/SH7m2UKUzPC9NkJDZZyBk6gcwxG+wWvrCCGQJyT9dEb
	Q==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id H3eC9maw04sX; Thu, 30 Jul 2026 19:59:24 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4hB0Qf1qMbzlfpLs;
	Thu, 30 Jul 2026 19:59:21 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Marco Elver <elver@google.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH v2 07/12] rbd: Enable lock context analysis
Date: Thu, 30 Jul 2026 12:58:30 -0700
Message-ID: <0b2988ca05e8a2733352a447e0810104b878376a.1785440858.git.bvanassche@acm.org>
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
In-Reply-To: <cover.1785440858.git.bvanassche@acm.org>
References: <cover.1785440858.git.bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add lock context annotations.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/rbd.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 1f1c2810f6ee..f0f7a94e3e3e 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -4183,6 +4183,7 @@ static void rbd_acquire_lock(struct work_struct *wo=
rk)
 }
=20
 static bool rbd_quiesce_lock(struct rbd_device *rbd_dev)
+	__must_hold(&rbd_dev->lock_rwsem)
 {
 	dout("%s rbd_dev %p\n", __func__, rbd_dev);
 	lockdep_assert_held_write(&rbd_dev->lock_rwsem);
@@ -4227,6 +4228,7 @@ static void __rbd_release_lock(struct rbd_device *r=
bd_dev)
  * lock_rwsem must be held for write
  */
 static void rbd_release_lock(struct rbd_device *rbd_dev)
+	__must_hold(&rbd_dev->lock_rwsem)
 {
 	if (!rbd_quiesce_lock(rbd_dev))
 		return;
@@ -4583,6 +4585,7 @@ static void rbd_unregister_watch(struct rbd_device =
*rbd_dev)
  * lock_rwsem must be held for write
  */
 static void rbd_reacquire_lock(struct rbd_device *rbd_dev)
+	__must_hold(&rbd_dev->lock_rwsem)
 {
 	struct ceph_osd_client *osdc =3D &rbd_dev->rbd_client->client->osdc;
 	char cookie[32];
@@ -6780,6 +6783,7 @@ static void rbd_dev_device_release(struct rbd_devic=
e *rbd_dev)
  * upon return.
  */
 static int rbd_dev_device_setup(struct rbd_device *rbd_dev)
+	__releases(&rbd_dev->header_rwsem)
 {
 	int ret;
=20
@@ -6881,6 +6885,7 @@ static void rbd_dev_image_release(struct rbd_device=
 *rbd_dev)
  * with @depth =3D=3D 0.
  */
 static int rbd_dev_image_probe(struct rbd_device *rbd_dev, int depth)
+	__context_unsafe(conditional locking on @depth)
 {
 	bool need_watch =3D !rbd_is_ro(rbd_dev);
 	int ret;
@@ -7134,6 +7139,9 @@ static ssize_t do_rbd_add(const char *buf, size_t c=
ount)
 	if (rc < 0)
 		goto err_out_rbd_dev;
=20
+	/* Acquired by rbd_dev_image_probe(rbd_dev, 0) */
+	__acquire(&rbd_dev->header_rwsem);
+
 	if (rbd_dev->opts->alloc_size > rbd_dev->layout.object_size) {
 		rbd_warn(rbd_dev, "alloc_size adjusted to %u",
 			 rbd_dev->layout.object_size);
