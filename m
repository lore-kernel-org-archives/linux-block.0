Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDEE2628D;
	Wed, 31 Dec 2025 17:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767200487; cv=none; b=RIyyNXHi3xSmc8dX0KGAsjdbQdax3wnL+vgPF8ikwuMec4c2khOZcm+wc1u6xmC4LhI73p4HiyCRBAUOAB9oqQc03E9MeM3WR7dxC0sIhB9t1xnx2+XpoTOfPbWBlurlNo1YQv+H8ixB3O7SUiKN2dU+IoubOwnVAcsMs8+lFuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767200487; c=relaxed/simple;
	bh=9SdKlaU8EMcOWyN+a8k3zXwXSNceiUwuhX+/C+Y21wM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tFiJ/fZwB+s5dF47r2PicvSPdFqu25AhTQEhYfH86B6mTAU9ezNx1plh+1+gmXU+sccjKFYSOrVm3zTMkWJbW5udhN/bhs5cewfC375JdTRUk1pSAzEc6hkT3ifkHLFuQDOEdVPYAw7JGk0yFI+/YvBChj9NGHmCzx0CTDArNys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=Z4Kk3xwt; arc=none smtp.client-ip=192.134.164.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="Z4Kk3xwt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JzaT6YMekIKZjs91ZB40omkWvNzWTEmNqVO/qmivMEk=;
  b=Z4Kk3xwtIDlZCMSkeASfAfY464FJ9MTFpND+HYoWYLs3C04XgvVjmdvv
   qiQaRJSo65j/imlbcjF63DrmyeglWAhji8h4X0zvUtLeAkxQOT4YFClHA
   bSfjdH9zUBRoP19o1qp3xLJMsmGTBydGFuVEML1fNq67xrWbn8IBv0crM
   Y=;
X-CSE-ConnectionGUID: akgWHouqSCmAxErCeDPv2w==
X-CSE-MsgGUID: Lb0WJ4yyTUO10Y9i/NEL1g==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.21,192,1763420400"; 
   d="scan'208";a="256477593"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.102.196])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2025 18:01:23 +0100
From: Julia Lawall <Julia.Lawall@inria.fr>
To: Yu Kuai <yukuai3@huawei.com>
Cc: yunbolyu@smu.edu.sg,
	kexinsun@smail.nju.edu.cn,
	ratnadiraw@smu.edu.sg,
	xutong.ma@inria.fr,
	Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] bfq: update outdated comment
Date: Wed, 31 Dec 2025 18:01:17 +0100
Message-Id: <20251231170117.143488-1-Julia.Lawall@inria.fr>
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

