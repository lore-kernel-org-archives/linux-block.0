Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB8C268C42;
	Fri, 10 Oct 2025 02:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760063322; cv=none; b=K0rvQchN8n9UDpP2da427Gg61aijrhzrQMKKNWO6A/NF0FzBopSjbVAe51z2tcVZ0KxrPFUWTnl2PsQmX+Tp4KJIiy48YjnYyYlGEIPZE1pAAxXbW0kNr1dt1umdQ0OFHGTl7PWBjLWDAhkcj+eAiqrf0bACoIsUgTqTc1JmDLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760063322; c=relaxed/simple;
	bh=FK9xKviTcI/C/LX0yN/JGLOVejrI+c9f1E6gl9PnytQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gtPum16gswonQPC3YSA3KWLoS4peJmd/EZZEJ5Tk0j64cvn+mQKTC01Sck4D3jLqJDVMEoyOlJzUQGSymYpTmxz32s1eQRYp8SarLpnsILKBUKwEkukiFyApQe4w3bWr0E7BAbUeBiRWBs3E1TJzmaGisLOV3z9BXRDkSWWzP2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bndp/sPY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bndp/sPY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED887C4CEF7;
	Fri, 10 Oct 2025 02:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760063322;
	bh=FK9xKviTcI/C/LX0yN/JGLOVejrI+c9f1E6gl9PnytQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Bndp/sPYydcCNDbqrXtjVXk/W675XXogzGiv+wYQO7RUr4O7Qb323sK7694qpUdEB
	 j5Wmyok32ASruvnzXq2Wju1+WutiK3Ql+cvY9VIgTVJ0fSOggPEiK2pOUL2LnZrGXP
	 7MV0NvitQ8m8fJYIVrQHQCcSbwmVP5PJqlMGkaWVb0ptGQRoafeCgF7qyLELfyXdD9
	 mGDKGey91KwMJTKM21onErVPUAVbS/Cke52c6KzTNY0IR6A74dHjFVE2Z6RxKzuR9R
	 1EmjpsdWk6l62UzbYDrcD7uHVguKiwM9BwNkgf9sSoM3Kxohizt46BF2+kVK5eyAy1
	 QeYbPuk8Cz35Q==
From: Yu Kuai <yukuai@kernel.org>
To: axboe@kernel.dk,
	bvanassche@acm.org,
	nilay@linux.ibm.com
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai3@huawei.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	johnny.chenyi@huawei.com
Subject: [PATCH v3 7/7] blk-mq: add documentation for new queue attribute async_dpeth
Date: Fri, 10 Oct 2025 10:28:09 +0800
Message-ID: <20251010022812.2985286-8-yukuai@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010022812.2985286-1-yukuai@kernel.org>
References: <20251010022812.2985286-1-yukuai@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Yu Kuai <yukuai3@huawei.com>

Explain the attribute and the default value in different case.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
---
 Documentation/ABI/stable/sysfs-block | 34 ++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/Documentation/ABI/stable/sysfs-block b/Documentation/ABI/stable/sysfs-block
index 0ed10aeff86b..aa1e94169666 100644
--- a/Documentation/ABI/stable/sysfs-block
+++ b/Documentation/ABI/stable/sysfs-block
@@ -609,6 +609,40 @@ Description:
 		enabled, and whether tags are shared.
 
 
+What:		/sys/block/<disk>/queue/async_depth
+Date:		August 2025
+Contact:	linux-block@vger.kernel.org
+Description:
+		[RW] Controls how many asynchronous requests may be allocated in the
+		block layer. The value is always capped at nr_requests.
+
+		When no elevator is active (none):
+		- async_depth is always equal to nr_requests.
+
+		For bfq scheduler:
+		- By default, async_depth is set to 75% of nr_requests.
+		  Internal limits are then derived from this value:
+		  * Sync writes: limited to async_depth (≈75% of nr_requests).
+		  * Async I/O: limited to ~2/3 of async_depth (≈50% of nr_requests).
+
+		  If a bfq_queue is weight-raised:
+		  * Sync writes: limited to ~1/2 of async_depth (≈37% of nr_requests).
+		  * Async I/O: limited to ~1/4 of async_depth (≈18% of nr_requests).
+
+		- If the user writes a custom value to async_depth, BFQ will recompute
+		  these limits proportionally based on the new value.
+
+		For Kyber:
+		- By default async_depth is set to 75% of nr_requests.
+		- If the user writes a custom value to async_depth, then it override the
+		  default and directly control the limit for writes and async I/O.
+
+		For mq-deadline:
+		- By default async_depth is set to nr_requests.
+		- If the user writes a custom value to async_depth, then it override the
+		  default and directly control the limit for writes and async I/O.
+
+
 What:		/sys/block/<disk>/queue/nr_zones
 Date:		November 2018
 Contact:	Damien Le Moal <damien.lemoal@wdc.com>
-- 
2.51.0

