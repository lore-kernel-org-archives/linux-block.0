Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4320122FE0A
	for <linux-block@vger.kernel.org>; Wed, 22 Oct 2025 05:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761111945; cv=none; b=OZuJuKS0Ra5UN4DG/UknfiVotZOeR+Zh2liwjcm+mnGoG8AAo1eQ+BIeR4xmBYW9MjCJCT/q87bhxMoJ2XefXzaUrJ7WGihWU+10eQlENpVIKnsy90+ZOSCE+zqhyTX9abHrr0MBCNQ8LexV5N9Hw4Nvo8HQWDmti32FyDDgFlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761111945; c=relaxed/simple;
	bh=OOEDwYf/WoldymVHE1bARmPBao5IcHvki7sxdMEqYj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HCp4TfJxMo773yUCAN4q9ca/VGXprzmQOASi+UCYtH1Hd2rMoQLlgeM0a8yaaqJyYk/bl9OvP42YvF0FW48NDgKSlynqcTqgcB8080EN2a3A4A0QwMXjXUPP+IG1wAnj0xgnk8k+0WJ6svfbk83j/FmefeWLAD9JvmWRk7Cg2Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I1dmze2k; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I1dmze2k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761111942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+gdOCtyqfpPDKTOSjwLO+fIICNulbuVoEvWA7TNWh1Q=;
	b=I1dmze2kkkOKjUZUgjcY6u/yN4PnSxc6xZHipVQS3YGXnViuyuszMDJ8i0XPfTPuchUQjP
	Pwxpn36H92xtIYo2g5+lH6e3Re5HC1InEEKubEPn/akMTqfinM+Lfo4tzGi2K33oIEcC7v
	CoxCFVhubCTsMqfAovFOrQ0Ew3qQzNE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-klSRtkbzPRKOU9KweWQUfA-1; Wed, 22 Oct 2025 01:45:40 -0400
X-MC-Unique: klSRtkbzPRKOU9KweWQUfA-1
X-Mimecast-MFC-AGG-ID: klSRtkbzPRKOU9KweWQUfA_1761111939
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-471168953bdso4114305e9.1
        for <linux-block@vger.kernel.org>; Tue, 21 Oct 2025 22:45:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761111939; x=1761716739;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+gdOCtyqfpPDKTOSjwLO+fIICNulbuVoEvWA7TNWh1Q=;
        b=rjaiSVLpH3sTzcxodzmB4+IV0UbtJyN7BNroUBEMTPKZQBLkKsy+UsC1oRUSEjc+NL
         /0T5ev2uaDgn4A4ePzKudTugXURsFDNcwBLoBHMB2ew3yqbHeh/vKvJkY4rIv6EfRXv7
         XySXdsrdrAJXc9qSwM1Hgw8VjrnKKcylvrt77vJsz2wC0C3AhC8YfzdQFn9YUkORYrpN
         kjdNassqrArAi9LlulW1u/npP+fTkcIAbutfjNzdRqFHuJ/AwgZxd3J0CNP+fpU09CVc
         VBj5p+SUtok0OoZIft9Zod/blHKm1ZCJpRumubW3fuNHPEmTbKSHpjCAnTzP4GFiO0bi
         SgIw==
X-Forwarded-Encrypted: i=1; AJvYcCWSZgx5bxDUXi0At8KfKnJIN1ZV+b3PUj25xK73PWZ21/iHaQ3lbGHC55SZmBCWSYMjiuQtPf+Lg+ELXg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1tlMsG51rueOIBNHwZQxraMc5ranX4ZZ1+bev/9vShGNbyj0O
	m3oDv5kg92HiqonkRLcBSih0VGk50XCO3SAZmzbD4lJzKOkP7JNHIpeBjcqU5gPRg0pCyLwEXrJ
	pubX6TufnGSrnascnfVmq8YaKEvpUfeS4/JPkhT9s14joamdXrs4r9com6XHFMVMQ
X-Gm-Gg: ASbGncuLy9v7uAaANm/yP274yrzN5UPf/PjdVGAY5ZKgn8JsHIp+I6O1mw24U6tiYXX
	MT0pU68we5KG+VHDl2AmeNKrsF8mJd1OeooamZ/Wg1qy7YemzvPcBKrIbuKNuBzRqOPKgcaZFR4
	rPsGNn4mQxWQShAX7el4vYI+H+6BjS/IPz+ew5aHi2tLyWgGWlRBjkEzmY2EzKTX3AKc/ud5D/y
	Iy5QPjxSougbrt/Im6qUTZDnWBPLDlYznIU4cvt+G0rejD1FAcbZ0w49uMu/m6lqrPNkGXElrte
	4Ax6jamdQgRaOG9cENYQ7m5pMsYb/A1j+GMqWTgI/i22NCZsrRLMJ37KlHnzNfVAInPG
X-Received: by 2002:a05:600c:6992:b0:471:5c0:94fc with SMTP id 5b1f17b1804b1-475c3fa355cmr13586895e9.6.1761111939136;
        Tue, 21 Oct 2025 22:45:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElHGkXoX3hCkc0GRrDbDcYpbH4YLBEG6cIW8mw2RcnC42OK12DSE/fMXDY2iXzD02ahYxuXQ==
X-Received: by 2002:a05:600c:6992:b0:471:5c0:94fc with SMTP id 5b1f17b1804b1-475c3fa355cmr13586695e9.6.1761111938746;
        Tue, 21 Oct 2025 22:45:38 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:152d:b200:2a90:8f13:7c1e:f479])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47494ab11bbsm30712795e9.1.2025.10.21.22.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 22:45:38 -0700 (PDT)
Date: Wed, 22 Oct 2025 01:45:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Cong Zhang <cong.zhang@oss.qualcomm.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	linux-arm-msm@vger.kernel.org, virtualization@lists.linux.dev,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	pavan.kondeti@oss.qualcomm.com
Subject: Re: [PATCH] virtio_blk: NULL out vqs to avoid double free on failed
 resume
Message-ID: <20251022014453-mutt-send-email-mst@kernel.org>
References: <20251021-virtio_double_free-v1-1-4dd0cfd258f1@oss.qualcomm.com>
 <20251021085030-mutt-send-email-mst@kernel.org>
 <CACGkMEsU3+OWv=6mvQgP2iGL3Pe09=8PkTVA=2d9DPQ_SbTNSA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEsU3+OWv=6mvQgP2iGL3Pe09=8PkTVA=2d9DPQ_SbTNSA@mail.gmail.com>

On Wed, Oct 22, 2025 at 12:19:19PM +0800, Jason Wang wrote:
> On Tue, Oct 21, 2025 at 8:58 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Tue, Oct 21, 2025 at 07:07:56PM +0800, Cong Zhang wrote:
> > > The vblk->vqs releases during freeze. If resume fails before vblk->vqs
> > > is allocated, later freeze/remove may attempt to free vqs again.
> > > Set vblk->vqs to NULL after freeing to avoid double free.
> > >
> > > Signed-off-by: Cong Zhang <cong.zhang@oss.qualcomm.com>
> > > ---
> > > The patch fixes a double free issue that occurs in virtio_blk during
> > > freeze/resume.
> > > The issue is caused by:
> > > 1. During the first freeze, vblk->vqs is freed but pointer is not set to
> > >    NULL.
> > > 2. Virtio block device fails before vblk->vqs is allocated during resume.
> > > 3. During the next freeze, vblk->vqs gets freed again, causing the
> > >    double free crash.
> >
> > this part I don't get. if restore fails, how can freeze be called
> > again?
> 
> For example, could it be triggered by the user?
> 
> Thanks

I don't know - were you able to trigger it? how?


> >
> > > ---
> > >  drivers/block/virtio_blk.c | 13 ++++++++++++-
> > >  1 file changed, 12 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > > index f061420dfb10c40b21765b173fab7046aa447506..746795066d7f56a01c9a9c0344d24f9fa06841eb 100644
> > > --- a/drivers/block/virtio_blk.c
> > > +++ b/drivers/block/virtio_blk.c
> > > @@ -1026,8 +1026,13 @@ static int init_vq(struct virtio_blk *vblk)
> > >  out:
> > >       kfree(vqs);
> > >       kfree(vqs_info);
> > > -     if (err)
> > > +     if (err) {
> > >               kfree(vblk->vqs);
> > > +             /*
> > > +              * Set to NULL to prevent freeing vqs again during freezing.
> > > +              */
> > > +             vblk->vqs = NULL;
> > > +     }
> > >       return err;
> > >  }
> > >
> >
> > > @@ -1598,6 +1603,12 @@ static int virtblk_freeze_priv(struct virtio_device *vdev)
> > >
> > >       vdev->config->del_vqs(vdev);
> > >       kfree(vblk->vqs);
> > > +     /*
> > > +      * Set to NULL to prevent freeing vqs again after a failed vqs
> > > +      * allocation during resume. Note that kfree() already handles NULL
> > > +      * pointers safely.
> > > +      */
> > > +     vblk->vqs = NULL;
> > >
> > >       return 0;
> > >  }
> > >
> > > ---
> > > base-commit: 8e2755d7779a95dd61d8997ebce33ff8b1efd3fb
> > > change-id: 20250926-virtio_double_free-7ab880d82a17
> > >
> > > Best regards,
> > > --
> > > Cong Zhang <cong.zhang@oss.qualcomm.com>
> >

