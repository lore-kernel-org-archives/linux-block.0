Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E3A23A0E7
	for <linux-block@vger.kernel.org>; Mon, 13 Jan 2025 14:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736779661; cv=none; b=JuA/Qn3swF0CQ99SId4Dv3Bl7YUKe9i7ZjdZc9ALN4LVGBpytKHH8+Yr6j4eZYd6vY5mI+oZz7HCnUyPMftdIbr1VLJl/SZksC4pBMnwXezRcwivFxICAx6PXDwLUOJ29K+eUxrfocoAaRL42zKGpwrhWG7z7ap7rWcEKpGxNjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736779661; c=relaxed/simple;
	bh=w3xFV48L7K6Gx1qvRlknzOzse/4GL+sC+J61jzHFXVU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=RNMzKRu807pXKgC3XJfyFpLcbREMZl+2NAMC51uDMNL7l6x6Eon1vHh2EvFO8wOSLC/4XUPUoK6UyPO2bemYjCoByfxNb8yyzA408Z4zcK1wSiR/GU/FKXZ70II0xeYchjyMNhiHhkl1yKR2n0DGN/c2/KVp+oVqxNzz1QGte40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=BIUexG3D; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="BIUexG3D"
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-844d7f81dd1so158040539f.2
        for <linux-block@vger.kernel.org>; Mon, 13 Jan 2025 06:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1736779659; x=1737384459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o62hMA98/bRxM6fdmM7b38fy78anUvDPQ8PqFAsKK88=;
        b=BIUexG3DDdpsd5GT24rLOi46CIvcQLxQ+EBFNCbCnqLm725BDAIKVsIe2UmvZYI7TW
         rGf/jofq4RA7hGkqpCgYBTZwGOf3siUb8MUkrIaet7gEtycwdHfVk2RZjzCqf09UjDBE
         9FcRpq6+ta954/kP6kxiGGjdSLyZJySHWFdFSyW0M9CXCSOpORX3gmhS2aPkG3tjrVWh
         Jhf/RgRFJwVZ/yjxeAQejPH1bOOYfpNMh0FtVTG5aIm4pE6HzbPZi0c7j4iSM+qFUPPT
         kolcwB58EFeu2tiBlBXLo3++VsqWPf9ZXtVjq17Tpj/xq8ZJSMZ+qVUU3FaMVCQ7D71+
         VmIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736779659; x=1737384459;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o62hMA98/bRxM6fdmM7b38fy78anUvDPQ8PqFAsKK88=;
        b=lzAR0TBICLtWav1pdd0c13UAIN2fles7y+rgo2NP10/MAGPtSo/A5cf8b0gwY42jVG
         ZghvcM8fEmxCm3rzr7itkPnkYY3QVntDLe7xdkA/wRbq/L0KNZazocwYXqRqDvywMszD
         liV2buX9eaISccQnBd24DYb7GTyn4HWX+lpghLo2mrTmXSxiBIjLpUis6I3yzMfpP/jt
         VZbMtVVIkwl+FdZnMCdeBAtlNzaIEjwhvVJPGNheYE9pQSo3mq0UvFeIDn+Agsk2mbyK
         RivFedBayHgdktTzbSJ+nRTgCXxZecZggMU5GmMkqEaHfpAG1GggFtyic5n7bhwcEBW6
         Xatg==
X-Gm-Message-State: AOJu0YwwngopBeoqkvenINUng9JIi5W5mPpXzXqjpfkLf42x6cOAkYRN
	xfMlRguKG+qLGON0WwwjbAEoOG8jUl1y7QZyWri8nSt4NJPcFUxeqhu34rRBhjI=
X-Gm-Gg: ASbGncuBNe7ViL2AVmnN3Rs8n1duPRNseeyhYJ2kW3snTpIIhrO2ygLVcsqYRhnf54E
	jxENW6FuJsGxMJ8Uae+4K7iWiBZ/y42Q8Xjzv9HB/SSZTgMwDFbIi6SL6zqBq10ELiDipMUrWl8
	Sk1qlnBVDwdhYVuN2Ws3GahcqHYFrpFry+CCPQY5JSkiDZwQrn3IfkIjekcxIGxMQzQ3OMqFQ6x
	vY7bvewps+EED4fV4+vZ4OcVtv6MnpXnvxPpy2roDW4D6I=
X-Google-Smtp-Source: AGHT+IEhVcmz2FEH54p4MZ54Eyi46I1ThIv1W3jOEvT3NqBJ8E8cO001T+ALkmYH/dwGreT7/eefLA==
X-Received: by 2002:a05:6e02:18cc:b0:3ce:6628:3e0 with SMTP id e9e14a558f8ab-3ce662805eemr45446365ab.17.1736779659535;
        Mon, 13 Jan 2025 06:47:39 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ea1b7459e9sm2768810173.118.2025.01.13.06.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 06:47:38 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc: "Richard Russon (FlatCap)" <ldm@flatcap.org>, 
 linux-ntfs-dev@lists.sourceforge.net
In-Reply-To: <20250111062758.910458-1-rdunlap@infradead.org>
References: <20250111062758.910458-1-rdunlap@infradead.org>
Subject: Re: [PATCH] partitions: ldm: remove the initial kernel-doc
 notation
Message-Id: <173677965850.1125204.10539957651432273035.b4-ty@kernel.dk>
Date: Mon, 13 Jan 2025 07:47:38 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-14bd6


On Fri, 10 Jan 2025 22:27:58 -0800, Randy Dunlap wrote:
> Remove the file's first comment describing what the file is.
> This comment is not in kernel-doc format so it causes a kernel-doc
> warning.
> 
> ldm.h:13: warning: expecting prototype for ldm(). Prototype was for _FS_PT_LDM_H_() instead
> 
> 
> [...]

Applied, thanks!

[1/1] partitions: ldm: remove the initial kernel-doc notation
      commit: e494e451611a3de6ae95f99e8339210c157d70fb

Best regards,
-- 
Jens Axboe



