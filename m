Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267E3346784
	for <linux-block@vger.kernel.org>; Sat, 31 Jan 2026 13:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769864448; cv=pass; b=pKGlozRpfngCNzVxoX6TrIDAwhcpNBYI9OocE+oLo8bQRK/m7t4YYiwCqjw1LpdmyBb4PnR8GpCAmoLm/V6oSye1EkP9VBwzzl9NJxWJJuS/EKQlz0Y90UOGGmz9gx+IYOl8qW1rlPSgpHc0TlEvIqARtWSldQYDR0KWd7o16sc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769864448; c=relaxed/simple;
	bh=fOY2JEQruztarJSs+CpUaPjoo04iDMlrNoAiyRG/Lls=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vFOxxYwZnG2aVnV52DVlPBfMARw+KlmuHclyKZyqIRtqle5fVm8CzFOWXoH2CZlpYP1uj6GuZ47x725wtUJK9WP8yT/Ve/zZV5QfdxwwjYgYaPS8Aq9G05/mrvDtaJSmzFCNklYGvS7LUANbWtiUEUpYO5S4XT3g0+11RdlvBJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V2OK4fYn; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=luWk8AKP; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V2OK4fYn";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="luWk8AKP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769864445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2xQP5dk/2/EhwE9cPPLJlOMoFx7c2d6aAINy7Z5odIY=;
	b=V2OK4fYnk1CXZ5H8xjElOCHfxZCrFXHKmo9kmT64uA4tFgCruzAkoCqOVlAPrbmRCv11TL
	cKNNWUpyEZA727dDhd4aKjMOARKjWGPhI0LZWWV3gelNKvj+OpF8QsIKQeEw79ywi51GKN
	NzSglCiJ8Zn8jCg5NN/BdRfVp5klI2s=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235-QI5Gxa-mN0C4iEOu7zU-Mw-1; Sat, 31 Jan 2026 08:00:44 -0500
X-MC-Unique: QI5Gxa-mN0C4iEOu7zU-Mw-1
X-Mimecast-MFC-AGG-ID: QI5Gxa-mN0C4iEOu7zU-Mw_1769864443
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-385bd85a0f4so25572531fa.3
        for <linux-block@vger.kernel.org>; Sat, 31 Jan 2026 05:00:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769864442; cv=none;
        d=google.com; s=arc-20240605;
        b=DjNKA6PlU05nwlWe/QQohp7gCckbJgEYNBBAoHFXIMl7tMeAaYrVzjrlMH6BW+hsbv
         ylFTJ8S6Lz4n1qJcaocfzl1XGyhklxEG+eoT1YsjYOLgom1loKZRtzlTYab2P7z1vg9l
         aL321sUlQudaXFWIWu8NercuprxN8gTRkQPfPZaXR/AePBCIC8doWYApoXezFiPfO/Kg
         TAE8ewguhyVPQ8GChqh5fOOiXJuqDbEHb///2ORTr5sbyE1EjUDBRDKs0LINLbFK/uYX
         bP0OMMUJJ41nO9JgwdjvkWsU5ayGYMaxT2K4xyH8d0lP/Omh1wdhjLphurrHM10NKs0A
         8ZSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2xQP5dk/2/EhwE9cPPLJlOMoFx7c2d6aAINy7Z5odIY=;
        fh=hrmPSnUMpagzHluRUapVDxLztSdfbTEoPlkhCzMq9kI=;
        b=IUMZM4WJojEkqs+GCQwrtOA0JFTAFHMSP5M1mdVWQRKjlfYqlJizvnLeSzNadkIJ/V
         8LYQP9XyinXHWV4LCdn6ZRWTdh7JCsCw8v70MkGw4OT/37bOgEDj1/x3Nr3jRMYlJ3EX
         Edlo9YHRsGLHyc+L3yDft89v7n0Nfb0BJbJZj7SitKm7VZcVuc2TCjQqEeyzkRz0DNYU
         PHx+U67FEKC8O+adJE86G8bQ2uK1BVxk8Gcg4EKE9hKmyOIYpgEiUmybbrpTW16j5TbG
         FEHux6wLWiWADFzUP7Wpiad7UTt1Z5xxwpwg47RkfNTXumHqmDwK+KtCH0S7IE5VTbqt
         BVfA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769864442; x=1770469242; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2xQP5dk/2/EhwE9cPPLJlOMoFx7c2d6aAINy7Z5odIY=;
        b=luWk8AKPTE5kfpOsG34qbw8CB6q7cUQWMkiosG7vti5WbDzslHGPxuwhmqoDMO1Clp
         tPho6+u/6pl1pXEsmBGYJYd2xhg4oB5R5rVthZbFJprB5eid7VzXjxNJ1Giv7lVKkVYK
         uI6cS118iRf4FiGT2Jg0HRHap79X3nCbofo3+WkJb70xGs6lA9QohBlz/klY6Jo/C9+I
         6slvxRQ2renQAscLHGA6CF4JrYecN14rPsc7L2KB3vtQoxCs7O9qjChGKaSrDdRc7KxP
         sYJR46anGdSO8k1kbMqvjpjuSVEXjp1FgLCXzqQsRMZxC6s2usi6ue3xga4AUAs7BZHt
         PmxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769864442; x=1770469242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2xQP5dk/2/EhwE9cPPLJlOMoFx7c2d6aAINy7Z5odIY=;
        b=L8jinysHFApsxXv58n6Rjk+Ih/GbEYERL7/pkB7lJA5mIO++o57Qic+kq2zdu2IBRD
         RZlxZyk8D20ELLOTdO+BgfvqGmosuZj4Xy7sZzk9VpkQIwg/sXJ0NNNrYK2Rj63HYHvP
         V3/3XcmUr0hMRNmi7dlGndRrx9sa83X/3rGzDt9b0gzlitIrA9I4oCCkWPmR0VAzWw/n
         So1xNSfBpodSppxrGScdjrwGesU/s6Q0I1sDEWOTupSAAGDzDJqLJ+vLQ4MvtJHt0pIe
         eOMC37t8FeJmrzV3hHYiABfG2k9NHvtq4i83GhgriNE/oayQg1aOPwJrL+S6ptsfz6+8
         mqbg==
X-Forwarded-Encrypted: i=1; AJvYcCWFkblhl6h5Yk744mM2SENjSnBz1rUfuSTWPvlwqQyRcY8WDzHB/LU1WQpuXRSCEgvNKLnzaj+VKurv4g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxhnQWmyvf+vQkr9WmPZc3Mj5TjCe2k6NlLhyRrK4dExoAPWfRC
	ea2CVLA9kNMrEGRZgCBHJ5gF2tUwNBMSoXWP8KngnA6tcE4DZbhihca3J43cJN5VXlhkglAQsz3
	rLgzguCBwx2uEGKOff16qCCXirE98ZFQxc45rjE2yQx3mrV8/XxTK1JxlkgVd23JEXd6QDsC8GW
	a5UedP0owz44NZ6tNeZQa3bVQXbbPngqtYPz/UMD+x9RSAK0EgKQ==
X-Gm-Gg: AZuq6aLNZZv/jVSqVoJVGu0l8BW5A0vwu6asY3vxAxe55Vf3QM/Bop5Z3XcN2Z9AWnJ
	NkOo0ltfeRuTxBLWwKugZxl/bMHHwXtyxym/xZBFHZaDRcMyChV/sHotHv0ky8YCVb3DrhyQ8Or
	1LMYdm/9ynq0jU94U4n7qxAXJkQF85w5QsDctl8DT58TkM8/iOugf1VX2fOci6AVPrLhE=
X-Received: by 2002:a05:651c:a0a:b0:37e:6031:4e5 with SMTP id 38308e7fff4ca-38646629907mr19928441fa.22.1769864441657;
        Sat, 31 Jan 2026 05:00:41 -0800 (PST)
X-Received: by 2002:a05:651c:a0a:b0:37e:6031:4e5 with SMTP id
 38308e7fff4ca-38646629907mr19928251fa.22.1769864441191; Sat, 31 Jan 2026
 05:00:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHj4cs9wv3SdPo+N01Fw2SHBYDs9tj2M_e1-GdQOkRy=DsBB1w@mail.gmail.com>
 <262c8ac1-e625-4e4c-8b3c-85f842aba6fe@gmail.com> <7d718bc8-64b6-4e8f-bad7-7e1615c577ca@nvidia.com>
 <CAHj4cs9gBTHLB_7JrFpZnJ-imc7jmqnhZpqkemaRVQYLn9j_rQ@mail.gmail.com>
 <CAHj4cs-84wsWQKeBS2wkd-_Y4Xe7wcTPqzutisNbXtpcAdh8yw@mail.gmail.com> <aXxhkUXXOlrRw1sG@fedora>
In-Reply-To: <aXxhkUXXOlrRw1sG@fedora>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Sat, 31 Jan 2026 21:00:27 +0800
X-Gm-Features: AZwV_Qh-D_qOZQCdgkztGDIsNY17wMdEuIadZQMyNY1-SiMwy1BW9r5UsDTXd9s
Message-ID: <CAHj4cs8ONasnaHgdNPFq_JWaMkGtW714tU-9hYXYmhBEXsib5w@mail.gmail.com>
Subject: Re: [bug report] kmemleak observed during blktests nvme/fc
To: Ming Lei <ming.lei@redhat.com>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>, justintee8345@gmail.com, 
	Chaitanya Kulkarni <ckulkarnilinux@gmail.com>, 
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>, linux-block <linux-block@vger.kernel.org>, 
	Daniel Wagner <dwagner@suse.de>, Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 30, 2026 at 3:45=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> On Thu, Jan 15, 2026 at 05:24:58PM +0800, Yi Zhang wrote:
> > Hi Justin and Chaitanya
> >
> > It turns out that the kmemleak was caused by nvme-loop. It was
> > observed during the stress nvme loop/tcp/fc[1] test, but the kmemleak
> > log was reported during the nvme/fc test. That's why I didn't
> > reproduce it with the stress nvme/fc test before.
> >
> > [1]
> > nvme_trtype=3Dloop ./check nvme/
> > nvme_trtype=3Dtcp ./check nvme/
> > nvme_trtype=3Dfc ./check nvme/
> >
> > unreferenced object 0xffff8881295fd000 (size 1024):
> >   comm "nvme", pid 101335, jiffies 4299282670
> >   hex dump (first 32 bytes):
> >     00 00 00 00 ad 4e ad de ff ff ff ff 00 00 00 00  .....N..........
> >     ff ff ff ff ff ff ff ff e0 3c 57 af ff ff ff ff  .........<W.....
> >   backtrace (crc 414bcfcd):
> >     __kmalloc_cache_node_noprof+0x5f9/0x840
> >     blk_mq_alloc_hctx+0x52/0x810
> >     blk_mq_alloc_and_init_hctx+0x5b9/0x840
> >     __blk_mq_realloc_hw_ctxs+0x20a/0x610
> >     blk_mq_init_allocated_queue+0x2e9/0x1210
> >     blk_mq_alloc_queue+0x17f/0x230
> >     nvme_alloc_admin_tag_set+0x352/0x670 [nvme_core]
> >     nvme_loop_configure_admin_queue+0xdf/0x2d0 [nvme_loop]
> >     nvme_loop_create_ctrl+0x428/0xb13 [nvme_loop]
> >     nvmf_create_ctrl+0x2ec/0x620 [nvme_fabrics]
> >     nvmf_dev_write+0xd5/0x180 [nvme_fabrics]
> >     vfs_write+0x1d0/0xfd0
> >     ksys_write+0xf9/0x1d0
> >     do_syscall_64+0x95/0x520
> >     entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
> It seems regression from 03b3bcd319b3 ("nvme: fix admin request_queue
> lifetime"), can you try the following fix?
>

I've verified the issue cannot be reproduced now. Thanks.


>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 19b67cf5d550..64db8e3d8fd8 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4848,6 +4848,15 @@ int nvme_alloc_admin_tag_set(struct nvme_ctrl *ctr=
l, struct blk_mq_tag_set *set,
>         struct queue_limits lim =3D {};
>         int ret;
>
> +       /*
> +        * If a previous admin queue exists (e.g., from before a reset),
> +        * put it now before allocating a new one to avoid orphaning it.
> +        */
> +       if (ctrl->admin_q) {
> +               blk_put_queue(ctrl->admin_q);
> +               ctrl->admin_q =3D NULL;
> +       }
> +
>         memset(set, 0, sizeof(*set));
>         set->ops =3D ops;
>         set->queue_depth =3D NVME_AQ_MQ_TAG_DEPTH;
>
>
>
>
> Thanks,
> Ming
>


--=20
Best Regards,
  Yi Zhang

