Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6FD24BD03
	for <linux-block@vger.kernel.org>; Tue,  9 Jun 2026 22:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781042775; cv=none; b=Ekn+qVfbz+bjbZu65D2yyZ/U9ayps8gzkLUJAjZekS4y1l08O5G0lN0+O+TUeAZFFwvKqrI4IGhtopRWihlYaeG1v+5dVW8UoRT/Q7bWmBEgRfNzmDw5hq67Ef9VLQx3YCVrzAaIdBOM68/mtMur6rN6GtVt6RZSq12zQfrrkJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781042775; c=relaxed/simple;
	bh=tdyKlHhQ6Un0EZOlyGsmDkoONjFDReveGlVHYC59Iu4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZJkyBU5BkWlSYw0Lw48Uj30m+BJ25zfcrPY77Jk99uo+oOah0NHiRIqYVDnTyPKRAjivPfZ6gjgygP/NQGKg9mcGv7sKOITwmZsdhrU44TNiVKY5BwYxaN48asbtMCtMgAh+4U7Ak6WnLXjCvf+bCIZV9NTKtCKpAvUA5sHT/F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=FzB8E900; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="FzB8E900"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4gZjfY3dl3zlgwMq;
	Tue,  9 Jun 2026 22:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1781042766; x=1783634767; bh=JQgPf
	ZFpm+QGbk0jZW5aUNF6RsdSIvgF36i/iITreKY=; b=FzB8E90000zWawHyQw38c
	XgmLW/b+QOhJ+w40bNckEigROQahQBo12y2a8zZpm/eQ2ivRkFtzky5HLlmlEy4t
	kR9qSr468pRy/6EqOu/bx9VP8y33PXLC8M0Mg5lgoh9vgAgAdWCFFIkfoX9t+rn2
	rlSRT188vNrsP0mq2j6XWoLc+6H34z+ZN5IIKX0oUKWsktY4P7TCCz0Psh85+uAt
	2CQj+YEWP+wn1ewenh+Y5ry5fNbKltVx0qncCKTuoMQsptbWkIsfC36AsW96+87q
	ci7UO720spjgPpJiDCTaIHITp75V2WPrcgXA0ZRxIWl5GAAkabMC0gCg7/W3LQVT
	Q==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id z7l3ZJ3VmfxG; Tue,  9 Jun 2026 22:06:06 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4gZjfM1Fp0zlh1Mn;
	Tue,  9 Jun 2026 22:06:02 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Marco Elver <elver@google.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Subject: [PATCH 09/27] drbd: Split drbd_nl_get_connections_dumpit()
Date: Tue,  9 Jun 2026 15:04:56 -0700
Message-ID: <167a1fe9f633fe1d1a0d89a50f10c3185d9ddddd.1781042470.git.bvanassche@acm.org>
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

Move the code between the 'put_result' and 'out' labels into a new
function. Prepare for making the following code unconditional:

	if (resource)
		mutex_unlock(&resource->conf_update);

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/drbd/drbd_nl.c | 98 ++++++++++++++++++++----------------
 1 file changed, 55 insertions(+), 43 deletions(-)

diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index c44b92856da3..57ab1f1fb1bc 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -3529,15 +3529,56 @@ int drbd_adm_dump_connections_done(struct netlink=
_callback *cb)
=20
 enum { SINGLE_RESOURCE, ITERATE_RESOURCES };
=20
+static int drbd_nl_put_dump_connections_result(
+	struct sk_buff *skb, struct netlink_callback *cb,
+	struct drbd_resource *resource, struct drbd_connection *connection,
+	enum drbd_ret_code retcode)
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
