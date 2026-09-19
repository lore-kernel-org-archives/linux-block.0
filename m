Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B253909BC
	for <linux-block@vger.kernel.org>; Sat, 19 Sep 2026 19:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789845651; cv=none; b=I5mHAlJnLt0OrIsOob3nsf8QYBd90HzwkxGNWCCUr3oXXTh4hnL0M0ahycLI2R2Opu4/eLsDU74rPQAD6JOs0kAO6uZFXX/v2l/K+EJco5qaovdKKyTm2RdLsVXh4jkMrlMWE1ygIdnRw0NOCpowPDNcL2+rUVChFmu89DdiKCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789845651; c=relaxed/simple;
	bh=pwyYfRVLdkmd5N5Logo84oAtYOsGm4GJuMOw/mAwfH4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T80wdJWeEAM9h07qEDASABLLFyzK5h5xwvK8NzA1G5KODcfQcousaOG1jbO3DBSOEyGlx1qnL4zkvmoq/G5BtGk3+h99AN+FhnXb0LBJWw4hjv/K9cI9ctn6eSZQUo5QYiEqwx4MfpmLsAtPO01mLHPKanOpWrSGcvyDFPjOQ5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sSJhMCre; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sSJhMCre"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e7bcb94d3so12430995e9.2
        for <linux-block@vger.kernel.org>; Sat, 19 Sep 2026 12:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789845646; x=1790450446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=T4YJdmYOeUNhSU17w57J3KEAsEIgs0iLdMFga4KPQms=;
        b=sSJhMCreai4TWaTuNvlwtI4kq6TQGgNN0jvcBac9QjtUUrmZbyoEdbxRFDjtD29bhK
         2+OYeDcXNUnQOaut0XBnQEjDo/3RVlcgyJWVxl6NFKBWiDINsmZlcr0mWIP0O/XwRTJp
         POorS2w/nRn0cTRSfB5nSolgYHWRElGYT9N3wGmtbgYiqbNU/rZhEPyYGMnnv0jMaROY
         g9UVkYJC3l0Amk+UsJRCPgACzSxsxVkkavxOhoO5JWLqCsL3HuQLbUYamWUSvsv21t1C
         Y74JtZ+nChBtKXpnmA7+ajTLU/JKPaLlv7VezAPrhnj6UfU6HgxxEasR8CiAfAGX6GEq
         Wlqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789845646; x=1790450446;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T4YJdmYOeUNhSU17w57J3KEAsEIgs0iLdMFga4KPQms=;
        b=uIs2eQ0AY/2q1E96NGrt9f6E6o7sJhACHFIa8NOVu7WqcnlMY7ssDuwMe0eMGBrrUN
         CadH40JZuHdYPAxdppZff8nIN9zVJITs5sK9YC2a9SmRz0bm8pK1Q6/llah1p8ZokUfP
         Umh0LuRi47XUIGM1U9eOHX7A6P1hJcm0nwUm7cJDl0i6rh4NxY8kq0re/MYxj3NCwP1d
         CeIBllJkovkMC+i7HJkLt4XaAI0guXBOSi4ZmlgICfdoSPIwVaRQFqisz/EVrNAzA4+f
         uZYMS11jMi/cIHjVo2wdZWJUecIPokdS+GUcibDKszS63IW4wwvbgiuWPTByfcu2Ipqj
         0PRg==
X-Forwarded-Encrypted: i=1; AKwUvBzNVYeBLN4vCGDGSQ2I134bnr78QhpBsqbhtZnLWHeh1UVrQpRx3aGMZEsTWcfeKwyGdyGWOD8tIRgHsw==@vger.kernel.org
X-Gm-Message-State: AFuF++mCTwIYLU7qKYRT1AYUBlpmxUAN07yi8tVhIuDZfdzL/42P3zwC
	1YRCmEMYqrPLVsSHb4dmO6zyyJwqUwiaEo9bvlNKF9+gAqrkHzJljIYD
X-Gm-Gg: AYBFou1RKXenq84AKLEXI1YVYq6o8hxDb4jHXdlyaJGDFulgJH1LLFW0N2MERj5pKM4
	xoeu7SCnCxhU7036tMFp0ymqQIaulm0PXCICTSxCyPxnpcVnMP4QFDslmRnOCf0RBCI/k95Lss1
	sSOdUh31Stb8vCQUUFWEDK3GerT4N4fAg8iGhU8ggY3BpEgOqSNCGaYAlkF7o8/exjZGYZLaXWU
	hDxqdBh7NSaF6kay/JD2L6mHblSCe7M1MNg6dEBlQlsuYWyhb5Jmp6Zc1tllWUy+sRJ12Kj7y5n
	JdbLNCVRSjtvfsPT4YTAp7iRi5Kx6+00O3kMPLjczMQpiGK7i0nT28OOuYp9G02SaZ2KPiWeJ0j
	Kwnfxzx4kAP8QjTr8RHc0hY4aU/JeMHdhVPOSTlbFk8/ffriTGjis8uhgFL0HnUWctc+iXcgtYT
	zf0k2NeuWjEz+yPJuVGfhF0mpwHZ8V/Z3I+8UfhVSd+JNEFylttEMWseGy4V8jJYHzercRZpgQq
	D5zTDVFvpdVaQDBSmgkNvIY/MbLHONPQXVwKmOsuzya3CeAgeE=
X-Received: by 2002:a05:600c:3ba1:b0:49e:745d:c317 with SMTP id 5b1f17b1804b1-49fc56b5754mr106076785e9.12.1789845645497;
        Sat, 19 Sep 2026 12:20:45 -0700 (PDT)
Received: from fedora ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fc5755c40sm163812045e9.3.2026.09.19.12.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 12:20:45 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: axboe@kernel.dk
Cc: hare@suse.de,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH] block: z2ram: fix dangling gendisk pointer on add_disk() failure
Date: Sun, 20 Sep 2026 00:20:33 +0500
Message-ID: <20260919192033.271538-1-meatuni001@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

z2ram_register_disk() stores the freshly allocated gendisk in
z2ram_gendisk[minor] before calling add_disk(). If add_disk() fails,
it drops the reference with put_disk() but leaves the array entry
pointing at the now-freed gendisk instead of clearing it.

z2_init() only aborts and unwinds when minor 0 fails; a later minor
failing just leaves that dangling entry in place and the module still
reports successful load. z2_exit() then unconditionally calls
del_gendisk()/put_disk() on every entry in z2ram_gendisk[], so module
removal walks into the stale pointer left behind by the earlier
failure.

Clear the array entry when add_disk() fails, and skip NULL entries in
z2_exit(), matching how a minor that never registered is represented.

Fixes: 76487f024142 ("z2ram: use separate gendisk for the different modes")
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
 drivers/block/z2ram.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/block/z2ram.c b/drivers/block/z2ram.c
index b216cba1c3bf..e7fabaa53ba1 100644
--- a/drivers/block/z2ram.c
+++ b/drivers/block/z2ram.c
@@ -333,8 +333,10 @@ static int z2ram_register_disk(int minor)
 
 	z2ram_gendisk[minor] = disk;
 	err = add_disk(disk);
-	if (err)
+	if (err) {
+		z2ram_gendisk[minor] = NULL;
 		put_disk(disk);
+	}
 	return err;
 }
 
@@ -379,6 +381,8 @@ static void __exit z2_exit(void)
 	unregister_blkdev(Z2RAM_MAJOR, DEVICE_NAME);
 
 	for (i = 0; i < Z2MINOR_COUNT; i++) {
+		if (!z2ram_gendisk[i])
+			continue;
 		del_gendisk(z2ram_gendisk[i]);
 		put_disk(z2ram_gendisk[i]);
 	}
-- 
2.55.0

