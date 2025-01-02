Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B968405F7;
	Thu,  2 Jan 2025 12:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735819304; cv=none; b=rZOWOI+/79JehMzS5TGphhafGKmhwrkK5ZL9I0o7AzgQ5rTFCBOefTl10E6Ce7FuQM3QyklDA74hGjsHG02F8muc9dlQNNeCwlZFr8Gz1crGVMhXhKk74cOGCxmoNvUaN7eV808EVbol21NmtAM5FNMdSZx4OtzctadYYZZWcHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735819304; c=relaxed/simple;
	bh=odFRxWYpeapXxCpd6HffuzlvvZGINR1nCzZoPhfea30=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B6hB0GDvgH5eM2vATWO8tjiL6Suf37zbpGH9S1goPY7h5WYy5T6+y0i9WCnAzzb0qWPdNAR3djJLd76yPFmHL8imCOeRRa5xE6g9rWJy9OUkepWjzFqGmH8hSUI/duxBg6OupC5nTLcKFoc5AStMkEl4a+sgby6LKzt9e+e/4VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=TMjD8zum; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="TMjD8zum"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1735819292;
	bh=odFRxWYpeapXxCpd6HffuzlvvZGINR1nCzZoPhfea30=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TMjD8zum1+bQUNqAxpo4U1Hu6HGZPdpD8E0kKFWZTNzrGzT8Rozboa7m+hGHr3U3m
	 Zw+wEkq9az+JQlD3ZpGXlrhBgc2j767YUByhpJrFr7F6JS8EGWJNU7vNLh6Yz7QTy+
	 n5f9nDTYX1g9TfU4fRecd387br/g7Ny3xAC5vrRY=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Thu, 02 Jan 2025 13:01:34 +0100
Subject: [PATCH 4/4] kyber: constify sysfs attributes
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250102-sysfs-const-attr-elevator-v1-4-9837d2058c60@weissschuh.net>
References: <20250102-sysfs-const-attr-elevator-v1-0-9837d2058c60@weissschuh.net>
In-Reply-To: <20250102-sysfs-const-attr-elevator-v1-0-9837d2058c60@weissschuh.net>
To: Jens Axboe <axboe@kernel.dk>, Yu Kuai <yukuai3@huawei.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1735819292; l=935;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=odFRxWYpeapXxCpd6HffuzlvvZGINR1nCzZoPhfea30=;
 b=h3Y7x1T+4rvepCyaWUhQksxThUJfGFsLhYd6343XJSyyjaVYYWfItvZ4rDnO/+k/Ta6TZRD0p
 WaRgJurXpzoBSlYzDu/0kAK2pFg/NeCn5v9vWEMNkljTsYMk5AkkonY
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The elevator core now allows instances of 'struct elv_fs_entry' to be
moved into read-only memory. Make use of that to protect them against
accidental or malicious modifications.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 block/kyber-iosched.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/kyber-iosched.c b/block/kyber-iosched.c
index 4155594aefc657016d86bb25050b67544fefaf34..dc31f2dfa414f68f3475489d5d33ad07730393b5 100644
--- a/block/kyber-iosched.c
+++ b/block/kyber-iosched.c
@@ -889,7 +889,7 @@ KYBER_LAT_SHOW_STORE(KYBER_WRITE, write);
 #undef KYBER_LAT_SHOW_STORE
 
 #define KYBER_LAT_ATTR(op) __ATTR(op##_lat_nsec, 0644, kyber_##op##_lat_show, kyber_##op##_lat_store)
-static struct elv_fs_entry kyber_sched_attrs[] = {
+static const struct elv_fs_entry kyber_sched_attrs[] = {
 	KYBER_LAT_ATTR(read),
 	KYBER_LAT_ATTR(write),
 	__ATTR_NULL

-- 
2.47.1

