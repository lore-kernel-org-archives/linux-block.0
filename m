Received: from mail.nearlyone.de (mail.nearlyone.de [49.12.199.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0128DEAE6;
	Fri, 21 Jun 2024 13:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.199.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718978009; cv=none; b=s0tCAKVN8fadHf71zdd9nZwVdtWfFqnMFJgrDm6slVuPxvvIyCSz86keLVUmPYWFdVKsuGOyfc1pnPvENbd8e6/TkW7v0JjcxyDD14hcam93aKiqsxhX9tQWBgYPqQLImCAftnp5KUjj3wsAcCqd3u1asODLfTY9dAKYDWigsjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718978009; c=relaxed/simple;
	bh=R6ZXMQLW2392mw1CWus8FWrfEB8kPFv8wxHZAWrIAUE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NHGuIv+eUrQbAk0SXkegfG3qwyV05DoqWSbSxoTmqt5T7tdLpKaTIS2vxSKSaQcO6PpRasH0Gfc0EXbqtQDnti8Ic4+M3qX8mGA8Q7KNjn6eYYGA84sWNgMI89/4MEV1xUmv1MZD6EF9JbkhH6fOqkZaAMzBXYeYegdS5WQRUkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=monom.org; dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b=wK55wQp2; arc=none smtp.client-ip=49.12.199.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=monom.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b="wK55wQp2"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6A9BEDACCF;
	Fri, 21 Jun 2024 15:53:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1718977998; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=C6O9bd6qH5NJhHxs+s6bVDs7oMyZxsTsvkh10LQsbwo=;
	b=wK55wQp2bh6vEvia14MR8WNy5Sb3v3eUhWBkstK0zV+5PQk11ucrBzNqP9hX+ZZ6obZMkL
	3TkJAHBPknD/3rGcIKmlS1/y0psXMqN8xHOM99ybENVpCpLrlL0ivlsck2qGz2FD4mWSos
	iXIAPvMW20+4YOVhtKEJxjcTinX1KuXwdWyEEQHqnPPcg5DAWOatgpKLHchV2pK8deAENO
	UsjyR7G3d0buTDXvovkg6UM6yMpVrnJO0hmZEfDX9jRk6cisL/4tOvAhlSBB/daWAKn/6n
	04Y36RIehL+P5D9otiSe1EVnSUL9sDTzF1cHhyviYSz8+AD3iftynNLDaNKqrA==
From: Daniel Wagner <dwagner@suse.de>
Date: Fri, 21 Jun 2024 15:53:10 +0200
Subject: [PATCH 1/3] sched/isolation: Add io_queue housekeeping option
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240621-isolcpus-io-queues-v1-1-8b169bf41083@suse.de>
References: <20240621-isolcpus-io-queues-v1-0-8b169bf41083@suse.de>
In-Reply-To: <20240621-isolcpus-io-queues-v1-0-8b169bf41083@suse.de>
To: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, 
 Sagi Grimberg <sagi@grimberg.me>, Thomas Gleixner <tglx@linutronix.de>, 
 Christoph Hellwig <hch@lst.de>
Cc: Frederic Weisbecker <fweisbecker@suse.com>, 
 Mel Gorman <mgorman@suse.de>, Hannes Reinecke <hare@suse.de>, 
 Sridhar Balaraman <sbalaraman@parallelwireless.com>, 
 "brookxu.cn" <brookxu.cn@gmail.com>, Ming Lei <ming.lei@redhat.com>, 
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-nvme@lists.infradead.org, Daniel Wagner <dwagner@suse.de>
X-Mailer: b4 0.13.0
X-Last-TLS-Session-Version: TLSv1.3

Drivers such as nvme-pci are spreading the IO queues on all CPUs. This
is not necessary an invalid setup when using isolcpus but there are also
users of isolcpus which do not want to have any IO workload on the
isolated CPUs.

Add a new house keeping type so the infrastructure code and drivers are
able to distinguish between the two setups.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 include/linux/sched/isolation.h | 1 +
 kernel/sched/isolation.c        | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
index 2b461129d1fa..fe751d704e99 100644
--- a/include/linux/sched/isolation.h
+++ b/include/linux/sched/isolation.h
@@ -16,6 +16,7 @@ enum hk_type {
 	HK_TYPE_WQ,
 	HK_TYPE_MANAGED_IRQ,
 	HK_TYPE_KTHREAD,
+	HK_TYPE_IO_QUEUE,
 	HK_TYPE_MAX
 };
 
diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index 5891e715f00d..91d7a434330c 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -18,6 +18,7 @@ enum hk_flags {
 	HK_FLAG_WQ		= BIT(HK_TYPE_WQ),
 	HK_FLAG_MANAGED_IRQ	= BIT(HK_TYPE_MANAGED_IRQ),
 	HK_FLAG_KTHREAD		= BIT(HK_TYPE_KTHREAD),
+	HK_FLAG_IO_QUEUE	= BIT(HK_TYPE_IO_QUEUE),
 };
 
 DEFINE_STATIC_KEY_FALSE(housekeeping_overridden);
@@ -228,6 +229,12 @@ static int __init housekeeping_isolcpus_setup(char *str)
 			continue;
 		}
 
+		if (!strncmp(str, "io_queue,", 9)) {
+			str += 9;
+			flags |= HK_FLAG_IO_QUEUE;
+			continue;
+		}
+
 		/*
 		 * Skip unknown sub-parameter and validate that it is not
 		 * containing an invalid character.

-- 
2.45.2

