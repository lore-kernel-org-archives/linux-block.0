Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C523745517B
	for <linux-block@vger.kernel.org>; Fri, 16 Oct 2026 10:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792147301; cv=pass; b=pS50WnuHmsUBIZ7RDwpD8ASo2/gCs2np8X5XEgJgwdcSfnei/e8phsEJoqVlOtumfNPxg4j4z3tem5vpfZIvA9ZtxHR+3mH1Y2Gz5z6nSSqte4uuWS2zxv28n2uYmIbTMk5UezXssv4/5YKTeevU7oD01bdCR936NPh+GS+yaic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792147301; c=relaxed/simple;
	bh=yidpPs+IlsFe6CH8kkeaYDg9/bA2fKGHlODzWaB+2wg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fvzv2to4z9agAxSZCeNudcxqE7Zhn7ztC05bHGbjTTp3IMk/NFQSMmCJP5oJtlHX/QALhgyC9/4elKjzZjC6rb+v9R8pjq3rO3zVmJMTTD+MXqOcVEtrVgVsVmhBvPaNVLcx3i/K53mp2Gl1y4HgSsy5wWakJxQ03IRQkGitYD8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RcBzKwY+; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RcBzKwY+"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6af8620a7d2so7500420a12.0
        for <linux-block@vger.kernel.org>; Fri, 16 Oct 2026 03:41:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792147298; cv=none;
        d=google.com; s=arc-20260327;
        b=A8Ewq5v05gcq9ILhdMtWH8pBaROLwR48E/euqBisN1FBxj3F3ki2vlFW9JpQ7Cm9qs
         SwSiwq9qvxHsxf2BZzOc0ZYh4NSUpz7OYCO9mfHZ6B46N3bhwdzclANq7+MGFdli/8q7
         Dr1Ta6Qr/+lKopiN4sA7B5xpaAxWarAvYkGTik8OU8WXtACCHuOTlKMJXN5jwkZ4ikXB
         fC9NJic3E0lXvunMIpj0jbplbgHa9NGUtFLwUzV6uDvnz9cBcnSNtTx2lwvEqEPbZaIj
         Kwxlkce2g0jwps/xY634Bcoj6JJHw1CpV0e2R6MBN8fhwj4fh9YbQbJrnZPTcUfYM9UC
         /O4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=yidpPs+IlsFe6CH8kkeaYDg9/bA2fKGHlODzWaB+2wg=;
        fh=ve1Ps200Dj/lmSzpWgNvNl1Bm7Kbxzq+Sbk76/JhiP0=;
        b=Jhvk/UOfwopLRWORPSbkLWM4bhFi8pZbOLgN9EBE23qKrQ1bPgEkbmjF2z2cTp14zV
         UxqAdnkBLyMsf0ndjvGMJ7EK38u+s75AnBEm0K6rshrthmtG0k+u0t8omVJ3rSVsXTuU
         hvINbnfB5tNpfF5NTaKCxvT7I6SjA2CiG9lc4H/+57E0xJ2lLr0veg3ZgCrXIGjJutTD
         KG1ebK8/eImfrHMhWY7czNITI7l8K1EDqsthSpkvpmCY3OeFq6hBaE+Xx9hgsWdgdhCi
         toel6jwFdr60F3DyfM+xPiB/iLzxUDvxfHgU6qB65Nga02oPu8/TbovTwo8HKOnODw+4
         VMSw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792147298; x=1792752098; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yidpPs+IlsFe6CH8kkeaYDg9/bA2fKGHlODzWaB+2wg=;
        b=RcBzKwY+Re9tWtfa3LP0D4VBWpIl57mAaetOXQUUvAaPyeKXHX3ebbgSxJ8XfJg3ux
         E5Xn0NAdxhiEFDNt4bWUFd2XQ+5OOphkUMSz+vYAwZlzYC/atRSzB3AFZYwEOcdcukb3
         Om5um1lV/P8T1l6d2eLExlhTwiLXRGf20atYqoCxodCjEYuWq+lrL/FP/9UXEEdIQRIy
         1m4de4VAkK9YCj/71TebV5dVl/GGTgIzr/qs7KLh3SqKWQWn1BIInB8XQOflXshx3rnP
         heNMC011u1kC25hxBSWpUWeWUFBBnVnNBvo0Syjg0lvjFRWv/bJ6ML0tFEq5nPuVqCPs
         eu6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792147298; x=1792752098;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=yidpPs+IlsFe6CH8kkeaYDg9/bA2fKGHlODzWaB+2wg=;
        b=bcAOE5FNVsD9lxfYEABsjl3U/vfbh0mRClvXecIaq5JSXgmK94nN983FplnE7ktIqO
         u+RiqFTyFU/i4bxzR0CvraUhk1eTIm9fnrf7wriHvJXkD6Mgd1jG2csFs8AlmiRco1Zi
         jYWuMBQE7suvRXqRefFNnCY18rDDfgCeTF+2ktQAUMZhqsGVgt5kmURhbWH6iMmxheGA
         IL69H9zFLXJHLGr735ZeECwSMB1+JAM4bfMfqGLqoHDefCXaaswoMDGRM7xnft4vzVdC
         o7FhQpn62zTqMf5pxPRqJqwy96K12GxZoogdhp2Cp2dw1/n7KZcvHi2D9k7+jN94kd0L
         LVUA==
X-Forwarded-Encrypted: i=1; AKwUvByJ4mgmUv3XabQvGhdLls5udlG9m629sXc3iLkxIHqTIsrdYU7qzhl37KDJbZ/eHvC0/ibaVulP3/FHXQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYIbYdkn3PLlxs/FnlB+ZrJ4rFbW9/TFJRvDob1/NncNFN5n7K3D
	wSMU0utuIklKNtqNEwfvgeXuG4+8U4sXzT3peJxnM9PdGqqiFkWAgKJVy/mlK/CZoww485Nk0wH
	wd34TD5CCZIcTlTQMoek2H7pkaFN5kg==
X-Gm-Gg: AYBFou27472ipJEfx2D+b6fK6YIhPKF8+dYtsx0nQqGJ/Idy1gOf6j6U0yfbv1MPWkv
	2DQ4kVL41kSsWMKzi3csVB+A/NvLLnP7td32slMGeZNq/UGZGnvRq+WagBR6SOWEFP4ndyT93TN
	N9mbZ6YRRmauAVzNywqwB4stcL6Gi+sKS9vSfEcbL5kRdF+69rTPRU1WnyamiyB6ReD14ryXtsy
	byPGVJ6L1C0bOyjutbet9orU6h6etBpR2m0Gl5bTh2VqeZ5oPLgNtZDPlE6MN5m9wi/3mCoOwxC
	C4el1OHUPhmTnAEiNmPUlPP5puq6PLjFE2RZh+h/zn5GvU9f+O9S1DbiCYlfkbQGHEGRr2NF4lS
	E2ekJsa5J/sVFkaRgZoLKSB71IzS1mL0N416F4LKZ
X-Received: by 2002:a05:6402:2101:b0:6b1:c355:c7c0 with SMTP id
 4fb4d7f45d1cf-6b1f9998b4amr8172527a12.26.1792147297855; Fri, 16 Oct 2026
 03:41:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261016103453.1129150-1-anuj1072538@gmail.com>
In-Reply-To: <20261016103453.1129150-1-anuj1072538@gmail.com>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Fri, 16 Oct 2026 16:11:00 +0530
X-Gm-Features: AclHuK_TBuGnsWkZyqNlpbVsORRdkyu1KED6frckw8PX5cM8wShBEPc2Ia-Ogs0
Message-ID: <CACzX3AsAKsYsZr7DoDTBYi6H2gYMzkktNkMi88O5GD457XxmHw@mail.gmail.com>
Subject: Re: [PATCH] nvme/io_uring: enable dma-buf backed passthrough I/O
To: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, axboe@kernel.dk
Cc: asml.silence@gmail.com, joshi.k@samsung.com, 
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, 
	io-uring@vger.kernel.org, Anuj Gupta <anuj20.g@samsung.com>
Content-Type: text/plain; charset="UTF-8"

I tested the dma-buf backed NVMe passthrough path with a liburing test,
available here:
https://github.com/anuj7781/liburing/tree/rw-dmabuf-pt
