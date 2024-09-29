Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B884417C22F;
	Sun, 29 Sep 2024 14:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727618901; cv=none; b=t6InaeivYa8279KmL/3DowkjrfRbE/Jmd5gDlYprU9I8SQcbNHUztGEgqmr0zbu53U41c6p9ZhNFxCQA4TTCfoVyJcCAI2EZB3Mx7vA4eqx3vTbfYghHLfeIqHTN3Zo6p1WWPoVY2fRzHyOMOlShgUkKToZud3GmNb+wy5mk+To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727618901; c=relaxed/simple;
	bh=AvSpeRPjeVRXz5j8dQKUo3Zt1JFIF3gH9S62HhEmPeo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tjkxs8AFsPA4IAKVekhCFiyKwfwFE1SWseUo6j54maBIo/f36ZBgwy797NXdLHuY47oNm3e/y7ZZBaZyp+YIM0BcVHD3HrqMKVj1YP8e/olE79hpAGotsNL1Ai/8Q82GRXlGAvqqKRVdazNk3Hr1tq+QIhjBtYqgtz4wLbzJXO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bWMV7vNI; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bWMV7vNI"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-37cd1ccaf71so1608963f8f.0;
        Sun, 29 Sep 2024 07:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727618898; x=1728223698; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=36HmyHvoEEpKMI8/Stc+TIqGBije17bfud9rEk2jFTM=;
        b=bWMV7vNISrYcenySlT8Gp/OXmx/ARXtjxXumiv8RU2cUNbXmcRxy9E10G0r4HEBQfn
         RhEWpWepDEnrmHjS763KIixCPOOwkJlTtpkUP10AsPuxa85n70z7Fu05PYEtJ5WZKQ08
         aX61MVZjhztHEAQKZm2/Zs/8dJ19oj6KQIuxs4+3fdgsMuDR9JyS94KyvmHeGrF58wzU
         N+h718h5B2Ph9g4V3QU/srHcFl/aS4Ke0ZUPpsRAVBcEY253ASlnbY2xWuTu7iBcr+Zx
         1vn5XLSqTSb3Ll5q837wv2PQyxvdSuvpdKvV6yFcXgaQ3Hs3BRIl2j0da/E6T0zt5a1T
         2jWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727618898; x=1728223698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=36HmyHvoEEpKMI8/Stc+TIqGBije17bfud9rEk2jFTM=;
        b=C+xJip9Qw8RDeTuYQJzmuXmb05+/1v0QtFE1jNYphRx0jN6fZSrON8Ow9ja/5orjRE
         3lvDd7Q08l8S+KgAZhCTZZGQVjZX/ZeRhPShCir32phLFYD1R2wqBrawtSjKjvnE825d
         yRCtW1t+2LV+IDjDMbJUpwhWg8eNTFW7pnJiOrABx2/7inOTmS92yR8/4gFvTe+kcuc1
         V/oZW0pUl3GTkOY6WYIm7LfLW0ovOn2/rS9xs7CJbjt7iTO6d3p3eIh/5ZXWmPmhF62C
         8X4J+eY9oI2fNi4Ga65sZoL6E7ExYLW6woSOp2QtHV3w6ZZRSLi81OlcX38y4U+ROfn7
         Zanw==
X-Forwarded-Encrypted: i=1; AJvYcCVd0v+r05BVMnqOnTGzfU4Js5rXhSLL4UI/TgKheLBB9DvA++3r0ZzlC8Saan3bH9PCC3sE3wIE4aoK8uk=@vger.kernel.org, AJvYcCVrJEcYjsu2RlOH/7a6PhEGyb3ZAa34DUrOO+JTJfnS/IR971V6Q/uGk6mXj1veg4dncAf6eTrfy1ly@vger.kernel.org, AJvYcCVyJ4+XSRCcf+I6GB7EkUTnI0aJXHrvtCaiuf9DPnbu3q/iAo5RIHk4jUGLcfBez1XBWp7h1ISmEqn/@vger.kernel.org, AJvYcCWaB1YPmtgyWh+CLi/xMMM4G9N02IgEzWnc6r9V/koiJDsJ7pha9n1vkI4rPMHLzedjE3Vs85qssZTNFkZH@vger.kernel.org, AJvYcCXnKMXL1Q+cRQZ/QQAW8iHm0dGBxC5IWtj5WG2vGSZ0WQ/H/w+CBcmFmxw0rrYSn1lzDLwKV8OwflAs@vger.kernel.org
X-Gm-Message-State: AOJu0YwKkzbVYvNcTeCbDzTMuGxP38xoAZGPU6cD4g0fx/kyfimTf76a
	vXR+7Xvzxw73KQxflyXBcbaOdtc4bi+vZ4iGk4WvWrYgz8mPwAoN
X-Google-Smtp-Source: AGHT+IHjYS4dd74eVVCo58zMYH88HdXoSeT+yMiboR0ERx2snGOSj03c78zKXhZHjlAoxdI1msta7w==
X-Received: by 2002:adf:a41d:0:b0:374:cd3c:db6d with SMTP id ffacd0b85a97d-37ccdb09a13mr7842135f8f.6.1727618897933;
        Sun, 29 Sep 2024 07:08:17 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42f57dd3106sm77856005e9.7.2024.09.29.07.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2024 07:08:17 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	Jonathan Corbet <corbet@lwn.net>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	INAGAKI Hiroshi <musashino.open@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Li Lingfeng <lilingfeng3@huawei.com>,
	Christian Heusel <christian@heusel.eu>,
	linux-block@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	upstream@airoha.com
Subject: [PATCH v3 2/4] docs: block: Document support for read-only partition in cmdline part
Date: Sun, 29 Sep 2024 16:06:18 +0200
Message-ID: <20240929140713.6883-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240929140713.6883-1-ansuelsmth@gmail.com>
References: <20240929140713.6883-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document support for read-only partition in cmdline partition for block
devices by appending "ro" after the (partition name).

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 Documentation/block/cmdline-partition.rst | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/block/cmdline-partition.rst b/Documentation/block/cmdline-partition.rst
index 530bedff548a..526ba201dddc 100644
--- a/Documentation/block/cmdline-partition.rst
+++ b/Documentation/block/cmdline-partition.rst
@@ -39,13 +39,16 @@ blkdevparts=<blkdev-def>[;<blkdev-def>]
     create a link to block device partition with the name "PARTNAME".
     User space application can access partition by partition name.
 
+ro
+    read-only. Flag the partition as read-only.
+
 Example:
 
     eMMC disk names are "mmcblk0" and "mmcblk0boot0".
 
   bootargs::
 
-    'blkdevparts=mmcblk0:1G(data0),1G(data1),-;mmcblk0boot0:1m(boot),-(kernel)'
+    'blkdevparts=mmcblk0:1G(data0),1G(data1),-;mmcblk0boot0:1m(boot)ro,-(kernel)'
 
   dmesg::
 
-- 
2.45.2

