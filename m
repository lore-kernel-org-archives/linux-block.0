Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B3853A1
	for <linux-block@vger.kernel.org>; Fri, 23 Feb 2024 03:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708659540; cv=none; b=UGl9ei4sSbzHF8YcIKWKX8ZYiAJNtgm3qexr0e7MxPokun2CA7SgR4R7BYL+3zv3gCn7bTlh3uj2pqtj/DCL156Zh6FImWxYfSnnFPxKpBOmaT69sAwoAxSkoJNVMcxEwuayqmXYJqZ0BphiqrhLdj5DMwD5lkTS+eUUmM2VEdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708659540; c=relaxed/simple;
	bh=B0i0+nxfozszHhNkVrDf9L8PZfAFfrk7N7ZDM0M5HBg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p+J2dS+cAT+fA8oCKs/vqEfxm5IB3mIdT3YQvWUAMXl4eh+L7ulsDZvH1r3U+RklMAlOi+dlPpIsF1EQdRAd2z1Kf5JOV8nQg9wGrBEljSDAmdSdVu92ckRrIRhtUntUJdCNzpUtxTLboH5m2HWaEQiB5eq040r8Du25SbxE1pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dlJ/6Xnd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dlJ/6Xnd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708659534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B0i0+nxfozszHhNkVrDf9L8PZfAFfrk7N7ZDM0M5HBg=;
	b=dlJ/6XndNUyXQhOboEYV6IYp7qL6BnH1e089NkTmdYRsg2d94aW579W6a9fJ8whpEoNy3I
	VJC03Gb/LNWvHOqnulC3PuDJKuq88+juSOdXzgf56fPgwYDTTdW5jt2CYBoIEhSubrDu+5
	tBTModpFVT3PXCR1P7feJV00sgYjePM=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-ILOQd3zBMUqLcaWds6YPNw-1; Thu, 22 Feb 2024 22:38:53 -0500
X-MC-Unique: ILOQd3zBMUqLcaWds6YPNw-1
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-46d1e3394a0so100537137.0
        for <linux-block@vger.kernel.org>; Thu, 22 Feb 2024 19:38:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708659533; x=1709264333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B0i0+nxfozszHhNkVrDf9L8PZfAFfrk7N7ZDM0M5HBg=;
        b=HrwTGjcn5BcH/Gzzzf6IYEcqZFOyPtYHBeN7ckG9Ym+1ikCXo2bBNYk1WT9w5lJdvt
         sEOc7Fj7FbaPie4xcrW2UBRHk97BTvQwpU5bODO+zoFdgjYnYmRAEArMyrUoQkd7788q
         j8BaauEBuXF6k3zE2MSjUq0PKZ9pUyh71pDpOMkWSo8blGH2TSQdREW2kOccMqh0uNAa
         jn33HavdMObL/8azRGtvfrEo1zQOKcVckrqpVtTACexIeE3ve8DIT10K+UtJGhQXg2XU
         AbChpiVwOO6t+u0e/rLiY4JCJQk69binDENs0meS7iWwj7l6ypOihyz81dS5ICqdwtDt
         yOmw==
X-Gm-Message-State: AOJu0YxwXXPQm+IJHNb+kZmd/DXQTndY18agWuUBJ5pc4MT9+ApCZc/L
	Jz85ypB4jXcQyXvh/mu5r9wGP512Mo5pizkWxFpAaW4wCD5JMvmNREcY8U5/6yzlHSgu/m3njiT
	n1BTzxD2TEjqEaJeolxMc7wyY2IFflP7OiIAW+04je4Y/N+ktrQH0xRc2wwfDrw4dm1NlyxCF/l
	fw1Ch8SNTYoiV16Y4s2FEX8FfrMHT/kcXjMwM=
X-Received: by 2002:a05:6102:3bd5:b0:470:5f0b:5d52 with SMTP id a21-20020a0561023bd500b004705f0b5d52mr733520vsv.1.1708659532838;
        Thu, 22 Feb 2024 19:38:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFCi7Nly8NrzpaEv3afvqfYVJQF08wqstMO58fqKSzSDKgfROkvjK/2ZA4uqLhyGi/Nv8V2C/TTinOemxNC/5U=
X-Received: by 2002:a05:6102:3bd5:b0:470:5f0b:5d52 with SMTP id
 a21-20020a0561023bd500b004705f0b5d52mr733513vsv.1.1708659532596; Thu, 22 Feb
 2024 19:38:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222191922.2130580-1-kbusch@meta.com> <20240222191922.2130580-5-kbusch@meta.com>
In-Reply-To: <20240222191922.2130580-5-kbusch@meta.com>
From: Ming Lei <ming.lei@redhat.com>
Date: Fri, 23 Feb 2024 11:38:41 +0800
Message-ID: <CAFj5m9JAZ1UMnWkpvR31LUG-Ym76Hkc1dWhc8ta-8wZLWPOOMg@mail.gmail.com>
Subject: Re: [PATCHv3 4/4] blk-lib: check for kill signal
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, axboe@kernel.org, nilay@linux.ibm.com, 
	chaitanyak@nvidia.com, Keith Busch <kbusch@kernel.org>, 
	Conrad Meyer <conradmeyer@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 3:20=E2=80=AFAM Keith Busch <kbusch@meta.com> wrote=
:
>
> From: Keith Busch <kbusch@kernel.org>
>
> Some of these block operations can access a significant capacity and
> take longer than the user expected. A user may change their mind about
> wanting to run that command and attempt to kill the process and do
> something else with their device. But since the task is uninterruptable,
> they have to wait for it to finish, which could be many hours.
>
> Check for a fatal signal at each iteration so the user doesn't have to
> wait for their regretted operation to complete naturally.
>
> Reported-by: Conrad Meyer <conradmeyer@meta.com>
> Signed-off-by: Keith Busch <kbusch@kernel.org>

Looks fine,

Reviewed-by: Ming Lei <ming.lei@redhat.com>

