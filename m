Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14EEF14D452
	for <linux-block@vger.kernel.org>; Tue,  9 Jul 2024 07:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720511466; cv=none; b=GuETqP1oSTwmX8U+HVxNiduQxcDGbx/kQH9ZfoiVf/r9zY5usc2D510ilXxCCCcfGnU2GEJ26j0fpxOYSpz7lAWBuVuaglq20oT/MtNu+tvwfNy4umy6lOqaiyPSG5YzRIVLOBp2vzV4Vr1gdJcplBth+7FxJuTLDFBqKRG1Npc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720511466; c=relaxed/simple;
	bh=GW+EbPAm4hHbTsC2x/kPcfW/1ojBg+BpcgL47NVHa7U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ekjmkyN6wt4Z/A6pSRPWKRJTSdnKNb2qLPR9+DKpn0pdRmup9oPVBuYhdBUVKOwTVBfl7ezwvAn3Sz4ob2mQD/P1gUqZIEUYyxN9sKrxClFRfx+OAuj5yrIfTBuHXLYEetavSdEkF5lVvUSB4ddRPjFZFwWmw8BGd8sMMAAjykI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=bDvXZrOa; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="bDvXZrOa"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-6e7e23b42c3so2448640a12.1
        for <linux-block@vger.kernel.org>; Tue, 09 Jul 2024 00:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1720511461; x=1721116261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rH2LKJ5HJHgLjNSyzU2sfO5c0h5HphrNELJ/X033wjI=;
        b=bDvXZrOa310Sq5JdMHv/6mXp31f1tesUlosHL8XCbuhTwQnSero0MtuPmQmc75K7tT
         jJweti2sONTgOeObHcz5Hddhw+VizP6QH2KKUxH2JIF8d6aIwogdPCxZqOxr0rCYx6aH
         gYAQyXfu1TWWIh4TA1RBUlhw+DZnYspZoqCkC3TwwMT/sL7kb9XAkyBsFJHDpNVq65j+
         EVA5Ue5hKFH1Xh7udIL4wmgse/x3R5IHaiVJJyTqKLe0K10MwnMynqJeXRsu3nVePMLU
         widcmoLfPjkQ6oEKVlC569rPBmvYgk1PS0x1v1Xxc7KopRWwMayTe5Tr0piYJn0OypMj
         a/AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720511461; x=1721116261;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rH2LKJ5HJHgLjNSyzU2sfO5c0h5HphrNELJ/X033wjI=;
        b=DJsMywvchvixX4qvrAeiT1qo6fxJvZcnd6H73pUAE7ix24VLeNEWPVsXiqXcgb+3Zt
         sntONiL4/mXpVG2vGALYcYnKm3uRGGx4GO9lH1OgZePiPDcwqoQwSgfaR0Hyg25cikF7
         e6zy1vSqCxCRe5WV6wKG9WlE8UvezoGyS0sQ+61afsHP9ewmbjeq55NmUAxU2Fb/meh9
         ps1PnbGubILh+cOeRp95xn84EZmFeCsLMajjUFaxi6pmU7szfQBA09E1u1D1Dsz8gdKy
         xbI4tz9H5RYDuCy4Za0JzreOOjxl9u93DHxIvvzVceakjYg3YzM9LhaCfqpuSPz8xXGd
         22Ew==
X-Forwarded-Encrypted: i=1; AJvYcCUgE+fXcnQ2rWHY0F/BXcs+42LtpBiHE+fdOhL2GuIVPsTogwT921xVU2NquxuACNRpvSK/noh/FmfBu8hNyx6Jh9pGHpOTVxpmPGI=
X-Gm-Message-State: AOJu0Ywi8IQR8fmcfml56bKtVzxr9N98nd10wfBXpDqldMmJu6x7R2FK
	spGOUS1EBe5mhNaeXwE/0cXo5jKr8QN3UPz7f70qWc2fyZ+u8TQ2FtA4PAjiAJY=
X-Google-Smtp-Source: AGHT+IEtzhNLYwdsLUEB3IkPaB9LK4j2KJqmSU8T6ZSrbB0fgnQxWDy4bJlJajo85/AGEYmPcUSvTA==
X-Received: by 2002:a05:6a20:72a5:b0:1c2:1ed4:4f90 with SMTP id adf61e73a8af0-1c29822de17mr2198873637.19.1720511461277;
        Tue, 09 Jul 2024 00:51:01 -0700 (PDT)
Received: from PF2NG7DJ-CGA.bytedance.net ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c99aa621e7sm9369708a91.41.2024.07.09.00.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 00:51:00 -0700 (PDT)
From: "lixianming.19951001" <lixianming.19951001@bytedance.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	pbonzini@redhat.com
Cc: virtualization@lists.linux.dev,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lixianming <lixianming.19951001@bytedance.com>
Subject: [PATCH] virtio_blk: stop all virtqueues when 'virtblk_probe' fails
Date: Tue,  9 Jul 2024 15:50:53 +0800
Message-Id: <20240709075053.811-1-lixianming.19951001@bytedance.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: lixianming <lixianming.19951001@bytedance.com>

We have already enabled the queue in 'init_vq',
so we should stop all the virtqueues, just as
we do in 'virtblk_remove', when 'virtblk_probe'
fails

Signed-off-by: lixianming <lixianming.19951001@bytedance.com>
---
 drivers/block/virtio_blk.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 2351f411fa46..fb702be291c2 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -1559,6 +1559,8 @@ static int virtblk_probe(struct virtio_device *vdev)
 out_free_tags:
 	blk_mq_free_tag_set(&vblk->tag_set);
 out_free_vq:
+	virtio_reset_device(vdev);
+	vblk->vdev = NULL;
 	vdev->config->del_vqs(vdev);
 	kfree(vblk->vqs);
 out_free_vblk:
-- 
2.20.1

