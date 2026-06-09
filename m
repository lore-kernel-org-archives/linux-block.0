Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBA83EBF0F
	for <linux-block@vger.kernel.org>; Tue,  9 Jun 2026 22:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781042756; cv=none; b=YQM2L/9o2IN0jjokpzn1Ce2cbDQHt8rbXfiXZ1fJbef3OICjeu2/W/akbroL6ja+hFc7nVT7AmDV2jeURFp2LedqoTlAEuPolBgq8BaWun4iO1ByQBaxyL3ZSNyyUDWTw6yA/AjZ76NX19oSJxafjzBZQBfiIkbS/6o7AK/u6rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781042756; c=relaxed/simple;
	bh=Y7c3R8cTEUfdl91yTLJxSt9zMNJAsRDGOyZgOb/zzGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FesdVSnucb2bX1wDUufL0ZHUaPw7LlN3KZqA4N/hEBWRfZWHY1ORDEaW++U0juwThhMAeBKpQI3c/m8lSo88Q6lKkMQ1nDlB6jhvRWTfX8Oc6Nk7Q63QnYDO6t4fnzZgnB8kgnIFLeClr8DvVjMc+HPeDj4K3OvxMMWnK89Vxlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=nif2Xyg9; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="nif2Xyg9"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4gZjfB568QzlfpM6;
	Tue,  9 Jun 2026 22:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1781042750; x=1783634751; bh=XmZos
	eb0D4FO/lDhRuqJQX9LSmBqCYPXmA8zPuSMnEk=; b=nif2Xyg99+qEjIZRoMMWu
	8+pFZYRiD18CdSqCWUFVk6YZ8ygbQLv6s2rRs2P+XYUIYFXD79AXIZz7QLasXkr2
	JJQni4wZjJ+mURl5FPSzTQJls/qBdnOovoCNla1wokHhR6ofr929Fn6eg6gHcKOx
	UI/tJbU9vS+a1k4KBuYwktNdZDHdpg0yNOw1w4SzS1SNawFALVUtXqjGRt8xqg7I
	cPRaHV5pxQMqEZ3daLHP93YqHahD8r8YlK/nJHR/h2oopiXxTOUOfmwqTUY5nkQ2
	YYU3+klZWczzsDzfXaqi+Vk766XlCCDMf0eobuxQqz1NHUY9Uq3Vh5iaoZolqs9n
	w==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 31oKxNQw0sJQ; Tue,  9 Jun 2026 22:05:50 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4gZjf42MCMzlh1Mn;
	Tue,  9 Jun 2026 22:05:48 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Marco Elver <elver@google.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Subject: [PATCH 04/27] drbd: Remove the get_ldev_if_state() macro
Date: Tue,  9 Jun 2026 15:04:51 -0700
Message-ID: <0f1141908524e2361a6c4921c668190c8f9a5831.1781042470.git.bvanassche@acm.org>
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

The get_ldev_if_state() macro has been introduced because sparse does
not support something like __cond_acquires(). Remove this macro and
rename _get_ldev_if_state() into get_ldev_if_state().

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
