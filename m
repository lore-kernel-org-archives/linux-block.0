Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9263CF69C
	for <linux-block@vger.kernel.org>; Thu, 20 Aug 2026 19:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787255881; cv=none; b=J+NFfXT8qqbdVnFDpMq6vhNFVGtns3o7zxYggfPdhGIYCJainncAE+qPn6lEYRURKJ673SFaCOmGgpqsNguYr7wpCATI5+44DoamcndCoB6lP7stPVTw4cySaBQR9qbH7JQAJNP63GrJHeAG7Y3Wu81MQrXN+Jn7f3QhCd8PoLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787255881; c=relaxed/simple;
	bh=1VU7jF4Zm9ODs/GTva1ekNSb6al4oZ7OOpX3Qjxd8TM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WlOKU4nKfzMnuct1vt2QDA6fq1KoquOrWzbhm3pmvWoTdSlV+wp4NT4jrgLeED144hOkxI52rnKw/vhjysGq3Ubuf3C8QCumezZOBbLCD5KtiCwNuxiDEKiZmeNq5uPFoVuYiWa16WUYIR2d8YCXI1eM/wJ5sNYeAaudhoGFaSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=J59K9/kG; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="J59K9/kG"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4hQvPL29HkzlfqKv;
	Thu, 20 Aug 2026 19:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1787255875; x=1789847876; bh=kIUv/
	X9sehDG3k9iOgecc/x08P0xF2lpE6zSXKTVAm8=; b=J59K9/kGwmzWX0pz1TJAW
	Dp8LNUR82AieeZOWcNxxTj8yVUhQRBP9Rfqt4cXv/YMZm+NW5LL//vta2hZIYGwt
	AgQ88tv7hH2HBFYxFRmBLrs6Vys82MevyoBrfA7+7ArSLzfV7YB0+YLzRKP7/Tvt
	VTcUNgsxRmtfkgs7mLrNPzl0eyFPw5MArwAi/JpTabzkB+rwL2wNUfbk0D27JGe3
	tfy3fYtEglnLWsFVgIQcaVz28TPdaAFpoQqc8gyXhgthS5dPlwtOCnixpbdb8/9B
	9EuZkinRn2kmjmuu8OO+Ugmv4JPO26TTXTxX512/vigtJvqlM83XZEnlxaHJVpPc
	w==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id o82AMX3yuQde; Thu, 20 Aug 2026 19:57:55 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (148.60.168.34.bc.googleusercontent.com [34.168.60.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4hQvPF5vJNzlfq9R;
	Thu, 20 Aug 2026 19:57:53 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 08/13] loop: Remove memory barriers
Date: Thu, 20 Aug 2026 12:57:16 -0700
Message-ID: <cf31f79daae5225f4f2a87680a7e7ae90616bdd9.1787255652.git.bvanassche@acm.org>
X-Mailer: git-send-email 2.55.0.766.g2966f0265a-goog
In-Reply-To: <cover.1787255652.git.bvanassche@acm.org>
References: <cover.1787255652.git.bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Now that all lo_state and lo_backing_file accesses from the control path
are serialized by lo_mutex, it is no longer necessary to use memory
barriers to order the lo_state and lo_backing_file accesses. Hence,
remove these memory barriers. While several lockless accesses of these
two member variables remain in the I/O path, these are serialized with
backing file changes by freezing the request queue. See also
loop_change_fd().

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/loop.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 8b633ea6e72f..93b589bc6e3d 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -515,11 +515,6 @@ static struct file *loop_get_backing_file(struct loo=
p_device *lo)
 {
 	if (lo->lo_state !=3D Lo_bound)
 		return NULL;
-	/*
-	 * Order wrt setting lo->lo_backing_file in
-	 * loop_configure().
-	 */
-	rmb();
 	return get_file(lo->lo_backing_file);
 }
=20
@@ -1149,9 +1144,6 @@ static int loop_configure(struct loop_device *lo, b=
lk_mode_t mode,
 	size =3D lo_calculate_size(lo, file);
 	loop_set_size(lo, size);
=20
-	/* Order wrt reading lo_state in loop_validate_file(). */
-	wmb();
-
 	WRITE_ONCE(lo->lo_state, Lo_bound);
 	if (part_shift)
 		lo->lo_flags |=3D LO_FLAGS_PARTSCAN;
