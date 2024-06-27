Received: from mail.nearlyone.de (mail.nearlyone.de [49.12.199.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55A5195FE5;
	Thu, 27 Jun 2024 14:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.199.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719497485; cv=none; b=YN3QNo2Bb2b7pQkyPx7AnD0bh4iCSHG1I7XC1fQ+yE8GHK2NE2fSeYZ6YIPxx1eLB8KddU5BMfLCQgWG0PKV6knLvg7FtqBThJ/uq7mFJvXn6Ipb+j3bUahEsTdmk4GBT69RNjqjXhK+GAO8vpUrlL2XAHOijMUuGhJPT+wEOlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719497485; c=relaxed/simple;
	bh=T3rk+myDgRW7pdJOY82hO4pqzWsSBl7pZeCzlSfrwRQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uB6TeIPsAw3hI0pZMyEo7ft7BvfnKgcXAheS/CEpVsvCWYn3sxBBOjga7j6cfXrPWso19YkVc9OD4FK/VIUobPutGjDR7FUVRe/CXQP5jq7oqtWCrvNPZU8+hOcmjv6zN3N4LUtGFrRhj+Z8kA+ETJQWenMrqmwT9RemR+wBBx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=monom.org; dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b=vhoedez/; arc=none smtp.client-ip=49.12.199.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=monom.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b="vhoedez/"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 45051DAD93;
	Thu, 27 Jun 2024 16:11:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1719497475; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Z86U4HajwRS+bO9fhPagrSAmcb5268+tFSMExzGmM3o=;
	b=vhoedez/x0GFd/0rEH5rsJdieqerjH6UHFIrRcjRCRxqfcRKPh9Fq8MKRusQ5urg+qLQ+8
	Fs/vQBnrxo4ep5baTF6EvSh7Hj6jNvclgrmUszFuhXembG/ToiKQ6lAigcnpL8oSO/u11p
	CB4Wuy3Kng2lBtcOBULI1QaFHcriMvSBT1tSZ7xCl4D9zMa2RZlyMHerXWmlmDDJW4jVII
	yozcdDh7LJrSK8TiBrZj1b6K5s7VYKuyErE842emuSlBpj0rEsqrGFGr+Q3g6eGuiTGFeZ
	7tkFQbS8H6IkK4Ka2557R+BlSI/YT2ZqURHjqpwgCNCnPuaVEbgKs8TfbmcJQw==
From: Daniel Wagner <dwagner@suse.de>
Date: Thu, 27 Jun 2024 16:10:52 +0200
Subject: [PATCH v2 2/3] nvme-pci: limit queue count to housekeeping CPUs
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240627-isolcpus-io-queues-v2-2-26a32e3c4f75@suse.de>
References: <20240627-isolcpus-io-queues-v2-0-26a32e3c4f75@suse.de>
In-Reply-To: <20240627-isolcpus-io-queues-v2-0-26a32e3c4f75@suse.de>
To: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, 
 Sagi Grimberg <sagi@grimberg.me>, Thomas Gleixner <tglx@linutronix.de>, 
 Christoph Hellwig <hch@lst.de>
Cc: Frederic Weisbecker <fweisbecker@suse.com>, 
 Mel Gorman <mgorman@suse.de>, Hannes Reinecke <hare@suse.de>, 
 Sridhar Balaraman <sbalaraman@parallelwireless.com>, 
 "brookxu.cn" <brookxu.cn@gmail.com>, Ming Lei <ming.lei@redhat.com>, 
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-nvme@lists.infradead.org, Daniel Wagner <dwagner@suse.de>
X-Mailer: b4 0.14.0
X-Last-TLS-Session-Version: TLSv1.3

When isolcpus is used, the nvme-pci driver should only allocated queues
for the housekeeping CPUs. Use the blk_mq_num_possible_queues helper
which returns the correct number of queues for all configurations.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/host/pci.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 102a9fb0c65f..193144e6d59b 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -81,7 +81,7 @@ static int io_queue_count_set(const char *val, const struct kernel_param *kp)
 	int ret;
 
 	ret = kstrtouint(val, 10, &n);
-	if (ret != 0 || n > num_possible_cpus())
+	if (ret != 0 || n > blk_mq_num_possible_queues())
 		return -EINVAL;
 	return param_set_uint(val, kp);
 }
@@ -2263,7 +2263,8 @@ static unsigned int nvme_max_io_queues(struct nvme_dev *dev)
 	 */
 	if (dev->ctrl.quirks & NVME_QUIRK_SHARED_TAGS)
 		return 1;
-	return num_possible_cpus() + dev->nr_write_queues + dev->nr_poll_queues;
+	return blk_mq_num_possible_queues() + dev->nr_write_queues +
+		dev->nr_poll_queues;
 }
 
 static int nvme_setup_io_queues(struct nvme_dev *dev)

-- 
2.45.2

