Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C5333C186
	for <linux-block@vger.kernel.org>; Mon, 16 Mar 2026 20:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773691765; cv=none; b=K0KV9PM4GDeEd2cueFvUy3Q/koEW5zhY/5ajZf7qOzs9/PnTy+BQl6tRcYrmsQB0bHKB2e4K8WJcAuVfAJMc/HEC7aYq16D5JCDztGJwj9sjJ+xZhd9DA+O8IFovELodffY71IVRcPtzLtPgSMmfcKnzzc+bqeM6rJW0tk7UDwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773691765; c=relaxed/simple;
	bh=cDrvSux2Qf1SCtFIAs8dxmSQTWb0JJAmkAR1mpUVP2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gh/7/RGEUxeZEmjvwxKaGrOCg/zdJPqmc2HXFuHxgpecYRRZFYvnM6lHd+uNefpWncoYBhffNzA5Lu4ypQNxJ1yBvoi2S5SWNmV68l0uvXFGwTPhFnTnJoIJnAh8qLLgM8//XbqChLLye2Vfg633W43b61PocJkG4DOf2inOUgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=4gDomztR; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="4gDomztR"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fZR4z4gF6zlfgPY;
	Mon, 16 Mar 2026 20:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:mime-version
	:references:in-reply-to:x-mailer:message-id:date:date:subject
	:subject:from:from:received:received; s=mr01; t=1773691759; x=
	1776283760; bh=8iQmMJ0LkInsXZOqdFx0YT/2PvbJEbgVv+Lf0LmdOEc=; b=4
	gDomztRz2B4AFCn2VwXGyaikbLFcXvz9HCxN4hdRdD/ep7ErDinrWIJ4kQypByqM
	84sQ7hb4xNzJOGt8kowSqM+OX+hB+IRCcjq7NVv6pA3B9AvWPPEJN5gS4W9Csfm2
	JUEc5IB3H0iGcHgi85de+eUQe8geSllteLr1DDdKAy6HzlxLVAA8f9Ga3z/4k+NI
	G9xJcebm7FBe3N2PhPm5v399QviZC5TzIBCIhCZXcj/nixF69QgnacVcx9v/5rnO
	ttey4pJVLHkJQ2NUyoPzUBkLa1fejrmeg/uZlrPN2ez5PSWORHpOrGbPdLYVjjF1
	9hbPAuth/UZuIZvBpjoDQ==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id pndMFPnF9wwB; Mon, 16 Mar 2026 20:09:19 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fZR4q2nX7zlh1TK;
	Mon, 16 Mar 2026 20:09:15 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH v2 01/12] drbd: Balance RCU calls in drbd_adm_dump_devices()
Date: Mon, 16 Mar 2026 13:08:37 -0700
Message-ID: <20260316200901.4111651-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
In-Reply-To: <20260316200901.4111651-1-bvanassche@acm.org>
References: <20260316200901.4111651-1-bvanassche@acm.org>
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
Cc: Andreas Gruenbacher <agruenba@redhat.com>
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
