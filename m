Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F7343D4EF
	for <linux-block@vger.kernel.org>; Thu, 20 Aug 2026 19:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787255868; cv=none; b=pebZigsXIbhreSKFeN7hpOcKciViwjvLjeFtmCE+47OKHyFfx1W7hU08lp4U8vC/bGAGKn7aJzJ0sUMorKoT3rl7TQCqNCqMB87fUbI7rxV6UG/YMzi+Jb1t+bruYsnNN1DRtIev5abZXAvqh4a9dE/qSfsxF4GZxT2FAmpGkDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787255868; c=relaxed/simple;
	bh=k22t4HyGv7Y0QTOBoGbvJsFfowel+Ip+nQiiicoYSto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KQmKggzy/vtWfuh7Irffvtl4q0fEijbnlHLCj9H/qjGsCSo9r18txihuBO+Tof7GXBp5VxOTnwpmIy0D5Y85dO9cMRP9V9JEaNJ8vhOx5FKgB/fViREDPg6aPi7DwHasGuSQjmskL3xLk80ax52zp+ntqDinfon0Rmln/kQObNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=UBcwmKP0; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="UBcwmKP0"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4hQvP66Cy2zlfqKv;
	Thu, 20 Aug 2026 19:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1787255864; x=1789847865; bh=apggF
	76676OAviaPLmuIH5QtfZlflZXSwq1sIHpoaBg=; b=UBcwmKP0L+wLaCCjuG0G8
	T0N/P1dTp2ziho1kgMSdBNfbO4quZg1i6e8lGBONaA2ShmdfXn83sqk+CrZbw1/x
	JE1jwhUVWphRZax2e+evXaApU1LyuqyY0VFQN68b9USBgEXEKfkuNaFiFxC4Matd
	0hvJk9rjMm59bTIjjA/a4yXKbvCM+K08zyCn53NcwhTYih7zsZj8ZMFWf5mZTa0g
	VlZxz7xtg4Hdm+TEYmUfOxIxqpGfIkqN1Uc0j52WqZMiSD5Ikv64e9G4x6IaGUCv
	skwi9zwRGPf8hCnF06MNWUnW+uEn8IS9LjJ5fVzyrbW24FzZ5VNNStf5aYRLb52I
	g==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id KcMCVrTrdczL; Thu, 20 Aug 2026 19:57:44 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (148.60.168.34.bc.googleusercontent.com [34.168.60.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4hQvP24N1fzlfq9P;
	Thu, 20 Aug 2026 19:57:42 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 03/13] loop: Enable context analysis
Date: Thu, 20 Aug 2026 12:57:11 -0700
Message-ID: <2a09e1f8b942fe7e94ce256219dccd4475710167.1787255652.git.bvanassche@acm.org>
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

Let the compiler verify __must_hold(), __guarded_by() etc. Suppress the
warnings reported for loop_global_{,un}_lock*() by adding a
__context_unsafe() annotation. Both __context_unsafe() annotations will b=
e
removed by a later patch.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/Makefile | 2 ++
 drivers/block/loop.c   | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/drivers/block/Makefile b/drivers/block/Makefile
index 2d8096eb8cdf..d4555949cc3c 100644
--- a/drivers/block/Makefile
+++ b/drivers/block/Makefile
@@ -6,6 +6,8 @@
 # Rewritten to use lists instead of if-statements.
 #=20
=20
+CONTEXT_ANALYSIS_loop.o :=3D y
+
 # needed for trace events
 ccflags-y				+=3D -I$(src)
=20
diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 4315c36d4042..638d97293a79 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -108,6 +108,8 @@ static DEFINE_MUTEX(loop_validate_mutex);
  * loop_configure()/loop_change_fd()/__loop_clr_fd() calls.
  */
 static int loop_global_lock_killable(struct loop_device *lo, bool global=
)
+	__cond_acquires(0, &lo->lo_mutex)
+	__context_unsafe(conditional locking)
 {
 	int err;
=20
@@ -129,6 +131,8 @@ static int loop_global_lock_killable(struct loop_devi=
ce *lo, bool global)
  * @global: true if @lo was about to bind another "struct loop_device", =
false otherwise
  */
 static void loop_global_unlock(struct loop_device *lo, bool global)
+	__releases(&lo->lo_mutex)
+	__context_unsafe(conditional locking)
 {
 	mutex_unlock(&lo->lo_mutex);
 	if (global)
