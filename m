Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659FE82866
	for <linux-block@vger.kernel.org>; Fri,  5 Dec 2025 12:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764938866; cv=none; b=Ri5bkY4K0tMDUDG5yygXN3vjmgV/xDSeEC4GQA8kYI3BGk7SdCdiqPNFigRJIqs2CJaKMIk4xrf9eGOsBQS3s0Q9mNjUEjIPr/ytQdc0UPKKRjQ54RJliRlOTZqMXJBmkwazW3WBoqAAXhmpWX1B02bBZzLFrBwrArqvwt5+nS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764938866; c=relaxed/simple;
	bh=yXmMdGyLiVy86qzyJ7gUZNl8INxeQtmYxPAsb3G1MBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b7Hf+b/4lCUCM4f6Jk0pzqoLJBTlkDL2IR+TD1Rs4UWzkSTBYiod0le/VfVIkjFR/kBxbDPc1ngr8Dpt21c3ZBileaw/YAEMZHroD97zRcgzp1lWl6EDKPGsdCqPVxpUiJ5fQxKXYIo5Ui/sFSfdtrneW/nfC/x7ig+44H23UBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=H3JZkYZm; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="H3JZkYZm"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-42f762198cbso1367607f8f.3
        for <linux-block@vger.kernel.org>; Fri, 05 Dec 2025 04:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1764938860; x=1765543660; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=upVPQ6SYDZsmzlQH9LmAoZr81+Vy5FEMUIRftV8qJMk=;
        b=H3JZkYZmJufDTYsK6TubiTjhkhr9fKdbagWzaYshVblH8h9alXEOuyf0GXspbf5MSi
         KmVJT9lGm6biowiuQNSdLyLbQxhM7JG/K+HBj58OsFLx9un8otZN9XCO1NtsN/0+swkC
         ENEWCb7/lZQcCRexXPW8OLzloVgxj3mf5NOane3+h7hkaYO/ojBvEIm0GYg743XvI5um
         H1U8rd45IV6+Tc3Z3COlaERUtz6FDg1qIRYns2qoUPAzNcx9Yat4vYJ+XNRUW3QFxOtC
         OPqtjETmFEH5hxDzD2TwQ7GyRxbpqHHzs/idAifNQTzdaH4Dpt12zh9HUeWM8nZQJVYJ
         Ftaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764938860; x=1765543660;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=upVPQ6SYDZsmzlQH9LmAoZr81+Vy5FEMUIRftV8qJMk=;
        b=hVpsIwfX4KfJBSZI77M8wTtvALD9IIQoPXkPXfllher1OLTYJvyxcOCaL91LvWEiBs
         GGH24Ht9M1JzXkdl5Gkcap/xrmLuLN3xvdmUXqeGSVhwIJTiaBNXQHaNfOQ+2gzstGVG
         lFOz2L4NZnm3jNiKbi/5bzFIrfr6JjCQeL+x2zgImweDbImR7NwjW3N+Vqinlnb1pK/y
         z0QmMxorg9F4jCH+ewXcEDpnlGEodhZZshUa1v6vrnoNbFx2D2ff7JK2ApygKzNI5kIN
         fT7WuGkSfnm0RbLT4RfZIcYQIVdrIubrw5v2EABzJrRiI5bK4sZyuHphfiw2pZ7h18pT
         +7TQ==
X-Gm-Message-State: AOJu0YxXv0Eoj5dhO3BkfIPX3fR44RD/koFetb76oDzO468fu9s92lC+
	AFzuKV674hNAm6mqGWmStCnChAn+vKPHDBdfE/wI/X60j60krYtASeB3iL7YxwZA+6V1OcP4xCg
	huqHZ
X-Gm-Gg: ASbGncvsajpu1ZWwbE7CGAb+afroJLxucdfkUh4u73428bUrP2l83ViQuks/PnVyGvv
	UfV3u220qhTCxe0WwWkG4bjV/u65O7XuTXAUUhZ5+n/M3xM3pECiKCm2GLjOxF3ObnK3gEhaNSu
	lsC0c8GqLp9U2sgLWyu6dEyXuE468KGAqzfnWTnFPxyDEDW3xOVfc13yDgTqiDlwWijuxp8UMUE
	I3o/CJzuZZ+54zIUlVJps3dmFcaCEYxLg9HzQa4Xxt2IeYYNvXVtL+u7J7bnb1YVLXa2Me9uU1T
	a5CmXuBA1adcJmFKSGfCnBoZqLhq58sP9l1us/OPudjjHcusq1tklogJILeanBv6OWZ+GyP0G91
	zMP7plQ9xtAm1r2SMHt0uLjoJrhAUarCzkPvKqciIcA78NdKSGR+T0xtwNfW8fn3u1HlJnC2Yl4
	N2gM/PqeBpZw4wVtsnqxm38GegMvOJQUiVOcnS50t+z3gBt3n6/5sR40M4U5aWrZooysLwMlPG2
	YIyCPEPgk4T0g==
X-Google-Smtp-Source: AGHT+IEt/dJs7ZRnSWpP9QcdDpHL8Qy/ohT4cKFRCr0sk707pxIo2tWrA+hyMSHEg0lJI9bfQbqTUA==
X-Received: by 2002:a05:6000:144c:b0:42b:2e94:5a8f with SMTP id ffacd0b85a97d-42f7985c646mr7243521f8f.52.1764938859727;
        Fri, 05 Dec 2025 04:47:39 -0800 (PST)
Received: from lb03189.speedport.ip (p200300f00f28af70a31ee45bb042915f.dip0.t-ipconnect.de. [2003:f0:f28:af70:a31e:e45b:b042:915f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7cbfee66sm8540037f8f.11.2025.12.05.04.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 04:47:39 -0800 (PST)
From: Md Haris Iqbal <haris.iqbal@ionos.com>
To: linux-block@vger.kernel.org
Cc: axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	bvanassche@acm.org,
	haris.iqbal@ionos.com,
	jinpu.wang@ionos.com,
	grzegorz.prajsner@ionos.com,
	Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: [PATCH 2/6] block: rnbd: add .release to rnbd_dev_ktype
Date: Fri,  5 Dec 2025 13:47:29 +0100
Message-ID: <20251205124733.26358-3-haris.iqbal@ionos.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251205124733.26358-1-haris.iqbal@ionos.com>
References: <20251205124733.26358-1-haris.iqbal@ionos.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhu Yanjun <yanjun.zhu@linux.dev>

Every ktype must provides a .release function that will be called after
the last kobject_put.

Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
Reviewed-by: Md Haris Iqbal <haris.iqbal@ionos.com>
Signed-off-by: Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
---
 drivers/block/rnbd/rnbd-clt-sysfs.c |  8 ++++++++
 drivers/block/rnbd/rnbd-clt.c       | 18 ++++++++++--------
 2 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-clt-sysfs.c b/drivers/block/rnbd/rnbd-clt-sysfs.c
index 6ea7c12e3a87..144aea1466a4 100644
--- a/drivers/block/rnbd/rnbd-clt-sysfs.c
+++ b/drivers/block/rnbd/rnbd-clt-sysfs.c
@@ -475,9 +475,17 @@ void rnbd_clt_remove_dev_symlink(struct rnbd_clt_dev *dev)
 	}
 }
 
+static void rnbd_dev_release(struct kobject *kobj)
+{
+	struct rnbd_clt_dev *dev = container_of(kobj, struct rnbd_clt_dev, kobj);
+
+	kfree(dev);
+}
+
 static const struct kobj_type rnbd_dev_ktype = {
 	.sysfs_ops      = &kobj_sysfs_ops,
 	.default_groups = rnbd_dev_groups,
+	.release	= rnbd_dev_release,
 };
 
 static int rnbd_clt_add_dev_kobj(struct rnbd_clt_dev *dev)
diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
index f1409e54010a..085fe8dd1179 100644
--- a/drivers/block/rnbd/rnbd-clt.c
+++ b/drivers/block/rnbd/rnbd-clt.c
@@ -60,7 +60,9 @@ static void rnbd_clt_put_dev(struct rnbd_clt_dev *dev)
 	kfree(dev->pathname);
 	rnbd_clt_put_sess(dev->sess);
 	mutex_destroy(&dev->lock);
-	kfree(dev);
+
+	if (dev->kobj.state_initialized)
+		kobject_put(&dev->kobj);
 }
 
 static inline bool rnbd_clt_get_dev(struct rnbd_clt_dev *dev)
@@ -1514,7 +1516,7 @@ static bool insert_dev_if_not_exists_devpath(struct rnbd_clt_dev *dev)
 	return found;
 }
 
-static void delete_dev(struct rnbd_clt_dev *dev)
+static void rnbd_delete_dev(struct rnbd_clt_dev *dev)
 {
 	struct rnbd_clt_session *sess = dev->sess;
 
@@ -1635,7 +1637,7 @@ struct rnbd_clt_dev *rnbd_clt_map_device(const char *sessname,
 	kfree(rsp);
 	rnbd_put_iu(sess, iu);
 del_dev:
-	delete_dev(dev);
+	rnbd_delete_dev(dev);
 put_dev:
 	rnbd_clt_put_dev(dev);
 put_sess:
@@ -1644,13 +1646,13 @@ struct rnbd_clt_dev *rnbd_clt_map_device(const char *sessname,
 	return ERR_PTR(ret);
 }
 
-static void destroy_gen_disk(struct rnbd_clt_dev *dev)
+static void rnbd_destroy_gen_disk(struct rnbd_clt_dev *dev)
 {
 	del_gendisk(dev->gd);
 	put_disk(dev->gd);
 }
 
-static void destroy_sysfs(struct rnbd_clt_dev *dev,
+static void rnbd_destroy_sysfs(struct rnbd_clt_dev *dev,
 			  const struct attribute *sysfs_self)
 {
 	rnbd_clt_remove_dev_symlink(dev);
@@ -1688,9 +1690,9 @@ int rnbd_clt_unmap_device(struct rnbd_clt_dev *dev, bool force,
 	dev->dev_state = DEV_STATE_UNMAPPED;
 	mutex_unlock(&dev->lock);
 
-	delete_dev(dev);
-	destroy_sysfs(dev, sysfs_self);
-	destroy_gen_disk(dev);
+	rnbd_delete_dev(dev);
+	rnbd_destroy_sysfs(dev, sysfs_self);
+	rnbd_destroy_gen_disk(dev);
 	if (was_mapped && sess->rtrs)
 		send_msg_close(dev, dev->device_id, RTRS_PERMIT_WAIT);
 
-- 
2.43.0

