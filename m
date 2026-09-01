Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4FE3B38B5
	for <linux-block@vger.kernel.org>; Tue,  1 Sep 2026 04:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788237766; cv=none; b=AvqKuVuQn/+APkAZ+DX2obSdtmjEQ5r48f5ACkOKq+qFrCl53Bd8gIbwH7CMXGFkfChB0MZLt6rik/GgtmSSi8bKcZD/ID+K6I3lbvV4pZfc1G8X328sZLqSfzgOpfWeCBslr0vYlZ5ligjsUKPFerSc8/k+jaAuH9FzUon/Reg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788237766; c=relaxed/simple;
	bh=lwtSoK8qbGNGh7TYIVnApvAovs2Gg2mOthqxA+561WM=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=aV1prf0BW9+Uaaxqntaa3Vpai1cp1lppEKWHqvkKKfbY2gZhrISm9qug9hxkoOIpOALsVBZrH4PjQBXspjbqmoaszZiBwSc0AT/bPGR+ql2zteDDpGW7EQtJYSBCsmVDSjhyXaNhUYYvQlujj85TBcLpPf5nzBn7JcAY03avHQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=m96c4x7/; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="m96c4x7/"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-398d2b28acfso1612825a91.1
        for <linux-block@vger.kernel.org>; Mon, 31 Aug 2026 21:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1788237763; x=1788842563; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fUFkNGKwjaw5NK4t/hA/rEnJIEuA7+uukbAK235h6O4=;
        b=m96c4x7/7SJ8I0vCstWvumuJWvHR4Lwkj00ZCf6bG4U6NOb+YulaVnOtQs0OO3JAY2
         6hyYajCOTO/kxYrfoDbWZD9sUFypikDH0Q3yLyXtRfK33pTVdSCtcOzxm7hmL6/kLDYp
         mnuNfGpEbjAtHIdV08xPkX3Tz1wtcLa+y+68+ki6B/Ny24DsWeGi57B84HOK32JEOid4
         JegzbR1fcRBD4JvJWjE7SdIyutooCpTYfxmRqqfHXp91ZE9Tj7zdA4HvGyOv9CnoMvQ1
         ZYkNWjrcnp7Qp/CZhVUOZ8WPqrRghrtW5W10vXgOSRKG7/3OqNI0LR30PaZls2D8Gh7/
         XqLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788237763; x=1788842563;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:to:from:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fUFkNGKwjaw5NK4t/hA/rEnJIEuA7+uukbAK235h6O4=;
        b=JyDvdi2QaPlPPLEDRJ12Vri2GVNEfkdwsRp5YtSi81tMRGWomGNFmAma2IrjS0su9t
         bs/pWAZFRSNMfKIA56RIyaMSuD2DUeWnVNPLcAz3DKbviv3JTe6KwYD1twxQ2hDMDm4V
         1iFjK25lIKNviLAssfFyplshMWo3WJ4PtkfteaRiYVJpyWox2AkjQeAYcUIJ0jJ508w4
         ffDAp+h9sCzuSs3zSgk68rdmGn/5qcTERFiSGkD2fK324QYFt6pQU3sMuCb8onHX6qrj
         xVSzJrMY+JBWfOfOEf/ojfcuezBs3tw8/AYbCKg4iQkCpvJWLB5v3RO02tNqOvpvzxWg
         iJLg==
X-Gm-Message-State: AFuF++lr29K1bt26BDPEbhG9DzzK/jTOYLWezMVjO922wvcZfFYmxF04
	sQNZRkD89gNkNqgnTHpOWMcaOWXdWQVdr3SjxuCDLYCyENbQlNAnHrkvrPG1mRFKLJJAAbL9TFZ
	3Xk7CmNM=
X-Gm-Gg: AYBFou1eKpVzyytVtaPlhd3Rux1NJS3MHTFQUqEJZ6RwgCulA2Y1ZbQRqJLhSE8lBG5
	qxVbP7fpyUvoZtQsc9MGqMjZ2nOb/x147P8JuWymXMNhuZNGZfp5F03V0phY8BZKxjCLrvBnwDq
	8Sa0SsGRbM21+N0jxSFsSQHipz9bar7J1kUyxbN7gY7Hw6ZLmTp0GjpCNgmeZWDxFs/so4trIPr
	a2S8b1bIYWXFh+bUyr93X4HG/IG9SEPoOCPSEx8dg7qSLLgeOOrnODouaqvw0mw7VkQXNOiIZ33
	KNV12Kyx8GL3I4/+3weTxuSu6wZ1qYXqDTC4ygvnU94vxBsrIlUOivwlSqLqhimS/Gw5nNalN4A
	667ELDWWw0L3H2hzBxOVuuYnR/vvVkN31W5IkVf+XtIs1jlOWZEDAFJjisBD2CEb9YedhkMVFAC
	oro4F2FYGccYv6XnrbDfpe9ZGDop12aWTCWUeA74tHCKr7nOkjHJ8MX5N0PMnDnWOB0ToUEMzb/
	OLzd3Dnl1D9JWSxB8PjVNDy+N1MvvIAFim2gZEiYqrssMAdqwwEzg==
X-Received: by 2002:a17:90a:1182:b0:399:1b64:e0d7 with SMTP id 98e67ed59e1d1-3991b64e5dcmr1874941a91.19.1788237762895;
        Mon, 31 Aug 2026 21:42:42 -0700 (PDT)
Received: from [127.0.0.1] ([192.77.111.15])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f99585csm33301110eec.21.2026.08.31.21.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 21:42:42 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>
In-Reply-To: <20260831025050.667758-1-dlemoal@kernel.org>
References: <20260831025050.667758-1-dlemoal@kernel.org>
Subject: Re: [PATCH RESEND] block: flag zoned disks with GENHD_FL_NO_PART
Message-Id: <178823776207.2367683.18331635634381064817.b4-ty@b4>
Date: Mon, 31 Aug 2026 22:42:42 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Mon, 31 Aug 2026 11:50:50 +0900, Damien Le Moal wrote:
> Zoned block devices do not support partitions. However, the partition
> table is nevertheless still inspected, and any partition found ignored
> with a warning in add_partition(). While this is generally not a problem,
> and in fact beneficial to the user as it indicates an invalid use of a
> zoned block device, scanning for a partition table on the device may
> result in issuing read operations to offline zones (e.g. after a disk head
> is depopulated for disks that support head management operations).
> 
> [...]

Applied, thanks!

[1/1] block: flag zoned disks with GENHD_FL_NO_PART
      commit: 3f9c7a108c0e8f14425384912017071b71341e3b

Best regards,
-- 
Jens Axboe



