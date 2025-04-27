Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D0E148832;
	Sun, 27 Apr 2025 15:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745768917; cv=none; b=YjIOFNNW2jrn+ojN6SHGu41LgT1QWhGkdW1dBmWX03OFum2nNjep2/0KMlKd0a2B1O88+8iq+y81TpFgLDj9Q0kZ/QF0qNWEAJZHcIT0Uy2uz41xr1D6Umksme28JAMxbnTfR2L2qTIe7jqQR4MndtezHQfGTawmlLLxL1wNvdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745768917; c=relaxed/simple;
	bh=UFzSyisM3IZr5hdd997M0KmDiSaAUnMiOjf0cFk0zTA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=auYgTUqwk7Zbm1G+PRYMLquY/3uqGrAPY4ugjssdCh/y/XcDC1yq54x/Q6zgW8v3Uz11xE4geMjXrBU8XC86vg4czw0kLgfFK4fICT42tRI8k1ocyYcTaXkzRv3YyJEDyuG5s2QzzFz02tifi6HManZFH6OFG3IVgykY+aabkds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IEMqwpM7; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IEMqwpM7"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ac2af2f15d1so478789866b.1;
        Sun, 27 Apr 2025 08:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745768914; x=1746373714; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8QP2qKXlylQ5fUgl8dt0xcd9xHalJz4VX3PTuL+s83g=;
        b=IEMqwpM7uCgAhDoL7fcbEKimxmyEw9YIvrMnCBdGQtr+7ICC2GvgjOxB8ndzfPGQIi
         9Y7uZ0KP8/wPxCKFsGyCQTmgfVS31zBM2DS6GLRcTeEFuKzvZhCs2GvXk6G4li46XGa3
         BBQZi32d78mRyol7iaVy6+BJRNqD+fWKvUYPA8JWTswJKu8XwMQ39j6P73kwGqD7/O4M
         w1xYuHoN0OzFJyvEy+4PdRhEx2LU0VuPxlyOKHofy4faq4dcVevkOLFXeH5TeomM3g41
         MnEASxhMvkxqukMgXYE06VVUcPUk4kXAw+hvyMqHIGQ8O8VNhflYX8opgzGvMBrsiQ67
         GqrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745768914; x=1746373714;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8QP2qKXlylQ5fUgl8dt0xcd9xHalJz4VX3PTuL+s83g=;
        b=uZkhyI1dno8Ts0q3mrOB9ZMpIpQ6Kam07ONWJFUlbp8eyaexM/+53lXwl9xsz/6G6L
         37ovOo2nii1U5gjfBEFEk2Qzy7ZatArci0FYId5ROtKco+c5mYE7xW9Tjo49SJ8X7hWj
         /R1M7LIt6MWOivMp/zz6K6BnpYUfPFpGwIvx4Rf97DrM41mO4wWlS6m4Ogj+x2hQmKFN
         loR+EgXXP9cdJt8/XJ4Q6pCsoMmlJ8jK/FaPFP20s/82RhSs776Qi0ewixuJTlKvl0WD
         +2QQ1UQxUmbp2AkwNWV61bFePpJ0VQ5Q2q5rKdABTh3eDdadaSPZ5CwnuNR5uSZBLU47
         o3Qg==
X-Forwarded-Encrypted: i=1; AJvYcCU1qsgLuhjR6XOqGx5gjXNgEUzwsVecYGZPEa7rGE199XvcSIZuWfdQDJOEg/xAux6s+gEd+FWvc+U5yGpt@vger.kernel.org, AJvYcCXHai3+XH4xFWGEZyH8Xso8qHH/WIU1E5LA04fmut8idUT7mAH79OyAzDtqL4rF1iFKGoQewbyBr2k6Qg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzRLlnWA5IZbryKq+bBCiV52fk8xrscKRMUq77PpPKGeekzCpGi
	cJ/MNs2h7PyDErNXKTvRrtubmkyXCi+cvm+pc2fxCMD0yJSPboGc
X-Gm-Gg: ASbGncsX4ts1/OYiYLEvdih2kkSyPv2ZKnaEnkniwhSLRJsFI986G4waPyA+yj/U3bd
	7zzwmXdbG2p7+ymDQgyI34cx8hgSh+FD/rhlR+z/DiUG4nVXO56ZSg0UNbWeC+r35MROSrzJvjH
	cX07ibopF0qMgBV5fHaZTL5UdEzyWSzUk3D7u+ECgAEtufXnOYr7BhL/8fOHzl3pQMAzD8i7MBt
	oWGZGpYygNcbA7wKC07MZ9ALbJGJSwGZf7jtA5k+mdQhJMCTdiTadb4nWykZsfwBDvxD4viIfYO
	up32i/urjC+Q7/jFi9DTCoTq4n/ifIwGtWWB9Tin
X-Google-Smtp-Source: AGHT+IHcmgxRrBs0qKvkEibbI/1p/gWCaTVx6a/jlKX5SCzjltVcUrawA0H5BtGngKUx98T+x/djlg==
X-Received: by 2002:a17:907:c10:b0:ace:4197:9ad0 with SMTP id a640c23a62f3a-ace7111d8c0mr798356466b.25.1745768914063;
        Sun, 27 Apr 2025 08:48:34 -0700 (PDT)
Received: from pc ([165.51.118.63])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6eda7d9asm457235866b.166.2025.04.27.08.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Apr 2025 08:48:33 -0700 (PDT)
Date: Sun, 27 Apr 2025 16:48:30 +0100
From: Salah Triki <salah.triki@gmail.com>
To: "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
	Jack Wang <jinpu.wang@ionos.com>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: salah.triki@gmail.com
Subject: [PATCH] block: rnbd: add .release to rnbd_dev_ktype
Message-ID: <aA5Rzse_xM5JWjgg@pc>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Every ktype must provides a .release function that will be called after
the last kobject_put.

Signed-off-by: Salah Triki <salah.triki@gmail.com>
---
 drivers/block/rnbd/rnbd-clt-sysfs.c | 8 ++++++++
 1 file changed, 8 insertions(+)

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
-- 
2.43.0

