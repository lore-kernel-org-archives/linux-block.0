Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B602E1714CC;
	Wed, 25 Sep 2024 21:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727300807; cv=none; b=jypAecmHeL6h0cwk8Po6QY4BY9ctgIm23Wb3BYm+YyOp8QyJhZtCgW0kYX2yUqc7pBioel5qIS1e3ds9gkeu4gKb30Ll84vppqVnUqzdjjnyiV9KXjbqRCE961SEN/UghF6rLZNuNCQQFzZuaubDOfIw20aKdNTZK2l6NBQyFLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727300807; c=relaxed/simple;
	bh=AvSpeRPjeVRXz5j8dQKUo3Zt1JFIF3gH9S62HhEmPeo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gl7NOgIv3Go8Q1X5oKXr2KmSw5vt5puIvCzIeIOH8Bji6iTr0bSOnmyKduEZOBrgH9t2g0T1hs19pqj/0fAOIAe4VrOY+bUx9bbuaJTdqMhZA800ZQqAOSAfx6i+JpGMSVtFNd89Br2o84C0tajsvANL33PirXx8QCk7v0tmHxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TqWwFOr0; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TqWwFOr0"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42cb0f28bfbso2304055e9.1;
        Wed, 25 Sep 2024 14:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727300804; x=1727905604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=36HmyHvoEEpKMI8/Stc+TIqGBije17bfud9rEk2jFTM=;
        b=TqWwFOr0VMoxMCQ30nc9YK5+dNm5NoHTlQXjuP5/dkVsl7FmhBQax4vX+IzJ5N25vw
         BcUDQFpIjlsSh+xfyEd5f4ZcLAQrhu1hmNJ59jIqb+vbTIIE7qTTfE43tpiqHBEFuGUf
         dMNarIinB8cFYiwC0Rt7b5HeIcmUYP2eACvAM6ugMfU8D+3531zcsxLV6wZGnZAzUWlk
         dBAM7Br1GDsUgTXbjSurmNDNvxaeUExCvEMMoQel/c70mVS8etJIuAynI0sRceb1GeUa
         3qQTzlR7HN6trDErJgZJDqqFyhDxIREo669e4+b6pvY2svJube5ICuTXF4tg5plibBCq
         XjlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727300804; x=1727905604;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=36HmyHvoEEpKMI8/Stc+TIqGBije17bfud9rEk2jFTM=;
        b=Vz+L8xuRgcY24VnwqLBEm2+SqDRCwqjaKD1X94ZXonyuZVnyGFCjbxo2Ub9kMUyEGi
         QleutXiSIhTewmWwvPLRZqaCST+iPvpqkwGHb6Q5AzmAMfTQyYAPmwpShJzhe1xvvXvx
         EjFZ87C/vcP95+0p8H7A2nJCS9Y1ztHWhXADaYMkMd/z51I+PwU6kuJfqX4tnVM+yOoo
         AzAuMz7kC2sNA292LqRSnd8A05vZtcq1tw7qG+yqjGwodBupUdPHGprje1T6t+rnDFaH
         25P9zhLL/9cSteD3LDJ5s1iLWycvN4iEo/IjamsDPDpwNcivlpE2HqVl93kkJsZ4aYii
         GeLw==
X-Forwarded-Encrypted: i=1; AJvYcCUqGxbh2A6+hSvmtb053fv0hDCd9UCj+4bA3AUkfq1YTYIgLCbZGSkBRZhuk+I+qxXtFezG+1WkndTi@vger.kernel.org, AJvYcCUrtnYUpZZxYwQpPYPKLW62VkuqwnqqCtU/S+89U9oS8xjs37WtHrYwy7WjR8t0ZkZMxtjdPHZ5vwqA@vger.kernel.org, AJvYcCV6zHZwJiZvLHbmdxkjr8PWDUI17hgDvxDwCSZvgplXuYLGesJdavIHAfRTqFgUOcwh4zqcB6ilEurGy2iG@vger.kernel.org, AJvYcCVHPQXBlfAmAiTlCMkmU7kZogbac8TgRLBFdIkbh1tLDimZpzzDcSlR+sGL/Bd/Y4xv4xivF7NynNRu@vger.kernel.org, AJvYcCWymTYxb0WkGtfthdebrGhTWsDe7srDfkS4fEbJyPW8KStuN3aZZgmgun/5td/gXNafChF3XR0FN1b7Ukw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSRpWitjUOEK0INt2mQJPGFr4dl1swF7IJm7BwO51qp8yPufOf
	1MiyT/QZdGOYtbeqBQ3OTj7xDvtHzR4d8/PW5uYixr0HzMWYZ4yn
X-Google-Smtp-Source: AGHT+IFEGvmVDdovHjIR/TZhLA7blPbTqS8qJmoeaPcP9+ntt5+F1WQucpd+dgUvMfPNjk8XWg9Z1A==
X-Received: by 2002:a05:600c:6003:b0:42c:a574:6362 with SMTP id 5b1f17b1804b1-42f50b68f6bmr21103775e9.11.1727300803624;
        Wed, 25 Sep 2024 14:46:43 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42e96a1f2aasm28802565e9.45.2024.09.25.14.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 14:46:42 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	Jonathan Corbet <corbet@lwn.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Simon Glass <sjg@chromium.org>,
	INAGAKI Hiroshi <musashino.open@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Li Lingfeng <lilingfeng3@huawei.com>,
	Christian Heusel <christian@heusel.eu>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	linux-block@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [RFC PATCH v2 2/5] docs: block: Document support for read-only partition in cmdline part
Date: Wed, 25 Sep 2024 23:45:22 +0200
Message-ID: <20240925214544.6114-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240925214544.6114-1-ansuelsmth@gmail.com>
References: <20240925214544.6114-1-ansuelsmth@gmail.com>
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

