Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7F82941A
	for <linux-block@vger.kernel.org>; Thu, 20 Aug 2026 04:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787200251; cv=none; b=PEmK7ob6IkKJQO3lGqiSWW8xud4Tt6fGqH7xGaGNRLM7RR7W7mAek9a+iy6dPpljS41DQC8n5VjtvBk5bPLIjRhN3+QUQE/nuyr6jYyqurafBmIRIbqWpy3nW6F/0FbQAicBOGhql7SL8npkuFU9I9xB/1vDmyofBg9VW0tvxUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787200251; c=relaxed/simple;
	bh=Gsc3MPeb/UzqY/BGYUT5a0UEvbWSGnyUPXMlynGthYg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xc7/Rh+F9QtTGLuXf6q6ZcKzDa8XkN9taJ7yBHMj2NnPfI4LAvRkO3nbATNbne7If+a0m/NlKSGBGI0ZlBBq+Evn+Zbqb8rc8C+AuzUDmTv33PI1mAkXelg5fVrwPBATICfdpKBpG600SoCVFmrn1Ms022Y/uGfCS6sNZqIMCHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sx8Oq6h/; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sx8Oq6h/"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cedda2ce6fso10076325ad.1
        for <linux-block@vger.kernel.org>; Wed, 19 Aug 2026 21:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787200248; x=1787805048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=I+IVgraoRn/WB9CLu47Q7vfnBpS7x8p+feFll9RC2u4=;
        b=sx8Oq6h/vW7FhaWz3Gd7314Aegjdk5TMBbqc5hhK2/DztQhvMS63QsMg6nDxz90BrD
         ZgyPH0S7tph7bXuJGbT4bWA8J3FhwAHlpmos4uqg4yTos/sbSxttIFxN/XE5TX+d1bA9
         KQcfiwidYmKuNBAEDntylgC5Z/A7P3Yvz489TR0zDUeJoToeHeAJ5o+3mZsM1Bxu+gK/
         eYvfZVgRIN+izhzgesaDlQybH98cY5RXxWCpzISoR90vzNTKmObXRfng9EGu1MIi0oXN
         SOkmLuNVnw+7U7URellw80A+gXz/aLuSRSm2KxlIqRyxo/iibj6k2pn7uWQA+XvM4xx5
         u5yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787200248; x=1787805048;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I+IVgraoRn/WB9CLu47Q7vfnBpS7x8p+feFll9RC2u4=;
        b=AlBItynFI6lF95XXC+Jor5nBcUXOCi5AZsQffQzbquUEle+SOa2Fb3i/wwDqOHrmwb
         nW9z7UfhLsEz04OmjFiD9hmYli02nngxW7UXVII1tpU5ZkN/FFVWH6W5Yn6mMx0GKvOS
         cqz4Yb+1oAbfRj6eR5BnRqiEIdRHUO2MuLJdJ/jWXxVhYXBLAfXpQSayp3i1gEex2HbO
         MM8c0Aq3qC538KaszbyIPKQms10dIpvQmMWPeLB+JdzgfyXpos2MChz66f3lcdTlPmh3
         GOwecM9OlBT3hWK46MeBp7+yC0bAQ710n0VqxvvRqJAzz95WBjCIRWyCTj7p2jmKUZn5
         aqPw==
X-Forwarded-Encrypted: i=1; AHgh+RoaJQdzhjDM9BNl7ouIP+4DXGD6+GruHek4qT9oyhtFY7iTefIaxYIM/7dV2yfHJYMPLaRvgzAEp6PgSg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ0QDkzB18uE8wy94fXlhrNyk+LPyFCLjnzPGsruu9ZnGocLUM
	X1l7UQIafpUTmAyLQQ+a9WgZeyCm2I4apWIFAyDvt9Yq4H9Ufwbulw0=
X-Gm-Gg: AR+sD11x37jmYPh4ameYEfPA1j3Nyi+GFB5hWasY4J6QvWeTW6/WuDoWXTfyGbW2Kq5
	0kYDMwlwY2NAMxSTRdLwErAmydL6uzoLq5sjMEuKOS9pXMzhqLr1DadauKOvqoKJzyy5NnOJsFf
	MnJnfK37fbRVL+Yk8FSUbrkooPjfCtfHzCh8qfVco8eIY4YP/jWUzvlkUNJbIDR/K5ACJlUMZ7b
	mtPJXt/LX974eyRQUOhJLzTDVGVgZ+cBgCCU7OELDOdMtIOZ4sI0hJ2eUV7gw6wjPeWDUMEA5SZ
	pml4pydEF4lzeOaSbkkK/1Uc1JygDMdyTSlI4g8Ld8pacgrrLMGelggLeG37zQftqEStTNeIlAJ
	/6HppsJULU9bPyztbxu5XOGILeRD4Z6jfshg+MBCwEdjmkjtgIHJBWY+MCF+G2UAdufXI5HEPP+
	+HSUgVvvuS9oqrOIZr9iD4CaBMyS3+HfaDbd0ZH+gfuYoSH/yU4o3tP/a5XlFktBLFobvTyln9a
	A==
X-Received: by 2002:a17:903:2bcb:b0:2cc:9179:32e with SMTP id d9443c01a7336-2d601e80fd8mr190373025ad.10.1787200247727;
        Wed, 19 Aug 2026 21:30:47 -0700 (PDT)
Received: from DL2XHKPB4.dl.net ([103.63.104.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d62e4ca49esm1760065ad.80.2026.08.19.21.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 21:30:47 -0700 (PDT)
From: Triet Hoang <triet.hoang.dev@gmail.com>
To: axboe@kernel.dk
Cc: dbgh9129@gmail.com,
	triet.hoang.dev@gmail.com,
	mateusz.nowicki@posteo.net,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mtip32xx: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
Date: Thu, 20 Aug 2026 11:30:33 +0700
Message-ID: <20260820043033.1945613-1-triet.hoang.dev@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the deprecated SIMPLE_DEV_PM_OPS
to DEFINE_SIMPLE_DEV_PM_OPS and pm_sleep_ptr().

This lets us drop the __maybe_unused annotations from its suspend and
resume callbacks, and reduces kernel size in case CONFIG_PM or
CONFIG_PM_SLEEP is disabled.

Fixes: cd97b7e0d780 ("mtip32xx: convert to generic power management")

Signed-off-by: Triet Hoang <triet.hoang.dev@gmail.com>
---
 drivers/block/mtip32xx/mtip32xx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index f214a616386c..cf44e281d7b3 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -3937,7 +3937,7 @@ static void mtip_pci_remove(struct pci_dev *pdev)
  *	0  Success
  *	<0 Error
  */
-static int __maybe_unused mtip_pci_suspend(struct device *dev)
+static int mtip_pci_suspend(struct device *dev)
 {
 	int rv = 0;
 	struct driver_data *dd = dev_get_drvdata(dev);
@@ -3959,7 +3959,7 @@ static int __maybe_unused mtip_pci_suspend(struct device *dev)
  *      0  Success
  *      <0 Error
  */
-static int __maybe_unused mtip_pci_resume(struct device *dev)
+static int mtip_pci_resume(struct device *dev)
 {
 	int rv = 0;
 	struct driver_data *dd = dev_get_drvdata(dev);
@@ -4002,7 +4002,7 @@ static const struct pci_device_id mtip_pci_tbl[] = {
 	{ 0 }
 };
 
-static SIMPLE_DEV_PM_OPS(mtip_pci_pm_ops, mtip_pci_suspend, mtip_pci_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(mtip_pci_pm_ops, mtip_pci_suspend, mtip_pci_resume);
 
 /* Structure that describes the PCI driver functions. */
 static struct pci_driver mtip_pci_driver = {
@@ -4010,7 +4010,7 @@ static struct pci_driver mtip_pci_driver = {
 	.id_table		= mtip_pci_tbl,
 	.probe			= mtip_pci_probe,
 	.remove			= mtip_pci_remove,
-	.driver.pm		= &mtip_pci_pm_ops,
+	.driver.pm		= pm_sleep_ptr(&mtip_pci_pm_ops),
 	.shutdown		= mtip_pci_shutdown,
 };
 
-- 
2.53.0

