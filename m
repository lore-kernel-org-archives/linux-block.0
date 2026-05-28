Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3CA33291F
	for <linux-block@vger.kernel.org>; Thu, 28 May 2026 21:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780002310; cv=none; b=sbanzAxVlM8xnuEU0qoxPM9+woHquMCXShbIRQEUbAx/TC/RYQ+KZJtA4M3qjS07cJgpn+4biX7WQuFWipQ/KJT6MoI2AQAMv9bvXkM36RItlENLNvafKhMiOuklqjhgbZHMDhK4roPrQ0dEA0nSMwKiPP9vsZHgTet+9lUsQRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780002310; c=relaxed/simple;
	bh=tk1c7rnwuBHS2uRZ5SwD0NGJn2M8Eb6GDVhRgrEKGj0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LRaYRyiBvffu5SU42p99xmU2Mm3RJh1SMrLj/cu1XS3MLAFV2EITKqgywrKH9URv3fqnyqfRnRKH7vPUC9CKoctHy0pmmMpwlaYLA6uBJS5B2tEW4B6215w9qSvQmnyFMDiCD23vai8/AoTuFTjsTuKifxLMpGfzjJQWGbBOlqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J/VqoU+R; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J/VqoU+R"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4903997fcb5so75667615e9.2
        for <linux-block@vger.kernel.org>; Thu, 28 May 2026 14:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780002307; x=1780607107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K4mg5HNDrZSCCvclWVXl2PaKa8JuKCMeM5HAnfez5H0=;
        b=J/VqoU+RzIZentEDsQSC0t35GnF9EqBfogi0y7anugMWf0LbAfQFbRd1gJTprc9iqG
         6AZWYpjvc6Cafgf2E8BAlkStJsRb5DvVrZKkiPML55E5Ky2VUXU9qt1ud8xsxsb8Lhi1
         vFAB3d5a8K+kM5/AJA/qC/UJb2Hpa60+1QTbTtpXqdxT3D8dEJl6lI2SZDBLDA4FWqHo
         BGwNXmLFftYqj5vVlsPacGvV4xByRCwURvuD/DzEHhVmt22GH4Pgdw2p9ytNS8dVmDUr
         cp44IJap8Y5kyGPXfT1L6skcl26LYM1X4ff+JKUAdrixPRuqCwSXl+hWGwmKZLJMcI61
         yEdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780002307; x=1780607107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K4mg5HNDrZSCCvclWVXl2PaKa8JuKCMeM5HAnfez5H0=;
        b=dCwb1ayRGFuXVkcubCMc7P4Lktt1JybkS1OII+9eG0Cg+6/rW0PrlK7abWdTrLF0Et
         OfXa4TNkzuBOCG+Kg1hOkvVn7E/1Jdk6/W3BI9Oq6XbXjxpHrqG9Shd77wYhp0gwhuNi
         K8yhrfwq2u6aBLGe9VmctKk/5Da0BZ5CbSHSbA4UoJGC4oU5T2MqQO1JBf9Kj06/BRx3
         NEHuX3pbxDIhnaSBLeqIXeLdg668CRsa1wcEkSswbJwPFkXTVe1ypWQmfxLID9difxmA
         4FUl/D1rQMcVz6CHF5tivZC/vpqG0iLmo2eFeGfsBOng+br/7vKGploRO48BdgMsFkPx
         VWdw==
X-Gm-Message-State: AOJu0Yzxhe9a6DXSRgxOIVEQNVTGddyx08zZukQHaoJ8wn4hTLot+Zc9
	uqzKBCz6p6InN5f2Ef2tFi+CwnuoNXO3LcgX4W3FNwdIgi+hBsjbPMsh
X-Gm-Gg: Acq92OHUitbZ+oQWtMmbCPZEIWbBE3UK3TF34hRXjWj3785/oQ7giW78ArfKbdpNkbk
	Dvj14yOSI/azEeu32z1dtHBcR0l2wWuodeVrBOVryiOwkrBh578U1rB5wwoSbmj8LXjQg1yK7s/
	kW/A5Qmrt+c9SqJDX/D2zoTAvzFGTNgbJnZ0iHcrcoUoezhbIAOe6DNgfx32Qsja43SWcwoCCJf
	bvbebv+VgljF7mhHO/RYuYez+3D9T1hYupYCdJX98/taLRyF/OGKOfL1GqANt0rEACVhtYJeyHr
	h/qg6Bx9H4IRUaOVii2mU91EH0wZwSz9dhVqJ6V6hCZD+8D+OTJlYPfgcwm5kyRCaicYZO2lZAf
	22Y40nUdv3PKk6D3oQl6aOCx/UG01KmMx6feL2MK8fwY5VcA5D86CweOoYQzRwhZNoGFMInGkoI
	lRPIZFz36/OIuiemtcsiIqPxpOu4nhcE9jMl0w9r1fCWzMndiQSr30apekFYin2kccQCk44CE=
X-Received: by 2002:a05:600c:c059:20b0:490:3d62:f5e1 with SMTP id 5b1f17b1804b1-4909c0e421emr1387775e9.22.1780002306931;
        Thu, 28 May 2026 14:05:06 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49092654e10sm56452765e9.7.2026.05.28.14.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 14:05:06 -0700 (PDT)
Date: Thu, 28 May 2026 22:05:05 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-block@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>,
 Dongsheng Yang <dongsheng.yang@linux.dev>, Jens Axboe <axboe@kernel.dk>,
 Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers
 <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, Justin
 Stitt <justinstitt@google.com>, ceph-devel@vger.kernel.org (open list:RADOS
 BLOCK DEVICE (RBD)), linux-kernel@vger.kernel.org (open list),
 llvm@lists.linux.dev (open list:CLANG/LLVM BUILD
 SUPPORT:Keyword:\b(?i:clang|llvm)\b)
Subject: Re: [PATCH] rbd: cast snap_count to size_t to avoid tautological
 comparison warning
Message-ID: <20260528220505.73eac71a@pumpkin>
In-Reply-To: <20260528202151.136274-1-rosenp@gmail.com>
References: <20260528202151.136274-1-rosenp@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 May 2026 13:21:51 -0700
Rosen Penev <rosenp@gmail.com> wrote:

> snap_count is u32 but the comparison is against a SIZE_MAX-derived value
> (~2^61 on 64-bit), which clang flags as always false with
> -Wtautological-constant-out-of-range-compare. Cast to size_t so the
> comparison is done in the correct width.

If that warning makes any sense then the cast shouldn't make any difference.

Why not check against RBD_MAX_SNAP_COUNT - the buffer isn't big enough
to hold any more than that.

-- David

> 
> Assisted-by: Opencode:Big-pickle
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/block/rbd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 94709466ad19..b4ba51db9a28 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -6079,7 +6079,7 @@ static int rbd_dev_v2_snap_context(struct rbd_device *rbd_dev,
>  	 * make sure the computed size of the snapshot context we
>  	 * allocate is representable in a size_t.
>  	 */
> -	if (snap_count > (SIZE_MAX - sizeof (struct ceph_snap_context))
> +	if ((size_t)snap_count > (SIZE_MAX - sizeof (struct ceph_snap_context))
>  				 / sizeof (u64)) {
>  		ret = -EINVAL;
>  		goto out;

