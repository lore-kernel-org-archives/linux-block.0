Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835942FCC04
	for <linux-block@vger.kernel.org>; Fri, 28 Nov 2025 08:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764318801; cv=none; b=gj2oOKhadx7TCs3MXmikn9nJF54rEK+xU84mK2idYzU4Pm75lfyEa2SNlc1FxHV3Q1l/5v9EPxniAFwBBeWJsTsMPAsOrTc1eAUoFD1K718O0hfHcMTiYOMHyPXP1lPQi268Qy+C1IqJZMIduhI0fu/iqmkcDn1LZG5PstJnJs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764318801; c=relaxed/simple;
	bh=Hfn+I4xKib6YHUNH+g6fjmCyECLvbavw8yPYoNL/5CA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dijvbtkWhee/iLK7CZ2nLB+tT+qSoh1/i6vAOfqvRTZFV+LEsBBjxccurF9tV9qWKrlGM6dAC9F07wec1mc++FKg2CVp+J2QevV/vzLUtORUfGr5ImexN83e//nq681A9iqd1ex+D8BjujspUCdd48PJpwHF5S8tpsnsghq3O0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OUi/xMAG; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OUi/xMAG"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7aad4823079so1395918b3a.0
        for <linux-block@vger.kernel.org>; Fri, 28 Nov 2025 00:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764318799; x=1764923599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vdyx9mvaY+8x+eK9XImqi9TsYLR1v6CaCbGe/GD/N5s=;
        b=OUi/xMAG412JYQWqySKUfzoBptHS4/Qe8BOfLx1Cl7Ol+ZrysScGuSCbCSD832sagK
         E2WVayGv/dFEuvs3uezePHhpenkhUJLWlEWRdXBi0+7UKy4yLs1/7RbnYaoYGFlgMvpC
         ifZxtMlbt5rIFtBO7OFqKBQ1L4bCpYAdoX2eDKAz4KVeJqP0rWJAhziBh5ZQJZMY/DNy
         H0HbeiwnWIhXZ9LZnKl1d6uWdhJoY2QxPPZd2n1+PQMGtQPJj/gMdhpIVwsNWsx0Lykp
         PnNT804fJRSb5AQKhnUVPvisdKk7jejR5ztxyrbImwCfmqeTl42L6fq7+FW91/eRitbr
         LDnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764318799; x=1764923599;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vdyx9mvaY+8x+eK9XImqi9TsYLR1v6CaCbGe/GD/N5s=;
        b=bxM5SNMZBHKYWSic+KDkKTtO6KkMxX6849UxkpZjYX6rBWlHunsy9Z39aPe4u/PczH
         gwzwjQIlIKxZkHSouIakO2tSiNVUTQPpksQVpa2K7uDEhhoN4Farc43jQ4jNF/loNqM2
         ZJGEL6M3DLKuL3mMFoRNDLtNXdJbiywddO5U7yVNgMxPaf1WH7GoteJ6MnMOivzkCgvA
         tIZ5DKhcKAw0jsK96oif9nLwyNYjRvz78g2BMdPEJHOBuJdhXy/695nlxfQTQIJZG6DF
         yULL7q8BRizOVi0klH0TdwSIUADiDhVUvPfSnwubUoJBbSuF06buDuzJAKpW88WVLA+G
         QU8A==
X-Gm-Message-State: AOJu0YxEuuXWvxYxM1lTNowb2x4nq/LfDVA2k0tn97IHpr8sIrxR4CK2
	p1Vgrcour/NxH3MQp9EFS79KAjAcNLYma0GfflGNsTFn/vnjOCq0Y7wY
X-Gm-Gg: ASbGncvDPHKE7DDUA/mAq/LrHOgSd3K/j1gVmCUb94YYujQ0bQvpKcKJ+P06GupgDgb
	50bAStwmexHZwjzQjsUbuhCIngZJa+jQ260/ErIWQRGnj+plO0TjP4pBuZ3eS7MushK9C4iou0X
	peNS0Y0mBZiAmQiBb55JhOquVZ3eC9AtPdQ+n00d4TLB1I/v/3yK99Cp8QRq8lIOTpaNldOncHD
	70cGsJUX9drnXfMjjergeG8JEvVzQdkWlYJOkKza8bxs+QSMvq6QhfCe0c7Y3tKU1am3a+/L0z/
	a6cTnWHBOrDla44YXoP7YKcUbqPaU17GkjAjN2FlSPROw7pTlUrO7IYJNp0CevwCOQVtjEz1EWk
	cU/DbiQ1nmxTeSOvEhSyEK09NsHmW23rizeVq3kVOY4HaSAg6h3270Quw6RO+yKnPtJGZY8YVWx
	cIY16dVMlY9vRXqLuGPbSJaLtbZg==
X-Google-Smtp-Source: AGHT+IHKXq8x9elSCjEHks4N7hQUevj8WxDVP5HKi9llAEtlIQFfHNb05BLq+B1Nz6uA8fi9DHZiww==
X-Received: by 2002:a05:7022:671f:b0:119:e56b:91f2 with SMTP id a92af1059eb24-11c9d870411mr17436186c88.35.1764318798796;
        Fri, 28 Nov 2025 00:33:18 -0800 (PST)
Received: from localhost.localdomain ([104.128.72.44])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcaed5f6bsm20941371c88.1.2025.11.28.00.33.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 00:33:18 -0800 (PST)
From: zhangshida <starzhangzsd@gmail.com>
X-Google-Original-From: zhangshida <zhangshida@kylinos.cn>
To: Johannes.Thumshirn@wdc.com,
	hch@infradead.org,
	gruenba@redhat.com,
	ming.lei@redhat.com,
	siangkao@linux.alibaba.com
Cc: linux-block@vger.kernel.org,
	linux-bcache@vger.kernel.org,
	nvdimm@lists.linux.dev,
	virtualization@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	gfs2@lists.linux.dev,
	ntfs3@lists.linux.dev,
	linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhangshida@kylinos.cn,
	starzhangzsd@gmail.com
Subject: [PATCH v2 08/12] block: Replace the repetitive bio chaining code patterns
Date: Fri, 28 Nov 2025 16:32:15 +0800
Message-Id: <20251128083219.2332407-9-zhangshida@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251128083219.2332407-1-zhangshida@kylinos.cn>
References: <20251128083219.2332407-1-zhangshida@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shida Zhang <zhangshida@kylinos.cn>

Replace duplicate bio chaining logic with the common
bio_chain_and_submit helper function.

Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
---
 fs/squashfs/block.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/squashfs/block.c b/fs/squashfs/block.c
index a05e3793f93..5818e473255 100644
--- a/fs/squashfs/block.c
+++ b/fs/squashfs/block.c
@@ -126,8 +126,7 @@ static int squashfs_bio_read_cached(struct bio *fullbio,
 			if (bio) {
 				bio_trim(bio, start_idx * PAGE_SECTORS,
 					 (end_idx - start_idx) * PAGE_SECTORS);
-				bio_chain(bio, new);
-				submit_bio(bio);
+				bio_chain_and_submit(bio, new);
 			}
 
 			bio = new;
-- 
2.34.1

