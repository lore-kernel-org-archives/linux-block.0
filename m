Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2182749F7
	for <linux-block@vger.kernel.org>; Mon, 14 Apr 2025 14:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744642093; cv=none; b=DFLyQhQ43mu+h/iLoPftq3p64fXU5HBzaqGIKwZo6qcZmWJAHh79zuoahG7Y8v1nfst3s5i6pmvNuu5AjCw/0rHZG2YQEIOb3AUKAq6N4GvaH1svVsCUtou1o2eIZEwJ0fdW2/UjjBe0tmjrzcvKfSoXsl8Lh/bK5pjliXcOfgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744642093; c=relaxed/simple;
	bh=rhMCMHbUjfu25o78Qk0bXpRpxmEMmo84KsOZ4BfvPaU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DWkGTkSC9zoTh8ItO2zwJpkk8m9TospiHYLS2OUfG8jGot22FQ8S77gGQtMYcqcO7W2V/6cFwJFJMUmJ/poCBF+yt3FvrOvLBZ3VTleG0Ik4Rc1gVcWdxTczFquK2Bzr+3S9uTjuivYD1Vhb56eM+lD7L1xpJ0QdtpP4UXJ3eFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=tT8B/kr7; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="tT8B/kr7"
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-85dac9728cdso81526339f.0
        for <linux-block@vger.kernel.org>; Mon, 14 Apr 2025 07:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1744642091; x=1745246891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n9NLOZp+0Nb53rh8qL2R0uTQQrVDxB/y4kuMaCTOR7c=;
        b=tT8B/kr7C9kGzYJyLkTdE8v0pbWdmoya/a1TKYm1+s5zhY5feNjUt3kBkNgJhmjL9Z
         M9KA/yhWP2Xaa8PopnQyrba3Z8aSsBu5iNZiIltwRBgJJ/KU3vPrylIWoJYj4GiMLLZC
         dBrdaX3iieG0fHsN/hf1GkA/oQgc/HHD1F6RvVTCbGQOCLfWhChLp75iZQ9UaT0mSCRg
         CkaBFp2CoxzffjcUg+rVzG+4/i8/3l2DiyxyVmzHCtmH4Z1/xBET3dmyOcJ7QvMxDTR/
         k0Hx92/F2d55YHzJGFZ4vnYyDSFQy3X/8OSgfBdeZoePx7ANie8VPjsER1APaYiSGfFn
         /Gvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744642091; x=1745246891;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n9NLOZp+0Nb53rh8qL2R0uTQQrVDxB/y4kuMaCTOR7c=;
        b=mEm9jLmmi5A/IJKoNvehYyLCGUkvnCaHk1t7WWgSkgzb+fnU4wQGo74ExM/F4rirjc
         q97R7/DIctc2djLAuk/qGmxy+IMBLxPeM5cLKJLWyhuf7Y1k6ZNwRbcxIdL5juSwP4w8
         8sv1gxdh3aH+DJYo+aRX9CVMvtsFp6hwFNnmnbi3497aFYTjJ6D8ot9AExKAB4KEV36d
         pL4kmROOaXztOsPtxxT//5aGmdE6sMQWghwCfbKfTNAZSa0jY8L7e0d1Zk2v6+OQHF4D
         7qVmoZPn3pcJykngwLqUigGSsoXr0HM2d/JUCKeASM+sRtE6dhpxs9p6iYvWg93TfbJR
         dqlA==
X-Gm-Message-State: AOJu0YzSKxnpmiUlseGYuIKoyY0AAo8iXNaCgwoV3E5QGGYR8SVIJvGO
	1Hr8XXQwUHn+VWeJZTICdwBkZLEtAZ3+d0T7deS9OdEfgvtKMG30TNJ2bCVXXq4=
X-Gm-Gg: ASbGncsEutJyd9s8K/XLzdElNSqFtY7skiid2CkbIt3iMeeHaBzs/pF4k++QyJBbeH1
	+PP2LWZM8cYhFJA7AKRY7zQ4xB7vbJjSDCkfN/vPGZcG6eaIc/THOvouyq8bhOWK7/2S6OJ1Hj8
	CH3A5PoedETvJo4rY9L4A6q6oZnArGcdB4KuZGsWRBIfmjONs5OY3nUkXAU+UKq1z9F/g7zYIIm
	rKPmLFPaWrjoDpX/NEoIrEdg2OUm6rlLMrK7mCz93R6IvCHxeXrNxbbr+ELHKDxRxU5iIdzrZnP
	uEKzuCFkOxmhNxcT0NW4JMQake4gYYev
X-Google-Smtp-Source: AGHT+IGPfM+faRGObScSF9y3uJ9gSmNmLDppjIkdwVGlwIxx/VnPJwjYYyDuKqqfztkP+4WddDe9ag==
X-Received: by 2002:a05:6602:2b96:b0:861:7237:9021 with SMTP id ca18e2360f4ac-8617cb46848mr1354025639f.3.1744642091087;
        Mon, 14 Apr 2025 07:48:11 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f505e6bd7bsm2569671173.141.2025.04.14.07.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 07:48:10 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: "Bird, Tim" <Tim.Bird@sony.com>
Cc: linux-block@vger.kernel.org, linux-spdx@vger.kernel.org, 
 LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <MW5PR13MB5632EE4645BCA24ED111EC0EFDB62@MW5PR13MB5632.namprd13.prod.outlook.com>
References: <MW5PR13MB5632EE4645BCA24ED111EC0EFDB62@MW5PR13MB5632.namprd13.prod.outlook.com>
Subject: Re: [PATCH] block: add SPDX header line to blk-throttle.h
Message-Id: <174464208984.57766.7624425408061189714.b4-ty@kernel.dk>
Date: Mon, 14 Apr 2025 08:48:09 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Fri, 11 Apr 2025 19:20:18 +0000, Bird, Tim wrote:
> Add an SPDX license identifier line to blk-throttle.h
> 
> Use 'GPL-2.0' as the identifier, since blk-throttle.c uses
> that, and blk.h (from which some material was copied when
> blk-throttle.h was created) also uses that identifier.
> 
> 
> [...]

Applied, thanks!

[1/1] block: add SPDX header line to blk-throttle.h
      commit: 1b4194053f6b30556272ff11750dd518e067ea49

Best regards,
-- 
Jens Axboe



