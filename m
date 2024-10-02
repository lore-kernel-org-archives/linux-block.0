Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3F219CC26;
	Wed,  2 Oct 2024 22:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727907229; cv=none; b=FvGW5fNUdyvoSdNpG2GBCopkHyG2zRvlgL+TCDqDPQZYQ2H31i8Ex7SACSsIkmP7UsAqSSTwBkgEpGg752bP4rJDvHpHm22JPaSc5hvmaIRukILuoYYx3U+8K+DmXazarvQTgA/kpgZN5404Ej/NT27gqiHE+5UkakbozvN0Q28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727907229; c=relaxed/simple;
	bh=AvSpeRPjeVRXz5j8dQKUo3Zt1JFIF3gH9S62HhEmPeo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J/cfp6m37aDfqZC9FBRYsAAzAioYV8iElHvzT7qqdUiOmqy6L4wAz8zi2adwZKZRKYrWQgClC3U5xoTOA4RE9nClhF4+pUw5a5tlMe/AeFJazxFsR3pwaOt78n93qEkdBHr55Z0fY5TiZIcd1iZwqeQiyPVZVFaQaQLWsePDhPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MvmCBBDe; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MvmCBBDe"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42cb5b3c57eso1994875e9.2;
        Wed, 02 Oct 2024 15:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727907226; x=1728512026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=36HmyHvoEEpKMI8/Stc+TIqGBije17bfud9rEk2jFTM=;
        b=MvmCBBDeKJ2xGkG8i/VHa4nCuDG/ZaxWYhCzNjlMgoRH0CgWx20lBPj8ocJ60ml+JV
         RfEOikBFYf6rl7dSOs9PSDjXw7EIq4wQLWIV1T/82kDcChphJ1kmSza4sHvMDPfpfW++
         NMo130zJRD5L2jpyxzHj7fV6fvSxszjIjrO3POV8eCLK3Yn3tZNrj5Q0IDRGdx4XrqeU
         k8tw8bfXgHhLhFg4XxxpiDQcGlqMmJ7nZ+KohtzbtM47wC0n3CBueiZz5FOw8OsFr4QQ
         d4JT9aa+hE4wy2r25ttmpWvqo+OKMGdLsGE9h9dhOu4edy297FVf9Kv398mC74at0vwk
         ky4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727907226; x=1728512026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=36HmyHvoEEpKMI8/Stc+TIqGBije17bfud9rEk2jFTM=;
        b=iEdcbVk+EuVLvwH67vRN6Qbc8QmlYsudZNQs4v9M5aveSUoo5Gbs2om15WsaLdEdjK
         hmezPvb48VuA6cz8AEM4xX0/N4PfYwp8U7melk28HnXDHckq6unPGn0eDardy0e85QHX
         AtEK5dJdjud3R3o7FdDj1YDhUEtcxT7IYI76rYY0AYxv2MeUzbh5JtjzTrN5ictk6VOv
         iH3HidhxPLf0epU4BJ1jEi9gR1LDg7jlfAxIfrWNAsj7PSrzBtpgOuibGW6AcVb7Xszn
         V+F05eg+jQKEOrTtJqBvatNl1NxypgefGTFX3TMKUbigM18egkFWywh/t2HPN9wG0rpd
         iw+w==
X-Forwarded-Encrypted: i=1; AJvYcCUCKuuputubzpxPX/s76FhyvJYt/qG38y1XN998Q1mEEkFgqcmOzlbvaGqaWGA8rWGWaI4oeSozSUqy@vger.kernel.org, AJvYcCVCZ0Nkg6hzYTLc3ZcBM/YXPAJt44IN9U7hbpYUXVMXYwApMyCci0XdncfzBIAevZjHO5aUE4DkhWNkYk8=@vger.kernel.org, AJvYcCX9WwuxRN+qswI6tcrt9gaPVZ48bM1Eig63ZrpyXMjHNUFv9R3uKPy9XmoZjn7DjwIVQdauqoFX5r+Q@vger.kernel.org, AJvYcCXkZNdf25CsypyFl+YNlR13wSEEu4r+vq0LKiSSbC5PGUJYgXERm0EJB0VOijLmM1Lt964IdXreTxIc@vger.kernel.org, AJvYcCXlgSWaiogFtjXdnPaLIkQyMsRWjZnAswLD4TJCzTZoIS2HdqGNsxgUj9YFAhJ2Mj4P8z1OLIr5vBcuHugU@vger.kernel.org
X-Gm-Message-State: AOJu0YxffibpOYusnmnUFE7OJNDSyAM/wKqdIe9npy+Yv1xP9s1gCCqb
	Hb7Xjc2QvyQFEsgCufmBDvZYmY6a4rbdebj3ZAsltj8Hfm+GqmYe
X-Google-Smtp-Source: AGHT+IH8zG6IQs/9tpO/SHQNvoOax51SUD4BoKGMr+glZVZqZQshRljrFpilX+Z23SlVh4aYkxEc8w==
X-Received: by 2002:a05:600c:6dd9:b0:42e:93af:61c5 with SMTP id 5b1f17b1804b1-42f77948002mr35767695e9.14.1727907226194;
        Wed, 02 Oct 2024 15:13:46 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42f79ead1absm29218245e9.17.2024.10.02.15.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 15:13:44 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	Jonathan Corbet <corbet@lwn.net>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	INAGAKI Hiroshi <musashino.open@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Ming Lei <ming.lei@redhat.com>,
	Li Lingfeng <lilingfeng3@huawei.com>,
	Christian Heusel <christian@heusel.eu>,
	Avri Altman <avri.altman@wdc.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Riyan Dhiman <riyandhiman14@gmail.com>,
	Mikko Rapeli <mikko.rapeli@linaro.org>,
	Jorge Ramirez-Ortiz <jorge@foundries.io>,
	Li Zhijian <lizhijian@fujitsu.com>,
	Dominique Martinet <dominique.martinet@atmark-techno.com>,
	Jens Wiklander <jens.wiklander@linaro.org>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-block@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	upstream@airoha.com,
	Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v6 2/6] docs: block: Document support for read-only partition in cmdline part
Date: Thu,  3 Oct 2024 00:11:42 +0200
Message-ID: <20241002221306.4403-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241002221306.4403-1-ansuelsmth@gmail.com>
References: <20241002221306.4403-1-ansuelsmth@gmail.com>
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

