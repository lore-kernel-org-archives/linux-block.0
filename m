Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C7F242D64
	for <linux-block@vger.kernel.org>; Wed,  2 Jul 2025 23:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751498444; cv=none; b=OkKeaJMyMutKqyG46oRbEBPaqTFYeYsVu+xSxJBUL2qAFy5pz4FmlUEr8OjC6Cnm10axswtGo1X9eOzGWHVRVia0NPdvDY365AabvaOZV0RUsScV2hanYHQa8bMBCPfOiXLcwgLmrYlnzf22aGDfRdta3HyxCPn2ZkuDBznnvMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751498444; c=relaxed/simple;
	bh=q3ofX0T5a7aC+Sxdb7tFd/olIE4sjwbtwq6Y+ktwBIo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Fj5uQ0oC58JJKPtdVVB8+iBwwlYa5sWuCLWoc4WAcpfx5Xb91jAuUaYUo7jkb1dCOfglIp07iDBf4Eg17iweQWXnyv2eE2BkZJ3i4P6O8yU2DV2g+384fMyC7TGQrsIH0QA9gtpxV9Gl0wnFwxUR2VRobSgMrWKPEZGIIjDiRCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=aP1+7Cv6; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="aP1+7Cv6"
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-8731c4ba046so451539839f.3
        for <linux-block@vger.kernel.org>; Wed, 02 Jul 2025 16:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1751498442; x=1752103242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lhaVNTqKFBo7V81f6Yv1iIxQt+Ef23n06JZqgPmk2Dc=;
        b=aP1+7Cv6tUDK44r5eumil1x3bKPOaNI3s9spHmMqIG0SiaWEAggSXcSyBd2NYPIyFX
         +oCnsLTxxiPquirA9QqY0zHR/FA9EwxCb9Aqop8Ccw5hOCp2zqBMdavRwnvmUEzDFutg
         OUOE+OFFah/+sLwUaMJ3ig4KmUoWZQE60Z0rSCIjlOcP6iEPFRvEnLoLWHu7LbC9Fqd4
         Gi/13kImiDCNGQRnoJmOi9s6bZif6fK8i4XMAlsuMwsm4q38BN/UAkhSfePBXIdAZx1i
         0NcfkSoRiWTxSIy96bKr4qb+Mj0xzP9Yz9BIysV9zSfPKYmsbQ4TkQSwPYP77d6pnm5Y
         lkkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751498442; x=1752103242;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lhaVNTqKFBo7V81f6Yv1iIxQt+Ef23n06JZqgPmk2Dc=;
        b=F8mRLNhZ4ox/+ZgVxhVAfkDqlrb607mKQa78dXesjHN6T0WdZYtFk5bJiFoGxqj/uX
         ACBKXad5tgV9OnCbCcddVBfMXXuDnRWpd76ykpK/TCeJX+LoNC4ZGkJw+KPiDhH/mi44
         jeR/4P687CGN+LsLSlSiuzn+0H90cX8TCwgufxd1BH5ZfZmo7w7reECR3MBsH4COUbtX
         Ua8Oxp4Dg5C2wfR/HvofXOVJDUerj1hN21Ks9Y5FDs4N0CUPuQ7rJu2dFSmxRe1vrNfJ
         BsH1tiwlKwueN+Rv4kDgdDNs37jkRVGqmbexA7myOqT7oiqxOIQcIeyp1tpz6ypBsXnt
         yboQ==
X-Gm-Message-State: AOJu0YyDBiE7opeimViOWi/kjfhrR0PnDWTH8cQY64G0a2AjPj9GgTki
	TJ43Adu5z53+FVESP7JjeWGXffm90ohzyU5Vl/KVL1VF7a+w/x7Ccnu9DEUfGPbA/g7v3F1nMkK
	oIHWi
X-Gm-Gg: ASbGncu7kAX33tUmhamw1FGfgGQrK8BDwguBkTaib+iGuOVOUukTo7ej9I5fTcauWKX
	1j+Kz8mBMKkmH4mUewtK9QmkC9MFMtHyprAIm/pao/ML+mTKpAOhM3ZLfDNSZm6/oe/7clskrEf
	2CaL1c9CHKUejWJ0dTuEPFVUr6AbwAAz1CFoYZSXkDcJwHPiCBrxFZhYBCyEjsrVlP/lvjaOoQG
	hNWciuYXFZeJskmCcbQqetoXSjMimoV8X3crEGEIDdTCTkmHCz5ImJ3no8VKli6L6WDb3fNRAfE
	TKx9s4HXrUXKblSHjmzMdFLSFoeMNTrZQLlQ3oaBshIwgsLd+qzRyg==
X-Google-Smtp-Source: AGHT+IEby1ioQvw12GtPt/ocg6xPvPzaqg55+xdZ8hB8KnbDdnv7Wv2+8Tq0O9OKzEA3E3Emy/GHyQ==
X-Received: by 2002:a05:6602:750d:b0:85b:3c49:8811 with SMTP id ca18e2360f4ac-876c6a098f1mr818720039f.4.1751498441970;
        Wed, 02 Jul 2025 16:20:41 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-502048d2af9sm3209457173.56.2025.07.02.16.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 16:20:41 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: axboe@kernel.org, colyli@kernel.org
Cc: linux-block@vger.kernel.org, linux-bcache@vger.kernel.org, 
 Matthew Wilcox <willy@infradead.org>
In-Reply-To: <20250702024848.343370-1-colyli@kernel.org>
References: <20250702024848.343370-1-colyli@kernel.org>
Subject: Re: [PATCH] bcache: Use a folio
Message-Id: <175149844110.467787.16486778272474982430.b4-ty@kernel.dk>
Date: Wed, 02 Jul 2025 17:20:41 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-d7477


On Wed, 02 Jul 2025 10:48:48 +0800, colyli@kernel.org wrote:
> Retrieve a folio from the page cache instead of a page.  Removes a
> hidden call to compound_head().  Then be sure to call folio_put()
> instead of put_page() to release it.  That doesn't save any calls
> to compound_head(), just moves them around.
> 
> 

Applied, thanks!

[1/1] bcache: Use a folio
      commit: 88b4b873551f0901dd0314d37ca2a420ec6c2686

Best regards,
-- 
Jens Axboe



