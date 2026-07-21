Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3F246D570
	for <linux-block@vger.kernel.org>; Tue, 21 Jul 2026 16:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784649885; cv=none; b=nKUl67ao+WHcKKSyAZ08zhvYEzXwdlJmhfKT2811j4/KqhoyiNuSBcO6VjdWvcsP8mgDdNzFSS2gpJdvy3d0x9WvQ+ad0TPimCglFNl43096AqcaP773qNhDWNejS3QM13/PHdaYBHkeeF8tLXXK9hOjp+xEN5RF4ftExbSMI3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784649885; c=relaxed/simple;
	bh=nSHvJY5/CXstz0kWFDpSxvpAxFraeURbFuSDTLzmrWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o8sCcuenVnFReaQr7Avv69zu2kIV5DBAWr9Ny4tjWqDnYX90UtdIq+q9EKK0P4LPzeFojd2+Pumxd81noNCc9C8u+hjVBVHKTuD4ux1FkHrqt4kUyvZfBzt72Z4DOWx4IznM+Vz+tGTNILmCaIpp9BffVWw34jZUwesMkI2umFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BcI40R3v; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BcI40R3v"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4956242332dso17932685e9.2
        for <linux-block@vger.kernel.org>; Tue, 21 Jul 2026 09:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784649882; x=1785254682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=toIsjSwtRAMDwQlEQ+XT5qunvDwN2qKwkQYEh96aALo=;
        b=BcI40R3vtoFyfmG1hYLflR/cXHrzbwPOFZ/QYQfVK940a3GU64aZuwbeQX7UR6NLcB
         tija1LhZ/tWpMIjy+QeUjK3ewRCwcYZEO+zuAfLaR4oxInrP1pMyM6PR0XvWpOYi6f8W
         VwG0ob44uLxlJw+w2N57jxL0NZRAy/PI9e3shTTA9njGtvpUgKUY9B14TbUDZQUOQQPq
         4m7q5da8xPzImpeGalpkf25O++N8ge4gDCACHsP62ULm56JvAAY/sRFMhpthOCTXVAZk
         PdXE6Y6j1epXVaHOs+Zp/2QZ/0ZUrXlMj0cVqxWyYv2QEf/SmgNfAbJAzMPXRalEWmg8
         JNsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784649882; x=1785254682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=toIsjSwtRAMDwQlEQ+XT5qunvDwN2qKwkQYEh96aALo=;
        b=qeEncjxuldZ8wd5GnwYd5EuqYH6jSitHAOuvMgO/+6/GgL9zcCbzrku6SptRm3W8XT
         Ldck0UXIWftFqUvGhLHkT2YJhRsN8JUdp0nfa9YLVJIzlPs8yHbXsi/gnvVJejCOgR5L
         u1XQjPnWhAjxeCKFvdaDX3GyPbdP8nHkCS46UhFInJ6n950HzaAJO/0QrqeJ6bexuByE
         +ys7WMettBxMnZkfLNn5bcIgm4YZ+iWo070WSjWF1RYEn1wTqQkc37STbeWYRjDdk5Ha
         NlmmodGNv+3v0jaoMR13hgJhHd0RmtEf6IE7PB2I1cINCoMhEYRfT6HMVlee4uIvr5zk
         6gRA==
X-Gm-Message-State: AOJu0YzBNuN/KC4eQzEPyW3P09jSsSS4LqEWNLtCFe4XFqZJ7RWJduTP
	TSPoxN3pDI1u6/xlxyGxbPoxHpcEG4AxRAUteUOh+rWAU4vSF2n3w11EV5hSFw==
X-Gm-Gg: AfdE7cmKEoKoBeJAaXYZ6TUUkPuhlkbln0rNQlDQgCggHuC0tzb4Pq6+D2lTp1XVV/v
	KzPajOs4xkTMt4BzmsoRvWH/aoY4uIh4WWu0KoQGrfb83bEi85N0xnEpnSVY8oSbHST7K+aqHfH
	Fs5G1w+DgCGkensybPRjnVn26nhjrNUYOZvLTMgHkgSXsOu3+4X/vbvuJ4jnlGdlb+R6LyhfFTO
	iAsmQpZXJvSZA2HEKL8/KBlSGlAwg8jeMO9LPwm8Kc6QZugD9SWr30C9Fk86Ep38aPMhe6NgXZN
	ObOA1E+cERiny3HQ0p5znHIv8pVsZ5T+V+cN4ezzQLHFnIMIdqHRNsMkJWcNxmX9VuDDshaD6Nn
	nKu3CsGVIWHdJZs4xu5EIcZMmieDEbNx1gu9BATWgmjWAXgZRlSCEV+evb8WWPHmU/Vk0do+ZE/
	etcjwBMualY9Nk6rtJJZDQ8BAq1FTaJp1jhFu9lZjnOQ6lffU=
X-Received: by 2002:a05:600c:3512:b0:495:4572:21af with SMTP id 5b1f17b1804b1-4954a3ef7dbmr207403615e9.9.1784649882250;
        Tue, 21 Jul 2026 09:04:42 -0700 (PDT)
Received: from localhost.suse.org ([37.109.161.57])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4956a4f24bcsm5591425e9.1.2026.07.21.09.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 09:04:41 -0700 (PDT)
From: Sebastian Chlad <sebastianchlad@gmail.com>
X-Google-Original-From: Sebastian Chlad <sebastian.chlad@suse.com>
To: linux-block@vger.kernel.org
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Sebastian Chlad <sebastian.chlad@suse.com>
Subject: [PATCH blktests 2/2] loop/006: settle udev before completing the test
Date: Tue, 21 Jul 2026 18:04:32 +0200
Message-ID: <20260721160432.27409-2-sebastian.chlad@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260721160432.27409-1-sebastian.chlad@suse.com>
References: <20260721160432.27409-1-sebastian.chlad@suse.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ensures udev has processed the burst of attach/detach/LOOP_CHANGE_FD
activity generated by this test before control is handed back, so it
does not leave a backlog for the next test to contend with.

Signed-off-by: Sebastian Chlad <sebastian.chlad@suse.com>
---
 tests/loop/006 | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tests/loop/006 b/tests/loop/006
index 549c112..701d44c 100755
--- a/tests/loop/006
+++ b/tests/loop/006
@@ -69,5 +69,10 @@ test() {
 	fi
 	losetup -d "$loop_dev"
 
+	# Let udev catch up on the attach/detach/change-fd before
+	# handing control back, so it doesn't leave a backlog for
+	# whatever test runs next.
+	udevadm settle
+
 	echo "Test complete"
 }
-- 
2.51.0

