Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603044E1414
	for <linux-block@vger.kernel.org>; Thu, 15 Oct 2026 09:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792055482; cv=none; b=DXAdSRy5RMTNok5vuMMZZk3epnwxTBGLLljL73U1/5ou47gAOGYq0p0s/VjXsI0gTfYfPhS7xRev4fd46gZrJc5YQmFTzLtzuf3xVyH29IIy2aDnrAGUVNsO9qMpiEXNPSL+sm+Su6/Sy4jrDLW9nUXM6EfjpaxE2tDTky/EUOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792055482; c=relaxed/simple;
	bh=G9kty0cmuqWHae7vsnxZGgEljENPB3gY9weHBSiEzAU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rAkd2EO1tk0GGRiHRGbCljGoCtpRk1ZA1KB3aujukRi5Xoju4GjsPR5shm6voRQZQTwd3shY34qlOvoPWctHWASe0r+hTkHsBBqWhMI/MsykzbBv4M8MsdfiDLfepOlLLujAIwU1Hq/RtB16B41CgHy/86m0/KJwX/k8vlPHW34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=FfMyqaRu; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="FfMyqaRu"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-887beafb714so2573375b3a.1
        for <linux-block@vger.kernel.org>; Thu, 15 Oct 2026 02:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1792055481; x=1792660281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kDoarhYVjO6GcDLXPC39BoDv5gAMZD7MR6J/y4jxP/g=;
        b=FfMyqaRujkKDk1z3kR0kolvEg8mzf1fmAMG4WUfVeOPaYN+8ZAm8zFYr8LZfWf5Gek
         qIXxpxhg5UfJDjXIdrsFLvM/h35FjhxiP9FbU+ohdpeG7AJpPXcGQKSabIWmWpq3wFO/
         PC/rLqdkysABcNOEiLZQflJcloKiDgvz0DMNl1KiWNQ28eUPGgG75qOJj1d7usCa8BXu
         K4qISCqZjJZTL0l1a/QuPhShm4gBj/F6LU3TkVXsh+pt4O+mbO1D0x8Rd7n7+V9vgzH+
         JevQ5NuxAm+j8HEnsRVX9k4TsEuOxt1KQ7fKVEQ6xtZ07huaS+ysylpCTxEHJmNmB31V
         Kcjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792055481; x=1792660281;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kDoarhYVjO6GcDLXPC39BoDv5gAMZD7MR6J/y4jxP/g=;
        b=soMixSwIesim4IFxCYDE2zib1HUzRjvls5j3Li332ru96w1v7DJsyGAtF2yJ74ZSto
         RmuehGFFL7I0eQRuEY3yVAd6tZgU0WH4684z0ldT6BY8NC1VE90h0rXcYtgIziV8tskn
         rdSpei/gJn06NzQmMCG5m19xBdqbgoyqiIvTIYt1LdWBcuo5Bu6xF8h63dFiiu16VVNN
         OA2sit6voNa/szOBhSp3rfBMAzvizvLBQOfOddfTYo6oqyDh0ToLXYN+zEaNmaHCVZAO
         nZgh/rXe2aEpjuFFfgudki2Qy9H2fO+1pIJWb51WmUfl74D2qs2eEjFQBUiDatnrdXyj
         sDkg==
X-Gm-Message-State: AFq9FYKoyoPxqDO+0aIyOVoiGaI9MVt2dl7JvWTEA5QVs6qBuQPqb9av
	lgvZFZCVFHNAeBHS8+9ct2lp5ZZRGCeS//B23mv49oIVyTzScYU/Upr43NtGCWWqeDfwpdyfpKE
	EwYBjRkc=
X-Gm-Gg: AYBFou3UUAXMtBae5m3E0IDXrFEV2JA+AAFiyJbaZPGeHfqejuKgtsr05It1gbnlsEu
	3kzKwLhUDwYqolGmtA/1Lmqv64Qy85km5/3dSlmrJFT0t2mrc2wwR/8ZM7aLrSUcqgDHK7g1HUt
	Q9iKHRy7G9Vl8GMQcwFUJOg1RlHF/ETiFfGwL2rhtdqV/mGb+F3NoHFQePM+kogY+k6XQsengiN
	Qg14yUUSJQrN+2NIN2ADZVC4OdhSSBlNTg2x1NONSFaj3n/f8wQHkptN7lwwqHkGW9Hs44uisES
	2jBhsADNfpsVGO+a5B8LbpNtPR7xl1sCfSGYNmWD5KQ5whLz4suHxdSwlq1uzDw42J7OWVNGOhf
	88pHfpPzUIVh/Spb8EPm15wVL70s4sGHOKkgyxgSgumIO3Ke7uIAA0mlp2Rp77E1tt7J1lcrALX
	az8yxLKRWMZYTmNn6aejbglghpoGejk+TZtOjA4Q+mPMnRkLS+56jGmFndT1LInf3iYQxYZJ2zF
	Tc=
X-Received: by 2002:a05:6a00:4fce:b0:892:d40c:4f7b with SMTP id d2e1a72fcca58-897c653fe53mr16105745b3a.10.1792055480248;
        Thu, 15 Oct 2026 02:11:20 -0700 (PDT)
Received: from localhost ([106.38.226.135])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89d7f5204dcsm2093895b3a.6.2026.10.15.02.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 02:11:19 -0700 (PDT)
From: Julian Sun <sunjunchao@bytedance.com>
To: linux-block@vger.kernel.org
Cc: jack@suse.cz,
	axboe@kernel.dk,
	viro@zeniv.linux.org.uk,
	mcgrof@kernel.org,
	djwong@kernel.org
Subject: [PATCH 1/2] block: reject NOWAIT buffered write fallback
Date: Thu, 15 Oct 2026 17:11:04 +0800
Message-Id: <20261015091105.1315605-2-sunjunchao@bytedance.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261015091105.1315605-1-sunjunchao@bytedance.com>
References: <20261015091105.1315605-1-sunjunchao@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

blkdev_write_iter() rejects NOWAIT buffered writes, but does not
enforce this restriction when direct I/O falls back to buffered I/O.
Successful fallback waits for writeback, violating NOWAIT semantics.

Reject NOWAIT requests in blkdev_buffered_write() with -EAGAIN.

Fixes: c35fc7a5abae ("block_dev: support RFW_NOWAIT on block device nodes")
Signed-off-by: Julian Sun <sunjunchao@bytedance.com>
---
 block/fops.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/fops.c b/block/fops.c
index 2ce7c6c4714e..982a713b4c27 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -709,6 +709,10 @@ blkdev_direct_write(struct kiocb *iocb, struct iov_iter *from)
 
 static ssize_t blkdev_buffered_write(struct kiocb *iocb, struct iov_iter *from)
 {
+	/* Buffered fallback waits for writeback, which NOWAIT cannot allow. */
+	if (iocb->ki_flags & IOCB_NOWAIT)
+		return -EAGAIN;
+
 	return iomap_file_buffered_write(iocb, from, &blkdev_iomap_ops, NULL,
 			NULL);
 }
-- 
2.39.5

