Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1783175550
	for <linux-block@vger.kernel.org>; Fri,  5 Apr 2024 21:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712352301; cv=none; b=Yaijf8o0UdlQb6MWG3xwPwq0gCMV5u17iQ1NwssmJo5aK+snFVNOzI6OrRjHas7Ro5k720IOu9BK8/lsjDXvLVUDNbkG2zBOpQtRI/hAPyqtT6RWyKusIDHOc0t/kXC4/fLr23kyVLiMpUM0DR8LdfMGSLbR7zyM0VA5myGzr1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712352301; c=relaxed/simple;
	bh=EObJSk1gTozIYXoylC4wrkj5Oyx+bgYarnIhKmB7X20=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ebly+Gf1J8VeuKuVlKYUKFsOgLNB9WpziYiJr7a2aMprgymXGmQecbIWdOTQH+a/n+z4W5arM67Cvl2XHes07nXS9edLY4XygVUcG6DNv7LZJYFOzorHPBu7fIvXJM5yhNwq9jmqszSlC2xnN5X/928UAX1gx0saD1/umK0ke9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OppOowoY; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OppOowoY"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6eced6fd98aso2135977b3a.0
        for <linux-block@vger.kernel.org>; Fri, 05 Apr 2024 14:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712352299; x=1712957099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gdVYLNH8KuqKJ8kDiPrCytZdr5cNufr6nL8DEmtEIDk=;
        b=OppOowoYpqZ0wSppn6Tiqtg+BdUbgeChnk7d/dIQ/1rdqEpo8bgup3r7XTpO+izn6v
         OgyEbb2gDfpkY8YGs5h5KYSVjr9m7CKZosglIsJNoPTozn9Kx2IC7GM8PtaAQWDKPtT2
         pKv72ULVQzn9tZ01ApizgxEaKA5ex/tO0PxIkPtgF3mDpdqbZUWszQW7DXZ682NMUd7T
         gO5vlvhnboN2jK/IM2VOZFjeuWkx6+C/AT2b9Aqr+l9iIeIq66sYQk0pfUoduiZ/dGXW
         vEYBMhQuQ/zGddWKgn5mgSbw+ShbjWx4KGjjcs4wFTlBFL0WLx5+ilgnGWFsmp+C8tRz
         EEvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712352299; x=1712957099;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gdVYLNH8KuqKJ8kDiPrCytZdr5cNufr6nL8DEmtEIDk=;
        b=srCDFS3QSxGC/zkho6kRrPpwH0pjlfSqzr0IL6K4JGoqo/8MPL1ljdC8aVXbgq58CX
         LQrhrGxglof0anGRvPCLqBdeh/Y6y3Q/wxZLmErytBZXwke/M2bC4Wm54cAbywo+xpAD
         iV44qgskFFm8x0L+ntEwdPanjc00RL/WGnxK77ygjqeVSus3wkscCn+WZcmh9VtwbuXh
         /vZ9xPr12XuKmORSIOCY1BWpXcQZaSVhSlJktC3T0DgWizXEJdgc1wC1OuPJqUmC38jJ
         99blH+4qVUYh9c/s6bQsJmrMsQ95NH/zrRUHfvbh/mUPDSflNdBv+iL52z2VgDDm5/Eg
         saUg==
X-Forwarded-Encrypted: i=1; AJvYcCWZqLjyWl4Z5IER0sgH0EA7hATNA6sYnZli23whCprhyRM1XH7jYFe/LsRn0dgM/p4MGVDKHx07VI9ZWu9xMyjBvU8FYvV1RPnp57g=
X-Gm-Message-State: AOJu0Yxef6QE8qDIYAxFVgb7qLTfoQ503J3MMCv3MLnKEQ2DuHZ3twLz
	RtHU7aZEXo5TUBUs9KMOk4Gp6YVigPJGJY3IgdKgueJL9VtxPRSQtHIwY5jizwQ=
X-Google-Smtp-Source: AGHT+IHtk1bP6Q3y5vSA9cfQINaX1qDHkDIQWa0SCyqDlsMPwzR+p22yU8q4+gwRstc4SKKUw2xDgA==
X-Received: by 2002:a05:6a21:a5a6:b0:1a3:aecb:db60 with SMTP id gd38-20020a056a21a5a600b001a3aecbdb60mr3557654pzc.9.1712352299030;
        Fri, 05 Apr 2024 14:24:59 -0700 (PDT)
Received: from tokunori-desktop.flets-east.jp ([240b:10:2720:5500:c6c4:352b:b00b:887c])
        by smtp.gmail.com with ESMTPSA id r3-20020aa78b83000000b006eae6c8d2c3sm1965726pfd.106.2024.04.05.14.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 14:24:58 -0700 (PDT)
From: Tokunori Ikegami <ikegami.t@gmail.com>
To: Bart Van Assche <bvanassche@acm.org>,
	linux-block@vger.kernel.org
Cc: Tokunori Ikegami <ikegami.t@gmail.com>
Subject: [PATCH v2] docs: sysfs-block: document size sysfs entry
Date: Sat,  6 Apr 2024 06:24:48 +0900
Message-Id: <20240405212448.6062-1-ikegami.t@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document it since /sys/block/<disk>/size is undocumented.

Signed-off-by: Tokunori Ikegami <ikegami.t@gmail.com>
---
 Documentation/ABI/stable/sysfs-block | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/ABI/stable/sysfs-block b/Documentation/ABI/stable/sysfs-block
index 7718ed34777e..5b7ef093b60a 100644
--- a/Documentation/ABI/stable/sysfs-block
+++ b/Documentation/ABI/stable/sysfs-block
@@ -707,6 +707,13 @@ Description:
 		zoned will report "none".
 
 
+What:		/sys/block/<disk>/size
+Date:		April 2024
+Contact:	linux-block@vger.kernel.org
+Description:
+		[RO] Size of the block device in units of 512 bytes.
+
+
 What:		/sys/block/<disk>/stat
 Date:		February 2008
 Contact:	Jerome Marchand <jmarchan@redhat.com>
-- 
2.40.1

