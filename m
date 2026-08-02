Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C4D19DF6A
	for <linux-block@vger.kernel.org>; Sun,  2 Aug 2026 03:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785640532; cv=none; b=seBpIdKSQrwIESYoA6VCn2yEnFT3KAEq2sSpkDTTn4RZd+T4ZX5GR4BUD79WClqsPsFo0jo+8oXUVLT6wZMcD+7NHZoxgYOGBh8IMnviPHyB/HO50mnVLJ4JFm5jy3iEumLEXPvwEFKCTvcsXixgN6rbm4eQ//jLofU8QLEdR1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785640532; c=relaxed/simple;
	bh=83pfoVdZbW5Vz1QhwKcrGUXLYnXaQkCQyi8dnppnJ5M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gRQ0z/tCS2ohMLQkp9d2a4hG04Wqb/bN8//BUtLXyaagDndfVI2qRLcoKCgOPN5Le4sLqvNhr1uqrS8T9q12R1TWM0OciEkzZ+0mmDLN8Qk+1tX1CY5oQMM8Zx004q3l8BMC/gVc6eN8CFj4X3FakNEvX8BlLni9ldmecOAtJzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l69cr+KG; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l69cr+KG"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-5276d598b96so10778131cf.3
        for <linux-block@vger.kernel.org>; Sat, 01 Aug 2026 20:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785640528; x=1786245328; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=e3IfyNkgW9IQAsL2Zxr0BNiKaqjF2nRfAzM5DfsWas4=;
        b=l69cr+KGd6sMtmcGD5/XX2RUa8FobkKjm1YIzGwmjMwmwqM5DgBvOhHOkoAdZMLSag
         j8+2ecfrQqMnB2AaIxKqehO8M5aFKhoiEEtaBr8nD7dIOkojaXInASeAPx5uCrLrMIEh
         dJ6BlUGokPUiVuNyi2xivxWegfb/xwCNtTvZHP2eoZ0FlhuBjvGCkbqVaVVBQCtVETMA
         kqlytz+aSWTQlUpMZ7SsmgNKaGc4hTaADGTQ/7Wgknc/dIxB1oU7QCTJT11yLawvOHZQ
         SMPF28QCFltmjubGNYyGhoYPcoHR4pix9vhLi9gNdOdLV7Uy5aAUoVd7o25TNh9UQoB/
         epNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785640528; x=1786245328;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e3IfyNkgW9IQAsL2Zxr0BNiKaqjF2nRfAzM5DfsWas4=;
        b=kaJK0y5Sp0hibbjLjZI/5mxqnR3k1UN12i0etg1rcjIoIuEzPHw9AbKpm5oKGJXlh1
         DeTIdBBdHKxh+ATLsjA4Ce3vp0G9a/f7uK22EF4JymEla/6A7CK+KBEv2MBtd2cS7fYy
         L8y9a4UsYvPk004c65jzPn2P8pUn/mU7sP3w98F9+163PJGZrj4OJLoWFZABHrWc3fRJ
         gwGTIybKlqtJpuRT3Wy46+XoMdPjY+Kvcxi0WntgN6/IZtku3OYiJIZYeSPHbD7GfHck
         x8msDvbDVKe7OIDVDhpl8KsQG8HxILiJZx026QrtVK+MAlrIZooxwIYJM379Z1vIU2VY
         xLGg==
X-Gm-Message-State: AOJu0YwgeodoRE2+U76z6eyhoYJJqHBvDm9FDP0Tb5Wr73v264Fnn+WO
	HiyBYjmH4w/B6HFk8YqJzB5187mcXwuJOppulG3PgC1Ivb3j9QGNiDJC
X-Gm-Gg: AR+sD11yBKuaoKNoJAk0FEQ88iByljTjXR/mioSCQKsuG94StTosycwsIWnGyytiVNQ
	W7eQ7gD00m+lnWaR99ZnZjmetGRT8hd0J54JE7QfsfuwHs2/pt2jS2lrbzFWNzec8JcDVTFJRvC
	mbui0OY7VgKScl2bfXT0TuAa6EsvAOk3j+4mXCLiXEkhyY+lPjHitWjFnTFUv/JulU5KZ04aC4Z
	Smcws0XKmbQu+F6oGJnLCpMRTwUuzMMkt4jjFw5zud+yGI9fb4PWvQLTF745qHn6F/tLBJjK8+Y
	M3sm1L1vqPFzuG1p29TupwdukoHVCNgA5TIQoJygYt6VwTgF+/XKa8PAmAcXQgLNTY8o/Re4BHQ
	gjA/LQ79qjS+3EDd+twJ3c9ISVLdLGkPf8LQiyy6QLk3K8ggpdCnw0+Fz2RWBp7Uo6taYBYrj3y
	gJVR08iMYyayWNtUzeuzoHYS60wCUre3p6dGHl8QuuKMMZHELH7E2f0Sm0Ihn8/lgsJibmhVvd4
	cidi791E3eUaRnJpA==
X-Received: by 2002:ac8:5714:0:b0:528:15e:d1d1 with SMTP id d75a77b69052e-52b56737b31mr103627351cf.16.1785640527964;
        Sat, 01 Aug 2026 20:15:27 -0700 (PDT)
Received: from i4-l-hqh5357-03.ad.psu.edu ([130.203.139.71])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52b4e64df9bsm37039851cf.0.2026.08.01.20.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 20:15:27 -0700 (PDT)
From: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
To: "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
	Jack Wang <jinpu.wang@ionos.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shuangpeng Bai <shuangpeng.kernel@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] rnbd-clt: fix use-after-free on device sysfs creation failure
Date: Sat,  1 Aug 2026 23:13:50 -0400
Message-ID: <20260802031350.1468599-1-shuangpeng.kernel@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rnbd_clt_add_dev_kobj() initializes dev->kobj and adds it below the
gendisk kobject after rnbd_clt_map_device() has returned a live
rnbd_clt_dev to rnbd_clt_map_device_store().

If kobject_init_and_add() fails, the helper currently calls
kobject_put() on the embedded kobject. That put can drop the initial
kobject reference and run rnbd_dev_release(), freeing dev. The caller
then continues through the normal error path and calls
rnbd_clt_unmap_device(dev, true, NULL), dereferencing the freed device.

Leave the initialized kobject alive until the normal device teardown has
completed and rnbd_clt_put_dev() drops the final device reference. Since
kobject_init_and_add() failure can leave the kobject initialized but not
present in sysfs, only call kobject_del() from rnbd_destroy_sysfs() when
state_in_sysfs is set.

Fixes: 581cf833cac4 ("block: rnbd: add .release to rnbd_dev_ktype")
Cc: stable@vger.kernel.org
Signed-off-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
---
 drivers/block/rnbd/rnbd-clt-sysfs.c | 2 +-
 drivers/block/rnbd/rnbd-clt.c       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-clt-sysfs.c b/drivers/block/rnbd/rnbd-clt-sysfs.c
index eb485e4c12e2..9f5d30659f3d 100644
--- a/drivers/block/rnbd/rnbd-clt-sysfs.c
+++ b/drivers/block/rnbd/rnbd-clt-sysfs.c
@@ -498,7 +498,7 @@ static int rnbd_clt_add_dev_kobj(struct rnbd_clt_dev *dev)
 	if (ret) {
 		rnbd_clt_err(dev, "Failed to create device sysfs dir, err: %d\n",
 			      ret);
-		kobject_put(&dev->kobj);
+		return ret;
 	}
 	kobject_uevent(gd_kobj, KOBJ_ONLINE);
 
diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
index 4d6725a0035e..5fe5c7e259b7 100644
--- a/drivers/block/rnbd/rnbd-clt.c
+++ b/drivers/block/rnbd/rnbd-clt.c
@@ -1658,7 +1658,7 @@ static void rnbd_destroy_sysfs(struct rnbd_clt_dev *dev,
 			  const struct attribute *sysfs_self)
 {
 	rnbd_clt_remove_dev_symlink(dev);
-	if (dev->kobj.state_initialized) {
+	if (dev->kobj.state_in_sysfs) {
 		if (sysfs_self)
 			/* To avoid deadlock firstly remove itself */
 			sysfs_remove_file_self(&dev->kobj, sysfs_self);
-- 
2.43.0

