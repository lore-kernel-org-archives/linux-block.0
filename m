Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC01542EC5
	for <linux-block@vger.kernel.org>; Thu, 15 Oct 2026 15:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792077810; cv=pass; b=BNiaYdgAON9sFAf1O1Ce9FDqkvNeLeZCHryomCZfzxeDx2KGm+I3MyGSVCcBvw0mHQR03sVxwNifDQKGXh0+ocAmXbWTLzsTrjpBlMmqe9PbZkJTnygTtVfAvj+eoiZrNgAbPGU3Mbo9GwVrc+2PVl5XSw8jWO2Ae/RjGoO8iVE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792077810; c=relaxed/simple;
	bh=2EOHoPv3BQDykUH33A3omRl0PnRrEhVuncaHNdWKUGE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LZg/N2QXARzPdL2EIiRipQ5/0hLJEwk4M76NPqzCkAXzjeg3bh4ye0oJG7ODRl5wp6Epw+nebYxXWwP0kiMG8AmunVNiLl6YFiytcQSfVv70hqpFINIIRVjsMvsdQ6uvR8iPiRvpw6exnDBiH0ZyLf9WlRVDPn350OfwGHOi0/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kJvOiHM9; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kJvOiHM9"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-677d35fd1d2so1905157d50.1
        for <linux-block@vger.kernel.org>; Thu, 15 Oct 2026 08:23:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792077799; cv=none;
        d=google.com; s=arc-20260327;
        b=J5ih45hOHAgyGA96BMKciJSSbEMZKhqtRlWdm61lgSPyTLX8BF032NJan4VNneId2Z
         xDJ0X8518+cFKtlbXNm0zlIXJYyXv4NhHhJ4DeRvS0JOGc/HLkp1g1j3BNZb1C2CtBae
         9y70m9ZbiupRMiBHnqifRn722+U8P2TaWUP7RAUVDzLGrifBtE42fLJfBlIOsnJSVOva
         qKDYdS34GTvzzHIQn45ebRqQMRfW2e13QhhAs2UF0loI6moqfxK4X/HXh6WccjcMCKI9
         jSpyTw/4X7fS8WtSWecd6bgzuObNRYMs12iVq4r5mq8Hz6UwWULS0+0a7qZ5weAHUOzi
         /66Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2EOHoPv3BQDykUH33A3omRl0PnRrEhVuncaHNdWKUGE=;
        fh=Via1bAKV5uXFVfGgK1/SSMM2GzTcHGAzdrXoVNklEsk=;
        b=ObWByzFr7mOEBNwZkY/K5woTk7oYQtcMkT+U4Cd8Kk2M2zdlE6uhu4D10MlKsogDYf
         Jab7xVWnaT1jzuwhjMPoODHkcxPdlFPy96dMdy4IAJP+MKsrntoz/mePqRHI10YHMqdh
         3la9AV5kbgloHZuB2AXe3xk6IlNtqnanHeahDAkD0UqehVSeZ05YrM6/l3x9/LCTe9f/
         ZBi0daBezaFcDsNfBW3pp7Bwel+ZzDYlpmOBGma/1rmyYYlBp65c3/pHXwJtDSqvrX7y
         g9lha60qdSIbUBrq7AYpj/DhQh6faeU/3YOlvfUscq2YrRX9RXcVTLkohonyElWzCO/3
         NcVw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792077799; x=1792682599; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2EOHoPv3BQDykUH33A3omRl0PnRrEhVuncaHNdWKUGE=;
        b=kJvOiHM9M0WnN33nHmHK3r+01pGpxKYp5aY/UMKhQFhOLUSVrDioLgyfEQddwhvQ38
         PSxocSnNo4gQUdIbe4ErVPJiV96p+kqbiIxQcBbi7vbgtMDwRxN5BGIrrEmVjrvwbGhi
         0YCuafuazhtWQFzgBrSCDze23oQAIfATfnChfJJA42QV55tZXBH4DSzlHC4euw7F+JYX
         ieWEFUQcCTMYDeBtXjSe9qtkAAJtz4+p2iCkdX7bjFDQxaCuc8msRNw56cgXEz9EFzHv
         UEuv6DmGT5a0nd7IP8MfwnoWyF+3btMgkyS9YVwMoxdO2oDWtDnoZXek8Em3C42YaF85
         mLMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792077799; x=1792682599;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2EOHoPv3BQDykUH33A3omRl0PnRrEhVuncaHNdWKUGE=;
        b=jh+9PVXbDnoNMTY3XumfFwxl24vE/80oFqvEgurFToSsDkJS4J9ngL9EJX3elsIU6F
         0PRU1Uolve+qO2othCHXR0o7qLTxvQOM+N+Fd0oYE4danNA9mM7lNQ80dl0s3ew+F1KL
         CZ4xJh3iPGuvLkaUw2NXaBPr2PMcL1ErnFM+WTFBGSocPnMel3Id+8C1rjYBQdvUNAg+
         iKfdRK/Fz7SQpmd14zQFSzAF0g/NKJq7Fh4iyMLXoJyDvTcXz+AyhCyhA30bed2Ku1pm
         87X/JqbvMHR7Bm1DyCNPEum8zy3XCQ1w9fL13ubruzHQlJZNpFGrqJV0pcUOnfyMDxMi
         PyQQ==
X-Forwarded-Encrypted: i=1; AKwUvBw/g7k6sSb44jViPUesDDvUBHOdxyG1dRWzMv6IKP2tofEYqTfsypWwPSV0f2PlGTHZs/8iOyJAUK5FNA==@vger.kernel.org
X-Gm-Message-State: AFq9FYIzK7hxfCvOFCXBIg5aJBbbSFp+CsDyvJ5wyoyJcFbFGLxriliE
	UsvhXysXWEd62bOlFQwUjmK2TqqQCiE6sejM4nhRBvxawVwNXe+dGgusRREBzEy+C7C0tUVgCqn
	Od/SmRQ6yYDkY0qiVXldohosENcxi45A=
X-Gm-Gg: AYBFou3p7P6VzRMyEz+hr3omdW7GQFvJp0B3mVyn+1JTEsljB17sPuQEm00iDiXxAJ+
	TQ/j4pLiZ5DOuiaRd66dcWEFmkiOcmos+oOJk+36oqvo+NNW6B1t0zsvrbw8lcj1I5zSfb+q14w
	lBsnOku4jhVKju4qxg5mP4cpxyF57dRy5rXYbLNK+0o4txfnT91A9+nei/Yn+q5JkBu+Zp38xXG
	jQUViZSwo/C8tf7dRoTypq9m5zOK4ygxiZCt85AnoHNaYgrZvReiY7EQTaxnA7MS/5QgEdFI+hl
	iUENAZLmt0fuwSM55Z8JywzHDWMGcmqK1IBtqy9D4Po9/cvBb7V/McY=
X-Received: by 2002:a05:690e:1286:b0:66f:94c4:51ea with SMTP id
 956f58d0204a3-6793603db52mr5927090d50.47.1792077799474; Thu, 15 Oct 2026
 08:23:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261015093854.2082600-1-huangsj@hygon.cn> <20261015093854.2082600-2-huangsj@hygon.cn>
In-Reply-To: <20261015093854.2082600-2-huangsj@hygon.cn>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 15 Oct 2026 11:23:07 -0400
X-Gm-Features: AclHuK8xZfXzISQM_5AP4aKpkZUrwKcxhhqslcqF8aMXobo6HxWE2h1pVZC0fso
Message-ID: <CAEjxPJ7xgpYOQVRSoBMK-_w4kmrPu_v37iS+q3Oj5TvtKUvJqA@mail.gmail.com>
Subject: Re: [PATCH 1/3] vfs: add inode iteration method super_iter_inodes
To: Huang Shijie <huangsj@hygon.cn>
Cc: axboe@kernel.dk, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	zhongyuan@hygon.cn, fangbaoshun@hygon.cn, yingzhiwei@hygon.cn, jack@suse.cz, 
	agruenba@redhat.com, mic@digikod.net, gnoack@google.com, paul@paul-moore.com, 
	jmorris@namei.org, serge@hallyn.com, aleksa@amutable.com, legion@kernel.org, 
	david@kernel.org, sandeen@redhat.com, ebiggers@kernel.org, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev, 
	linux-security-module@vger.kernel.org, sunjunchao@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026 at 5:44=E2=80=AFAM Huang Shijie <huangsj@hygon.cn> wro=
te:
>
> This will be used to replace the explicit sb->s_inodes iteration,
> with the caller supplying a callback function and a private data
> pointer that is passed to the callback along with each inode that is
> iterated.
>
> A single iteration function, super_iter_inodes(), is provided, with
> the iteration mode selected by the INO_ITER_F_UNSAFE flag. The
> INO_ITER_F_REFERENCED flag can additionally restrict the iteration to
> inodes that still have a reference.
>
> Without INO_ITER_F_UNSAFE, the callback is called with a valid,
> unlocked and referenced inode, so any inode operation, including
> blocking operations, is allowed. The iterator is responsible for
> inode lifecycle management, so the callback only needs to implement
> the operation it wants to perform on all inodes.
>
> With INO_ITER_F_UNSAFE set, the inodes are iterated without taking a
> reference and the callback is run in an atomic context that must not
> block. This mode is for internal VFS use only and runs under a RCU
> read lock so that the VFS inode is not freed from under the callback.
> It is needed for operations that require tight control over the state
> of the inodes they operate on.
>
> This mechanism allows the existing sb->s_inodes iteration models to
> be maintained, providing a generic implementation for iterating all
> cached inodes on the superblock.
>
> Signed-off-by: Huang Shijie <huangsj@hygon.cn>

Perhaps SELinux could also use this to replace its own inode walking
logic at the tail of security/selinux/hooks.c:sb_finish_set_opts()?
