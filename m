Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D892820322;
	Mon, 17 Mar 2025 14:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742220812; cv=none; b=r8C8iYAxTlVluYmQYTZc/1cX00+CdM0wNXJ6aDIw36peWPAGdV3XXi4be47Fby05rIVFm4ch0D5M/9nCx0J5Xbr/6PIYqxjE+vSr91EnuHRzFkSEmbPdBIdOeAEwrf0c95GfuovVYF+DytZyUh2bk7aeBGuakqouJUTnybTdaP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742220812; c=relaxed/simple;
	bh=Hpdcypjt0ZbNYUdHGey6gpoTcz3DMDSTuv0leQ5C0HE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=AV5FC+Cv3OIb+xr/qNKKG2qS7DBmM+PNQQJk14kldTuCb53xoJpPQhkqsNWJQgzxSoL0EVX2JN+B/QvE18ZMtJx31ioB9ItqGkx1tMcDzFUxClsEc0Q6UzzRIQXVmd/nKN1V9D8AANC53AuEuezjkHDXpwzvEL1u6tgQN6gl0v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TzYCnaTd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Cr7WxoOe; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TzYCnaTd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Cr7WxoOe"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742220809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EtclTXwOSCMg5QOeKYXMx4COUFyfI8/aHYlSBvUgGug=;
	b=TzYCnaTdWzV3lR+LbCsvEXfYiozktCDRcAjuEJRTFaKJX21f1jRAeEEWrSmmwM693xOcZj
	2LYKAtFqBlOpqv7KfpCqL2RmmlMHcQn5uBC/EpYh20HASDiCqSZRVz8SKgx3h0+0kLs0f4
	rLCmkHMHGUOKDFGBMCSyZlFp2qXw++J3Whcu0AZWM9WafvunhtnOuGvfj/iSXg7m97k/JX
	IE98Ukjxml0QJay26gx3Qo/HKuXQor/S+VxpLA7zycAkUjvQMChVQ+egsa8mNTmI/7ST64
	9cpjR30crg9kNbyKef84j5u/TbML0mAPVNiXWUl8FmZH4uf3EL4HkwYco0F1+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742220809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EtclTXwOSCMg5QOeKYXMx4COUFyfI8/aHYlSBvUgGug=;
	b=Cr7WxoOe6k9vgW/OwIAFPJXvkXXDWam+Q5QI+HAYPBEKwogwSrCNLAFJK7AloA6dPmU0XD
	lRnFLnNMiYbyqmAA==
Date: Mon, 17 Mar 2025 15:13:25 +0100
Subject: [PATCH] loop: Properly send KOBJ_CHANGED uevent for disk device
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250317-loop-uevent-changed-v1-1-cb29cb91b62d@linutronix.de>
X-B4-Tracking: v=1; b=H4sIAAQu2GcC/32Nyw7CIBBFf6WZtRgeRYMr/8N0QWRqJ2mgAUpqG
 v5drHtzV+fmPnZIGAkT3LodIhZKFHwDcergOVn/QkauMUguNVf8yuYQFrZiQZ/ZL+GYtepi+Ng
 r5Apac4k40nasPobGE6Uc4vs4KeLr/t8rgjWh0dpKZXqp7zP5NcfgaTs7hKHW+gFGqDT0ugAAA
 A==
X-Change-ID: 20250307-loop-uevent-changed-aa3690f43e03
To: Jens Axboe <axboe@kernel.dk>, Martijn Coenen <maco@android.com>, 
 Alyssa Ross <hi@alyssa.is>
Cc: John Ogness <john.ogness@linutronix.de>, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742220808; l=2095;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=Hpdcypjt0ZbNYUdHGey6gpoTcz3DMDSTuv0leQ5C0HE=;
 b=ZiaehUy4QRjIUsV2+NmlNt3mlBEdxOFbu0yZU+R2EUOO8E9PCR+ziupoxLo1EqSseZc+g9f8L
 XR1CUo90jEsDkbodaQktZN9z1XRXdwyXnqFtTUbzSN2/owDrtXrfL1g
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The wording "uncork" in the code comment indicates that it is expected that
the suppressed event instances are automatically sent after unsuppressing.
This is not the case, they are discarded.
In effect this means that no "changed" events are emitted on the device
itself by default. On the other hand each discovered partition does trigger
a "changed" event on the loop device itself. Therefore no event is emitted for
devices without partitions.

This leads to udev missing the device creation and prompting workarounds in
userspace, see the linked util-linux/losetup bug.

Explicitly emit the events and drop the confusingly worded comments.

Link: https://github.com/util-linux/util-linux/issues/2434
Fixes: 3448914e8cc5 ("loop: Add LOOP_CONFIGURE ioctl")
Cc: stable@vger.kernel.org
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 drivers/block/loop.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index c05fe27a96b64f1f1ea3868510fdd0c7f4937f55..fbc67ff29e07c15f2e3b3e225a4a37df016fe9de 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -654,8 +654,8 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
 
 	error = 0;
 done:
-	/* enable and uncork uevent now that we are done */
 	dev_set_uevent_suppress(disk_to_dev(lo->lo_disk), 0);
+	kobject_uevent(&disk_to_dev(lo->lo_disk)->kobj, KOBJ_CHANGE);
 	return error;
 
 out_err:
@@ -1115,8 +1115,8 @@ static int loop_configure(struct loop_device *lo, blk_mode_t mode,
 	if (partscan)
 		clear_bit(GD_SUPPRESS_PART_SCAN, &lo->lo_disk->state);
 
-	/* enable and uncork uevent now that we are done */
 	dev_set_uevent_suppress(disk_to_dev(lo->lo_disk), 0);
+	kobject_uevent(&disk_to_dev(lo->lo_disk)->kobj, KOBJ_CHANGE);
 
 	loop_global_unlock(lo, is_loop);
 	if (partscan)

---
base-commit: 4701f33a10702d5fc577c32434eb62adde0a1ae1
change-id: 20250307-loop-uevent-changed-aa3690f43e03

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>

