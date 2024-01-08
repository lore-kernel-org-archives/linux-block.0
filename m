Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5430B54F85
	for <linux-block@vger.kernel.org>; Mon,  8 Jan 2024 19:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="PVjYdEow"
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-360576be804so1470275ab.0
        for <linux-block@vger.kernel.org>; Mon, 08 Jan 2024 11:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1704740478; x=1705345278; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qQ7oboKZXJiIwF/pzsjFjn4GRumBSljx35OhJYFhzXI=;
        b=PVjYdEowHOqnNE89G2Een5oumdoWVSJI6ZotfJe7zD56Gl7ggSZ0Igo/M0pX9Q2Yal
         cp+HJ8D+cmDdBZlqwKCSxqSrx5xhOJXo9GNy3ur/fv1Aa7mB/qXj+Lf23+VKBo9qa8WI
         7y4F1Yeh7PT2l083lcAlcIVAU/WPon/L4B7oFJ8wHjabv3xH8KiY+K1Yhf7Iuy51Q5YO
         xe0/SnTlf0C1OGPY+zJnzaxnra98GoLUBbfaewZCIc7PSVquzUJ0FfrtAqqcmiE+V13o
         1q0Cn8wlzcAdmuwRY+qPW8TAYCaUiW712cmxDdfiO1yJ1TVpdWi8UoL6GxHL7mvK/Xn0
         ZQAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704740478; x=1705345278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qQ7oboKZXJiIwF/pzsjFjn4GRumBSljx35OhJYFhzXI=;
        b=gL1eQNOk/HJLC/kE0SoW3d//bioCD04S+HcOoQs0dsb04b+wbhqarYeOLAKr7Dq6bG
         Fw4YZKl8p602KA7z6GYxwdsMPLYGoxWliQAT6gVdVOIbsZiN2MvRwgXKVoZJHR8ugjBK
         SrwoeuMOtiQusz2pCj9xdYs7ImcL/NwOBOpJ/NW0zx3hc4ickMtjLjjgdb6bLQ+pCzEZ
         0wLjRIhfY2/zeS2uhaO6EVH+gVBfkfLvv/q6fl79yXWXSzB5wbTekvZHYPVhci6K5/77
         UGPWWJr66x1gHgN28Vqm4Fkjs9vjW6XMf+/moIceTO0hSaAwhdDh8Y3bO17n06c4y6Cm
         o4Yw==
X-Gm-Message-State: AOJu0YyFoDTRCb1KNYuVEU8P4QXGdBmC2PxVD2oSRit6uvr2yULGlN9Y
	LBdMZLiBoNytHUPfZKhgBQy9vljCNNpnzLC/G+pn1FG8OfKefg==
X-Google-Smtp-Source: AGHT+IHbLZ1m/QGXF+/VWDXPZv6uOk9TJhVWE76kQxDye8v1emzYJrihY70rD2yLfuqpasBXAvuWhw==
X-Received: by 2002:a5d:804a:0:b0:7bc:207d:5178 with SMTP id b10-20020a5d804a000000b007bc207d5178mr7114789ior.2.1704740478613;
        Mon, 08 Jan 2024 11:01:18 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id z12-20020a029f0c000000b0046dcb39c1d3sm128206jal.28.2024.01.08.11.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 11:01:18 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/2] block: make __get_task_ioprio() easier to read
Date: Mon,  8 Jan 2024 11:59:56 -0700
Message-ID: <20240108190113.1264200-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240108190113.1264200-1-axboe@kernel.dk>
References: <20240108190113.1264200-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We don't need to do any gymnastics if we don't have an io_context
assigned at all, so just return early with our default priority.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/ioprio.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/ioprio.h b/include/linux/ioprio.h
index d6a9b5b7ed16..db1249cd9692 100644
--- a/include/linux/ioprio.h
+++ b/include/linux/ioprio.h
@@ -59,13 +59,13 @@ static inline int __get_task_ioprio(struct task_struct *p)
 	struct io_context *ioc = p->io_context;
 	int prio;
 
+	if (!ioc)
+		return IOPRIO_DEFAULT;
+
 	if (p != current)
 		lockdep_assert_held(&p->alloc_lock);
-	if (ioc)
-		prio = ioc->ioprio;
-	else
-		prio = IOPRIO_DEFAULT;
 
+	prio = ioc->ioprio;
 	if (IOPRIO_PRIO_CLASS(prio) == IOPRIO_CLASS_NONE)
 		prio = IOPRIO_PRIO_VALUE(task_nice_ioclass(p),
 					 task_nice_ioprio(p));
-- 
2.43.0

