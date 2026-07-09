Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7412DCF41
	for <linux-block@vger.kernel.org>; Thu,  9 Jul 2026 21:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783632982; cv=none; b=Vows5oOaAJ3HTYG3bsedmwmPaf4Lm9DdPh9n9zLvgGK91IqFL9TguIZFgeK7hHO8hW0GAqyaVUtA12Ln9IiJmC+Dms+ahMCYzkdDQ0dfWpFmOHGttOZZGHQGNOaqT5evbBtzHcVbzIvHbzj0e5s+LbDwKp5GjtxfZC83ZTPMAns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783632982; c=relaxed/simple;
	bh=oAOGTaB4FDLpvpV/NCEs0aSlynJSQ/sLn9NcePHkEWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tGcIg0TSkNGkMEcDhKzye2Yj3g5w0ZKVfkvfa+uZV2u/KAdasQSqjuZBaMAQwvCIHZcOpM8GqXChzrR1VavO6op/xXANl69+GoeXnQ/gaV82bM3YmJfftJEDujOxnV86TOkh/3QgeQ5P8fBV7oMr7btx+9/QMw00YH+F10+BXtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=z+OxgYfG; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="z+OxgYfG"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4gx7ZD4bv1zlfdCs;
	Thu,  9 Jul 2026 21:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1783632976; x=1786224977; bh=efRwG
	VgwHpZ9pa6rtTHGQ8KMxo4VvZQU2whpNwIjRTQ=; b=z+OxgYfGIPqYTzWF4vhd2
	TF09BMJPF375I1fZ0WFqaVl6IgGwv7yr3yZlJJOMnefOv6Wzzb6tieYa5pzo+Z6n
	Bt3whjivvu+ZSoMW5H42HxTv+vkuJ0KkJqJ41UX+YbGLiNwSEddc+ImzQGPNN6rF
	QsMlkXN0rxtUbJ8ElUCTvrEVT4ED4qvofEUjDSH11aEEC7wpTFE3iN62/BI6YaKt
	HuG6ldixxOwUhH3YLS/YB0F+YfNrAjv8P1deXv4vqIFixTk9VDVp3Muj0aVyx3gE
	YZw4Mt2xC8AJNiYXK3LIB/o6TUMlwtb05VueTsDdLtYycRNpyp6kbziGFknmHO3Q
	Q==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id me7E8N9kuy3q; Thu,  9 Jul 2026 21:36:16 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4gx7Z53DlbzlhH0D;
	Thu,  9 Jul 2026 21:36:13 +0000 (UTC)
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
Subject: [PATCH 09/12] drbd: Make a mutex_unlock() call unconditional
Date: Thu,  9 Jul 2026 14:35:30 -0700
Message-ID: <139d94c8c38b79d55aa7de2ec75a42c1276404a2.1783632330.git.bvanassche@acm.org>
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

Only jump to the 'out' label if resource is not NULL such that the
mutex_unlock() call past the 'out' label can be made unconditional.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/drbd/drbd_nl.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index ffcee2e2d1eb..748b1d093f2e 100644
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
