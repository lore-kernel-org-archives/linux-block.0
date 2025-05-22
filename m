Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA1C13BAF1
	for <linux-block@vger.kernel.org>; Thu, 22 May 2025 14:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747923409; cv=none; b=GSfCqvtpPI/tOd2VIQrhJ7KEkYDcyuRNjNBOzNqNCDbQyxA7oFWI3zVYmvQ0sl2KP1ZHM1PNdYAkC/b0IMyYUsdqMBbu68fyMLUEVCvjOiAPZQIseWwsW4rbnp8oTjb8VKwa/P3WVgdKC07axuqFgr59u6JXjmFVwJSwq0WvGuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747923409; c=relaxed/simple;
	bh=avaoqQUXxX9oUMSN+JYXv35pK1GslmAZHtJunApYpO4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ax8AFEjt09u0huzGZ4EaGm1ujwnGtlyyqA/YkG2V0lnMe4PQG2Yakf2y87/GDYJd7nR2SRmHaTYlf6SfkxvCDcavEUNcER3eEbu1sy3UV3dL5Q1zZGliG3zThrGzouKH2pYjHOXJVG2/kD72T4oAHQ6BFKeIhxb7hzi6Pi2otOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=UXMSQ13T; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="UXMSQ13T"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b16c64b8cbcso1121842a12.3
        for <linux-block@vger.kernel.org>; Thu, 22 May 2025 07:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1747923407; x=1748528207; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=avaoqQUXxX9oUMSN+JYXv35pK1GslmAZHtJunApYpO4=;
        b=UXMSQ13TBu2W20WqZi54ywZHJxKSwEtu8HQrhiBonfIPPBT7G78meY1GMH99N0R0Dp
         JO9SS4Hfsmj4IhOq20ZF/BflpQ7DUUPrepSZu9bIspmIEoqpYghKV10bi4/eUiCjE7PX
         cA9zRKvAm4OK74eV+y2NFRNhchstJ4W32kQkAzmOHMdGu01+fHUKKruQ8tDYzbj7yL0B
         Cm8OOplltRbusGnO0RDlrdwwtx0G/4L97ZCoa8GEpKU3qZ/1t/P3hNPWzVuqkmYBjykP
         K2MRu/NK/JQJv8ohrGMvdn6rdMUZbp8EZIwALhVxarzwO1Xl+eIYd0zIlqr1a30OFwzl
         rH8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747923407; x=1748528207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=avaoqQUXxX9oUMSN+JYXv35pK1GslmAZHtJunApYpO4=;
        b=PS5UKuND75tTTDKHKOB+VBL590FoVMe8KmDWHxfmPgoayXpSeLWHSarK5NF9DZyccO
         279WBmw4wgNuSWh9tQFXVeSGFv0yEsnVnUsGLyOBrOVoK6prH64s6BRmxfi6dsMn4Uaj
         Lj3wo8TobkU6mv4gxJilyCNfPpVvt4HA345Your+SfH3Ptxsb32h53ZncaWqW+Q8DyuI
         +E+eTrhGMOoZDEEbj8XQcpiyzhR1/MKXMYlD0xnw6nP+JgNnN7vG4XLQtETQGEx3qpMb
         /CI0AzrNDXlK4cvkz+6P26nrsD8fw6aMcvF4RrLWh1o7KFbBuSJ04YpR0v4u08HNN2lF
         CmUA==
X-Forwarded-Encrypted: i=1; AJvYcCVmpretqKD19depcgktVr9ilW63eykhOCQqqMua89COUYg7FfLD8msF/IVEVuBt81orzjZLU4nbQ1Wsgw==@vger.kernel.org
X-Gm-Message-State: AOJu0YysX/8xbN5Ry4kik3Xb89aDUg7vFTWXbRRswiNbcQUIma+B+jdH
	ePWPV+IC4/X2C2zjQFKYwOU/JwGDr5kLaCOWhoHgxPWk5Lb0AuBo2twEEHW7A8yKNL4mdCQd2W2
	uil15B6r0N8mdRQQ+jojf5j5CE/jiXSRHNpt6wQgQGrfIGm4Oz6Fc
X-Gm-Gg: ASbGncu6MHIQyVW9r/L6fZzoil98OZblTL/AmvFbI4PXb71vQwC59vnTLl71FAMTpGf
	+YgIexhijh6FdQEhyGTVV5E0iPD+opxZv+qPZC6rvQJYqTcwdpekXul+Ng4iz/Blzp8az0XOnnp
	fYK5wv7U3GWk4ZUyxTTBDN6hyh9WyjKC4=
X-Google-Smtp-Source: AGHT+IFn230/PKJZsGRuxo11zZ+JeSHOoNGGnfIVQoI+Qv70Y452zzlcAff+q1itAyKInAytfcjBAK7DbbYzYCCyHpM=
X-Received: by 2002:a17:903:2f43:b0:231:d156:b271 with SMTP id
 d9443c01a7336-231d43a65e7mr131841975ad.5.1747923406935; Thu, 22 May 2025
 07:16:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250521223107.709131-1-kbusch@meta.com> <20250521223107.709131-4-kbusch@meta.com>
 <CADUfDZqVeaR=15drRFvdrgGyFhyQ=FtscaZycVrQ0pd-PGei=A@mail.gmail.com>
 <CADUfDZqC0kiLTDFv3kXNaDr25rb+6RGG3cW3r=mox2vdihpsow@mail.gmail.com>
 <aC6Ymfrn1cZablbE@kbusch-mbp> <CADUfDZr8DJUPhLvVFK9OPSv015VDSBGNv7z_rrioHFAqOALUOg@mail.gmail.com>
 <aC6oR90OFDSITndh@kbusch-mbp>
In-Reply-To: <aC6oR90OFDSITndh@kbusch-mbp>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Thu, 22 May 2025 07:16:35 -0700
X-Gm-Features: AX0GCFvNqnF_XxkcA7L7Svsfe06zE1TUnGBTF3YyWXFV7MLgXmZgc53gSM_Pbfs
Message-ID: <CADUfDZoA2dRfzEQ-uaTUfVQ+QYa-7RGfUZGYGpCmXDJVSt97UA@mail.gmail.com>
Subject: Re: [PATCH 3/5] nvme: add support for copy offload
To: Keith Busch <kbusch@kernel.org>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org, 
	linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 21, 2025 at 9:30=E2=80=AFPM Keith Busch <kbusch@kernel.org> wro=
te:
>
> On Wed, May 21, 2025 at 08:41:40PM -0700, Caleb Sander Mateos wrote:
> > For the record, that change broke Linux hosts sending DSM commands to
> > our NVMe controller, which was validating that the SGL length exactly
> > matches the number of data bytes implied by the command. I'm sure
> > we're in the minority of NVMe controller vendors in aggressively
> > validating the NVMe command parameters, but it was unfortunate to
> > discover this change in Linux's behavior.
>
> This is a fabrics target you're talking about? I assume so because pci
> would use PRP for a 4k payload, which doesn't encode transfer lengths.
> All the offending controllers were pci, so maybe we could have
> constrained the DSM over-allocation to that transport if we knew this
> was causing problems for fabrics.

Yes, fabrics. I would be fine with always mapping the full 4K data
length for PCI but using the exact length of the ranges for fabrics.

Best,
Caleb
