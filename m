Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A59391838
	for <linux-block@vger.kernel.org>; Mon, 16 Mar 2026 20:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773692836; cv=none; b=CjKZSBa3KJRR6ZGH91zq9DmnWr5kWUr9mEtth6Y+BQyREiZUpWofmZ2lrOlDQoLMwevJ5baqidwMcaxXxeA4WgUN016QtVkQmAH1wsafaLuXQLTsz+6oPhXxYNOUN7cNmUiT1S41lMYvp2NruifZnT1lfMUafrv72NqfqxGLeGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773692836; c=relaxed/simple;
	bh=8okJ2fmzvjNNFPFXI9EMfIxITHFwACLEFFZDTbRfHNU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fPGdspfZxZc0D24YHZ6yxlSzJU9MJu/kougm1pLhAL9KO8Q98RM0olEqJTf+Gq1LsfSQjU3XAGl9vNOrMgEZHcwrMXI4tEccw8wXExfrHUmUNfYueTBeHLWt5RWEIl2EwIjTkhlR5iBC+TVSDLgJmQaIuH5DXhPDb7S6QDVAubQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jYA4sFjr; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jYA4sFjr"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-485445e80bdso44301415e9.0
        for <linux-block@vger.kernel.org>; Mon, 16 Mar 2026 13:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773692833; x=1774297633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QGkSCnkaww1lWR+SNMIGIRrj8X0ysk6mGmmOv90jF6Y=;
        b=jYA4sFjr2sMDGi5vBQn5kPJ1AMmWfLUmNi/Gdk7HfMmIulKmWpDo1LHwMc/1b7YVme
         AehBw9LuPdN9GcIYtUC6y9/fvpyV3qCiBKsQXdf4H/UrOesuiFKCqXCEb8fmh9/CVyNl
         W/HSBRWZ3QB4dyuKBAl5fda9lGuuzwQuFZ+ktZauXV0Kio8NkfBcLIy810K4YXrnenTN
         k47UN81aOwNiCc664TFe0PoUaDa85jcaowkSG45RrWBGLtBLEAicEhnuoiRt98K1aFbc
         oK3/Njh70qh50hjqbeoPJUhmWrC5wth2PdIvLUi8z6NkA5ioJknj8KEQsJ//Ls51idQd
         8QCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773692833; x=1774297633;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QGkSCnkaww1lWR+SNMIGIRrj8X0ysk6mGmmOv90jF6Y=;
        b=VDMPRji2xilC5zdvcJDZ7CjS3z9ub/QVl+03FFd26B8vCEEkppUYNOV+zIiDSj9k3B
         iOCWvdNC2qJ82kJWDb0FyKdtzwiSgKnAF+tPb1YEoEB4e4L7jhCxeK58rJVImfZy3XZj
         Jnja/V5xLA5laFzR1AV2oFNks7FbqJTZVQtu7Mx4Ne0+soJo2nX1Q9dR22firHE0EQiz
         dkniLwnxqSNtIZYa2QwO6HVxyGxItVAFlnxztNQOfLAOVMSaacvxC/G1BSyaW+NjRkuh
         PM/3C0tOKkESmGJpQSBIxMAuttLyVc4sIUQxtf+TZEVprqAu7BXHbABIMmA4QkXNXDht
         9LMQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5eoQuQEEYMCJY9HDlsmOUz0wP+7vAA1ID5KSh55uw6WGI35rXFApbYRQogwXnSrsBwpTkgELK17be/w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/aU9dmLyBiDvaAzqBlRHPT6+1QgrksWOsZs1DADNlCC68Tc12
	U7bgakmNpNMY/93l43D2R8mwZc03uTDfoQx3Re0q4OY66NNGOY7SXu1z
X-Gm-Gg: ATEYQzzhsAY6G5kFW2EkvCXus1E94G2I2shnTAjmou+M8lGpcP5yu3fC0gfp4XnevKD
	ZwUBl1B8YBxg3eAgKkF7RRaadjIKmRY25+nGtxDjd5A5u9hFEvTjHJj1RDo9xovIki+LG+PUjIh
	yA3ZIHE4JFi2f6KQq0Vy/u72jubClas7iiDOlGuAZ84pBe7Bv6IBlNS716o6srGDFc8ZFsyEpLe
	z/UKqBGbXcxFbUdlLO09hKBYC8YHAodWskpCjki90NYaVQ+NRZyoARkU4f/6M5dqTMFTclDiCs/
	JuoVZNA59CnizdstJL5ACllUkaFxxkQ74frTeN+QOel5nrVHhAh+e7tHpohhWUyCGb2V1zIjL0V
	v1/EvujTEVO/y518tzbZ5k/MuXmC2hd6sATDcgOEzwy9kntV52KdqRzzdl8Z/VrMNEujo4AgLEH
	bstC6hJAZacedvEnovxKKz1g==
X-Received: by 2002:a05:600d:8499:10b0:485:3f30:6250 with SMTP id 5b1f17b1804b1-48556714fd8mr184206035e9.20.1773692832397;
        Mon, 16 Mar 2026 13:27:12 -0700 (PDT)
Received: from localhost ([87.254.0.141])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48557777105sm172470675e9.4.2026.03.16.13.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 13:27:10 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Jens Axboe <axboe@kernel.dk>,
	drbd-dev@lists.linbit.com,
	linux-block@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] drbd: Fix typos: "receive_peer_dagatg" -> "receive_peer_dagtag"
Date: Mon, 16 Mar 2026 20:25:48 +0000
Message-ID: <20260316202549.33978-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There are a couple of typos in drbd_info and drbd_err messages.
Fix them.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/block/drbd/drbd_receiver.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 06d83b5ffafb..100207623182 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -8850,14 +8850,14 @@ static int receive_peer_dagtag(struct drbd_connection *connection, struct packet
 			    strategy != SYNC_SOURCE_USE_BITMAP &&
 			    strategy != SYNC_TARGET_USE_BITMAP) {
 				drbd_info(peer_device,
-					  "receive_peer_dagatg(): %s by rule=%s\n",
+					  "receive_peer_dagtag(): %s by rule=%s\n",
 					  strategy_descriptor(strategy).name,
 					  drbd_sync_rule_str(rule));
 				goto out;
 			}
 		} else if (ps != strategy) {
 			drbd_err(peer_device,
-				 "receive_peer_dagatg(): Inconsistent resync directions %s %s\n",
+				 "receive_peer_dagtag(): Inconsistent resync directions %s %s\n",
 				 strategy_descriptor(strategy).name, strategy_descriptor(ps).name);
 			goto out;
 		}
-- 
2.53.0

