Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362B82FB993;
	Wed, 13 Aug 2025 22:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755125721; cv=none; b=gIAmUSYuiverxouJYzMAyxVf10e2GxWJqulF4upukEzoJ2hy5kNQCg2tDOsnSvj0cF2OHWKwcDDsmK+YCwcuveifQxrwc6eB9DlGfbKRI3qu6IUAqwBEs9ynH66jDI6XBxrG9dHsyTWVR6MkPTlN0JH1DrlauXAUNlceYwRuruQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755125721; c=relaxed/simple;
	bh=mNwkIP1gRIgMnN1aK5nlZaImKiEaDmb5+aPduJ94HZg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HtyGZlyHeTK03KRhrjD3hwUOw9/pn2iUJN6PQcceTToulJrcmDKmx57DkKT+Zx2Gf1uh+c5GEIu2U+uE3lNmiwk01qvYYg7rsRWDYZ/OhurTrNiesEe3gUHw6pLB2eQh6g7ZBdPqPcI3PjuqUNKV2c7vox6yWiq8aOtL+BIjz0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e8BaGMxh; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e8BaGMxh"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45a1b0b2d21so1239695e9.2;
        Wed, 13 Aug 2025 15:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755125718; x=1755730518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u/7HuxK1PiW4pica1ZvP+UeUtnq1Mq8dM1bfrWpL2pA=;
        b=e8BaGMxhddTIci7ChCKzbMdIl2VNCTxrGOBF44BbtEgPgv1Gc5atui3WL3YT1/V5cz
         d4GZgwMTCxDh1g62eAqgVQZHTcveog482YmIxC37HGI/kEaDB2mhxv7z3rnVmiV3w4Tz
         6n0CORhP4n8FOKyM42P3Aag2YsXsVbvSfOxosEDiy0izDgxMMHS6Rep7f+49JFmxx4sA
         dtvz4r7ofQ28KVBZuixMRQPxRzNxEO0yWXk9H+TLWJpmzNlI6Sv+90g2w4cuIPQbr9D6
         oaW3DrvExSZetxjELrctDqaZp7RrhltIn2uC0TpPzf81hBOvl1jHdE9OYldsSr7j9VXU
         yvGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755125718; x=1755730518;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u/7HuxK1PiW4pica1ZvP+UeUtnq1Mq8dM1bfrWpL2pA=;
        b=aR1jjAb43xQsgk3+tRQs2AUgq23NhpIwLLPv3DjcJ4odk12wShRpEAPZWr3lHGV5OR
         1CYkSNJ5lck1Fugl9bqLCgGUg/12uQOWORFfWogre1n3x0rEsfPg7clDuzmYe3LIh0L1
         nXPKd5J3A6Zj9jJp8NXYz7B5SA+nQgCdgH/pz4ORYk00FkMP4IWqGyzPGwYQSRoakOTV
         svh4olpLPF+RV8Bus9Pg3n+pOW6J6/Cx2NXqE/VbvlBrRNBBcv28d71u542wR6x6KSAi
         S1owkEXCiEMJvULd8ZIuLdnpc4c2+Z6PpYPzk71RJpSyHWPeXicinSaNRk8XumgKYSkc
         123Q==
X-Forwarded-Encrypted: i=1; AJvYcCUQM8gyBF8L0v5Vdzy9q//B5uFO0K1U+GBXugikRuqNWk+0YfXrz15L6tl7VVkbbpFU4dPX6Ocw2Kfs1Jrj@vger.kernel.org, AJvYcCVbjHZYrF2YCeJtEP6rFuPgLqF+wmWxSwYyMheowAo3b+zyLl71u7XvJbae37EA/mdJUBjQrqbdULGcVg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzLTzGKkS3GoahGmwJZlevDeaXAVmvmXvB3ulSyBYMA+V1FzZjN
	fIIggZrPO0Pjv2MX/Mg0c5/f6WM3AIJBPAi7IcqmPrYD8qXwaNK51xVG
X-Gm-Gg: ASbGncuDWjkezA2Clw9I7vAj65YvsuOiP7v5tjOmo1jiTOYxRbnWTJyTY7mdSnm4WBW
	iRJXM1Bla1UIQ2bjqn0gjn5+cYWs4WPSoHW8jgTG4R48DokydiFEdDjO06No1jPQaW23YdHAyOi
	L0pPuDWeNyAlu2OwjSa6s6gwa8glgGtsIwGyntQRcpunVBiEdWuZNmWhtIehSBkJAE7byogG8Nl
	JwVYjLauYzKV2KsNzI3BkWAUPktHjrtkF7QDIud/4SFhed9sFOwJvheB67gJt0+sITCAeFxdbrE
	Hwjc6cI53idaMypRjLEb02YNVTdMULsAD7078J9/BuZx71wjvZX75oRhbtYP3m+WnmmWL4+TcJm
	BzcyCVOoGJqM9/U+mTAvk3jAsKpgIwr5uhdOnP2nuZ5xwNq8Y1na4DkT0O2EDnIQtsKpT/CRCMg
	==
X-Google-Smtp-Source: AGHT+IFeCjojdSo/SpRtqi2SaYzzhmaB5U1RpVmYXo6pe2aArUfXV1t+Q54VbnzmGyma/aP/wkq4Tg==
X-Received: by 2002:a05:600c:1911:b0:459:d9a2:e920 with SMTP id 5b1f17b1804b1-45a1b5ffe70mr4084125e9.4.1755125718357;
        Wed, 13 Aug 2025 15:55:18 -0700 (PDT)
Received: from ekhafagy-ROG-Zephyrus-M16-GU603HR-GU603HR.. ([156.204.193.65])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1a590192sm16446865e9.24.2025.08.13.15.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 15:55:18 -0700 (PDT)
From: Eslam Khafagy <eslam.medhat1993@gmail.com>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Jens Axboe <axboe@kernel.dk>,
	drbd-dev@lists.linbit.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: skhan@linuxfoundation.com,
	eslam.medhat1993@gmail.com
Subject: [PATCH v3] DRBD: replace strcpy with strscpy
Date: Thu, 14 Aug 2025 01:54:53 +0300
Message-ID: <20250813225510.138105-1-eslam.medhat1993@gmail.com>
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
index 975024cf03c5..d4ea742664c2 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -3989,14 +3989,14 @@ static int receive_SyncParam(struct drbd_connection *connection, struct packet_i
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

