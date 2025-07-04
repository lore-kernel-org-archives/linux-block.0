Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B080A1EE7B7;
	Fri,  4 Jul 2025 17:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751651445; cv=none; b=H+xIxQjKlFExysI/K9v0UN0TC8ijqRn3aVX8yp7oMUCETUaj5YrvhrJMvoadivvgUPhdPCC4tHwfVapvYkoedInO0GuqfxjSEqt3qyrH42sHdUaxoQnKE/D6i8dnCzqUdn9STpvN+ICyTsq1BQUCXYjZ9vpEmPgpN9jeO2U+WiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751651445; c=relaxed/simple;
	bh=wB4CRAZJy+K0gy6uZ0Y5nkA+Q6wo0BrNhBcOAGOBIaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nfTWjnciqAp5puE1m+asJ6B9VlLqxZXwu/Hozj9AwO8pdXs8h9G72VRZ/i7KFOWGGHDNoXydfq2MHbFJMUUxn1MAaxbAQBEXfe7g3nRmo6lFZEisFXf6qGjYCorh6/eMb2+xjL+JFlqpKn8wcjMq9n0Xxk2bN54HBagqZhWrSOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J4Vvk7Sp; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J4Vvk7Sp"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a57ae5cb17so743821f8f.0;
        Fri, 04 Jul 2025 10:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751651442; x=1752256242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7kzxKyGyUkMQNU8zFP39T97KAl93oC6U2R3DXkWnfQQ=;
        b=J4Vvk7Sp2tnW2ZttP3cc27u36YkhpzVtSw4dHao5Fy9kPTaueBOwrs2GYpfA9KIKlV
         VcsjGPUcaHYGnVIJe7ItKwDV+RQDsaLtE9lOxA09/OrQ9YgpEwOn8UXccztI/9FqxwGQ
         0PcQbg4lr4pVWbTyIDt6yu5UikJWn6NMpSSH6ckuwBvf76jXIncMYMg8ef9cERQjqZkD
         MSeoDLck/pMF8JZH3WNhNCJxfzPIGzA+VN2fQvSE156oO8aRrJoo/JPphlSyZPnHrNc2
         rOqfSkNUPEAcwmZQNLSJlTnMUtEa0JynQt6UaUHJl8TDqHRxlI6NchX/jqTWuSo9Hw+8
         2Xug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751651442; x=1752256242;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7kzxKyGyUkMQNU8zFP39T97KAl93oC6U2R3DXkWnfQQ=;
        b=Pn0VJuoR666QPflScM5nxqUYxA88RfXYmSGWN/sbkcGKi+H9/7T+E2G9W929bFV1D/
         5W7uOifyPEDVoecFkjisyjeFBcuQwasUS8vLPv8hgEehsPzkH4IbKLfjnsoUfi3nR+pV
         6PrnVqzGQ4bUnRZ3TzC7FI6ZG77vuRJhlJau2ECoptpzfAgJNL/yfFkLXPyIFZD9O6fX
         hETpiAZlA8GeJ8TKv00pIUZc2rb9cXUY9SBTLL/9oVhj2UdEVuqTjKIMEnJgDf0knupi
         Bz5lHDQj6vI0w3112/7a7kaGegIbTTOV2FNS2ZkEyJMzqBWdc12R3oe+Otcfm5GUlDxz
         xmLg==
X-Forwarded-Encrypted: i=1; AJvYcCVKv95AGUtB0jvrE6tWKB3MTL0qLb+N+/uN75BOO4BJ6dTs5x3nuFuTEIzKw3y9yfwvMGyyN2rHsOIM8g==@vger.kernel.org, AJvYcCXaddmmmaji2W1lXGWJgxzmUog7vMvdGHeR62ArcH05DqUN2o/k4nnN2JKpE91Gw1GZOU77P6qWsy9zGzmw@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu2aHPAjYpY+jjHgm6AiLX3IOvHu527cCzdGE7J4d/6qeTyydh
	yaHqje0wIdPwDqihHoZ8tAMAih2Cx71MuCJ39MFqm3PDGpMmlJI8G9y5
X-Gm-Gg: ASbGncshw3enH0Mgo6NmW9/3IXNJ4qhLX05LRHXk5Z+Cht85MLpI6vv1EYof2S8/3Vw
	rMkdFyobafuMLk9gcwBrDdCX2RI3bmGJxI3xerpnP56IaXYB/6IZhS1ijxmHeNneg37iG9dYeh/
	eYe6EDfub0EpRpsYGqIZRh4qRTRXN7lUFcdcer2mkZ8yGK3ZWFhhWmw1M7K9Wu92OyW6W9gYWgC
	JLcl0j4MaNiCju5F5Uh4cwVBaf5z3DWUsllfBj7NI2eFqg+Jsxv7YJn063Sq/W6Zkx5qbkuTFwe
	4JcsBhedXqJMRxWPt28cNWAVtE2Co16wccG7eZDgkeEsyJgT1zrcGYxRIjelvAc8hdmSPstGT2Y
	DI8A+uJC1gXLy3sBPFL04e/F3ljVKw1bGu4bU1Q==
X-Google-Smtp-Source: AGHT+IHkGqUW4qYzaIeEVo4MIPsGKugMbjdQlEOB95vKMllXraZTUlpZPd8DNQlc+GfPIEvC/98pUg==
X-Received: by 2002:a05:6000:2c13:b0:3a4:ef0d:e614 with SMTP id ffacd0b85a97d-3b4964def6bmr3030814f8f.33.1751651441612;
        Fri, 04 Jul 2025 10:50:41 -0700 (PDT)
Received: from ekhafagy-ROG-Zephyrus-M16-GU603HR-GU603HR.. ([156.204.255.91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b4708d0ed9sm3063745f8f.38.2025.07.04.10.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 10:50:41 -0700 (PDT)
From: Eslam Khafagy <eslam.medhat1993@gmail.com>
To: 
Cc: skhan@linuxfoundation.com,
	Eslam Khafagy <eslam.medhat1993@gmail.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Jens Axboe <axboe@kernel.dk>,
	drbd-dev@lists.linbit.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] DRBD: replace strcpy with strscpy
Date: Fri,  4 Jul 2025 20:50:15 +0300
Message-ID: <20250704175018.333165-1-eslam.medhat1993@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

strcpy is deprecated due to lack of bounds checking. This patch replaces
strcpy with strscpy, the recommended alternative for null terminated
strings, to follow best practices.

I had to do a small refactor for __drbd_send_protocol since it uses
strlen anyways. so why not use that for strscpy.

Signed-off-by: Eslam Khafagy <eslam.medhat1993@gmail.com>
---
 drivers/block/drbd/drbd_main.c     | 17 +++++++++--------
 drivers/block/drbd/drbd_receiver.c |  4 ++--
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 52724b79be30..4e5bd74be90a 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -742,9 +742,9 @@ int drbd_send_sync_param(struct drbd_peer_device *peer_device)
 	}
 
 	if (apv >= 88)
-		strcpy(p->verify_alg, nc->verify_alg);
+		strscpy(p->verify_alg, nc->verify_alg);
 	if (apv >= 89)
-		strcpy(p->csums_alg, nc->csums_alg);
+		strscpy(p->csums_alg, nc->csums_alg);
 	rcu_read_unlock();
 
 	return drbd_send_command(peer_device, sock, cmd, size, NULL, 0);
@@ -771,10 +771,6 @@ int __drbd_send_protocol(struct drbd_connection *connection, enum drbd_packet cm
 		return -EOPNOTSUPP;
 	}
 
-	size = sizeof(*p);
-	if (connection->agreed_pro_version >= 87)
-		size += strlen(nc->integrity_alg) + 1;
-
 	p->protocol      = cpu_to_be32(nc->wire_protocol);
 	p->after_sb_0p   = cpu_to_be32(nc->after_sb_0p);
 	p->after_sb_1p   = cpu_to_be32(nc->after_sb_1p);
@@ -787,8 +783,13 @@ int __drbd_send_protocol(struct drbd_connection *connection, enum drbd_packet cm
 		cf |= CF_DRY_RUN;
 	p->conn_flags    = cpu_to_be32(cf);
 
-	if (connection->agreed_pro_version >= 87)
-		strcpy(p->integrity_alg, nc->integrity_alg);
+	size = sizeof(*p);
+	if (connection->agreed_pro_version >= 87) {
+		int integrity_len = strlen(nc->integrity_alg);
+		size += integrity_len + 1;
+		strscpy(p->integrity_alg, nc->integrity_alg, integrity_len);
+	}
+
 	rcu_read_unlock();
 
 	return __conn_send_command(connection, sock, cmd, size, NULL, 0);
diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index e5a2e5f7887b..9c2d439f26e8 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -3985,14 +3985,14 @@ static int receive_SyncParam(struct drbd_connection *connection, struct packet_i
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
2.43.0

