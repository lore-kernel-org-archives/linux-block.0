Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB94288AD
	for <linux-block@vger.kernel.org>; Sun,  5 Apr 2026 11:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775388447; cv=pass; b=ErDCO9P8X2ZJ8Iu+5XmYON5T6XNgI9mGFvUxB3kbUFyvMnFtNcEBhKmGHCravXHPbs2tgKQOm68yOtbUOuS8ZuQRXjuN7avHPH/mBkbPpsyprBSbRCtTCse/5+C+dwHlZJjPc5uy/RYwjTS3maQ0ScVI60z12aIxA2q+SNlEdp4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775388447; c=relaxed/simple;
	bh=3mKGFGRC8Ir/bEzi2WUjXo1t2+zLxBk0Rpi89ZF+PFE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GejdyHAlvORf0rUH5uFXyVDLTiDaH7OScg/M3IoqGdVacuzxWPumpX5GE4x2FDXo6F3kD32a2bIjK1UZnB0xPAPx+/c5psVBRSe6/78VCgUWxxe1TyTOJ0LGYOAF40sMT8CQHHkvaSIAl7HYD6uDE80T2C5d9O3LTmqI9dSoDsU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p5+LLAB0; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p5+LLAB0"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-65c0891f4e9so1488972a12.1
        for <linux-block@vger.kernel.org>; Sun, 05 Apr 2026 04:27:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775388445; cv=none;
        d=google.com; s=arc-20240605;
        b=GFvioWMryzb7GSeMNvao69RgERUOjeuIdieSs68I4u/3PQTr8bc9DtKWx6HdghbeC4
         wHE8mtzqZvmZMV3qW04F100J6R5NABkcW43ceQVZZxUqbc6OXqMb/y0Kju+vvP1KHCt7
         Q+dlZ9Jr2ZTk6OpP0ZmCqr7ZpGhsICKRDPSiS9oCxCklla/u/PHsn6U9Qqtk2EGdUSH5
         korb+HQTwmmaOBiu+Faall7YIWptD4x0eVvu694TnaoQrmGq/C+9xcU7RhJ2p+pgqhz8
         /TP/WYbeXEMm2MShTe2LCrTMo/bECQ8Qsq6pHr+x10Le9rcAYlQPz+zugRymKc8SKKmy
         PGug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=3mKGFGRC8Ir/bEzi2WUjXo1t2+zLxBk0Rpi89ZF+PFE=;
        fh=ekc0fXs0P9wGjOGGOMpHLSyAg8lPbGtvmwrkY+IItk8=;
        b=Cv6meOVMYlU3ofySPAy75HyuvGdnvLs8qkyzbbU9YelntWnv7eEiG6AYa8m1/9tPLf
         OG2obS8TaOU/ocCpzLwOaWwh8p9WCJXt0Xk+vfiz2Geyob3r/VJtAxFl3fZsmIKZnn8v
         KZ4yAnxnRxY3x8GOnFDIIp5dkPQlxgS7wTGm71tp+ysyKcULijUyHUCvGPDAwu4RU/XR
         aAaEGkjSGf2G/frqTJRh4+h8I/dO7Tigri/yMwth0XU9e3ye0wuuK+r5BNG5QjbNPZwN
         HzEXBFPNVeGeZ/pLGV4/Gp07gBNXHb2udI69JDaVonNA8Y2mLY/ymWxvHjvbwV6JM4dd
         ymQQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775388445; x=1775993245; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3mKGFGRC8Ir/bEzi2WUjXo1t2+zLxBk0Rpi89ZF+PFE=;
        b=p5+LLAB0cpEJCu6nFFEj6V8s+vMqQYkWqDAi7A4D6IwaVMw4vKZPtn0G6/DHa48Z8V
         V7w+KongZq9iS/kHDIjna1ZlvaPyLryFtAiCmIHNXYPKZm8akE6joXvGFOxe2RSSD6T4
         hS6fDiJgWHTV2yJn/egDu9orrvyCmXRgVATn9hcvNwFDwczBMdlpo7Pb+kL6zLT+5Omi
         7UMDGcJutJXOxhKaTdYvgLt78p77slExTu2vdGuLJdcwiPdpdgrB2nSJrB2P60BuKa79
         ZbTYC8gJr25mghT7whieK2vboiv5bOdrJzy/RBawF9pTwqmEtso2+wc2TvPOlg/r1cwe
         LNBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775388445; x=1775993245;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3mKGFGRC8Ir/bEzi2WUjXo1t2+zLxBk0Rpi89ZF+PFE=;
        b=EdmqH4AhRkIbcR9O9Xa2ho1ivM0MPhO3cskATYuniB67wvh+tgfl0c7mYX6f6F+YJu
         SVKJ+SbXwpGP5EmaZ0bM4Ksck6CRsPUSI+aOXJbeooqLBd3U3PrEcuNmxjvWbpZdVkwq
         8KBdeA6G4DFuysV0rXa4EliwmfTh1nKqipK8jFm69gQTZqI1P+ueHAwPnXl0hvOS2LQf
         VNAqoAxEyv/GhgH9013bw+/QIlMuhncfzLFeK2lxzg/2ZHUv+n+ZPVnpkn2VqogHXKxw
         hbPM3KBefq76P9dWIdMfc70dNLFhgvk8jpHEuqOSLh300RB+ztL4KekfyWXNkTryeXQZ
         WCew==
X-Forwarded-Encrypted: i=1; AJvYcCXjl04x7pjFZO2/gheK47PDq1AcbdgQqnddAy/De4u57fKs7IxGb9WpQOPxoW8D4N/v/Oy+yDIRHaYKvg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyF530Lt8FFHN7uSxcYVrPl2gWoSHEKz75KScTqFlNFTjmgulUG
	zlLsDT6YVzu5/2jzaBfuiLX/joUbHHymGm3/B40t4qGwmdi6dAihiwRR8sBkkJ5xkGb9yJ1SRgZ
	mda/xmJfv4dy4uJalZUFTdU8G9GkpPw==
X-Gm-Gg: AeBDiesF7lfuQDdPnriP0X6wwDzdGGLaKo4OsNr6HlUL2uwk7r9n9QOO9FeHdumPli0
	T5nP2uNpk7AjsRdhGqJU+k6WtAP50rFBsFC7h645ozUlT46ShZtjnz/YBaL9nMebr+B2CPCZVoe
	cZwicDMsg+CwiwVMQI7+sHLZlJzQccP2CVfFAjumxZwSgTP+PsjbDIBzJiO9PZar2MQhJUe7xFl
	kAiM7JiwApbXrOD86anTGKHarGXDwUFzU/dw+3xc+D8DvVLwIwroLk+b2ClDv8IRNVMa4hjhIfn
	l3X7V8YjlrWcHnIbM0a433T5kWcXRBgIaKmDzuJmchTiNxeE5C9ZjQDBDYiKPv6yYTh0oQ==
X-Received: by 2002:a05:6402:274e:b0:66e:dfdf:cf1e with SMTP id
 4fb4d7f45d1cf-66edfdfcfa5mr545956a12.27.1775388444505; Sun, 05 Apr 2026
 04:27:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260403194109.2255933-1-csander@purestorage.com>
In-Reply-To: <20260403194109.2255933-1-csander@purestorage.com>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Sun, 5 Apr 2026 16:56:46 +0530
X-Gm-Features: AQROBzDs0E7EbtHWRnG-_oRVFkR49Vyn1zNqbc_cUv_MF4CXocoxU69uiac_8Sw
Message-ID: <CACzX3AvwQ87hL4GOBmpiGDYGqvb9O_HVjkS_e+-jLiJGgA7HPg@mail.gmail.com>
Subject: Re: [PATCH 0/6] block: fix integrity offset/length conversions
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Chaitanya Kulkarni <kch@nvidia.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> The block layer's integrity code currently sets the seed (initial
> reference tag) in units of 512-byte sectors but increments it in units
> of integrity intervals. Not only do the T10 DIF formats require ref tags
> to be the lower bits of the logical block address, but mixing the two
> units means the ref tags used for a particular logical block vary based
> on its offset within a read/write request. This looks to be a
> longstanding bug affecting block devices that support integrity with
> block sizes > 512 bytes; I'm surprised it wasn't noticed before.
>
This likely went unnoticed because the remap path compensates for it:
blk_integrity_prepare() rewrites the host-side sector-based ref tag to
the correct device-visible interval/LBA value, and
blk_integrity_complete() rewrites it back on reads. So for block-auto
PI, and for the FS-PI path that goes through the same remap, the
device-facing ref tag still comes out correct even though the host-side
seed is semantically wrong.
