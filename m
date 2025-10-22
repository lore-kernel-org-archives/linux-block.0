Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6012935BDA4
	for <linux-block@vger.kernel.org>; Wed, 22 Oct 2025 16:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761149010; cv=none; b=OAqkvoCnc3PbTCh8dhc0R4CeIOi7A1uG4b1z5FC0ZbZFzRKoVsRJokaodhAlx4BQSsfi7C83Y7D8BRXfJ02AtSizlICBsCD+B+XDwB6K8JsrhT873AxNfs091jji0eJsDhuUJ8LGv+w2LRHotlWINGiNjv/+3bB8e4PAJJ8DWxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761149010; c=relaxed/simple;
	bh=bBPxVcBRCesceVuGcEuyzrUztLljBOYrXae9XUuSqYc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hvloHkSKH3HKivXghdtrXFzOrd6Ejo4UqC8dc38tLsbmfRxUTSD3jccDIq1G5tw/uJIjgz3D7Yv7Y4wztr/+rWRg0/gtuml4M90/IDyjmo228Nyhg+saA6w2TseTolayd+Q9lO/uVacHt5UAwTqWdkz0w/bBV8JUpmGC31x3ZJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=IhO73xaS; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="IhO73xaS"
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-93ba2eb817aso650186539f.2
        for <linux-block@vger.kernel.org>; Wed, 22 Oct 2025 09:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1761149005; x=1761753805; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jhSZM1/vLiz3cxCchmWfhisjGD0QMNUM1RPiG1hnMd8=;
        b=IhO73xaSotw0IQgHjf4Uqxoc+HuoRwxZhr3Vz6fmSbuVwkXq5ulfimJlnq/VidASQb
         lbidKOfB1I0YHVt24KN/SzIRwansE9mNU1LRLcRl8VyLhQITbITXBhp7VhM9B8A4bH7J
         Oc6vq3JQVFqd+YjusET5O1OnoW4uimEcyZzUl93P5O4j1Jns4RtOyH91Nhz+7/jNc9Dm
         8aDs4UbnEqpZxHNXjQxIlzrUG4IcagDFA+yrD96TRzud7Utqz4XejddTqXOeCllY1OSo
         smINAdDX2imPJC6GlGuC8k+eFIAH/HlmetFFEuuSlC4nr+ZY6ApHhfnzV97Zz6yH+p7V
         JETw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761149005; x=1761753805;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jhSZM1/vLiz3cxCchmWfhisjGD0QMNUM1RPiG1hnMd8=;
        b=SQp0AiHdP+NFcEDMTJC8zpqdBsFjDoKfCj/HPtrJSRMOzWwg8abJCdfenIf223WLBk
         rpMabHeeKpTH3NEtQKX4ZOPmnFpt8j3v7/SknDykXue6hESrV3pTq4KfXq1VFe9UoFHd
         3G5guio6xTQJGtkpulgDsumHthjj0XlPKkxsqrTfDXE6jqL6ZnNxtDzZENbR5QJQYvGN
         5DxRI2bfYf1l6sAFolNe0RK3uAPH75wrWtWvkew1F5HH6z4Nus0uF8CCC5emWRxoMK9l
         jHGH8Ba607tY/FXw//NMl/Pd6yPTR2Hm9szt/0MrMQCiLy2gD0y3GcuTXxh+7+3PZuQ9
         5Hnw==
X-Forwarded-Encrypted: i=1; AJvYcCVSkQ0RbjURvJoF58vTguh4LPnR/OtvM6uzXVin0UgQ5y8aEfwE7E+xAUrpP0JVXPv8ngacW8N8tZymxQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyR3dW2e9yADtjN0eaq7JJI5bT+mNAgptry4O+Cow4dlyOImJA2
	sv2JV7bKT5i9NuwI/suZC+pve8Az531ZBbfIasUe9oGuQIb6jTu7/MQTDojAlYJAHf8=
X-Gm-Gg: ASbGncuJdPv74xD6TfThOHYnHf/PpQbKxc6saG9DV3AoMCi0x4wHv15U0H45tTwyS84
	RfQuq2+tBM5GOfGY2pO1d9xwNSnrVXOQJGFvBEWhSSe5TOJHMtm+T6KjyzYLtLih5TcUmlfo/cX
	//YQVGZ+0Vkz5eHK1/aJNumdCiBsePFWWm7ERRZpirMV4mpkR5u2tE09Ag6L6tufPlhfimtzCpX
	4VrRPv/0NayuMbv/ruvrIX1bKSIWzbFwOlyArciLmMAys3pZhJpioFPVjvikCowBKI6Q9RHCRcI
	KRQny1cl66MflrJfZv6byjlrhuquY88OZI3NEVnoqvRvFduElNrMD3NT/rJkgR3waDa72Bm2+j1
	f95neGpL06K3ir723OTau1GJ3kCiCXSSiugHsEJo2tPJrwBmf0M/UX/lBgqK2djoKNnEfQV+mUm
	Eglg==
X-Google-Smtp-Source: AGHT+IGDS1qDXS72ygU1x4nQo6n5rSbuTxOgyC8ri16Y8/EbAtIaLVkwbWsOzcwbBHd6YU/L4bPvIw==
X-Received: by 2002:a05:6e02:3e06:b0:430:9f96:23c7 with SMTP id e9e14a558f8ab-430c524fcd9mr295344855ab.4.1761149005090;
        Wed, 22 Oct 2025 09:03:25 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5a8a97699f4sm5252380173.51.2025.10.22.09.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 09:03:24 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, linux-block@vger.kernel.org, 
 martin.petersen@oracle.com
In-Reply-To: <20251022083335.2147105-1-hch@lst.de>
References: <20251022083335.2147105-1-hch@lst.de>
Subject: Re: [PATCH] block: require LBA dma_alignment when using PI
Message-Id: <176114900405.64630.14310909276445856638.b4-ty@kernel.dk>
Date: Wed, 22 Oct 2025 10:03:24 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Wed, 22 Oct 2025 10:33:31 +0200, Christoph Hellwig wrote:
> The block layer PI generation / verification code expects the bio_vecs
> to have at least LBA size (or more correctly integrity internal)
> granularity.  With the direct I/O alignment relaxation in 2022, user
> space can now feed bios with less alignment than that, leading to
> scribbling outside the PI buffers.  Apparently this wasn't noticed so far
> because none of the tests generate such buffers, but since 851c4c96db00
> ("xfs: implement XFS_IOC_DIOINFO in terms of vfs_getattr"), xfstests
> generic/013 by default generates such I/O now that the relaxed alignment
> is advertised by the XFS_IOC_DIOINFO ioctl.
> 
> [...]

Applied, thanks!

[1/1] block: require LBA dma_alignment when using PI
      commit: 4c8cf6bd28d6fea23819f082ddc8063fd6fa963a

Best regards,
-- 
Jens Axboe



