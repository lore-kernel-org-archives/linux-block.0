Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE4919AD78
	for <linux-block@vger.kernel.org>; Fri, 23 Aug 2024 20:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724443740; cv=none; b=ijnoD4g2P5N3Xcp8PwZo0dkRLnOyRVigKh+lmtMfTAfk9W0bd+sj7fVeSacIt6bbmgEh/DQ2U87aNCZdBgHNGNddX9BzeJR8g9PtDPjnVOkivGzccpBZsrWrq4ZbkjQFAgOIoW0uN6Fd1DxNx36efRwKDkl+06lGpkwpg2dv3o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724443740; c=relaxed/simple;
	bh=pIR3vM/y29oNJ445O02kZeRZAQ3oVk6XvfNJdo5dza8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OhPxWY7ar0dP27x3+TR7cXPBynvTnWE+MAaoJYU9bDMainINzLB32eQkSNVONSi+U3/THtzyAi0VKi2F2p8yb7lkPdLSoJbHvlHWxVedII1mhUqEdl9P16xlpcVtKnGe9TNelJHjK407zBBuV7lVYNKank3yhZYn/kMKRXKyrVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WqLk5cIy; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WqLk5cIy"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a83562f9be9so261008966b.0
        for <linux-block@vger.kernel.org>; Fri, 23 Aug 2024 13:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724443736; x=1725048536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qSE07mevysGs4hIlAiWiKLrTdVKJ6Yd2deEW2FZkz/M=;
        b=WqLk5cIyJM75U3MvT26Wa0AhE//dJij3PFrUv0EWuxuyQAw97fH7MkwnL8OBqvpLSf
         G9PTj93RcEae2hfLkh9B8msaXUB97LdRVsyt2BR/ZUzFWiBTHKm9mIdrai3rtMxxDs6j
         JEL0Nob/3WcQ8q5RURlqSGhLq/UE1OeNkMtHBHGQHS3Nhh8veE0yaA7nB8PBbmuohNou
         XC2vrgYIFMrdzPS6rBOg0iM7EJNV8dEk9jYwsgi7SwhQ1fje0iNEf2l5OllMiLoKa1Xy
         z7MlAqLkaEkfhYUVt8gMebBeInmI+KTZsOoD+/NdWvHCLfQPJefCR1CAInwGChOdH360
         CYig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724443736; x=1725048536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qSE07mevysGs4hIlAiWiKLrTdVKJ6Yd2deEW2FZkz/M=;
        b=F/rBaJf/Uyl0AR5Asb6D0lNk8bw0dMW4dYafb1oicHCHIugztsfjsOHCHQsJeaJK/s
         gcNF/HfPZBkqvYJKKszAay86AhhyXmJ7bM7o255fpVcrE4wOvtJ7apsWkf50mzhX9SrA
         hYkmd3XF7wZIF7q4Feg81jBz5UsNVO7KYqcdSreeqMPdqdeGOqr4xBDcMGzCr8guq+IU
         GjxrEy81/7yN0OcdsjX7F5cs0tpo4jdcwT9v7DQklcnOYnSS+0Robhe9M79lpZsNYjHX
         SglzT9Y93oK37stCRf2cjFoSnL7Cz3rb7rLhZrMCmA4IM4+Dcld8eq0pvJVbc19NcJjp
         DO0g==
X-Forwarded-Encrypted: i=1; AJvYcCWMDUoj9B/WkV6DuoZ3qkj4LRcQzRi9fuF+CAoRUorJfxvY/KLE/pySijxWQxpslCpXtifAlfEsSykang==@vger.kernel.org
X-Gm-Message-State: AOJu0YwplluZqZexjHUAcBMbM6WbQv2OCchJLtwBOK9qRGKfFsXpbAch
	f+EVTnlqWfqpiVcVkUM3fvERfT9dy51Ez0Hn6INn6MyLaAYRP4MP+EF4c1IjQSA=
X-Google-Smtp-Source: AGHT+IGADpIP4DvJCkCm1/Xu7gk2/E9mDpWF9e4TUjiERBdiNyPX75m2yIkqc4OIg2WNUrh5OfKQew==
X-Received: by 2002:a17:907:e92:b0:a86:8917:fcd6 with SMTP id a640c23a62f3a-a86a54cf719mr207090766b.60.1724443735545;
        Fri, 23 Aug 2024 13:08:55 -0700 (PDT)
Received: from localhost (p200300de37360a00d7e56139e90929dd.dip0.t-ipconnect.de. [2003:de:3736:a00:d7e5:6139:e909:29dd])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-a868f43367fsm304014866b.115.2024.08.23.13.08.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Aug 2024 13:08:55 -0700 (PDT)
From: Martin Wilck <martin.wilck@suse.com>
X-Google-Original-From: Martin Wilck <mwilck@suse.com>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Daniel Wagner <dwagner@suse.de>
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	Hannes Reinecke <hare@suse.de>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Martin Wilck <mwilck@suse.com>
Subject: [PATCH v2 2/3] blktests: nvme/032: skip on non-PCI devices
Date: Fri, 23 Aug 2024 22:08:20 +0200
Message-ID: <20240823200822.129867-2-mwilck@suse.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240823200822.129867-1-mwilck@suse.com>
References: <20240823200822.129867-1-mwilck@suse.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nvme/032 is a PCI-specific test.

Signed-off-by: Martin Wilck <mwilck@suse.com>
---
 tests/nvme/032 | 2 +-
 tests/nvme/rc  | 8 ++++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/tests/nvme/032 b/tests/nvme/032
index 5353e96..512d7ea 100755
--- a/tests/nvme/032
+++ b/tests/nvme/032
@@ -24,7 +24,7 @@ requires() {
 }
 
 device_requires() {
-	_require_test_dev_is_nvme
+	_require_test_dev_is_nvme_pci
 }
 
 test_device() {
diff --git a/tests/nvme/rc b/tests/nvme/rc
index 5c554b6..b702a57 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -130,6 +130,14 @@ _require_test_dev_is_nvme() {
 	return 0
 }
 
+_require_test_dev_is_nvme_pci() {
+	if [[ ! "$(readlink -f "$TEST_DEV_SYSFS/device")" =~ devices/pci ]]; then
+		SKIP_REASONS+=("$TEST_DEV is not a PCI NVMe device")
+		return 1
+	fi
+	return 0
+}
+
 _require_test_dev_is_not_nvme_multipath() {
 	if [[ "$(readlink -f "$TEST_DEV_SYSFS/device")" =~ /nvme-subsystem/ ]]; then
 		SKIP_REASONS+=("$TEST_DEV is a NVMe multipath device")
-- 
2.46.0

