Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101B2198830;
	Mon, 23 Sep 2024 11:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727089213; cv=none; b=DVdLa6kJmKEszQOQINF4mnSSiJ6TefyIV+JC9p6PDSUZIJtCPWcf095lM+3KM8sepGSgFBDHvQRoNowPM8m/PukVHKDP9l94lvn6AE56nkYj89NZN9azobGGAEPZ718AZtWn2eERXOMh8JETc9NFQTx2s3vNhuzYr9gudI86M28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727089213; c=relaxed/simple;
	bh=AvSpeRPjeVRXz5j8dQKUo3Zt1JFIF3gH9S62HhEmPeo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SUQf4EPscxJdurdNgEyqjEu140mUJXtzQitKaanWNMEQCpa1Yg7ZS5k0s1IfoGyRlM3nTqfUIb/7DzxecKjKV95X6yPi0rC2n60U+RDFumrOOPXhPEr9HcjXGtM/dBk0J3Ktxz+tnGkLM/gtE+Xo/uAGkhqrV7eQzBRPm5WdZeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BxoNxUxJ; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BxoNxUxJ"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42cbb08a1a5so39905405e9.3;
        Mon, 23 Sep 2024 04:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727089210; x=1727694010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=36HmyHvoEEpKMI8/Stc+TIqGBije17bfud9rEk2jFTM=;
        b=BxoNxUxJZfwMU+JB+Fm3dhYhMzfZaCky564j+nP72FDVZV/J5XcH2PwPDdTGLgvGlq
         /hiOVbhvVFFW7eeia3A7lBl0SkhPgx7DVA6zbyn2KFvGEVPkuuBtGWwraSlQeKAYlSrm
         IJ+zY/zGkzwgavIUVXe4wG1qQE3WgW2WQOnOTXkka2CndNC4Sn1AVnH8I+qmeYU7jmHr
         nImRw0S5nux11mZohz90a/bQ2vEBiSZn4XM3Fd9FOzTPbJbOhM63ukWbxR06h/CKu/vO
         bGEVC2OVzEsTP2HEvkWcfv3BszgzclUbK06t2kJ412dPFpU4gegFvRxiLQbtRxsZu99b
         au8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727089210; x=1727694010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=36HmyHvoEEpKMI8/Stc+TIqGBije17bfud9rEk2jFTM=;
        b=AfFYZSGpzfeH8k4+27bR2DS6UB0QaUUcmmktUuMhH4dTi9A/PLjAjWnp/3VfeeMw+P
         cDWc0m5EK2DAsVbcoTRLTTDfebxrZ0Kvn1LcgD5GcFLS92aSEBOWTLyruC4wCGGC94iz
         wi/+mfTy2QnrEUKbf4FaukHNXj31XgNTX0ddv4ajhM3tvfFG1Cf/ZpNV0wq0srCIAX0B
         egxFq3vRBrPnWKKRGvugdbixSjrydXzA3UxEd/OxP5fju/skkg3iipPr/ZIF1GSE7QJy
         nOKsgyT1jlNqLdLuKSJXTtZ1gZ4NiAoI+HRvZgjkrDzLIu4JKigsIwSkzA/FJiQf01Fr
         Fsdg==
X-Forwarded-Encrypted: i=1; AJvYcCU2Dm3zW19Pie2PJGh6wXkeM29SJlwAp62hNoy4LGcSixZwBhY95p+CZkKKzrhzGKvzK/LYL2hKew9V@vger.kernel.org, AJvYcCVOUPK2SffUw8DZvsi9HCuFw8Exvn6g/hXRtfjBmdm69y7CSwnTL9Rhwk+LS0C1yZg7485Ttpv57vsgiEsk@vger.kernel.org, AJvYcCVvu5EFRiONWTfTVvptEYz0xjlK+rUbCdNhYhrps6URQGwi5AQXMiH3eXN7Bn6ZLoLX4v6PJT506fhS@vger.kernel.org, AJvYcCWw1kPGMHxJjtZGr7Vth1cZ3o9hZijFABIxDWH4rqvncfPDyHfC8ESjf8Ygh2VhMCmGQ5X0d6Tdy42d@vger.kernel.org, AJvYcCXwdmgHZaEL2WXiuUUOmLFl95WC4ZNNJWU2i0fH5giHke14ehQsO6gJTAl8jTGRnIEnec9+CPqylJ370Pk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi8gKFxDce+dFpriWeUNO3+0AEWZyIlfm0r4ATW3hSJIC10ehr
	cw8c4UpFOHdTr+UBzZ1FramngBJjaoWamwAaLJoNa0cWLVXEgBh5
X-Google-Smtp-Source: AGHT+IFgo28Z5y1d9oL3jd8zd0ceuYYzEDnbDY27ygnKWGg1jKQU8CYFnsybLuTT1dqbvrzcAt72Qw==
X-Received: by 2002:a05:600c:1c04:b0:42c:bb41:a077 with SMTP id 5b1f17b1804b1-42e7ada4c7cmr74426875e9.23.1727089210051;
        Mon, 23 Sep 2024 04:00:10 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42e7afd7490sm97856615e9.28.2024.09.23.04.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 04:00:09 -0700 (PDT)
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
	Ming Lei <ming.lei@redhat.com>,
	Li Lingfeng <lilingfeng3@huawei.com>,
	Christian Heusel <christian@heusel.eu>,
	linux-block@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [RFC PATCH 2/4] docs: block: Document support for read-only partition in cmdline part
Date: Mon, 23 Sep 2024 12:59:31 +0200
Message-ID: <20240923105937.4374-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240923105937.4374-1-ansuelsmth@gmail.com>
References: <20240923105937.4374-1-ansuelsmth@gmail.com>
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

