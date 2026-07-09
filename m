Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BB54499AB
	for <linux-block@vger.kernel.org>; Thu,  9 Jul 2026 21:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783632977; cv=none; b=GnTQWtJMI8FBVI8J/kmHN4dKXjC8ZcTl6GFPk2QshMaih3PwGqCtJFhojf2W2ZzqT0IJVHZpof/FD7CC8GXTvVbsdp/oxI9xGhO4AUYwLHRO5OfD8gWCRORFbP0+C4jSvXG36LIGSgKPVtn8jQDJ4u9WN3YoMn5Q1DUboptOGzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783632977; c=relaxed/simple;
	bh=5L3dKF/TmRPqJsufq4j45uuwoxsmAMtI2jHoqn/hOsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rh2RvUD03VDTxWcGhXYDJzrK3IsHPJgiCt1E1XJb8or450fx5dH/0afLr94QFW2oMf7ZYzzofrE2y4wXXgcqDLzY2IRL6FDvxvc0XNZ4RKrSIom5HG3EYzGcXW4nYCFl9Q0Dfc1uT4IHGfpOSg6n6W39QrwRSQWkIKGoXjrEtqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=n5rCdvIP; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="n5rCdvIP"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4gx7Z73bjTzlhH0H;
	Thu,  9 Jul 2026 21:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1783632970; x=1786224971; bh=kZEw6
	lMVS5gosFZGv8v43mBasv9ZzQZSF99N7L1dNx8=; b=n5rCdvIPZGAZCLxnMLgTn
	rxI+Z/8uwA/t9kIHQN4wBmlpE+QOPSWOMUeETCC1BNx76DWGDyuijL2QZ61h5SdM
	xHVAtpBOVl+2GjFFjjmCMf7k7LhvGMt4PAy3J/BAIpfMQi0WzG8PutqG70lDcGyQ
	CpZwbC8Apik9vN6p2HTva/yBrQUPkx2tldBMLlBDlJTyCRDYrrwGu5mJDcw9y+SZ
	qXQNv/0V/nDxu/ytNriIuhqS7rPBd21nRtsg4TIA8/ZZwKZVA6qB46ZaL+eC55A7
	+bYwXXJS2qaKishh96qGHGyxLZqsKW0ZjS+ftRp7QLXSJGOgqYp/1Br+WjNC7aOj
	g==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id iD1jT_FHuDH2; Thu,  9 Jul 2026 21:36:10 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4gx7Z011XnzlhH09;
	Thu,  9 Jul 2026 21:36:07 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Marco Elver <elver@google.com>,
	=?UTF-8?q?Cc=20=3A=20Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Christoph Hellwig <hch@lst.de>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>
Subject: [PATCH 07/12] drbd: Pass 'resource' directly to complete_conflicting_writes()
Date: Thu,  9 Jul 2026 14:35:28 -0700
Message-ID: <b1132419aec70bb2cf9e1dd62ca09a6e3b9e6cdf.1783632330.git.bvanassche@acm.org>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
In-Reply-To: <cover.1783632330.git.bvanassche@acm.org>
References: <cover.1783632330.git.bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Prepare for adding lock context annotations. Without this change, an
__assume_ctx_lock() statement would have to be added.

Reviewed-by: Christoph Hellwig <hch@lst.de>
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
