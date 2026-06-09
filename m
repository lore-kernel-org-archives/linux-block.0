Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B1B24BD03
	for <linux-block@vger.kernel.org>; Tue,  9 Jun 2026 22:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781042795; cv=none; b=NISrV5ANmHnfQjaRPYrP03xi+LrirM2zsbx1p4XIG3zJHuDD0mt9m2sTiSp9HuGiC/tEYyj/Uj2cC6rWWBsU5pl+LQpa3rCSbQcVmLNBY6tRtqWsmEFDH+g8ozdcrVLexIR8Fmx/TAaNwKP4zREK6Kf+6wduVxfZTrYGv9cqgfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781042795; c=relaxed/simple;
	bh=VAmiPfMBha8jY2ICI0P2Z3zeZAbIVpWA3em5quyhdaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KUh4IkLH9gn20Wt04tW+Uh7oHSnQJvllccg6hc4gR7JEn3PiXMAZ0QqS4vYmwnKJt8C70rZsdxEKr/tUaGyXR5gZGQ/gNVPXLKRvNNGD/mc0gaeHZh8Hp0iDV/mjgoWc3TVqEmmSxUHyC5pcndOQqBWSgGUF14cqQ8vibwWeW34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=BIyKn1aG; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="BIyKn1aG"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4gZjfy2GsBzlgyH5;
	Tue,  9 Jun 2026 22:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1781042791; x=1783634792; bh=PtPDD
	X2KaS1GIIMoUuHnvFBc+1xFM/dVY11qi4dgzXs=; b=BIyKn1aGQlObf1bN0BbLQ
	1U4A+NIdUkFXxNwRO2GMHU7ZEwBQH+MRrBDxnqEIArJqGNYgvC1ejquLytFT/IBd
	iOJOR5Xj7qPonNvm8ipzhCHCrgHdkynzXMlvAxmgPS5bJ6Gb6LoS4BRVgJrWuPtx
	YA+uUaVDN4Lob+ii6RLaoPuPnwalo6P6HAqS8j1vRhaBh1WQ/dj/HSJaS5cgdKdP
	JSQkYqzkddZpZDyPyRMRaxdw4nSHwuZqs3L8FCUjfTNebw53860hfkaO0zO8mKjl
	wYThr2YLWnovJCKiJW8LBNLNPRVW2bqbNgi1bS6Y+SzpkvzSAT881Y2GYGqqAWtR
	w==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id ywLIPjKXGCeL; Tue,  9 Jun 2026 22:06:31 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4gZjfs6L8bzlffvQ;
	Tue,  9 Jun 2026 22:06:29 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Marco Elver <elver@google.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 18/27] loop: Add lock context annotations
Date: Tue,  9 Jun 2026 15:05:05 -0700
Message-ID: <1391f73ea3af981cd2e76b56cdfe47b5bb56ffa0.1781042470.git.bvanassche@acm.org>
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

Add lock context annotations that are compatible with Clang.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/loop.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 1a33536000e0..ff7eff102c5a 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
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
