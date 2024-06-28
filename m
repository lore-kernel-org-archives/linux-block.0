Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440A2146D53
	for <linux-block@vger.kernel.org>; Fri, 28 Jun 2024 09:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719565932; cv=none; b=VWE7N88MpcH0me6+BVn2xboa16xy5kUFAO34RWBaCXaeC8utqYOJOtQwjx3hThcPpzRhiXbxLK/3uRU0BV32a7GJOPdbvP77voZ1EMUkV2MmshlqCUcgXFn7J2GTBCOqrHzrGQVDQz6IhUN16NVsI8fKiGzaZpRUgbsdNPYnMDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719565932; c=relaxed/simple;
	bh=PCo0ch/K5cV4qtz92YLrZCNpDJeKxdLKbj4Byj/RJr8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mgOSniMdz1JpubIBYtmxC5ne4H1wCeB7TvVT7hWDRhQfhhURCRwVf4UHr4bYxLd4Uq3ijrBmQJ6ni9aQDTwzz4r5XHzK0htY15aFKyfnlt9weBNyrzYQPQrtlCuN0szJqssyUCIiCtGU/18AnZ5T38MHYX4xQYfZhQvMP8v9VGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk; spf=none smtp.mailfrom=metaspace.dk; dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b=DKUCg4il; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b="DKUCg4il"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4256aee6d4fso2824855e9.3
        for <linux-block@vger.kernel.org>; Fri, 28 Jun 2024 02:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20230601.gappssmtp.com; s=20230601; t=1719565927; x=1720170727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gReKHraiJioXX+0nn2hR0b48w9MDTmOAPv5i1yeBpkk=;
        b=DKUCg4il16O7BGG8uXtWYThS5s8xrdxu66xEUmb6Ov7FoUB+P6sfsMzpyZGQriZQ/t
         VuYnA8WlfIhzJQ/mmX+C3OBZ/kcsj/D4XBea5u7zdwgYut9eQC171zHcm4Tc+3vW10MD
         22hegD8yeZsXFFv5lQn+tueNLfcILSiy1RqnI4miLkdCcB0A8ofBVLP6Be6mm5XiFZBH
         Rns89d5KETNf6LXUHCgXXZzLRZC6tl7lVFTBykBt+yD11lWWLqJG8fPRq11nuRknEW2Y
         TFvM8jveFNBA1VoLozUUfZGWFuq50CNxF96Gz/wTdDrOwJWIs3R1HBPwcTIGnZodnTqO
         KtJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719565927; x=1720170727;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gReKHraiJioXX+0nn2hR0b48w9MDTmOAPv5i1yeBpkk=;
        b=JZcVYJGfD8ydi0tZUqmH3ZdgxVpa3eTQlAss9LFOOcnraGTEE2groJ50LLS8E1m/Ho
         MKLuK/a060cf8pgNIoZHSBCENQHxP7H385QIGdLEO/FeXB+Y51PKVEKYLzGDT6Y2RPeX
         drLT7EGSfHyCnGJl//MfNWf4qgSPvVh5E7q1giVeyEMajODb1RpkbPgEVWWcBbjL0f1A
         ikphGfSG9x5ARaK5sCbQHKtZVsqPhaYXQZ4/wiCTj8jEDjv3ASW4SFYwm4DClqwOokbQ
         RvX6ARBgYPdqsjXl7J+bWrGcaon7o8R85N+21Af0YkFwcKLV/A+puBg7PTKDNBNVugQo
         DkLg==
X-Forwarded-Encrypted: i=1; AJvYcCUYb9dS35gJefwo+s9SA0wsGEf9MlcCvwXxwOqMoOgiIGXB+0ccDSI7IhpURE0pwpbctDQVhKb8pKs72bFeYRh40AIDiTS0IN2Mg5o=
X-Gm-Message-State: AOJu0YzRYFUeED+3AlA2VrD1q/HtPnPvJM21GAuOCruxXO/eaKyyVLmY
	mEu9t8mdemLPBP5des5Xj5i3S63zsgu/ji1Mm0RGfWGdUV24fIsOoWHt3nCEGGhPVUPJiCpilPA
	+
X-Google-Smtp-Source: AGHT+IH1BQ1L9JwoTn32tEYpbdOBhXvNVZ8PPxOwy/tYMxfMbTMsDdU3wz6CM8jY4UqVEfbTMZgUrQ==
X-Received: by 2002:a05:600c:2153:b0:424:ad2a:1055 with SMTP id 5b1f17b1804b1-424ad2a10aamr62544065e9.15.1719565927312;
        Fri, 28 Jun 2024 02:12:07 -0700 (PDT)
Received: from localhost ([147.161.155.79])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256af38a0asm26506765e9.1.2024.06.28.02.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 02:12:06 -0700 (PDT)
From: Andreas Hindborg <nmi@metaspace.dk>
To: Jens Axboe <axboe@kernel.dk>,
	"linux-block @ vger . kernel . org" <linux-block@vger.kernel.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Miguel Ojeda <ojeda@kernel.org>,
	rust-for-linux@vger.kernel.org,
	Andreas Hindborg <a.hindborg@samsung.com>
Subject: [PATCH] rust: block: fix generated bindings after refactoring of features
Date: Fri, 28 Jun 2024 11:11:52 +0200
Message-ID: <20240628091152.2185241-1-nmi@metaspace.dk>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1205; i=a.hindborg@samsung.com;
 h=from:subject; bh=FI75m/0Mm0ozDMrFAxnTU/YHbJfNFGdUEoZhhb7aZ7I=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFwTDlrQTBEQUFvQjRiZ2FQb
 mtvWTNjQnl5WmlBR1orZmhhTUl4bnVuWVJqWktIQ28rY291ZE5FClJwTURjMFF2eWFVb0xRMnpO
 am1EOVlrQ013UUFBUW9BSFJZaEJCTEIrVWRXdjN3cUZkYkFFdUc0R2o1NUtHTjMKQlFKbWZuNFd
 BQW9KRU9HNEdqNTVLR04zWWVzUUFLOFpuczBFRVNYQkRVQVp6b2dLZElLWU5raFlkS0M3K2hrbA
 pNenVmSnNWcHdodDBGVmhvVkl6SHdkM2hadzVGVndNMWVmY21SRG5yZWNVd1FQMWYvb2NYK21zd
 Vg4MGVyOERICmR5M2V0QStNNVlESGhadElyT2QzdEcyTmFrTFgveTRVYUZRTW1INnN2WjNXZ1ZK
 eEpweGxZZUtuTmRhWldhWXYKbWNDa2ZhVWd4dFNwQit3R3d3enVBVThZVFJrc2JFaUtMcDQwd1l
 uMWNld3JjaS9nbE95RFZpOU1va0ttZG9VSQp3UVhyTnZLcWdKZmJGa1JDSDNCRjdHSysxSXJ5bm
 RadDViUWR3eWRFbGpOZ1k1U1I3aVhrV0QwWVMxVTNLdEZPCkZLQnk0aENaWEFaZFlXdzN1dXdEd
 2MwaVNONTEvc25Vek1NdFRFbUpweDFrekpSWkFNWTVJTHNiZ3k2NlVoemgKL2IyL20wNlc4bGJt
 YmdaNk9WYkNQQkUrRlhiMm5KTjVnUlJoQVJGRVdOMWxCeVFFVXpWZ0RNRGJaK1FoZVAvTwpEL3h
 vWUVjLzFvam9kSG96UjgyTThFTGJFMTdaeWJNeHQ3L0s5TGdhT1ozL1Nybk5GTlFFbnRhNkpTL2
 dBMXZRCkt0bHpyd1MyRDhDdXNsM01VeGtwSXFERlYzSk4vbVdnQXA1OFAyRlA3NU5OWVhSRVZGM
 FlYcFN0aEo5Qmg4RXIKOXBmamxpSG9PMzdXZThISURzdVFLcDk0a3ZrUm1Ma2U1SHE4aTEwT2pz
 dE9iNXUxakRlbHhvTlNwcExPQUUrbApSbkNZNi8wZ2dkeFRXeThJNWRXeUxVNmNPWVhyaERiM05
 yWjFhSmxnMCtBRllmYi9zVkVOc2toczRscEJqWWVXCkVoamw3Q1FpWUxrZGVRPT0KPW1najUKLS 0tLS1FTkQgUEdQIE1FU1NBR0UtLS0tLQo=
X-Developer-Key: i=a.hindborg@samsung.com; a=openpgp; fpr=3108C10F46872E248D1FB221376EB100563EF7A7
Content-Transfer-Encoding: 8bit

From: Andreas Hindborg <a.hindborg@samsung.com>

Block device features and flags were refactored from `enum` to `#define`.
This broke Rust binding generation. This patch fixes the binding
generation.

Fixes: fcf865e357f8 ("block: convert features and flags to __bitwise types")
Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
---
 rust/bindings/bindings_helper.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 84f601d7068e..6deee85a29c8 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -9,6 +9,7 @@
 #include <kunit/test.h>
 #include <linux/blk_types.h>
 #include <linux/blk-mq.h>
+#include <linux/blkdev.h>
 #include <linux/errname.h>
 #include <linux/ethtool.h>
 #include <linux/jiffies.h>
@@ -28,3 +29,4 @@ const gfp_t RUST_CONST_HELPER_GFP_KERNEL = GFP_KERNEL;
 const gfp_t RUST_CONST_HELPER_GFP_KERNEL_ACCOUNT = GFP_KERNEL_ACCOUNT;
 const gfp_t RUST_CONST_HELPER_GFP_NOWAIT = GFP_NOWAIT;
 const gfp_t RUST_CONST_HELPER___GFP_ZERO = __GFP_ZERO;
+const blk_features_t RUST_CONST_HELPER_BLK_FEAT_ROTATIONAL = BLK_FEAT_ROTATIONAL;

base-commit: 9c6e1f8702d51f233402d1aac96cdde8c6bf2877
-- 
2.45.2

