Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A261F39936D
	for <linux-block@vger.kernel.org>; Wed,  8 Jul 2026 10:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783508237; cv=none; b=YXVG9j+PkFDndk33F2D3aY/QGEpDRssjb9NWm8O+PG7iBTQXx/uFV8a41Er39rTq/YyMNDTdnPASIGx0b/Fh1Ax1vlPKwPdglUxs4rRsghM51up+BwATOsi1ifmPvdy21HHYKUxCaEqtwS6KFpJqyyv9jOuBLpkogMU3h1S+mW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783508237; c=relaxed/simple;
	bh=kBUME9+6xIyWuaIS3fhzOwBqwuFrfcS707RgECLo/iY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p+/+2Ea1mJ1FCuBN6dPwTnByOTveQJyCF6bBdRGnq10bKqRxsOcxaMzqgd8yxKsNpO757gz7zHLhm4QDLkaiGLk03OyHE23+r6zBP+t+NwlN7G/3nWp6o2sIGtYyRdBvlZlw7reghbwG/HvEfrgHNOE2merZPCjf2PiooIcGs60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c5XsicPn; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c5XsicPn"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cc7e86e7aeso5827045ad.2
        for <linux-block@vger.kernel.org>; Wed, 08 Jul 2026 03:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783508232; x=1784113032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5aYPVA5+Id6wN+hTSn6+3yuMuC7pfUDdgUd36EQG3A8=;
        b=c5XsicPnW7j9j+g9Abapi85qxuzTIFv4r22q2ftKqLqqfa+L2JCIlgUaG8EfkdN6oS
         h/9fLhe0FOC3tQrVFbCOODuZ974/gstS1MqoOZZUFldVCRXo9CdfbaGO/Tv0Joy3jeSw
         ystcjeHIx0p25hnpRzNKAmRg4Bvzyr39TRlSM065FkxtODASmguXNnckt6sWC+CznPYn
         DJIzMpglwzwqY0bBhQzJSreBe9kqlmViTT7J4Hoq6TgSxS/x8zc14Ksoh3G+03XshB2z
         C8lYf2cZMSEJVVhqCnYe8Ua6TMQ6dUBWUY+XK/XrIFd5mf/urr5kJ4du6AhLr5JyZRUB
         /MMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783508232; x=1784113032;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5aYPVA5+Id6wN+hTSn6+3yuMuC7pfUDdgUd36EQG3A8=;
        b=iokD/4+U1Jjt21/eU/io1CQjQ/GiAx5IkFIzILeBj8qEEzKlrmou3xX61VAT6QsMC/
         ED1WpJ1MzDV26AofFhFlmKImjjZvY+Qj+tzb5H6s8nzIsStLmXC9G+kNS49Hs0g7eON9
         yJJsnfMUCQtgK5BnccKSReMh/B66PJyivlF6x292e9UWZ5Fe9t9LCt0GhrvdfehJus8E
         jlxUZ/Zo/LrQCbkVQgsAbabEDSKHP2rfD984VniJSNHaPt9oN0ZghXCiutYZE6xx8Fri
         gFdX8UiNWhGCYlnvXHloTQZVreFEMzIDLpyBD3tP1wo3eTi+TMaRsg7QdM4D5AZszTFZ
         Vh8Q==
X-Forwarded-Encrypted: i=1; AHgh+RoNm6GlCBoThKIX7UlJauk2SmwTrbLlW9eWcHW/NVvDNpex7hoCD/ZUUvhZz3vBUEpdYKjxk2pOr8dvcg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwU2zIkvaQbtrj5FDaYwlt8BALKvkCe163BA+GQy3vTQJ/q4mjJ
	abFA3BVx99oAaGbId0I4ais4onhuEC8TXc6kBTgugObDv2KWGb9vbQN6
X-Gm-Gg: AfdE7ckQYL7K64pYxAfuztOEUi54I4uwRlu+AxJZkaykVVY20QtrIxWZjej0D3Fd8Zf
	vCGXtkJBx9IRPgpPqzqIs9HaXD+ATctdQiD1NEzD339EagQ7UvhgSEyRRqq/zmIbNuZB/ByqWO9
	+1J291wRTfqSjQLxKI3w3Y/IAL4IVYqfa1HzIWTja307bbmqtqOsk141/DI8r0OAn4+nkeWdOQq
	cpwszWxTOjxQOy4nwfwmJ0t1qN59pEY7YRWllw3K4O02axKAWW8yDWYWGsmVsgH+S0/i+ZjReTV
	QrIXhUpBciCU1eAQQvzY+f9C+1EiX+Oavbnyh7gMZOdWHd3DZB8//gW3s/Rsrqxn9MP3vSpaLWf
	t41Z0HczC6wqggAVyE6MZuavSUZfNVlfZ6HhqDz72O9yM5oVZHeQ1BXwfMW1xRQyA4WwgQJDII/
	5XDg==
X-Received: by 2002:a17:902:f685:b0:2c9:e2c1:4fb5 with SMTP id d9443c01a7336-2ccea40b669mr19564265ad.22.1783508232135;
        Wed, 08 Jul 2026 03:57:12 -0700 (PDT)
Received: from lgs.. ([152.32.251.59])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc99cc5aasm26490935ad.0.2026.07.08.03.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 03:57:11 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Denis Efremov <efremov@linux.com>,
	Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>
Subject: [PATCH] floppy: unregister platform device on add_disk failure
Date: Wed,  8 Jul 2026 18:57:03 +0800
Message-ID: <20260708105703.747262-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The change referenced by the Fixes tag reverted a previous fix because
that fix added incorrect cleanup for the platform_device_register()
failure path.

However, reverting the whole change also removed the cleanup for a later
failure path. If platform_device_register() succeeds but device_add_disk()
fails, the current floppy platform device has already been registered and
registered[drive] has been set.

The common out_remove_drives path uses while (drive--), so it starts from
the previous drive and does not unregister the current one. As a result,
the platform device registered for the failing drive is leaked.

Unregister the current platform device directly on the device_add_disk()
failure path, where platform_device_register() is known to have
succeeded. Leave the platform_device_register() failure path unchanged.

Fixes: 895a9b37917d ("Revert "floppy: fix reference leak on platform_device_register() failure"")
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/block/floppy.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index f04397b8e381..7a34af534460 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -4729,8 +4729,11 @@ static int __init do_floppy_init(void)
 
 		err = device_add_disk(&floppy_device[drive].dev,
 				      disks[drive][0], NULL);
-		if (err)
+		if (err) {
+			platform_device_unregister(&floppy_device[drive]);
+			registered[drive] = false;
 			goto out_remove_drives;
+		}
 	}
 
 	return 0;
-- 
2.43.0

