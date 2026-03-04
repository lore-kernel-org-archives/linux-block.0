Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0134386448
	for <linux-block@vger.kernel.org>; Wed,  4 Mar 2026 19:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772653762; cv=none; b=BJzzM5M36TfH3ZyiNf5ni6d+EQOR1XduTm30CBvgoARNt4WZ5ReoKZEIPJ7nA7pd8VwQmSzHwY+vz6LpX/kv16uZ0QX9rS2YUSdDabLG6UXm5pUav/EVnuYfesYPsNQO4AJK0wjsQ6S9DMM5QIMdQGQCmetgkI/RvBtnArD2hPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772653762; c=relaxed/simple;
	bh=nWUsPqEz64DRxRs4stKE7KIOmuHx0LOPxKQEjZyS+jU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qeY9OCdRRA34eigC1qhGWI99sgce9vakAMNial6ZnhHZXLUAGidolz6v7sI6/Z9ia69HBpxL6u5fmy1y+VbTH6ozeclWHAnN/Zg0wecH1Snud3VYr6jbhoycRCFh69NIP10ccNfd2N7F//FGlr+pTBAwRp4W6db/fkaXp30Iby0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=B+Om/pWI; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="B+Om/pWI"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4fR3CP3NpZz1XM0p0;
	Wed,  4 Mar 2026 19:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1772653757; x=1775245758; bh=KCtAi
	2+JuLPtiSpcUSdnD8CARriGYij4GJ/FCeNg6Zs=; b=B+Om/pWIJZSntWNERidj8
	pHbiZoLHJduN3TdcgPBocxLuUgRb/TwH8joB9VwA8lRO2iOHt4ev5lVYLS8ZlLSJ
	eMl87t/xMhiZY5M2e7TbcPZv+gpdxjRFmqO10V9i1kRZ6Lh+z4TF5MF7YxrSCd6I
	QglzOvwGG4UiEpUwn9wsGuZVhCkrjPtH7XcxurC4UU1NzMnKLtcS6qD/ZUGvSBjv
	CpmhWQx/B/4y1NPsyKQYAdZpFXNxLk+9RFIfIp1d0IU1NhMztOAK9yg0gt3BhJyJ
	umze/Jb/01WIetjhyIEho75+dt6cghVAb7kMGmB80juuO4vP+SMU8fAi4Rvf2uY3
	w==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 4ry8cYWoseC5; Wed,  4 Mar 2026 19:49:17 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4fR3CJ1cCyz1XM6JV;
	Wed,  4 Mar 2026 19:49:15 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Marco Elver <elver@google.com>,
	linux-block@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 06/14] loop: Add lock context annotations
Date: Wed,  4 Mar 2026 11:48:25 -0800
Message-ID: <20260304194843.760669-7-bvanassche@acm.org>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
In-Reply-To: <20260304194843.760669-1-bvanassche@acm.org>
References: <20260304194843.760669-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Prepare for enabling lock context analysis by adding lock context
annotations that are compatible with Clang.

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
