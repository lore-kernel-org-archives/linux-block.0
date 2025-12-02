Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B272E6CC3
	for <linux-block@vger.kernel.org>; Tue,  2 Dec 2025 19:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764704279; cv=none; b=m/CJzjrh1Wq0mOSa2R1nk5jLdOWTKAvSK1lrv0pLcxq5/3LC4cVPb2DC0jHqEGtq9dYO2188cC5G0Qx+ZddB9pkRgeRUuFn1bMdHc9gb8Rqg9FWGf39v3AX2pxzPINcbBvXgkwXigOhIxkk9KHhhW1jPsqxJJBfXVQc3lVhDtlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764704279; c=relaxed/simple;
	bh=xERiU4ppA0AFlgBc/6yyG5R6CDD3y1wftzYAux2Kp/s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=as/WWLCfuFdeC8RE49+PH3T8AGImoFycmbzVYyFz/NnJq4koPtPWSfJPp1ilnHIVmp2itc4JSm3utQGmj2+EZC6GGYwdfFR77VVzAR1YhqX24FdIGRSbjpYuRODZeuyZth+gWiOLpc+dxrRTF+Wg4GPO72VHqxAdQX4OCN/WPdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qjJatZU3; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qjJatZU3"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-477c49f273fso56605425e9.3
        for <linux-block@vger.kernel.org>; Tue, 02 Dec 2025 11:37:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764704276; x=1765309076; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=A26qkcx0gzbdQjnPGB2mh5/mO34YYNtCkv24hE/+hVA=;
        b=qjJatZU3G6vu5eLhxQ+hU+aXgU2wubH6r6z5g0FjJSIyzUAUO5Ip1LtCa8yaXe9Xxv
         mu2ciDXyEH5iF+wotX0Zqu2AWkd9MuIcJZ3fs3eAAtX+oE3u8noVSzs1brLQWErTmavh
         2rNrIhSq6BI/jCqVfxKJftV6PM/SClVhj8QsxIX/M47HA4SyEdk5cWlHZtlgcnRQ8lfQ
         NSUN7gaFUxkWrQvBUzosM2c6O2Q2JPKZTKNRIu4JdIe+yCx0HNwf1K8PqLUiVmMR4scL
         q4wAjSxryjNxK1XLw7Lt15SUBr1ON2+Y7b6ZrS/X1GUhcOJbTSVrXLbtmn6Ke3xqqdv/
         MfhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764704276; x=1765309076;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A26qkcx0gzbdQjnPGB2mh5/mO34YYNtCkv24hE/+hVA=;
        b=tMxIIyMhWdV1m555DV4ZWsttWPd716fyEVyK6ODHC9sbcDTll9xZv87Wid95HHiadr
         502CuW7c5Eb0/0jL/pW/CII5F8wUJxlK/fmpf/bxSL0G+PzpvHo+E/Mxw4w1L3EVTAF6
         30+aGxl+sYsk5KhUDDlK7PfUSSq3xo0XU54Mf77Ao6sUf4Uuk54QZA5ZPgdzYDamhAbg
         1vgVh6Ii0RdIrjxHOhqIcJJj1zaD1FvZaQpLuyOpZqomZ09QlXsvSpeN1WnIAq583HKA
         LXY2C0l+Wk61ds5hwh+dkY+BWVa2PwNbx1iLdsJKHHagONAVomiW0lvMxS3gC+tHZZLx
         aUIg==
X-Forwarded-Encrypted: i=1; AJvYcCVKYz1hye0NoqjDzLtQWwSSPpScoArwH6chgyNH/+b10kTDsOogOKKcWI1ozAvfAhKXuaMKQzKgddxu+Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyVUha1YW9xUjjnM0199SgYnSK9YLZWecnXFP1nYKUiq3Q5U/sf
	wjiRq2z4u5ZbUpMwxCsqggJmz3Ux1vQjUJ/+iTC4FIh8c29MfApnqm1nBcpa4UCW9RIPHu6w/+v
	uV6PZlSLuR3R1FpsxGg==
X-Google-Smtp-Source: AGHT+IGYpROhkFCJXaqZVss3Aj7Z4dCuqkHvh9NnQ9AmYfoUFQabruKqVts+lURH0yzSLg4Z6xsNOogkjHo39TU=
X-Received: from wmbjx1.prod.google.com ([2002:a05:600c:5781:b0:477:1022:3342])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4443:b0:475:da1a:5418 with SMTP id 5b1f17b1804b1-477c017484bmr443104325e9.1.1764704276660;
 Tue, 02 Dec 2025 11:37:56 -0800 (PST)
Date: Tue, 02 Dec 2025 19:37:30 +0000
In-Reply-To: <20251202-define-rust-helper-v1-0-a2e13cbc17a6@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251202-define-rust-helper-v1-0-a2e13cbc17a6@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=983; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=xERiU4ppA0AFlgBc/6yyG5R6CDD3y1wftzYAux2Kp/s=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBpL0AH4l1ngaorSNoUeNZ3T+oo/2rSZCNF6W/TQ
 ksLlNducOiJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaS9ABwAKCRAEWL7uWMY5
 RlDSD/9k+P6WIKkFcV3b27pkAPZFqmhGLpmqtIyvY5VUEk583LUlqBWEiXgYdPySMg4ZoGQOlDi
 xdFGnVVUqVCwBOkPCOkaHT8sNsU1adY7+0vSeg5fdAO1oGBanZD0ka5jekp3OGxUcFu829VvTQ/
 dzrQZHoE8VBGN5bB2pc7IZwhuCRFC7rSRd9dcmpY1qXxS3/kTgz2ec6Y3YXMXq9FvGrke+9kAAC
 Nl71iaPvgxwnRtf6x0v8gHymZYa7ohOKHfB6YHhgD44byPCIYrPsembqgXbbQ0A2sNFfB2qLVM3
 zaMr3BHwcYajhqFgZt5C1mq9svLzJ7SpGGE6ajEm5tGgNVvahIm39IlfLyUnIH2FtMLiC9kVnNz
 5DMdGjmGZ7rJBODU0vhDQzL5cfZbtfLa+rcE316sbuOzzmi/lMd3G1UlrcSREjwUHP26Neeger+
 EhP2HFpmWMdMOchAWh0uLVBvguqvBj9y+K0TPDuKLRJSaub6SplTB9NAqK4gG1w6t2+FNRsORdP
 vk+SNYTtwk1O2IwB2xOBlNp/P+DGKNphxiccJsE+XN2PciejYioYALNij1VeC05TDuPwXvfyvsZ
 ITUA2KCHzGDrkst2lbcev/aGQegtK3WnrTjLMyigV+YItcn9tvh/StDMORI046NBVkrVP0vJSUS qaMgTQq2SyY21NA==
X-Mailer: b4 0.14.2
Message-ID: <20251202-define-rust-helper-v1-6-a2e13cbc17a6@google.com>
Subject: [PATCH 06/46] rust: blk: add __rust_helper to helpers
From: Alice Ryhl <aliceryhl@google.com>
To: rust-for-linux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	linux-block@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

This is needed to inline these helpers into Rust code.

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
2.52.0.158.g65b55ccf14-goog

