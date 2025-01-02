Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA8D194C8B;
	Thu,  2 Jan 2025 12:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735819305; cv=none; b=qVI+9vQ8Nt45I24HshAJBsMuUOMaEX/0xQ3Eu1e18KTQVrLQNOBSB38uH/zlEJ5Qpm3ow4fsEn2dPeDrUwBdRH9ex0pma5azHBaGGtKjkjQBqJCLzxl1hs+APkBpkL00Kc8wal4Ay4QkYgUcXm+nC40avPVmT2BCk1jKIJatpnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735819305; c=relaxed/simple;
	bh=ZDExbkwJU/vM0+WXsyrHEHxxuUiUTAJ13SHngPCJR7c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Mu//biDboCRvYWtOJaTOp7qQ4YqfUab7xCkHKktMrlG9ihXH0v7iIg0yh+vyyYI5Ce84HO6SXVAZQ6xCk5aIDgzNu8Uc0ovbo7AQgCC1H1MslcQBjaZgKXPxx9J7LBmwAOA6r5toV8JpRqvW4BhZY434d0gYqZQ55HlBLczkmJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=Pp511oI1; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="Pp511oI1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1735819292;
	bh=ZDExbkwJU/vM0+WXsyrHEHxxuUiUTAJ13SHngPCJR7c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Pp511oI1goXY9yHUCRrYqFrW7X6GkIMaVKam38OikGSYDe/s89Jsic0I1Ko3gpGBc
	 O7s2HZSyvx+fIbjP0eoU7oZ1KPTUNWQqJvB17fn8aIE7ISgO6BDn70z3iV3c3Al/ri
	 ATGgQN1VmxavexBXef3xz1OD7GEx52kzdXE9H7jE=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Thu, 02 Jan 2025 13:01:33 +0100
Subject: [PATCH 3/4] block, bfq: constify sysfs attributes
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250102-sysfs-const-attr-elevator-v1-3-9837d2058c60@weissschuh.net>
References: <20250102-sysfs-const-attr-elevator-v1-0-9837d2058c60@weissschuh.net>
In-Reply-To: <20250102-sysfs-const-attr-elevator-v1-0-9837d2058c60@weissschuh.net>
To: Jens Axboe <axboe@kernel.dk>, Yu Kuai <yukuai3@huawei.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1735819292; l=911;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=ZDExbkwJU/vM0+WXsyrHEHxxuUiUTAJ13SHngPCJR7c=;
 b=yK3s4PGOX4H4wJYrhLf4c9WT45F06i3sGqI6Zv6NUz+aN72q64ZT3dqlKvYEq4PKzqJaoLl3i
 OniTp3Bed+zCSaKaRXYxS/2RQ7vnYEv2BbV2j7oN7NQlLCM9sZpWO1A
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The elevator core now allows instances of 'struct elv_fs_entry' to be
moved into read-only memory. Make use of that to protect them against
accidental or malicious modifications.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 block/bfq-iosched.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 95dd7b795935658b8709de7eab81b4730ece022d..068c63e957382e41de2454efabbab50b06d1ffd2 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -7614,7 +7614,7 @@ static ssize_t bfq_low_latency_store(struct elevator_queue *e,
 #define BFQ_ATTR(name) \
 	__ATTR(name, 0644, bfq_##name##_show, bfq_##name##_store)
 
-static struct elv_fs_entry bfq_attrs[] = {
+static const struct elv_fs_entry bfq_attrs[] = {
 	BFQ_ATTR(fifo_expire_sync),
 	BFQ_ATTR(fifo_expire_async),
 	BFQ_ATTR(back_seek_max),

-- 
2.47.1

