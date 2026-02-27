Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B7824887E
	for <linux-block@vger.kernel.org>; Fri, 27 Feb 2026 13:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772198712; cv=none; b=kEjGRf7B7RKqS0p+luSOfi3uS6dpw1mi9nTG7pFW/jF6svUVobDXMqWD4rz+ZVL27ne1BItw7+zLU/XSugsQ5SnWxgfcsnF1Qf88SLL6Ly7rxPcbS4UzsE+j8cpBLQoUSICGydR59AsiHcXx71yu0AgH/mv5LMuzHNZL/igSUlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772198712; c=relaxed/simple;
	bh=IX2NuZrOcaGSDEdHTFw9XqWFjcfHXn6IuL4+Z6OKG2Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L9gv6b7J4rtrw+vsO7OZ8hUqL+HKzl8s0Ud8bIkVDRlqwNb7wGd9B5fJgVQA5kQGc3G+746DIE/iZrfRWJw5VQQO7x/X1jOpb7bgq4BTth6CzQ1dQ++pzakoHivawsXwFgeEPqz8duwyjnLrr8Cj02o4noSjHdDC1FMpXktAoDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WD+f03FI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WD+f03FI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1895BC116C6;
	Fri, 27 Feb 2026 13:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772198712;
	bh=IX2NuZrOcaGSDEdHTFw9XqWFjcfHXn6IuL4+Z6OKG2Q=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=WD+f03FIiPqHCk/l2mFR/7mijkmyPC+XNmx1qWvLJRa6EQuIkinRGaXP53A+uqQIm
	 MUhJnONCzwXVzeOllJ/zfnUi8OGneiT9vEPcHQFjYtw4omhCl1bbhYaWFXj3fcAC96
	 4Jqb7fHkxxyqhdq7nted6kc3TQB5DKCtFjGJlj4h1mfKym465FkoGsaRLYkGLMvHcB
	 pptQ5ildCcafD5rIqUGfBo1ad7M4Ww6Em/3F7d6orf31c61EBAryox/n4TCDrNMq6N
	 d1RQhIliRan/ms8IEWUSbF1hcdZRDnWZSqN7D2kciA54jMkhKAC3mxhjGYG7yhotAq
	 0Dglv4M98XldQ==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: [PATCH v4 7/8] block: default to QD=1 writes for blk-mq rotational zoned devices
Date: Fri, 27 Feb 2026 22:19:50 +0900
Message-ID: <20260227131951.2464150-8-dlemoal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260227131951.2464150-1-dlemoal@kernel.org>
References: <20260227131951.2464150-1-dlemoal@kernel.org>
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
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 block/blk-sysfs.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index ec8f9ccd86c4..c17993f641e5 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -961,6 +961,14 @@ int blk_register_queue(struct gendisk *disk)
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

