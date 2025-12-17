Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A718A342524
	for <linux-block@vger.kernel.org>; Wed, 17 Dec 2025 09:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765964230; cv=none; b=oNpQh564LDX7lKLJKWp8/gJc+Au91qpUf/v1PmJOU4WIcMF6pyTYHx2aAv1YCqegS9rjxpB1jYadSBbRgTyhR0BPxPK3Jc3mDA8aNY3PTjbwGQmu44jixGtZ4r88hzXACwDeCW9tkaIovc+8HGvYphnuc3oLNqRpnGr63ET2Qxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765964230; c=relaxed/simple;
	bh=ADLWZB7heMvI8C75+SC62FWj4QS0Sqtg+MDBZq15gwU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bUP2RrD7gGx1NZ3UqTQYZ/Otww+2tYDkbE4/hSccdsjenPmkEDLnbWAt4c15opBQMuiL2LUQyaq1nd3SfLNvcL3PBV72fRHkVbf1oQ/k39/ho4Vbql3wkgDQAKnSSv4i6NUkt+F5JoXpjha79lQhep/CX5T46U+BK/PBCiWWb4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SBJNXi3A; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SBJNXi3A"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4779c9109ceso5251245e9.1
        for <linux-block@vger.kernel.org>; Wed, 17 Dec 2025 01:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765964226; x=1766569026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z1GOk404zfyFe5sUCnK+WQVcDYCJq/p7/vBWn+8ExHM=;
        b=SBJNXi3ASWHbgGJylnJ3AEY9CcismYr44Ta4PWdOrVv4dx9FKjg7/4ouhOp57R49aD
         d90BZicsaFq/W8qwLLz6U1byxcgytYtYVVrKwdUOl7Ifh9h2IHavoeIEkOYbaSbSsRbz
         zFOzb9EqpL2oiACatE/8lB5bfPq9egtHHKCxLEXOrNTqihxlK+gtzVSK/4gGVjrDmOA/
         +l9gEp7L+kH+kUiqk4up6TLLDuqWVMoF0J7ptppNcBe/Si4PYakaBQ52k56BNDR0pEla
         ZrYqYRjNHqLUdppjvuxhBIDqk6OZXyaepJgV76RGe3et4H8gp7zeFD3Q8GCuT9ynTvn8
         vMIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765964226; x=1766569026;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z1GOk404zfyFe5sUCnK+WQVcDYCJq/p7/vBWn+8ExHM=;
        b=iynvf9YimkjFlLzE/u3rFPkdKOGciEgMftB+phR1apVtuf66FFu76c7r4hp/uThaq4
         GveFV3SKFBcypiYVJ7uiDk9AlUkbk2R0pwdWiBbPk/JHv0MP6uzqLVyo5g8bFDDzCUD7
         YrkTnaYym4FUlJDHn91Iaqz/h6OpGpnB2THg8P6Daaa+XIHJXAE9Daedoei0p6MCejlK
         I7a6pXYV2h6npnhS+vDLKAm09hLu/FVpm10WLEMcHTQ4Sbxszne5GU4Vuz+Nnli37HFx
         rkaGKEbCroryURr5DJgQyDyKpf6xEJJo5RtqmRUJy61H21ESaED47cH+Vklyl7s61KFq
         IpHg==
X-Forwarded-Encrypted: i=1; AJvYcCXmEFR9gt8f9WFKSV5qutBIptnR1mFDaJoOKQ2HggjLj//LYfD7hDP9TbmyeCQsTsMzqX39Hw9+agMq8w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwYR8V2UUB/FMYOwuHuT/ZWmhKHZ18s/Xygg/bA/d1ft2fiqnhi
	PeVyG8g2Fq2xm8zQzLFNpLxqPOkcrNh07LilaEDG7LviPDZvCMBr56Sp
X-Gm-Gg: AY/fxX5lu/0VFVOXcN7qWi0LigFNAWND5NvPh9H3nTDiMivE4BlSWjsnZj+omuivrm2
	Ptkmp8wGL/93NLDbDgIlj9TDJ8k8dxvyiAOgA/7qy2VGcOEPb+LYRuvJANkGQxNfy89yH8AGVJk
	P4D/FpUTs+Ck1deNwLloeKlMygnN0O5V0WcatDf8t9dvVIj9zW0KeKsa3V0x42hbEhqehUpShAA
	kYOVdOqySqF0mlyjxz5pWndgA3LB667Nv7kDw8Un+U04eiaGMxQTDO15y3oS20lSjW5rxZWh7h/
	85ZZNWbgU6Vw9jNVr7stPBiekAi95vdCKPSUzz6tzaHHArLNABR5l8GrMRcQ26nevXyu1RENkl/
	1r7fhik16t9M+7Dhf+LoZyWwsJZzQQ/hAXmCLA0PfuWztiX61Qu5V2Z5UZHa3p4wXThPTM1uhqk
	dLwRMjVWtYD6ymmQrA8KMc7JhakgviIwvM044o0VKRXh0oLVQBcnJw3yDtkktDp5wkSbQgQtOPY
	PTnniA=
X-Google-Smtp-Source: AGHT+IHgamaBo+e2Pgz14lTDAZNfZl8uQyf8niiu2ktv7qlyAEpoAjbF5VQVzy++0hTE9iQhnltqOg==
X-Received: by 2002:a05:600c:8b62:b0:471:1387:377e with SMTP id 5b1f17b1804b1-47a8f90f781mr120237745e9.6.1765964225630;
        Wed, 17 Dec 2025 01:37:05 -0800 (PST)
Received: from thomas-precision3591.paris.inria.fr (wifi-pro-83-215.paris.inria.fr. [128.93.83.215])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-47bdc1c2076sm29854865e9.3.2025.12.17.01.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 01:37:05 -0800 (PST)
From: Thomas Fourier <fourier.thomas@gmail.com>
To: 
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	"Md. Haris Iqbal" <haris.iqbal@ionos.com>,
	Jack Wang <jinpu.wang@ionos.com>,
	Jens Axboe <axboe@kernel.dk>,
	Md Haris Iqbal <haris.iqbal@cloud.ionos.com>,
	Lutz Pogrell <lutz.pogrell@cloud.ionos.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] block: rnbd-clt: Fix leaked ID in init_dev()
Date: Wed, 17 Dec 2025 10:36:48 +0100
Message-ID: <20251217093648.15938-2-fourier.thomas@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If kstrdup() fails in init_dev(), then the newly allocated ID is lost.

Fixes: 64e8a6ece1a5 ("block/rnbd-clt: Dynamically alloc buffer for pathname & blk_symlink_name")
Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
---
v1->v2:
  - store id in dev directly

 drivers/block/rnbd/rnbd-clt.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
index f1409e54010a..d1c354636315 100644
--- a/drivers/block/rnbd/rnbd-clt.c
+++ b/drivers/block/rnbd/rnbd-clt.c
@@ -1423,9 +1423,11 @@ static struct rnbd_clt_dev *init_dev(struct rnbd_clt_session *sess,
 		goto out_alloc;
 	}
 
-	ret = ida_alloc_max(&index_ida, (1 << (MINORBITS - RNBD_PART_BITS)) - 1,
-			    GFP_KERNEL);
-	if (ret < 0) {
+	dev->clt_device_id = ida_alloc_max(&index_ida,
+					   (1 << (MINORBITS - RNBD_PART_BITS)) - 1,
+					   GFP_KERNEL);
+	if (dev->clt_device_id < 0) {
+		ret = dev->clt_device_id;
 		pr_err("Failed to initialize device '%s' from session %s, allocating idr failed, err: %d\n",
 		       pathname, sess->sessname, ret);
 		goto out_queues;
@@ -1434,10 +1436,9 @@ static struct rnbd_clt_dev *init_dev(struct rnbd_clt_session *sess,
 	dev->pathname = kstrdup(pathname, GFP_KERNEL);
 	if (!dev->pathname) {
 		ret = -ENOMEM;
-		goto out_queues;
+		goto out_ida;
 	}
 
-	dev->clt_device_id	= ret;
 	dev->sess		= sess;
 	dev->access_mode	= access_mode;
 	dev->nr_poll_queues	= nr_poll_queues;
@@ -1453,6 +1454,8 @@ static struct rnbd_clt_dev *init_dev(struct rnbd_clt_session *sess,
 
 	return dev;
 
+out_ida:
+	ida_free(&index_ida, dev->clt_device_id);
 out_queues:
 	kfree(dev->hw_queues);
 out_alloc:
-- 
2.43.0

