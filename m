Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54F23B6340;
	Tue, 19 May 2026 20:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779222662; cv=none; b=KRYcNs3ezs+uwaP7ATKnKsL/TSjlcTeGqgtKnuVmKEE9LPmnKpN3BxjcbDgh8+B/0UY+N0wQVPrU/8I3UvC0pU3DIIlGTAnR2TN+V0REGBNCqMSqWcf9xT/uUT4FdqBdAru5+OJkcLfeOxl27IECscEDZb0BjE2Qg2yOggJGpSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779222662; c=relaxed/simple;
	bh=yZHk1ruKayumMYHGayQ4oen4HVaEBAWkfTAuovMew8c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ffjA7PrLwDw1UUNOn9hrXj3pRmECKVkKEk6mPh6A0Xv3BpOkrl9fDPhjQ33dlmwy2RiH5uCvCKUk8scjQP+fg5ymRdfrJs4Mi28p1e3yz3/yVwvNo44RYcOnAe7v4k5wypQXUrk2awYSNUL4FIeUZNyoSmJfZhz0Ml6zhaVs77U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lksJY6Wt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lksJY6Wt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE4641F000E9;
	Tue, 19 May 2026 20:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779222661;
	bh=ymV87WQu6SLHGYf9DY+7rf3qagjVFA0MccVv8lf/a0o=;
	h=From:To:Cc:Subject:Date;
	b=lksJY6WtjsZUHhEfl/IzdHRwWaka6Vi5OnC+E/2aL+TtNMKxMZzJGJUshjQspft05
	 Wv9+Ynhn6s1RAgJ6QN90pyoSE9+yCFkijMgouFTNuNfQGsc2s2XZonrNUngruKUM4N
	 ulSUivfz1HWbY0vfIzerd5SqmC2VAcYDG2WrSxLTt2LBFjJoLJN8e8JxeIe1zUs/nE
	 jsoDxz78tA5y4CTKTN8weeRUXsWzMKQqFCRvvDayMiNtU5OyBDDYq9TlKMzC74NkSc
	 KRAu2ccM/YswgKyHbyiEuXoevVT3zMXpQP1wn8GfCaXQmWTMxcqtCVpzUVHakAqIWq
	 5oQeIdvbWOhrA==
From: Arnd Bergmann <arnd@kernel.org>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Jens Axboe <axboe@kernel.dk>,
	Jakub Kicinski <kuba@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	drbd-dev@lists.linbit.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drbd: remove unused drbd_nl_mcgrps[] array
Date: Tue, 19 May 2026 22:30:49 +0200
Message-Id: <20260519203057.1340528-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

After the rework, two files have a copy of drbd_nl_mcgrps[], but one
of them has no references:

drivers/block/drbd/drbd_nl_gen.c:641:42: error: 'drbd_nl_mcgrps' defined but not used [-Werror=unused-const-variable=]
  641 | static const struct genl_multicast_group drbd_nl_mcgrps[] = {
      |                                          ^~~~~~~~~~~~~~

At the default warning level, -Wunused-const-variables is turned off,
so this has gone unnoticed.

Remove the extra variable.

Fixes: 8098eeb693c4 ("drbd: replace genl_magic with explicit netlink serialization")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/block/drbd/drbd_nl_gen.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/block/drbd/drbd_nl_gen.c b/drivers/block/drbd/drbd_nl_gen.c
index fb44b948cec8..e133e8415205 100644
--- a/drivers/block/drbd/drbd_nl_gen.c
+++ b/drivers/block/drbd/drbd_nl_gen.c
@@ -638,10 +638,6 @@ const struct genl_split_ops drbd_nl_ops[32] = {
 	},
 };
 
-static const struct genl_multicast_group drbd_nl_mcgrps[] = {
-	[DRBD_NLGRP_EVENTS] = { "events", },
-};
-
 static int __drbd_cfg_context_from_attrs(struct drbd_cfg_context *s,
 		struct nlattr ***ret_nested_attribute_table,
 		struct genl_info *info)
-- 
2.39.5

