Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419991CF2AF;
	Tue,  1 Oct 2024 22:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727821242; cv=none; b=r+2BMxOCOTQTNhsg+0cYTbwh3ltzheMGgUCsSRnC+sgzDxWDUm5Qr7LL8+1xtbQDHNyEcXlAcGsP7ODRdSimG5OTPrmQ00UiKIjEUDTT/fblMyDkM8BCI24NiwMbIefOddwxUseHsHyHVaW+xuSnVOFtR4SBoIR98MNANrrECLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727821242; c=relaxed/simple;
	bh=AvSpeRPjeVRXz5j8dQKUo3Zt1JFIF3gH9S62HhEmPeo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tmQub9VXZGNGy24ofd9b/fJtaldfYtzpmvo145MizEtH3shaYY9OY93S98Erbj3rCGKDNYC1EnPbx/LYyyss/oR3LbDKFQ5voQLfApT8B5sCirjs6IGFhAKLLTxh8HfBEC4dMUDSiWC2YZWMOWoRGxfo2PD2mmDYIAaKVoWkQgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bYWc+uzB; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bYWc+uzB"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42cafda818aso57939885e9.2;
        Tue, 01 Oct 2024 15:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727821239; x=1728426039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=36HmyHvoEEpKMI8/Stc+TIqGBije17bfud9rEk2jFTM=;
        b=bYWc+uzBWvH5QL9CXyyZvxSKrB3M+1gJn7bhGvOJlrCmXSw+JxBGagel+poM1IWgX4
         ODnZmrUGEn52TK2gVWgOge/wG9ZabvKFckD0Mk4gl2hr/qWbaV/4f8wX7KcD4GxRxQJy
         tC9JqBuqJBZzybdzptz3+bpSfCvKGAv+i7sONr74OeT+EZj7F26zRKhMvgQ7gi3NVRNY
         T6DsjQJsOYpSQpVduN+4CWTAsbZ7Y+tZD4iki1Doh+pzBiZzub8lkZk8Jsyc8w/DxPI9
         LmmLEgBwbZHEohhDI5gWUdTUXkPbn4i8JihBduWpRhb7JbbD3Oa68+Z0JqcFLDLW76sX
         jJOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727821239; x=1728426039;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=36HmyHvoEEpKMI8/Stc+TIqGBije17bfud9rEk2jFTM=;
        b=itKD4wr9IqwkBxFTjz1fS2Oqrf78FEELl2j0jsXWCJhhFSMc7wlS8b+wlp/bdKsZpG
         0J4rYoPDh/fYO64EY0DHN2mozQxsofLIkgK4RnbOky5bbEwpS/AKXTfVEa8gGMWYCgDY
         gZpHEdG+NQ54n8rBkWAPGEnquxLJrWIvZZBIAH2CuYOhILo0TjktIpgYJHJrtvZlqVjO
         /i+IxBC6RPMhBfzPqOkkWkVzgt2ZtIYWISLtLpUdTSNF8dT+telIPEpZcBXc8/Mu14jz
         PQoVrAMbeLAaCIMsobeJazUPeAsZoTDpe1z/JOfJHyn7HLsPrJ2JMAVzhR4GfKyLjmYv
         tPqw==
X-Forwarded-Encrypted: i=1; AJvYcCU/8gr6urstTjs1WnTX97K/di4Oc2/ALccRcsnCJek6jmC3W5MOjXkQaH6TS+sPqjZsFg3n9R2wyn1j@vger.kernel.org, AJvYcCUGNLtSm9tORSFxdy2/m8IozP1hbCGus7nj4bhdGqPt9+4fdeV9zMVxmJfojk2kgORhO2XiURIpWiiE@vger.kernel.org, AJvYcCUfDwxeirsw5t1T3yoe13Szr8RIix0mht+LNWGjw+7WvOcxSLXctbz+aQwwF2W1Ntnk5BYuIQcR3BFMxrE=@vger.kernel.org, AJvYcCUzI12b3kmkB3a0ElQnJHcxkuA8w7Bri3qRpv5ttopTo4zNvDF5ESt0HH/7IyaZc2d6xW4VwQ8SoQmH22RC@vger.kernel.org, AJvYcCWhDXoIjQNDAFzBzPpYx+/BWbR1d9/XdflAKwQTyubPpEnR3Icqv2htwPp0Vf3456474+MobZ4AgyN9@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1nEv+Q9nUvuGXib64Ar+QRfE8TyDeUhcc2YabYXr0kEoMmBzO
	qpJqwtQipIG0QywcKvbNu2WyEU/vCu5wUtV6DxCTuSM0GEUySNeO
X-Google-Smtp-Source: AGHT+IGIDPxjQ+V4nk5hK7ebrKIAFPgPpB4BaP2+JauvZQ+jCU4eMkLt/5R1XilbQgftoTFXdvGVxQ==
X-Received: by 2002:a5d:5043:0:b0:374:c16d:6282 with SMTP id ffacd0b85a97d-37cfba12323mr683317f8f.55.1727821239214;
        Tue, 01 Oct 2024 15:20:39 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-37cd57427fbsm12677089f8f.100.2024.10.01.15.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 15:20:38 -0700 (PDT)
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
	Jan Kara <jack@suse.cz>,
	Li Lingfeng <lilingfeng3@huawei.com>,
	Christian Heusel <christian@heusel.eu>,
	Avri Altman <avri.altman@wdc.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Mikko Rapeli <mikko.rapeli@linaro.org>,
	Riyan Dhiman <riyandhiman14@gmail.com>,
	Jorge Ramirez-Ortiz <jorge@foundries.io>,
	Dominique Martinet <dominique.martinet@atmark-techno.com>,
	Jens Wiklander <jens.wiklander@linaro.org>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Li Zhijian <lizhijian@fujitsu.com>,
	linux-block@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	upstream@airoha.com
Subject: [PATCH v5 2/6] docs: block: Document support for read-only partition in cmdline part
Date: Wed,  2 Oct 2024 00:18:54 +0200
Message-ID: <20241001221931.9309-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241001221931.9309-1-ansuelsmth@gmail.com>
References: <20241001221931.9309-1-ansuelsmth@gmail.com>
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

