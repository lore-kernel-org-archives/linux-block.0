Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EBB8389DF0
	for <linux-block@vger.kernel.org>; Thu, 26 Feb 2026 04:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772079345; cv=none; b=kmo9QjBkiwZk8IhELZdOUGCrGD5Ncrr9lsiROpMVkMQYRKGhRgg99CgG1lPTAYGAxPh4PlerWrYOFipGstDxudGw2j/ffVZaI3Gu6Hvj0K1OZwT8SuQjWX3oVLZn2NiDOMD0uRhVEkmkL0Iou420kZp0dGYGz3UoGVvZUukBlBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772079345; c=relaxed/simple;
	bh=b3K/qoYhsYv+yui4jG4tZmAAvAN6Hqe9s9xBy/JBUXE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oRSCzL8+wh3D4Cx1LIY3JPGDJ13HKOthUR53qnuadJV/rnNmo9n9cw/K+36AZbNSi6B7zqvm/MA93cgu0QKDLAENHUp76enbj1xr0pZp0mKn+biFwn+CheMWQfiHIDUtqMm33o/QVQu7uq00ZrDaUfPPKipXgfmzZ2jmQxMKtEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a3YSOXR2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a3YSOXR2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A419FC116C6;
	Thu, 26 Feb 2026 04:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772079344;
	bh=b3K/qoYhsYv+yui4jG4tZmAAvAN6Hqe9s9xBy/JBUXE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=a3YSOXR23Z5r2nRrKLwwMlqDc/NC4R1dKiT+j5tS3/KI8/2lUPLcbK8z9NjzIBXW2
	 dMZ94Hxt6nsSpA3XGXLfCzqaHaHbVDf2l5H/3IIEbhs1DgjdExjH5A60+3qpu8qvhV
	 d5wuoDBQjGuoaN2BUm5YvzapgC1hhK8VHQ0+zHvfOi4urDT824xkrPsfQuV4x8P/kp
	 mj/3LBcl1ZSwzlguPhq8q2meuOGSiTcOujdC8qpEEkgzXbCsm9LECJ9d74IYdoI9/6
	 1UEjthrfphK5PsR6y7HFMZYPnu9aiFy1UDA/ISXQv7cHxwFB5p7aAbZXanJT0DZdJ1
	 ytrUSU3iBVt1g==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: [PATCH v2 6/7] block: default to QD=1 writes for blk-mq rotational zoned devices
Date: Thu, 26 Feb 2026 13:10:23 +0900
Message-ID: <20260226041024.2154806-7-dlemoal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260226041024.2154806-1-dlemoal@kernel.org>
References: <20260226041024.2154806-1-dlemoal@kernel.org>
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

