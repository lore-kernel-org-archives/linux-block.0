Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FB83E5EF2
	for <linux-block@vger.kernel.org>; Thu,  2 Apr 2026 18:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775155216; cv=none; b=QQXwzFWbLeJ3pA7IIZYCr8r7vnYHN8bT21juKB4qz7BTmy0fUepx6fTrzXLWS6oOHm6imBvT7kHsP+M3CTwnAtQw/+O5Im3+7Hp1MnCdfOThvgcvL4sloC7YhDSbHmRKaLa/+/JVy9nL/ArFL/SCrha6O1T9en/mfR0debPayAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775155216; c=relaxed/simple;
	bh=pkHqY61zfZJ3Rf5JtvRRnnbK6U1qaesfcXhSm0FvHaU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y3lQCsjkln9TeKlYduCnbmMnW4s66BHNgrOLXj/HRSiUPR5NpcbROyZjQrIEzhlBhvDNur1ded6RngjEs5ygJsRbcJG59J2nYYcjST3IsMmOdlfA+sK06MmUw9dgrE1PwhqnHyeXiqBU4aQXXLcYOC1ChsX0xPL/5qV0wkpEg54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=1oj1uU8i; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="1oj1uU8i"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fmrJF0hnrzlh2g0;
	Thu,  2 Apr 2026 18:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1775155208; x=1777747209; bh=XVdgj
	XdsC5omZHxzDKE2ttP8Dw62qqz3JQgH+qKx2bA=; b=1oj1uU8i0maOFYMl23lxa
	vanS+kTo27abbFaja0YAGSv4WkTG3v3SbyWQMP3jTBd2mfXOx/jgzODJOZiD17QT
	eMJpCbXjyDApcBvAKavPc4SD2E69+v0QdrkF7b+Gxs9XW2rIWP8ImGnUwF3Cmjne
	MpS7M8k8PeDgv3A3M8MRLZQ2GSYl1bk05uefbPEKSZ42NR7NBQV9vrDJNks4eoOx
	EIXh/EGdH5Wruk+vEHRox1itEKlAmYnWy6AzZV0BM+EwJEgjPqq/wvJERa0YRtKE
	mBUR0OnhKi5OOCfAgRKFnt6aI5ey0odz0/0Jeshh5Ns2XHiJr/ETeA3r2l2OB7qs
	Q==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id f7rxtfxtOYhB; Thu,  2 Apr 2026 18:40:08 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fmrJ628f7zlfwHS;
	Thu,  2 Apr 2026 18:40:05 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Marco Elver <elver@google.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH v3 02/12] block/bdev: Annotate the blk_holder_ops callback invocations
Date: Thu,  2 Apr 2026 11:39:34 -0700
Message-ID: <20260402183950.3626956-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
In-Reply-To: <20260402183950.3626956-1-bvanassche@acm.org>
References: <20260402183950.3626956-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The four callback functions in blk_holder_ops all release the
bd_holder_lock. Add __release() annotations where appropriate to prepare
for enabling thread-safety analysis. Explicit __release() annotations hav=
e
been added since Clang does not support adding a __releases() annotation
to a function pointer.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/bdev.c  | 10 ++++++++--
 block/ioctl.c |  6 ++++--
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index ed022f8c48c7..bab8f23ec7ec 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -312,7 +312,9 @@ int bdev_freeze(struct block_device *bdev)
 	mutex_lock(&bdev->bd_holder_lock);
 	if (bdev->bd_holder_ops && bdev->bd_holder_ops->freeze) {
 		error =3D bdev->bd_holder_ops->freeze(bdev);
+		/* bdev->bd_holder_ops->freeze() releases bd_holder_lock */
 		lockdep_assert_not_held(&bdev->bd_holder_lock);
+		__release(&bdev->bd_holder_lock);
 	} else {
 		mutex_unlock(&bdev->bd_holder_lock);
 		error =3D sync_blockdev(bdev);
@@ -355,7 +357,9 @@ int bdev_thaw(struct block_device *bdev)
 	mutex_lock(&bdev->bd_holder_lock);
 	if (bdev->bd_holder_ops && bdev->bd_holder_ops->thaw) {
 		error =3D bdev->bd_holder_ops->thaw(bdev);
+		/* bdev->bd_holder_ops->thaw() releases bd_holder_lock */
 		lockdep_assert_not_held(&bdev->bd_holder_lock);
+		__release(&bdev->bd_holder_lock);
 	} else {
 		mutex_unlock(&bdev->bd_holder_lock);
 	}
@@ -1254,9 +1258,11 @@ EXPORT_SYMBOL(lookup_bdev);
 void bdev_mark_dead(struct block_device *bdev, bool surprise)
 {
 	mutex_lock(&bdev->bd_holder_lock);
-	if (bdev->bd_holder_ops && bdev->bd_holder_ops->mark_dead)
+	if (bdev->bd_holder_ops && bdev->bd_holder_ops->mark_dead) {
 		bdev->bd_holder_ops->mark_dead(bdev, surprise);
-	else {
+		/* bdev->bd_holder_ops->mark_dead() releases bd_holder_lock */
+		__release(&bdev->bd_holder_lock);
+	} else {
 		mutex_unlock(&bdev->bd_holder_lock);
 		sync_blockdev(bdev);
 	}
diff --git a/block/ioctl.c b/block/ioctl.c
index 0b04661ac809..57c69ef0f2cd 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -523,9 +523,11 @@ static int blkdev_flushbuf(struct block_device *bdev=
, unsigned cmd,
 		return -EACCES;
=20
 	mutex_lock(&bdev->bd_holder_lock);
-	if (bdev->bd_holder_ops && bdev->bd_holder_ops->sync)
+	if (bdev->bd_holder_ops && bdev->bd_holder_ops->sync) {
 		bdev->bd_holder_ops->sync(bdev);
-	else {
+		/* bdev->bd_holder_ops->sync() releases bd_holder_lock */
+		__release(&bdev->bd_holder_lock);
+	} else {
 		mutex_unlock(&bdev->bd_holder_lock);
 		sync_blockdev(bdev);
 	}
