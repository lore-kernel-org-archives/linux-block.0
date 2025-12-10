Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324B426C3BE
	for <linux-block@vger.kernel.org>; Wed, 10 Dec 2025 20:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765399300; cv=none; b=mbWqs3acIYXwaKDwLftKlA/f7hbrViOrowNTIFecuSPEgKCKTR9IrNtlTrylkBb2F5RoQ17/h0LEy+k796lkcgVJfBNb2jYrYahfscj6AjJwGy6ZlfwJeQTFkfT9L7hXlfMxPdMVq3vXqRLOuK0CSplotVxajQkEleS5Cdnwlos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765399300; c=relaxed/simple;
	bh=sk0inF3TT5rkOv56c/aY7jTEq6K9Zzw6dmBQXXjAhXQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=oH57ESppvoRD7xzK0XWU7sGPrhjTcGak3F7T8q2av38hBZD57LGN8hvnnaoXavgrIk96orRcSEiRld8a10yV1QEZTCDLaGXBPhfIm2YmJUc87uZpDP3aS1V9aYjtsLYcJ6QqK2qpol7Mt2glPVV3CjaPD0XMz2hLkvMPoxsfVYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=292sQVYm; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="292sQVYm"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-298287a26c3so3821545ad.0
        for <linux-block@vger.kernel.org>; Wed, 10 Dec 2025 12:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1765399296; x=1766004096; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UGvobYMEj5/vTe98MvaWBJhqeKtKkbI1++KlBvBD0tE=;
        b=292sQVYmq65QciHoITWBQbHTZs4xzAou3r5m9XBk/tOOY3OhNcACO02FcnzEpWhbcS
         vTBic0INe14Dz69+HC4YY1jl8v3cFWpnRuzzY0LdSwXZwGel8J4+WzR/Bp7N/0ngeKiO
         pHPvfTAkEhbA9ef3ZiMXdDpUFFzMBTpBww22XLCu5MKJ4ZgRCwS6ivhfSJb9E9pKjcVS
         Uc9DljemUeZptxffD5K5Q+mdGJCR2+EOYIUVDbGVPJScGc3QTMG1XzS/6uTcoQZcrK35
         RtCZeT07WKlD2uNBB2IWeipvWgnJkGSGqzMimWQbllbDZNj26SrsxWD1s8VI2kBebRUk
         iN9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765399296; x=1766004096;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UGvobYMEj5/vTe98MvaWBJhqeKtKkbI1++KlBvBD0tE=;
        b=pdOyzz5lY7Dp/m5cjx1YI1bWDSv76131ikOoNV9Fcoc/xZDoqmgESolaV8rhFBLSAK
         QBEC21+t/yYMwUGUo7imnf86KZMZvVin/gfznGyJyFadWJae6Nki5Pmua1kw5m4Slm2F
         +AwP9PMwDu06NZUzFiIFQVRb+XDev16JfReRz8q1CO1OGw4N4RQpWxgB/xovm+nfYhM6
         gQXbjSg4Z7Uymlx1cG9GmrNcIMRwCpV2Yi2XXdboPVWN+6s3t2/trx3llScD/GXO3Rsy
         /9Lq/veT2GtVzbo3Ex3h3pFsgEgs6KaRDMnXAr6/NNIcfS4qHU/mLMxC6WywazyTaEgt
         Pa1g==
X-Gm-Message-State: AOJu0YxRDavG3iP/vQHX1DDOVpex0zZN8N0CuaC/WyDh+WsvesFwib78
	maBZDrqGPzJTPcZPD/XbrEybIYuT31w+GH5NpC5pvgI3/+58H5i6Qk7v1h/2K5Y37jsjnPwe+Fr
	9vBSf9YSOyQ==
X-Gm-Gg: ASbGnctreJjHM928a1+Z/+Kc2knBopTSYdW1IiIlfDoHqMEwWWjjcobM/zTB0iyyRiu
	ygFih4Kj1sbOBFsqjsq7KipEZol464LgUQ4ZmoeQ00IsrvqZ9yOmfUYeNFX5l/cLIn7YYtC2PeI
	6GxfLPXOyXWBZ54QAnmgCA72mEoH/zOZKGTO42ZE5IL7qRNi4ekRA7cFJJ/llvGvVMMMETtYPnS
	PRIEhXzL0lUZPsQ10sdJ0Ygxe+DG2lmPdMRVx5bZIg44SJtFyC58yc7Jk4R+fV4f4vxpxEWKqEk
	tYMIhMVQ6P868VyiztVEM5MKSa9wQih6T9e2EHN5/lCy9EbiTYPeCCC7978y0vPYfyUZI7gc4x4
	Ku9J2qtbx4SqCMaRpYgmXL++MH2sRlHTSiWcfEw9yXzdrplSJNq+Fn7tpI9dEljIlJ4LRFPGVeY
	QOKyxp/N4QTIMNY1VwCK5yK/J94px+6eqF+l5ZKJU4tKORJQ==
X-Google-Smtp-Source: AGHT+IFGPNHi70bZ7J1MYymzy2OdDGFJlcxdz7G3IccZ+Xyn4VxLBT2gWZWOrLOfpKwuY7X7M93gww==
X-Received: by 2002:a05:7022:7a0:b0:11b:82b8:40ae with SMTP id a92af1059eb24-11f2967d57fmr3021261c88.18.1765399295866;
        Wed, 10 Dec 2025 12:41:35 -0800 (PST)
Received: from [127.0.0.1] (221x255x142x61.ap221.ftth.ucom.ne.jp. [221.255.142.61])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11f2e2ffac2sm1394404c88.11.2025.12.10.12.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 12:41:34 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, hch@lst.de, Keith Busch <kbusch@meta.com>
Cc: Keith Busch <kbusch@kernel.org>, Sebastian Ott <sebott@redhat.com>
In-Reply-To: <20251210104346.379106-1-kbusch@meta.com>
References: <20251210104346.379106-1-kbusch@meta.com>
Subject: Re: [PATCHv2] blk-mq-dma: always initialize dma state
Message-Id: <176539929376.462101.12821025290492029343.b4-ty@kernel.dk>
Date: Wed, 10 Dec 2025 13:41:33 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Wed, 10 Dec 2025 02:43:46 -0800, Keith Busch wrote:
> Ensure the dma state is initialized when we're not using the contiguous
> iova, otherwise the caller may be using a stale state from a previous
> request that could use the coalesed iova allocation.
> 
> 

Applied, thanks!

[1/1] blk-mq-dma: always initialize dma state
      commit: a0750fae73c55112ea11a4867bee40f11e679405

Best regards,
-- 
Jens Axboe



