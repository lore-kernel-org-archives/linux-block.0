Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADE281AD7;
	Fri, 11 Oct 2024 17:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728666214; cv=none; b=D7oRNdgKjxuKF/2uV1AqtSQGfY2ou92FrW2AeWoRinUiq00/+X2eY5xOC7K2tb52lzMoAFeSd3KkDWVfwC6H7nEj2Yj35uM2+MKQwoBEvaR+dr6pnkMPW1DDhK2Y8sUaZ4uMjrZpv1aBLECfIzhjofBJOps4xud5Ap9eirVYUlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728666214; c=relaxed/simple;
	bh=wUUK1rQSfa96ydZdXqc0ewnp59uc09fzzahy3mtmRko=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bOAlraSTGq/DlV3MThw0hlvSPvzHO2MO1CvqqvogfnbwnmyDEJJN62ZvNNDi30cYv4MLBooJEuww1Ap0ZPI1M/jD9thzsa6pztULpsDZmdN9iQR91BaF5Wyam3ePcRsn31qWYphQ9hh54dtmbbm6vEu4grlYN3O1O/piEJVgFeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-37d43a9bc03so1274536f8f.2;
        Fri, 11 Oct 2024 10:03:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728666211; x=1729271011;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vTfOyfLv8TRJcCBLxu7TtJPYlmj6NMUkEgMfr77g03M=;
        b=P2Gie8heBshs1F92joxzWVepz5ltRT58pju2Wqs9f+0IjXpyZTnbviA41P6y/MruMO
         hgsqOfxQVzqKsDafkHOrxt1TrGjdNpYhSXY6mwjsFZ4hk/D6yfYROm8Zun/Um26irQ6E
         wEDdsUoDhBtq2wMZfBSIYoD2/ppV0E5zWYn/2IO8rlnxJ2xQqzmLMYXlPl3OJuuQNQxL
         IpzovtLwRwyjNIDZPK10dHht6O7RAOeoK3N7xTIcSs3/cYt9ugN3CMfXYujwIIoke4SU
         eW+LtPMSTQfI+cxXxLyV9Xtka0Kw0EB2m4Wp19YZ0kOKiqhbVT50do0hiI1zYWs7UWHz
         1eyg==
X-Forwarded-Encrypted: i=1; AJvYcCXKZjt/VGj/AXRl/8v9U2wZag/R9OyT5sUBdfuNogMcowMtrJ6g9CtfTtUSIHeMSuC4hyv045t/fT/u4A==@vger.kernel.org, AJvYcCXQEZ90fm3jA56wLQvX1v1gbshEa3syst+4ojlO2Dx6Du7mjtK8mbVxpn29sj6zSFdQcZHmJ+vtcCWHGy9o@vger.kernel.org
X-Gm-Message-State: AOJu0YxNcIsJZB3XSK9mnFINdhINeQEjm18NbsF4oHPMp5t6YB5xk4tq
	pGDJv3XzVFOiA+xGrdw0Wp4htVB2+mjPgZQ9LdGq4cy63o4gycyP
X-Google-Smtp-Source: AGHT+IHOUA1KFTI0ZqOZDgpPW54yLU9DbBd/VxpToYcNTf/LnpqwsvPC65oc5ZcryeVfGubb14pXHg==
X-Received: by 2002:adf:fcd1:0:b0:37d:51a2:accd with SMTP id ffacd0b85a97d-37d5fd4603bmr311018f8f.0.1728666210372;
        Fri, 11 Oct 2024 10:03:30 -0700 (PDT)
Received: from localhost (fwdproxy-lla-006.fbsv.net. [2a03:2880:30ff:6::face:b00c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b7ef4f6sm4401778f8f.107.2024.10.11.10.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 10:03:29 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: hch@infradead.org,
	Jens Axboe <axboe@kernel.dk>,
	Damien Le Moal <dlemoal@kernel.org>
Cc: kernel-team@meta.com,
	linux-block@vger.kernel.org (open list:BLOCK LAYER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3] elevator: do not request_module if elevator exists
Date: Fri, 11 Oct 2024 10:01:21 -0700
Message-ID: <20241011170122.3880087-1-leitao@debian.org>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Whenever an I/O elevator is changed, the system attempts to load a
module for the new elevator. This occurs regardless of whether the
elevator is already loaded or built directly into the kernel. This
behavior introduces unnecessary overhead and potential issues.

This makes the operation slower, and more error-prone. For instance,
making the problem fixed by [1] visible for users that doesn't even rely
on modules being available through modules.

Do not try to load the ioscheduler if it is already visible.

This change brings two main benefits: it improves the performance of
elevator changes, and it reduces the likelihood of errors occurring
during this process.

[1] Commit e3accac1a976 ("block: Fix elv_iosched_local_module handling of "none" scheduler")
Fixes: 734e1a860312 ("block: Prevent deadlocks when switching elevators")
Signed-off-by: Breno Leitao <leitao@debian.org>
---
Changelog:
 v3:
   * Remove the helper, since it is not used anywhere else (Jens)

 v2:
   * Protect __elevator_find() by elv_list_lock (Christoph Hellwig)
   * https://lore.kernel.org/all/20241011154959.3198364-1-leitao@debian.org/

 v1:
   * https://lore.kernel.org/all/20241010141509.4028059-1-leitao@debian.org/

 block/elevator.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/block/elevator.c b/block/elevator.c
index 565807f0b1c7..640fcc891b0d 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -708,13 +708,21 @@ int elv_iosched_load_module(struct gendisk *disk, const char *buf,
 			    size_t count)
 {
 	char elevator_name[ELV_NAME_MAX];
+	struct elevator_type *found;
+	const char *name;
 
 	if (!elv_support_iosched(disk->queue))
 		return -EOPNOTSUPP;
 
 	strscpy(elevator_name, buf, sizeof(elevator_name));
+	name = strstrip(elevator_name);
 
-	request_module("%s-iosched", strstrip(elevator_name));
+	spin_lock(&elv_list_lock);
+	found = __elevator_find(name);
+	spin_unlock(&elv_list_lock);
+
+	if (!found)
+		request_module("%s-iosched", name);
 
 	return 0;
 }
-- 
2.43.5

