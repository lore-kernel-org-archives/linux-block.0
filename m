Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA0518FDB2;
	Thu,  2 Jan 2025 12:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735819305; cv=none; b=RmV8bn6FyhNXXNvOgeLzgF92yd52LAdj62rwIKdXAfi+X7eQMNGz+A+G45ElM3KaYfpOHKq9XlTrIauIccYt/9t+LThAwxnCfl7UamSgalhgNms8HI3XUcWVGkQQGXBTF0MIXOySxLtGypzya7Ix0UPtUn0XfTqaEa28zYxjiuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735819305; c=relaxed/simple;
	bh=WD60vvlaO/9NSCYrqpuUaM1VdxoLzNlEclK2oVJ1JRU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jp7UY0Bg9zsQhJ48Y8eAJIguqh+w7fw/CKBBkgZjtsEQruf6DCm7cCT7UhJUjjUf5CLt3JU2gvxnof5a8HMRZv5ocfFWcL3IUOFaVTnGq9EpElx2eFViTDhqOGMA6MDyEKZAJY3YdZjii3qlQxG9no7HY7fXa3Jg7xOa9zqN6AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=BiIGgS+d; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="BiIGgS+d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1735819292;
	bh=WD60vvlaO/9NSCYrqpuUaM1VdxoLzNlEclK2oVJ1JRU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BiIGgS+diHCuNJ7//XzQcm1PB6fIUnTB3R/q6v6KtK7CRp7mApiPXvp5WqpSWfq9N
	 Q8ccqlv6zLQ52cEV+rJLGXOUPML81DWsYbuBcJ++d6X/JNu3TJlhluW8J8bA0cBPIc
	 8XWK7hPwsMGfshLjsNHOeCY96HY6usKrOhL0xRL0=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Thu, 02 Jan 2025 13:01:32 +0100
Subject: [PATCH 2/4] block: mq-deadline: Constify sysfs attributes
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250102-sysfs-const-attr-elevator-v1-2-9837d2058c60@weissschuh.net>
References: <20250102-sysfs-const-attr-elevator-v1-0-9837d2058c60@weissschuh.net>
In-Reply-To: <20250102-sysfs-const-attr-elevator-v1-0-9837d2058c60@weissschuh.net>
To: Jens Axboe <axboe@kernel.dk>, Yu Kuai <yukuai3@huawei.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1735819292; l=920;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=WD60vvlaO/9NSCYrqpuUaM1VdxoLzNlEclK2oVJ1JRU=;
 b=XvBzdSqltsivaV+Pk7hf+KvhH0z2/9FqCGJ+KZ1eNUxSr8oJGwFtJynvG8Q1IrIE/VNLlvIpB
 Xq+j5nXxhI3CmNUL4Oa/EsnZ8xmZNg9uKgFf/Nn/tkjDDWc3WcSf8UF
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The elevator core now allows instances of 'struct elv_fs_entry' to be
moved into read-only memory. Make use of that to protect them against
accidental or malicious modifications.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 block/mq-deadline.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 5528347b5fcfca3d5bda443f9a116e29b95dd0c1..754f6b7415cdce0a3af60545731a1f2ec525d2e6 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -834,7 +834,7 @@ STORE_INT(deadline_fifo_batch_store, &dd->fifo_batch, 0, INT_MAX);
 #define DD_ATTR(name) \
 	__ATTR(name, 0644, deadline_##name##_show, deadline_##name##_store)
 
-static struct elv_fs_entry deadline_attrs[] = {
+static const struct elv_fs_entry deadline_attrs[] = {
 	DD_ATTR(read_expire),
 	DD_ATTR(write_expire),
 	DD_ATTR(writes_starved),

-- 
2.47.1

