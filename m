Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6219476
	for <linux-block@vger.kernel.org>; Sat, 21 Feb 2026 00:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771634973; cv=none; b=PNo3UP37Qe90d3+caeYToOhCtkb76eQ6gUjsicG1ERj7QTj78XTCCWEoJ07FPXmMc/Bqk3icTXLkXH8YK9aenmzUfxnA11PHBr/P8FRA4cY2mjKljyLDfg8BIobw48jGdzUwlD47PvaHjSHyomQisoPU55Xvm4a4tyBQVaYtrBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771634973; c=relaxed/simple;
	bh=RVcIbL9yZwhjkDAyuYJFLBCcFOzxfu8D8i5JA3uSWvE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lE+jBPq8Q5ho2/UX60XZsvOgqZlwDdrykpjJwL8XMR79UtgdSZft7KlPM26r5ahYTCiL0zjgfKMFVInwKZO+hUQEP8HULosG7NvRV+W1L42Ra+GdwIS1OI8pl3AW0YBvYBNrO5TG8padsPyKiIqQh7lFsCUnX3wWBZRE2Zq9htU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rsLlxIq1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rsLlxIq1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A667AC116D0;
	Sat, 21 Feb 2026 00:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771634972;
	bh=RVcIbL9yZwhjkDAyuYJFLBCcFOzxfu8D8i5JA3uSWvE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=rsLlxIq1oEWZOy+MMUHE2Yc76bKabX1oS0UeXzbKB1oRy8T3mxRp/egMzQtA+ogxE
	 MRAyI8qV0pnuH6l8C2hJaPlG9DwAJTqqy/4C/MualcKR0nZ3i23gZsURZiI6IC4bHK
	 loTYUuPdCSBVnd32HQ9NP3txK+NC4eaZxopZ8I/6sb46jfSwqq1SO/YdIMTRcD91k8
	 KzIgn159E8bZJK26+bG0hH2Uz1dgUGuMB0lLnqkCF+H5yg70sqy7ryIPqY80g/yHEK
	 Si8+g7ihjpAkqvELfOMR9Dd89Bsq3QJ61is7zptPtt+pLt/bJegHH1E8+wxa4pQ7HT
	 twbSMtGrXMHDw==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: [PATCH 7/8] block: default to QD=1 writes for blk-mq rotational zoned devices
Date: Sat, 21 Feb 2026 09:44:10 +0900
Message-ID: <20260221004411.548482-8-dlemoal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260221004411.548482-1-dlemoal@kernel.org>
References: <20260221004411.548482-1-dlemoal@kernel.org>
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
---
 block/blk-sysfs.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 789802286d95..0e552b8f5bbd 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -963,6 +963,14 @@ int blk_register_queue(struct gendisk *disk)
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

