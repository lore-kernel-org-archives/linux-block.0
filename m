Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB004499AB
	for <linux-block@vger.kernel.org>; Thu,  9 Jul 2026 21:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783632981; cv=none; b=g7eN0G8RKWF6+FZyX17ebcrCdgZQS3hIxBFPX+QO/xLfPUaZmczXV4gZTJX1pJdWFugHlFpFyTafk5mOrYZ3ASCfz2ukr+S21lkwaYiF0kf2zgEgzueg2sxI03JP4VkVgpI79UtnNBPE9dCjQDggZZLvmDGlnoJFjCDaRntS9ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783632981; c=relaxed/simple;
	bh=l33VtmfbgsAkEUBxYt6KsyNEsReFzdjhZh+aFWJ8pCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I4kJClHvUmG0upiEMy+dI8+6Ph9vtyEg5ZDWCezmpPDel8I629ehiJovzOcv05N0fUiNwZMCgqzBXLThBi/rqLOAEDbKwJLZ6ipJdKbQTRRKaXe9M6dNXE3/NIb7MBzSfAfJ9ANMFccdKQdHPBreYJnZZPbrQozlVoP1Q7q6I44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=g6jeDrUJ; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="g6jeDrUJ"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4gx7ZC3DV1zlhH0G;
	Thu,  9 Jul 2026 21:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1783632972; x=1786224973; bh=nGyNn
	5+21JpZhynkEEXDqussHWd1fQR5J51HcJPwQdA=; b=g6jeDrUJ3Cc0iDvCCFiES
	qW+m+6ZcL9fJyHKJ6XvZ8bhsU2d8Iwo3/c1WeNSBGPGbGqwX6GIahsN1+Dbj7pnN
	vI4fTJgS+fNqPAmpnKv1/lyhnZpCgthPe9bN5rVXBOse79nOZnHD/bDgRakUnvvU
	slUYU99RKMhccrgYY11Lv4YWBTuwnA708c8u7u36Cd5P+ZGQPnqmaXB0saNkJMZ1
	BrNILs+h0qzMA0R/BusR19vJD+WJri+Ir/BnzzxElsIWWbbmntvK8bzprcxE0vB2
	XwSB63d9fGJb0mHSvNFSQ6q/HqL2HwkYk3Km9m1JQAPAOj7QAE26Jnu39HmTMjQl
	A==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id N94Dc8W7UAd0; Thu,  9 Jul 2026 21:36:12 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4gx7Z26d2JzlfdCs;
	Thu,  9 Jul 2026 21:36:10 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Marco Elver <elver@google.com>,
	=?UTF-8?q?Cc=20=3A=20Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>
Subject: [PATCH 08/12] drbd: Split drbd_nl_get_connections_dumpit()
Date: Thu,  9 Jul 2026 14:35:29 -0700
Message-ID: <ebdd4810614f465d0102f069472babb3a7d1eb02.1783632330.git.bvanassche@acm.org>
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

Move the code between the 'put_result' and 'out' labels into a new
function. Prepare for making the following code unconditional:

	if (resource)
		mutex_unlock(&resource->conf_update);

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/drbd/drbd_nl.c | 98 ++++++++++++++++++++----------------
 1 file changed, 55 insertions(+), 43 deletions(-)

diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index c44b92856da3..ffcee2e2d1eb 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -3529,15 +3529,56 @@ int drbd_adm_dump_connections_done(struct netlink=
_callback *cb)
=20
 enum { SINGLE_RESOURCE, ITERATE_RESOURCES };
=20
+static int drbd_nl_put_dump_connections_result(
+		struct sk_buff *skb, struct netlink_callback *cb,
+		struct drbd_resource *resource,
+		struct drbd_connection *connection, enum drbd_ret_code retcode)
+{
+	struct drbd_genlmsghdr *dh;
+
+	dh =3D genlmsg_put(skb, NETLINK_CB(cb->skb).portid, cb->nlh->nlmsg_seq,
+			 &drbd_nl_family, NLM_F_MULTI,
+			 DRBD_ADM_GET_CONNECTIONS);
+	if (!dh)
+		return -ENOMEM;
+	dh->ret_code =3D retcode;
+	dh->minor =3D -1U;
+	if (retcode =3D=3D NO_ERROR) {
+		struct connection_statistics connection_statistics;
+		struct connection_info connection_info;
+		struct net_conf *net_conf;
+		int err;
+
+		err =3D nla_put_drbd_cfg_context(skb, resource, connection, NULL);
+		if (err)
+			return err;
+		net_conf =3D rcu_dereference(connection->net_conf);
+		if (net_conf) {
+			err =3D net_conf_to_skb(skb, net_conf);
+			if (err)
+				return err;
+		}
+		connection_to_info(&connection_info, connection);
+		err =3D connection_info_to_skb(skb, &connection_info);
+		if (err)
+			return err;
+		connection_statistics.conn_congested =3D
+			test_bit(NET_CONGESTED, &connection->flags);
+		err =3D connection_statistics_to_skb(skb, &connection_statistics);
+		if (err)
+			return err;
+		cb->args[2] =3D (long)connection;
+	}
+	genlmsg_end(skb, dh);
+	return 0;
+}
+
 int drbd_nl_get_connections_dumpit(struct sk_buff *skb, struct netlink_c=
allback *cb)
 {
 	struct nlattr *resource_filter;
 	struct drbd_resource *resource =3D NULL, *next_resource;
 	struct drbd_connection *connection;
-	int err =3D 0, retcode;
-	struct drbd_genlmsghdr *dh;
-	struct connection_info connection_info;
-	struct connection_statistics connection_statistics;
+	int err =3D 0;
=20
 	rcu_read_lock();
 	resource =3D (struct drbd_resource *)cb->args[0];
@@ -3545,10 +3586,13 @@ int drbd_nl_get_connections_dumpit(struct sk_buff=
 *skb, struct netlink_callback
 		resource_filter =3D find_cfg_context_attr(cb->nlh,
 				DRBD_A_DRBD_CFG_CONTEXT_CTX_RESOURCE_NAME);
 		if (resource_filter) {
-			retcode =3D ERR_RES_NOT_KNOWN;
 			resource =3D drbd_find_resource(nla_data(resource_filter));
-			if (!resource)
-				goto put_result;
+			if (!resource) {
+				err =3D drbd_nl_put_dump_connections_result(
+					skb, cb, resource, NULL,
+					ERR_RES_NOT_KNOWN);
+				goto out;
+			}
 			cb->args[0] =3D (long)resource;
 			cb->args[1] =3D SINGLE_RESOURCE;
 		}
@@ -3579,8 +3623,9 @@ int drbd_nl_get_connections_dumpit(struct sk_buff *=
skb, struct netlink_callback
 	list_for_each_entry_continue_rcu(connection, &resource->connections, co=
nnections) {
 		if (!has_net_conf(connection))
 			continue;
-		retcode =3D NO_ERROR;
-		goto put_result;  /* only one iteration */
+		err =3D drbd_nl_put_dump_connections_result(skb, cb, resource,
+							  connection, NO_ERROR);
+		goto out; /* only one iteration */
 	}
=20
 no_more_connections:
@@ -3603,41 +3648,8 @@ int drbd_nl_get_connections_dumpit(struct sk_buff =
*skb, struct netlink_callback
 		cb->args[2] =3D 0;
 		goto next_resource;
 	}
-	goto out;  /* no more resources */
-
-put_result:
-	dh =3D genlmsg_put(skb, NETLINK_CB(cb->skb).portid,
-			cb->nlh->nlmsg_seq, &drbd_nl_family,
-			NLM_F_MULTI, DRBD_ADM_GET_CONNECTIONS);
-	err =3D -ENOMEM;
-	if (!dh)
-		goto out;
-	dh->ret_code =3D retcode;
-	dh->minor =3D -1U;
-	if (retcode =3D=3D NO_ERROR) {
-		struct net_conf *net_conf;
=20
-		err =3D nla_put_drbd_cfg_context(skb, resource, connection, NULL);
-		if (err)
-			goto out;
-		net_conf =3D rcu_dereference(connection->net_conf);
-		if (net_conf) {
-			err =3D net_conf_to_skb(skb, net_conf);
-			if (err)
-				goto out;
-		}
-		connection_to_info(&connection_info, connection);
-		err =3D connection_info_to_skb(skb, &connection_info);
-		if (err)
-			goto out;
-		connection_statistics.conn_congested =3D test_bit(NET_CONGESTED, &conn=
ection->flags);
-		err =3D connection_statistics_to_skb(skb, &connection_statistics);
-		if (err)
-			goto out;
-		cb->args[2] =3D (long)connection;
-	}
-	genlmsg_end(skb, dh);
-	err =3D 0;
+	/* no more resources */
=20
 out:
 	rcu_read_unlock();
