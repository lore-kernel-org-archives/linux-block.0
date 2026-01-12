Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D177237E307
	for <linux-block@vger.kernel.org>; Mon, 12 Jan 2026 17:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768237505; cv=none; b=fwIKtXVGbB4C8Mgf5n7CF/Csu/3cIXpeJEBKWFeOpId8DZteNUIYSTbVUGSZUbJH1CcyvUimz2bUrcz/hH47PdXoYDZgxikHDf24RqTx+Y3S1wQ7T+cVqSl+ahm42x3i38tuYZhhwS3AfXKRBlXYTBUmbvnqjXweMGpsmGzYYSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768237505; c=relaxed/simple;
	bh=PSODpUAswlIac0Cz2UXm4iCjS0hhRMof1atbvQalbhk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JUNZVQd/myweDbd80JPjNZHuug7CXC9ScmvbOXTyMDriZ6VYx5Vcoin5U45yVjV69Puy3J98dH72eUO9DWDrt6YG0qgePB1HQUFvEUsM9xXEZtbWCiHPP5HBhLyi9huoVD5sB9AE9vTOVGw5xFZe+V1d6M7zK2fS46zgYRakUC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Q2wS8JYF; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Q2wS8JYF"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768237491;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=g1TniHRbfd2bwPXGfXb5xEPMCBPMS+sg9L8CypJ8iH8=;
	b=Q2wS8JYFCBAFkM39RowL4YyslHWXkOpu9IDwzfFYnY6zyKPyMaM1pNqiselmmAQCY6/c5C
	SGKN44GJyi3fqZyCLKP3sp9rYJ3gSpzjVKRpjQd4gV9pxkVE26o5tnhH6Nq6m1/YJBYvkv
	rx7a7Y4Q5WYI1QGIsuTo81uyLQFpofE=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	drbd-dev@lists.linbit.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drbd: Replace deprecated strcpy with strscpy
Date: Mon, 12 Jan 2026 18:04:12 +0100
Message-ID: <20260112170412.741013-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

strcpy() has been deprecated [1] because it performs no bounds checking
on the destination buffer, which can lead to buffer overflows. Replace
it with the safer strscpy().  No functional changes.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strcpy [1]
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/block/drbd/drbd_main.c     | 14 +++++++++-----
 drivers/block/drbd/drbd_receiver.c |  4 ++--
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index c73376886e7a..8cb5d5ba9a3d 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -32,6 +32,7 @@
 #include <linux/memcontrol.h>
 #include <linux/mm_inline.h>
 #include <linux/slab.h>
+#include <linux/string.h>
 #include <linux/random.h>
 #include <linux/reboot.h>
 #include <linux/notifier.h>
@@ -732,9 +733,9 @@ int drbd_send_sync_param(struct drbd_peer_device *peer_device)
 	}
 
 	if (apv >= 88)
-		strcpy(p->verify_alg, nc->verify_alg);
+		strscpy(p->verify_alg, nc->verify_alg);
 	if (apv >= 89)
-		strcpy(p->csums_alg, nc->csums_alg);
+		strscpy(p->csums_alg, nc->csums_alg);
 	rcu_read_unlock();
 
 	return drbd_send_command(peer_device, sock, cmd, size, NULL, 0);
@@ -745,6 +746,7 @@ int __drbd_send_protocol(struct drbd_connection *connection, enum drbd_packet cm
 	struct drbd_socket *sock;
 	struct p_protocol *p;
 	struct net_conf *nc;
+	size_t integrity_alg_len;
 	int size, cf;
 
 	sock = &connection->data;
@@ -762,8 +764,10 @@ int __drbd_send_protocol(struct drbd_connection *connection, enum drbd_packet cm
 	}
 
 	size = sizeof(*p);
-	if (connection->agreed_pro_version >= 87)
-		size += strlen(nc->integrity_alg) + 1;
+	if (connection->agreed_pro_version >= 87) {
+		integrity_alg_len = strlen(nc->integrity_alg) + 1;
+		size += integrity_alg_len;
+	}
 
 	p->protocol      = cpu_to_be32(nc->wire_protocol);
 	p->after_sb_0p   = cpu_to_be32(nc->after_sb_0p);
@@ -778,7 +782,7 @@ int __drbd_send_protocol(struct drbd_connection *connection, enum drbd_packet cm
 	p->conn_flags    = cpu_to_be32(cf);
 
 	if (connection->agreed_pro_version >= 87)
-		strcpy(p->integrity_alg, nc->integrity_alg);
+		strscpy(p->integrity_alg, nc->integrity_alg, integrity_alg_len);
 	rcu_read_unlock();
 
 	return __conn_send_command(connection, sock, cmd, size, NULL, 0);
diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 3de919b6f0e1..3d0a061b6c40 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -3801,14 +3801,14 @@ static int receive_SyncParam(struct drbd_connection *connection, struct packet_i
 			*new_net_conf = *old_net_conf;
 
 			if (verify_tfm) {
-				strcpy(new_net_conf->verify_alg, p->verify_alg);
+				strscpy(new_net_conf->verify_alg, p->verify_alg);
 				new_net_conf->verify_alg_len = strlen(p->verify_alg) + 1;
 				crypto_free_shash(peer_device->connection->verify_tfm);
 				peer_device->connection->verify_tfm = verify_tfm;
 				drbd_info(device, "using verify-alg: \"%s\"\n", p->verify_alg);
 			}
 			if (csums_tfm) {
-				strcpy(new_net_conf->csums_alg, p->csums_alg);
+				strscpy(new_net_conf->csums_alg, p->csums_alg);
 				new_net_conf->csums_alg_len = strlen(p->csums_alg) + 1;
 				crypto_free_shash(peer_device->connection->csums_tfm);
 				peer_device->connection->csums_tfm = csums_tfm;
-- 
Thorsten Blum <thorsten.blum@linux.dev>
GPG: 1D60 735E 8AEF 3BE4 73B6  9D84 7336 78FD 8DFE EAD4

