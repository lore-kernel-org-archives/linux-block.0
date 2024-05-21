Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7963D147C6F
	for <linux-block@vger.kernel.org>; Tue, 21 May 2024 17:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716312298; cv=none; b=FB2/slQjuIxXNKKlXg1TJGyxzOTgqUcbVAy2o4tULkEk9/D7lq0+C3WGKDip0ElmQh6usIu0q359CNqbmeGSeQQH2ZO3OeVuIgvDF2UZvWVrtYzd9xwHFeycvOmNAHoXZ2CtyX4N0iS5elDfU06kADBW6lEPZVRHzcEZtkJAJvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716312298; c=relaxed/simple;
	bh=Mp+/q8c8hbWGXuMucrngX6nTiddO1CJiBpKpwPZWuwg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=bNqDW7kIwt16gKTL4Z3rdn0aNGUzp5zDNqNOXPIQ0BdPWDltq/ehif1zYHeT/tZRpKQ0vGNeb/feknu9qw8wp5AC08SenSMAHgquiIjzdjSJWEmkrV7/tAUvKUbG0EbazssgHZtGnQ+8952QKK58GfrfEqGHLLNTqTUjqLdB7+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=NcullA16; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="NcullA16"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-43dff9da88fso2616161cf.2
        for <linux-block@vger.kernel.org>; Tue, 21 May 2024 10:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1716312295; x=1716917095; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=jKtX9LPaY3WIQ6A6JgI1AIzpeIoX8dCfePecQCx15F8=;
        b=NcullA16ZP+Yo/9ryt32LqVeS5wXGMveSmCTutsf+70iln+6f17lEXujeIMdxT5xBC
         63T4WuW2xOldIrIFLsL+KxGF3HNsBax+5LBhKS3u/dB6fHmB11ang0pTMPrAe6G7Ht0C
         I7SMRZfbabuhzASsPY0aG58zzS2JgURWiZR4rPMb93j1faTWd4ntQyMkPlRELQmyPjJA
         4UTjn3Ha2blV91Q9scwuFNv9mUCIg1DhXRKBk5kVjRr91lFQoiPgjyszKVMqgFXantKW
         4fQj7z3nUEyUG/VeaXiVxictFWX5aXEbtxcuflvmc2+s/79PKueyUulyAmwjUdwZE+wh
         W+Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716312295; x=1716917095;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jKtX9LPaY3WIQ6A6JgI1AIzpeIoX8dCfePecQCx15F8=;
        b=XwEVTC/I1TeEt0SxuqAoMsgn1I2tVWniWshYHF/7gEJyzDxV/d4DYb3g855l4/a/6+
         2lkxn+aGOxT/W5jt72WN9Kt0hu52Eh8ex1dYSFa+nzSrBA5UHagyrzk0OLANYqK3IOO9
         UE43x9ou1EYw+GsQZq5jWATPq9O3g8OebxWlezAafv1b6dbHgLatnHPnaDmh8+V9kwl4
         dW+Ikan6UGo9qs/JZJAz7Wob2GWJrBH5JdmNGOfR+48djgSbLrmKFwtzvoss6KLR7Cs3
         uUHRY8b2KLsNEUwE337WV9U4zSxi0SdRHBvsTksa5RoKfqzAUAowYA+RFX5CPTI25KQM
         4ftA==
X-Gm-Message-State: AOJu0YxzQVG7qd323boOPhootjspnI0dZ0DnEp+Ua047wyRMyBGraoul
	RgFRd/hbo2ljP6kxrmzk1/9DV8yMYHq2IBdICYFoyLLD1zYW+dCvjIuPksbn5aarT6MiGssICSs
	p
X-Google-Smtp-Source: AGHT+IGWl2vapGiONzSCaRj7mqbxH6VL3zm/uAX3RmIyFBLCHJnuVaml1qzLObfJPPG6vGlIE7RVig==
X-Received: by 2002:a05:622a:105:b0:43a:d3e6:3ecb with SMTP id d75a77b69052e-43dfdb2f1dcmr365805121cf.26.1716312294984;
        Tue, 21 May 2024 10:24:54 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43e0bf64844sm134213251cf.62.2024.05.21.10.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 10:24:54 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-block@vger.kernel.org,
	shinichiro.kawasaki@wdc.com
Subject: [PATCH] blktests: fix how we handle waiting for nbd to connect
Date: Tue, 21 May 2024 13:24:39 -0400
Message-ID: <9377610cbdc3568c172cd7c5d2e9d36da8dd2cf4.1716312272.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Because NBD has the old style configure the device directly config we
sometimes have spurious failures where the device wasn't quite ready
before the rest of the test continued.

nbd/002 had been using _wait_for_nbd_connect, however this helper waits
for the recv task to show up, which actually happens slightly before the
size is set and we're actually ready to be read from.  This means we
would sometimes fail nbd/002 because the device wasn't quite right.

Additionally nbd/001 has a similar issue where we weren't waiting for
the device to be ready before going ahead with the test, which would
cause spurious failures.

Fix this by adjusting _wait_for_nbd_connect to only exit once the size
for the device is being reported properly, meaning that it's ready to be
read from.

Then add this call to nbd/001 to eliminate the random failures we would
see with this test.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 tests/nbd/001 | 1 +
 tests/nbd/rc  | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/tests/nbd/001 b/tests/nbd/001
index 5fd0d43..0975af0 100755
--- a/tests/nbd/001
+++ b/tests/nbd/001
@@ -18,6 +18,7 @@ test() {
 	echo "Running ${TEST_NAME}"
 	_start_nbd_server
 	nbd-client -L -N export localhost /dev/nbd0 >> "$FULL" 2>&1
+	_wait_for_nbd_connect
 	udevadm settle
 
 	parted -s /dev/nbd0 print 2>> "$FULL" | grep 'Disk /dev/nbd0'
diff --git a/tests/nbd/rc b/tests/nbd/rc
index 9c1c15b..e96dc61 100644
--- a/tests/nbd/rc
+++ b/tests/nbd/rc
@@ -43,7 +43,8 @@ _have_nbd_netlink() {
 
 _wait_for_nbd_connect() {
 	for ((i = 0; i < 3; i++)); do
-		if [[ -e /sys/kernel/debug/nbd/nbd0/tasks ]]; then
+		sz=$(lsblk --raw --noheadings -o SIZE /dev/nbd0)
+		if [ "$sz" != "0B"  ]; then
 			return 0
 		fi
 		sleep 1
-- 
2.43.0

