Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33CD1B4151;
	Tue, 18 Feb 2025 06:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739861965; cv=none; b=VD5b9BslEVxCDKTCiwoF8Kcna0THtbDYp5kWPLmEAE4y9ooUMQ4tM2hJMYQgnTD3zAJD4Hb3ZRBkZQno8gLCFH7E3+adMXSvlfZqdToQfaUSU+kQ4Xixc3ra6dLiNEe+U3Lv9NISOFJPRl1FFbaZWMytJu8QZjcKJaT6mFkmW5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739861965; c=relaxed/simple;
	bh=o2yCsGFeXQCVwDPR+JGPByG5v9wSd6DbNK+ZCKzMbEM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=U5upIghu0C4+eZ7V+hx6jm30LG18ggSfaCLtuqSNbpNA60X6ECf1RtdJG2l3DDn9swzDVRUK56b7mFkHvAojsxarnYYQx8khwAlipUTFuO4ngUWyChEpU7J2/TsuKCGp8WO9y2ENvWzCSt0zSv+Euib2O/bMiCTD2oRmeo2m0LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 51I6wjx2003135;
	Tue, 18 Feb 2025 14:58:45 +0800 (+08)
	(envelope-from zhaoyang.huang@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4YxqyB2Xzlz2SKBqR;
	Tue, 18 Feb 2025 14:54:26 +0800 (CST)
Received: from bj03382pcu01.spreadtrum.com (10.0.73.40) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Tue, 18 Feb 2025 14:58:43 +0800
From: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
To: Jens Axboe <axboe@kernel.dk>, Dan Schatzberg <schatzberg.dan@gmail.com>,
        Ming Lei <ming.lei@redhat.com>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, <steve.kang@unisoc.com>
Subject: [PATCH] Revert "driver: block: release the lo_work_lock before queue_work"
Date: Tue, 18 Feb 2025 14:58:35 +0800
Message-ID: <20250218065835.19503-1-zhaoyang.huang@unisoc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL:SHSQR01.spreadtrum.com 51I6wjx2003135

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

This reverts commit ad934fc1784802fd1408224474b25ee5289fadfc.

loop_queue_work should be strictly serialized to loop_process_work since
the lo_worker could be freed without noticing new work has been queued
again.

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
 drivers/block/loop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 68c943a77e41..c05fe27a96b6 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -894,8 +894,8 @@ static void loop_queue_work(struct loop_device *lo, struct loop_cmd *cmd)
 		cmd_list = &lo->rootcg_cmd_list;
 	}
 	list_add_tail(&cmd->list_entry, cmd_list);
-	spin_unlock_irq(&lo->lo_work_lock);
 	queue_work(lo->workqueue, work);
+	spin_unlock_irq(&lo->lo_work_lock);
 }
 
 static void loop_set_timer(struct loop_device *lo)
-- 
2.25.1

