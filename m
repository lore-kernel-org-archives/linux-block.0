Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434AB13ADC
	for <linux-block@vger.kernel.org>; Sat, 20 Apr 2024 07:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713599894; cv=none; b=hw1zOrhXPKg6bpoGf+AjtZhouhqEf5V6og5IXJ7o3HUdRACp8e0yAujw0mkD7bgEP8Q/NtPpgTI30vpkRJ1GLgNq9EZ2RLkClIBuRkuTQXxw4YsXIqpV/yfVsnMBmz77+u6+fASMeOyR3W6Z2EzoasjH6+O6pBzwtAAwOc1kLSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713599894; c=relaxed/simple;
	bh=oyiHc6p3G2ZI1v4mkmdMazewCoDvlhkyzs5XQlJyCrI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=usPA92MAN25cbpHhzcZdeLKox7ju2See1P1w9DZMIIiQCpn/Yn1TsrZuUHds9oY+kWR2vO43ahy5F0FexQrH7J2vEgWsg4J/Q+79XLjTKy7p1tAqebpJwOLw17FR2Vh346aZwr62SqXXSJ6E1SyivX95bI8Hu6q25EoAKyY02Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CSdm4vpt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CSdm4vpt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64B4AC3277B;
	Sat, 20 Apr 2024 07:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713599893;
	bh=oyiHc6p3G2ZI1v4mkmdMazewCoDvlhkyzs5XQlJyCrI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=CSdm4vptwLBLSxSg448e4Up3KcZDQYA4pI34ZRNCwxs7Ksd+iERFS7UgdsMaKsMB2
	 zKEKlBcygd9IMY9PEkCpgNrx5f9hqFnv0F5OmFJv1x4k0a8q22EMvI7DEnkeEFl+ue
	 zE9tTc91eYv+QCMXY3lFzM4Gz1s5AZIYFnnIuoD1C7PD2xJaxBuqQgqetCSWNN24Sv
	 kmgF14HBZzR11NG5LsNyMuAmNcM6591gNCsRvFTPQS9l2MWLc0e41qRiFDms7sypgl
	 3KiSuGAfyIW2VD1+mMFIOTIJxOM3JKEJ7gkZWSwcRUt/lG4PLgUP1A4ZqHE5TQcdqk
	 gL9S6CwioM6gw==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: [PATCH v2 1/2] block: prevent freeing a zone write plug too early
Date: Sat, 20 Apr 2024 16:58:10 +0900
Message-ID: <20240420075811.1276893-2-dlemoal@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240420075811.1276893-1-dlemoal@kernel.org>
References: <20240420075811.1276893-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The submission of plugged BIOs is done using a work struct executing the
function blk_zone_wplug_bio_work(). This function gets and submits a
plugged zone write BIO and is guaranteed to operate on a valid zone
write plug (with a reference count higher than 0) on entry as plugged
BIOs hold a reference on their zone write plugs. However, once a BIO is
submitted with submit_bio_noacct_nocheck(), the BIO may complete before
blk_zone_wplug_bio_work(), with the BIO completion trigering a release
and freeing of the zone write plug if the BIO is the last write to a
zone (making the zone FULL). This potentially can result in the zone
write plug being freed while the work is still active.

Avoid this by calling flush_work() from disk_free_zone_wplug_rcu().

Fixes: dd291d77cc90 ("block: Introduce zone write plugging")
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 block/blk-zoned.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 3befebe6b319..685f0b9159fd 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -526,6 +526,8 @@ static void disk_free_zone_wplug_rcu(struct rcu_head *rcu_head)
 	struct blk_zone_wplug *zwplug =
 		container_of(rcu_head, struct blk_zone_wplug, rcu_head);
 
+	flush_work(&zwplug->bio_work);
+
 	mempool_free(zwplug, zwplug->disk->zone_wplugs_pool);
 }
 
-- 
2.44.0

