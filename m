Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E43C2D1;
	Sat,  5 Jul 2025 17:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751736777; cv=none; b=r38lfhArl2yyFQBdKCbYYozDBqKpu8g9QwhVbwXaR4G9U+ogPHwPJyKSJcgFmkM1ofIDo5ww8+cbdHOGEeDcLi2+2UBphTGxH2g3ZxAE+dN5+33zInROEKIT/37KM4+a458dKcY3zZMUg/w3Vpn2uxXDWOgmUFGH6FTwEEEZoBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751736777; c=relaxed/simple;
	bh=63cUjIB4osdOi2aZ9nh3xxhbq84WuucWLl+AmrtOrgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FCy5KFrBhoY2M9suBWOSlV1J+GKKuYDsZrkX3xxHG/Rb2YPSfVfLjMGGlF0h9lPfyDLpiv1uycubJe4tZ3UgBuU0A1xwddhiwXkDCFHogBX5+G0XzQW6/TLjvDn7V+FgrxxAECQnluRFZlVoDY/V39tk+fZY9tgX+RNxLp15YRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DnBJJyti; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DnBJJyti"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4531e146a24so11934275e9.0;
        Sat, 05 Jul 2025 10:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751736774; x=1752341574; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vr/ZD3BCUnN4ej5gioLyrHVyB4YH9QmjY1UHVXxI2VU=;
        b=DnBJJytimcTSuWU4l4hPZLmwjcxoxZh+hK/RBWUjLcPqmk3SVVdICb/r7ehbiLbcTz
         nyrvncMryYypMBhPgdhXN8zpamaRHydarzS0cG4IOahgmz6PrGVzSriUN3lx9d8xA7Qf
         18e0WZFO3YgOnzu5oMNAdoa+4Y3cqo8a/hs0RBODFiewD/mU9bDgOzoelU5wv/y5+DMU
         oO4PUIBFcI5/KVnvMZSeF/k4ASu4kO0ki0amb5PXdwMpTis95ShnSBvEJyL7HNNGBwca
         rAmErubXzLq7NJr5ceA9Zsao6/B1Ce0w6NGj7/Gq7YLaPrWGoZfGLog2Ky/JESfH43uW
         Hmvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751736774; x=1752341574;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vr/ZD3BCUnN4ej5gioLyrHVyB4YH9QmjY1UHVXxI2VU=;
        b=Y2D21q1dox8VYqozfTvBbOaxx4UIPuruXBd6EE2HWCli0R183T66TaXvWyYk9zurex
         JCinE9lLrW24hOs8LPvAqOmLsaAWauvA42DVkY0wWROkAq2CpMaqnInir8icht9YNhUU
         7dvYtqGWtbczzSTRWDRPVNzjyOdO9klun4THVXw3g6gKEnMX4i6h8R17G/nB7yvVRuB/
         CupJndaFEj4unREkPKcV/DoIXuvzH+sjUbSX4YsMRcy24xMFOVbZprvK+22W2pAs1CJQ
         sxaCz7yRk3A/stHbASK+AWzCeArCgyzGFIcmSWHsOLPr7N/aDd1W1n/8nMCFJoNKrrvv
         BYmg==
X-Forwarded-Encrypted: i=1; AJvYcCUo1HPqACBnTFDKeu4wGbPZc07j3Z1Ibu6fVmvCxFuZifnqRA3L4tEhjoJe8DMT5BDubXDKX2bA2k6a2TY+@vger.kernel.org, AJvYcCXYT86hMXhednXt2LYJjlhvOJulTejNGmxoglY4qEM7CqFTqArwJZzWStPVKIQC/Ykq8QHWjCrCanDLBg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/+DEbxuH8Tb5yd4rqKR5fc84ri5lhWh1On2gOcNbEF5PuonqW
	u/fE+j7axciitYbUwTMf+kaJxiBGmZmMkUdjv6Mlb14JpBtcVD1gxVeQ
X-Gm-Gg: ASbGnctSII+Nhp+xCLqPSNCw5MGO4lgmqVz2PbnLU9A30+9iEuUa4F6qca5utB1iyqY
	dtvcC8O6O7NnZlt1I99QrMTI8lJTCoTjij8QufLxto3ccYR2aNU02VaXgWu3zVNfS3F3XmiiOPH
	XTAKNyFUvw6le79T9cPomi60exR8XX2Xf4wMmMY1u0WeYUnGR3RSubFVIktQ6K8XCeCme2SRomq
	vXOo5FJkTZMBgTlhjBLYC9ZiBySEwFqiouob5sAD9frdjT5OP3ge5foSr/Ensfg8VKniCnQWGwy
	uoAcCuN90OJbZ73nFWZk+JGh9kJeLYp1lXu0qjA3+ErTXUEU50ZB/4swSwiZzmUx5+2geCHpMAb
	fJhlGdNaQxQx0n8C108LVdrWK2hzbDl5Y2RRu
X-Google-Smtp-Source: AGHT+IG/6HH9ShvrRUcFIgouUs+F16roF+T0fvocNgtyC7J6R2vbml3IdtiWwj7ol8JOeLlHcd8OBg==
X-Received: by 2002:a05:6000:4807:b0:3a8:6260:d321 with SMTP id ffacd0b85a97d-3b49aa429cemr1784449f8f.3.1751736774164;
        Sat, 05 Jul 2025 10:32:54 -0700 (PDT)
Received: from ekhafagy-ROG-Zephyrus-M16-GU603HR-GU603HR.. ([197.46.88.143])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454c041cd4asm5618845e9.28.2025.07.05.10.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jul 2025 10:32:53 -0700 (PDT)
From: Eslam Khafagy <eslam.medhat1993@gmail.com>
To: 
Cc: skhan@linuxfoundation.com,
	eslam.medhat1993@gmail.com,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Jens Axboe <axboe@kernel.dk>,
	drbd-dev@lists.linbit.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] DRBD: replace strcpy with strscpy
Date: Sat,  5 Jul 2025 20:32:44 +0300
Message-ID: <20250705173248.59003-1-eslam.medhat1993@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704175018.333165-1-eslam.medhat1993@gmail.com>
References: <20250704175018.333165-1-eslam.medhat1993@gmail.com>
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

V2:
 - I forgot about null termination so i fixed it.

Signed-off-by: Eslam Khafagy <eslam.medhat1993@gmail.com>
---
 drivers/block/drbd/drbd_main.c     | 17 +++++++++--------
 drivers/block/drbd/drbd_receiver.c |  4 ++--
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 52724b79be30..028a5cf41d7f 100644
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
+		int integrity_len = strlen(nc->integrity_alg) + 1;
+		size += integrity_len;
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

