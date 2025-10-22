Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7951A2F39DD
	for <linux-block@vger.kernel.org>; Wed, 22 Oct 2025 07:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761116477; cv=none; b=s1hIMYm7juOxbEjRvcs3LojK50vyGaKTM+V2e9pIFZDunuwyIt5dE6taCYzMJnS04jZlr3uJKVuex4rB7/DYUb4KWMu+SmD7g1uJ3SWgmUiymPOFP6ofsyMonZCskZdS+w0vkDCdOJCepxPGYrUcZvemoNxVXjdDf5TjEPNXw8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761116477; c=relaxed/simple;
	bh=HxC//6c/pxtCaIYc6byaWXcJI1kJg6+v7VVvcpx2G0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S2t0en6Dzg0urv/A4jjieaaNqqeQcOX5pfKIJQG7DpLQBFVN0UGdz66eWzgSAaULkFR66AT02d6CH99vPAz1rTIr4b3zhA2h0L2N1LaeGMNPJ0xNZb91026F7z89ippYiSqPlQjNxIlOlpDMl+TfOY8bEt7vvuTxPub1CRpFObs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XJ7Up6Xv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XJ7Up6Xv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761116474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p/wzttfZZIcdwp5kIjVhv23r7cyBB6dYXyfUT8ERUaw=;
	b=XJ7Up6Xv0TRJJoRz0xUOMcQXCyG5bIkzoPCA+elWLAwLWagKxc4CtENdhC111+ziFnZi26
	xrlmeC5I0CdW/VkyxLc57VOPyOwEl3lEOtqH0Ntz0ZjfzUsUPMtd7WlrMB2WcjIbijXg8a
	VjMDFu9wRrqYdmBviIaL8WzbhwhEphw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-hUo29kskOV2Vs9PG1u55IQ-1; Wed, 22 Oct 2025 03:01:10 -0400
X-MC-Unique: hUo29kskOV2Vs9PG1u55IQ-1
X-Mimecast-MFC-AGG-ID: hUo29kskOV2Vs9PG1u55IQ_1761116470
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-428567f67c5so58224f8f.2
        for <linux-block@vger.kernel.org>; Wed, 22 Oct 2025 00:01:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761116469; x=1761721269;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p/wzttfZZIcdwp5kIjVhv23r7cyBB6dYXyfUT8ERUaw=;
        b=Tg2f0LqsDxqJhgNtmb7Azh3UXLn5eH1J9wpz7tK88h8MURZosQOWsZpoWo8a45tFS8
         SpdS5EuD93POpkOmWYri01tknZwB3AmThTJnAZAM4bYJp8Bm33HJbAhdENIU4+1x0Q/V
         Pj/Sxf689Yad1TGtaRP4/LDO46ESdwcqRcB966pVLBQSDnpvP68SE8AgYJTaxGDp24LX
         BkPvXYBU0YtgumHqzjqKdtOdG9Fdd7pahl4ZlR5caVs3IZRqwXscdMem6hf+hLv+QeuJ
         +jhAikBxUT90i3tziWFJTmqppIgKmyeCanr95ulr0+AVbXtMWXTOFCKPfPglNBdDVXL9
         8dAA==
X-Forwarded-Encrypted: i=1; AJvYcCXAyDACC8TMiPkYuc+gvwzb2+6JIp3BDaRrF620pjEZWkAkpy093K79oLiCdAChYqYADE9aLiUBMQJxcg==@vger.kernel.org
X-Gm-Message-State: AOJu0YztmasTfIwnumsJzdIX5DCnI2SzlZ3uodwGzqNjMbNyFpiZUEGS
	8cM84w5x3noEu5j517MWQbYyKJzgmnlJLE459tYVGOTMU5Ghhr1RHV9ol5z/KoEyKAhBDtyaHkp
	TaasnqLSUmpUTQz/L2cpXEnB47MEemkmoEQxgeRZcMhkk4Vq8escVmxm6IeaXuAlX
X-Gm-Gg: ASbGncuEXw03keBUzDcfAbhXTwzALezWezXxWOa0/p2ExQ3sxcEvOMq5YEUPaHxqu2R
	yWcgNHGOPHr9qkmdPvKzrzaPZ8A32Ow+4ZzX8wBra6tf0//YDckSweSNyvHoEY8yXTtFG7T08k9
	X2ravLePLz1LnKolKcWZCXcageQjeRZ8Pzz+qFfI8t0fEYCieH0oKf6dfkgv2jM9+huasI/3OMe
	j2odm0QY03+QTaRAtbYFlFa3KP+KwCTxNl2tmsEpFlqZ0j06E/47Q461w8G7zv0fe6g/JouuJlt
	quGOSJASLMm715cyT7zrYW+488SiDubwUP81p09E/jG3qs8N+YFKR5itXBsvw5m5M6tq
X-Received: by 2002:a05:6000:420a:b0:3e5:5822:ec9d with SMTP id ffacd0b85a97d-42704d99f29mr12826974f8f.41.1761116469401;
        Wed, 22 Oct 2025 00:01:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtVUgbjjOkBKOAaeXoFsLqPC4uhTnJ7B4qxCiofbC48XDxdUtASszyIQinjVP9ESvl7Ojt0A==
X-Received: by 2002:a05:6000:420a:b0:3e5:5822:ec9d with SMTP id ffacd0b85a97d-42704d99f29mr12826933f8f.41.1761116468823;
        Wed, 22 Oct 2025 00:01:08 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:152d:b200:2a90:8f13:7c1e:f479])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427ea5b3c56sm23924067f8f.18.2025.10.22.00.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 00:01:08 -0700 (PDT)
Date: Wed, 22 Oct 2025 03:01:05 -0400
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
Message-ID: <20251022030050-mutt-send-email-mst@kernel.org>
References: <20251021-virtio_double_free-v1-1-4dd0cfd258f1@oss.qualcomm.com>
 <20251021085030-mutt-send-email-mst@kernel.org>
 <CACGkMEsU3+OWv=6mvQgP2iGL3Pe09=8PkTVA=2d9DPQ_SbTNSA@mail.gmail.com>
 <20251022014453-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251022014453-mutt-send-email-mst@kernel.org>

On Wed, Oct 22, 2025 at 01:45:38AM -0400, Michael S. Tsirkin wrote:
> On Wed, Oct 22, 2025 at 12:19:19PM +0800, Jason Wang wrote:
> > On Tue, Oct 21, 2025 at 8:58 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Tue, Oct 21, 2025 at 07:07:56PM +0800, Cong Zhang wrote:
> > > > The vblk->vqs releases during freeze. If resume fails before vblk->vqs
> > > > is allocated, later freeze/remove may attempt to free vqs again.
> > > > Set vblk->vqs to NULL after freeing to avoid double free.
> > > >
> > > > Signed-off-by: Cong Zhang <cong.zhang@oss.qualcomm.com>
> > > > ---
> > > > The patch fixes a double free issue that occurs in virtio_blk during
> > > > freeze/resume.
> > > > The issue is caused by:
> > > > 1. During the first freeze, vblk->vqs is freed but pointer is not set to
> > > >    NULL.
> > > > 2. Virtio block device fails before vblk->vqs is allocated during resume.
> > > > 3. During the next freeze, vblk->vqs gets freed again, causing the
> > > >    double free crash.
> > >
> > > this part I don't get. if restore fails, how can freeze be called
> > > again?
> > 
> > For example, could it be triggered by the user?
> > 
> > Thanks
> 
> I don't know - were you able to trigger it? how?

Sorry I mean the submitter of course.

> 
> > >
> > > > ---
> > > >  drivers/block/virtio_blk.c | 13 ++++++++++++-
> > > >  1 file changed, 12 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > > > index f061420dfb10c40b21765b173fab7046aa447506..746795066d7f56a01c9a9c0344d24f9fa06841eb 100644
> > > > --- a/drivers/block/virtio_blk.c
> > > > +++ b/drivers/block/virtio_blk.c
> > > > @@ -1026,8 +1026,13 @@ static int init_vq(struct virtio_blk *vblk)
> > > >  out:
> > > >       kfree(vqs);
> > > >       kfree(vqs_info);
> > > > -     if (err)
> > > > +     if (err) {
> > > >               kfree(vblk->vqs);
> > > > +             /*
> > > > +              * Set to NULL to prevent freeing vqs again during freezing.
> > > > +              */
> > > > +             vblk->vqs = NULL;
> > > > +     }
> > > >       return err;
> > > >  }
> > > >
> > >
> > > > @@ -1598,6 +1603,12 @@ static int virtblk_freeze_priv(struct virtio_device *vdev)
> > > >
> > > >       vdev->config->del_vqs(vdev);
> > > >       kfree(vblk->vqs);
> > > > +     /*
> > > > +      * Set to NULL to prevent freeing vqs again after a failed vqs
> > > > +      * allocation during resume. Note that kfree() already handles NULL
> > > > +      * pointers safely.
> > > > +      */
> > > > +     vblk->vqs = NULL;
> > > >
> > > >       return 0;
> > > >  }
> > > >
> > > > ---
> > > > base-commit: 8e2755d7779a95dd61d8997ebce33ff8b1efd3fb
> > > > change-id: 20250926-virtio_double_free-7ab880d82a17
> > > >
> > > > Best regards,
> > > > --
> > > > Cong Zhang <cong.zhang@oss.qualcomm.com>
> > >

