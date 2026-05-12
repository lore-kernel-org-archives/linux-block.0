Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A6E3B813F
	for <linux-block@vger.kernel.org>; Tue, 12 May 2026 15:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778599668; cv=none; b=YJThFxm9x0gZLRDZrcFreWYWO27MS9ULdu2Y8rf29kT2XmPEIsGaAZzlJmiwn7P/CTSFbupzQ2i9UzAz/x9/BJLy43wCtTUI/mDgsLOpW8o5Cr4ax7d415pej11Fqs7IsicjxKVq1KaqO5wnHM1zLadptlcnLyfhqGu1nX2JL5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778599668; c=relaxed/simple;
	bh=622PWjdbb/KAK3yDs52NPuiG7VYIHnznVM3x8y0jpqE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=feyuTuOofJ3Rfu2rLZJb543LllnJD4dgzDrIjyBZ6uefTEexaXwocUaeV/1YXHpjvc1MUIaYjrga0XRVphfV6d4B/Moq74HgVhT9L1HuJLnxqP6zQzMCcsVofuHiSPQeCB4PFk2X4syd4CWxE2KxtGw0amHYX/JsceD7jTaHbME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=WbGDQlnd; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="WbGDQlnd"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-4824176bbbeso1459942b6e.0
        for <linux-block@vger.kernel.org>; Tue, 12 May 2026 08:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1778599666; x=1779204466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vyd6QDETTVWl1xicw+wgwFzqdK3v/8bha5AyEYIiQFE=;
        b=WbGDQlndUows6Rc4qcqFtSBhrF1VkbtoNcRJh4bl0zPACUEhT/pwR2FLb5s6mLxNhJ
         JWZBXMdTnMIxzOl0dh4MzwnrHslfSYRxSeZTzuOkH75Av6hPYvjsrFol/sx/D1nUA0yJ
         hZWIMgEZAT5fDkcUeWA5BBt6fmSlMkKffigRQbc9JPYUqYfTKWfdqRa5zk5jNOvAyQ05
         wWyKUF4IbGRMhIZVY4NbmK/pcRyaW34Jo2gv6kUE7GSeODSt1Rume2vjvecMA266MDyQ
         8cOPoOkcQsnDyawMfn2E9T6Ca4PQlS7mT29FMJGzCwlkG81zA2MxAzDXbMuCVp6Z5usH
         vAwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778599666; x=1779204466;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Vyd6QDETTVWl1xicw+wgwFzqdK3v/8bha5AyEYIiQFE=;
        b=L6qq7/YxuKkIpvdREEWDw27CTFFMRT7cC9dufSEOvhcWkJDiQe6Qtb4uu4n8e4+tWm
         /dyYwWeSViRmZo40cxwgpUUf+0gbz2sVdCa4MntyZBK7ySyJhkuKt+/0wlb8lf2YmDRL
         8DFsLRy1p/oTo3dKMD3Yv3nXN9pFmS1ODElYH0F36kmbO8rQCjMbSLRh3+BIa19kJO/z
         7w/hzBgg1xtV0+6VkoJHX4Mz4miGli6r5whVRaekzWnfCsTEC5/0d0AG7taNth6ZI952
         UOtM+TZOjFLKiIZv7x6v+N5KuK7LkyWqHswCxf7F8reDfoeJ0GTBs2LJEkqpBz+zEkXs
         9ptw==
X-Forwarded-Encrypted: i=1; AFNElJ+QmYHP9ttFgY9bYZqahl80t+RgorxhXsRK3LZFOgi5G0PnV6AOvgOiVYs90sOvGBLgsmEszPv3Hb5j5Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2c1xefZr2sCjrnGS5QnkaU8gMbN1oitc2eSyQGklgLEZ+TTYu
	8SbZYEyOQFWct2ILRCs/lhSkoySltqWPlGhTDhFyXTfTGNf2M+RYaC1+6UauRFpjek0=
X-Gm-Gg: Acq92OE2aYEXWLGoU3pkmJpSFnIOc6Xy5aD+fIoMGSDLhGUPBtlc9My/+CNv3c9xXMX
	c9IZ6/0I2LTLdL0XiKawOTnsU1D+DEz8EmCUrhnQydU9hgz/iPtMe4pGyIbb+StjU6EZbuQhtzB
	5XOSh8i/cbdIK+8bzg5t+7j2Fxf1urAfkqP529O6RwJFvInY+J9i6S035Y5r/gXLVWWVVIPYGdc
	8STiq1UbD27zBblXEpYo4FmGu9ACGEdu3XMdE97jFPGCaaUeXmJeG26Qvm0hGQ3LvBykZeKBE8/
	wKpY6/qiEDnKTbVXA3ua6r+WxCKcVNvu7qgRgVfvSfcWAiNcQiR0e14x7uiwC05BWZRqc38Y2UU
	Keuy5sNvPyv1tb9Mflwo51f7CsxCXtCMHvekLOfR7w797PR0Y7LPCarNHcDTyk7ljg/KQX7M8eN
	RIAQt/E9DnmhkvUde9eFfyGGTwUShR7qPQ7PV1BvhlBxXa8rGcKOPh+lvulah6ETpaorGG8FEeJ
	fTyaWpqnbySog==
X-Received: by 2002:a05:6808:80c8:b0:47c:6c99:f20d with SMTP id 5614622812f47-482973b6681mr2084881b6e.40.1778599666201;
        Tue, 12 May 2026 08:27:46 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4355736f517sm13044552fac.12.2026.05.12.08.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 08:27:45 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Keith Busch <kbusch@kernel.org>, Sungwoo Kim <iam@sung-woo.kim>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
 Chao Shi <cshi008@fiu.edu>, Weidong Zhu <weizhu@fiu.edu>, 
 Dave Tian <daveti@purdue.edu>, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260512050929.541397-2-iam@sung-woo.kim>
References: <20260512050929.541397-2-iam@sung-woo.kim>
Subject: Re: [PATCH v5] block: bio-integrity: Fix null-ptr-deref in
 bio_integrity_map_user()
Message-Id: <177859966513.306312.7119943732212003071.b4-ty@b4>
Date: Tue, 12 May 2026 09:27:45 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Tue, 12 May 2026 01:09:29 -0400, Sungwoo Kim wrote:
> pin_user_pages_fast() can partially succeed and return the number of
> pages that were actually pinned. However, the bio_integrity_map_user()
> does not handle this partial pinning. This leads to a general protection
> fault since bvec_from_pages() dereferences an unpinned page address,
> which is 0.
> 
> To fix this, add a check to verify that all requested memory is pinned.
> If partial pinning occurs, unpin the memory and return -EFAULT.
> 
> [...]

Applied, thanks!

[1/1] block: bio-integrity: Fix null-ptr-deref in bio_integrity_map_user()
      commit: 8582792cf23b3d94674d4d838f7cde9a28d0fcaf

Best regards,
-- 
Jens Axboe



