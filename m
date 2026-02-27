Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA50129E11D
	for <linux-block@vger.kernel.org>; Fri, 27 Feb 2026 01:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772157311; cv=none; b=fjAnfwHbjaxQwT9UREyHlnLIVMvu1MPWfIOJ2Sidhm8pXBSTShpRcJyEmyzI+PGbyIQwr6SFimvJw40Smu6g5DOVfuqkK36Ww9DB6yzrvllsLLvhPHtuArih+QKn5ZYMp1ms4BlVyD8qEXLUgILLMZyVV8O+qJbmnAhckQ6hWVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772157311; c=relaxed/simple;
	bh=GMFWNShs/ijwErAgjqovTzo2GfoBYce6yMLBV90Ruh0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rGHv/Y672MP09Wqx9NrRskVeabcuhGnkPjtZBNVrYzpvSvibEBYsyZHzlcN379xUGifYEOcPqhNV8KvMpus1CjnYOGpAu1mpU/OOEzOlTBSn35UtUCbwtP6Zl+8Oa9FbOMXllcAxhQwEVJpJ7ofpG1SV0SA/aNYn4RqWqBRl8XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xdihkn0v; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xdihkn0v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C5C1C2BC86;
	Fri, 27 Feb 2026 01:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772157311;
	bh=GMFWNShs/ijwErAgjqovTzo2GfoBYce6yMLBV90Ruh0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Xdihkn0vwyLikORoTh0W/o4xPAb+wk5j9SY9VGwQ+EjQQizziTIWbcGyxPWzmjc/C
	 PwGUHsDnRkHgfEui3OpC+7pzA4ZI87HAsE/OlIZsF7rzdnnS/cvda8j9RCnKGHZ2Tb
	 y+1TYGPj7YzMEz4ifaJXwwG+dCzUDz4bTq16zgAG0YbYeboWRGqQMXRWMkTiznFE8o
	 ofc54IsyngfSfMClcAh9qIts4VXehVxpsnNc77eYDpz8t2N/ymeVLvqkE2lElFR1j1
	 LU52+daRwUF031zdvoHqm46T1QPnpDXxzWELRlFG/M2v4PN6hEKNkmkDdNj1I7Yl0/
	 px2IXtcKkXKNQ==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: [PATCH v3 7/8] block: default to QD=1 writes for blk-mq rotational zoned devices
Date: Fri, 27 Feb 2026 10:49:50 +0900
Message-ID: <20260227014951.2327711-8-dlemoal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260227014951.2327711-1-dlemoal@kernel.org>
References: <20260227014951.2327711-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For blk-mq rotational zoned block devices (e.g. SMR HDDs), default to
having zone write plugging limit write operations to a maximum queue
depth of 1 for all zones. This significantly reduce write seek overhead
and improves SMR HDD write throughput.

For remotely connected disks with a very high network latency this
features might not be useful. However, remotely connected zoned devices
are rare at the moment, and we cannot know the round trip latency to
pick a good default for network attached devices. System administrators
can however disable this feature in that case.

For BIO based (non blk-mq) rotational zoned block devices, the device
driver (e.g. a DM target driver) can directly set an appropriate
default.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-sysfs.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index bfa2ab82cc55..a92513bfbdfc 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -964,6 +964,14 @@ int blk_register_queue(struct gendisk *disk)
 		blk_mq_debugfs_register(q);
 	blk_debugfs_unlock(q, memflags);
 
+	/*
+	 * For blk-mq rotational zoned devices, default to using QD=1
+	 * writes. For non-mq rotational zoned devices, the device driver can
+	 * set an appropriate default.
+	 */
+	if (queue_is_mq(q) && blk_queue_rot(q) && blk_queue_is_zoned(q))
+		blk_queue_flag_set(QUEUE_FLAG_ZONED_QD1_WRITES, q);
+
 	ret = disk_register_independent_access_ranges(disk);
 	if (ret)
 		goto out_debugfs_remove;
-- 
2.53.0

