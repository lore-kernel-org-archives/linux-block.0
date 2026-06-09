Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60533EBF0F
	for <linux-block@vger.kernel.org>; Tue,  9 Jun 2026 22:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781042764; cv=none; b=LqMfSpWH6HP3PtWTF4TXKH/5Y45IeDL7zP2OePAfN61how8cArxTvr3k42ozHsw5aBZdkhrR/ZmjE8i/b1IMAgEw4GYo0uML6+iKGM8TgxfexZ/H4hu/zCISFJVcEEmi+NkerLx2hqT71+PQSPmtm66Y1I6bybVKNnDnzeeFITg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781042764; c=relaxed/simple;
	bh=KqRX10a5ex4ZtdIwMtqYrNZTwrzJxCKMpnHPqL6jeU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kN1L5vr5RmPHynr4wELkuiZl5es0ZHexQDt8mp9ICCnWpkBXATTQZNn0Mgy5KUhlTN8h93SRM33WK7J0C5lMM61ArbY55wfKDTrQpoUbD4TEtB2Fnv4Qlp10mt2FWoxZ5GlVKdQUmEskXmn4LYd53ua9KNT3AorKPC9wf9A01g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=AhOVFBRn; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="AhOVFBRn"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4gZjfL6trbzlgyH5;
	Tue,  9 Jun 2026 22:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1781042758; x=1783634759; bh=GycQA
	XOcNMKQEYZ+GBa50tYPVXLOmT70GIbRkkLm500=; b=AhOVFBRnQMDh9lC5Vk+nZ
	klWlWVl3BMmfpgnCr8N8t6IDa2UuNFKWqZYa30hS3KfvXX601z5b0YhtDiGbptPf
	5mAaM3JG4dnwfccozBLSGaPGqpaWNgG68MDyogmZ7oDNzbKLVBOY2Hy6yzwCqN4J
	hIc94eJGct7tXX5lN32FqT3Q2U3fzGahYwbuuvqcdwogwOBHqiumPnPQuTzeTQXD
	cMeZ+XqRbGzN5PjlwrJi8vYErf2H2Z8pfftvAn7SuYybD/AdDy+Cj2ojZtu6696r
	7ww4ZSIk29skrOmazubTSkx1+LNCCq3LckQ1IICDeCQviWNcP5szjhjnfXWCjDAw
	A==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id zQpl6qCQhcdJ; Tue,  9 Jun 2026 22:05:58 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4gZjfD4MtwzlfdCs;
	Tue,  9 Jun 2026 22:05:56 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Marco Elver <elver@google.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Subject: [PATCH 07/27] drbd: Move two declarations
Date: Tue,  9 Jun 2026 15:04:54 -0700
Message-ID: <7e40961a092b149aa2e3b6fc3c510da650ee0401.1781042470.git.bvanassche@acm.org>
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

Move the resources_mutex declaration in front of the functions that
acquire and release this mutex. Move the drbd_wait_misc() declaration
past the struct drbd_device definition. This patch prepares for adding
lock context annotations.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/drbd/drbd_int.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.=
h
index 4b9d69adb9d4..1f3f2157df8b 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -195,7 +195,7 @@ struct drbd_device_work {
=20
 #include "drbd_interval.h"
=20
-int drbd_wait_misc(struct drbd_device *, struct drbd_interval *);
+extern struct mutex resources_mutex;
=20
 void lock_all_resources(void);
 void unlock_all_resources(void);
@@ -1094,6 +1094,7 @@ int drbd_bmio_set_n_write(struct drbd_device *devic=
e,
 			  struct drbd_peer_device *peer_device);
 int drbd_bmio_clear_n_write(struct drbd_device *device,
 			    struct drbd_peer_device *peer_device);
+int drbd_wait_misc(struct drbd_device *device, struct drbd_interval *i);
=20
 /* Meta data layout
  *
@@ -1363,8 +1364,6 @@ extern struct bio_set drbd_md_io_bio_set;
 /* And a bio_set for cloning */
 extern struct bio_set drbd_io_bio_set;
=20
-extern struct mutex resources_mutex;
-
 enum drbd_ret_code drbd_create_device(struct drbd_config_context *adm_ct=
x,
 				      unsigned int minor);
 void drbd_destroy_device(struct kref *kref);
