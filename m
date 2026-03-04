Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112B63D6686
	for <linux-block@vger.kernel.org>; Wed,  4 Mar 2026 18:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772647797; cv=pass; b=tHdKGjPHooSGKNjfbJQFoH+hqQhGuIrV+PiZEgOuJwGUpXqCHnKULvRR07Ol0zK37P1Wa1dZe4nZJFmfFbCDK+F55vjVxqUyzqexgH5MPSfszaqOiamvHc4d6PUD8rEpmg7AfDzBrtYHwkzzyLNH8Sj/afS2hbcIU7JtT9gKRpI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772647797; c=relaxed/simple;
	bh=RalLVkkry4FncaXhIQ16HmZaENLn1C4uOsOfiZ6OFOU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l9Y6dCHB/ZGjbsLIdiiohC2B29Zwn1h2WSGcwlcKNEjpdRyhDQpciuo8Vzux/Lbwp9jiawRwMIGLdAxy/C09Vn6wFn90dUnXbMGwxTcyfx7A+CJAcfI+XPNNNKFBaU6QQrmhGptyyj48MC25X0yTlCoY2CQMDj13dOPii1OoUgA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=je2IXbX7; arc=pass smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="je2IXbX7"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-64c9fcc24b3so5372400d50.1
        for <linux-block@vger.kernel.org>; Wed, 04 Mar 2026 10:09:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772647795; cv=none;
        d=google.com; s=arc-20240605;
        b=FxB22jkjY7B3tVCucwXPsD50fRrkZ9EwD+ojbcaKSU5b6C9oVp9jYIdUf3huvEp19h
         QNDnk5/SUFDCpN1EdYeJxOwhGrkGp1eke/mpLPnVh5IWtrSMBDwjSqGfgpHzbpZW+M3u
         t0atbyTAxyOidG3D3BgXQY8FY4C3RdE/ZDeKAugyR7XBoFnH8QtsQxUGu3JmHTkhBaX7
         zbb7Z3ZWKoW2Jj3ADyLb7vfI/8nsvVAhrYXjDYm/6C66BTnc6DHgeNMyj7exeu1V+c9E
         j81LwnYQGC0KGCkHBPJ2A8p2fjAXorMqvfcqiMD5Hnd1yn0Zh0756FbvAa03kp25cwod
         GLXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/AAP6xDZoNmpLXND/XB3hSZCf89V94pBMhQ2bbUGJDk=;
        fh=Rnnfzo8jZlobVIJKOIcrd2rvK6HOTvJyctEdtEnTYcQ=;
        b=a7tW6eEx1VzBCoKLaq2Thx8AUkYauZVekZ+gBAvDODj/cUbT5VoN+6p+1MGVANO//K
         /ZeJxXWX4gBVkfLLRa5mhV8Pd2N4zyj/MtgibmRrXsKc7hrSMCdLQSpslKbatax5jQs7
         b8cpkpL6Ptd1P+y4D4Hjlp6zoDyK+SWpDgForSxWhJgJLsa44HaO8KAkfVvUpa/gO/w0
         M08r5Gn6XB5sBcBEAm6LOKyAIby0845lABxMkp6hE4FpAdjeuDze9T35lGgfAdnnu5oZ
         +d50kkdxeodeZ3dm0GzWfkZlOgdTlkdgEg/lMAqMAJHWQI055kulU49AiuHkJMBPK0dF
         8u7Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772647795; x=1773252595; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/AAP6xDZoNmpLXND/XB3hSZCf89V94pBMhQ2bbUGJDk=;
        b=je2IXbX7sUK68iTCEqzNDtQk1dXBGuPkLGyezCkAuulDxDToUhQtJ35U0z2pDE+6Ce
         6QB3SoK/IKFi7R2OcgTjWYEaPGC8GFurueh5S3wNMlzCkVsTtV+z3HBXpUx1nkVPkasE
         IeVDz1t5Uedpj8pVcfCUEvch14sHW+63q3X6jBpUQrEr42yi0QUDfuA4+/1ViKxSe+Cd
         NSa7HfpGrPo9uyMQx3eRVEhnubzWUsrLb4It+deBw/N7xNbW/DhAqKCiy7ppnd/u3xbR
         sZ9LLBYdJ1IyV7BY0RTZUuqhIAzyqwefzUF6FDeaWl/vSqF3Xc13khNJG+BNBVtp1dnY
         QBxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772647795; x=1773252595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/AAP6xDZoNmpLXND/XB3hSZCf89V94pBMhQ2bbUGJDk=;
        b=icOcC3ykaOzLoS2lIp5YdRvjTpCwnY1XtJg2WE6XW7YJDk7tZzQOutC7DQZGafag4o
         OiZXZxiXZ663mlyCwMembpbHNo0ENecqsq+wJtFgrqiSPUyFzaJ+ZmteWZ39hCtoJtSy
         vMuoa9FGZjmBB6SIaCb2QOgncM61D8ZhK+UX4iqOMNcUPCwiION2IRJvsUkB8sJL9VC6
         pRIXtRMV75Afh75/2f4IWWTnbo0Dagdc49lztMi4LPEC+bGf/ghhTxMPPMsuQisBR1XI
         S2C4OdYLEW8V//0kpZkTY1j5oT0bNMMLDswB3YkFlEmZOoFNpNKC1eIU9+zNFmlApPdh
         A67A==
X-Forwarded-Encrypted: i=1; AJvYcCUBaYT3WZRjYEyEQvWF2re9XhXPSu7X3kBX30Z/R+V92iFBrDu2cex9xIE3Jk0AlPmSpYmOsUKufysIXA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwkvaO+JCDMXIER2VPnL5PDStX9kZ3cVTBByJgyZQvvC7jno38u
	OMcA6iTrftzHhix5qBjpW7xLP1tRcVjGyqpR0T2J5OjXYh3AOs1tZ5FvSYAmhARfphi2kIT1Itr
	gRQXWUxIlaapaZvcRpV3k6V8elGmoh6M=
X-Gm-Gg: ATEYQzwl1HzYsSWbmDy8MPEqqu40MG6yRI6A22uNJohwVF9C9T2sQIZey/T+l8qayUr
	QYkzIZ54ewL0YgAp2xcr1EbsEzO812ZBMUHji4FSeeOckiWiR8eSj55m+eLaNe/fdx0WWqRrrKt
	Ex1jk8v6ENcNJX37YyAv7J/ThoBBNuXoUYYayP2AwZuGZ20nAALn2DYL/N75Stxlacch78trhjL
	JXzVfhUfI+PoJ9bXdS/Y7+qkmztu732ciJy6rIbQnPRp7kZRceOroI6j/+kXYhUtdWpDfUEtEh9
	7wD//9j35Pc8uyqewdOOi5Jd5rrIALy+YZ9xlDneZeUjC2EScNQ8aj74prl7jtn4+5p8YsbcOs0
	U04Q4iBfnmg==
X-Received: by 2002:a05:690e:dcf:b0:640:dd02:a777 with SMTP id
 956f58d0204a3-64cf9bbde6dmr2328620d50.69.1772647795104; Wed, 04 Mar 2026
 10:09:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260304121729.1532469-1-linlin.zhang@oss.qualcomm.com> <aaguW3p3_LOeM_Dz@infradead.org>
In-Reply-To: <aaguW3p3_LOeM_Dz@infradead.org>
From: Adrian Vovk <adrianvovk@gmail.com>
Date: Wed, 4 Mar 2026 13:09:44 -0500
X-Gm-Features: AaiRm53qIrqqlwryq6-vL-KMtUUaiHvUVdrssaMtyjIxU1gScjYF_6wvmEHxIl8
Message-ID: <CAAdYy_nRbYMsiysC66nrMqFEtEdjjBTdpLcVZBak-M9QL7BK3g@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] dm-inlinecrypt: add target for inline block device encryption
To: Christoph Hellwig <hch@infradead.org>
Cc: Linlin Zhang <linlin.zhang@oss.qualcomm.com>, linux-block@vger.kernel.org, 
	ebiggers@kernel.org, linux-kernel@vger.kernel.org, dm-devel@lists.linux.dev, 
	quic_mdalam@quicinc.com, gmazyland@gmail.com, israelr@nvidia.com, 
	mpatocka@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Christoph,

On Wed, Mar 4, 2026 at 8:06=E2=80=AFAM Christoph Hellwig <hch@infradead.org=
> wrote:
>
> What is the use case for this?  I'd much rather add fscrypt support
> to file systems that are missing it than forcing another stacking
> layer.

Maybe I am misunderstanding something, but this seems orthogonal to
fscrypt? Userspace would use this to do LUKS full-disk encryption, but
with the hardware acceleration provided by the inline encryption
hardware.

Best,
Adrian
