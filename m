Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523EA221FC7
	for <linux-block@vger.kernel.org>; Tue,  9 Sep 2025 16:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757435756; cv=none; b=CE1WFb011RLz/SM070STGPYBqP4PnGLqN9xlUzY+HspLJW+t4u36q3fhbP8QtSwA64fuBPcqgB5YEdxORsAGCdG/x3SESQenTKqbv6/b2JiR5SrHi7xK3FC2Yr5rTSn7czlwU5JILm61aD8+iNW6VUQnGECD6ebWvSIpLEzmLSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757435756; c=relaxed/simple;
	bh=e8WFp1zpZun1HsYZIO7PfQYNNlbDwCYr2GnvTqk6riY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DKE6Tn8OV2yxzEHvpmX9lk3sJpTsN9JcFNOuUjWRLPOdjJ8QT9kGJtwKSZxpknTLxWNJlYBTJI767AAz31Ev3ByaWDWrnwR+ebXkgoOI0SlKHivOQyef1J1L2/QbKS7G4n/n60mVqCdFqLvOjt7YSGuE+V7XYklQHVUHQLMDGnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=n50zlsnl; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="n50zlsnl"
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-88762f20125so458217839f.0
        for <linux-block@vger.kernel.org>; Tue, 09 Sep 2025 09:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1757435753; x=1758040553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EAq7BOyP0B72ZyrsylWLSagzgiFC6B6Gb5G0213Wrro=;
        b=n50zlsnl0GtZDFpxfz0GOSsoSAo3/VL6fH2CDLbUBi27ZoOMkTrh+EHmQkphhG/r/c
         PLuv5dc1x3c3tVFeWw6l6ZZ4DJuBGdZdncK9DriY5mvKsJyIEerqGB3Xt9YXqfx5h3Yt
         qx+AUN7E8G1I2x7G/UDGNT+ms5iPmnDhhR4JNhsgML1EMTdBw+C8RQCxeMC3jCNIK7Yz
         PXUv6R311NjYa0dA2AC787n3Qpqlco2eEKQWlYn+RMeyo96EOOQGc34Hf/zB8bogmsVr
         7SwS8iXVZW4LC8LchvlQtzyHeR3o5xIN4F6oAuzVDHZdich90R1PKiE9/oyvdtmDTL3I
         RIHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757435753; x=1758040553;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EAq7BOyP0B72ZyrsylWLSagzgiFC6B6Gb5G0213Wrro=;
        b=UBnJbr19rqM6cwBodosoyslSNby+De56VOrxGdH8l+Yfloyb4cL1ubxuMYyI7DOEvW
         FT4QiKF1pnTkOL+DgxxiKEJ8dufjxmgCdNpEUGXR6JCiCBdt5VbqBx7nXnZO+yQA+Vdn
         GAcgg+880iLllCkfdEclHr52n41TvMWj5k2S1NdUuIQWKrUXom1iOlKPncF/eyDj7Gi4
         MlD8vUQu38a7YciWBAF3jZMRymRg8Sx6WxuCWZvUSDDBTLmxzxCOKdplTWLNX+4laTv0
         tF3ttzxPAkHkOFYvJf8B2E+1mMqq2zuk1GgKE6OiHXCU8pfpk5aw1lnW58tYVQW4a072
         LDGw==
X-Gm-Message-State: AOJu0YyscFdJNChiIy/bnJ3NQm8lbb1F28srsEKxkxv0h1P/SJOPFtQT
	zlEL5eyUzm/wADaSX2oFbNpKE7SMsrMwmaDlsAsSZZYi2mwrRplBf5IkzZfA8lWXN/Ek1gTOqUM
	qXdIJ
X-Gm-Gg: ASbGncuwTqkc+eBg5BohvpFUlSoveu4x+6Uql5GuXGzh98ShLfoikvQUDIHvuYWojaP
	nEqWx58h+kOcsmXapbOrt28hFQIt6TkGorLU8q5/3UCY+t55Fs76Ob11zkjH+9tXApXUFnY9B6A
	7KzDsA3UkVmXvoOCiSSw+AbfYuq5Y4jQ3jk7vyM/kZpWfkGHfh8XD6nwrSIagItSZ+nvaftLZP0
	70g61t/LEvl9VEYIpzHzhX9Kkug119w4Dc5qfAgL3kmPArDhgCwjKviHORqk8xdOMbjDPx0DZIV
	+hJMIMYRvnkiUDTrShETQV2SdTnMcqMmdommZqppxtybviO/oGZ1qjixGHiVwHIUS+YxRnjYmgb
	tI12cVXUFNLzWig==
X-Google-Smtp-Source: AGHT+IE4StV8pHw158LA69+GRldNKkauD57gep0bmq97NRh7X24SVIdYQpdkULoXIuu/kSDyy40+SQ==
X-Received: by 2002:a92:c24c:0:b0:3e3:f9db:c0f2 with SMTP id e9e14a558f8ab-3fd8e98d19amr216327265ab.10.1757435752165;
        Tue, 09 Sep 2025 09:35:52 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50d8f31cc4esm9921243173.50.2025.09.09.09.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 09:35:51 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Keith Busch <kbusch@meta.com>
Cc: hch@lst.de, leon@kernel.org, Keith Busch <kbusch@kernel.org>
In-Reply-To: <20250903202746.3629381-1-kbusch@meta.com>
References: <20250903202746.3629381-1-kbusch@meta.com>
Subject: Re: [PATCH] blk-map: provide the bdev to bio if one exists
Message-Id: <175743575162.122061.6789614378331426216.b4-ty@kernel.dk>
Date: Tue, 09 Sep 2025 10:35:51 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Wed, 03 Sep 2025 13:27:46 -0700, Keith Busch wrote:
> We can now safely provide a block device when extracting user pages for
> driver and user passthrough commands. Set the bdev so the caller doesn't
> have to do that later. This has an additional  benefit of being able to
> extract P2P pages in the passthrough path.
> 
> 

Applied, thanks!

[1/1] blk-map: provide the bdev to bio if one exists
      commit: d0d1d522316e91f2b935a78bbf962b8e529d8c4f

Best regards,
-- 
Jens Axboe



