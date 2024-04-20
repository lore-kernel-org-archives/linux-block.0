Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC8D12E6C
	for <linux-block@vger.kernel.org>; Sat, 20 Apr 2024 07:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713597399; cv=none; b=Yzgan6Z+KsrSw+bNOwYHxyD9DTpgQXFzXSi+mOyuRKKvmwFfFN4s+rmyuGd/dd3Xv3fz5xy4GCNcfN3eUcnupTCOng9jv/kjRjijCctxVkvxwr0ONLSakrCny9N7TEy1+FhQYbZRxlLBjntA0zFf0arqTIkqqjjHRNPI+3G0vuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713597399; c=relaxed/simple;
	bh=oyiHc6p3G2ZI1v4mkmdMazewCoDvlhkyzs5XQlJyCrI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=es+zjlJpEMy7ceKSNZ2F635PCC8fWxV00xrMKLDscsIouWwmi+6oWzgXUL/GAFUMJkDWSRR/N5vNBUJqpiCaJaSw5KmV7foMPgASJ6tmIVmlbpUhUAWvJ13a54V96IppWLHGK62Yl6FXyqWRNMHeV8jAddwzcFWAlwM1c6DmRMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QYgpHn3/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QYgpHn3/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B824C3277B;
	Sat, 20 Apr 2024 07:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713597399;
	bh=oyiHc6p3G2ZI1v4mkmdMazewCoDvlhkyzs5XQlJyCrI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=QYgpHn3/bDPw9mN7GO64Mf0p1QNIPsH21ghsmU/9/Wuce7j0ZjiFv0OE53Y6sgSMs
	 9mVCNHGI+DevOa+gLM8hAXjsOOlBHAZhmfDEHTFQIWTLLtR+RhfFmIcu11YGDSOy+e
	 D385JXdntChzllqjGfz7/oxrLVLO3hufOkJbYCmPTJhSGx9/PIjI7rEF/myxA8cXHX
	 FACAY414am0Vo1qRGruhKx+0sPJlZhjKOOZ8+0bnG4AmufgsMo4JbpoWcLBwS/39wJ
	 2N5XHtKEnicqiW0nEIPMaa/FPS4ZRz04s4PI7AEVqAeHaQAzMNZ8z65eoS5PTUXAdB
	 ISUNYbhiPWuDg==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: [PATCH 1/2] block: prevent freeing a zone write plug too early
Date: Sat, 20 Apr 2024 16:16:36 +0900
Message-ID: <20240420071637.1270724-2-dlemoal@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240420071637.1270724-1-dlemoal@kernel.org>
References: <20240420071637.1270724-1-dlemoal@kernel.org>
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

