Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F9234D4CE
	for <linux-block@vger.kernel.org>; Sat, 26 Sep 2026 16:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790440561; cv=none; b=cEjIbsBvHH0XrxTVQBqWC0JJJASOKGIb/mlkMPvs8Asz9c5P17sBXtDsutZG3xli+pYJDqon9tWosULOMjoXiyoKDfOHunkpFfgJUrl2UtJCqX1qKo6HaGw9y+q5ENUcxvYsItVApGnhs+zoUCdEkg10ZwqjPLjV4J3S9XE7zNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790440561; c=relaxed/simple;
	bh=5VNrVx4ZKAIvebGxfLNqPgw9xDv0RVGMqeAFRyrl6Dc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g42nvQOsRkvt2zwAFMMDrpLY5Sqzo+Q8QfIK7QDXv2ZezjV3qyoanuvkOpjvTcBDnUNxZDd3CBxoX4xIe3qXri4/Qm4YPPIgw9F5mAiKO3p4VW/dHwkiN/GoRFzFnurzwH21Nk/CyylFOCJSQw2LIGNdkBe+/dQ3UFdRPrt9tB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GMRKMigy; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GMRKMigy"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b91369d18so11190245e9.0
        for <linux-block@vger.kernel.org>; Sat, 26 Sep 2026 09:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790440556; x=1791045356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=92J4cdfV5TssQddcjnr52AW40i0MRdcSuU09rnmRkE4=;
        b=GMRKMigy15lhxSBtsY9tLDNnBp7jDte0j+9a22hpyfopd7WK/kzTZkyKuCrx3FDgOD
         QB62hxpqiZiEpg/wmJfp15seOyKZJ8t8M3+LpotC1nj7mwchNUw10R3mSKxa8i8ZZNbI
         b/u9ThPqkGvnDsDmuEe6Zsv4pTruh2Esy/PivZgp40yVT7/hf9XNRk5YrhByOlrkl54R
         wCUToG/F7yMPkEDPSu12arX5Iqj3LrIVuNzZ9SUO2G339eTPuq/PKvbWzDJMkNNY2p/h
         Ah1+crCdkTu/2KxpVi7Io+iyE/RJ7NVX2mWT7t7QTaljZLkZhfJeXSmNsXGKMol6+9lu
         fBKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790440556; x=1791045356;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=92J4cdfV5TssQddcjnr52AW40i0MRdcSuU09rnmRkE4=;
        b=Xm1uOytQYLd8v8iP3xFM99YILJayMjiCSdKWrkWMx97XPxBkvwtJEOQS7BsR22EqOR
         NuNx66OK4SJxnoHf2PX4ijTTnkQsUE8ZPpZ/QH6BFw0miGlO0TVx4KhudIl8jsps1cKm
         4E8AC0WgM5x9F5f87rsKCv0u9eu//EJ/hL2QJy2H6VYl73/bJ/ho0+iTKvCbdCXuByLN
         kRD3LTtY3toK+53s2wJeOcubrr2BRq58B06tuLA/DbvJ8rfpYkLADRjY626LOzmGMrDW
         n67RrjkggChvOoRgkWX4TaEuJEytIt/KHJqUtDNEqFNMdZ2jCcuw0bJiS4uBZI3iHy9K
         DCeg==
X-Forwarded-Encrypted: i=1; AKwUvBw3zwmNDafAMAWsrAUkhPSp6dYaEN4TsvAQcOpewHehKXpPJAT7qTv+NbglCJ+7ilpcM3jzFI2iv9blZA==@vger.kernel.org
X-Gm-Message-State: AFuF++leOyVqJ8ASaxlIJZCrbP5lu/XzARF7C5qGcB+Cz26aj0DWWurX
	RSSYlpjbhBZLqiBymxwUNl5ROWAnjIsMkChIy7Dtdax4Uwa8DBKgsWMxg3erFbOblfE=
X-Gm-Gg: AYBFou2dPXdHoBZEdZUbnPzER0Lt1pZmIHlet4hRUPoQmjdkCjVLSWUy+lwk+8kJ1R1
	tmy3cST8op3OhXPf1OAxR8ScqVbr7ZBUOiBJEBLVAQd/xvUFKL42FbvPD7bPm4Zr4iLE4GIrU+6
	mphfBq+5w4yPh/Yfk4Fu73+hG0Woi5LHRSCYA5pXIY/pol9PNHwf/pILs/+2l1K4D5NLdUlms4I
	aDmZaS4xUuyH/awLxJVO4IHKe0g7LmHSl0DqYU3YIgirvJ7+XR0S12K4jnO44/FgxJFzC5tZRZe
	eS/Ep9sFZjmXyi2B3CGKpXPCmyVdgtVmqxcUi6UIs5yBTzC1XvAKhm6KrEY1ASpNqiD6n4aJC3y
	2bRMNUtrcO3wn82kSGhMetZGF56YkIF1m0+qq7nvXXlqy8z7qMNzyNHGFqtjDatJbs1vz3z57YI
	6koxBOj22pYhs0b5qf8bAkSI02RUluXYVHz2NZ0AMoR2z8/jXbShEP5yQdBsuKf+1A7Ny+plkDL
	Ek8S1lp4m2fUr9QEJ/XQ+D8yD32e/7d+NkbCPZ7LrOoaZTBDUGEvYVGkaKyoxqDsSztZlOsBH1h
	Yg==
X-Received: by 2002:a05:600c:1546:b0:49e:7a00:b9a5 with SMTP id 5b1f17b1804b1-49fe66bdee6mr155118895e9.4.1790440556411;
        Sat, 26 Sep 2026 09:35:56 -0700 (PDT)
Received: from moosama76.. ([102.44.245.127])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a355d96sm16176146f8f.17.2026.09.26.09.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 09:35:56 -0700 (PDT)
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
Subject: [PATCH v2 1/5] rust: add DropGuard KUnit test configuration
Date: Sat, 26 Sep 2026 19:35:47 +0300
Message-ID: <20260926163551.52371-2-mohamed.osama189110@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260926163551.52371-1-mohamed.osama189110@gmail.com>
References: <20260926163551.52371-1-mohamed.osama189110@gmail.com>
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

