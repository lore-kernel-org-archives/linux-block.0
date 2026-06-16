Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FDA466B7B
	for <linux-block@vger.kernel.org>; Tue, 16 Jun 2026 16:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781626122; cv=none; b=jmHbRlo5fDVTrMdGgKgbGOaqMHv/+LOxy5AtS4Q1gB9A80ioV3jaQA/mb1p2jY1dV3wNWu9ucxcjLfuhhuSRG/Mu3cfKzaPb3XWzrF8y/E0xsVXirSf66BnqoLhTIZPCCOhLp59rStpB6HephW2zssNSoDk8ZHGz3/WQXZ4ede4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781626122; c=relaxed/simple;
	bh=TK4VE9m+LnJjw1TU9J38PsjmX07jb0KTu0emDvRQGXs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mRkuwRwEdASRDhzGPMZKAetiU/Ey6Ml8eBwZmSAcrnV+qyRJBn7+X64GW+8+Szkla2lfvXukEzxiIUaCs9UIAGs7k83UxHXoHqDKEf44+3MNPqOSJ43UAwf9hDSVkOT4889wYIvDO33NMF9EJcY5Xur9xCD51JhsoXBFhhFzxw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=SDqDLG9j; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="SDqDLG9j"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-440dcd6406aso2842155fac.1
        for <linux-block@vger.kernel.org>; Tue, 16 Jun 2026 09:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1781626119; x=1782230919; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6l3VVrlUzgw1Wn3p9J6Zfru0XVcWTKAXUjfmhfosCa0=;
        b=SDqDLG9j3o3O+fu3dze9PxYmmnzh7ldTZB/pR+f/6xfQe5nTgkmEvGsa/vyMWaKEqH
         WBUvzsh2BoslV9Rg3S+CFgv6JmLZrX2VPfYZmZ/5xQNWoo+wwNATSVtwEfJFc2QPVNXj
         wmuHWhVmCNc2+GgmOhvOqifU3ZqIkMPgmK1LATyZ9ut1fwf1CRtAAZVMNan1URgASSPh
         yb2t/xGyrcia8qyU+XdYK9VnBpgRqJymyf5U85CbA/BGj7zSxhXWyyVCenGYdJwgGR7X
         5RD7TAr75SsHlM84fJMLSAjqfcXEFbTae80yC88PO/i+hi5nwK1JvxEs9d/g6l5s4USJ
         9FGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781626119; x=1782230919;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6l3VVrlUzgw1Wn3p9J6Zfru0XVcWTKAXUjfmhfosCa0=;
        b=slBGigPfEatDUTL+s6X82+LsPtPV0n0hvaHbMvf41onjZGA3TDgOyfaa3JFBVhpL7A
         VZLWboeKTNj9xgtouGutDroNFW6X5bhhAJx4kNjBu0sdGDh790PgndmPckM1rFE0zeKt
         eAsP+3VYIGTJldUcnctE+mYO/v2ob7u245X1e7nPhGhspvX8CiDtQeIAXw1yNwwUiS4w
         /8XpUQYsBBM8duKRWE/QywRQ+hj1wrIsnE7C0ae1Jaax/HEeMjDSWyXJMeCYGRUAUMeG
         cAG7xYQSxsoJjJ0j4ZyG/cEmTMHZOrakCC4c00ZPU1mktpiP5UMI8iurkFmj3B0q3vHb
         D7gw==
X-Gm-Message-State: AOJu0YxIy1hh8jGqKUSe0eX+SfTRDFDo4HgWjzp+abtuWxx4qqGNdiHo
	5UZ7UjmvpjyXyAoWLUy0uc+eqf1K1fw6kzJS6lC+ioKxfw2QB/OhF2YwP99njjUP3WPlzQEMVn7
	vfsIzGcc=
X-Gm-Gg: Acq92OGS8DPgMLE1p3C+ndA4y1EUCUD6aggnw/LX0/oU1P0cMi7vxjSAgqEkJmhPnxY
	BObr4+ulAfMuxsvRnN9MTknCZZGZ0zPGJ7Y9ekoiwb7zSzwlEZxevRoyeA8SU9ue0dCsW8zh2TP
	JThx+PlQF2Nl2psk8bAuTp78MbmRftqWBkIzr1zi/hxGuIbJHdnGk3/awtgs4pO3ZCgTM+Zcng8
	PuT/8abIHjdRLbjkUmJ4R8eT8GsZq7MVUCi6sHXYenmOe8GlR+6M8wGzNrUu4pt5hXZvlq6QsJI
	0njGMlVOPMfwnwlJKvUcd0JnHqZ+PJfGu4+dKDsWRcL5r1EN65u2qyvUqPKjNSu0rgMDR6eF16i
	yo3fBMDPl72/6owDFQ9Fqiin8qlJTOufCRT3vjEciJEd8kdXUoBe2vqnb0r9uGuJ6KxNHrKMqsY
	jRuqlGSGzioGgzvN25S53PpBXdvmEiybL7P8AI45C10VaqHQrBVqhdDS9mL7CSpuiv9Rzx30Zgi
	/lR
X-Received: by 2002:a05:6808:1a04:b0:482:c2dd:d192 with SMTP id 5614622812f47-489429cc4f1mr215606b6e.26.1781626118715;
        Tue, 16 Jun 2026 09:08:38 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4875ddd9fd3sm4631101b6e.7.2026.06.16.09.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 09:08:38 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, bsegall@google.com, 
 dietmar.eggemann@arm.com, juri.lelli@redhat.com, kprateek.nayak@amd.com, 
 linux-kernel@vger.kernel.org, mgorman@suse.de, mingo@redhat.com, 
 peterz@infradead.org, rostedt@goodmis.org, vincent.guittot@linaro.org, 
 vschneid@redhat.com, Usama Arif <usama.arif@linux.dev>
Cc: shakeel.butt@linux.dev, hannes@cmpxchg.org, riel@surriel.com, 
 kernel-team@meta.com
In-Reply-To: <20260616141604.328820-1-usama.arif@linux.dev>
References: <20260616141604.328820-1-usama.arif@linux.dev>
Subject: Re: [PATCH 0/2] block: invalidate cached plug timestamp on context
 switch
Message-Id: <178162611741.2191657.12211870708971600814.b4-ty@b4>
Date: Tue, 16 Jun 2026 10:08:37 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Tue, 16 Jun 2026 07:15:16 -0700, Usama Arif wrote:
> The details for this are in patch 2. The main reason for this series
> is to invalidate the cached timestamp on context switch. This was
> done in sched_update_worker() only before which was resulting in
> blk-iocost reading stale timestamps and throttling based on wrong
> information.
> 
> Patch 1 is a prerequisite to create the invariant that
> PF_BLOCK_TS set implies current->plug != NULL.
> 
> [...]

Applied, thanks!

[1/2] kernel/fork: clear PF_BLOCK_TS in copy_process()
      commit: fd38b75c4b43295b10d69772a46d1c74dbd6fc81
[2/2] block: invalidate cached plug timestamp after task switch
      commit: fad156c2af227f42ca796cbb20ddc354a6dd9932

Best regards,
-- 
Jens Axboe



