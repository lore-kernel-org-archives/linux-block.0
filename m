Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CC03C9438
	for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 19:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785441554; cv=none; b=Xq3pWF2hvnhtMFV2fQswOsvJr1tJGD2AcaV3fiILrHPNGN/LJ7EQzHitPa6xX1Mj2pvRbNnv8gUCHig2sSKYTzLSKSlioFSVkUClsKpll4mMN6PCA5i3DzMXx7lgNk89BU5L5lwX0/kNd7ZERrXbqQvOzSg7Bri5DVGZs0og0Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785441554; c=relaxed/simple;
	bh=edXLFNddh7Z1cOaHMha7hFR4QLGaTZEiTOcJktMwvH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QAwP3Y1Ef9Vky0DUNm00aWpuAaPwfBZgV/hkmMKUZ10l29uipYu5AAumaCUi2YPr+hWgHzrzBfxh+fyfYOb9kTXcjgEiRKsBK2hQk8X/71ZwTUNy8lfpCDv95ae/Zy+tmsa4A+Ct4LopHiWt9iFPXEgMFa3OoyrA+52CHGkGiAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=gphXxjMV; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="gphXxjMV"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4hB0QQ0G4wzlfpM0;
	Thu, 30 Jul 2026 19:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1785441545; x=1788033546; bh=T58U0
	VTcUukG9BdIHThdNqUv1rDoISDJ0DirF6kan8s=; b=gphXxjMVs4DHaC7CZh75M
	fIu0hCBoWEcK3Wvez1Lqn2VQXLPdbzE7fs7ikZIDS37deNvVXCJRjMWaeHvWob1a
	/VwbPc8Wq7tIayIRlOoY7J8aC7fa2KalDuE8y4zX5QVyIwKoHFhXDOW6OQPAhwrd
	bPHeAV5i4182pSEDu4SMYU36YivgM3GOFrw6X9WM08ZbALY+4DGqZMAZPf1oIqZw
	4cuLaeQqYX/D/PDqVP+J+24PTjUrsIORuoycAAzoVW9qtGy7YqCkRNezwu3bCOrK
	qR2Kkzx/MDo0z0vXg6OopN9fHKi0DQd8eMHgE6wb+43hqdwBOXEfUBnyLWa9XW3z
	A==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 3nHOmm3cGC_G; Thu, 30 Jul 2026 19:59:05 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4hB0QH4K55zlfvps;
	Thu, 30 Jul 2026 19:59:03 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Marco Elver <elver@google.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH v2 03/12] loop: Add lock context annotations
Date: Thu, 30 Jul 2026 12:58:26 -0700
Message-ID: <db7c5b870df403fe97229f6bb59144122e16aa41.1785440858.git.bvanassche@acm.org>
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

Add lock context annotations that are compatible with Clang. Swap the
loop_ctl_mutex and loop_index_idr declarations such that __guarded_by()
can be used.

Cc: Nilay Shroff <nilay@linux.ibm.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/loop.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index a71fe763c933..e2ac19de11f4 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -90,8 +90,8 @@ struct loop_cmd {
 #define LOOP_IDLE_WORKER_TIMEOUT (60 * HZ)
 #define LOOP_DEFAULT_HW_Q_DEPTH 128
=20
-static DEFINE_IDR(loop_index_idr);
 static DEFINE_MUTEX(loop_ctl_mutex);
+static __guarded_by(&loop_ctl_mutex) DEFINE_IDR(loop_index_idr);
 static DEFINE_MUTEX(loop_validate_mutex);
=20
 /**
@@ -106,6 +106,8 @@ static DEFINE_MUTEX(loop_validate_mutex);
  * loop_configure()/loop_change_fd()/__loop_clr_fd() calls.
  */
 static int loop_global_lock_killable(struct loop_device *lo)
+	__cond_acquires(0, &loop_validate_mutex)
+	__cond_acquires(0, &lo->lo_mutex)
 {
 	int err;
=20
@@ -124,6 +126,8 @@ static int loop_global_lock_killable(struct loop_devi=
ce *lo)
  * @lo: struct loop_device
  */
 static void loop_global_unlock(struct loop_device *lo)
+	__releases(&lo->lo_mutex)
+	__releases(&loop_validate_mutex)
 {
 	mutex_unlock(&lo->lo_mutex);
 	mutex_unlock(&loop_validate_mutex);
@@ -2329,6 +2333,7 @@ static void __exit loop_exit(void)
 	 * module unloading is requested). If this is not a clean unloading,
 	 * we have no means to avoid kernel crash.
 	 */
+	__assume_ctx_lock(&loop_ctl_mutex);
 	idr_for_each_entry(&loop_index_idr, lo, id)
 		loop_remove(lo);
=20
