Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F052D29E042;
	Tue, 15 Apr 2025 14:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744728923; cv=none; b=MKkhsz5dHWjS44GKR1nNXqaGQcScrrCG5Uldl1SwHoRTzmnVwb7A/GA9kxxPkRVHKNCV9t62ATraSIoR4g7yF8CpE+13z8WQcnoIwpCZ5rcuj3g7t/lnS1Gi56jZS5p9fbuOENJieybiuK8lOVR5I4ZGRUa1BC3+HZnLWS1D7JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744728923; c=relaxed/simple;
	bh=/4fQKNG7ZThRdPS8W+NDfn4K1XtNr/N3er3BGwyb5c4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=leGP9UvuENSzAP+i+BX6LVUajNI2FILgoqj5591jsD1nb+p1ThFz5aAeAqkGhFpSGrFkfb9DW0q6FP0Opb3fQeXTKvnpXpE8pUitDuhmatOSu+o6oH0jumHK2Z8zn3wDvnJIw++YaoUWCOCsA3SmJn1FRf+tqZKhj2Va6i2OVRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=K8+bYXci; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nMroUl67; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="K8+bYXci";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nMroUl67"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744728918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sORXXgGo11q0HFoO8JqYEm1slEujioCF3YjA6xNqDKM=;
	b=K8+bYXciJEz5Iw/bePoOe/OIy3GPJB3CQy2dpV5LNTiDQvghqJEjxi8mpoIH9V9KaVwfkd
	g6Uu0VPwNMggC/JKjsDt97BB5nk5YTqmSxBa+GHM9N/nDhxkDQ7O0v6SvVaThsvjsCwtpt
	YQOiGiLkoL+POAAxByOhH8FSRrwBSrmZqiWWFKYSH3SM8ko4kqR24/cjHoAbYlUvdK10GG
	M8pINRIhammQ8LUmvM+DG/5ImX3OAFK3LOCw2Sp1V7jgzejWI3+uCuGelg3dCGcWT/AU6g
	g61d663tT9uyAQHsa+1NvwxaTQwMBExMKr5ajUaoEmIEWkQFWPVk3UHWpXTcsA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744728918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sORXXgGo11q0HFoO8JqYEm1slEujioCF3YjA6xNqDKM=;
	b=nMroUl67uXF1Ps8M0XqyNxolTM3e2/EIzmcH2SJ4Wh1xWVyVp5JPyV7B9FBVJljVK5obfE
	j/cmk+ypky4txQBQ==
Date: Tue, 15 Apr 2025 16:55:06 +0200
Subject: [PATCH v3] loop: LOOP_SET_FD: send uevents for partitions
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250415-loop-uevent-changed-v3-1-60ff69ac6088@linutronix.de>
X-B4-Tracking: v=1; b=H4sIAElz/mcC/32OQQqDMBBFryJZNyWZGEu66j1KF1HHGpBEEg0W8
 e6NuihIkVn9Yd6bP5OA3mAg92wmHqMJxtkUxCUjVavtG6mpUybAQDLBbrRzrqcjRrQD3S9qqrU
 oFGtygUyQRPYeGzNt1ucr5daEwfnP9iTydXvui5ymQSWlBqFykI/O2HHwzprpWuP6Yuf5CV+Vo
 KpS8bKA+sCvnSL8euRc/vdA8rAqx0IrECXoo2dZli8SSwIjQgEAAA==
X-Change-ID: 20250307-loop-uevent-changed-aa3690f43e03
To: Jens Axboe <axboe@kernel.dk>, Martijn Coenen <maco@android.com>, 
 Alyssa Ross <hi@alyssa.is>, Christoph Hellwig <hch@lst.de>, 
 Greg KH <greg@kroah.com>, Jan Kara <jack@suse.cz>
Cc: John Ogness <john.ogness@linutronix.de>, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744728915; l=2155;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=/4fQKNG7ZThRdPS8W+NDfn4K1XtNr/N3er3BGwyb5c4=;
 b=HmkGcARamVEmalVkorOr2+8ny2ewAEsxjZcDfIp1Z0eg/XCmgnnIlCRgoHeIMVz7WYsMbOhvJ
 Nnl14SRj1o3ApFT1TZ0C07+AHyfDowD7rMaHaMKa36rrk3O6vkReG3H
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Remove the suppression of the uevents before scanning for partitions.
The partitions inherit their suppression settings from their parent device,
which lead to the uevents being dropped.

This is similar to the same changes for LOOP_CONFIGURE done in
commit bb430b694226 ("loop: LOOP_CONFIGURE: send uevents for partitions").

Fixes: 498ef5c777d9 ("loop: suppress uevents while reconfiguring the device")
Cc: stable@vger.kernel.org
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
Changes in v3:
- Rebase onto block/block-6.15
- Drop already applied patch "loop: properly send KOBJ_CHANGED uevent for disk device"
- Add patch to fix partition uevents for LOOP_SET_FD
- Link to v2: https://lore.kernel.org/r/20250415-loop-uevent-changed-v2-1-0c4e6a923b2a@linutronix.de

Changes in v2:
- Use correct Fixes tag
- Rework commit message slightly
- Rebase onto v6.15-rc1
- Link to v1: https://lore.kernel.org/r/20250317-loop-uevent-changed-v1-1-cb29cb91b62d@linutronix.de
---
 drivers/block/loop.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 3be7f00e7fc740da2745ffbccfcebe53eef2ddaa..e9ec7a45f3f2d1dd2a82b3506f3740089a20ae05 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -662,12 +662,12 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
 	 * dependency.
 	 */
 	fput(old_file);
+	dev_set_uevent_suppress(disk_to_dev(lo->lo_disk), 0);
 	if (partscan)
 		loop_reread_partitions(lo);
 
 	error = 0;
 done:
-	dev_set_uevent_suppress(disk_to_dev(lo->lo_disk), 0);
 	kobject_uevent(&disk_to_dev(lo->lo_disk)->kobj, KOBJ_CHANGE);
 	return error;
 
@@ -675,6 +675,7 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
 	loop_global_unlock(lo, is_loop);
 out_putf:
 	fput(file);
+	dev_set_uevent_suppress(disk_to_dev(lo->lo_disk), 0);
 	goto done;
 }
 

---
base-commit: 7ed2a771b5fb3edee9c4608181235c30b40bb042
change-id: 20250307-loop-uevent-changed-aa3690f43e03

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>

