Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E3E172798;
	Fri, 16 Aug 2024 10:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723802462; cv=none; b=neoRZIPgRDjpApb29XTx4JF1PYTwKZ+6/PETbiS4L7YH041OMxhqvKBaN6KiRKzVnXmoMBVSZw9DYYXde8LSP/WFaeuBGw3S00+WZRRdlcBcOZCpIkvYhnho9nwbQOSfFoaE3uDG1trizsaSF8l1g1r1+/O+sb1WHr6dYFTNqkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723802462; c=relaxed/simple;
	bh=jhn/3PFIu/sI8ZqDElJwN4EJD5hMsgcnSky07m468ds=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pz620CS9DRdDObgm6FsC+HLBkpMb6MhL/2DSrgGCi8ng3mlpyl0yd4mj8WvUIDXIWLCb4OiiAaFVBwYm04QPGF5Ck3onvCf+o4q0C/Mz6lv7TH8KsA9c+fQYRKh8tQK4SgspcVuzK0GjbU8tP+ZirZf2fZLSXjh8T1ci5N9KbOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Wlcs53p1hz1xv9n;
	Fri, 16 Aug 2024 17:59:05 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id CD2F514040F;
	Fri, 16 Aug 2024 18:00:57 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 16 Aug
 2024 18:00:57 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<yuehaibing@huawei.com>
Subject: [PATCH -next] blk-cgroup: Remove unused declaration blkg_path()
Date: Fri, 16 Aug 2024 17:58:21 +0800
Message-ID: <20240816095821.877842-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemf500002.china.huawei.com (7.185.36.57)

Commit bb7e5a193d8b ("block, bfq: remove blkg_path()") removed the
implementation but leave declaration.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 block/blk-cgroup.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/blk-cgroup.h b/block/blk-cgroup.h
index 864fad4a850b..b9e3265c1eb3 100644
--- a/block/blk-cgroup.h
+++ b/block/blk-cgroup.h
@@ -485,7 +485,6 @@ static inline void blkcg_deactivate_policy(struct gendisk *disk,
 static inline struct blkg_policy_data *blkg_to_pd(struct blkcg_gq *blkg,
 						  struct blkcg_policy *pol) { return NULL; }
 static inline struct blkcg_gq *pd_to_blkg(struct blkg_policy_data *pd) { return NULL; }
-static inline char *blkg_path(struct blkcg_gq *blkg) { return NULL; }
 static inline void blkg_get(struct blkcg_gq *blkg) { }
 static inline void blkg_put(struct blkcg_gq *blkg) { }
 static inline void blkcg_bio_issue_init(struct bio *bio) { }
-- 
2.34.1

