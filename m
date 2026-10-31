Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793442030;
	b=OU+mcAhN2Zf7zoFeP1YFT8UF2qOaJSxizSorruX6bjXnXhyaue+gNsAHmEyuG6XrU/Vx
	 ZA0pXhG0BrPL3DXM1MCq/2p0F9WJD+v1ZvFodNZ0VlP5r3VK81xPByeaxopDfMUXjVaSP
	 wbdSEzOr56TU8ryy+NxNmOP5qkGLeGcEcYtgCfMFZp4QzGnukAXw/Jd1s2Kmml8wgPNdu
	 IpyCxggBYh3cTNORzyHE3hEbft+VUNZO4ddS3DGcgr3OYvzLM4zpvP4oFhGOC8F2WciQx
	 kDFs8r5KT+QOvqAC/uc8K4HBkj11rXVed/Zj6u7PTutAlGJAmFMuB4lUb7muHRqqryg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793442030;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=KiP4+9EUfnZMvYjmy0GTyuqZwSwHrcUNArwbkHdqfEw=;
	b=3sdAuYYMs9hVMl5a5j6/LD1zGd2Wdtx+NDL4PdnKN4phQKLSd8JJhaEdh5gxEI1dkCPU
	 DlK3fImNpwlsSe3qAxz6fUQBHAxAnVeTl/1dsBvPMbVqArkrvGa86IT9MX/c5b8jP4TNl
	 5FEEUcE+vUOLmoJYkg3bYpoOc4Y/pznhkOgSfGIo4CWkfwbPHCPXNmNC7DYiENqQwW5tU
	 p8jeM0heTjipZPKWF10JiClWYvv8pb/o8jMlGzW6LY5jAiYoj0sUOrJWszZJgrMIm8pEv
	 g7vva4yR1afW3DY6uwiuSN+9Nwa0M7idZSd3+fwRXR5WVjDzi7RturKmSEgw9p6PgOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C4VEQPuy;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D29606A31A
	for <linux-block@vger.kernel.org>; Sat, 31 Oct 2026 10:20:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6D29606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C4VEQPuy
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a20a37703bso11301005e9.1
        for <linux-block@vger.kernel.org>; Sat, 31 Oct 2026 03:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793442028; x=1794046828; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KiP4+9EUfnZMvYjmy0GTyuqZwSwHrcUNArwbkHdqfEw=;
        b=C4VEQPuy8WdrQGNOP/fXwJ58Mf+GyGL7LGD75bURVKa9WX5s+hTiCTMtqbJLSim+y2
         gbWvzXJhNS2Tx7cpK+JBR48O7Gql5X70ewXNWfOJh78mgudMqnh9AG+z5SuH9tXYxP+x
         dqMZJmmgUDejXZJAsD2oDlzs0WALO6faPkJWlgWToHREXyrx/PlDMjNjW7sK0xpDVEf8
         9xrVyvU1TE58fWe6XHYGnRBVg5ZYx9+Mf7BMa7l4nc7WF3cZ4z3Vhx0FAR+v3oBkCEJq
         p2t00TwWsETVbYFhCOT7sLjbvqNyOsIPYx3YleGgSH8AOdDG+3FcI96n1/SQ2ni0cF+2
         phQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793442028; x=1794046828;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KiP4+9EUfnZMvYjmy0GTyuqZwSwHrcUNArwbkHdqfEw=;
        b=CT88orar10bgr6YBixJn695p9ABdlqo9JsOBzKvxEaXOw1qgyfDzDEfLZ4W+aNNJeY
         sFj/jvAjvbsBaTr74LOVxQFXouL0YuyIb3mhN7PyATzrgea7CxcwKsw1K8DElR4HMkp8
         5cYBP51MKKVrvd6278D0R9KZqG8uH0+ZKJw80/Vd3UKQeI0edDDVTN8rPNCg/g+Azgqq
         t6EiPQKz8ldPRgNd+4Uuevb8KA0VMfXT4JgNW2lvSOjJ5OZECgEKqvaSOAxXB135qkGN
         hLcObp34FnENoB7+fwjSGkpZNYCTsixBODsdEdqUlixNabZ4XaEmtUEnF/PTtDJGmCRM
         dPyg==
X-Gm-Message-State: AFq9FYI0hCuPncx5BpDQlnGnvsmWu/zJWYuAyQcuNA3ZXtU9luVvm5v4
	U3q81lWHfxtSUuH9UgLVkgJin9ALoH1LuRzSrik4YZ2PdfxsXUvvPekT
X-Gm-Gg: AYBFou2VIbQdwFeG56phewjjd2kjp4Wxp6dEzhHsuokhIqvRSC4m8q6g6Qzz/EoHQe8
	JdMz9M0Og3x22nA9+xOZMybvgRqWGGP9gwnOLtOX6jcBrZoTg+7fNiEH71WJN6SX6fol+gJGeqM
	iUX/Yn94Em+D5WEQ2wIgdgmKZhSsKDSQLf1lUskmg5aYQna/fDMyh8gAhx2cp/1Zp39hoxye5de
	KA+7Cjh+vi2zIRfZRpvYscn3jRQkuzZdRvuFBtD6wXxlDYrAfMMmzybIvwwxRtS1i+wbrdNOh2r
	BmrQVg54iUO5sjO2++opZFI8WDNR1iriOql/tgu0eGjaSoGVrU6yhU3w7uSIZR94esqY54xg7WN
	HAGGeBNnyqBJqQjVTaewAHIm6CFDXwUuf++lXVsgyf7TLTOptoEDFHEqzCDMP22p5MW0+95ux+5
	gxFZJIjtCTsKGqlTo/KH+3nkfAdPve0DD6jyi/mZdFuioaEVy/ztjn8jKxs2aVJ93wW9YJimwjF
	yg1XP3lLg6tj194U7LDyw6sHjKUcM57e4MUPkBE+gdZ/5DjVSmgq2PtVWB+D84m2nwNXP5fhSIg
	cLlR6ADi7iXJK/Qlw6q7PU/g02NxVvbs4CCgXd/0KCBb
X-Received: by 2002:a05:600c:314a:b0:4a2:fd2:985d with SMTP id 5b1f17b1804b1-4ac1775316amr104580545e9.12.1793442028100;
        Sat, 31 Oct 2026 03:20:28 -0700 (PDT)
Received: from localhost.localdomain ([2a06:c701:4773:6f00:c8d4:ec29:293e:f39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b72715sm7628038f8f.18.2026.10.31.03.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 03:20:27 -0700 (PDT)
From: Avi Weiss <thnkslprpt@gmail.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	hch@lst.de,
	mkp@kernel.org,
	linux-kernel@vger.kernel.org,
	Avi Weiss <thnkslprpt@gmail.com>
Subject: [PATCH] block: report the correct discard alignment in sysfs
Date: Sat, 31 Oct 2026 12:20:24 +0200
Message-ID: <20261031102023.3644494-2-thnkslprpt@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

disk_discard_alignment_show() reports the physical I/O alignment offset
instead of the discard alignment. Devices can specify these offsets
independently, so the discard_alignment sysfs attribute can report the
wrong value.

Use bdev_discard_alignment() for the whole-disk attribute, as is already
done for partitions.

Fixes: 4e1462ffe899 ("block: remove queue_discard_alignment")
Signed-off-by: Avi Weiss <thnkslprpt@gmail.com>
---
 block/genhd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/genhd.c b/block/genhd.c
index 10ca8b4d6eea..69204d44adae 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1146,7 +1146,7 @@ static ssize_t disk_discard_alignment_show(struct device *dev,
 {
 	struct gendisk *disk = dev_to_disk(dev);
 
-	return sysfs_emit(buf, "%d\n", bdev_alignment_offset(disk->part0));
+	return sysfs_emit(buf, "%u\n", bdev_discard_alignment(disk->part0));
 }
 
 static ssize_t diskseq_show(struct device *dev,

base-commit: 36aad21d50d1af3f6954bb0c988257a908202477
-- 
2.43.0

