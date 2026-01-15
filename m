Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BB734DCF2
	for <linux-block@vger.kernel.org>; Thu, 15 Jan 2026 09:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768469117; cv=none; b=thn4Kl6iKI3BTYMin6QeAL5lQO91GYbUTrvW3VrNBPX1bffptX4df6aDzrSPlWMQZkJKxd8EwdG0HHACLWcOiOLq/+0aS/MPme1kYcZgcs2Z3wKLqowSxWRfeb/qz9r1mF1Ev+kBHRr9rvZS5I0+r8u3i9Ctprgj68KPYmDSoBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768469117; c=relaxed/simple;
	bh=zfGjpg4zpVIbODkbpBbVLKcC9rUSmBMpD3GAAU51X/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sF5RhS27tj0gZBW9wCVaniElXNLB3h5Lo/hGKubW+ibM937gVAeUgmur3yyp4vSMho9aG/PugL8s/W0hmejfOR1teNemROh4tK8jjPH208GEoyK4a+Jc2E69eqdlyNcNxdQMFwgeAMXlxjz8gynJQtMjRbZhzu9tAZazZgeMoIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MnxCewiK; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=RaiQIc/n; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MnxCewiK";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="RaiQIc/n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768469115;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AFVx2OPknI0/5/crmPB60StwMjoaJBP8nc1bG0QCX/A=;
	b=MnxCewiK+rQAW3tSUjVYtXcBndLSFk7FNlBbw/iZ8OBDldXyTUYPbIXDwm2H931VVDscJ6
	rXY82Q05HuR6uO/6FakXWlcFbPaWYd005WnJbUIIDOzPPMJFFtp3Oux0ekNIWizLKBzpA0
	9G+BVsK9rc6pxgmIFULbdj2Ih26XQBU=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-ZEJM6ugwNluuimx9WbhmcQ-1; Thu, 15 Jan 2026 04:25:13 -0500
X-MC-Unique: ZEJM6ugwNluuimx9WbhmcQ-1
X-Mimecast-MFC-AGG-ID: ZEJM6ugwNluuimx9WbhmcQ_1768469112
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-38305c7a140so3600041fa.2
        for <linux-block@vger.kernel.org>; Thu, 15 Jan 2026 01:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768469112; x=1769073912; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AFVx2OPknI0/5/crmPB60StwMjoaJBP8nc1bG0QCX/A=;
        b=RaiQIc/nCemccU4jUKFS1cdK7InLFjIvz3rAufk5lN2fJaEpc+gv0xUZgvg2NOccXh
         eQSrQPhFY2KRxzkuv+99GAxnnJlQyAZrjeX57HRiHxz+04jsEGuSO3OggscXEK+rJZjB
         CpfESmQ2JFNy7mIYi5ciD6slSrTUZfmkcQ7yrvJUtCq9nCjqcCQqLvWIDyFl/a8AHnNB
         RNFcg+AaWbUGt8iNY1+Omx2z4K4g379Fx5h5DEeNWWe8ibJ1Frd6MjKHO++fw6WlAiqK
         79y3IUoavLNtUS2t4VQeWV0TC8FBwDMvfTXav7FMN5KmXz09CLt73bUmZkaXDBzURAqh
         G87A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768469112; x=1769073912;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AFVx2OPknI0/5/crmPB60StwMjoaJBP8nc1bG0QCX/A=;
        b=l7ro8Yw+aR6WPaVeQiLq3pZp2AtvDxLodDf/htV5orTmMXDXvzhJbN54GdeB/1jBin
         mVnqjn8zmXdLStR+E+fexuJ1FlE+wc+BcsZRW45oAPU6JMAC6Zh+sXcGHaXtga8KSmoz
         SnUDmjO6EFh2OA3Uv/s9A/YBMuacX9AvlB+viC9MjXrTNxAzLKJILvr/FKEe/Z0n4Msk
         mZ2EYiPwNVWNd8JZW1U764cp6I89NisaHTW/YxzlhZ6D68/E/vYgUNuz++JhmCnnkzym
         JzvHQ570FjXo/JoTg9ZMvr/AEQ4pZqV3cfI3+9gJGZfw/a+WbjJ45pSg5QORyHpZ8TRo
         PX7g==
X-Forwarded-Encrypted: i=1; AJvYcCX1Y6fkJyyGYkkFGzb2fhTXLlPs6+cHWADA7aEwblD56Tde2chC9Z3mSPcNB6reHskszMRLK2fhT5BzoQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5ZSdElVVX04SvR5nIR4uNGMJqWpHWpB4EiZQwSMnqe6o/wSma
	AvRj5RaTYgbn+QcQlq/QmnhxbQ67KX6aIXTObQIk8YmXOtTHk7f1ttK5bCFZe5fezP0tBr5FV7J
	egNpAmsOvJhPkNFSZ2QPINO9bmXWVs7RjRwfZMLwfz3sDXBJAKQp2276Rl2bSUcnsPeVp5RgsjB
	c59R5UWp3FsSZMPCqR1f2roRk23xYTQMjkczCjoZI=
X-Gm-Gg: AY/fxX6b+zvO1RgA8fO3R3DHeY59yjIJfDMlPYpCe0z9Ci0FOq8PXr7B6OxUQac7Qkb
	r5NMaj2mnGW22b/iYH8iuOBeDyAdKA/tWH0ZwTx4hh6FWI6pt2AOanHdg/8MihSUdTXgamXHqv7
	Ouue6nIgM0YuYo2jlLa+Y3gYJ8zNjJGN3+wSHtxc43ox7rvgvPA4osmvYOHoZsosCbdxQ=
X-Received: by 2002:a05:651c:1541:b0:383:5a4f:2605 with SMTP id 38308e7fff4ca-38360831ad3mr18477941fa.44.1768469111874;
        Thu, 15 Jan 2026 01:25:11 -0800 (PST)
X-Received: by 2002:a05:651c:1541:b0:383:5a4f:2605 with SMTP id
 38308e7fff4ca-38360831ad3mr18477851fa.44.1768469111410; Thu, 15 Jan 2026
 01:25:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHj4cs9wv3SdPo+N01Fw2SHBYDs9tj2M_e1-GdQOkRy=DsBB1w@mail.gmail.com>
 <262c8ac1-e625-4e4c-8b3c-85f842aba6fe@gmail.com> <7d718bc8-64b6-4e8f-bad7-7e1615c577ca@nvidia.com>
 <CAHj4cs9gBTHLB_7JrFpZnJ-imc7jmqnhZpqkemaRVQYLn9j_rQ@mail.gmail.com>
In-Reply-To: <CAHj4cs9gBTHLB_7JrFpZnJ-imc7jmqnhZpqkemaRVQYLn9j_rQ@mail.gmail.com>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Thu, 15 Jan 2026 17:24:58 +0800
X-Gm-Features: AZwV_QgMuBM7WRV2hAZveEm3FY527xhIAOt1HlaitQTZAE4l_GoB7b6WdnawdWg
Message-ID: <CAHj4cs-84wsWQKeBS2wkd-_Y4Xe7wcTPqzutisNbXtpcAdh8yw@mail.gmail.com>
Subject: Re: [bug report] kmemleak observed during blktests nvme/fc
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>, justintee8345@gmail.com
Cc: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>, 
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>, linux-block <linux-block@vger.kernel.org>, 
	Daniel Wagner <dwagner@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Justin and Chaitanya

It turns out that the kmemleak was caused by nvme-loop. It was
observed during the stress nvme loop/tcp/fc[1] test, but the kmemleak
log was reported during the nvme/fc test. That's why I didn't
reproduce it with the stress nvme/fc test before.

[1]
nvme_trtype=3Dloop ./check nvme/
nvme_trtype=3Dtcp ./check nvme/
nvme_trtype=3Dfc ./check nvme/

unreferenced object 0xffff8881295fd000 (size 1024):
  comm "nvme", pid 101335, jiffies 4299282670
  hex dump (first 32 bytes):
    00 00 00 00 ad 4e ad de ff ff ff ff 00 00 00 00  .....N..........
    ff ff ff ff ff ff ff ff e0 3c 57 af ff ff ff ff  .........<W.....
  backtrace (crc 414bcfcd):
    __kmalloc_cache_node_noprof+0x5f9/0x840
    blk_mq_alloc_hctx+0x52/0x810
    blk_mq_alloc_and_init_hctx+0x5b9/0x840
    __blk_mq_realloc_hw_ctxs+0x20a/0x610
    blk_mq_init_allocated_queue+0x2e9/0x1210
    blk_mq_alloc_queue+0x17f/0x230
    nvme_alloc_admin_tag_set+0x352/0x670 [nvme_core]
    nvme_loop_configure_admin_queue+0xdf/0x2d0 [nvme_loop]
    nvme_loop_create_ctrl+0x428/0xb13 [nvme_loop]
    nvmf_create_ctrl+0x2ec/0x620 [nvme_fabrics]
    nvmf_dev_write+0xd5/0x180 [nvme_fabrics]
    vfs_write+0x1d0/0xfd0
    ksys_write+0xf9/0x1d0
    do_syscall_64+0x95/0x520
    entry_SYSCALL_64_after_hwframe+0x76/0x7e
unreferenced object 0xffff8881c24db660 (size 8):
  comm "nvme", pid 101335, jiffies 4299282670
  hex dump (first 8 bytes):
    ff ff 00 00 00 00 00 00                          ........
  backtrace (crc b47d4cd6):
    __kmalloc_node_noprof+0x6ab/0x970
    alloc_cpumask_var_node+0x56/0xb0
    blk_mq_alloc_hctx+0x74/0x810
    blk_mq_alloc_and_init_hctx+0x5b9/0x840
    __blk_mq_realloc_hw_ctxs+0x20a/0x610
    blk_mq_init_allocated_queue+0x2e9/0x1210
    blk_mq_alloc_queue+0x17f/0x230
    nvme_alloc_admin_tag_set+0x352/0x670 [nvme_core]
    nvme_loop_configure_admin_queue+0xdf/0x2d0 [nvme_loop]
    nvme_loop_create_ctrl+0x428/0xb13 [nvme_loop]
    nvmf_create_ctrl+0x2ec/0x620 [nvme_fabrics]
    nvmf_dev_write+0xd5/0x180 [nvme_fabrics]
    vfs_write+0x1d0/0xfd0
    ksys_write+0xf9/0x1d0
    do_syscall_64+0x95/0x520
    entry_SYSCALL_64_after_hwframe+0x76/0x7e
unreferenced object 0xffff8882752cd300 (size 128):
  comm "nvme", pid 101335, jiffies 4299282670
  hex dump (first 32 bytes):
    00 bf f0 fb ff e8 ff ff 00 bf 30 fc ff e8 ff ff  ..........0.....
    00 bf 70 fc ff e8 ff ff 00 bf b0 fc ff e8 ff ff  ..p.............
  backtrace (crc caffc16d):
    __kmalloc_node_noprof+0x6ab/0x970
    blk_mq_alloc_hctx+0x43a/0x810
    blk_mq_alloc_and_init_hctx+0x5b9/0x840
    __blk_mq_realloc_hw_ctxs+0x20a/0x610
    blk_mq_init_allocated_queue+0x2e9/0x1210
    blk_mq_alloc_queue+0x17f/0x230
    nvme_alloc_admin_tag_set+0x352/0x670 [nvme_core]
    nvme_loop_configure_admin_queue+0xdf/0x2d0 [nvme_loop]
    nvme_loop_create_ctrl+0x428/0xb13 [nvme_loop]
    nvmf_create_ctrl+0x2ec/0x620 [nvme_fabrics]
    nvmf_dev_write+0xd5/0x180 [nvme_fabrics]
    vfs_write+0x1d0/0xfd0
    ksys_write+0xf9/0x1d0
    do_syscall_64+0x95/0x520
    entry_SYSCALL_64_after_hwframe+0x76/0x7e
unreferenced object 0xffff88827d5d7800 (size 512):
  comm "nvme", pid 101335, jiffies 4299282670
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc 93cf34af):
    __kvmalloc_node_noprof+0x814/0xb30
    sbitmap_init_node+0x184/0x730
    blk_mq_alloc_hctx+0x4b3/0x810
    blk_mq_alloc_and_init_hctx+0x5b9/0x840
    __blk_mq_realloc_hw_ctxs+0x20a/0x610
    blk_mq_init_allocated_queue+0x2e9/0x1210
    blk_mq_alloc_queue+0x17f/0x230
    nvme_alloc_admin_tag_set+0x352/0x670 [nvme_core]
    nvme_loop_configure_admin_queue+0xdf/0x2d0 [nvme_loop]
    nvme_loop_create_ctrl+0x428/0xb13 [nvme_loop]
    nvmf_create_ctrl+0x2ec/0x620 [nvme_fabrics]
    nvmf_dev_write+0xd5/0x180 [nvme_fabrics]
    vfs_write+0x1d0/0xfd0
    ksys_write+0xf9/0x1d0
    do_syscall_64+0x95/0x520
    entry_SYSCALL_64_after_hwframe+0x76/0x7e
On Sat, Dec 27, 2025 at 8:10=E2=80=AFPM Yi Zhang <yi.zhang@redhat.com> wrot=
e:
>
> > > Can you try following ? FYI : - Potential fix, only compile tested.
> > >
> > > From b3c2e350ae741b18c04abe489dcf9d325537c01c Mon Sep 17 00:00:00 200=
1
> > > From: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
> > > Date: Sun, 14 Dec 2025 19:29:24 -0800
> > > Subject: [PATCH COMPILE TESTED ONLY] nvme-fc: release admin tagset if
> > > init fails
> > >
> > > nvme_fabrics creates an NVMe/FC controller in following path:
> > >
> > >     nvmf_dev_write()
> > >       -> nvmf_create_ctrl()
> > >         -> nvme_fc_create_ctrl()
> > >           -> nvme_fc_init_ctrl()
> > >
> > > Check ctrl->ctrl.admin_tagset in the fail_ctrl path and call
> > > nvme_remove_admin_tag_set() to release the resources.
> > >
> > > Signed-off-by: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
> > > ---
> > >  drivers/nvme/host/fc.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> > > index bc455fa98246..6948de3f438a 100644
> > > --- a/drivers/nvme/host/fc.c
> > > +++ b/drivers/nvme/host/fc.c
> > > @@ -3587,6 +3587,8 @@ nvme_fc_init_ctrl(struct device *dev, struct
> > > nvmf_ctrl_options *opts,
> > >
> > >      ctrl->ctrl.opts =3D NULL;
> > >
> > > +    if (ctrl->ctrl.admin_tagset)
> > > +        nvme_remove_admin_tag_set(&ctrl->ctrl);
> > >      /* initiate nvme ctrl ref counting teardown */
> > >      nvme_uninit_ctrl(&ctrl->ctrl);
> > >
> > did you get a chance to try this ?
>
> Hi Chaitanya
>
> Sorry for the late response, I tried to reproduce this issue recently
> but with no luck to reproduce it again.
> And during the stress blktests nvme/fc test, I reproduced several panic i=
ssue.
> I will report it later after I get more info.
>
>
> >
> > -ck
> >
>
>
> --
> Best Regards,
>   Yi Zhang



--
Best Regards,
  Yi Zhang

