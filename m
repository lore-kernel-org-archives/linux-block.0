Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5792F1FD1
	for <linux-block@vger.kernel.org>; Fri, 21 Nov 2025 08:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763713095; cv=none; b=TGYGl86ccUDj7GtFW3lTeuxKENbo6ZlCLCRYjLZBkb7abPn8wRQGcNtaUrq922qhSsZENRw+mMzInin0XJPfGoBTG6VyoCQ8dXnm6/iTCO7VkzZW/mx34QYK/JFIzWOO1mp/3bjXIVOxohD4IYR3PjlTEXTgbIu9UdOXfZUZlKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763713095; c=relaxed/simple;
	bh=+7tflVaH8x7L3VJvig23+lCVNVSwvcR4NvQ6QZjXrp0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W3V4b6g9XlW8i3zfTAS41LXZbYKOi4zvxDZ5sI9EdMParUiGcfZ7qy6Nl+eEGQj4lv7E3uOmHLnLCHY0EBBFfyo3sBtblv+4BgWwVY8rQ96jH1tbl/z8QyTy8q7GC77qXLJBx/Jqgh0/OUT7GMPadmdS5YyL6HtIVTJdM9yaHiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b3lbr++E; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b3lbr++E"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7bb3092e4d7so1951095b3a.0
        for <linux-block@vger.kernel.org>; Fri, 21 Nov 2025 00:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763713089; x=1764317889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HsO4Hd5ROz+D0bqFKvcezOn2Jkcskeai3TxWpcHV0vk=;
        b=b3lbr++EhNcLm+hUHPpMjU4R1FvAu94LDT+I6Y/CmvTMR2lIc+Y/vo6ykQnBdgQwVj
         Id+2LJX6BJT3buIFuo/mAMzXoLpe0jDHK3IpDkbnJ+FybRVHLKI676zPflxm21yHfOJ6
         H8mCuVdsaxpZNqh1pgUDize0Tf5c5HT/cD+phB04tg3r1NqpGtAQupo5DEu9grQd53Yw
         4pihNR9g729te5WNl+dLaHVJUN9QsJLP7ERu/DwNOkyPmeEQhA5uaAScA6xjSdh87Fih
         Lznd1tWleRW7Qj6RrI/FFE/Yp6xtmZadpMqA07SfUXkeWVtAMQKVhNfXFOSM+Y3Vkq9M
         7MwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763713089; x=1764317889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HsO4Hd5ROz+D0bqFKvcezOn2Jkcskeai3TxWpcHV0vk=;
        b=uVbZrGbI50s4Vismb5hT7DxapR8ddEpr6c9thAldG7Wrhfa1iuAwqYXKUzbs7BfeCC
         NUKkcL9K2Yuo121kd7jY++p2hEOZM1AKUKwzLYQpBPdjnHkZ6byo8DM5NQ2tZ5Wr46p2
         d0tyCFuAIhfGx5yjdurh/ZTD232I9cTzxcHwMWwfIN5rOXh3veKWMXmeDLr+e+DgI7JC
         v/+/ByZog8Qh9WMQBVJW+PIn8ixvhgOytcvIeunknXX3DeNY1opAtSkHmxm0/nb+/JKS
         r3+nUZWbPrXltjCs8B8YZY9SMrY1RpaamAWBldZem12mPhdIhp2K7NQgAZbPS8O4IPFL
         ykSw==
X-Gm-Message-State: AOJu0YwNw4jPvddgiNudy0khEN4buxmNaul0q2MN8ueyFLWMTwqGZGbh
	Kq0gXXiZVRBOcpyM6QQuhLI3c0YgGokQCS0xKSx63habSzDL0jFrtyOr
X-Gm-Gg: ASbGncsHvSLmylJhIdrtni3dRthmiRom03YEL5D8BZTgC/4EzIXdnLN6O7dL3KpRLtf
	FHFT0b7WexlNC5RgKIcnmn0i/KAkY3je55/F3R7xbT5d4W2XDNL7+rrkcE0JPb3SWG8+IFxjMCA
	Jblz43v8/hfelXjYPsIcUMLHXbBsLs04I1n2RysFGNoe0+pNFK3k0EYQ2KBB2zKyCMa/ocGiNys
	OEB71ckkMBNNvsnuTMt6f9xsST7R8XleMndfvmGNI6W8hZBtZTya5kmcXtXWClhOcPayY2W7sWJ
	fl0s/+jw15NACVmjrcku0vhnKh3t+xexs+6xBhHikgqYvn6w6HZHlAinjWsAHNoOpWNsZfsf/jY
	DP7kbgl1PdcQAfBE6Wmkknn1KMXfDdOT1OXPsRBuvpz4n3Nm8prsMBzIfHX/vsd1lBN0h7ekj+I
	f0GJfXJCEUZqkd+ti6RMwJOglH/g==
X-Google-Smtp-Source: AGHT+IFqeRBYEjCaG+tIpPdWA+qVKSXVzOiqtjGknDBSdNDUFTnY7ogPNjlccPCj95LHEh6lRlusYg==
X-Received: by 2002:a05:7022:6b97:b0:119:e569:fb9b with SMTP id a92af1059eb24-11c9d708d34mr570234c88.10.1763713089300;
        Fri, 21 Nov 2025 00:18:09 -0800 (PST)
Received: from localhost.localdomain ([104.128.72.43])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11c93e55af3sm20997352c88.7.2025.11.21.00.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 00:18:09 -0800 (PST)
From: zhangshida <starzhangzsd@gmail.com>
X-Google-Original-From: zhangshida <zhangshida@kylinos.cn>
To: linux-kernel@vger.kernel.org
Cc: linux-block@vger.kernel.org,
	nvdimm@lists.linux.dev,
	virtualization@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	gfs2@lists.linux.dev,
	ntfs3@lists.linux.dev,
	linux-xfs@vger.kernel.org,
	zhangshida@kylinos.cn,
	starzhangzsd@gmail.com
Subject: [PATCH 1/9] block: fix data loss and stale date exposure problems during append write
Date: Fri, 21 Nov 2025 16:17:40 +0800
Message-Id: <20251121081748.1443507-2-zhangshida@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251121081748.1443507-1-zhangshida@kylinos.cn>
References: <20251121081748.1443507-1-zhangshida@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shida Zhang <zhangshida@kylinos.cn>

Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
---
 block/bio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index b3a79285c27..55c2c1a0020 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -322,7 +322,7 @@ static struct bio *__bio_chain_endio(struct bio *bio)
 
 static void bio_chain_endio(struct bio *bio)
 {
-	bio_endio(__bio_chain_endio(bio));
+	bio_endio(bio);
 }
 
 /**
-- 
2.34.1

