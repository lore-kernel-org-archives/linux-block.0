Received: from mail-pf1-f226.google.com (mail-pf1-f226.google.com [209.85.210.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC0F294A12
	for <linux-block@vger.kernel.org>; Fri, 20 Jun 2025 15:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750432217; cv=none; b=L0c3QbFNYXUG9eGpwEd72wbF0r23IDAe1LwsOBV2B1I0gfymbNQVbd8i7JygA3FFTS2xCGYOEhuje8jdxXhcA8Qin/bZUmmMiqndANKzqhlg3us3triYfrBqLIML46cISTMIHyiuj4Tfng5KUFr5ymFu9x6EqO667lf4LApWoRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750432217; c=relaxed/simple;
	bh=IQDgBnKlOWBV2ew9VaW/IvgKZzWIEis6/rSV0TjgzwY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PsrlDtsEoWLH2t1DjlGGvQnBkbCPRqZb4Dpw+WaRpk6m5m5FdyGQOxceVljiACOvEmSK1OMjsVYzaFKfH6Lc4DWMXwCXhgwqwAeCYW/ZDQuanJ6/cQpyyDfYouw3j1SGyNgh3z2MyOqh1KqB+KKk99uKwmzd/SzXsrN+BF2EN5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=LZ+jBifU; arc=none smtp.client-ip=209.85.210.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="LZ+jBifU"
Received: by mail-pf1-f226.google.com with SMTP id d2e1a72fcca58-748e60725fcso165081b3a.3
        for <linux-block@vger.kernel.org>; Fri, 20 Jun 2025 08:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1750432215; x=1751037015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1RIq0ZfKc+yHLLGUITosmMN617sTFwTIizfo+cwqxPo=;
        b=LZ+jBifUXajjm++PTwVay5OKZxTwsQoUWhiwx9aO3a3ZDhOiUoKGy4Y23FP/zp3iXL
         8VOXgaJFQ9gbMpIsz52IBSDrCX+62hFUOpRjKH5YzEDW1hS81UwfRZRZ98ODTr8rXugj
         WN2DaPW2NFDwz3SNX+w42pX0Bus5egMSr3D0RMhm8xnFooweOmk8+0a5fqEZVi3HYioL
         0mJQvDc6RS3DC2yjrG3Ps4c8t8kPV2BCUziJez/1wm32Cb1+rsa2ER6sNTAE+IHFRSQr
         bBG1QxUqYtSkcxb/J2ADT/1dBC/+YWU+L5Ui3Aq2uFLrHjD3cDoQHTXYSiMNdooNSCj8
         tEeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750432215; x=1751037015;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1RIq0ZfKc+yHLLGUITosmMN617sTFwTIizfo+cwqxPo=;
        b=IFSifceV+yYPJBij2HzG3RMO6SyRwEswf7mdHGlArALQclWHN6/RiUq4Psc2raAuMK
         lTaUyCqVg16GcsvoVWY5AhxrIOo8rp02dEDPcRULjEShEu6EGGpVRnDJ00+dEiIVty0b
         BUN2G8eaQrdwgKibs4NMapcGjh1CvfaxAWU2dCrKqr+DetvACLoAs+QuvboxsvJSZGVU
         cY+ephUIhEg1JosARhnCLF+d8oV7F453zH3+zbSRfOpC/2xHO/UDSCFcbVc+VWzDW3Yd
         /5TCjOp0xwQy52cL87Tgpy0x0aSQjvsehVYrAfHdtfVBeFOQ92xZEcwTfaJV62QHHPjV
         K6Hg==
X-Gm-Message-State: AOJu0YzAfeOaeMNBIusSfJoc8LkYkaP33yeLeZ4QTfO0b8ZFYdSjnQw0
	8chhjXYe3LdaZRT3+mtdP7U8GgVWG5Qc9a89g+X2HClcDB7qTnxVSkqjrEYQc/Guzrbk/3FhsTD
	d0T1rKyLEdqSL4U+t0yT23GHrqAvx0F+PRWJw
X-Gm-Gg: ASbGncvoIDivLs5z2ApL2QmNQUnIvnQLTb5rJVDUsm2fYsq6YBI4SuyJq3X1RFW0tne
	TdmMwgPGl6tY7VKDUHuTzipzLK9qszfRws+xFt2INjkyjWizlqqge+ykEo94wGVUuXI6gQoVQvU
	oLWksFOXYmOF95WaHGcJjTZ9MMgUV05N/SkopLC2cx75mIFawsV+g3oGBl6k7U15T/Y5p/PyOt1
	ECeOO8+JRmcc+2v+viiYr7m0fpx1W07i4GppcoRCtvy2Q0i7+dZQ7uBoc0WH0KY9erpl+xQg8GK
	pV6pOHla+LjGIurGIAdJABTGWtcfK5oaP7FoALb9ksXuwUlsXdef0Fw=
X-Google-Smtp-Source: AGHT+IES/XldM6S90tGLggidsk/u7O7S96uu0t+QbeDBfq7jKunZ4xeJ3gs6IPDlJd/jpI370FBeR1jE+0jy
X-Received: by 2002:a05:6a21:3298:b0:1ee:d6a7:e333 with SMTP id adf61e73a8af0-22026fca5demr1802671637.8.1750432214401;
        Fri, 20 Jun 2025 08:10:14 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-7490a413d7asm114334b3a.3.2025.06.20.08.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 08:10:14 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id C9C283403AF;
	Fri, 20 Jun 2025 09:10:13 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id C90F9E4548E; Fri, 20 Jun 2025 09:10:13 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v2 01/14] ublk: use vmalloc for ublk_device's __queues
Date: Fri, 20 Jun 2025 09:09:55 -0600
Message-ID: <20250620151008.3976463-2-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250620151008.3976463-1-csander@purestorage.com>
References: <20250620151008.3976463-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

struct ublk_device's __queues points to an allocation with up to
UBLK_MAX_NR_QUEUES (4096) queues, each of which have:
- struct ublk_queue (48 bytes)
- Tail array of up to UBLK_MAX_QUEUE_DEPTH (4096) struct ublk_io's,
  32 bytes each
This means the full allocation can exceed 512 MB, which may well be
impossible to service with contiguous physical pages. Switch to
kvcalloc() and kvfree(), since there is no need for physically
contiguous memory.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Fixes: 71f28f3136af ("ublk_drv: add io_uring based userspace block driver")
---
 drivers/block/ublk_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index d36f44f5ee80..467769fc388f 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2486,22 +2486,22 @@ static void ublk_deinit_queues(struct ublk_device *ub)
 	if (!ub->__queues)
 		return;
 
 	for (i = 0; i < nr_queues; i++)
 		ublk_deinit_queue(ub, i);
-	kfree(ub->__queues);
+	kvfree(ub->__queues);
 }
 
 static int ublk_init_queues(struct ublk_device *ub)
 {
 	int nr_queues = ub->dev_info.nr_hw_queues;
 	int depth = ub->dev_info.queue_depth;
 	int ubq_size = sizeof(struct ublk_queue) + depth * sizeof(struct ublk_io);
 	int i, ret = -ENOMEM;
 
 	ub->queue_size = ubq_size;
-	ub->__queues = kcalloc(nr_queues, ubq_size, GFP_KERNEL);
+	ub->__queues = kvcalloc(nr_queues, ubq_size, GFP_KERNEL);
 	if (!ub->__queues)
 		return ret;
 
 	for (i = 0; i < nr_queues; i++) {
 		if (ublk_init_queue(ub, i))
-- 
2.45.2

