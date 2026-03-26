Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622593E4C88
	for <linux-block@vger.kernel.org>; Thu, 26 Mar 2026 21:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774561274; cv=none; b=gRz80b2qHJDHcHJBpMIXlxks6SaDaJg7tlPn9/8l9ign32wYUn+P3sjYohJ4Co+6+6qJPGrC9WnO3+T6NuSdw1HyCNuzMT4lBqv2RE+XAx8ZQBf1T+D9n46OS9GHxAbJINlz5tn9FzZKHxIDKzz9d66SyqysFDqSncaK7jXQuQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774561274; c=relaxed/simple;
	bh=nI84xd/DV2qKrIDxyuINMAi9N52Tla73R7GgnDVBIhg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JhrOxfWuNg8WnvJx6huQTaBgmbVGKHq9nAXwmFS1q9rYk8i/Lmlv3ydwTPqp6oJ5dwegmRdeuEaIw91CARj0Z5z6OlJCbj1IGF9hq5N5e4Hxe046nEf0/BW8dY+rNalZQEs5YXRzQpWzRM4z9Z3OIg0VdxHnRI+HXgRDAyqg/CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=nLlDCbnZ; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="nLlDCbnZ"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4fhcfH4cp2z1XM6Jl;
	Thu, 26 Mar 2026 21:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:mime-version
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1774561266; x=1777153267; bh=9AVcV
	QtKehsl/JY+3DCbtSRX3NA3qCRn4URX8RKZ6EQ=; b=nLlDCbnZUM0Fb/vZXNrp9
	Sf+Lzr7wuuCw8pMbvpCWAioiyy5f15A8zTMApG5WwDLCFd9en2R2V1kvJqaSXTN6
	taTltXwxSs0wD9bq5EV3GrR0L0DF8Dfq5IUAXC57z1lGRs26cmzCZnWkfMt09RW9
	/VEWj32WUEHLDtBasDcYQz+JJ7LKOVVYKXbPaR1AIwN299Momsi5chmthLaatijK
	VNcAD7dd5+uLEjaRjTFLAsVlKckk2O/T14JqvnZDyvNYTRbrJhn4sW+7kSxNnosz
	pRlPrgR6usxhw3bQkA01Qi/R41ZjuBfXstClBz5wrsJjn4iEAifCtW4rs/ore2ZU
	g==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id rEN4Kmri5l1r; Thu, 26 Mar 2026 21:41:06 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4fhcf82j3lz1XM5kt;
	Thu, 26 Mar 2026 21:41:04 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH] drbd: Balance RCU calls in drbd_adm_dump_devices()
Date: Thu, 26 Mar 2026 14:40:54 -0700
Message-ID: <20260326214054.284593-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
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
thread-safety analyzer.

Tested-by: Christoph B=C3=B6hmwalder <christoph.boehmwalder@linbit.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Fixes: a55bbd375d18 ("drbd: Backport the "status" command")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/drbd/drbd_nl.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index e18fa260a662..1f8ffdf9b24e 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -3443,8 +3443,10 @@ int drbd_adm_dump_devices(struct sk_buff *skb, str=
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
@@ -3693,8 +3695,10 @@ int drbd_adm_dump_peer_devices(struct sk_buff *skb=
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
