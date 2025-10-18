Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7605129BDB1
	for <linux-block@vger.kernel.org>; Sat, 18 Oct 2025 20:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760819927; cv=none; b=ATdjbQFeLkOjJHbB1mXxRoi6TMg6ytR270dd183fgceILOJWgfgH3PiYAZSPRQKR5MLnzNVA1LyhMWdxx5mc6YZ5NZZR89lH+gz7SHj/btbN/B3HIvdO3vKXFe/IL9UzWjVl2vXL4gvVyLT+Tq7Fx9wd1ZcJG5h6fMUASEaPOZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760819927; c=relaxed/simple;
	bh=gXiDaLZ91cP4YS9lUPTJFUZXlsCNeyjYE1dKNW2Lj2A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Df93nWugAoDJVrgY875sRBfh3BZFXwLXQChZPIIQeaO3fywnN10ByLsq9K3fV8pLBW4Mgf2eOZDuU7WC/XTS4xiJSlQ1T+K2o2gCsqryHx+wB0ntWML/3Q0S1kMpgt29tyfIzPe+jBCKDaK7ygZaHyJD5STSL8q23zVjYImaTpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dohBeJ7n; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dohBeJ7n"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4270900c887so231627f8f.1
        for <linux-block@vger.kernel.org>; Sat, 18 Oct 2025 13:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760819924; x=1761424724; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x9i40smiRcDxizYgBMawCBNl5T4msgfFadm8b+kPK2g=;
        b=dohBeJ7nL4S2Q+Jrktq35YgWasEijVNyfNuXa9fhkjzwk7n37uc1hJxRgFPy+k8MPG
         TSCYd+i+uM777C2cs6B4b73JsgCpmSmYe/HCGlDmUvrlLhSvDbj/ADklJhOohkRS1UpD
         sN+8YGKF62AlCFgpLmxqhpZNhk79JQyB7Cw3wjyruO/ul7gc8/2q1iGLebF3GUSi0RWI
         T4/XRllU9LX+ULFXMP/a3aFolXEkizw52QrFpQyZuF8KQOnSc9/b8mfi8dyAmfe3+Tx4
         ClqNQzA15IupqB9PwsVkTaHrWlQCry+Q/0hQp4ekmoPBZoRagUpDwr+G+zkQjM8UN8rY
         JtRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760819924; x=1761424724;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x9i40smiRcDxizYgBMawCBNl5T4msgfFadm8b+kPK2g=;
        b=DYJXbA2PEKNQ0HN4580yvh+PiB+N/pFYun0XvfZBMJ7FsQ4H9g1yTQT0CPhG3vKcbR
         adHCr5vpeWOJVBeliw6fYkAbxwYJ7rBzmB6KNUsUlaUbsMEZuB6J4UCXI4MpNMtKoE9v
         3x0XeauMVcD9GbCqQIkQ1M9Rip5n2hrYm3DQ88Nw6VsQtEzGUV7O0Ewm3Hnx2UGZ21ea
         dFQLUZ8VCjbiFutaQpcNxzfROnIMCVcOO1OvXqofHiDXSBBsB5D868PV/a+LKFmIAYME
         RJd2XEVwQYmACorO3/MXGBUS6OLiR9a+tCkbW/JIEiFCt+6oJv5KAO6eefxJKHwPcKXB
         w/Xg==
X-Gm-Message-State: AOJu0YyRQBK5KbAfn7aWH0Tqvu1TnXisOhLy4NTnMAdyR1bgx6t3iI/N
	wqxiZjzYFEp3RzpW/Vu8tavS+bZUUBZM//AKRl+wtNYK+FEWAGo5X+L6
X-Gm-Gg: ASbGncuPN1qAJ9lsluKCPGVadwYLjDm6f/GFbquTrv7dGdfS5gwUbMW0QC+TS9C/q+k
	28hu4I8vyclLShN7sVYwz/Ag02w0m52/IC9MTzXQJvnfPFYvW61aVQ6qmBCXGJpP8ZPaZM2EEbw
	MmU3ZpsCc/XuQFizOxu8RmdxkbNwNU6l5q+UMs9ljD+bHvOHfa48/AiWB+I8J4Sb00l3htJW4eg
	v8DjHiEiT/5FY5yi7pjyObP+B7ITI/tdiJtiZsEJToJD3YXV3hhh+sd9EuPa+Pma3/u/IyIztdT
	cLbZS4sW2aTzSrANi7Th7kunbXgYR4nURkQ1QxnFsUONseeGDR3d+WLBXZN0F1ZjwWu1wEU7KbW
	JK1YL+LPj+QFcxrY1OQ/AOav5mmhwKw8V4k9aaUbPvZijOWmL/jxDpyHkp+YSD2tGruYiVdOYwu
	UGzC/Ae4V5MP4tzdA=
X-Google-Smtp-Source: AGHT+IHI0fmt4JmUe22K1u4pN/SrFRoF9/x8jnxN9nc1hal9Xk8KmftD9LhBWGubiIcbdw640e+xFw==
X-Received: by 2002:a05:600c:3149:b0:471:161b:4244 with SMTP id 5b1f17b1804b1-4711792a696mr32181475e9.5.1760819923502;
        Sat, 18 Oct 2025 13:38:43 -0700 (PDT)
Received: from bhk ([165.50.121.102])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4710e8037aasm80372765e9.2.2025.10.18.13.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 13:38:43 -0700 (PDT)
From: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	khalid@kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
Subject: [PATCH] blk-mq: use struct_size() in kmalloc()
Date: Sat, 18 Oct 2025 22:38:13 +0100
Message-ID: <20251018213831.260055-1-mehdi.benhadjkhelifa@gmail.com>
X-Mailer: git-send-email 2.51.1.dirty
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change struct size calculation to use struct_size()
to align with new recommended practices[1] which quotes:
"Another common case to avoid is calculating the size of a structure with
a trailing array of others structures, as in:

header = kzalloc(sizeof(*header) + count * sizeof(*header->item),
                 GFP_KERNEL);

Instead, use the helper:

header = kzalloc(struct_size(header, item, count), GFP_KERNEL);"

Signed-off-by: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
---
 block/blk-mq-sched.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index e0bed16485c3..97b69fbe26f6 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -466,8 +466,7 @@ struct elevator_tags *blk_mq_alloc_sched_tags(struct blk_mq_tag_set *set,
 	else
 		nr_tags = nr_hw_queues;
 
-	et = kmalloc(sizeof(struct elevator_tags) +
-			nr_tags * sizeof(struct blk_mq_tags *), gfp);
+	et = kmalloc(struct_size(et, tags, nr_tags), gfp);
 	if (!et)
 		return NULL;
 
-- 
2.51.1.dirty

