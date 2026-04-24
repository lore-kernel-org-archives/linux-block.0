Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E28F35DA77;
	Fri, 24 Apr 2026 10:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777027178; cv=none; b=sQcxsgGfR5+kGsqadnbdqVUJH2wGP/bWYYtNGMk0/GwnG8/DhYLkmn2v20eOxuzNCoMuZYMCI3mJYyGlzGD17AGkMHhAt/CJMsjkZ849Ip6Dk0FwX9VCHKubk+IG1sEycsvjwTwAzEdQfWQBNqded3gwDeyxBRqofTHifWZPb6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777027178; c=relaxed/simple;
	bh=WMZAm4Rkd/G6zoxhnbgT2Z4AwiPfeM55bL2lVaTdh78=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ofGa6Bobop94m1zHoZYxO7KoV6udD/KzgmRIZah4y9IeDMQhqc5WnV1WARQtT8ZL4kxjOv7/wwhZTt4D1jhw2eA0bH8mA+Kn+9xOiw+h9d8TeAmJyvL3cm6J0adfpZQW3YpHE5piQvH9/PmLh3FubL6SZ58VdRL7JPcj50CjRro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EQVyEK1/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EQVyEK1/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC18CC19425;
	Fri, 24 Apr 2026 10:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777027178;
	bh=WMZAm4Rkd/G6zoxhnbgT2Z4AwiPfeM55bL2lVaTdh78=;
	h=From:To:Cc:Subject:Date:From;
	b=EQVyEK1/uItUUuh5+Y9/o0f3/AC/iPssSPCn/kxSQSXYA3cZG6jGx2avMZyVzE0sv
	 Jz+Zuhj334/MJnaAGFX7he+xF/2GhDpVe5RKLnb3G3rGCqnqLY45CaYv3P/x0lyhek
	 3thKBDkjp9ioMcdCqm3nBQa/IYE4Ha0jLjHOt+Y/0KClVz61f+gsHCIMwr/iDtd1Fg
	 TSUa7LWlV3MHa8oMma0trlsEru5ZGj10LTnOgs7u40G9x8NvhA3Z8h3xocraBXpWfY
	 os1hz+Xj99U0Z70fQ9OxZNEYAjyMcerEeXY6ikZVzDqC8rumpkyW76UrSWf/gLOsG2
	 ZFv+R6c+N0Sfw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wGDwd-0000000AymI-3F8t;
	Fri, 24 Apr 2026 12:39:35 +0200
From: Johan Hovold <johan@kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Dongsheng Yang <dongsheng.yang@linux.dev>,
	Jens Axboe <axboe@kernel.dk>,
	ceph-devel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH] block: rbd: switch to dynamic root device
Date: Fri, 24 Apr 2026 12:39:31 +0200
Message-ID: <20260424103931.2616903-1-johan@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Driver core expects devices to be dynamically allocated and will, for
example, complain loudly when no release function has been provided.

Use root_device_register() to allocate and register the root device
instead of open coding using a static device.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/block/rbd.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index e7da06200c1e..ffab1b4e7c25 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -580,14 +580,7 @@ static const struct bus_type rbd_bus_type = {
 	.bus_groups	= rbd_bus_groups,
 };
 
-static void rbd_root_dev_release(struct device *dev)
-{
-}
-
-static struct device rbd_root_dev = {
-	.init_name =    "rbd",
-	.release =      rbd_root_dev_release,
-};
+static struct device *rbd_root_dev;
 
 static __printf(2, 3)
 void rbd_warn(struct rbd_device *rbd_dev, const char *fmt, ...)
@@ -5390,7 +5383,7 @@ static struct rbd_device *__rbd_dev_create(struct rbd_spec *spec)
 
 	rbd_dev->dev.bus = &rbd_bus_type;
 	rbd_dev->dev.type = &rbd_device_type;
-	rbd_dev->dev.parent = &rbd_root_dev;
+	rbd_dev->dev.parent = rbd_root_dev;
 	device_initialize(&rbd_dev->dev);
 
 	return rbd_dev;
@@ -7331,15 +7324,13 @@ static int __init rbd_sysfs_init(void)
 {
 	int ret;
 
-	ret = device_register(&rbd_root_dev);
-	if (ret < 0) {
-		put_device(&rbd_root_dev);
-		return ret;
-	}
+	rbd_root_dev = root_device_register("rbd");
+	if (IS_ERR(rbd_root_dev))
+		return PTR_ERR(rbd_root_dev);
 
 	ret = bus_register(&rbd_bus_type);
 	if (ret < 0)
-		device_unregister(&rbd_root_dev);
+		root_device_unregister(rbd_root_dev);
 
 	return ret;
 }
@@ -7347,7 +7338,7 @@ static int __init rbd_sysfs_init(void)
 static void __exit rbd_sysfs_cleanup(void)
 {
 	bus_unregister(&rbd_bus_type);
-	device_unregister(&rbd_root_dev);
+	root_device_unregister(rbd_root_dev);
 }
 
 static int __init rbd_slab_init(void)
-- 
2.53.0

