Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205880;
	b=eOe9FDyJWlRpNC1SdykGTSI1pU1sXTLvUrDmrmJUF0uucVwy1XpWPXTOXVYL4Eh/38AB
	 bwznQCHXcbBuDrcilMh1CYYaXEfjQLzMj7hrV/t7CeGXJfNfaaH/ZXZgX0+l0zGgEpvtw
	 7rldilHMvlNuHJxLNGGhAggeKk0I/Mt+qkG3euJ+RiVG2EkPg9DidxkVwELGu6u8XK+h4
	 FE5Z/IKsNnQE56h/HlL/7BksZPmVr8dfmrvbcmlYuUxfaeU1hxkEuLC5QsdrrjTPZLVBA
	 RTj2QJrwKFr3dHcbZp1tzWWF9mgb+Dh9OO4CwtWhtPE8Xe3zfsc1HTQXUVGoiuwMfAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205880;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=cv0SzPzJWKPySBuVNpg4GGorf8yT2G0mmwcag7EQCoo=;
	b=PkYTZKxbwwm4IulX0LgVuMUkrdhPXR6Tp3UfINlRkVuWlwMzMuESDzC+1/b+pOymuoqG
	 jhSZvNIp3Jx7rh7foHX/XIGQOrFJhYoxv9B+eUaXg2GG+5owxrlR0DH4jG4L0MuQgDjTX
	 PByXIn3/5Uvj5PuxRwn1ElLNr2tVTUdWOFTvm9CCXRoJYzOzR6SZCP6Yz1Phfu7qzKTQr
	 hRdvaS16eGo6Ae/f9z60UmvVRbzOLg2sYwgxHyROQufbPqk9Ev/L08eZQUu0Qi2rRtFdn
	 DliO+K7P1e+/HQvTZKJDkcj20QqHjuwKjsw1HjqRmDatqfh/50OyPVW8A23Ja/V0tQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=UTqSpAMk;
	arc=none smtp.remote-ip=209.85.210.47
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D981E606A31A
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 16:44:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D981E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=UTqSpAMk
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7f84a55e31aso753732a34.2
        for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 09:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793205879; x=1793810679; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cv0SzPzJWKPySBuVNpg4GGorf8yT2G0mmwcag7EQCoo=;
        b=UTqSpAMkoevcNJo+vLHZbuHzC64PJESj2nDKrh8nGgQXt/R2EBYkBDRbzsTOFohlXP
         Lx1OJx5BeklRJuYVbihGyhKVoRI7ySOERmvu0VLyUHZoxS/C0Ch9/Q1Lcn/GPWwRHr4s
         x2rKQTD/mJZcvTCTP1wYlYfHlyDLlFgiI2Tjc48S0v45f5MsEVnsbB9EeExfkcsKxNXa
         rWSscx38m9m2mYe2hFVUkb3040536slm3vcrjYA2bWP5nnvDWhrbAJwni9FCxNFbYvsb
         z1+MR9bpudh6xioQexmugKuBQs4XIt7/d9qhU8rEcYZEMALClnnNOmia+YDntbCkW/WI
         BpyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793205879; x=1793810679;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cv0SzPzJWKPySBuVNpg4GGorf8yT2G0mmwcag7EQCoo=;
        b=UnQwp4N2RoEvN5B8NAUpAVK8S9SfubakaMJBxf9b0MhsV4AlYdgKH0Q1w28MuLtzKd
         EGTehvv5W/R8uSItCb9+ANIWsDOFD0umdIrVcA15VOAxQj2G2+mktSmxUSG6MFWwmvOi
         rvqA8U5YicIAYjbgT8x3Jq4FvFMFQhIJBDeoWCif/cf9dHeFEOHpDlYv1niNT4bM3zgR
         Ira7JKvkeK7+N2B74dm00dyRzyzG1RgSTdGQMhiAKbFPene1xm9WyQmTqndYe9adcBaD
         Dq6YDK6pcIMq6eksijCMyqozK4tLsUJffWFwY2+8riX2zRdfwYyDNmx1pE1BKQh0GR5w
         hBjg==
X-Gm-Message-State: AFq9FYLR99uuMCq9cLFkxv54TdB+e9Jw1Uycb6jZZnhPAuhEiieZfTLQ
	YgncfyfIY2v52XDUKlK1bJ6Ycn825mhSF01aFA5uin2VG9Fe2gv+KicgeuiIAjrD6zM4OsAO/kk
	BiWtrj58=
X-Gm-Gg: AYBFou0r1QwCSTSAUscAG0PiGIDP/XA9C2iFqZ1koPgJ+GmhWhER5JGNgB31gn/4NRi
	d45qCf4+Or+4JySMCxn92seRZFspsKLLhP8Di9JETK26kn3PVjO0douHpvC/VgxeErCFdDVc5kc
	PZDE4U7DewTccXBhCtCuT2DdOvs+4/kbj4e2IWk1o2CzTrXdO/dOQrTFKKmZHd6B0ftgEDpUtt+
	Q338n8/yctoRrAsK2I9sWsPrPIjhcsF4Yz73ycQaiFq11n18nRUywobv3SjgmJZ0IpjWCQ/pNRd
	IPeFx3ysTcmk0tw5cMbpUHKvCuFJ7OGlY9EmXKBcIXH4/yBlNrxzhYiBZB3A2tEX9AGgdQ8YMi7
	9Ppusob8DC8XV4QIBklF4qxOsOJrDhr/iDvRSNoX95ZsuFNCi5KARcOs10Hx30hKnhG4iBw/Bxv
	u4l6SgliAAsEbvyq4BjBzxWTeehiZ7uyMv8yc4Lb5gFOosl0v3lNNRHLiI1FioPn3tZNVQ3i8iu
	IpvYs25bhp7g57DqHcjgVaiCJv2Ci0mIZUV0Xje+cEekP/X7So9M3HUm1LBEnEMBx9ogeY9nXhu
	yE9YNDY7z7nLYyo7Fd9DwLbxi5H7wLONxGmDfmMYPcuR6tZH3f6sam2ACOdKbuzPZ514H22FIw=
	=
X-Received: by 2002:a05:6830:25c5:b0:830:43b8:735f with SMTP id 46e09a7af769-85ac0fd301bmr2661235a34.25.1793205878904;
        Wed, 28 Oct 2026 09:44:38 -0700 (PDT)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85b20216828sm2416941a34.19.2026.10.28.09.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:44:38 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	"Md. Haris Iqbal" <haris.iqbal@ionos.com>,
	Jack Wang <jinpu.wang@ionos.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 16/98] block/rnbd-srv: don't free the device on a sysfs error
Date: Wed, 28 Oct 2026 10:41:19 -0600
Message-ID: <20261028164415.1262013-17-axboe@kernel.dk>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261028164415.1262013-1-axboe@kernel.dk>
References: <20261028164415.1262013-1-axboe@kernel.dk>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Josef Bacik <josef@toxicpanda.com>

rnbd_srv_create_dev_sysfs() drops the only kobject reference on its
error paths, and the release function frees the rnbd_srv_dev.
process_msg_open() keeps using it and ends in destroy_device() with a
list_del() and a second kfree(). This doesn't need memory pressure: a
client opening a device while its last mapping goes away gets -EEXIST
from kobject_add() against the old directory.

Only undo kobject_add() on failure and leave the reference to
destroy_device(). Initialise the kobject once, the next open retries.

Fixes: 8cee532f469b ("block/rnbd: server: sysfs interface functions")
Fixes: d3a95ccaaf4d ("block/rnbd: call kobject_put in the failure path")
Cc: "Md. Haris Iqbal" <haris.iqbal@ionos.com>
Cc: Jack Wang <jinpu.wang@ionos.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/block/rnbd/rnbd-srv-sysfs.c | 16 ++++++++++------
 drivers/block/rnbd/rnbd-srv.c       |  3 +++
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-srv-sysfs.c b/drivers/block/rnbd/rnbd-srv-sysfs.c
index 64780094442c..33d5d1738be5 100644
--- a/drivers/block/rnbd/rnbd-srv-sysfs.c
+++ b/drivers/block/rnbd/rnbd-srv-sysfs.c
@@ -44,12 +44,17 @@ int rnbd_srv_create_dev_sysfs(struct rnbd_srv_dev *dev,
 	struct kobject *bdev_kobj;
 	int ret;
 
-	ret = kobject_init_and_add(&dev->dev_kobj, &dev_ktype,
-				   rnbd_devs_kobj, "%pg", bdev);
-	if (ret) {
-		kobject_put(&dev->dev_kobj);
+	/*
+	 * The release function frees the device, which the caller goes on
+	 * using and which others may share: never drop the reference of the
+	 * kobject here. That is for destroy_device().
+	 */
+	if (!dev->dev_kobj.state_initialized)
+		kobject_init(&dev->dev_kobj, &dev_ktype);
+
+	ret = kobject_add(&dev->dev_kobj, rnbd_devs_kobj, "%pg", bdev);
+	if (ret)
 		return ret;
-	}
 
 	dev->dev_sessions_kobj = kobject_create_and_add("sessions",
 							&dev->dev_kobj);
@@ -69,7 +74,6 @@ int rnbd_srv_create_dev_sysfs(struct rnbd_srv_dev *dev,
 	kobject_put(dev->dev_sessions_kobj);
 free_dev_kobj:
 	kobject_del(&dev->dev_kobj);
-	kobject_put(&dev->dev_kobj);
 	return ret;
 }
 
diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.c
index 79c9a5fb418f..2b0619389fc9 100644
--- a/drivers/block/rnbd/rnbd-srv.c
+++ b/drivers/block/rnbd/rnbd-srv.c
@@ -208,6 +208,9 @@ static void destroy_device(struct kref *kref)
 		 * Destroy kobj only if it was really created.
 		 */
 		rnbd_srv_destroy_dev_sysfs(dev);
+	else if (dev->dev_kobj.state_initialized)
+		/* The files could not be created. Frees the name, too. */
+		kobject_put(&dev->dev_kobj);
 	else
 		kfree(dev);
 }
-- 
2.56.0

