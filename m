Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EC124BD03
	for <linux-block@vger.kernel.org>; Tue,  9 Jun 2026 22:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781042770; cv=none; b=lEA07dR49DvBFtTNS2X2Q9zIpykf/ESG9GtokFSoxe20n8iBm7mhZgJpwJg44jQEn1bgbwRTo86DGl4ewk0QJiTyz97pzFaDMlMnYRO2IiQca97+RtcdRjCP88MaERJ0K5qrgPTVuZc6Uz+671I7T6L+KatpD/r6nqh3nl6dYKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781042770; c=relaxed/simple;
	bh=j79kH4ej/bjgHlxsoS37pqtsd+3O0lP4j4HZi8igiZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cZgE0c5GTMRudzI2Y9gYhxRFN0wYDNr8ODPvqOsFMno237jixBtvm5TO2TCCpZCO175DxXiUXiES9YjuVZwKw4629jWEr+WVWEUBRADVJ5594NNIXRDgJJFYoq2Lht/U1ieYMqEcVUIeOWRlK49o0BrUhzYuNceozbIGCeKVr1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=R+Wb5s7O; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="R+Wb5s7O"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4gZjfR25qPzlfpM6;
	Tue,  9 Jun 2026 22:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1781042762; x=1783634763; bh=u2PAB
	naU8uFof3UFLFeEPg7B4yQuUn5v5fb1aHJm2UA=; b=R+Wb5s7Od5xaimtxRrP/P
	cV60Hyi4JbPoV7SBlrBNaVRi32Yqk4jA3HEt9rViKAfqh01HEpymRwqvN37s0RFO
	KbvV/2ExwPe9/YgwPz8WUcfWAhC6xfOj2D1sv+HhVpCSXC8C6G/A93qg5jhbkrD8
	3zMezysy6ESPMqxlOtXlUh7QsyA+E5LvbPwqyQvygCelDD9vMoK7RMUCdKRwVd+G
	hI/iBS92c/nj2MDbDzqZhviBYXJiMNBFD0e1I6GfrrgklQYCkD896x7hZE4ZgDWf
	otF1GllNuOf6WDBv0kK03U9Btt+sJpdQ3ak67M9xinEFmQ3UKLZ+RL7dFmtRqNeZ
	Q==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id ngZARG8Brt8K; Tue,  9 Jun 2026 22:06:02 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4gZjfH0QcnzlgwNB;
	Tue,  9 Jun 2026 22:05:58 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Marco Elver <elver@google.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Subject: [PATCH 08/27] drbd: Pass 'resource' directly to complete_conflicting_writes()
Date: Tue,  9 Jun 2026 15:04:55 -0700
Message-ID: <77d0fd75811d7f604fa80b5c93172b5653b52880.1781042470.git.bvanassche@acm.org>
X-Mailer: git-send-email 2.54.0.1099.g489fc7bff1-goog
In-Reply-To: <cover.1781042470.git.bvanassche@acm.org>
References: <cover.1781042470.git.bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Prepare for adding lock context annotations. Without this change, an
__assume_ctx_lock() statement would have to be added.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/drbd/drbd_req.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.=
c
index 70f75ef07945..a851e43c94a8 100644
--- a/drivers/block/drbd/drbd_req.c
+++ b/drivers/block/drbd/drbd_req.c
@@ -951,7 +951,8 @@ static bool remote_due_to_read_balancing(struct drbd_=
device *device, sector_t se
  *
  * Only way out: remove the conflicting intervals from the tree.
  */
-static void complete_conflicting_writes(struct drbd_request *req)
+static void complete_conflicting_writes(struct drbd_resource *resource,
+					struct drbd_request *req)
 {
 	DEFINE_WAIT(wait);
 	struct drbd_device *device =3D req->device;
@@ -974,9 +975,9 @@ static void complete_conflicting_writes(struct drbd_r=
equest *req)
 		/* Indicate to wake up device->misc_wait on progress.  */
 		prepare_to_wait(&device->misc_wait, &wait, TASK_UNINTERRUPTIBLE);
 		i->waiting =3D true;
-		spin_unlock_irq(&device->resource->req_lock);
+		spin_unlock_irq(&resource->req_lock);
 		schedule();
-		spin_lock_irq(&device->resource->req_lock);
+		spin_lock_irq(&resource->req_lock);
 	}
 	finish_wait(&device->misc_wait, &wait);
 }
@@ -1329,7 +1330,7 @@ static void drbd_send_and_submit(struct drbd_device=
 *device, struct drbd_request
 		/* This may temporarily give up the req_lock,
 		 * but will re-aquire it before it returns here.
 		 * Needs to be before the check on drbd_suspended() */
-		complete_conflicting_writes(req);
+		complete_conflicting_writes(resource, req);
 		/* no more giving up req_lock from now on! */
=20
 		/* check for congestion, and potentially stop sending
