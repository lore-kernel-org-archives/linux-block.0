Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2BC81732;
	Wed, 31 Dec 2025 17:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767201739; cv=none; b=fwdmbP0E1kogOTJ2uVK3HmroQnzbEKqMixEHsPsw2rUGsPIfK1f/ma46qyjVFZa9bvgsWmfzi57N1/jx5PAFFHcPOEwQ4beslIC3zig7RhxzGQqdcpxj5CSLFTnrnmcJzmq5eB6qnhrigTxVjTjTq9C63XXVRUU2Tnw9yPPuhcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767201739; c=relaxed/simple;
	bh=VDDny+2QcoOw2Ggk69xl1kHlpWEUwbpfpAnWRcBk8rM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Sy/DMVZo48dwJiYFPxgziviMd8znfpAkFX/88mdu2IGrHOvrudJSrGbsCNWiuMrdD4eNHFJPwk3mWdyFdXLYtBcBBBW9LCRmmVDK6r0x7B7RYnmgcAVhDkL3HJSJ9u94LYtSf7ust+C6O8FB9VuSGTVGoPBviOcLSYDqyE7Wsp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=ptJwsOGF; arc=none smtp.client-ip=192.134.164.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="ptJwsOGF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ITcUj6uBUKyp7sUAB0nbMV5L5gZYuxxVkAnwHIPB+Og=;
  b=ptJwsOGFkqUcWOQmVodl7wmmfvRpEVZJXW6oCJmifYGQELruhO/3Juo+
   Qt7vRdZBvpzg0LZEqIjtmFtZ78/0dT7taGb4LURG8khQ4HWnC639qv+nK
   Gh1U2lr2Rb7Vvh9jU9L0czCl7/HwEuEzX01hO2XBz1DydR/73U91QYgzF
   4=;
X-CSE-ConnectionGUID: /BWuHIigT9WndUo8z3sgTA==
X-CSE-MsgGUID: QGtqnSlqRBeUOjxFLvwD5Q==
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.21,192,1763420400"; 
   d="scan'208";a="134818928"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.102.196])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2025 18:22:14 +0100
From: Julia Lawall <Julia.Lawall@inria.fr>
To: Yu Kuai <yukuai@fnnas.com>
Cc: kernel-janitors@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] bfq: update outdated comment
Date: Wed, 31 Dec 2025 18:22:07 +0100
Message-Id: <20251231172207.143911-1-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function bfq_bfqq_may_idle() was renamed as bfq_better_to_idle()
in commit 277a4a9b56cd ("block, bfq: give a better name to
bfq_bfqq_may_idle").  Update the comment accordingly.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---

v2: Update the email address of Yu Kuai

 block/bfq-iosched.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index 34a498e6b2a5..355a731e2c04 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -984,7 +984,7 @@ struct bfq_group_data {
  *                   unused for the root group. Used to know whether there
  *                   are groups with more than one active @bfq_entity
  *                   (see the comments to the function
- *                   bfq_bfqq_may_idle()).
+ *                   bfq_better_to_idle()).
  * @rq_pos_tree: rbtree sorted by next_request position, used when
  *               determining if two or more queues have interleaving
  *               requests (see bfq_find_close_cooperator()).

