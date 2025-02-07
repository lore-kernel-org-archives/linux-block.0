Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1161A4F12;
	Fri,  7 Feb 2025 09:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738920030; cv=none; b=NtnIsvDvBedT6hkmoUpPnshyTudyfO87TIH2hVolVHGKGoxuCzxT2pkAXi5mKiVV9qwSK0gAvXA5otX6ajx4ky5/rwUAqAv886GxLIXhmzSHCaSYnkpqxiliwJem3qxv9mSZaKuqW2jtgoIUQVPDjoaRw4pIqiO9z4fGX/ZpZI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738920030; c=relaxed/simple;
	bh=ASRMSmQH5zCH47zOAUGyjNKwpvP1MOiQYbU0gtvunE4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=c50wmPQK94ydIl1aTNzICIE1II8ryQMrdYfZMcNt1ZTuLzT3hlm9mTSN29HYjMY/cZwuyr5B7hk0DHiKMGGGlwaMdrVcm06i0z/bWxJp1o+g7OsW+8cH6Ynk5wIjoyrtLoi0hHKbaJYE/6/My95lU1SyQHouXSTq0A7boJ6aAOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from SHSQR01.spreadtrum.com (localhost [127.0.0.2] (may be forged))
	by SHSQR01.spreadtrum.com with ESMTP id 5179KMUq072842;
	Fri, 7 Feb 2025 17:20:22 +0800 (+08)
	(envelope-from zhaoyang.huang@unisoc.com)
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 5179Jvtj070927;
	Fri, 7 Feb 2025 17:19:57 +0800 (+08)
	(envelope-from zhaoyang.huang@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4Yq7cb5wYgz2P9pxx;
	Fri,  7 Feb 2025 17:15:59 +0800 (CST)
Received: from bj03382pcu01.spreadtrum.com (10.0.73.40) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Fri, 7 Feb 2025 17:19:55 +0800
From: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
To: Jens Axboe <axboe@kernel.dk>, Dan Schatzberg <schatzberg.dan@gmail.com>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Zhaoyang Huang
	<huangzhaoyang@gmail.com>, <steve.kang@unisoc.com>
Subject: [PATCH] driver: block: release the lo_work_lock before queue_work
Date: Fri, 7 Feb 2025 17:19:42 +0800
Message-ID: <20250207091942.3966756-1-zhaoyang.huang@unisoc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL:SHSQR01.spreadtrum.com 5179Jvtj070927

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

queue_work could spin on wq->cpu_pwq->pool->lock which could lead to
concurrent loop_process_work failed on lo_work_lock contention and
increase the request latency. Remove this combination by moving the
lock release ahead of queue_work.

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
 drivers/block/loop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 8f6761c27c68..33e31cd95953 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -890,8 +890,8 @@ static void loop_queue_work(struct loop_device *lo, struct loop_cmd *cmd)
 		cmd_list = &lo->rootcg_cmd_list;
 	}
 	list_add_tail(&cmd->list_entry, cmd_list);
-	queue_work(lo->workqueue, work);
 	spin_unlock_irq(&lo->lo_work_lock);
+	queue_work(lo->workqueue, work);
 }
 
 static void loop_set_timer(struct loop_device *lo)
-- 
2.25.1

