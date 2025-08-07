Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64865BE46
	for <linux-block@vger.kernel.org>; Thu,  7 Aug 2025 05:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754544952; cv=none; b=J2IDzhQuqrCE4YNIzvYJX7zIUc6pkytiRkYh9BhLP8av5y3aFMxOo0X7phmCXYjoVqX+pSnGhtRrBAiYnlFPN540pA8hGAmAw0Z63iWvjPV5rgFI4D/pKTwa8GLoxVe/OmtPt4c/qiWNfL/1G83eLwJdXmNiMIQWYvXbwhysRbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754544952; c=relaxed/simple;
	bh=SHbPesG0UHqenGAmo4nydeJuWPG9WKBwQJ78Ppc0048=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AcMC2TCfBcS9kWRLijAhVaDD2SXSm2LvF+kQrqYkgzUmqeUJuQ02Wwookl69bt6RkrCq4zo44el8sH86zOXfCV0qWO0PKvxIeA4jy6QskIjwmO2HC48W8EPqZVZl7hi1FFVaildGGqUBV42HmR0422JJ6B5O3B2srU8Djfr7l3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Xe6/WqHp; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Xe6/WqHp"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-76bc68cc9e4so715757b3a.2
        for <linux-block@vger.kernel.org>; Wed, 06 Aug 2025 22:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1754544951; x=1755149751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QoW10+RcxtJxMxrx5pWJddPJprR6x75GK3Y5SnJ1n5s=;
        b=Xe6/WqHp0xJQgmdizMt3qukHHmbBnWm0NgENXpfUX7mx1NofvQE6Hu5W58DcM0pMgb
         em6JQj72UYrvh62jw2jaiZEeFGId+d28Pm9K2JdLG3qN44hCNGAw2Nh/HZ1qBmNbVnja
         ZBqaoUHaC0NnARLtGPYFNuyy737jRnumbIg+Kow1yafLtkYCsx/gq5/t4qKrLWcIjpNM
         dwV+nZWuiMUes4bVSMy+jFNfmZ/lAEA852kgXoAM2AT/6qqjkMQhxglHa8iltYWkEvzz
         8dQYiMVip3tRvXaAveV0M3aOJdpv1k33hgYVbjSNgWsbNHE0vd+pKQ3DtThdwcCRxmKO
         oT9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754544951; x=1755149751;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QoW10+RcxtJxMxrx5pWJddPJprR6x75GK3Y5SnJ1n5s=;
        b=ugUytIt8K0nH3nae7WnTVXG9JG+Rs0jQzIQI+5sbg+bIUgSWtdq+WjZy50xLdhs5Pi
         hk3WEHg7nyh3P0aILFotXkCxjCDyuVtraMx+RnFP1kEVP+Vz+1ZcXHZ2bgsCsH2LoO31
         c4dy/IdqmtTzR0CX7dWRGUib3HSfMvWgpyG5w68aDKpFxKbGYWSG029eYhLcJCUu5I47
         oi3rP3oinDLU3V755Zlxog5iENp+nSffAQK+seEVG442oYE7EaLSkFPfwWvOzJ6NVu5r
         zi9onOjtoZTT9nvO1SnxikEvT/e7Y1b4g643jU4XxnssgqusgpT0r+DrHn2adk1DX0zl
         5TzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqT/523nqvMgZGWafXnTJbMI7DR5n41BARKjt8LCESAQosKIa9XxGWTfJgLnoifzJHURGzPZ8dckPKNQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxkg3qrpdJ4CLrsREAYj9rc2oiFhAP1ER75Zs9yCwsbUz4iUrd/
	27Fpl9MrBDPAg8OjhZIak1ZHED2CvxJ6zgCwzqfnB0Tl0jdv6gbPoy2uCiJfcljR0Qk=
X-Gm-Gg: ASbGnctNxz2Eqx9h76bbVGbOtVYSSqbUNlj5Kbe18bn6KHWn8zPdJYDu40Ki6wn3dVD
	FE8syrf1yGvsrt6mmB71/97xm7rBjIY6V1Nd1CH1BdwM0QR4r1u1pyzhpEeRzQzuWaHlF4GlFAl
	Uo4ADWQ14pzblaI6XXxVA3knf89PNqpxfQTGbiOU9CIsRiVLEpxBYkZUrrTsA8BP+5m9z53bM16
	lvscGNLTxTdiE/9epzaK/8lzPlgTAgR3jIWORu5BhG1x1ywrVQC5ND2i4Y8UNfrW0m1j+JGlwNM
	BDrTMtd4QmY81AWAfoUBM8J/8f6B5D+BWGGI33j+w36iJJDWG4twAj8nDmqRie/FQXaT1/MLuS4
	7a17BsX/d7XrEkvcOXzcjI1nq9OEpclDQJ4n9tBM=
X-Google-Smtp-Source: AGHT+IGeyHcVUYRXGoHcwS/JcJOXNo7fQU6bAK888L0yq4XpFiifdOi5CrgPuZlMwnAPe9aSf/fYLg==
X-Received: by 2002:a05:6a20:559a:b0:23d:9fd5:9231 with SMTP id adf61e73a8af0-240315b3ba3mr8005141637.46.1754544950644;
        Wed, 06 Aug 2025 22:35:50 -0700 (PDT)
Received: from localhost.localdomain ([2601:640:8202:6fb0::eb28])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-76bf772116asm10978824b3a.97.2025.08.06.22.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 22:35:50 -0700 (PDT)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Yi Zhang <yi.zhang@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Keith Busch <kbusch@kernel.org>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Mohamed Khalfella <mkhalfella@purestorage.com>,
	Hannes Reinecke <hare@kernel.org>,
	Daniel Wagner <dwagner@suse.de>,
	Maurizio Lombardi <mlombard@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Randy Jennings <randyj@purestorage.com>,
	linux-nvme@lists.infradead.org,
	linux-block <linux-block@vger.kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] nvmet: exit debugfs after discovery subsystem exits
Date: Wed,  6 Aug 2025 22:35:07 -0700
Message-ID: <20250807053507.2794335-1-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.49.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 528589947c180 ("nvmet: initialize discovery subsys after debugfs
is initialized") changed nvmet_init() to initialize nvme discovery after
"nvmet" debugfs directory is initialized. The change broke nvmet_exit()
because discovery subsystem now depends on debugfs. Debugfs should be
destroyed after discovery subsystem. Fix nvmet_exit() to do that.

Reported-by: Yi Zhang <yi.zhang@redhat.com>
Closes: https://lore.kernel.org/all/CAHj4cs96AfFQpyDKF_MdfJsnOEo=2V7dQgqjFv+k3t7H-=yGhA@mail.gmail.com/
Fixes: 528589947c180 ("nvmet: initialize discovery subsys after debugfs is initialized")
Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
---
 drivers/nvme/target/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 83f3d2f8ef2d0..0dd7bd99afa32 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1992,8 +1992,8 @@ static int __init nvmet_init(void)
 static void __exit nvmet_exit(void)
 {
 	nvmet_exit_configfs();
-	nvmet_exit_debugfs();
 	nvmet_exit_discovery();
+	nvmet_exit_debugfs();
 	ida_destroy(&cntlid_ida);
 	destroy_workqueue(nvmet_wq);
 	destroy_workqueue(buffered_io_wq);
-- 
2.49.1

