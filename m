Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554E838657C
	for <linux-block@vger.kernel.org>; Wed,  4 Mar 2026 19:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772653747; cv=none; b=AQC5IhjHtiHstmyS1JWRQXdXkQyelH33XLK74l+XDj80NK7myRGvCu/wP7KUkoMmJ4gniiTnzmsEvuDgOfgqyPEG3YEHy/G8ZhP0LgANaKaGvyQ2Bxwpd4hNJUjb5I67NjQ34TlikikWUko78PMlc0wBiAknr+t6NFIEy3RMURc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772653747; c=relaxed/simple;
	bh=OUcLerF14RC+NdTM+rfTeKQUatoGXTRtKadZdfn5cxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D0FyUNnh+K98NQcZ1+AZ03VicsAZLyR0pgPjG4vheFbVa0BK9v+XXot5bN6Z5FSgpLJeju1BOuPYodX5YmM5R6YF8XF8dbytWYlvdllEq5umpMS4lj9FSXr45KTvHEeq1ddkOinx5VYmqhcidpd+d1BOtsDp1QY8Z25igAEUtGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=qO8C9O28; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="qO8C9O28"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4fR3C56KRlz1XM0pH;
	Wed,  4 Mar 2026 19:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:mime-version
	:references:in-reply-to:x-mailer:message-id:date:date:subject
	:subject:from:from:received:received; s=mr01; t=1772653740; x=
	1775245741; bh=nQSYXZga5E6QxePLEpqTnGRazvQOE7vvfCXFQNXDZSs=; b=q
	O8C9O28cevPlCaj4Ji7DcnOU6RUQvq1Tx84WZJO7z/T+OUQ7xm+AME4BYmQ4STRq
	fPcFSAZG2ObAfobMHD+n/0fkcHfiz9pzxMp/2vr1QX3+4s87r+Gl/mG56P31r8Ia
	tkzvirBcv3QsTzFYCyaZXPzAYgUwDK9LHFGv9zykFstcLWLgF7atyr6vs1dSsl/0
	hOpNSM/zMNVywko5xFjaSN6N+kOcw/DiosBxCahrOTvi4i9yUKpplSGa4UKSVcDw
	P1XIu2w+Bse7lGDNOItTdgZr6FyOjMkJFtQE6eEA4vY/L+r+XvoMSBaLQqLZL1ua
	buSd+Sm9GZzLnctPJ5WMQ==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id SljoZ6_RsgYZ; Wed,  4 Mar 2026 19:49:00 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4fR3Bx2WLbz1XM6JV;
	Wed,  4 Mar 2026 19:48:57 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Marco Elver <elver@google.com>,
	linux-block@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Andreas Gruenbacher <agruen@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 01/14] drbd: Balance RCU calls in drbd_adm_dump_devices()
Date: Wed,  4 Mar 2026 11:48:20 -0800
Message-ID: <20260304194843.760669-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
In-Reply-To: <20260304194843.760669-1-bvanassche@acm.org>
References: <20260304194843.760669-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Make drbd_adm_dump_devices() call rcu_read_lock() before
rcu_read_unlock() is called. This has been detected by the Clang
thread-safety analyzer. Compile-tested only.

Tested-by: Christoph B=C3=B6hmwalder <christoph.boehmwalder@linbit.com>
Cc: Andreas Gruenbacher <agruen@linbit.com>
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
