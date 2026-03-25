Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B772777EA
	for <linux-block@vger.kernel.org>; Wed, 25 Mar 2026 21:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774475177; cv=none; b=Y8rBSLOtet/a7Rj0oMpyX84VLIy7/cpfxHDoPV1CsBUGg4R57+tI6xmCQhxH6YOG6kklRn6KkwlSjDcHxEW2dNxuY3htOVqfA8A2ZqtMBJLW04TuAXMD6XaL4kLr0ozdedoGioDLXYLDuh4BDjBdBsIKpTs9kqspYnMQgOmFAXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774475177; c=relaxed/simple;
	bh=DAwvUzQ7UlEmekdmAlmslSqSVJyEjQuekjmbWaO6JpA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oTTkkdckBjRnOaI8yepPNN+tR3SqNyrmVnE8QTxyfwaJ03AXAYumtJsrs6H9prmKa6ntdDrMHjoC/VCvE9VJV75B50nY/l8Icuic9Pzh/tFWNWvZDS0XnyAaL7LZOYvMMmtmj19TQUsP8Nt+uVYOlrUJ5o1NV9ciwwjUGO0BibA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=kUZcmaBs; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="kUZcmaBs"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fh0pc2kMvzlgy4t;
	Wed, 25 Mar 2026 21:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1774475171; x=1777067172; bh=mz2if
	at5GyRQbLPcvs1/9fO2GlW2QifsKN7hhG3x7kY=; b=kUZcmaBsJEEZ1MAOzEENv
	eHIKepzKdDoe+4/eF6KcoEuxTuNTbQ5Pc7GTDlbZD/Q3djUzgrQT/n+c5UcpHTm7
	FQn5CTJCY603hBj1/aBHyqHIifINXb0H9znVeXRA0G/hNJB4hSuDYTyOmJA+q399
	MckpJGOnlZbslDiFaM5eX1ucUg9DGZx8wFa5i2lF4mRss+/K0SPiEi8HX/X4Fzqm
	AQS27FHwP1kL9nGw2jYFkVNhEB6KgyKCqIs8Bvh/2kJiIY989DhuJL1K7E6Z5Nay
	DKg7OqcYsNxM4mNoV1ZI8CDIVKRwao6eVtoxNEAjKNkO29rTsCAZdxkqMjMXFrf3
	Q==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 4I8CFBTdLTTK; Wed, 25 Mar 2026 21:46:11 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fh0pT6XDfzlgwN4;
	Wed, 25 Mar 2026 21:46:09 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH v2 17/26] loop: Add lock context annotations
Date: Wed, 25 Mar 2026 14:44:58 -0700
Message-ID: <20260325214518.2854494-18-bvanassche@acm.org>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
In-Reply-To: <20260325214518.2854494-1-bvanassche@acm.org>
References: <20260325214518.2854494-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add lock context annotations that are compatible with Clang and enable
lock context analysis.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/loop.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 0000913f7efc..9c7ed9e8a442 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -107,6 +107,8 @@ static DEFINE_MUTEX(loop_validate_mutex);
  * loop_configure()/loop_change_fd()/__loop_clr_fd() calls.
  */
 static int loop_global_lock_killable(struct loop_device *lo, bool global=
)
+	__cond_acquires(0, &lo->lo_mutex)
+	__no_context_analysis /* conditional locking */
 {
 	int err;
=20
@@ -128,6 +130,8 @@ static int loop_global_lock_killable(struct loop_devi=
ce *lo, bool global)
  * @global: true if @lo was about to bind another "struct loop_device", =
false otherwise
  */
 static void loop_global_unlock(struct loop_device *lo, bool global)
+	__releases(&lo->lo_mutex)
+	__no_context_analysis /* conditional locking */
 {
 	mutex_unlock(&lo->lo_mutex);
 	if (global)
