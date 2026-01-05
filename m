Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E24207A38
	for <linux-block@vger.kernel.org>; Mon,  5 Jan 2026 12:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767616965; cv=none; b=m/+/QMbsuTdLLi+jIIk/ze93tQXrvPViKl7oSyWuP6n9g4AMZvZ6HvTASk/YAJ6lULk3y9Lf4ZhQfQN5yohxNZpQUaoSQSokpmscfOb/gw11mE/LLO7LrPqjV9hokWHcnVBUhCQfTh5Msi4N9Zo9pGBQXHAjUlLwl3ERHbY8JRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767616965; c=relaxed/simple;
	bh=7YOfd6BIaSgVOEuggrQSmas2nK001qTwu40Xnq68ho8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VXhCvPPpUkKBccPrtRfezmA2EIVK6O4a8Z1xFUhEbGwAwMlO/6pN2e4UW5qYUE9Z2N25Y5HDijzGi1ccKP6ZKziYA3nbOFtt4reKmPVeEK4H021Jpsxz08DV2hJvvMwRMJSUtDlVzLFLcJ+HSHKW4XQR3CgrUBPOksUT2POCYZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rbDkKljD; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rbDkKljD"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-477cf25ceccso149634635e9.0
        for <linux-block@vger.kernel.org>; Mon, 05 Jan 2026 04:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767616961; x=1768221761; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pAEWUPqGafJsPyLzRansBUV/K4ksBeeXMLF3e+syEJs=;
        b=rbDkKljDj20EJBiY4gdzloo1FdlCZZYyTgUtSgNL3f1rD/etNHp4VqHkAY2uWEsDsP
         EBLaTQonjifuG89asvzOgK+hNiLIMHl71i6mnc+spX8CYyP2zlR6rG9vaIGAo5jVmBhl
         MJtSqAwlvVKshuQ/gZQzF7s7ioLDDpUBf1SNlSRUTs89gkYWpHIEp/i755VF+kldfRkT
         PmMRLN3PbP0/atOVtPO1YtYXARFg+iB5QILP+UqpeQMh4Y5PRD+hvFULQ5ZpzL1eEOMC
         0clVciGv+HpPO/rPw2zaLmqSOJTHs96HCQu4fM/i8GnKJIx4kykskAtUlqweVqFrIjjK
         oRdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767616961; x=1768221761;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pAEWUPqGafJsPyLzRansBUV/K4ksBeeXMLF3e+syEJs=;
        b=fHCiDrNhDHyQsQELc1TtsCXArWCQ/ofvPmpOOPqlh9MfspddwjlE0e3HbJKhzqCvd6
         jR48Y6nfHwFUhFWGVzftdC1hSKVbIMOS8qLgeXLi+Sdup8gEeyvcUNVoux0et2XbeV+4
         0Rwfcnl6KO+Ug0we03IyNQ72epdSILWUfPLRxMm7LtJSwvREGSKYxSTCBzV8XaEg2s9F
         PlkxhhpuLmwnF+kAafR93WJzwTswZZwEnVe4XdJKuR4hr3qjFbPdHPT0PmW6sVF+FEi9
         FKfKaKHA+pcoF4NlHx3RiGQqX4GyfObL7e98NYYExpcCCsXdhh/kmF7Y2t/1ibA/mbMY
         NUCw==
X-Forwarded-Encrypted: i=1; AJvYcCVlCyzASiyfMUGCdMWZos/3u6FTvih3cNGaRhM271x9BWWIUz29h6vm8xbX7WQr7tduk6adOCciTUrzMg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxtzqQk9KJrj2LTjM2qS5lUc5phLliacfyHXeIHhOR5YdmQFIMu
	evUf/hs9Xik1YZhw2/f+Z32BKITG7Z4U96xMAM5vu3TUuNMa/MpmTvUxzaj/tz7V+KPLbCIP0FQ
	Pvv/lHLxTZbLFnhNcxA==
X-Google-Smtp-Source: AGHT+IEqBboTGbJEnAhUdsoO0Sa3wunZtXW/D7wzh2htHW6yOpQKo2iiZlFGvdup2MhdqTDYJyJE99tPLQuWCFg=
X-Received: from wmbjh12.prod.google.com ([2002:a05:600c:a08c:b0:47a:9505:f0b6])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:8183:b0:477:fad:acd9 with SMTP id 5b1f17b1804b1-47d195a9834mr577619975e9.34.1767616961499;
 Mon, 05 Jan 2026 04:42:41 -0800 (PST)
Date: Mon, 05 Jan 2026 12:42:15 +0000
In-Reply-To: <20260105-define-rust-helper-v2-0-51da5f454a67@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260105-define-rust-helper-v2-0-51da5f454a67@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=1073; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=7YOfd6BIaSgVOEuggrQSmas2nK001qTwu40Xnq68ho8=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBpW7G6KgqzoGiKhgM1oONkxTX1RHBvSM0z6aXBh
 N+S1VG5TBOJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaVuxugAKCRAEWL7uWMY5
 RhCxEAC2t5fIdzNQgAQ/ihWYfNvcjOtm10sNSiyBiNu1o2FjcapvY31uMWTcBkfviGBP0wUSIGo
 G9umZUc6lEnNH/ANYc21Br2Abad6G5FgKMlZIevRk8CBEzP2fkiXBHU4u8fDxdfC32c6b7WK29C
 kiuR4fNOWe4BKOef7dwJD5KGQbm/bNtYLcho+VvSgEZ8roa/0IQukFzcdtN/GArTywZLg39zOE9
 XgC5bJlg7TVbWSQetrFWi46y3aWxBPTwlS8pN7dG9t5CTHONLCnuuFCSlDBMBzBn+Z+o9LfgR3P
 N0aTu/QY789oDTDX6ZYbnD+wMv/dgJLcyZxEC5tbyhrE+m80+dQZbJmUNkguAqextX9BfdD5sqd
 5Zq8HJTYL1FMRPPQ4Br38Rm9OGUG/z93AXyIaJx/i8rLdvqv4OO0ULAKD9qC9AIIKoyFuRbQJ+Z
 QIZVMycKYb3TZ8ky/pWt6bbsh9xqs+FMdz7GAErjsih6XpRhaFbr7uioi3ah/f76GExdO7pBSxF
 EDgasPI9aMv/N9l9TGG6oWrFI3bcOcQVMQzGwRoglaVDzxc0WiM0BPnaalsmyKSkryrwM9zwLNL
 wKkYFQQ5O/SCX0bi1+nrgBex2gt5NrozeJvkjlWqM5HKtVG203Hvwnn4DMul02929uHAS85csGz aU3FieHVe+ObEFw==
X-Mailer: b4 0.14.2
Message-ID: <20260105-define-rust-helper-v2-2-51da5f454a67@google.com>
Subject: [PATCH v2 02/27] rust: blk: add __rust_helper to helpers
From: Alice Ryhl <aliceryhl@google.com>
To: rust-for-linux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	Andreas Hindborg <a.hindborg@kernel.org>, linux-block@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

This is needed to inline these helpers into Rust code.

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Cc: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: linux-block@vger.kernel.org
---
 rust/helpers/blk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/rust/helpers/blk.c b/rust/helpers/blk.c
index cc9f4e6a2d2346eb2814104cce706755ba135e06..20c512e46a7a5fd126d092a5b9f8742a1deac9ff 100644
--- a/rust/helpers/blk.c
+++ b/rust/helpers/blk.c
@@ -3,12 +3,12 @@
 #include <linux/blk-mq.h>
 #include <linux/blkdev.h>
 
-void *rust_helper_blk_mq_rq_to_pdu(struct request *rq)
+__rust_helper void *rust_helper_blk_mq_rq_to_pdu(struct request *rq)
 {
 	return blk_mq_rq_to_pdu(rq);
 }
 
-struct request *rust_helper_blk_mq_rq_from_pdu(void *pdu)
+__rust_helper struct request *rust_helper_blk_mq_rq_from_pdu(void *pdu)
 {
 	return blk_mq_rq_from_pdu(pdu);
 }

-- 
2.52.0.351.gbe84eed79e-goog

