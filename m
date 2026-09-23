Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691A949A3CD
	for <linux-block@vger.kernel.org>; Wed, 23 Sep 2026 11:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790162436; cv=none; b=ngL43d0cQk9ss05ZT7sLUuQfdcQq5VTy04JWy1FWGOaV9YvokBHpjeyJBPclucVfhzz1yXOe8Etm75CcKyJFZsY8VNz5ooEusaS2Ggp99syNkJ0cnBh677uLMHCnhdjT3N7mYDV4Fse/qsuibJF7M831e3SmMNLk0YYrdhwm+is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790162436; c=relaxed/simple;
	bh=/s6S8jqT9hYqbZUp1KqE3phwiuZASgDS1vKv5d3sCfA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=RjUAoNXEeUDrKC9CvkCKfvic50zzTH49dItFx7Vw5IuUWGgseHx3g1Nu3aL8INF7l7SesyXRA0SJFZbe64udrSXMbQ+FiSSLFgmC253DwEuVCz3mtNayLvcj58MKmUJOXNKkb7n71GkoPAlc0sUMs3x6sol9dwcxAkbrJwItGGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=RQlYf2eV; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="RQlYf2eV"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-33bb1a50f6fso318344eec.2
        for <linux-block@vger.kernel.org>; Wed, 23 Sep 2026 04:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1790162433; x=1790767233; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I3X2EnOUI+n8VlfiKlh3vGXR+bQV1stTFKryFjCDnBE=;
        b=RQlYf2eVbgKD3s+K39WNX+qObnkLLQdbZQ0r+LHNe6MN1zRinYoOrZEs1KL4gODrWo
         YcEw8UzKOEWDGgCADAm+zE4SV4EXmREClnWVOagfrHNR+Zni6QXVOdpWqpim1Q/qz+gn
         XCrcWR/IaQizBOkUSc9bUEYOnr3PdExWbmTBpCigh3WQoosG+58UgTjUao4gXi0wS5By
         z/qX2hjBzf5GpKGyjpBG6nGVaDhhDmrSk1ho1RlR9ccOP/xBEc6snDcjZ74ACTmF6ty1
         aRk/iQ0vQ7GgHLy6BWLQ8WUDpAg7DngBL/B+6jZTWL6xOOGuNjhXUsBXWOq8tEwC2Xls
         89Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790162433; x=1790767233;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I3X2EnOUI+n8VlfiKlh3vGXR+bQV1stTFKryFjCDnBE=;
        b=cNeZ/ZfZal+dTscR2vU+lmBPFZxeO776L2tm3dazBEiw3l/IeVc0xLCT1EJuXcGT++
         3gp9I4THjoV0pS7cmfhrb1saY29+NcprBvKVludBk66TofOokkOq732npDIoMa1GerYl
         p/9Hcv0FT98abBE3wBvApOY68lF4wSibVqXCUlUOVmu0Gk/AkEy21xByLxalbmPOkIYt
         hn3BaDpx/T6PHAuqlYPyKB1NVGFIKPG40xw3gr/h2EtJPEfW74RzEHGr6btVX6AC6uX7
         343MFWQ3qcypchDbd5RgDgEV3/jTvXeu3XgSHnOj0+NbLx0OMwKVss+jwc40Lg6tLhR8
         N+Sw==
X-Forwarded-Encrypted: i=1; AKwUvBzjUNQNBVRIPVdXdYgLwDkkDjQvvpmJl7fU54uuhg9dionx5x7MUjmACdCreHVLG9jwYAkkKWfN8xU2NQ==@vger.kernel.org
X-Gm-Message-State: AFuF++mdgV5MPqtV9+PL/CVLEv3Wj1mgdQQTaK+KMh3xoXz36aAMHqAA
	c2f4sBRIBiQHTzCVXcmzYTXWqDDFBpeZx6sKVWX+8Y8FNP6Ac+R+UAhBmk+oL59ah6w=
X-Gm-Gg: AYBFou2YU3rE+jSZM+5y6QV8S6dOeOFQSFE78+AjrpuGCQyWRTwaxm2KuS/Vy//KsfT
	w6MUAfE2p+joSgcZnkO/hs9A7davoydCo3ZicJgrWS11ZuWGKGmiF1+MpJbM3viAjq2dbFNZvym
	mqLUzbGvRzmDxEN8ebou9bkGtvi60d0epmUAnPylrwzhnrfFrZDP5cIxIhfFgdUo5hRsXEoQzF1
	UTeRL6DMzw+innXlGagAg4KaHhDYQIwtPavwcjsdJMCgokHAUvHVTyOREGGKYnpOmbWwVCEggpR
	AXkGlPeAtJwsQt7KvJDS3i/Mgvm7EA/pnvw2QzAweU2GbDgDzuoeT9XVwchMC/kakuCltWSB7rB
	8C966mlF/Ih5RZ6R5nxd6YgnYCyPb8UE/mCL5uHuLaayaeovaVTMVfEXqxwYj7N2B8PWy3kduX7
	2G/KNZRxr8A+Jpm07fi/kVN62FW4kN+JRdKPalIwldBmZNIqoz7ZeHU/Zj3EWP/FcW/eextJ1Ht
	NSb/jZWzHvlsvX79zEdjdc3IVNOWg54mNdqBPwvakzt436qtudlJM//hOmqxN5l
X-Received: by 2002:a05:693c:621a:b0:33b:faa4:c816 with SMTP id 5a478bee46e88-33e8d2ebdcemr2596187eec.19.1790162433322;
        Wed, 23 Sep 2026 04:20:33 -0700 (PDT)
Received: from xps16.local ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e95c7d003sm5516279eec.9.2026.09.23.04.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 04:20:32 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Yang Xiuwei <yangxiuwei@kylinos.cn>
Cc: "Martin K . Petersen" <mkp@kernel.org>, 
 Christian Brauner <brauner@kernel.org>, Christoph Hellwig <hch@lst.de>, 
 linux-block@vger.kernel.org
In-Reply-To: <20260923093732.1504291-1-yangxiuwei@kylinos.cn>
References: <20260923093732.1504291-1-yangxiuwei@kylinos.cn>
Subject: Re: [PATCH] block: reject polled dio with user integrity metadata
Message-Id: <179016243250.15063.12963175980026280131.b4-ty@b4>
Date: Wed, 23 Sep 2026 05:20:32 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Wed, 23 Sep 2026 17:37:32 +0800, Yang Xiuwei wrote:
> IOCB_HAS_METADATA leaves iocb->private as a uio_meta, while
> iocb_bio_iopoll() expects a bio. Since 2729a60bbfb9, metadata I/O
> always uses __blkdev_direct_IO(), which never publishes the bio for
> polling, so IOPOLL calls bio_poll() on the uio_meta.
> 
> Reproducer: io_uring IOPOLL plus a PI attribute on an integrity device
> (scsi_debug dif=1 dix=1). KASAN reports:
> 
> [...]

Applied, thanks!

[1/1] block: reject polled dio with user integrity metadata
      commit: 2a42e6fe1293f2e2d579c9fe5bbab056dd8b880e

Best regards,
-- 
Jens Axboe



