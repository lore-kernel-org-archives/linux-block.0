Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72FF3783C5;
	Mon, 23 Feb 2026 21:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771883510; cv=none; b=Q3AXMnkQlqixP6V11mbQruiLEVIqs+O6qG31uZvzGu714KbOwSgH/rSDnPqcwjoyvSu7N8hd8iYTBhFBUIdzBMBoaPJMov5JZK5ggT05Y1e5QV8dVKu2tQMzY6J1uA17/gZDhfcW8R89NjRfsr4S5BvQnaXYGK+gJSyAFf6EiNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771883510; c=relaxed/simple;
	bh=zq6bDNiJWYQ+kdpYBR0818FrKLlUyc71kpvByhT0XgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a4NhS0z3lNbYQ2R8xtBVt3Uc2uvXuUNJRwkjBTGNu+fKuZ4JA3Z+BqnQUMJf2Fa+0Z6EMn1+Cry82O5yn8vC6KgXdwOEQpvp9r5hP2iRpjq3maCveIMII30myLVGP4l7+yM2MHhZ8BZxf9TVVacwjDlIapvtJmPoL6Gl/Xe8Grs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=cKtLL9T9; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="cKtLL9T9"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fKZLr59B2zlh1Wg;
	Mon, 23 Feb 2026 21:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1771883505; x=1774475506; bh=Pw1/H
	BCffDYtyrpz53JT5DwDWzC+O3+7dDllLLl4yHE=; b=cKtLL9T9CFbpBYQqTm8iF
	DRgzkhNOHFo37eFhrcSvJndus5zqbK1/ujDF8NejegBHp8eajoc+Ut9jdIttRR+3
	T/vAvgPkhZ6GGPibtgAA1bsWNTuLTLCvjxBCSQBuI/nag6jFuFopubSfsFCTuFwq
	cTLSzXz6UrPFVHlg+jfE/wYF6zKEu7gYMuHU+PtbGPnfRbuhpdNFYop/d0w1ze/r
	TpWLfyt8/2GItudmfuS2GoYzQ1OB39DJX0X9wuR2cwdM3voRxOyzYZ/EqJ2uo7hr
	0VpvUHbOQTe0wwVKfwLMvjzqYFpOvJg48++m9gGfwN9mmSZCcz6J9RltsAJAmyN/
	g==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id kw3OZej3YiQK; Mon, 23 Feb 2026 21:51:45 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fKZLj5x6hzlfgQH;
	Mon, 23 Feb 2026 21:51:41 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Waiman Long <longman@redhat.com>,
	linux-kernel@vger.kernel.org,
	Marco Elver <elver@google.com>,
	Christoph Hellwig <hch@lst.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Jann Horn <jannh@google.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Andreas Gruenbacher <agruen@linbit.com>,
	linux-block@vger.kernel.org
Subject: [PATCH 03/62] drbd: Balance RCU calls in drbd_adm_dump_devices()
Date: Mon, 23 Feb 2026 13:50:18 -0800
Message-ID: <20260223215118.2154194-4-bvanassche@acm.org>
X-Mailer: git-send-email 2.53.0.371.g1d285c8824-goog
In-Reply-To: <20260223215118.2154194-1-bvanassche@acm.org>
References: <20260223215118.2154194-1-bvanassche@acm.org>
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
