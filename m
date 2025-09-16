Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A47B2F39D7
	for <linux-block@vger.kernel.org>; Tue, 16 Sep 2025 23:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758066648; cv=none; b=nbsRpkI9Mp9RsmCKtySS0Hp2WgkmyMfTUyUMoNUOMpeIO0QlmiQMX485wNxfYOH+CsLCijdqV/Dsknu9XCCmGyYoUn/cRpnZTpe1JuqVyCdpAY17dhDNle64ZYBRNFqiJ8wOZO2JOQ9QG8zqyLmiuo/omJd+shkqmrDyBfp0SGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758066648; c=relaxed/simple;
	bh=WvDk48cCQDjmhEgUA3H/dzeLiBWsntQn2o/liLF6Xnw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jAjEwNehcSCA5002syJs87zq4+/F/gF7l/azwWypd2yc2cts75aSbMuwmkxKXu20diTiURxe6tGzG4ZHUjxwPaW5V1RwPScUvMmpvWnXyWKu4BpLORcES7GXcg/wZ7Vxrit79r0Hz3ntreTTsVm5Iqh3E4zpU9xoVWDxI3hVqP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cP0VpIBQ; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cP0VpIBQ"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7742adc1f25so4193766b3a.2
        for <linux-block@vger.kernel.org>; Tue, 16 Sep 2025 16:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758066645; x=1758671445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BHobEDbeY2DMEEr5x+JZY2wJlQRrUUUgIcR140CbiFE=;
        b=cP0VpIBQ8bSAm6pcXxfh5/LTWHp2uJR6AZTw0bEmn/Qg4U0ZP/IH2jVqER2t1SmN8r
         B3oyorgV8DINUgGl0Wy8uq39dek7maZOcd/rd1aiEg4mSylA6/i4XjTaVgTjInvEa+UI
         jAkcEMcXnIHqjxA4LWqsFJt9/rqVSAli+OKFfNn6KxKkG4ZRCGZAQKKbHnlyVZ4V/StV
         6rU63KwOcdZKjdUzLRNLCOjhzj/sbPj7yzO3uaJ9v7cAQQeLIlj55/Wbp29wCQKiKq20
         5OxMJPuVnbymHqsQvYx0GONvyAKEhx25O/VvCIMMusrrjMVQvCXJwKFvHsc89z4DEWNZ
         oPyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758066645; x=1758671445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BHobEDbeY2DMEEr5x+JZY2wJlQRrUUUgIcR140CbiFE=;
        b=hyYcX9gc2xi2VfrtKOmuvP9zYV2nkv2JZXWghCoiswiANBu6urr6cF9MVIK2t79JFT
         jHWU5+KzzzjkEL84YidUyIaLZA4Gn+J564towF9cgPLf29oAly5KlMlcUcqVLLUvrbeJ
         Lh4mibAVRM00M1kldT+u+N7hEsrqj9tlN28pt7WyHCye16qMEXK4CEw3kxxXZzQsYkyD
         dCMNWB2CI3HTw3oQl8pA4HlC/Er90HtuG5rVoIvm1w7OlKo/3VPwffr6B1HzfAMWd1af
         RcAtfSqbvuDEdnuiCHXxnlBWaICvsPXMdfBGolHwm4XcNE1OEmBgP3mM3IDN3kizpdva
         bgXw==
X-Forwarded-Encrypted: i=1; AJvYcCVoLsfZh9owNCOdxTq9wCkZCrzSTAhaPNKd+MdM25Nu1QBdpu5iDHfNFLEbS6Wgooj6gTFs0zfxcejlNA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyNJjGnlYEb7L8sm/Hhykkb49Trce4XV/p8wVcYnrHsXVB222le
	IugX3B6GGUnOBf1gCymtOjJIg+Nxtn7jCxLp7vPwRdrX9S1W0RSEq3qm
X-Gm-Gg: ASbGnctEjRZGEc347zhROtwpJWdo1k8UkuWFNE/ZumZiVNfMdqIXxpDGT9Qnk6hO5j6
	6cPF7R5JzsB4CJ036sTjWFh0DvtcFH11ewLB2MDRzU8whgNETvGMTFAiDMXnNE3R64AWvSjANjm
	LhlP9Y0Z/kR0v0r0y7c+SBukwYTyoPdxjHgy3CzmIBNnFTSz18MmoLLN9Hpx4I+Qg+1R/833whE
	kJuzlbjmHP/0sAgscLQ2fES2AljBe5BeNy0f0snBnnmGRjmHD9LuR3aagd+1WV2nsFCBg0+UcPm
	8VA/RQIeUzfhPx+l26b70DNFaLkKZmLLAtCHQQfpjw7uL9diC6PBU3w4DBgtOf3D+VnXEuG9N4H
	rw/QjlAACRmY4HUtwP1VgHZb0ZNr3RTCcp2cj2u7fPxgzwULLrg==
X-Google-Smtp-Source: AGHT+IHkRlLnCp0WU1FUde2gi6s/vcnbEIKk0ErpbS8ixCYe3+7N5XMnBohfRkdqaL85QNvZmgrsuQ==
X-Received: by 2002:a05:6a20:7d9c:b0:262:5689:b2b1 with SMTP id adf61e73a8af0-27a938d847dmr96465637.14.1758066645351;
        Tue, 16 Sep 2025 16:50:45 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:55::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77607b331e4sm17001334b3a.70.2025.09.16.16.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 16:50:45 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org,
	miklos@szeredi.hu
Cc: hch@infradead.org,
	djwong@kernel.org,
	hsiangkao@linux.alibaba.com,
	linux-block@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com,
	linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v3 12/15] iomap: make iomap_read_folio() a void return
Date: Tue, 16 Sep 2025 16:44:22 -0700
Message-ID: <20250916234425.1274735-13-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250916234425.1274735-1-joannelkoong@gmail.com>
References: <20250916234425.1274735-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No errors are propagated in iomap_read_folio(). Change
iomap_read_folio() to a void return to make this clearer to callers.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/iomap/buffered-io.c | 9 +--------
 include/linux/iomap.h  | 2 +-
 2 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 72258b0109ec..be535bd3aeca 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -450,7 +450,7 @@ static int iomap_read_folio_iter(struct iomap_iter *iter,
 	return ret;
 }
 
-int iomap_read_folio(const struct iomap_ops *ops,
+void iomap_read_folio(const struct iomap_ops *ops,
 		struct iomap_read_folio_ctx *ctx)
 {
 	struct folio *folio = ctx->cur_folio;
@@ -477,13 +477,6 @@ int iomap_read_folio(const struct iomap_ops *ops,
 
 	if (!cur_folio_owned)
 		folio_unlock(folio);
-
-	/*
-	 * Just like mpage_readahead and block_read_full_folio, we always
-	 * return 0 and just set the folio error flag on errors.  This
-	 * should be cleaned up throughout the stack eventually.
-	 */
-	return 0;
 }
 EXPORT_SYMBOL_GPL(iomap_read_folio);
 
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 4a168ebb40f5..fa55ec611fff 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -340,7 +340,7 @@ static inline bool iomap_want_unshare_iter(const struct iomap_iter *iter)
 ssize_t iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *from,
 		const struct iomap_ops *ops,
 		const struct iomap_write_ops *write_ops, void *private);
-int iomap_read_folio(const struct iomap_ops *ops,
+void iomap_read_folio(const struct iomap_ops *ops,
 		struct iomap_read_folio_ctx *ctx);
 void iomap_readahead(const struct iomap_ops *ops,
 		struct iomap_read_folio_ctx *ctx);
-- 
2.47.3

