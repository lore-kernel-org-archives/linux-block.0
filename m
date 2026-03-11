Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB583DC4B0
	for <linux-block@vger.kernel.org>; Wed, 11 Mar 2026 15:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773241757; cv=pass; b=sGbytg29K0efTdAfsJT1ypXqq+nnzn8Mnc4lRWumwhUs0pj8PzidurOFWmI7sVFGM1oSCEmqfVXWyr69S3I3Z4v5AcX3vlK6f7QWV0Ms4Hvee7SyYv+uiSgStuF6VkW/6Xa4sgMQIsPkaFW3Q95O5HTyQzao4YJvlG0PZQ2/8YQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773241757; c=relaxed/simple;
	bh=sr8EJ74h+PCWaP6DpleCKt+jfKdqyljjFBE6im8GNXo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EJBPdUIe66aWFBg4GP/LRp6ZfAGkjOVjjxQ9R4tD1ZPJNpxYffFuOz4IOKT0uYUl6LVX1Kjxs0sLvvU1SOY07grNJs+ptSOZExT2ZnJJJVqFmNOooq6dra/+fw3s5dWvxcTK8C91mBQAVa4woD1ATlCvfz2NiUlsrPTLXAEVzTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RL5ZMe+s; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=dB0octQG; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RL5ZMe+s";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="dB0octQG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773241753;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eAixbPiqiWKvxfTtqwLl1ZycNxKKR9XvSIdM8Jl9/1M=;
	b=RL5ZMe+scySmI6MzfpFmiQ/AUch0/RAQh9a0i8rQMWqLtLFeFIgLPBaXuTDNIaI70t4Ufg
	9xibD2hWALCC5foT0fcUG7nGEiXieH8+0h0/kCadEYcMLXMJBvNXtBJk97jL2zntaf7NJz
	9Qu/BjBGHDwdUlbixoHB4dymApb2qzs=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-ZFvMlVbvMUW-m5EDQ8Lsig-1; Wed, 11 Mar 2026 11:09:12 -0400
X-MC-Unique: ZFvMlVbvMUW-m5EDQ8Lsig-1
X-Mimecast-MFC-AGG-ID: ZFvMlVbvMUW-m5EDQ8Lsig_1773241750
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-5a12514a844so12789e87.2
        for <linux-block@vger.kernel.org>; Wed, 11 Mar 2026 08:09:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773241750; cv=none;
        d=google.com; s=arc-20240605;
        b=PK2xxqcbNrl7i4TZTQbBdO6GgdCOZyGzsNYaey/9gD+0wj7+TSw2/cn5t8C7AMDoOE
         tFRAb63duvZa7RouRnuXO+zbR1trVFO9Kqvk6nP5qD3caWlC309J1+VDhAbCaZdH2tpx
         ptwRqeXOFul6E5VCiQjXvuFXBNx0J8hY9hPgWcpZQ8bD03fCZ8OQ2Q6YzM6znHNDYofp
         oZbBGZUQ+Pi4aUgD/lorDolvdRDBW8hZiqjkxrbHmisksW1NhRCyYcdCMeQuhovjdeht
         X+w4Nm83ZkDrK3+l7HdriILlUrYVXXpt1dD1fyU+XlUH8LQ9h41vcuPMRxQmV8hmK0qA
         85Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eAixbPiqiWKvxfTtqwLl1ZycNxKKR9XvSIdM8Jl9/1M=;
        fh=Oerx2B9XHWJ2YAZqyhdRFGLY7FV5FnnPk2S2m32f0hY=;
        b=Zu9UHLzsS2gTWEdvt7ekZayuM58+DGg8MdRALW32AE6dh9V64Y6+cn6c6htVPfy80J
         qPfC1RVznIpwKSHEFvVxSi99PzGqEs9nxZkZkYlHfEny7FSdZP8eza8XG+EWQ6rkbZ20
         pOaPvJqmC+74T2wLzE6hUzbyUg03A1o5Z7iXWHIRRr1flnfk9H89l97HqYUDTxMQr3U9
         P1WETbuJiJhTEY5Ul4PlJZ2LRhABVhrGqU2P/XanJZBcqTL+rQZJVr/HsVG/X2lGNXZj
         eFY4v5ztHKhY8dQurrZNkFSTUwHaTOguPU9gaEUsTIEw6UU3/VmLYWlXRdtO44YeIKMn
         VVNA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773241750; x=1773846550; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eAixbPiqiWKvxfTtqwLl1ZycNxKKR9XvSIdM8Jl9/1M=;
        b=dB0octQGlhykp0hEvoSV8X1man1Mt4I+4ZE/XgE4SjsboNvTB/6bVyWyxaQXB84rsG
         xvF/Z9COgnnl3aKEzf2C6yze/8MdP7aFi9+bn3a5x9pyEHCyjXjSDEO5Vz0GDIXDmN5+
         +VuwxTrHf1g3BvXJcogXBDloLqwS3wQuW0r5MaR/g50LEH/miAXwlMv2Cxxj2zAMaihh
         IiPM+vSqOV3utoJc2Ul0QH9CibmbxZAzZg18Czlk6CobBuwLLmQ+YRZUsbcKOG0oTsM8
         MGkzB6UqkvZbEEXw6Ny8xOLpVtnTC3NZWrJi6bXawOZV67ShUqdL838elWDQsx9O008f
         aDzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773241750; x=1773846550;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eAixbPiqiWKvxfTtqwLl1ZycNxKKR9XvSIdM8Jl9/1M=;
        b=nQ9IMoLmNB1E9DSYw/Wyxhrb303tqh41YUwaBAiIU3TBOmUrRF7n6TxrZfxZj+KYaE
         sXWOzTt/JJzX99rqmwXz+ayJEUgIh/n4VKQGLq7DVzZ5Q+tlqyQezXS/MyoarXU+a79T
         4l0OOScf3Aw2tSTxGsZJObMNfAg7ECqKKB6NCm1lmwVIErXtJf8WO8Ms7aKpRUc5r5x0
         whsM8bXwDQ5TPlun+dbNbt4bEywm8Wo9bgaomvYSBc8WkVC7f3wN0G5vQlD9iK3n+Dx2
         0r5geJ4YVla8k/QwJsUbcfIQHE4qRgSudsEIQ01Ut6StxxwwT/UnhNMtdT99O5VcdeDv
         NlkQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhsDaJkFRnNF24DfyIwRrtNLT7B05PoXiEtRdtlswObQwQPpt1ZE8jw62wcH8lUgvk5KV0zrHRQQT6FQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyYfs8mnfyx5Qmb5X8KD9lP2hybWz4qfvuj+IJKhdo3tj40AMn1
	MoSs5RzmdqVP4Qic3gEjm9wTm2gspEqVKN7ct9F7sXaEZtjlDhb1AtkAgaK+qH7fBlWxA2bymk0
	12uI1jbPPsTx+FTqKqdzNC4py2GvqpmDhUxTbBoep1xgHAZUcERb8k9Tg1sygd20zwmi39wSl/3
	xWLXzRYezh380D8NcOc8O4smfAacwJL3Q01x45DxM=
X-Gm-Gg: ATEYQzy280My0reOUWiXJ5NPB3fEeXbqtGbYQpZBZ4iM0659OXJN9QKFL9hxk0vnp2m
	RFpunjQrWzP83RssLeu+/tzXRq1zOsOvF5+p5kzMlsqSDSEt4eo/XFcI0OjAk4TZTMuae/PpMtF
	RMrxN61nGAD+MI0fJhvoBHrobIfcQ0iikeZD0VpNOVzZHJHwMI/0EyhAofF8HXMYsA3EkixdoRW
	mjrd+rLJU97LdNbjeWQK86jHx7w4CM09DhjZjWsTed3hBFA10Y=
X-Received: by 2002:a05:651c:551:b0:389:ee7b:4d4b with SMTP id 38308e7fff4ca-38a67dd60d3mr11561771fa.12.1773241750304;
        Wed, 11 Mar 2026 08:09:10 -0700 (PDT)
X-Received: by 2002:a05:651c:551:b0:389:ee7b:4d4b with SMTP id
 38308e7fff4ca-38a67dd60d3mr11561701fa.12.1773241749845; Wed, 11 Mar 2026
 08:09:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aZ_-cH8euZLySxdD@shinmob> <CAHj4cs8mzSZez+n2qLu5931YAuQ4=RxNt6D6YJCsMEwGrm4UtA@mail.gmail.com>
 <DGZRYXTKC049.1I6QFQSMSD88H@arkamax.eu> <DGZTXRKSHBPC.2B318HF53ZRSN@arkamax.eu>
In-Reply-To: <DGZTXRKSHBPC.2B318HF53ZRSN@arkamax.eu>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Wed, 11 Mar 2026 23:08:41 +0800
X-Gm-Features: AaiRm52s-EH5ucY3yGw_WaFk4XtbskkABtsWUN8MID31uF9eSwnbqLdAEQHevQY
Message-ID: <CAHj4cs_nQEbeyvqvos7pwek8k0rLLXCghdoY9EsL4bCgZrxqtA@mail.gmail.com>
Subject: Re: blktests failures with v7.0-rc1 kernel
To: Maurizio Lombardi <mlombard@arkamax.eu>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, 
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, "nbd@other.debian.org" <nbd@other.debian.org>, 
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2026 at 5:02=E2=80=AFPM Maurizio Lombardi <mlombard@arkamax=
.eu> wrote:
>
> On Wed Mar 11, 2026 at 8:29 AM CET, Maurizio Lombardi wrote:
> > On Wed Mar 11, 2026 at 1:35 AM CET, Yi Zhang wrote:
> >
> > If nvmet_rdma_rw_ctx_init() fails, shouldn't it call
> > nvmet_req_free_sgls() before returning an error?
>
> Possible fix, not tested:
>
Hi Maurizio
The kmemleak still can be reproduced with this patch:

unreferenced object 0xffff88811db23d80 (size 32):
  comm "kworker/16:1H", pid 1360, jiffies 4296118279
  hex dump (first 32 bytes):
    82 3b 85 04 00 ea ff ff 00 00 00 00 00 10 00 00  .;..............
    00 e0 4e 21 81 88 ff ff 00 10 00 00 00 00 00 00  ..N!............
  backtrace (crc 4bb38867):
    __kmalloc_noprof+0x6f1/0xa10
    sgl_alloc_order+0x9e/0x370
    nvmet_req_alloc_sgls+0x294/0x4f0 [nvmet]
    nvmet_rdma_map_sgl_keyed+0x25d/0x9a0 [nvmet_rdma]
    nvmet_rdma_handle_command+0x1ed/0x4e0 [nvmet_rdma]
    __ib_process_cq+0x139/0x4b0 [ib_core]
    ib_cq_poll_work+0x4d/0x160 [ib_core]
    process_one_work+0x8b1/0x15e0
    worker_thread+0x5e9/0xfc0
    kthread+0x36b/0x470
    ret_from_fork+0x5bf/0x910
    ret_from_fork_asm+0x1a/0x30


> diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
> index 2d6eb89f98af..79ae743bb405 100644
> --- a/drivers/nvme/target/rdma.c
> +++ b/drivers/nvme/target/rdma.c
> @@ -892,7 +892,7 @@ static u16 nvmet_rdma_map_sgl_keyed(struct nvmet_rdma=
_rsp *rsp,
>
>         ret =3D nvmet_rdma_rw_ctx_init(rsp, addr, key, &sig_attrs);
>         if (unlikely(ret < 0))
> -               goto error_out;
> +               goto error_free_sgl;
>         rsp->n_rdma +=3D ret;
>
>         if (invalidate)
> @@ -900,6 +900,8 @@ static u16 nvmet_rdma_map_sgl_keyed(struct nvmet_rdma=
_rsp *rsp,
>
>         return 0;
>
> +error_free_sgl:
> +       nvmet_req_free_sgls(&rsp->req);
>  error_out:
>         rsp->req.transfer_len =3D 0;
>         return NVME_SC_INTERNAL;
>
> Maurizio
>


--=20
Best Regards,
  Yi Zhang

