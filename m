Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB4A2EC553
	for <linux-block@vger.kernel.org>; Fri, 28 Nov 2025 08:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764318820; cv=none; b=nzOk6nX5gA9RhtM7B6/e1ZgxH5mfrSVB6bTteDsE7G+tUT4giSJxCSGmAu9gRQoV6XEulWVHFe/NSNXVhGSc/5c+F2NPdezhl2iQdjNUxgpi+IuSbZHmMpCnoOWomEn8vA/jwOPMqxFSbNRjray602bV1CaJKTJgKhW93Y8kifQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764318820; c=relaxed/simple;
	bh=MIUxfeIlXsLJb7D1x07khmxiQaV6FMQZLzsNI6cDMOY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i9yCmWbqag1/LLyUbwLNsM5naAeHwtG8nQIQpkA6HIttF9S5tWqGNT6zBbwxZN20pJWPgJ7ejCcLD/43kFDP5oCc/vRXxjsWieGfnN5UslmIt2hv9641fr/c/qdUbFR7x4a/qMO34lWXHvd1v6hj4iOZspK+YRh0Dj8Y0t6o52w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EPebDMuF; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EPebDMuF"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7d26a7e5639so1098699b3a.1
        for <linux-block@vger.kernel.org>; Fri, 28 Nov 2025 00:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764318813; x=1764923613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rZsPDOjyUTRUehf6LhbOb026Dy93eapwVzPzgOc2prg=;
        b=EPebDMuF2YtiYM5kWUognxF1g/WoiT8JY4hRj+UZWVAgcw0ZBaHphOeRh69Nohxc8i
         TyzMJr+38d0Tl2NsNJOhzXHIkFZGFHbugNjrpwwKUwcZt/cC5mIceCQPGoJe+AOIno6O
         Zi0P0ckYCidr4AYY88DJy66bFtSFswpp4MYtYcik8TkCJ0ii1nfBS6GYTIoQ2tFugh95
         t/d73wR2vgsVU69F+rbxseA1CgyjXU8hLdFy2frc2xvhc53gQa3EIN51+SUuq4MVp4la
         lIfvjkONj3NgGeL3Y8OOOMLPCvQjce9jSxDFV9zb3Z8iBoPDqRhcCx1pf3xMxwRHxNoK
         ohLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764318813; x=1764923613;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rZsPDOjyUTRUehf6LhbOb026Dy93eapwVzPzgOc2prg=;
        b=FTsCQxvLcstiaF+962MEpWfNYiK4E/eW6+I+/geFQbWWBk67MeSR+QnvwMX270f8sx
         15JTWetwD7/HgTfUJAlNGUyh+sAH0oGjXKQL/LF3dxTlrpx/WKOxE5DnIg8cV0s6hcpW
         sqi083nJ2O4BJxr5I7nuuyI53aGN1dtGjwVfD5lGpr5QTJML4ULRNDR0Bjd3WWdVYCXv
         vwX94iZOkj4clqoWxySI3ULhidBq9H5SJUi0QgAYxWLU8SbHbv+ARynqbB8ywmCWj1YA
         2viYbD5g1hEKu2d3EXOB6P65iOMfAWzPlyAb47U+MxzfNfzA0NsaoqfolXiWferJ/tkY
         lmvw==
X-Gm-Message-State: AOJu0YyXPcNVHUWFYMI1dExbYqlBx7Ra+EqbRhbEjA4uVrx6ur9To3Mo
	vEUMCLtBbvh+/4/eVZAeD24ChJ04czTgJdDT9OOkEyxzITikmWTlwLFt
X-Gm-Gg: ASbGnctanI9IahKND25Pwez1NsW4ANvr/TpGcyYNO3L9wWR64JeFBQGqY+z3mzKVaCr
	6mGJ8YjWLuzjJzzPQxjLN4T97yyUGq27EI+MblQ35BRYvDfKYxIOZe0r0+xY0cBmvvckNfJcMpy
	quYPhL+OiZaX9AbAQTzh/Q5x3+oHFoDNuMJ1Jh2NeFolbic0egtbFK0phTEVtOrUS90HeOEBOam
	aAGGiENVL2VFxpuSlUdvNUuyx63vuKExhU+3g67wuIOsa0icfCoFkBfIEQOA2eXEh9qnJV/r7kS
	4gYCFFoEPF0zPrdJKMMmyklYmwkV9FwgBpvH+8MT7e2h8YfU/k42LrTBgX9cBH9311w3+70JHFT
	1/nTyEJBQLT6Z+NA5YhKLkNiIp6y1GzhWV7StIvJIzR0DUhlbhELB8W4g7MU4Ie9WC1jQtumCqm
	DYOMjIiSXtIIi/CBTQzn4Y46wmbKl1soPqQjns
X-Google-Smtp-Source: AGHT+IHqHdLof6s224+GbtnJAk22/n625R68t5gW5XXJrnH8NN05gDy1A3OVkHY/4+FwyWeG7e9t0g==
X-Received: by 2002:a05:7022:3886:b0:11b:9386:a3c8 with SMTP id a92af1059eb24-11c9d867ff0mr21572562c88.41.1764318813388;
        Fri, 28 Nov 2025 00:33:33 -0800 (PST)
Received: from localhost.localdomain ([104.128.72.44])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcaed5f6bsm20941371c88.1.2025.11.28.00.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 00:33:33 -0800 (PST)
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
Subject: [PATCH v2 11/12] nvdimm: Replace the repetitive bio chaining code patterns
Date: Fri, 28 Nov 2025 16:32:18 +0800
Message-Id: <20251128083219.2332407-12-zhangshida@kylinos.cn>
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
 drivers/nvdimm/nd_virtio.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvdimm/nd_virtio.c b/drivers/nvdimm/nd_virtio.c
index c3f07be4aa2..e6ec7ceee9b 100644
--- a/drivers/nvdimm/nd_virtio.c
+++ b/drivers/nvdimm/nd_virtio.c
@@ -122,8 +122,7 @@ int async_pmem_flush(struct nd_region *nd_region, struct bio *bio)
 			return -ENOMEM;
 		bio_clone_blkg_association(child, bio);
 		child->bi_iter.bi_sector = -1;
-		bio_chain(child, bio);
-		submit_bio(child);
+		bio_chain_and_submit(child, bio);
 		return 0;
 	}
 	if (virtio_pmem_flush(nd_region))
-- 
2.34.1

