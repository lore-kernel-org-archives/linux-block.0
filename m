Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CE23242AC
	for <linux-block@vger.kernel.org>; Sun,  5 Apr 2026 11:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775388481; cv=pass; b=iCMztvcg1l6WdsIylUtDEL4nabKvVTdpL59YnoZ+MLf5PfjBXbucM1ZDV0o3y9ajXhDQnJzfhM/M5y8z6hsKvdEp9/enrXO2STr2ytSoddNBVfv6XRsKisCHQmxFTTQ9e7lhG76gACoNUZDo9IsrZq7RWpmIdcZPLz+nVsrOZKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775388481; c=relaxed/simple;
	bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oJZkIF5HzfbXwZojP+oiI01edF++pbpp23Eu5g+oH6Nni2uwwKT8I5jFckCynydwXT50wsxhPKefgNeeoiZny/5vo0K62Kchw2QPpYJWEBTKm49Zgigt9sDlTn0r5op4zXgKz5qIzPcRLphaTFWm+PSbuPBNZEYJpxphbA4xD6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jjS9Eoje; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jjS9Eoje"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-66bd4f7b2d3so3675398a12.3
        for <linux-block@vger.kernel.org>; Sun, 05 Apr 2026 04:28:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775388479; cv=none;
        d=google.com; s=arc-20240605;
        b=ABxZ1xxrnjZC1FLN+UT0ukx3WKN0DJygxMP4me0CqAHP2P3cZhOv6vxdF+ML5AzzyL
         ApVZ94TBch17gmIEBZ3jKsXJtlEP4lp6NCCkLw+ccbDcjOoT/lhamD+XKX0gGwybt6DW
         3koud3pt1BQoMxn2cQKe/92YXFyL+Wam4GhqNk6ywCHsQt8xW3fKzctZ7kGjVX9zcft8
         7PJglLKEBT1/1L7IAASm7wa+7pfSv94d01/giwebpy8ezTkmfeFHM+g7bHSxdk7sHYWM
         SOYuYSIAvURt8wuxWJ6a2kC5bqlAhCFvzs46yx05ZrzybQQgIrVf8OQEqCJ6sGG7cqhp
         WhHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        fh=YKTdmXKi/80IW67hkSc6PQFEoRrGFOLhRafnXD0EwbA=;
        b=LhQ2Z1Rc87vHlCjXmbrAdZwGsm8SCu10mDIyvgY6QnXA3cx0qgzs2D4Ud0W6Kr3nEk
         0urtm79NgdAiuGy8A36he1WmjDq+VrkKphJmRRumGx0qjYv3OwjrKnVzTJRU/ldJP2dG
         kd1g4mmEwJgxlFRLcUC5wM1EHWELpjJUlpPfVnRSEtfjGQjcuepT9jYfguPwCq3adJV0
         0sp1TSISVI8eTWY5VGDId/jLCn59Lu1dX0pQ9hcyP2sB4LD43xBnM86M0Vw8TwQeXePO
         jRUnCQeUMRPQ05tTW/HIRzfniDFkb9H2dAJgSFDxNtaGKmvETjP2M18LWn3UXmv5fV51
         Ufog==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775388479; x=1775993279; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        b=jjS9Eojet1qPR5yY/IjndT2lJaD3dpqe/pRi4GbdvW6C0Du3Y3NIDIX76x9DesnTsX
         sFBJsxpk0Moia6w/r8Eax8/VS75YpHPxo6UaRBApQ0u5iiM2xMWAFyKsn6HdCIrpdUnp
         FlciLQzrVLv+5B7Fh0fobc+7j08vQ/uJIB8d9rmUYRNT1rZS3iSTE/k7Nzsf7J145gh7
         gJC6zBtKeNClATmHUS+MBKCg1/dx8YHgDWjTbMMVKbE7mmtvrMVaCt3ijjbZg4MwbdhV
         N1DqYidKYWPOtvJhHy1VXw4/RauZ365gF868Y7VovIoW0TQoRCyZZdae3b4aRh0jdqrJ
         cI5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775388479; x=1775993279;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        b=Yn0dwJquaLbITPd89bjPcY+C8Ai3+uyjCaKHD2a9oJU/OfomX5wympocZk4rLlOkvu
         Xs5/gxoC/103OSuUKtOZC2hsqEUhi/KixtO9YxTMg3dEIqSrx4IVQa4atGhFcQNtFtnI
         IDEgRY15v1AB9IkSmlCyXeoqUbXPTLlHd5UPY9S+qC0IeOvz4ypIY0nHw7jswxHyxy31
         BtesH7bSRdhUvG+nvfnIwMqic2bjyNIDMoy0V7JC5Pxso1PT//vRPTjsVNn/lI95Pbu/
         3rbeH5TPc622ci9KOL5hnXhNFF4kEh59SxiGkn2uniWr5+9k7gSKRnZJpuSGUvRPpOb6
         2+Og==
X-Forwarded-Encrypted: i=1; AJvYcCUwoFD7acH4lBt/yuODDMXqXDfPok6fQAJdN6eNp81J3Lc3OHJqJYmEdbGTUiYKDL6fTn08FxpxjDX/Ug==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc8zztKqAUCQFBgaeliO9cMQOzFG4oOPUVeQyL08aVDkgPY7AX
	c/07ZaLmDGWGSdtVTgooz8tuaP5dduM0gZBhrYYVJklRZ+yXmgNLGRVOBVqMSNXAP60ltl3DPpm
	r2M2WcROnaYnb42luP5IuHbNGgr9Hjw==
X-Gm-Gg: AeBDievErWoQ5AxLYdCNjfhSOMJSa+eTMOH4lhWy9wFQQMMpZat1Z9haRUZGnIv4yqJ
	UJE/msQzc3umSdcjUjtF2djhOQDHQx/Xbgz6xDYPPVVL/1ZOxwuoKO6JqEUvFuSbtZJJjAdPEUX
	59qYDqU097091Eppb6oAnj/xofAj3BMC9t4rjimUi46Zcia7RgYgcKpFARa3vdhSZuSCDYr7xca
	zspKF/Lzh9enfew0Bz2U4u7GYeusSwKa9qOSZbwmgwvb35+8k8yz22yBoUMudtStyc35vUYns5Q
	TAwCuou7v5i+TBqdChKJMhlfaSzI+zaROrVFKYnCjp/NmuUBv/MG9Ep27WgVJ569F0vUAA==
X-Received: by 2002:a05:6402:1ed6:b0:66e:d57a:7023 with SMTP id
 4fb4d7f45d1cf-66ed57a708cmr577928a12.6.1775388478798; Sun, 05 Apr 2026
 04:27:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260403194109.2255933-1-csander@purestorage.com> <20260403194109.2255933-2-csander@purestorage.com>
In-Reply-To: <20260403194109.2255933-2-csander@purestorage.com>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Sun, 5 Apr 2026 16:57:19 +0530
X-Gm-Features: AQROBzCwSmUwg2hzQ9ILQEZ1j4iBp-ZNL42-_yQcEJYC_dnQvWOfGvOnI16w6Bs
Message-ID: <CACzX3Auxb=D1PabMdVng1N7G_7zmn5poknRR-k5r-iJU7aWrGA@mail.gmail.com>
Subject: Re: [PATCH 1/6] blk-integrity: take sector_t in bio_integrity_intervals()
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Chaitanya Kulkarni <kch@nvidia.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, 
	Anuj Gupta <anuj20.g@samsung.com>
Content-Type: text/plain; charset="UTF-8"

Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>
