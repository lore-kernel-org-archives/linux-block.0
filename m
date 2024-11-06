Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B283D66
	for <linux-block@vger.kernel.org>; Wed,  6 Nov 2024 01:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730856869; cv=none; b=jRKWeaeUKl5/5dgfEkliNllh4Lcxz47h9tkYm0pTshiiozwF6jmMAaNjF5fJ6y2dUBvzrl2jJMWXO2YlnBYz0VxjrB8Fp/+vTZPvSqU3lcj5twZ9Nb7m9MRO9mnXpnXZjln7gXagi+bupLfmkqNa6MfrTiuHlIIxKOQdQcXp7E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730856869; c=relaxed/simple;
	bh=CMF/E8yae+LLRnb/qTWJ9AgQL1xKUZbtD1ApFpOaKjE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mXHeBYbsQUancDyVPf50VBKZ9uu8fPBlIEUgBSZM13G3fmf/AAesC+5Snkxt497fB0PFGX/RMbOp1iX7DiWuQH+btA3+pVMPWVruIw8yhRC6J2y/KvBZju0hgPZRAVxZE6Lnq5Fsm5I3Np0uVejKwe0quxUWsrW3RqYUW4p0qCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N3DkdCvk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N3DkdCvk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730856866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/ooQJqlbYM/ySrgPiTM2o1pseu04s91YciPs6oL2YxA=;
	b=N3DkdCvkhcZEAZVFsp1NX+YQiakzzPSErsYL2jqjXcV5Z3Dc9w3vpbyTcAmpbJbhJWCv9p
	pEdm1YB1CaIeGFYu7UTtXC2ODW5dvkSmvnrsQXal44wclCyQ9ftuvYIijIyAIUovQls8y1
	t6TSweozMF/bNslGeivZT32mPk5mZn0=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44-dwg4Ddz9OTisjEBVJleObQ-1; Tue, 05 Nov 2024 20:34:25 -0500
X-MC-Unique: dwg4Ddz9OTisjEBVJleObQ-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2fb4c35f728so48189971fa.2
        for <linux-block@vger.kernel.org>; Tue, 05 Nov 2024 17:34:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730856861; x=1731461661;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ooQJqlbYM/ySrgPiTM2o1pseu04s91YciPs6oL2YxA=;
        b=rThGwihfDcKllFuHNA0yl4owzsGSnR7UtJvtAYRySC8pO/pDR4lN1I4z971MCaij17
         xL5BmfXt2uHbgZkMMThI8HMh7cUyr3VKvYPuAkizSrxQQlpGxUCTa4qPsjWWeWVz/FnY
         y1qGi2Pb+iyDSfT1gN4PnYuhJGVmcfVWFF/tl8c4g1JDDY7aqmy8DsimH+myvVAwtA4S
         NyAEy/slNEFkfMtmAdiIgiAWAT6k09g0YZwT4C1ZDIUsrLPCdQ+569T0xaNEWFApdXQD
         bhifBwy/DbGhEylfs0F6uQIrdZX9dM/dPCCLCLX5ZsSrH/JwSAQ5jUgstxweGbvgJ0/r
         p7aQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTm8Bz80Ca5IMqDVT/YHX3YskOEwWBpspBIxtVBno1SaNFZJfIWg+MThOXu45BILIZc0zh9iHdstwJDQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxTWIF5bG8VmYq5eqHIZmPytkiRLZ1ompH+lA7dwg3r+bSAuc1X
	qL8Yf5/FW9ktiFc5nvjq8WYsACr6oq99nTZFgWCVbklH++BC0FKMvOW7bIgnt+GiNE+lsbx/aS7
	qJ2OsulVCNg2279BxbC1C6W5jOP8K2eoU/91TfeiYQ/i5sVZFZePYV10M9icI4/eV89RmR1+Jvl
	tD+PQmwvoQzMeDAeN2EJG2xgMa2H5hYLDe/7BUeA9hGr1oKdpI
X-Received: by 2002:a2e:a9a2:0:b0:2fb:5ae7:24e7 with SMTP id 38308e7fff4ca-2fedb794b69mr137292411fa.4.1730856861606;
        Tue, 05 Nov 2024 17:34:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFMSRjD0BFPGk6GjcQFn/YJ8mmHxPvY0pShjAW2ZDAdj3GD7z0cHCu5Mi2xlk2PN9cHVtQm4yFUcuq2RmGXogs=
X-Received: by 2002:a2e:a9a2:0:b0:2fb:5ae7:24e7 with SMTP id
 38308e7fff4ca-2fedb794b69mr137292221fa.4.1730856861250; Tue, 05 Nov 2024
 17:34:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105154817.459638-1-hch@lst.de>
In-Reply-To: <20241105154817.459638-1-hch@lst.de>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Wed, 6 Nov 2024 09:34:09 +0800
Message-ID: <CAHj4cs_g=qeZQzZO21ws8gx7iHEfGsSRDF65M_SbJSznKunhng@mail.gmail.com>
Subject: Re: max_hw_zone_append_sectos fixes
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, 
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Verified the reported issue was fixed by this series:

Tested-by: Yi Zhang <yi.zhang@redhat.com>

On Tue, Nov 5, 2024 at 11:48=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> Hi Jens,
>
> this series has a fix and a cleanup for the max_hw_zone_append_sectors
> change.
>
> Diffstat:
>  block/blk-settings.c          |    2 +-
>  drivers/nvme/host/multipath.c |    2 --
>  2 files changed, 1 insertion(+), 3 deletions(-)
>


--=20
Best Regards,
  Yi Zhang

