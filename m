Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FCF12E1E4
	for <linux-block@vger.kernel.org>; Tue,  6 Feb 2024 10:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707215028; cv=none; b=jx2SsBfqm48vvQhjUuPJzuDFV2TrdFIbjOnqSjVNujQ97vSu8GRN2nx97NsTcteCE3PM4eOfd+WOek/CTPS9zcasfTJyJK9fimmajBg4ewKdVP4ZK8NeY4gpGVRMbZYdccGvIwate9ySpIS/i+12IJzb7HDceBXsVadgZ8x0Irc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707215028; c=relaxed/simple;
	bh=JQc7I9dtacgIh6dzApcTtL71VyIWn4aWCD9+Rsus/uU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OIqSoo4tjjX9Mow8PZmwEV9QbDx93TDg8r6IfuhOdW7odKiuag7cgCDAUxXDoAt/BEf3gypT+luDeJlzWN/RPOdEvdNPJMtLrggLTDDPOqzZPijqZ3E3LqoHDaydNoO1J/YcnEPDQ2a1s2IEmfySrAuwOtjPjneL0YCyheFecJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AfwUCx/D; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AfwUCx/D"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-4c02bdc2892so183254e0c.1
        for <linux-block@vger.kernel.org>; Tue, 06 Feb 2024 02:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707215026; x=1707819826; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DvZiY9ihexG/Lq+UzYShBWDLaHBQcaLwobbBS4o9zoI=;
        b=AfwUCx/DJRNaiaKS1iipnlPsd5rZMmrz3I0s+8EEhKEvO4fZfrHxyhbJE3BovUA43g
         9tpanRMVnVovsVs3uMjdIu3BWWQRlDzKwCEQa8NaLkKDHYmX+l4DiEJscEkTeSynMpdq
         OOoiFliI+RBOdL6G2hSQpVC9qiI8wPPo+sNZeHE5Ebp+V5AiUEcHGcFQXl8dJylkzs2l
         Gogs5RDRwN09qnCUXn9vG32/kXPxcO78z+ipLk8WsqQvi9Knni5kArfFxxxWkndCrdDH
         Ugju7rBdGrXx5U4xXLXZPUydxBc27pQKhw1DvuXULYMuTlmqPVLF/DG+A+3lo7CJ0Cuh
         rf6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707215026; x=1707819826;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DvZiY9ihexG/Lq+UzYShBWDLaHBQcaLwobbBS4o9zoI=;
        b=f4Izq1TtE/zQXTyteFiqao1C9lda//T0K3/J8jObiOQpdaS1HBHt+IbyZYbcDgvRm2
         SRZZOKsY4gj8A/5lZhy+2ZVoj+toiebdqFOU5+kCuD9ygcp8ZwX4uMs1GZl3jPsqL5qQ
         Eaz5lMbE1kj7VV9m8bIJOwQcSYK1K7EWPrEjzYiuqsF/ZlPaFfhkMl5JMH/jEl6nSuj5
         OGYlXao2Aam9/TLi/IExm6DoR2mXgse6eyeP+t4wX2r17WuOhR7qFOT2Q6zxcyXyVSZf
         OecPdZy3VtvaxNiQug6HWY0nwnywlEdwZukpwW2Jac0YeHXqohhxkRKPIXQLxiJ7Nz7A
         Z84g==
X-Gm-Message-State: AOJu0Yzxn41osfY7lF4DCVB0KgQJWU2VwQUtLYXzHOSj+KXYfYvm+/8U
	kMS/yL/ZpEZdl86NsGYXwY/LX924tKkTEtkk59q5Lmj6Q6C4X25n+prVnobPMt33l/rMqXrrvhc
	kP43nLx7e/FF69+nfd20KlBkx4c6DrXC+wVPlzw==
X-Google-Smtp-Source: AGHT+IGfDOnd2EhP4TWByrQOkcid9KL+1EpEAi8LxcA+nJejScdKhoTZckC004/fc+VBarRks/cvEIzLg7CHcNC2TZ8=
X-Received: by 2002:a05:6122:17a8:b0:4b9:e8bd:3b2 with SMTP id
 o40-20020a05612217a800b004b9e8bd03b2mr1876525vkf.2.1707215025681; Tue, 06 Feb
 2024 02:23:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYttTwsbFuVq10igbSvP5xC6bf_XijM=mpUqrJV=uvUirQ@mail.gmail.com>
 <20240206101529.orwe3ofwwcaghqvz@quack3>
In-Reply-To: <20240206101529.orwe3ofwwcaghqvz@quack3>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 6 Feb 2024 15:53:34 +0530
Message-ID: <CA+G9fYup=QzTAhV2Bh_p8tujUGYNzGYKBHXkcW7jhhG6QFUo_g@mail.gmail.com>
Subject: Re: next: /dev/root: Can't open blockdev
To: Jan Kara <jack@suse.cz>
Cc: linux-block <linux-block@vger.kernel.org>, 
	Linux-Next Mailing List <linux-next@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	Linux Regressions <regressions@lists.linux.dev>, linux-fsdevel@vger.kernel.org, 
	lkft-triage@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>, 
	Christian Brauner <brauner@kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"

On Tue, 6 Feb 2024 at 15:45, Jan Kara <jack@suse.cz> wrote:
>
> On Tue 06-02-24 14:41:17, Naresh Kamboju wrote:
> > All qemu's mount rootfs failed on Linux next-20230206 tag due to the following
> > kernel crash.
> >
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> >
> > Crash log:
> > ---------
> > <3>[    3.257960] /dev/root: Can't open blockdev
> > <4>[    3.258940] VFS: Cannot open root device "/dev/sda" or
> > unknown-block(8,0): error -16
>
> Uhuh, -16 is EBUSY so it seems Christian's block device opening changes are
> suspect? Do you have some sample kconfig available somewhere?

All build information is in this url,
https://storage.tuxsuite.com/public/linaro/lkft/builds/2byqguFVp7MYAEjKo6nJGba2FcP/

- Naresh
