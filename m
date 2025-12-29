Received: from smtp.smtpout.orange.fr (smtp-28.smtpout.orange.fr [80.12.242.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC8E2D063E;
	Mon, 29 Dec 2025 10:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767004522; cv=none; b=jpcjsQ1D0XUUz04NFFKUBdih4Ht9Hh2Y/gi6Mcd9WkDHsMcw6qMSHY+av4/jaJBJURZIieSykIXv5Az91fUY8DWwUF2TmadqnQDIXZ3hmFPCICjJA6A5n0JUc/k4Vzbf85jTFce9e/6JjP8SwWiemFd3BucQqwtDSQ5kZaP9uDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767004522; c=relaxed/simple;
	bh=Wo7p7ip3CpXtlYg4RuaLG6bpeE3hxYDZr/0NE4kJGys=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZyIKM6Lt5iM/7sJ0XB7VvkTXPuGnMZa0p5OvFWftNVzRz+mPb3ZanheUlSW3ujaVT3VL0Z+j7A3V2DFyzZtdXSDZGOgpIoCBAnIRPF3iCEh4ppnC1Iuc7CiiLtpauv1AnQl2TocVOtnLW2JN+xF08g0im1B2rtf0fWopNsRFVIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=rIptRoRd; arc=none smtp.client-ip=80.12.242.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="rIptRoRd"
Received: from fedora.home ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPA
	id aAS2vcdqhY9keaAS2v4Rqm; Mon, 29 Dec 2025 11:26:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1767003971;
	bh=+m1I45rQxNviHo8GSCe2W6TJE8XDrQr4PToj1CVy9n8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=rIptRoRdeRwEkpjTNOjDvWqxvXGNLWlcoSD5jmnY2ptDm9BxEoUksPXnmnHppIc1P
	 x27BNDl7iuZLVl9BVpio/rS9gHtwo1HpZviub4UxeJOU0eoaN/KFnxipj3NlDjErqp
	 650g+cfBQ0mdRiSYHdazEvIUd1Yr0AGrEGVRPoDWP/GKNtZQpZ2bBTGjppcjuvYMpi
	 nPTMV4y89UNRSLvsbebHTB44H5aKuu5qfukzHzc+ohdXJa6L1JJjyvsHZ3mFEXN4zl
	 ayzfGkIHhbiP/W4U87SGsc6KWfPVu4vA+4pfHOBsmS1EkGCslNHv7ZI8DZUNA5RD+w
	 AMPF4ESQ/VNbw==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 29 Dec 2025 11:26:11 +0100
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-block@vger.kernel.org
Subject: [PATCH] null_blk: Constify struct configfs_item_operations and configfs_group_operations
Date: Mon, 29 Dec 2025 11:26:07 +0100
Message-ID: <71cd74099b2b8ab7b153b2ea15b53944189d014b.1767003948.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'struct configfs_item_operations' and 'configfs_group_operations' are not
modified in this driver.

Constifying these structures moves some data to a read-only section, so
increases overall security, especially when the structure holds some
function pointers.

On a x86_64, with allmodconfig:
Before:
======
   text	   data	    bss	    dec	    hex	filename
 100263	  37808	   2752	 140823	  22617	drivers/block/null_blk/main.o

After:
=====
   text	   data	    bss	    dec	    hex	filename
 100423	  37648	   2752	 140823	  22617	drivers/block/null_blk/main.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only.

This change is possible since commits f2f36500a63b and f7f78098690d.
---
 drivers/block/null_blk/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index c7c0fb79a6bf..29a371f48b57 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -642,7 +642,7 @@ static void nullb_device_release(struct config_item *item)
 	null_free_dev(dev);
 }
 
-static struct configfs_item_operations nullb_device_ops = {
+static const struct configfs_item_operations nullb_device_ops = {
 	.release	= nullb_device_release,
 };
 
@@ -739,7 +739,7 @@ static struct configfs_attribute *nullb_group_attrs[] = {
 	NULL,
 };
 
-static struct configfs_group_operations nullb_group_ops = {
+static const struct configfs_group_operations nullb_group_ops = {
 	.make_group	= nullb_group_make_group,
 	.drop_item	= nullb_group_drop_item,
 };
-- 
2.52.0

