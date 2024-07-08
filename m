Received: from out.smtpout.orange.fr (out-14.smtpout.orange.fr [193.252.22.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD3617C9E;
	Mon,  8 Jul 2024 18:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720464387; cv=none; b=EmXMiazvq6oc4GvWxVeD/26XnPn8F+hOf7786DPe3kf4tQN8FPexHtrE/VevUZ0US3oHsFwWMTmBzktHBWN8aLm0wURyNjbGMtnAzh6lvrjEwwWH8Lb1doJ5AbKOg5tpadhoCo6Gpxwm3INVCZtZKzKziy8k+J5aP3V9IsXsPd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720464387; c=relaxed/simple;
	bh=qhKBayIAPavSMW75aEM3zJFBTq4j3VWijVeLsHFc6bE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mF5exyT8mYmQbb0TdjpYY/jf24gwpWdJvmyS5bqC4KvY+JZW+hh19xat7C0lurpmohjA0xZpUCJIA3atDcugCmRofY3p8hpnx3eC3FlLynHIEK7Fddi9buEbTp9xnxFh0g7OVoznFFdYTew3xV37Vo+V81h+h/F2QivG3YqASu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=myuGue4s; arc=none smtp.client-ip=193.252.22.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="myuGue4s"
Received: from fedora.home ([86.243.222.230])
	by smtp.orange.fr with ESMTPA
	id QsprsV0CzZLaOQspssvWtF; Mon, 08 Jul 2024 20:11:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1720462296;
	bh=krSibVlXs2Xtz/4LEWDf2JDpcRVHt1a2jYVqAJYebcs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=myuGue4s1pukqR07LJDpCxc11AGXJ4/MLDGGJ/h9rppxkYq/auADyRTiP42xlwiVo
	 NjvawSS23pOqRM4r0jwEn71PnICPoL9r1H3MYNm5DgtLJO/QZ1cUSepN0wb85FYafp
	 0ACf17Rtk15N4iWRE3w+x6uvcWPkfy7urwBe/JEIq0dkBh3fiuy2IDgFWT8i3KDrt7
	 yUjxGM0taYXeZLyX8cyecR9CEiISmAf8CveSqqwBLkrDn/p+M/fi9Lc9wfFLi5F627
	 MYkNPFG6gQZjSKmqhjPNa/TBnHJ9Sq76K1NNLuacKQfwnQXwapHSi8G2DFY+Afb+NW
	 dDrAYKK1AUecQ==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 08 Jul 2024 20:11:36 +0200
X-ME-IP: 86.243.222.230
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
	Jack Wang <jinpu.wang@ionos.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-block@vger.kernel.org
Subject: [PATCH] block/rnbd: Constify struct kobj_type
Date: Mon,  8 Jul 2024 20:11:30 +0200
Message-ID: <e3d454173ffad30726c9351810d3aa7b75122711.1720462252.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'struct kobj_type' is not modified in this driver. It is only used with
kobject_init_and_add() which takes a "const struct kobj_type *" parameter.

Constifying this structure moves some data to a read-only section, so
increase overall security.

On a x86_64, with allmodconfig, as an example:
Before:
======
   text	   data	    bss	    dec	    hex	filename
   4082	    792	      8	   4882	   1312	drivers/block/rnbd/rnbd-srv-sysfs.o

After:
=====
   text	   data	    bss	    dec	    hex	filename
   4210	    672	      8	   4890	   131a	drivers/block/rnbd/rnbd-srv-sysfs.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested-only
---
 drivers/block/rnbd/rnbd-clt-sysfs.c | 2 +-
 drivers/block/rnbd/rnbd-srv-sysfs.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-clt-sysfs.c b/drivers/block/rnbd/rnbd-clt-sysfs.c
index 39887556cf95..6ea7c12e3a87 100644
--- a/drivers/block/rnbd/rnbd-clt-sysfs.c
+++ b/drivers/block/rnbd/rnbd-clt-sysfs.c
@@ -475,7 +475,7 @@ void rnbd_clt_remove_dev_symlink(struct rnbd_clt_dev *dev)
 	}
 }
 
-static struct kobj_type rnbd_dev_ktype = {
+static const struct kobj_type rnbd_dev_ktype = {
 	.sysfs_ops      = &kobj_sysfs_ops,
 	.default_groups = rnbd_dev_groups,
 };
diff --git a/drivers/block/rnbd/rnbd-srv-sysfs.c b/drivers/block/rnbd/rnbd-srv-sysfs.c
index cba6ba43c2c2..64780094442c 100644
--- a/drivers/block/rnbd/rnbd-srv-sysfs.c
+++ b/drivers/block/rnbd/rnbd-srv-sysfs.c
@@ -33,7 +33,7 @@ static void rnbd_srv_dev_release(struct kobject *kobj)
 	kfree(dev);
 }
 
-static struct kobj_type dev_ktype = {
+static const struct kobj_type dev_ktype = {
 	.sysfs_ops = &kobj_sysfs_ops,
 	.release = rnbd_srv_dev_release
 };
@@ -184,7 +184,7 @@ static void rnbd_srv_sess_dev_release(struct kobject *kobj)
 	rnbd_destroy_sess_dev(sess_dev, sess_dev->keep_id);
 }
 
-static struct kobj_type rnbd_srv_sess_dev_ktype = {
+static const struct kobj_type rnbd_srv_sess_dev_ktype = {
 	.sysfs_ops	= &kobj_sysfs_ops,
 	.release	= rnbd_srv_sess_dev_release,
 };
-- 
2.45.2

