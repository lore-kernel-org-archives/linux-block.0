Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59EF11F5E6
	for <linux-block@vger.kernel.org>; Sat,  1 Jun 2024 22:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717280301; cv=none; b=RDkdPxRgB0riv2+aPuAyF8jMl5evfhSAz092cd1r67yJ9++Ouly7cb1VyzQYBm8Xxg4cxkbgwaFdqP/n7emHTYWaRvokG4wMnQhYFJ4dlY1yJ86PGELjX66Iny//hQdUwwmARcdJ2CYBo4E6JUOZAy7wDwfWmQmLcRaoMl+g0RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717280301; c=relaxed/simple;
	bh=SUIN//KyfDe2RxmZ7/ZO72UKRmd/4tXFWxkO6sJTzx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m1V2tMD5VjcQK60NIQTNxi9T7UmW577xSwTenNyDoGIXPhyROcjh0A1AlMZRitKKhv1t5fEarY6E0qx8V7CtwQ09PmNkCkRn/pcUxOCYb8SxQYS9xCCb2ZhGloCovLQyaAK1OcdbtdQzV94dYleo6Sh5W2Wb9mxfSGX/J4F66BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=philpotter.co.uk; spf=pass smtp.mailfrom=philpotter.co.uk; dkim=pass (2048-bit key) header.d=philpotter-co-uk.20230601.gappssmtp.com header.i=@philpotter-co-uk.20230601.gappssmtp.com header.b=j7jhIgai; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=philpotter.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=philpotter.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=philpotter-co-uk.20230601.gappssmtp.com header.i=@philpotter-co-uk.20230601.gappssmtp.com header.b="j7jhIgai"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-421208c97a2so28393195e9.1
        for <linux-block@vger.kernel.org>; Sat, 01 Jun 2024 15:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20230601.gappssmtp.com; s=20230601; t=1717280298; x=1717885098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ngUNuLzfLATiwKJJMgh9h8krJGk+FFmn9uz/BYWOqIw=;
        b=j7jhIgai57VbpN/QJRc4cgcYek2Yxl4cjqGWB7qQyKODB0MmH3dYCil6PXal19Xu67
         s6DdhRmZ9tyeAjKIyIR/5qNPXOmMw+FX0Hcvhxvwwss1jV9OkAmNSw2Ux10ttuYeFN0N
         VfHneAxuyk6dXJBh91PymY4mGN5LUcsKGiT16SXWz6ZcATbuVqXpdJ1ibwR6qH4B4qnO
         HRmwBgJjp7SCULlF8nAW/y5ynpqoeBNy+rIiN1UjUsbjwNZ+whMPMfCfOvwCVfH7Vkhz
         MqEG/xainUlNMFJsnMxuTuOdIYMcx3QkWzUkZMPPFqiLvdCLRUf5VVs2xZVrMxEoO35E
         YMQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717280298; x=1717885098;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ngUNuLzfLATiwKJJMgh9h8krJGk+FFmn9uz/BYWOqIw=;
        b=swhsUGmzKAXn58ghUUPLLjUTYQyMIncX6Erq+YIYDytSMq/a9Rd/xciARh2ZzZj8KJ
         NmHmQNggODN8qEa+seYJN9SCH5jiC0+PAkUE+WVM9smmBwJ1YqbiErB8AYBpMo0tE+h2
         /f3PfIzEXSi0ASwqhjOIY4t2O9tBk7QbdDYusKxI+XNzKUPrwIxtzthcDpgssj9050us
         3Wm/xqbYsFHwv2fYDPD2QRCs34BszozsZLn5HQ4izgPgPi84WgKmPiuPpcwg1dlFGFb5
         tjcXFzZRCa0CiGMci86hS5LpGpP8jWlCCdmTLyGcffuJftYmsiW9F4Gd7lJrrO7UhvmR
         Q9/Q==
X-Gm-Message-State: AOJu0Yx+Ct/sY9+qeXB/YDNMbZ7XTR+BF68oW9nQ3OY0uPVSU/NY7ntO
	vkUvyT5GzlXc8bJDp5zP7WBkFu3K91IpXKMBhhfVeyRS3s+272cubWYXpmppWOI=
X-Google-Smtp-Source: AGHT+IFs7yp4HMkBNcYVjU/7ppNH8AM2FVmXhVQ3OXGI12o7CzGni6K9bJQ+C7lhjhC4o2OQ6SGboQ==
X-Received: by 2002:a05:600c:1c1c:b0:421:2adb:dd5d with SMTP id 5b1f17b1804b1-4212e043d2emr43639685e9.8.1717280297683;
        Sat, 01 Jun 2024 15:18:17 -0700 (PDT)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421381c650csm19592865e9.27.2024.06.01.15.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jun 2024 15:18:17 -0700 (PDT)
From: Phillip Potter <phil@philpotter.co.uk>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org
Subject: [PATCH 1/1] cdrom: Add missing MODULE_DESCRIPTION()
Date: Sat,  1 Jun 2024 23:18:16 +0100
Message-ID: <20240601221816.136977-2-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240601221816.136977-1-phil@philpotter.co.uk>
References: <20240601221816.136977-1-phil@philpotter.co.uk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Johnson <quic_jjohnson@quicinc.com>

make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/cdrom/cdrom.o

Add the missing MODULE_DESCRIPTION() macro invocation.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
Link: https://lore.kernel.org/lkml/20240530-cdrom-v1-1-51579c5c240a@quicinc.com
Reviewed-by: Phillip Potter <phil@philpotter.co.uk>
Link: https://lore.kernel.org/lkml/ZluYQbvrJkRlhnJC@KernelVM
Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/cdrom/cdrom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index 20c90ebb3a3f..b6ee9ae36653 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -3708,4 +3708,5 @@ static void __exit cdrom_exit(void)
 
 module_init(cdrom_init);
 module_exit(cdrom_exit);
+MODULE_DESCRIPTION("Uniform CD-ROM driver for Linux");
 MODULE_LICENSE("GPL");
-- 
2.45.1

