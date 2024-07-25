Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA60A63C7
	for <linux-block@vger.kernel.org>; Thu, 25 Jul 2024 19:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721937596; cv=none; b=UPo9ChLVucJ5Qkk4x7Ci5m+Vz17D9UJM30iWWSo+VBj6L4YoLeIRLVsfXClPAtVhhwTTqfW2YEFn1d5bAFge/ke6n3NLBCaIQXOAifqlIirVYuNtvD4bGZ7qYZWZwdKpCqmUWBi6bnCQESIvQhvRx9u2J82ip6jcoFGPZf1SVYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721937596; c=relaxed/simple;
	bh=6ZUzZwHdx1h+7YIaHAeHl+LavvOCO8czLFp/Rn64mHg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=R7HBXBdBLj4SE/sHXVa8A820I4yC46YpuTs8032qHUu1/7xSZj1ILewF2rMcUAHYvcTWN7O7SEEezF7ayU2DV5o6wAyNIvukFzxM9zCMdK9n0ZKovMQLxK5tDYT9321n11iCBIh3bD3C22WcsKnMhOsx1YQ0eczoieWOCqug0IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=DiXpuKZ/; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="DiXpuKZ/"
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-81f861f36a8so3438339f.0
        for <linux-block@vger.kernel.org>; Thu, 25 Jul 2024 12:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1721937593; x=1722542393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8XgXgmEtMXg4oQLwkxOMS2HSqq9McBzQIGAGBjn5i0o=;
        b=DiXpuKZ/jmJ8CFXRqq0z5KhjzhH+W3IGdndLAHyKn3/EYSohWks5+Nb4t+VPpfTWJh
         9ctmxEuR/X8ChyEQg1W1w3F2TDAGsjCdwA4/JcgFvvN07Bomo3h3ssLfyCyuyVar/B+5
         fO+ZYiYKtaN9gSuaNI5SBVKgo4+V8Ll9IPTUFnKBOTih0gDxUgw3wnghdorJgPBSGs0Z
         +AOUKpIrjtY5AaLv/Nx/xbGRHpfb0/DMPp9mOononEyUPxl3fmrLX79wq6ru6tGISU4s
         mD2V8G6gyzU+wTL/hcMMI6eqM2rq5pPTclj8fLka/oKaLc5cLERT3z6wbyMLKRMNa4ba
         dw8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721937593; x=1722542393;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8XgXgmEtMXg4oQLwkxOMS2HSqq9McBzQIGAGBjn5i0o=;
        b=Iw90Hai4XHaQR7KyyI/N/xuGLZhpzMHT8dgqv2+9KVGOpYI8+CUAYeCRkEcUPZVXRj
         RFJLOrfRzJo8mKPGY4pyy0K9ZxV0iiSnXiyUFsECWBjNFq1OPlLVZx4CpCN0tnJi8lBN
         dGfwL4LGDSNnOLGtkiz6yGex64TybI77wLOR+oE0mLCQVergRK4qKAVOJvspM6SI1hpg
         qQdKjdXyC3Pqdu5Z+/7mo8CDgbErl3i5mpJueCIjT0SF4iYlXNDqXL0PScXeD72Gb8tW
         N21J9mG+QduBVovW0ulDZ6Gz4acwng+HG6Ef8M0KmauWOvSMGb0qhuMLkZlfwKFs4BQ3
         PfCA==
X-Gm-Message-State: AOJu0YxozAb40Ya+cqYoHSB6nPW8mIn7EGz47RGN1hLVZmHIW2Q1y2rY
	oOmXDPb7GYPnZKCDtlRlXArtPfsBWgJjrSwWHHe0N9U7ETSL4IgrEK/PhYGPZeE=
X-Google-Smtp-Source: AGHT+IF+lE4LX6x0dgB+LLPvr0TYy3W68X/rGR/pknwS8jlOUdzMZKOI1TdeSmQVEohLB0xExWkSHg==
X-Received: by 2002:a92:c54a:0:b0:38e:cdf9:601c with SMTP id e9e14a558f8ab-39a22d4c4bamr24209705ab.5.1721937593023;
        Thu, 25 Jul 2024 12:59:53 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39a231070d3sm8533405ab.84.2024.07.25.12.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 12:59:52 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Josef Bacik <josef@toxicpanda.com>, Wouter Verhelst <w@uter.be>
Cc: linux-block@vger.kernel.org, nbd@other.debian.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240725164536.1275851-1-w@uter.be>
References: <20240725164536.1275851-1-w@uter.be>
Subject: Re: [PATCH] nbd: add support for rotational devices
Message-Id: <172193759229.89672.9311368505409768084.b4-ty@kernel.dk>
Date: Thu, 25 Jul 2024 13:59:52 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1


On Thu, 25 Jul 2024 18:45:36 +0200, Wouter Verhelst wrote:
> The NBD protocol defines the flag NBD_FLAG_ROTATIONAL to flag that the
> export in use should be treated as a rotational device.
> 
> Add support for that flag to the kernel driver.
> 
> 

Applied, thanks!

[1/1] nbd: add support for rotational devices
      commit: 45c7d3321b0ce575705bb62b6069efad48a51d67

Best regards,
-- 
Jens Axboe



