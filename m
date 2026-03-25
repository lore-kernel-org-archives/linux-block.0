Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311B02AD00
	for <linux-block@vger.kernel.org>; Wed, 25 Mar 2026 21:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774475172; cv=none; b=SrXtGXgFsy3TP7n5S3zfq6ed7hn56FjyfkhgyOcGN2ggRycXyAZU/wN7Koq5zxE1O3Lh1YbZStmUSpu6aHcb7uhnbW1S4OE+6OyPDHPRuw4QkT3yw7rXYtqHPa1yvWj+EOLcsJJHfgmJUYr+UY7mr55/4fGLl7J+UDAlrJS8H9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774475172; c=relaxed/simple;
	bh=lrOib0qKAqlc0X1obI7YSMTajvyYX72CpLJpOrvAbCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=du8DyqWPSFsGrn8xvCliex/RSoqHPTk8L/zwDBJekTckrtDIs3AZPUz9AANBEJj/TtIr92OdJALCDbw380iVTu80Cq9lkPfk2b1YUZQME2NDmdpE586ugEueDcdW4IXCQdY9WZO8qrmLcYiiX99AVpGTzf42vMcao+USM6RAefk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=Hn4SjDgb; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="Hn4SjDgb"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fh0pV6qcNzlgyGr;
	Wed, 25 Mar 2026 21:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:mime-version
	:references:in-reply-to:x-mailer:message-id:date:date:subject
	:subject:from:from:received:received; s=mr01; t=1774475165; x=
	1777067166; bh=yI8QCvfn9YHC7jW4C3Mpsx117LAxqLX1C8+TDZ3noRY=; b=H
	n4SjDgbFYkgSSOFaMg0Ad+ffFP+/6iSIef9zvH7oauTbXkrhk4ga0ALHXBsAE15C
	dS62F6Fv0ZWH788Sxd5xtHRGUDN6SkhKQmZVkYkbucIttXglJ0hcPc1MhZc+Cbzm
	CcH0F/c995XrUA+1gMVEoKpWxb7mYsCyzFNgEQNdWONrBpXtfFN9kEcH1xrKX7Ah
	YvTUiiGsmTxfoEII5w/exGoWtFjo7+Npm0iMLDJjp0JwVYweqQ+WbTjK8A3tvFUg
	LHtUzWFsQVfZXvtbgfANtTT8iiHHZjVSuHlRw1mLW+4m7eh+4tXjGumCw+0CDRtB
	aLKon3LocJX9ZPalYFT9Q==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id D-BmkEGv-Uzq; Wed, 25 Mar 2026 21:46:05 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fh0pM0MhMzlgyGh;
	Wed, 25 Mar 2026 21:46:02 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH v2 15/26] drbd: Balance RCU calls in drbd_adm_dump_devices()
Date: Wed, 25 Mar 2026 14:44:56 -0700
Message-ID: <20260325214518.2854494-16-bvanassche@acm.org>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
In-Reply-To: <20260325214518.2854494-1-bvanassche@acm.org>
References: <20260325214518.2854494-1-bvanassche@acm.org>
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
