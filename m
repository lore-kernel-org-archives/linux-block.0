Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043E13FE5F;
	Sat, 16 Aug 2025 16:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755361525; cv=none; b=Sj1qGakynP0w7J0LEb8GzmNNlxLjKDjjLUQy6vPm4E5ccYrV2W6kyhRmnXrGHfWxIjIUYXRmaEDN5vfno/nqFBZbw0ApGjM5SSYjQIPZWOHkDkI+VyTCifcK+V5ukZe8g3E8FvzBoS7EgNnPSnN7vqpnnsfoHO5lQal9vXwGlqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755361525; c=relaxed/simple;
	bh=psACTKma/alGF83wjVBQej1BbDd8pWOmHU51G23X4G4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AoNKmfWCNTeTJ+rq2h+rt7pT7fuMu5WNugTnFcmOrVQms42J/NaHeaKKaF/Nb8zX6i9ww5F7wCBdEPwy4wpFsqiEnFKV0Deep/MjtmEpCsMsJ1mov3hnTMm6sOem4Hq0t8Q/SDbsgcrPW4DoCxDLU8RPCmAeEpyx/zlijc/bmDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XeiKoiLP; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XeiKoiLP"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2445827be70so31217745ad.3;
        Sat, 16 Aug 2025 09:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755361523; x=1755966323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AdhKNk2+oVSN9oLALi02B99FMyIcDAgZBsj4njYLsvM=;
        b=XeiKoiLPB+GpNIh2okoy6XO+RcH5HN8zTt4k2hwv5aAp0QHiX97Uk/ubp8tLJlctAj
         HVddOQpUqgpGkz7h4SHFy6lqebc+3zGuWPYhGDHOny3aTsz4zs66jDFtnD7y4H7VWrRQ
         2ksSIpetXdnyAy2VQ5OUur2KqL5hhlo08VxONBA++qVo3d91ukD+3ERMu/4Ws3eufjhS
         f7z3HWvYw58bFxw7wLVF6kVVhtzbW2pQvvAVnfzWWdqz5T/Tv3tzhx4+tCb43bioBNua
         btHtB3NEzxHnJMl0aaS4J4OG8pE7LVoepkiWQoNADfKTtNRmd05uS6nWZFI6C4kjx7N4
         6ycA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755361523; x=1755966323;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AdhKNk2+oVSN9oLALi02B99FMyIcDAgZBsj4njYLsvM=;
        b=PX8Lvz0IhP4te9o0TQnR6Oy2UMCLHX5wP5kDU+1pyguE3YPy7Gn2oBmvjYUxsK8vGx
         jTKS0/QyoyTqCWCXsyaJ4cUdemGAYGn1HZQedYq7T2wnv+ss52tdkm2w+HhoC5eZfjZm
         BurHYCWrV2rbPCRhc46yuCrsQBhTYgnQJQtodl6CHORkeTu65v/hJU8zveSwnW7oGGh2
         hq6Fqe7QFcigZwz1zabhOXu2ulbTzHDJsHhAcmJvbQKaL7bbkZmSl4mdQNMnQCmDxTke
         qjKfgKu4mv+D1itI3fv2YnpTuhSmqZ0y2njKp3x6EQvonNiBLQgbO1xtNeDtXlo6CYwT
         P2iQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqqE8chtWxO9DUzhMCE+Z1ctSV/hRl0F5hzbvbjeE3g1ArjMeOUSczoqPEwfQF2xLi++KIda0Ra/EAhh8F@vger.kernel.org, AJvYcCXsTZZAJA86NCKl2HDl0YQVSolwKzcMpCvqMQz1X1cUdxPd2HGZzOXBjH7TcrtnhuvZg2YX8KMNj5gRyQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyyBJTow3gRHpb8x1QKhFk4E3JdJ3oWG6CGeUtciNnVoInWExrp
	0rGBPxRifIg3s0BP62NsQyGLy8s4abTHr6ubVbYIDkqJe7y6suLb2tYl
X-Gm-Gg: ASbGncsfayOW/nDcDNZFB5hvp/TJXJ5krc2NvSwhWNCkvVmjIe6GD4NrHH3A1KMPd3M
	JhW07EiOon2jz+38wPpnihbgZ8NtciKSw7lBH4HNySEHUQDofxjwSL7sZ2ALgqeB/g/eZo8Rqv0
	ZZ03x9D+ktulheaZFqXRi6mOs2EK7FP4ZgF99M9SIDrRvMJzRVFQ+71zINR+o/gEGAobmIB3oo3
	d5HKYwz2a6gXmVnX4S4qCVv7Tay+GU+H0Cw7U5sY2mrI4dgIJ8jI9Q39VtER47A9DAmLr//dsyU
	h3Mr33aeXulr+LDjKlMkvBBTehD9iqHub2/f6pbQOCLd7833e8kXxFyQmrk1El6nv2m7LgEsEyz
	gVry4iFaWujaLVOZYyz2+S65qgpqBw2i2agZdHX830/Yu4njBlFsUYA==
X-Google-Smtp-Source: AGHT+IEs9fGpoCpKWUXm4n67qUvO5gjp+6V9RT7b6NxVFYdLHTJifnKvvi6ucGi7KD5xv2fFcrILXw==
X-Received: by 2002:a17:902:e751:b0:23f:e2e0:f89b with SMTP id d9443c01a7336-2446d5ba169mr80248875ad.3.1755361523015;
        Sat, 16 Aug 2025 09:25:23 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c408:a82f:ebb8:7335:2344:5a58])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e452666besm3559157b3a.1.2025.08.16.09.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Aug 2025 09:25:22 -0700 (PDT)
From: Kevin Paul Reddy Janagari <kevinpaul468@gmail.com>
To: efremov@linux.com
Cc: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kevinpaul468@gmail.com
Subject: [PATCH] Fix race condition leading to panic in reset_interrupt
Date: Sat, 16 Aug 2025 21:53:57 +0530
Message-Id: <20250816162357.554462-1-kevinpaul468@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A local syzkaller issue shows that rapidly triggering floppy ioctls
can cause a race condition between the interrupt handler and the workqueue,
leading to a NULL pointer dereference.

A valid context pointer () is overwritten with NULL between
a work item being scheduled and its execution.

This fix  introduces a spinlock floppy_lock  This lock protects all reads 
and writes to the shared floppy_work_fn and cont global variables.

Tested in a qemu instance using crepro by syzkaller

Signed-off-by: Kevin Paul Reddy Janagari <kevinpaul468@gmail.com>
---
 drivers/block/floppy.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index 24be0c2c4075..3a1c8b204912 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -992,7 +992,16 @@ static void (*floppy_work_fn)(void);
 
 static void floppy_work_workfn(struct work_struct *work)
 {
-	floppy_work_fn();
+	void (*handler)(void);
+	unsigned long flags;
+
+	spin_lock_irqsave(&floppy_lock, flags);
+	handler = floppy_work_fn;
+
+	spin_unlock_irqrestore(&floppy_lock, flags);
+
+	if (handler)
+		handler();
 }
 
 static DECLARE_WORK(floppy_work, floppy_work_workfn);
-- 
2.39.5

