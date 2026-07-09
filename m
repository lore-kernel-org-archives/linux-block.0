Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09CB2DCF41
	for <linux-block@vger.kernel.org>; Thu,  9 Jul 2026 21:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783632965; cv=none; b=EBS1LmcswZ7KLscichT3uO5BEiVnsEuUyd6PNbbrKb6E33qS6DyK4CIGtyylLAzZiNLsuUZoCE1NY/nDHvA+U/PkHvEADKHzlBjwlqWKbia+0XFtDacPhSca8WrCGLUGVLDTcMfPE3QzYUQTya7X0l1OVe2QWaFuOrIWWP8RG0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783632965; c=relaxed/simple;
	bh=SGPXMt47Lgd4I5NLXGGdWvEYFYTcS1t//djwqaZEuCw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nOEg6jOHzaSdeeGDAq2dxy+W4kko5EFOwkXHsgQxEWgfhvex5i10GQfGwDMp+buZRIZaSa6v7jWF2yh0BDSebzT6h8kAn1mmYgHddoLfTe1msOKsrG+2LoaKSk2DTDRFmh5EoGFWIsT+1XBrIgWdq83shz5imbtPM06ikiYfVZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=k90MgSBZ; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="k90MgSBZ"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4gx7Yv2G2xzlhH07;
	Thu,  9 Jul 2026 21:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1783632958; x=1786224959; bh=/7T59
	Z0pUcRfIggjT1uwrqo8WW2/igGw6UGI3xXXOT8=; b=k90MgSBZoLEhp0QrPpIex
	mlyfEKvOchrj30iXeYaGHAVeJoZm3AVtPoK69j3CvjGZRpmDKE0NSajVnIoU0Jxd
	buDhT9OFb5JCRzCBHNlieGn03EyfNLaYVjSyBrEG4nlTSCnvjG64WPfIskaxs/tM
	Z5PGfN8/oSEkXIUYuvUHadE/+qNwvcark3Rq5LFVz+oqmjJH/YLqH3+jdr2ngGqR
	aYXkWi6w8vDMzF/6hm+G5xUc1tDxb+NTxwvEPW81/TPsqERQqaXfrRh4Mq6wLQap
	+sEP/o2FR9ylkHNshJ4rcsReeA6xZ0EeFZ3cn5cTaoi9HQRS0FBCbX5mhDQwHRIG
	Q==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id hgbY-nKe3JUu; Thu,  9 Jul 2026 21:35:58 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4gx7Ym4zS8zlh30c;
	Thu,  9 Jul 2026 21:35:56 +0000 (UTC)
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
Subject: [PATCH 03/12] drbd: Remove the get_ldev_if_state() macro
Date: Thu,  9 Jul 2026 14:35:24 -0700
Message-ID: <08fd1a5f8aebf51d3c547c585c87adb6d7485051.1783632330.git.bvanassche@acm.org>
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

The get_ldev_if_state() macro has been introduced because sparse does
not support something like __cond_acquires(). Remove this macro and
rename _get_ldev_if_state() into get_ldev_if_state().

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/drbd/drbd_int.h | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.=
h
index bba52252fbac..49383c309865 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -2002,9 +2002,6 @@ static inline bool is_sync_state(enum drbd_conns co=
nnection_state)
  *
  * You have to call put_ldev() when finished working with device->ldev.
  */
-#define get_ldev_if_state(_device, _min_state)				\
-	(_get_ldev_if_state((_device), (_min_state)) ?			\
-	 ({ __acquire(x); true; }) : false)
 #define get_ldev(_device) get_ldev_if_state(_device, D_INCONSISTENT)
=20
 static inline void put_ldev(struct drbd_device *device)
@@ -2033,8 +2030,8 @@ static inline void put_ldev(struct drbd_device *dev=
ice)
 	}
 }
=20
-static inline int _get_ldev_if_state(struct drbd_device *device,
-				     enum drbd_disk_state mins)
+static inline int get_ldev_if_state(struct drbd_device *device,
+				    enum drbd_disk_state mins)
 {
 	int io_allowed;
=20
