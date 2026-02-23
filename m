Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12063793AA
	for <linux-block@vger.kernel.org>; Mon, 23 Feb 2026 21:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771883407; cv=none; b=uR02LjnQU/edPEuOLaY8rxOd9pKS4F18JdDCWTuMU0X4zy6avZoeU0KEM0aVx/MIh0gK12kubegD1sPwhv99MzdZeAYx0w69pxXzbaUZkQJsCtCnzqe+izWPoaJn32IDau5VhOLw8regKLqnTb1T6yuFRD2rYJeFZwcOxU6A0Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771883407; c=relaxed/simple;
	bh=zq6bDNiJWYQ+kdpYBR0818FrKLlUyc71kpvByhT0XgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n8KdBsWIm9oNJjzSot9M+rifxy48ec8zIRDM4ZOn3Ov7EKSKSQSkEGO1x8vlTWQxpSkX3q+d9aRFOvJatHm0PjwJMXe/P2Wmlp0sd7kdJyYf8mXmD0clsZKWI887WXrUqxzOJjNyUTn16IR4bbSv2gFfa9qztGh4LA9HltqkqCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=D+vtbOZy; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="D+vtbOZy"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fKZJs1V3Rzlfl7s;
	Mon, 23 Feb 2026 21:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1771883404; x=1774475405; bh=Pw1/H
	BCffDYtyrpz53JT5DwDWzC+O3+7dDllLLl4yHE=; b=D+vtbOZyVICOxQs2wyaCM
	QNl0O+TX+4RWQ62tKqCDgEVM14/U5TYpq/oUNzYlEc9d6ePrNiikEIHDHT/P1FXs
	tYuClGBXifY0kvE8SHVeLIrHG7Iqt/LoFiiaWZEkDexcgboRNPivp5M1GoOfTEMm
	vJ2kzLGf9I65g1gDkADl0179NKOFkqjbTTdqwbwpolNO5STpukctXN/tuQqUNYkr
	9ZSWimYK17Kw9yIok36+BZWkxt6w0J994a1W2GbgNZZ1laG4tKx8aJ/MTdTzXTu8
	9Rc6iJCKMy6tDQMZVSRrzKaFq8jDnV01ILP733uYtC5hc6yYpr7xSJuDdAcAo6Q/
	Q==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id irHB_m02QGXx; Mon, 23 Feb 2026 21:50:04 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fKZJq320Fzlfl89;
	Mon, 23 Feb 2026 21:50:03 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Bart Van Assche <bvanassche@acm.org>,
	Andreas Gruenbacher <agruen@linbit.com>,
	linux-block@vger.kernel.org
Subject: [PATCH 03/62] drbd: Balance RCU calls in drbd_adm_dump_devices()
Date: Mon, 23 Feb 2026 13:48:51 -0800
Message-ID: <20260223214950.2153735-4-bvanassche@acm.org>
X-Mailer: git-send-email 2.53.0.371.g1d285c8824-goog
In-Reply-To: <20260223214950.2153735-1-bvanassche@acm.org>
References: <20260223214950.2153735-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Make drbd_adm_dump_devices() call rcu_read_lock() before
rcu_read_unlock() is called. This has been detected by the Clang
thread-safety analyzer. Compile-tested only.

Cc: Andreas Gruenbacher <agruen@linbit.com>
Cc: linux-block@vger.kernel.org
Fixes: a55bbd375d18 ("drbd: Backport the "status" command")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/drbd/drbd_nl.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index e201f0087a0f..728ecc431b38 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -3378,8 +3378,10 @@ int drbd_adm_dump_devices(struct sk_buff *skb, str=
uct netlink_callback *cb)
 		if (resource_filter) {
 			retcode =3D ERR_RES_NOT_KNOWN;
 			resource =3D drbd_find_resource(nla_data(resource_filter));
-			if (!resource)
+			if (!resource) {
+				rcu_read_lock();
 				goto put_result;
+			}
 			cb->args[0] =3D (long)resource;
 		}
 	}
@@ -3628,8 +3630,10 @@ int drbd_adm_dump_peer_devices(struct sk_buff *skb=
, struct netlink_callback *cb)
 		if (resource_filter) {
 			retcode =3D ERR_RES_NOT_KNOWN;
 			resource =3D drbd_find_resource(nla_data(resource_filter));
-			if (!resource)
+			if (!resource) {
+				rcu_read_lock();
 				goto put_result;
+			}
 		}
 		cb->args[0] =3D (long)resource;
 	}
