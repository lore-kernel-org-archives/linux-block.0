Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027CA2F28EB
	for <linux-block@vger.kernel.org>; Sat, 27 Dec 2025 12:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766837434; cv=none; b=JDazIDR8RQccInq3ROLzYrsm2p3ByGpvx3U1Rem/C21KKqwXSw4EpntA9Ww/d9LbfdFmc9LqunW1rEfGB4Qve8j3yOwYCnVPRiGPrqCAp/S/HUe5ReXk8fEguu+Oej2wAwS/InEDhJMaNlouaJNLgQmz0dhJEtEh51r/b6T4e+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766837434; c=relaxed/simple;
	bh=7hiHEIdy6rvkB9oH4YPX92zTgWCUmJgH7/Hxb4rfTX4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u414wU7VMkDsmCTQH/6HQaTBNnyiQ/6z/3vJpE16+AzJKQTKGYcNQ0WfZUTiPEgWl1/uSBbB3jd46SaUJNCIVxE7axdUCHgBKm9ndd5HQmsgwEoEUdPANqhUnHfpZz8fZt3DdiN2xD10KiUhpgzhu7CmLCh+ZYVe+s5VJQFE6lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LdrLsgue; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=oxz0HNwr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LdrLsgue";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="oxz0HNwr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766837430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TvOsps6cmPfIY1d49bXX2hzYUiz1m4GNX0Yr8eJPMkc=;
	b=LdrLsgue68ZYu0JuyQRU+LvSh9Ln7F5JnxACTzSX911Jc4m5UogGUUXe8azhcEV2tSQ19V
	yqeOjn+Uga4H6O6PhUfup8CSfAE39+E4ms1vjt/KNvwnHN+REFAfMI+ruQ/lKOFUqWepIh
	6n/Y9H7lWhqwWJNWzhbwTYRsifgI23k=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-170-12BNnNS5OlqrvcpemUmUtw-1; Sat, 27 Dec 2025 07:10:28 -0500
X-MC-Unique: 12BNnNS5OlqrvcpemUmUtw-1
X-Mimecast-MFC-AGG-ID: 12BNnNS5OlqrvcpemUmUtw_1766837427
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-5943838a6a3so1321064e87.1
        for <linux-block@vger.kernel.org>; Sat, 27 Dec 2025 04:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766837427; x=1767442227; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TvOsps6cmPfIY1d49bXX2hzYUiz1m4GNX0Yr8eJPMkc=;
        b=oxz0HNwrJ7+Lm18OYghcXJy1K6KRPKtD4ZEFp2f8LpHVXcVIregdNoLxCf98ZsG2rV
         xsZ3fZ6hD1nzPuXAtx4XEWCsk6Z0quNv9pPf4iJnXUUk/7WKb9+PxWV/7oEesqgGmAfm
         iDdw1lvMgu0FoaB3Et/K/b0VlhAuGMjRGylGaEukB+lYLFp8kfyLiBCHRVDg02XnYE4J
         qtkmorzlDL7VXgVPf51rafAYu5DNjbGNf1+o2EFtCfI/78zcxCb32dzkZxLPYZBFPdZh
         b3rlWqlbL+i2RLlMbrpiREMxduUIT6HTuNIjZtZdqb7S0DwlfcWHrt6SwNFMshot4i6w
         sKEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766837427; x=1767442227;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TvOsps6cmPfIY1d49bXX2hzYUiz1m4GNX0Yr8eJPMkc=;
        b=I9nuirUNAMoP2tXjxPWctJE70suYKvCq780IEdeYC6uaDpqoGkCpO6JLPk3NJ0DFBD
         lPujYZ+un7hYnX5C3uNYt9/g4Csptzo0PHzEFQBWiEeeySZdvA5eHj+0u7kiCG+zh5sj
         8j7T7LetS/6+Y9/0vwUMz4gXVM0aA9jVtqr6xGZrJu3EBMcWj/wI/5zaa+eeC8eTMk71
         Yaxgc7ZvFtFrXlyji5PzvTu3PJBKf+OXzcjc+eq44L1JS4QJP4W0K0zAVuUXu263Zs72
         75ymot6jyiM7mBb31fR8OhFW2xWj68uwkt9ST/oP6fi+kAMUgCd3BWaUYEmwGERpCpr7
         S6VQ==
X-Forwarded-Encrypted: i=1; AJvYcCVf5alauceng3HlH5Tb/8VNGV13M5fxxOxFD7otaN7b8z1xpT10AFgEhk1QZtVBNVNis8Juj5jqGrmxJg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzWj4tORd2dxv8qBOabOKefhbNyHLXQ0wPAT4/lZeivuOwWV6n2
	cg/UrNyMKqh+eS52IJBfqiD7/cBf+0V7/4tqaFxdWYs4y4O5C+FfZi65+KCe6SH2RGRvi6PR3bT
	AwCWckbIWZ1O+8EoBiAFM3OciQfuM/qgoNcGArbL6ktlhC8au9HnK1OUCAEeXj0BWaNW43flXFq
	X64nDdB6MjV2E24oi7yM9i0Fyn9MVKqV1ZYVrdT3o=
X-Gm-Gg: AY/fxX4LAc7ajic2/IBKBtsmwwX6C0+GbOufm1yUEQ3QsVsDzfl5pOvescUnSyTvKg1
	9JMdea6PqCwvSiMurDzwck89TKfdfnPvwWZQTkpyHy0rjEL1OwlhKCP6yvQ6wiUPWGKbGXepRII
	ILwKq2u5qWZtlxQkpXkHdmVcX7cbEEJxmcQILqr5URzpm02++dnAkoTpZtTI6PcHFFrXk=
X-Received: by 2002:a05:6512:1446:20b0:598:f1be:7e1b with SMTP id 2adb3069b0e04-59a17ddb4f3mr7034684e87.27.1766837427078;
        Sat, 27 Dec 2025 04:10:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEx+do6hym2GBt0SdC9GHHeXpYJbjfN5KO/klGde6KECeXB6L8RYRK43lxXz8zZZ4d1FOBeeO21xgXUDKy9ofQ=
X-Received: by 2002:a05:6512:1446:20b0:598:f1be:7e1b with SMTP id
 2adb3069b0e04-59a17ddb4f3mr7034679e87.27.1766837426698; Sat, 27 Dec 2025
 04:10:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHj4cs9wv3SdPo+N01Fw2SHBYDs9tj2M_e1-GdQOkRy=DsBB1w@mail.gmail.com>
 <262c8ac1-e625-4e4c-8b3c-85f842aba6fe@gmail.com> <7d718bc8-64b6-4e8f-bad7-7e1615c577ca@nvidia.com>
In-Reply-To: <7d718bc8-64b6-4e8f-bad7-7e1615c577ca@nvidia.com>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Sat, 27 Dec 2025 20:10:13 +0800
X-Gm-Features: AQt7F2pQQN-paPTMMBs5zAdwkh45Y8piwyH_iEGWsTo-SVLxEQoYcfscwKHfBCE
Message-ID: <CAHj4cs9gBTHLB_7JrFpZnJ-imc7jmqnhZpqkemaRVQYLn9j_rQ@mail.gmail.com>
Subject: Re: [bug report] kmemleak observed during blktests nvme/fc
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>, 
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>, linux-block <linux-block@vger.kernel.org>, 
	Daniel Wagner <dwagner@suse.de>
Content-Type: text/plain; charset="UTF-8"

> > Can you try following ? FYI : - Potential fix, only compile tested.
> >
> > From b3c2e350ae741b18c04abe489dcf9d325537c01c Mon Sep 17 00:00:00 2001
> > From: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
> > Date: Sun, 14 Dec 2025 19:29:24 -0800
> > Subject: [PATCH COMPILE TESTED ONLY] nvme-fc: release admin tagset if
> > init fails
> >
> > nvme_fabrics creates an NVMe/FC controller in following path:
> >
> >     nvmf_dev_write()
> >       -> nvmf_create_ctrl()
> >         -> nvme_fc_create_ctrl()
> >           -> nvme_fc_init_ctrl()
> >
> > Check ctrl->ctrl.admin_tagset in the fail_ctrl path and call
> > nvme_remove_admin_tag_set() to release the resources.
> >
> > Signed-off-by: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
> > ---
> >  drivers/nvme/host/fc.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> > index bc455fa98246..6948de3f438a 100644
> > --- a/drivers/nvme/host/fc.c
> > +++ b/drivers/nvme/host/fc.c
> > @@ -3587,6 +3587,8 @@ nvme_fc_init_ctrl(struct device *dev, struct
> > nvmf_ctrl_options *opts,
> >
> >      ctrl->ctrl.opts = NULL;
> >
> > +    if (ctrl->ctrl.admin_tagset)
> > +        nvme_remove_admin_tag_set(&ctrl->ctrl);
> >      /* initiate nvme ctrl ref counting teardown */
> >      nvme_uninit_ctrl(&ctrl->ctrl);
> >
> did you get a chance to try this ?

Hi Chaitanya

Sorry for the late response, I tried to reproduce this issue recently
but with no luck to reproduce it again.
And during the stress blktests nvme/fc test, I reproduced several panic issue.
I will report it later after I get more info.


>
> -ck
>


-- 
Best Regards,
  Yi Zhang

