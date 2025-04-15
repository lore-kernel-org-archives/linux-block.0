Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD13A1DDC18;
	Tue, 15 Apr 2025 08:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744707115; cv=none; b=eD+4+NxsnHeOewkZsBiKd8LsCw3X6TI7U+Fb14faPvmxXBlfaMHRuc9hNsOPqXqq3EOfMe89+e3EcpiZDaG7FMAbwcHsvtYwo/3ROIF6azqx6nscACyNlUpwzh8cJDboMi+0HP2gBu45tSbbCCyvrlDhVPQ9EKmP7EGB9+fKYjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744707115; c=relaxed/simple;
	bh=l6EgTfG/rNsxzj7YblsFEs3VRkJDgFjjSVvMIbcaSIM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ICCQUW5t4yzmDOIIo7TYAA/yNN4I+IG21qf2H14qvdSMoxbkz4niRqVdXPS6ub3z6LvJvNhWE11w3uXascMxQezaT74vxJ6/tHAXphQu19Zd2IBMI2SFrefJODsdrTIVEjg7L45XqlCC3bd9Ce9gKUaKLs7fhka1uN9sckVTbmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3C+0xkhw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+P38YhTz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3C+0xkhw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+P38YhTz"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744707110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PH6MVwxzLv8eF6loMN8LTTQbGVnttpn8SLDX1xC+Qgo=;
	b=3C+0xkhwu9H2ovaJRCfJTMtbdFS7iCD2T4FpT9OJGXFsPq/iLIkH0PqAZreWqL5FMOAb+N
	oG3T6qoACEytO6vKHY4CMSDNryYfgXO38RkI+7Mt8gPaqoPK6k4sjsT8TEXCFOSTz4eKH+
	hHNLebtwTopStnDrX+vkK/Qd7v7Cc5jfSGi9kYi2CVL1ZzON0/sZEbXh/C2Gl3ZUyUHfGt
	nDZ6ed2xg7262wzHPTOZJ6MjfkEXQWJrYNS28LurtZv4w6kyA/lDr/QLTij1z2+MMWLzGk
	kF6TEJX7x4UA0fJfxDCoiVAai7fQAxCPaVM85HHI3Ge2VOMyEPnRQQtkCifpag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744707110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PH6MVwxzLv8eF6loMN8LTTQbGVnttpn8SLDX1xC+Qgo=;
	b=+P38YhTzlVHayzy4c8rI89g2bBdDxGSgZljqDHmgDLArlQpeWoCpZmeBSOhdrBHmHBIRaZ
	GZYS2M0YJwyVOHCQ==
Date: Tue, 15 Apr 2025 10:51:47 +0200
Subject: [PATCH v2] loop: properly send KOBJ_CHANGED uevent for disk device
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250415-loop-uevent-changed-v2-1-0c4e6a923b2a@linutronix.de>
X-B4-Tracking: v=1; b=H4sIACIe/mcC/32NywqDMBBFf0WybkoexpKu+h/FRTRjHZBEEg0W8
 d8bddeFzOoM99y7kggBIZJnsZIACSN6l0HcCtL2xn2Aos1MBBOKSfagg/cjnSGBm+iZsNQYWWn
 WlRKYJNkcA3S4HK3vOnOPcfLhe4wkvn+v+xKn+UArZYTUpVCvAd08Be9wuVvYJ06fX/htI3Tba
 N5Uwv759bZtP8wS5cz6AAAA
X-Change-ID: 20250307-loop-uevent-changed-aa3690f43e03
To: Jens Axboe <axboe@kernel.dk>, Martijn Coenen <maco@android.com>, 
 Alyssa Ross <hi@alyssa.is>, Christoph Hellwig <hch@lst.de>, 
 Greg KH <greg@kroah.com>, Jan Kara <jack@suse.cz>
Cc: John Ogness <john.ogness@linutronix.de>, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744707109; l=2327;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=l6EgTfG/rNsxzj7YblsFEs3VRkJDgFjjSVvMIbcaSIM=;
 b=f16o4dJg2nliQLGkEQn1igGREQ/SBPg0rQ+5p2AI7Bx/+OeMl6YOVVVsFs3xLBUycq/uUH9WA
 YIUJ6Uobe/+AaKmVyFyCbbkVVnpvahZfF1NfVp2x4dyAGyKPZ7kfwtH
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The original commit message and the wording "uncork" in the code comment
indicate that it is expected that the suppressed event instances are
automatically sent after unsuppressing.
This is not the case, instead they are discarded.
In effect this means that no "changed" events are emitted on the device
itself by default.
While each discovered partition does trigger a changed event on the
device, devices without partitions don't have any event emitted.

This makes udev miss the device creation and prompted workarounds in
userspace. See the linked util-linux/losetup bug.

Explicitly emit the events and drop the confusingly worded comments.

Link: https://github.com/util-linux/util-linux/issues/2434
Fixes: 498ef5c777d9 ("loop: suppress uevents while reconfiguring the device")
Cc: stable@vger.kernel.org
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
Changes in v2:
- Use correct Fixes tag
- Rework commit message slightly
- Rebase onto v6.15-rc1
- Link to v1: https://lore.kernel.org/r/20250317-loop-uevent-changed-v1-1-cb29cb91b62d@linutronix.de
---
 drivers/block/loop.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 674527d770dc669e982a2b441af1171559aa427c..09a725710a21171e0adf5888f929ccaf94e98992 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -667,8 +667,8 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
 
 	error = 0;
 done:
-	/* enable and uncork uevent now that we are done */
 	dev_set_uevent_suppress(disk_to_dev(lo->lo_disk), 0);
+	kobject_uevent(&disk_to_dev(lo->lo_disk)->kobj, KOBJ_CHANGE);
 	return error;
 
 out_err:
@@ -1129,8 +1129,8 @@ static int loop_configure(struct loop_device *lo, blk_mode_t mode,
 	if (partscan)
 		clear_bit(GD_SUPPRESS_PART_SCAN, &lo->lo_disk->state);
 
-	/* enable and uncork uevent now that we are done */
 	dev_set_uevent_suppress(disk_to_dev(lo->lo_disk), 0);
+	kobject_uevent(&disk_to_dev(lo->lo_disk)->kobj, KOBJ_CHANGE);
 
 	loop_global_unlock(lo, is_loop);
 	if (partscan)

---
base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
change-id: 20250307-loop-uevent-changed-aa3690f43e03

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>

