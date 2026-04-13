Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4753431F9AF
	for <linux-block@vger.kernel.org>; Mon, 13 Apr 2026 15:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776094293; cv=none; b=GvMKGQDzDyh5Lf5L6wEXWQx1dMQnBsSDcVtZl/zRpz1NnPlbapWmB+vRNouqts9WuyRbTZ6ZnS9gZuF202KzVvYav4Q8PhAPmyZANWy0WcEnoTTwUQiAhmATgpBy9OBh0OB4KJWjjfg9Y2Fa1l2kibPPK9C2cARo7l9/42m0c0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776094293; c=relaxed/simple;
	bh=2Gq73zrEvKFb2Ww2j/DZ6lomDXLUZXge8zXGm46n/mI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KbdwmsvrTtNrUDXB4Itj6hd62S+nuV44+WNIHA0plcVWI52phkqekQEuQPboCPpXjy8b95IZ36A43qs/ny4AJcmNcBF9dYB/aESLCSP3OPQmQKkcB6Q2vV3uPMT8RUe3q1Hq6KLAIdWbhaAkMZ3S/9iZQbYRcdsMHazRiuW8xS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gdph6dUd; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gdph6dUd"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-35d90833cacso2789520a91.2
        for <linux-block@vger.kernel.org>; Mon, 13 Apr 2026 08:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776094290; x=1776699090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lQTuLDD9uHjmSb0q/D/D00Qi76jFLaRH/PnSP6cbt5M=;
        b=gdph6dUdEAL1p4rNZ7YDctR/A715NWuISjnAOz1P8njlFYoITOieCP7pHFxt/7q40y
         9FM7n2N35VJ7eQQoSMRdopag6+Di16Oc4wQWSofmMgz5vJFI4GXa7PXhvpn8zVY0poWo
         3oMtiFxHnJ4LTOLwFtnBibTvFig8138t4iQ4MTrjkjvFIADT6/ybFQH722gwHjIuOGeB
         /6dhkuXyV+pOvUVNzFBWVP17jdve0svjoSrD2eppry8T9+BXHimS+dQRA/JwnChNw5NZ
         wE7Q55h5naISVu9Hhp9O0TwcLn2P7bA1uLp6jJ1em9oSy3Kuuaq4uxsQmMgjQjX/38dD
         7vcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776094290; x=1776699090;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lQTuLDD9uHjmSb0q/D/D00Qi76jFLaRH/PnSP6cbt5M=;
        b=jwkbs5dD8WDY9qz23d3/pSlH3ZxdvwoYH1P+hTBrlp0vwE8546M1Ofl4BS8cOyeaT0
         y5ixcY3kzCp+pOYE47lP5hE2QAXRIvrUR6bES77IiF5SxLiPYBXadSuiWmXQ8rDI3Igt
         NfCyTXYe//gqFKuQhDxG1o2S8QsZXXeRfVxgdonT650LPr1TF5RlCzqLJBiONBMmHdDL
         d7KnhPqzTH0Tgrhf02F3cjETZBEZ59XwV4WqPjnUfq6//nFBsH2ahFIaMqyFCEJuf5Sk
         mC5fdNa2Mwz8T/x1X94PXLtRC0qOJB2WCo0ShF0XdKlaLe+Ny391pnoWkt7NxnT+KNoB
         BRtg==
X-Forwarded-Encrypted: i=1; AFNElJ9X0VBEDrS58CcndJQBQ5WQxTX2chArM4oxlT39ZpsdLhX2EryK2JKmieSxKOEuuVYDEonWYjK7qmeNow==@vger.kernel.org
X-Gm-Message-State: AOJu0YyYJYkmwuLU5danknh68eTtQWS+IzmCoJVJAIDIA2jopecIusR9
	Aq5fqBBR1kYNRHMleLNPBylyQiotxDGfgCHWdN2VK1K8B7rJeln3uDmk
X-Gm-Gg: AeBDievBemwiTANGpP7/8LlezNfze372QiO9eyT7npjDAJAIZGTwofg/a0MCHZF4jNt
	c8VyBNs+SLU/GM7zJciPbhHz4JOS95QbaRM1bDNcchmGB0AlVMCpzSRLx1svdL1x3s01gCZug3q
	oWubxq9bUTpy2Tfh22yLfVyUJTpBg/vlAwQCytyuDCz3lSqSI7oscO6bpMQPno4dk3lKwoTzqBa
	lCaJZ1ULg/v/EdLFVWsRfoBqX6MDocFswbxtMX4XsQd+b1OojJH0Tapz9qgUoi4BxkrLMJ0EH4Q
	9pa6gsnSy4r2pj+vBxQTsgdRSzwg2OwfItb5SsOd1g8feH7mMNZZXTwjZP1ooCDbkZjSoj6oTx2
	yCSa0VGjR2cVC1Zp3kFm0sluEXPIo5mGaCbwwCbIc66dq8Pm+05qhtKaGTnYCG4kfcy5n4vrRIy
	WY40Ay+QdKNIvobeGTOmsmqYAJs2xuvPuP
X-Received: by 2002:a17:90b:33ca:b0:35f:b4c7:b626 with SMTP id 98e67ed59e1d1-35fb4c7bb12mr4856393a91.18.1776094289095;
        Mon, 13 Apr 2026 08:31:29 -0700 (PDT)
Received: from lgs.. ([2409:893d:1188:142d:edd0:8593:d07a:ab64])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35e411ff4e1sm12981328a91.3.2026.04.13.08.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 08:31:28 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Denis Efremov <efremov@linux.com>,
	Jens Axboe <axboe@kernel.dk>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] floppy: fix reference leak on platform_device_register() failure
Date: Mon, 13 Apr 2026 23:31:14 +0800
Message-ID: <20260413153114.3040093-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When platform_device_register() fails in do_floppy_init(), the embedded
struct device in floppy_device[drive] has already been initialized by
device_initialize(), but the failure path jumps to out_remove_drives
without dropping the device reference for the current drive.

Previously registered floppy devices are cleaned up in out_remove_drives,
but the device for the drive that fails registration is not, leading to
a reference leak.

The issue was identified by a static analysis tool I developed and
confirmed by manual review. Fix this by calling put_device() for the
current floppy device before jumping to the common cleanup path.

Fixes: 94fd0db7bfb4a ("[PATCH] Floppy: Add cmos attribute to floppy driver")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/block/floppy.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index c28786e0fe1c..d9afe495d5c2 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -4724,8 +4724,10 @@ static int __init do_floppy_init(void)
 		floppy_device[drive].dev.groups = floppy_dev_groups;
 
 		err = platform_device_register(&floppy_device[drive]);
-		if (err)
+		if (err) {
+			put_device(&floppy_device[drive].dev);
 			goto out_remove_drives;
+		}
 
 		registered[drive] = true;
 
-- 
2.43.0

