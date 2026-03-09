Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB49258EDA
	for <linux-block@vger.kernel.org>; Mon,  9 Mar 2026 14:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773067960; cv=none; b=qM3LbSXUb+lFikLBUSoSqk1uVX7CI9McXmb7Nf32dIRN/aNzxO7KWXCpehMmabOkl3w6TANhBPOZelX2w+IDr2zH4VFBE3sTd7Bjx75UOX8JIwFV5QeTRfQy87xaHHfhWs3wGJxq3U+Gd6oeAueLf73nqDAo7CWLdNjE/2ZIPDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773067960; c=relaxed/simple;
	bh=njW+dpSk10SuO1AcbH5tukD81vdWuhIyIPazhF2qfvk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=V20fPD8ZW6PUZ6EFU+dQS9DHr5wLr9CtyWk95F55htSB72xbBMWBKi/i/BxrBKFxYOA+ntA78YyUYFkYjmpijXhuurgRfYXujchUqBjku4HZjHDgWbY2g9jdpmSisqpFyI8Xw81h1EVNOMApvNLxpmLPr5y9Pm7qTSPpAJg0deY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=KrQsV4Z1; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="KrQsV4Z1"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-899fb030812so117326446d6.2
        for <linux-block@vger.kernel.org>; Mon, 09 Mar 2026 07:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1773067958; x=1773672758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M362llShL/olgkvofrhnarltpI/bzDs+ZoXPZquhvi8=;
        b=KrQsV4Z1HnvgdgqrimF/HVIwAkgper6YwqQPBBhU179xQaK/8nfR4pTwUAED/LNhgl
         63NsYsAx9O+zHoQ0+NroafKUa1BE08m1wZqPQgYv9V+K2yQOuz8B2M8x7WXsiTg8TBy5
         UtqERWpCaFMGZ9hf7mKS4UcTGuEwmMuRZJr4yKuD+ssb5EqAv5SCfUahyGCytEP3DT0Z
         XOlRVNB90LXvnpKr42vGSGENW89XVDzNoiIIipS0TO1y/xTg8LuACIgJSJtYPRDhBVdG
         z4ip2wmVtrQvsMULJw67GfW2Ic4DmkMAL5gDlOsPKn8+KfDmwI4Vtqi8z7Cd3V+uaY5s
         yCaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773067958; x=1773672758;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M362llShL/olgkvofrhnarltpI/bzDs+ZoXPZquhvi8=;
        b=bT4TY92zLFPHy+zeFkiiVLFyukJgRxjPxuZYKcACHWabLbQhm7DoKn/OZDFvTM7Cg0
         ktU5whye7q5fZ+2yW/nMTzdVcIEBowPzitwgwP4chTV3rWz68VI7iivwVRRksjj+wybH
         oV+rdndwkCSMruWwqFtkHzBefuA832/M2akxCMgmnHPWdlW/XwyIHgPvwK4YQVc+2Lxe
         f9X83azG+L1Nvx76Gk1hPx6WayWvAjQ5eyvDstdNf58nt1RUgGMu2EVNOh1s6wd5V+PB
         oMY8xIfgrFybL+0Gz7ngBJUhAygpIm/GH5oedQnWbY1h8aTGeGktBlaaon9L5EkcpoMl
         aMqA==
X-Forwarded-Encrypted: i=1; AJvYcCXemC9sX4EbP8GxvxbD4mFPD7mZhDVxubtXmQRRu2DzqA+ZS9zjjHNwdquoDRuCPGGgA0x2xf6/yjWIYg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxUEf9+QvRMuY6CRudHtQmq9LF0XZnWil2JjYFytOGtAS2eEfTC
	CShrUobRuvwbN1AWn+jnZKnN9YV1VYyKIro/elwGnJpD1U/Lu/6AkWMCUc0i4LQN86k=
X-Gm-Gg: ATEYQzxhBGj2Q6u0XDOppOdteHlvcpBUM9Sa17OBPhBXWLK5t/Y4amAGJ2UjbNy6r+r
	8CPScfCLI3qAyUX1+47RWewSi2hpSr/2ZT4KWmqJAkB8WOTq3pWIVuGdk4WbwywYoRwdhCL7wZt
	ECYN5dJGXzyx+59F2KwbBap524KvBGhZRXtEF0VK3VoYKdps9Vx4Wt98VYoCFwgsgNkQeVIpWnq
	eiys4WhXlo5O4f7J5EH4YxlvAM81h6AnplukupS7JS5/Ka0ff6klPTGQjq+5p9Wn4RDxAFQjuUc
	W0xPU1E8l98HDkAbkjVnRiiUk19nbWZ36FisO4iwn+qRzp4G9AH00SDVdNhQ4j6cfl9gFbrEIma
	V129iVJWKiny8YMyaDonhpxjMkyw8E2ZFaUMgKIZXn4K+NNF96TXXX8d0WAN4FC0RaLXzBeYk2W
	gXWsWZEAyGNBAnAhs7GJR4gv69PFKSXe58GxA5nl1LtULUSGA=
X-Received: by 2002:ac8:5fd6:0:b0:4f4:de66:5901 with SMTP id d75a77b69052e-508f46c9079mr149938371cf.5.1773067957796;
        Mon, 09 Mar 2026 07:52:37 -0700 (PDT)
Received: from [127.0.0.1] ([99.196.133.212])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-508f651440dsm65793431cf.5.2026.03.09.07.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 07:52:36 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Christian Brauner <brauner@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Carlos Maiolino <cem@kernel.org>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Anuj Gupta <anuj20.g@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>, 
 Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, 
 ntfs3@lists.linux.dev, linux-block@vger.kernel.org, nvdimm@lists.linux.dev, 
 linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
In-Reply-To: <20260223132021.292832-1-hch@lst.de>
References: <20260223132021.292832-1-hch@lst.de>
Subject: Re: (subset) support file system generated / verified integrity
 information v4
Message-Id: <177306794392.32482.9164747646721806111.b4-ty@kernel.dk>
Date: Mon, 09 Mar 2026 08:52:23 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Mon, 23 Feb 2026 05:20:00 -0800, Christoph Hellwig wrote:
> this series adds support to generate and verify integrity information
> (aka T10 PI) in the file system, instead of the automatic below the
> covers support that is currently used.
> 
> There two reasons for this:
> 
>   a) to increase the protection enveloped.  Right now this is just a
>      minor step from the bottom of the block layer to the file system,
>      but it is required to support io_uring integrity data passthrough in
>      the file system similar to the currently existing support for block
>      devices, which will follow next.  It also allows the file system to
>      directly see the integrity error and act upon in, e.g. when using
>      RAID either integrated (as in btrfs) or by supporting reading
>      redundant copies through the block layer.
>   b) to make the PI processing more efficient.  This is primarily a
>      concern for reads, where the block layer auto PI has to schedule a
>      work item for each bio, and the file system them has to do it again
>      for bounce buffering.  Additionally the current iomap post-I/O
>      workqueue handling is a lot more efficient by supporting merging and
>      avoiding workqueue scheduling storms.
> 
> [...]

Applied, thanks!

[01/16] block: factor out a bio_integrity_action helper
        commit: 7ea25eaad5ae3a6c837a3df9bdb822194f002565
[02/16] block: factor out a bio_integrity_setup_default helper
        commit: a936655697cd8d1bab2fd5189e2c33dd6356a266
[03/16] block: add a bdev_has_integrity_csum helper
        commit: 7afe93946dff63aa57c6db81f5eb43ac8233364e
[04/16] block: prepare generation / verification helpers for fs usage
        commit: 3f00626832a9f85fc5a04b25898157a6d43cb236
[05/16] block: make max_integrity_io_size public
        commit: 8c56ef10150ed7650cf4105539242c94c156148c
[06/16] block: add fs_bio_integrity helpers
        commit: 0bde8a12b5540572a7fd6d2867bee6de15e4f289
[07/16] block: pass a maxlen argument to bio_iov_iter_bounce
        commit: a9aa6045abde87b94168c3ba034b953417e27272

Best regards,
-- 
Jens Axboe



