Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F70370D65;
	Mon, 16 Mar 2026 22:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773701043; cv=none; b=T2KFW9MXT/JUQS1n60Ev3PfIjMvU/Ukgp7L7a47iP2Ydzs22QyMrzEPkO0LNGqCNpZQO0fXDmNHB8HgqQWO9GIcg+/aU2qaXDrnyjYEHb+luFfjfo5kDOK9qnmhoN9DPPw5/g960ypj/3TeqgSxZ1QtFG0YrsCbnqIjerYkqEcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773701043; c=relaxed/simple;
	bh=j43NpdFFoV5b7UfTX0D30Ii6QNhkybdddNhDpCfWyus=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=imeg/qmUnrXWINhB4acnowPPTHtojnysuJ1VEKi9BcWbFuy4rX9Eo/ZnpxpIcZZYDtlvNrwW//MNk+y/rzuvvQO35HNOQnq8/ipoB668w3G+B23SY/ZqytP9jpsku14jGcL34+L9r14ciZMRDVTvLV/bInWkr7h+uulHoJ7IvWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=QnICkvO0; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="QnICkvO0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1773701039;
	bh=j43NpdFFoV5b7UfTX0D30Ii6QNhkybdddNhDpCfWyus=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QnICkvO0HgLCAGROOf0KNebIR+/uNw2AyjQ9hc5szrX6nXcKfogrbK7xBA3ucFwt7
	 vf16sunXp0Jc5e+QtvBavg0W4/4ZPYWDKU2mkgPKzhKVON42wEGisSijXNPQ4+yYGn
	 qMc8zGfoAJO4iZTGnISBceVUKh/rvRI52PqC2D4M=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 16 Mar 2026 23:43:54 +0100
Subject: [PATCH 4/4] blk-mq: make blk_mq_hw_ctx_sysfs_entry instances const
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260316-b4-sysfs-const-attr-block-v1-4-a35d73b986b0@weissschuh.net>
References: <20260316-b4-sysfs-const-attr-block-v1-0-a35d73b986b0@weissschuh.net>
In-Reply-To: <20260316-b4-sysfs-const-attr-block-v1-0-a35d73b986b0@weissschuh.net>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773701039; l=1869;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=j43NpdFFoV5b7UfTX0D30Ii6QNhkybdddNhDpCfWyus=;
 b=hhfbuWifdtgtiuZzwcP1exhd0XBCkiH89balOlvdDXjRB+JPEt4mJ296/EnoqZC2gsP9ZhiSE
 R4x7JRjxvkcCK4C/jNZQ/Ml0LDxHyS8WeM5+bhONsZ9NjcI6hsp9y3V
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The blk_mq_hw_ctx_sysfs_entry structures are never modified,
mark them as const.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 block/blk-mq-sysfs.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
index 58ec293373c6..895397831ecc 100644
--- a/block/blk-mq-sysfs.c
+++ b/block/blk-mq-sysfs.c
@@ -53,7 +53,7 @@ static ssize_t blk_mq_hw_sysfs_show(struct kobject *kobj,
 	struct request_queue *q;
 	ssize_t res;
 
-	entry = container_of(attr, struct blk_mq_hw_ctx_sysfs_entry, attr);
+	entry = container_of_const(attr, struct blk_mq_hw_ctx_sysfs_entry, attr);
 	hctx = container_of(kobj, struct blk_mq_hw_ctx, kobj);
 	q = hctx->queue;
 
@@ -101,20 +101,20 @@ static ssize_t blk_mq_hw_sysfs_cpus_show(struct blk_mq_hw_ctx *hctx, char *page)
 	return pos + ret;
 }
 
-static struct blk_mq_hw_ctx_sysfs_entry blk_mq_hw_sysfs_nr_tags = {
+static const struct blk_mq_hw_ctx_sysfs_entry blk_mq_hw_sysfs_nr_tags = {
 	.attr = {.name = "nr_tags", .mode = 0444 },
 	.show = blk_mq_hw_sysfs_nr_tags_show,
 };
-static struct blk_mq_hw_ctx_sysfs_entry blk_mq_hw_sysfs_nr_reserved_tags = {
+static const struct blk_mq_hw_ctx_sysfs_entry blk_mq_hw_sysfs_nr_reserved_tags = {
 	.attr = {.name = "nr_reserved_tags", .mode = 0444 },
 	.show = blk_mq_hw_sysfs_nr_reserved_tags_show,
 };
-static struct blk_mq_hw_ctx_sysfs_entry blk_mq_hw_sysfs_cpus = {
+static const struct blk_mq_hw_ctx_sysfs_entry blk_mq_hw_sysfs_cpus = {
 	.attr = {.name = "cpu_list", .mode = 0444 },
 	.show = blk_mq_hw_sysfs_cpus_show,
 };
 
-static struct attribute *default_hw_ctx_attrs[] = {
+static const struct attribute *const default_hw_ctx_attrs[] = {
 	&blk_mq_hw_sysfs_nr_tags.attr,
 	&blk_mq_hw_sysfs_nr_reserved_tags.attr,
 	&blk_mq_hw_sysfs_cpus.attr,

-- 
2.53.0

