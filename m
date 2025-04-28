Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB044211C;
	Mon, 28 Apr 2025 05:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745818058; cv=none; b=Pc9gx4nU3HVShUQ7nyHd45hfg6CGbiZax7x9BMFBiqxQnYmawK8J16MA0uC0gIPwGYxeGH+eb7Exuv17mPjBFZpl3otOSvKzxjXOR1gSps720cG3wQqLQrNYXVDgbJNX/AWqvoI7Jk5bgbR9iyZ9U520KzIQwFBxW9QrcixUIoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745818058; c=relaxed/simple;
	bh=jImKoBYqpdcHgRW3fjFe0vvxqd9XPuZABTgsqP+l0Ro=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pWarw52AtmBeuyRCNhpGJSvRyOEO2+ZrmnztZDX0mboddzJj5vuIOuRi6agsrkgbqLvMXJQ+o/fOkJJIngFdcXdlZWYzg44BN8QqdrJNIdd0W1+LYfhj4fpV0YeKVkWgIbOoeR8dPwsXLUAIftOMgTvf+aj3Xm1bevEobOsaRro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cdKPjjhE; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cdKPjjhE"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5e61d91a087so6649281a12.0;
        Sun, 27 Apr 2025 22:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745818055; x=1746422855; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fq+OzFBLLlyJg+NrzllHpi4v5rB4W3EdcTS9gRuN8A4=;
        b=cdKPjjhEU06SiQcNVtFe6l0m0Af4HEEjBaJT15DmaKUomS2IvwBuUGdZaE00hjWd4i
         vBgjwNspL+ktgeYtPBhDc2qNYtzUID7gf26Bz7K6ffTx/Und8JJdNIV5ZDIycIiajg7G
         Eq5DgWbAUI9ReAvH3uTV2EAeZWi4bY9Ng17jY5YhwKYQpFR0hHhfwRVozYsY76g92GgV
         7y6w9lTEJlz/lKuRzh7L/MPop0wmnJaG+h1sErNhxFmQL3wneWCAu2mqZoYwrAI7Qlvq
         OpILtrcE1mp+iniXN5W6nQIc0BPLla4lMxqy1G4ZtYDWNjHWrh73ANcEqfnehKIJFLa5
         LKgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745818055; x=1746422855;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fq+OzFBLLlyJg+NrzllHpi4v5rB4W3EdcTS9gRuN8A4=;
        b=YVOJFjK7h/1hRQZPskD62NhnPlCBXxmWyJkwhSa3xZke5IZ+/vFKYg7WpKRaW/544W
         xbTP1S2DFolJDFO/RjN44L1LqO7gmpk10UHb3nlXmuQN+jCBhjZPrmu6rcmrxzlYPW+O
         pvMpFQgCixJcKutEBraCL5wEzP2jvqpA+zguqSM1PbdF27k+VXz5t/ogEfB26rDOJ3Vc
         mGwBpq2qN7d32VkqaMA41jNEqE9FbXom79V6jZrFsxHqPI82fMC8HsCy29uczVptKexe
         EnbXvrqMMC+6ymrQHXB8CQWogLagNvzREnrR1JjtUBwUCXd8LmX3QpqwTecqqyjg0ZQ/
         94KA==
X-Forwarded-Encrypted: i=1; AJvYcCVgN8DftMlbh0XHtUu0ZZRb3X2QK+Q0dM2UAbmH/zXghJu6NPLPRa2c5hmVCHHzznrT3n8CBt9JvxCWTimq@vger.kernel.org, AJvYcCVrNSsV7nAmrfQQQeHjAPusEkMAAo0Hyk1tiRBqU00XpozRndASA83R6KArECv5HIm8tRv0wonjG1kjfQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+Yp9BzdKSs81JOxVBFVgFwJYJFO/cnAPB+QIn6Kl0qpz/Mg/R
	B+wueVH3RJCiep8t+H+Jua2oDeL979pBMIERLq+w5yMBdTjLxZkNB/ptojKPt6s=
X-Gm-Gg: ASbGncvHohPsaps5jJryd4MkUYh902mTb8ue9W8FDO/ERTA2pTpXO+KxadN9fjGl/ev
	Y8FE1SjkOfs83PvUc89wE6k+s9QDu0EYT6P6Su/UVMl7UJ1N1A8jDbCY+8KG8Vw+sPWYV7L/6Wp
	3xkFbf+pFD24GKMqatH2n6WQ+XwxDOkDHZlNye8Gdn6doD/wejMS5u7XR3Ih2JPRDoevuDH8eOD
	2leoDZrYnZIa1Cd4bkBa993il3XReepzutXERla0NDO+naDyx04PnIT8/5IqVRyqXE/fjiNXovr
	GGFrsH4osslKcCJnTA1YX741g9dkIw==
X-Google-Smtp-Source: AGHT+IEsSHjjKE5XelZrc415d9tgO/aN01y7t1du57Pj2dRdc8ZPK3Sz5H4MA9Merr31DkzUlUaz2Q==
X-Received: by 2002:a17:907:7da1:b0:ac1:e6bd:a568 with SMTP id a640c23a62f3a-ace84a7fe91mr615698266b.37.1745818054976;
        Sun, 27 Apr 2025 22:27:34 -0700 (PDT)
Received: from pc ([165.51.118.63])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6ecf8453sm564688366b.103.2025.04.27.22.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Apr 2025 22:27:34 -0700 (PDT)
Date: Mon, 28 Apr 2025 06:27:31 +0100
From: Salah Triki <salah.triki@gmail.com>
To: "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
	Jack Wang <jinpu.wang@ionos.com>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] block: rnbd: add .release to rnbd_dev_ktype
Message-ID: <aA8Rw1GzSSEs78Us@pc>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

After the last kobject_put the .release function of the ktype is called.
If this function is not defined the behavior is unpredictable.

Fixes: 1eb54f8f5dd8a ("block/rnbd: client: sysfs interface functions")

Signed-off-by: Salah Triki <salah.triki@gmail.com>
---
Changes in v2:
	- Make the commit message more clearer
	- Add a Fixes tag

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

