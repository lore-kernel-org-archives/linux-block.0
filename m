Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD58122541B
	for <linux-block@vger.kernel.org>; Fri, 21 Nov 2025 01:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763690181; cv=none; b=QSvt0XUj0JM1mn8OJpRq/mCj0fujD/OIKhFgkJyxEnVsDPfhxi4wBg9CZ7WFa6r4/hY9gpsuRkU58GG5TprHw3l64nuKH6OUXOiEZAcjbq9gxfpHHclosm0XHa48mFsiaH2tONU4onFBXgjw9wucJcvpXlHDejYYsPx+87hMT5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763690181; c=relaxed/simple;
	bh=gl0loKjQKXWlftC/MCyQXru7c1eWh+YwgoyRhwZB+zg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YsXmRKBFQcd/q0rUZN34S5Rhu1Sk+g6uoZ9L0wOVA/3o9J4JY57e2HSH2O0E/Wm5mxMV5RQCMa2k8gQIKMq4akS3b9vXFn+YVwytr1vh2rDpjbEa4qly5tTVOWaiRWOTbNPVQfy2iQAijDRxkUz6Bxe7Lf67QsFdex2yehEZ4J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=EqgaJExA; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EqgaJExA"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7baf61be569so1774519b3a.3
        for <linux-block@vger.kernel.org>; Thu, 20 Nov 2025 17:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1763690179; x=1764294979; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OViwcIPHyPF5+8ML/I7+PMGnT0G2LOCHMTt/vHjdb20=;
        b=EqgaJExAq/HvOAQuf2gPnQk123Qti+QTUaYKq5bxV+c5gMfrORx5MqCVwUGNuWQAe7
         oa65obvY3wKPgD7283Np1J1hBg6gyynF2PENuKAql15EfhGrSHYRAE8+10YTwItT5/+8
         ArtS8mNfzqSZiYvoFhLJOeLoVvPRt3GNE3dtg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763690179; x=1764294979;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OViwcIPHyPF5+8ML/I7+PMGnT0G2LOCHMTt/vHjdb20=;
        b=RhW8ffocKNvr7nSx0NNYjvYRxrOmofg9KzQuPYYz4GTxNfvBqzGEkyE7IDSzC5gEoL
         PNMGfoUbHDi5lOBd1jpLJvHADVtnLYvGdd0AQq05bV+MYMeKrzogZRkCNSuzD5Ov/DyO
         UFz/6wTOVVtW1ao19eFsGJAget1T718xYqB2o1BX7W97I+AqQteaSyDncSAdNN2HQVeV
         RciG8t2gOB2AyEzjSoNbTTVExBGavPYKPyzHvuY3LZ3d+ByWfqM/juxLKFBaGbqxNbxz
         upbtk9ArZmctdpcZm6MrPP9DcIpqM1yMsewl01BptiacyPStK+DosqdZP1zshBgRZDbv
         4NKg==
X-Forwarded-Encrypted: i=1; AJvYcCUgxyqZzgnlPB7r/uPlMvBk0Rbip3iT56ZLXanoZ+VqA4ZjZFPK/DynzPc0RW+kM/3lVojgRimNWvPRQw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzFqjDrYwQNbr6dnxM5E4oJ0CSuSUyO1SJzUWHxQMRrH71gl+0F
	lMhrvZFAIOe6ZPchl6JHR9GqdLaDjBvsqvsYHxBPLVj4O+vbdegioL8h8Y4jhDteCw==
X-Gm-Gg: ASbGncunqtV0wurXdvKMtEDD6Ll+T1DtbPsDwP67LedwTpH/t+w8yoL2yZEV963RqLC
	8fDZwC4KjeoSnENtQ5AKn8ZOWN8eJO8Bn75uNcCkY8G2DobR/LKJGVQCWv96jiiXW4dQE8PGek/
	oiovCJ5/rIdBoLLPHyS3Y9kYZ4F4Vz7U+Ttg/fJDW44WLiW/Gv0wfu+WiLi8rwbP8Wu0EzQMhM1
	8vFCyp16GBg77CmIoVJ87M0qaI0Tmp402fsIdeE5hUCJsMqF7tSujTLiri4FEbMakxfABA856zW
	wBFtCDrEvaxPAH538vmNVNcjAzxNzfhlYrdeGGV71A/JIqiIhGNL9QphF5ch/i7pMXsiow8jEId
	05K/KmYiR2Q86jKlp+hWaEGFRiM6RRXuVJi86Y9EIRLbiio8TtjQAtZtqAXnkQGdkDc7uZJ/Nve
	ZpQcAeVg8QqJSDAMg=
X-Google-Smtp-Source: AGHT+IGgE/KyAZL4wFe5YItWnpbOY1jW/qmnO0UUZOBfVTAHxChcoU8SYw4n2gxRVkYRqbrmyHSZew==
X-Received: by 2002:a05:6a20:2448:b0:345:e30f:d6da with SMTP id adf61e73a8af0-36150f059e2mr471179637.37.1763690179156;
        Thu, 20 Nov 2025 17:56:19 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:6762:7dba:8487:43a1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3ed379558sm4096703b3a.25.2025.11.20.17.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 17:56:18 -0800 (PST)
Date: Fri, 21 Nov 2025 10:56:14 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Brian Geffon <bgeffon@google.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Minchan Kim <minchan@kernel.org>, 
	Yuwen Chen <ywen.chen@foxmail.com>, Richard Chang <richardycc@google.com>, 
	Fengyu Lian <licayy@outlook.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-block@vger.kernel.org
Subject: Re: [RFC PATCHv5 2/6] zram: add writeback batch size device attr
Message-ID: <ajejtr7lff3dcvjrxgp7k3q3rykhjmxboxggldulhkinuqw6iy@pmbo2isvhf4q>
References: <20251120152126.3126298-1-senozhatsky@chromium.org>
 <20251120152126.3126298-3-senozhatsky@chromium.org>
 <CADyq12ypYai3Q2QntCjvp26U_J3xWpO4J_DSV+UwCqLFinkcGg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADyq12ypYai3Q2QntCjvp26U_J3xWpO4J_DSV+UwCqLFinkcGg@mail.gmail.com>

On (25/11/20 10:57), Brian Geffon wrote:
> > diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> > index 37c1416ac902..7904159e9226 100644
> > --- a/drivers/block/zram/zram_drv.c
> > +++ b/drivers/block/zram/zram_drv.c
> > @@ -588,6 +588,42 @@ static ssize_t writeback_limit_show(struct device *dev,
> >         return sysfs_emit(buf, "%llu\n", val);
> >  }
> >
> > +static ssize_t writeback_batch_size_store(struct device *dev,
> > +                                         struct device_attribute *attr,
> > +                                         const char *buf, size_t len)
> > +{
> > +       struct zram *zram = dev_to_zram(dev);
> > +       u32 val;
> > +       ssize_t ret = -EINVAL;
> > +
> > +       if (kstrtouint(buf, 10, &val))
> > +               return ret;
> > +
> > +       if (!val)
> > +               val = 1;
> 
> IMO a value of 0 for the batch size doesn't make sense, -EINVAL?

Ack.
