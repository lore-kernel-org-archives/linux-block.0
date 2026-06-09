Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD7E411669
	for <linux-block@vger.kernel.org>; Tue,  9 Jun 2026 22:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781042776; cv=none; b=gtYZCC1fxC+xagFzTUWSn20B747LXRwW806q03NLHX4xG6eEsn04azo3LQwrpWvPOywp34/HfkH14IMM2fjxtgQLDaXBj9rSUGBFDKeCPUH/r6vlG0ACKYSX532yGlobbIduxU7trb6N4hlD7fBlK9PMz7aBlEGkHVgOK1lO2Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781042776; c=relaxed/simple;
	bh=gzJ5rXs7/zLxq+wLuL1aHJ41VZwT0qeEYat+4U+EGac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kXhLaAq14dJzQFwW6agesGXsf9kIKLXh2njZnqeMdG9ik58Y3V3gu3lbuM2Hi1XWau6+2h+Um5mVUF0bJKPxzw9NWzDN0sCzIwnB7fX/ccqEUFRdjwQvFPNQny8XMfP+lTh9vStdpoe/+x6zJ7ghIo8bbeRvlwbZkfODdocjBKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=2V795P65; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="2V795P65"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4gZjfY6scSzlgyGq;
	Tue,  9 Jun 2026 22:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1781042769; x=1783634770; bh=ADKPB
	VH1qC4Tu2aj2TTO8qARHY8rwcepjDAuH6hQa9o=; b=2V795P656hB9pLdfH19JI
	l728hAKs4yUq9qXCfsu7IXMPGa+JjTqb8DjD0FLu7nz3hZ+kTsjhkFPDJvVDpUvp
	zE+c2Gf49q6ZAjWqYHVNvQ8MS9y8F1SLoiuG/50iUFn55xdrjAebjoZcgb8qX2cO
	G4LjJi5MqvoZyPby6Ms8A63YrRAKuqhooxKZXlzpMWrVCBKuHwCxykrDL1KpCNU8
	RP2otkSQYdeSmzQzKsgtXJCfijqPBBDBdqRGbG+zNY9RBL2FxrmlumziatZQEGZi
	2BpD+uykV9ClcPQas3G4pwBH3Y7tUSueXZpiNdw63HiwCI9HKj5mryb3aH74/o8t
	g==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id hdsrCfukAP31; Tue,  9 Jun 2026 22:06:09 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4gZjfQ65sDzlgy1v;
	Tue,  9 Jun 2026 22:06:06 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Marco Elver <elver@google.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Subject: [PATCH 10/27] drbd: Make a mutex_unlock() call unconditional
Date: Tue,  9 Jun 2026 15:04:57 -0700
Message-ID: <803dcc7259a57e513e7ec06a82307e75acd187a6.1781042470.git.bvanassche@acm.org>
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

Only jump to the 'out' label if resource is not NULL such that the
mutex_unlock() call past the 'out' label can be made unconditional.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/drbd/drbd_nl.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index 57ab1f1fb1bc..d0a370bd7609 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -3591,15 +3591,18 @@ int drbd_nl_get_connections_dumpit(struct sk_buff=
 *skb, struct netlink_callback
 				err =3D drbd_nl_put_dump_connections_result(
 					skb, cb, resource, NULL,
 					ERR_RES_NOT_KNOWN);
-				goto out;
+				rcu_read_unlock();
+				goto ret;
 			}
 			cb->args[0] =3D (long)resource;
 			cb->args[1] =3D SINGLE_RESOURCE;
 		}
 	}
 	if (!resource) {
-		if (list_empty(&drbd_resources))
-			goto out;
+		if (list_empty(&drbd_resources)) {
+			rcu_read_unlock();
+			goto ret;
+		}
 		resource =3D list_first_entry(&drbd_resources, struct drbd_resource, r=
esources);
 		kref_get(&resource->kref);
 		cb->args[0] =3D (long)resource;
@@ -3653,8 +3656,9 @@ int drbd_nl_get_connections_dumpit(struct sk_buff *=
skb, struct netlink_callback
=20
 out:
 	rcu_read_unlock();
-	if (resource)
-		mutex_unlock(&resource->conf_update);
+	mutex_unlock(&resource->conf_update);
+
+ret:
 	if (err)
 		return err;
 	return skb->len;
