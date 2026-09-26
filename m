Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B35435C684
	for <linux-block@vger.kernel.org>; Sat, 26 Sep 2026 17:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790444003; cv=none; b=gwgAXYvodxPqjCosVLLgu/RZ3uAPmTINhSFsrXXOYqNr0W+8pRn+dPyhMGwjTCxp4uiViGqAsYK0sF6ypNiPsGzVGKxjiMpAqJXboJvFWwyZfi6Ak5hzyEItQVRiahHtUzcTuxV9fSO6B2F/wbjDoHVQtunsGknqHfMJs4qdQOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790444003; c=relaxed/simple;
	bh=5VNrVx4ZKAIvebGxfLNqPgw9xDv0RVGMqeAFRyrl6Dc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hgpm1DODjFcUEmMDVHDLBSiApV821D8F5cVkkEF14xAorIZmZEYmsCKE+a4mrZIAtWADCSwf+Su34RoGCSvFjWlH7Qex9mVyTuujDk3HavIbQU1R+ZdN7Oqd4/tVtOxx6uOYNhpqg4zPKe4F0S/Co1FjDNEfKvecc+CBE6gM0+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jhsy/Qgw; arc=none smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jhsy/Qgw"
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-48882c1f261so534987f8f.0
        for <linux-block@vger.kernel.org>; Sat, 26 Sep 2026 10:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790444000; x=1791048800; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=92J4cdfV5TssQddcjnr52AW40i0MRdcSuU09rnmRkE4=;
        b=Jhsy/QgwQGQH/87yAKPPf1Dh8FY0VJsXzAvksSD+xuAxf50+UP2OMafPnaZdLnCbLS
         Jv7F/GA007tL54mAf9D7S3SJVISyQ6JlysA4NSC6BD0Kni9qEQTggiwlRK9gdB9RWu5D
         0P1FDDQcvwxMkUBOCijg7K1n96E9ZCJ24FM4i85FIt0Yec11SBSt5mE/kcn072m0mmhr
         JbeNXl4GaT2yEf7Ft0OqqX6f/6VVGhR8rQz8iTFxkBQgUae4WH2tzM+UgTnYt3iYroRS
         Dspapxuh3UEVDZdakBCyrjlGLK/QTD5YJ8xQR90vOlYvyHh7sUrfjsNFDEmGIAxQrss9
         3OZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790444000; x=1791048800;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=92J4cdfV5TssQddcjnr52AW40i0MRdcSuU09rnmRkE4=;
        b=R5IqNy4AVePEt05HpjcRhQkvnI1+BDUpeMN5NcocWzLNUcGi/lYIT+1bbouIJj0EqG
         OEF8VV3vsaxSFwoESQL0qHFCexRja/f5X8qTWe2HNsZZ18qcYrBXUHTvgvu7gXrAoKgh
         1PAIgRoq1N4rOgJeryBhXa+i62b4om/L5NZJUWdf29ie5hpfgguF8y+t6OjEAlFkCKt+
         vTlxpHoNOkfmPnSGADnBBgPWfRQIWgNi8kksz3r9W7yPfJTG9l94+mZuEAlbsGuf1hUu
         nfJuMBrL3F6u6HBqpwSwamQDRYKR+t4libMTsDCYfq4x77fSaXDDEIbtm7iTekJV1H8w
         3b6w==
X-Forwarded-Encrypted: i=1; AKwUvBy8AIreNPPlb2oLnAzaPVLrcp3rP2tjyx5tPxn6WMdOmTx5O6PMv1+OnsLSsRczDtS7moqyxDiJtiOJEw==@vger.kernel.org
X-Gm-Message-State: AFuF++lpf66z+Yk/L8rTHkwWu3Azmd0y8kK2sUO3BRa9OYHKROQG5Reb
	A5+sQv4Nyy4JE6zsJTShnS5LNDQBXO07Ym6TA/iucKxC007UgHwz8hN5
X-Gm-Gg: AYBFou3EsytHqoGxGfFWfdPCYNZUih12xlaL7BNA5Y3S+6JHthe8ghf0Y46ih88nW8G
	sbtacYZmsxVcES9jimNef3aYr8TwEHOz05eossTHoi7bIedRC8tEiLgWTLn7yrgikSCI0mkhpUD
	EN7D17oGZ3Xr/zbJyaUsjpStffiAyrlag+PsXhB6tQmbCmU/bs72ryy7YyAc1iYH1WXfMFbEvfd
	F0mZy2n2mwuoWtoL3ddwRdElLgY8s+EbTbllqylL6+xWWv7aETOg5XJy/ZuKxHd8ko9CstghsbC
	bZxZkvdzlDQzj8IMVvOzQNzaB67AZRNnHzTGrlylV67pTCqaX3+tnYYdZOjGNU4iWDSUziFX3Ix
	nbG1a9qgAZFiLxPPUn4ygfiz19b5brNg7f0BRjdlx/mIFl5tGXpRvy9CRCQ4+bP0Yyt647qFCFv
	UbTjqilfQbBxOhGeXzpHe7Y6Gzd8HsANPYYPxXIMM8tdTfbDPHDn7FCY7u5isTRxGZxXyCKOXyp
	q+cGsIrWKg7gPzo5FkpCNj9fLE89tWRdTWy4kX2MdzDmGce4Rm51IB8l3/QamU+IDo=
X-Received: by 2002:a05:600c:3148:b0:49f:fc4f:9efb with SMTP id 5b1f17b1804b1-49ffc4fa10bmr34693285e9.7.1790443999742;
        Sat, 26 Sep 2026 10:33:19 -0700 (PDT)
Received: from moosama76.. ([102.44.245.127])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe5de4de4sm246200495e9.8.2026.09.26.10.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 10:33:19 -0700 (PDT)
From: Mohamed Osama <mohamed.osama189110@gmail.com>
To: ojeda@kernel.org
Cc: boqun@kernel.org,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	dakr@kernel.org,
	daniel.almeida@collabora.com,
	tamird@kernel.org,
	acourbot@nvidia.com,
	work@onurozkan.dev,
	longman@redhat.com,
	lyude@redhat.com,
	linux-block@vger.kernel.org,
	linux-serial@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/5] rust: add DropGuard KUnit test configuration
Date: Sat, 26 Sep 2026 20:33:11 +0300
Message-ID: <20260926173315.56772-2-mohamed.osama189110@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260926173315.56772-1-mohamed.osama189110@gmail.com>
References: <20260926173315.56772-1-mohamed.osama189110@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a KUnit configuration option for testing the Rust DropGuard API.

The option follows the existing Rust KUnit test configuration pattern and
defaults to KUNIT_ALL_TESTS.

Signed-off-by: Mohamed Osama <mohamed.osama189110@gmail.com>
---
 rust/kernel/Kconfig.test | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/rust/kernel/Kconfig.test b/rust/kernel/Kconfig.test
index e6a5c7a795f0..011c72f14e2c 100644
--- a/rust/kernel/Kconfig.test
+++ b/rust/kernel/Kconfig.test
@@ -33,6 +33,16 @@ config RUST_KVEC_KUNIT_TEST
 
 	  If unsure, say N.
 
+config RUST_DROP_GUARD_KUNIT_TEST
+	bool "KUnit tests for Rust DropGuard API" if !KUNIT_ALL_TESTS
+	default KUNIT_ALL_TESTS
+	help
+	  This option enables KUnit tests for the Rust DropGuard API.
+	  These are only for development and testing, not for regular
+	  kernel use cases.
+
+	  If unsure, say N.
+
 config RUST_BITMAP_KUNIT_TEST
 	bool "KUnit tests for Rust bitmap API" if !KUNIT_ALL_TESTS
 	default KUNIT_ALL_TESTS
-- 
2.43.0

