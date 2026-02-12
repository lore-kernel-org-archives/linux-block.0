Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C30344DBD
	for <linux-block@vger.kernel.org>; Thu, 12 Feb 2026 11:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770895626; cv=none; b=p3N6zMCC08Iklc7cvRx7Ocolati6teuQKA6MfM9AxGXnWQSvtKxDET44oFgk3CSXQ66uavWQKoAsyOY2G4P9fLNml5/7h5iT1iKEEPzwdo63m4UNYxIsCIgAPfBcFBZKDiEbxQV796VojFhII5mxF2trradz0dY4dIC1YqsY9ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770895626; c=relaxed/simple;
	bh=nxICyZU1wgNIu5RISxj1r4lhTVSe59gBP0YmuRamuG0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=WmVIugB2kgj1oZfUHu+q3pDuVw/9Wh1UGrnNKtmrcN28TjGmeuj1TnhdEnUZ3BUF9ZEWcGaydHw3Xo9dm/M4ao4qkJXBVSnZNFqgdMHIcW0Ubj9ZxHN/YpKaO101NCbzjj6NUa5IItT2Q3cc8gV7drVJNQXYd76gzMJX2uHhiDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=s8t/rrpa; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="s8t/rrpa"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-3f9ebb269c3so3710691fac.3
        for <linux-block@vger.kernel.org>; Thu, 12 Feb 2026 03:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1770895623; x=1771500423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YegwS+vcYqNhlTUWcwc2C1VZhVLLhhyb0SoJW62okgc=;
        b=s8t/rrpaSEWqoBhyG7FzTP44zudsoAFU2Ffg4GasbNyBJMfrbcs4Wz39gU+wq9Swr9
         Mq92gGnzUoX2r6F3D3wqTSCSOvLfMSquG2jrmel37L2BXugSOx1PwJ/oI87o6g+XQ6Z1
         CFaTHK/QuU8Rc1ysuJCm9uDEknS3OIrO15PJFderGVg/+dZ/cO+oiKbKmt2Pc0baiEdr
         BLG0LoTT2x8NacugCImFwtC/OigzWUq33Evc2TzOYKx5E+1/j42s9CfGj48jmMmsi3Se
         qi8H5wi4JVRQhBADBwLTm6jm/uFkJaeo5KqNd3QcbuIWVNpAE6TbEDdCufN8cTtMWvA8
         6Y+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770895623; x=1771500423;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YegwS+vcYqNhlTUWcwc2C1VZhVLLhhyb0SoJW62okgc=;
        b=JIFrhz8Bqa/qApjlCkFfqRACfjqi2F31IfouvEhWkehUdmwtsyaFKnM7sfXRovA/uG
         FxAq8YiyKzf1xMnW4GLlSMuFO80hAhLIHZS05Tk5nIirq2GLIH8C5xtofuxajM3MV/MW
         WOKZf22p89PNWyfskbGZqRNR5ZxMeVKvnUOqnBXXkrn0abZ+LL7dXnk4X1+HCSWh21Gv
         w1M11WJTgKItIs0mLUcSHRTGNef1vJ03Ug40ZV7bTqwnxizP76ZlWO1ySkdtPpjW6ZdW
         fx2Aodr6NGvt2kS1DjWdN0xOiRcJGNrBJ4V5/G06C5mM8UY4onxNXhPEOQ/uDIY0ERuo
         MAMA==
X-Forwarded-Encrypted: i=1; AJvYcCU4ly9RJupQs9fngKRnaWanrk/rGWrabhvA2wjGgKLZoZCjrplW6eIHZvMMfw6X97umrKllzVQ7Lb6pjA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyzXt934Tbcx9ir9UxN2EfmE2Bshv1z8HUe5MafmkZDOZmbd8Z+
	lj3t7EDzoeZfiE9vsWtwujJEmB8uZnPBelFv622XuqPHa0uIz7tMN0ulD3ShWtWwAXlcL+ppj/n
	YT1pvwBI=
X-Gm-Gg: AZuq6aKkkuR4NWi66pEpgGm7cE2302CUg7vGzGxK7nQHtG0C/OPbFVFB5Tb4bGmYmmC
	4I6M5ns7WEnE6Lvm6dhGQH3ru6HhCHTVTYZxWpKjqM5sKKfbsLEpoeu+DTHQYLAWZoB5ZjZjQLW
	9vTn64ORM4rlSxN8f9UI2yrxtt7sZTIiaGLtx1dLkl2rBrop0NOCyXuHbNmeTt8nvbXAc8hQZhW
	voiAxdzgpgBB3qCQL0VBtFHjKXEO/J18/lW539OLv30nFKNjrXSVEFMwXY+g+tKJ3w+yqXYz9Ax
	8yYRs7k2PG2L4lhtxZc7sdIYesIQ1WiUKI8jzfE6Hxicm4mv2hMD/LNFiCbV9Rp6DeioXLtIImV
	gQDg58VFzIDlNNNtDYNW2RpBtAWmTYLOr483givw4CBnZkZRu7GcDMPmpXmxwTF8/SITwN3LiEU
	CaDcV119KZQzzjJzBSLDEFVxnOalydknnBPxwYxqKC7Gn1DeN5mzbs9lyd2lVc3kGa0svUTIq/o
	cAH
X-Received: by 2002:a05:6820:488d:b0:663:b86:498 with SMTP id 006d021491bc7-67598f11c93mr824720eaf.33.1770895623313;
        Thu, 12 Feb 2026 03:27:03 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6747293e4c2sm2232685eaf.2.2026.02.12.03.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 03:27:02 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: hch@lst.de, Chaitanya Kulkarni <kch@nvidia.com>
Cc: leon@kernel.org, linux-block@vger.kernel.org
In-Reply-To: <20260211204944.23380-1-kch@nvidia.com>
References: <20260211204944.23380-1-kch@nvidia.com>
Subject: Re: [PATCH] block: fix partial IOVA mapping cleanup in
 blk_rq_dma_map_iova
Message-Id: <177089562181.419890.6714791921040415886.b4-ty@kernel.dk>
Date: Thu, 12 Feb 2026 04:27:01 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Wed, 11 Feb 2026 12:49:44 -0800, Chaitanya Kulkarni wrote:
> When dma_iova_link() fails partway through mapping a request's bvec
> list, the function breaks out of the loop without cleaning up
> already mapped segments. Similarly, if dma_iova_sync() fails after
> linking all segments, no cleanup is performed.
> 
> This leaves partial IOVA mappings in place. The completion path
> attempts to unmap the full expected size via dma_iova_destroy() or
> nvme_unmap_data(), but only a partial size was actually mapped,
> leading to incorrect unmap operations.
> 
> [...]

Applied, thanks!

[1/1] block: fix partial IOVA mapping cleanup in blk_rq_dma_map_iova
      commit: 81e7223b1a2d63b655ee72577c8579f968d037e3

Best regards,
-- 
Jens Axboe



