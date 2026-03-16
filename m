Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995032874FA;
	Mon, 16 Mar 2026 22:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773701042; cv=none; b=WAHTfh3jLCN6xYS/pHW8zUNyYKRlvB4j/RowBhy0qIc2SkDvvve8RAYU/Nz8UmjfGpv0PDJEkg7M4Nd/9gub9hZtyI1Gnm3mWvT9g4a/VX92MjoDux4JdFlfIEXrE/Q6JSYSu0TfaqZuFx3i+JYadeTDO0G0gkZg6ga5CG14244=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773701042; c=relaxed/simple;
	bh=YQU1ECK7cC/rI7Us3XGfwIRmQYUOjZYw/POtMje1mDs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YDSYwFRyz9qJObE7ObxnQNBYIA1s1AQnHjeh5/qJ5LhMKr1vPIFKIdTU11UQlrOphKOe14UpOXKwYD9Ib5lCOe0pLe+gkpevsyzVfq3gTFEa5y5Hz5pgl07052/wX2QgWwOeyywep1+MyrbiEF0AKSrQdhodMEzfL3ks7Ljdf/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=VxPhT3Qw; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="VxPhT3Qw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1773701039;
	bh=YQU1ECK7cC/rI7Us3XGfwIRmQYUOjZYw/POtMje1mDs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VxPhT3Qw2h/WiZLYVmznwLk9BCiXgsLuHa6z58ie4Fr5T4IMy0nahEXqLesc0+x0s
	 7UvDIHsk/JSEBXdtqF4drMd7aLX9GYUICfsk38UzleucTusXbcmSMRx/CfarX/RDVB
	 aAv2e6n8sTDjggrehxYAD4YCAgOkPNHBxuZJCGBE=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 16 Mar 2026 23:43:52 +0100
Subject: [PATCH 2/4] block: ia-ranges: make blk_ia_range_sysfs_entry
 instances const
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260316-b4-sysfs-const-attr-block-v1-2-a35d73b986b0@weissschuh.net>
References: <20260316-b4-sysfs-const-attr-block-v1-0-a35d73b986b0@weissschuh.net>
In-Reply-To: <20260316-b4-sysfs-const-attr-block-v1-0-a35d73b986b0@weissschuh.net>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773701039; l=1240;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=YQU1ECK7cC/rI7Us3XGfwIRmQYUOjZYw/POtMje1mDs=;
 b=cqgpvIf+I+/qOmtUAml0035t431AOBy8i3si3RvDNxXZpWz5HL6yZrcs2tTiFmo+sggkcSWmS
 Arf8ab8Kpc4BcWlrOHNkUFeYsAAydjC8xr6riskpnmDY6aGCY/hq9mt
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The blk_ia_range_sysfs_entry structures are never modified,
mark them as const.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 block/blk-ia-ranges.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/blk-ia-ranges.c b/block/blk-ia-ranges.c
index d479f5481b66..7be8b58893c9 100644
--- a/block/blk-ia-ranges.c
+++ b/block/blk-ia-ranges.c
@@ -30,17 +30,17 @@ struct blk_ia_range_sysfs_entry {
 	ssize_t (*show)(struct blk_independent_access_range *iar, char *buf);
 };
 
-static struct blk_ia_range_sysfs_entry blk_ia_range_sector_entry = {
+static const struct blk_ia_range_sysfs_entry blk_ia_range_sector_entry = {
 	.attr = { .name = "sector", .mode = 0444 },
 	.show = blk_ia_range_sector_show,
 };
 
-static struct blk_ia_range_sysfs_entry blk_ia_range_nr_sectors_entry = {
+static const struct blk_ia_range_sysfs_entry blk_ia_range_nr_sectors_entry = {
 	.attr = { .name = "nr_sectors", .mode = 0444 },
 	.show = blk_ia_range_nr_sectors_show,
 };
 
-static struct attribute *blk_ia_range_attrs[] = {
+static const struct attribute *const blk_ia_range_attrs[] = {
 	&blk_ia_range_sector_entry.attr,
 	&blk_ia_range_nr_sectors_entry.attr,
 	NULL,

-- 
2.53.0

