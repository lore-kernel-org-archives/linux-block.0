Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC5C4499AB
	for <linux-block@vger.kernel.org>; Thu,  9 Jul 2026 21:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783632974; cv=none; b=duN59K8Expbd9+2VZL95qu+n4yh4d8RXMBqS6VZenzCE6Ox3d6TPcVoH87mhuLA45b7a/O1x18W92L8nVBwkvtJnVQa7jU4ZVaXxuGEyfgmB4QSq26Jn3idZZflnvy0LL8FNI4Ii7b3a/qkNyHR9zRQpl9HWy6J9A+HjX2+gQCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783632974; c=relaxed/simple;
	bh=nlB/kUWzPjczR0gDlJs7DJzEUEfZfsjyWSgBxeIFycY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AfWjrTGoM37QvCP2LQeGHGTYYwXyMOE78dRI+rz8oH5+oKGTnMoxopmudVxEBlPutwPNfadiNYGGFpTQJUatpvhpETqSa2jLVM5Ph0PyeoeuduqsEulEC7FkPlNZiJmZgW7DDqTmUqSAS+7pjwCXNBBhBY9Xjpem5KfuAT5NxAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=WdDYdEHC; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="WdDYdEHC"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4gx7Z446t7zlhH0B;
	Thu,  9 Jul 2026 21:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1783632967; x=1786224968; bh=enOgg
	uDwPE5BpoyBXSQ+CMayqCmimu5QC3uM/GH7brc=; b=WdDYdEHC7zTnplZS2uDrT
	UjLQf1v84ATKzvaF6FJL/nQOniLnfWrk6PDBqd77fVueCU7FGDk+/nHo9u2aHOus
	mGBJjOkXb7TvJPC74pFg6RmaVw+3aI6HscCF9Vo5LICWQPcHFCGFTHWaoiijd5m7
	aV/kt3VzubzQuUrurJS5MTkWJalLo2/VEJwJuB615PrleB2U+pFl/CftOPO9gmMh
	H11d4L5c/EoZcznlQ/9PNEZH0FymhXtRo/Ywg90/5t1+yN4H+YG0rGXhypRRD28x
	WDsY8aH/Kn63kRnDcvcOvGVkFL9V0aq9oj6C9TbSFFx26leJS70xYX3K/dmGHRHh
	w==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id K-FSJ8jfE49m; Thu,  9 Jul 2026 21:36:07 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4gx7Yx2bqZzlhH0D;
	Thu,  9 Jul 2026 21:36:05 +0000 (UTC)
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
Subject: [PATCH 06/12] drbd: Move two declarations
Date: Thu,  9 Jul 2026 14:35:27 -0700
Message-ID: <ae5f9acb485444cc67604b5e2e04867c093c1ef3.1783632330.git.bvanassche@acm.org>
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

Move the resources_mutex declaration in front of the functions that
acquire and release this mutex. Move the drbd_wait_misc() declaration
past the struct drbd_device definition. This patch prepares for adding
lock context annotations.

Reviewed-by: Christoph Hellwig <hch@lst.de>
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
