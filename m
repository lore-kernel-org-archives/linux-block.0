Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3033A7856
	for <linux-block@vger.kernel.org>; Tue,  3 Feb 2026 14:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770128320; cv=none; b=Udcyw1zaZh5kF2fiHGIEfbtU4tkhrcReaLvPSV/ZBy1wYS1h+segOfHJEdZcVXU8lm8HPZNc/gRG13DLIPXH8jnEy1UlRtWq90y88WK2SPl04yylUUREO+AaSsUj4U7BUFzu3JHo4SqjKhJ7pBhEUdNGaToSSbkla4i5sjmhtsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770128320; c=relaxed/simple;
	bh=1uWujhp4OKzaSmQ2LqaMBJKRpCeeqp9vOdw3Mry4Y60=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=S8SHIvIk4A8DzD8hdArhr35fQFSBwW8cxBKu1XLmaJQ+jOIoC0tJbo7OWo212OxYcRBOK5GY2BxLYgE/83NYUMaCzrnDsUifeeZHP28qcn+3RgXAQatodIJhGY33pejFgGcC+uPRLc2ND8YV4pQL7F4iah+gkorFaS6pnH8Ou94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=FeEw7MUg; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="FeEw7MUg"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-45c89d754dfso1868807b6e.1
        for <linux-block@vger.kernel.org>; Tue, 03 Feb 2026 06:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1770128315; x=1770733115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZC+XSu38R4WdHDaMJVbXUDYtnPmIyeyVit0MwU6HHhs=;
        b=FeEw7MUgPX76y6ykKJVaB4EZHhwxwfIan6+Y37lbToSjLASwTuASRvTk1yI5ah66qv
         Lpyye70thLwmMGlxhkH3jVaDW47++ivbI6/+jVn/Iv/hwy+l5eZs3nIp5AF+VRC4A6lp
         a68Acw2gwWgXBKkM9FL04DDTTnVPkurbh8gKDutuSGR9fliOFx6vU0i2OsRfx6VwKLp/
         ZI1ZRHdMSFm5QtnCxkfo3kq2RZUtgs9Aytc9+gRP6cvSEQXRpI9zAxudpbun4Q6jiOWa
         ZQllmrG1S3vlTZbue0gybuJQ0kFGPQDdte90u2Tb1YfJV1QD11cnUv1Aes4wbybphI+k
         sHJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770128315; x=1770733115;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZC+XSu38R4WdHDaMJVbXUDYtnPmIyeyVit0MwU6HHhs=;
        b=dryaC/zjwqIXa7Jcr7QdryTAUxDElyjgn8HzybQuWMKHL3ZBXRhaT7sEF2EfUHormh
         HDsPcQ6CkvI+mQaE6FQdGTIwyAH/Xj/TGfWcNHiyHJZ8sUUu07qjSonGlWhTWX1/kjzH
         Gm+2HOB3DxlAvxeXdLj99A6H6Ya7d6ir5D61UjLQatWdM5ik8qeq142E6Th2k1WUuTFu
         fZOPmhc+a6UAaCvGnLtM4Il9GSGjg1zk+kwzXTqFTAzZeSU+/xU0J1+7r9XhCn/vEM5Z
         WybQT5Ea65LM15J57HRzhLDVd4keUqCWv7MAlELMVOsvYpuq7FgACqDNfvno2uRYoIvB
         9WTg==
X-Gm-Message-State: AOJu0YxudBV15rPIiGCq5+RIY81xc7x5X9hAOk/CVufN2xFZBxhccnur
	c5cDAlQ+xnBPHgL/26Bc23Zd/YMsoHkoOBh3WYzNMj383IfJ86HJvjRsp7XTkjypotjx9tMiKxE
	s/aY4r4E=
X-Gm-Gg: AZuq6aJSnbPzEP2Btre6/1EUflbUeWS7i7Q5WliwOrykesKnqxdzAi7cXRtmm/mb1lI
	tzkOVq1wGtPz8colstYqH+HCQdGE7xTbfpTSN0kBYlh6NhQ2MYN4JTyH0DEGTN2cCtWTDXvKACi
	Xe2Pi9lDLxgfdkcS1sy9q8WbtA4b+P4gVCjl0jg0n2dFm1trfiMDhj4DxN8ybdIazXhozh5a8y8
	c5wK7iLtspxXPGSR1nuJJ2KrsVuDVrU1mj4PIKoFr3AOYR7L2V0UL3WossYEaAADMBGNWyqisux
	sEw4RBDMbCtALk0ZLG4xAW8Nd6NGPE+UDFF9FxGOzz8gbox7rroGusdoyqPPjT7vGKDDpLOhMnJ
	PjRkA5lNXwx8LSNaKl+gwQQAz1ko4dlti7fpo1l/cTYEieaT5oISw/o6gfKZ2olbv+SR42cA3du
	SFyfpb5JaFjmOEx/sGk6x5uqHRTTZHBzyD0aehLQdurTFDLhaOyIeTv6GLNmepq6HT
X-Received: by 2002:a05:6808:120c:b0:45e:e21f:bbb2 with SMTP id 5614622812f47-45f34d207f2mr7078557b6e.49.1770128315143;
        Tue, 03 Feb 2026 06:18:35 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-462cb7ca939sm611916b6e.9.2026.02.03.06.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 06:18:34 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>, 
 kernel test robot <lkp@intel.com>, Dan Carpenter <dan.carpenter@linaro.org>
In-Reply-To: <20260203113528.1669120-1-johannes.thumshirn@wdc.com>
References: <20260203113528.1669120-1-johannes.thumshirn@wdc.com>
Subject: Re: [PATCH] block: don't use strcpy to copy blockdev name
Message-Id: <177012831387.1184270.11312215798641150425.b4-ty@kernel.dk>
Date: Tue, 03 Feb 2026 07:18:33 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Tue, 03 Feb 2026 12:35:28 +0100, Johannes Thumshirn wrote:
> 0-day bot flagged the use of strcpy() in blk_trace_setup(), because the
> source buffer can theoretically be bigger than the destination buffer.
> 
> While none of the current callers pass a string bigger than
> BLKTRACE_BDEV_SIZE, use strscpy() to prevent eventual future misuse and
> silence the checker warnings.
> 
> [...]

Applied, thanks!

[1/1] block: don't use strcpy to copy blockdev name
      commit: ee4784a83fb21a2d16ebfdf8877fa6f6a1129150

Best regards,
-- 
Jens Axboe



