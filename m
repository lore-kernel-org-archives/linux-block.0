Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9227220C009;
	Mon, 26 May 2025 13:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748266172; cv=none; b=QM9TGMLQsniX93P/vkDA8I4SugEZ7BZcR3lM3AkgI5IdOcJehYSL/cPzPB5g40K7x+aOwMnM1+DDOdbSfF15BmZ0up87vSskpGqxWPN23KhMCmXg9l0UvIKnCj7rSVkFcwgdL/1mHVt9CFoVvn4hM59pxL40sANWXRBHjiNqgzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748266172; c=relaxed/simple;
	bh=ftqgrdFI1GpSlLjZn+vqEpJ3cfGGNQo5NsWZGQWfDcQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fwSItvdA2OmYOhbmCTBAU1nmEpZQYlO6xmgOeVtWZPF9o8OYZOp9tzMafSbw8dTce2QHOeRAfKZA55pdgjrs3PpjIllRz1sRCW7jmvQXat9HtSJsq/oHh34yy6iU8/JLyqEKhv/+cLM49A6vB24luRBv2Zu150qJzYoec/1J3Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XrHCoYs7; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XrHCoYs7"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-601f278369bso4679399a12.1;
        Mon, 26 May 2025 06:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748266168; x=1748870968; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ky+DCkhEOyCcqlejBTI455CsOSMLvUBLS4Gb0hfKRHc=;
        b=XrHCoYs7/og84/GSJkmRUxSpY+td42qTwNGxQ29xBFyTKKaVZZpD84bswigzTo9+uf
         LmkNL0toqkOV5GEIfOQyvFdkdkrCBP+ElKQey8gO3c4LOxjN+PgxD0IrFBRBfMrVEu9m
         km+fTz312EUyni+4x4pD5wcz1Nu2gf3TER9VU1ubkuUbLnJ5kxFB/rC2IJbcv1J2ivDk
         1w35JSjsSVys4kjQB6fZDc9Teitj1ac2B0Lt8anaHjoVp8Pf+rZ5pFhH1DWkVIjagICz
         TnnqrdYTRKrKGuQhxJC2S3zYxk1IPGY0qExKieQf34PWxLxc3VL7Z90+lsBZVH4FTNzG
         WeVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748266168; x=1748870968;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ky+DCkhEOyCcqlejBTI455CsOSMLvUBLS4Gb0hfKRHc=;
        b=vj7RrY3n65+WwZgVmdFzd3rZn0MJ6ZulIeSPxeGNeLq88j1QC4pugqGF8fQLfaOXB5
         zfRl4p0tmc7C5yoQ+xD+XW2CG12ctTL75uqQsk31672TEAXJii2hjqjO0tRv09fFl6IY
         NCa+eDRhP1FKkJ4pu6+MLbUKHpQ6MSuFVBrc3q68pJ73vcYWw/3oFqzzpHX6NE9oNJ4Y
         RLTUrozlqfl7CnaG5UKH80lGO5FyX170n2LBjwbWgU0e9UKfLfWSG7igXTg0wH+xuPPv
         OuOS6xeV+TZg6GeIlhKd/BaAWt2Idt1Z3iTjtRoMTj6eku9TMnmsLhLaq6Lyz5p2XQkY
         Bv6g==
X-Forwarded-Encrypted: i=1; AJvYcCU8RY5IPJ58ArZgo/VJwf5Nn8Af/l6D5OCyzNltOi2Ua/2LxYm2TMB0za/uNXfXu14hIIf2VCmV@vger.kernel.org, AJvYcCUUl0x/hWKlTT3y4YDhzof3R1V9ReH0mx65/f4jVN5ZEA4jLQ4NJlOLtWz37ZaLG0Ki+bNrWM7zov+U+w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwQF3nGCUVtnR9LYGkoHngfbwGbQDPNYz+/WCyLuzfg0VXXdaE9
	bhsS8rt3c/GDQnn1OJoCVFxmt/1loEYLGV4bCLDT40DM1jTBGQoWx1OuFrLqIbqHJhpsj8X73CQ
	nbS2GKie7POXnQiwGfVO6Fd4na0BO5Xs=
X-Gm-Gg: ASbGncsNTyYfa6YGd8pzcshdujynwnytjkNxR3h6DZj60Z6Kj3vWUR3mivKUFpkhbSb
	Y0YOP/ps1bh6/0St2ilySVsKGtsPYecwagHlqlGAMkf+0csztSYdcCFv+47vrfHuO75zg4fOHe8
	uWzJ5KWwFCREaevs/KJD+Hpy8XLwVMgJM=
X-Google-Smtp-Source: AGHT+IFvyx15Wv4KKKNKkL+b/IrI3XgNbs0ShaeDrFV2k6yVufyn/+YNtOoVkbAi0R7bkFeyzpJaGzrINco9iSKSY4w=
X-Received: by 2002:a05:6402:3486:b0:601:89d4:968e with SMTP id
 4fb4d7f45d1cf-602dacbfd7amr7816048a12.27.1748266167610; Mon, 26 May 2025
 06:29:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250521062744.1361774-1-parav@nvidia.com> <20250521145635.GA120766@fedora>
 <CY8PR12MB7195DE1F8F11675CD2584D22DC99A@CY8PR12MB7195.namprd12.prod.outlook.com>
 <CAJSP0QXxspELYnToMuP1w86rayQgPDRccVo892C258y9UbH_Hg@mail.gmail.com>
 <CY8PR12MB71958DFA8D0043DA3842B93ADC99A@CY8PR12MB7195.namprd12.prod.outlook.com>
 <CY8PR12MB719552B560C843F8CC334EDEDC65A@CY8PR12MB7195.namprd12.prod.outlook.com>
In-Reply-To: <CY8PR12MB719552B560C843F8CC334EDEDC65A@CY8PR12MB7195.namprd12.prod.outlook.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 26 May 2025 09:29:14 -0400
X-Gm-Features: AX0GCFuapTTNbi28N7wHTBYiG_3DZOJJw1MIzEKxGOcBFWIlrSs2rlkpolyRhLY
Message-ID: <CAJSP0QX70Om0Q-yGSN90N-4XJvhOV1XvVER-a0E05BRcd2JBKw@mail.gmail.com>
Subject: Re: [PATCH v1] virtio_blk: Fix disk deletion hang on device surprise removal
To: Parav Pandit <parav@nvidia.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, "mst@redhat.com" <mst@redhat.com>, 
	"axboe@kernel.dk" <axboe@kernel.dk>, 
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, 
	"NBU-Contact-Li Rongqing (EXTERNAL)" <lirongqing@baidu.com>, Chaitanya Kulkarni <chaitanyak@nvidia.com>, 
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"jasowang@redhat.com" <jasowang@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>, 
	Israel Rukshin <israelr@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 26, 2025 at 5:23=E2=80=AFAM Parav Pandit <parav@nvidia.com> wro=
te:
>
> Hi Stefan,
>
> > From: Parav Pandit <parav@nvidia.com>
> > Sent: Thursday, May 22, 2025 8:26 PM
> >
> >
> > > From: Stefan Hajnoczi <stefanha@gmail.com>
> > > Sent: Thursday, May 22, 2025 8:06 PM
> > >
> > > On Wed, May 21, 2025 at 10:57=E2=80=AFPM Parav Pandit <parav@nvidia.c=
om>
> > wrote:
> > > > > From: Stefan Hajnoczi <stefanha@redhat.com>
> > > > > Sent: Wednesday, May 21, 2025 8:27 PM
> > > > >
> > > > > On Wed, May 21, 2025 at 06:37:41AM +0000, Parav Pandit wrote:
> > > > > > When the PCI device is surprise removed, requests may not
> > > > > > complete the device as the VQ is marked as broken. Due to this,
> > > > > > the disk deletion hangs.
> > > > > >
> > > > > > Fix it by aborting the requests when the VQ is broken.
> > > > > >
> > > > > > With this fix now fio completes swiftly.
> > > > > > An alternative of IO timeout has been considered, however when
> > > > > > the driver knows about unresponsive block device, swiftly
> > > > > > clearing them enables users and upper layers to react quickly.
> > > > > >
> > > > > > Verified with multiple device unplug iterations with pending
> > > > > > requests in virtio used ring and some pending with the device.
> > > > > >
> > > > > > Fixes: 43bb40c5b926 ("virtio_pci: Support surprise removal of
> > > > > > virtio pci device")
> > > > > > Cc: stable@vger.kernel.org
> > > > > > Reported-by: lirongqing@baidu.com
> > > > > > Closes:
> > > > > > https://lore.kernel.org/virtualization/c45dd68698cd47238c55fb73=
c
> > > > > > a9
> > > > > > b474
> > > > > > 1@baidu.com/
> > > > > > Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> > > > > > Reviewed-by: Israel Rukshin <israelr@nvidia.com>
> > > > > > Signed-off-by: Parav Pandit <parav@nvidia.com>
> > > > > > ---
> > > > > > changelog:
> > > > > > v0->v1:
> > > > > > - Fixed comments from Stefan to rename a cleanup function
> > > > > > - Improved logic for handling any outstanding requests
> > > > > >   in bio layer
> > > > > > - improved cancel callback to sync with ongoing done()
> > > > > >
> > > > > > ---
> > > > > >  drivers/block/virtio_blk.c | 95
> > > > > > ++++++++++++++++++++++++++++++++++++++
> > > > > >  1 file changed, 95 insertions(+)
> > > > > >
> > > > > > diff --git a/drivers/block/virtio_blk.c
> > > > > > b/drivers/block/virtio_blk.c index 7cffea01d868..5212afdbd3c7
> > > > > > 100644
> > > > > > --- a/drivers/block/virtio_blk.c
> > > > > > +++ b/drivers/block/virtio_blk.c
> > > > > > @@ -435,6 +435,13 @@ static blk_status_t virtio_queue_rq(struct
> > > > > blk_mq_hw_ctx *hctx,
> > > > > >     blk_status_t status;
> > > > > >     int err;
> > > > > >
> > > > > > +   /* Immediately fail all incoming requests if the vq is brok=
en.
> > > > > > +    * Once the queue is unquiesced, upper block layer flushes
> > > > > > + any
> > > > > pending
> > > > > > +    * queued requests; fail them right away.
> > > > > > +    */
> > > > > > +   if (unlikely(virtqueue_is_broken(vblk->vqs[qid].vq)))
> > > > > > +           return BLK_STS_IOERR;
> > > > > > +
> > > > > >     status =3D virtblk_prep_rq(hctx, vblk, req, vbr);
> > > > > >     if (unlikely(status))
> > > > > >             return status;
> > > > > > @@ -508,6 +515,11 @@ static void virtio_queue_rqs(struct rq_lis=
t
> > > *rqlist)
> > > > > >     while ((req =3D rq_list_pop(rqlist))) {
> > > > > >             struct virtio_blk_vq *this_vq =3D
> > > > > >get_virtio_blk_vq(req- mq_hctx);
> > > > > >
> > > > > > +           if (unlikely(virtqueue_is_broken(this_vq->vq))) {
> > > > > > +                   rq_list_add_tail(&requeue_list, req);
> > > > > > +                   continue;
> > > > > > +           }
> > > > > > +
> > > > > >             if (vq && vq !=3D this_vq)
> > > > > >                     virtblk_add_req_batch(vq, &submit_list);
> > > > > >             vq =3D this_vq;
> > > > > > @@ -1554,6 +1566,87 @@ static int virtblk_probe(struct
> > > > > > virtio_device
> > > > > *vdev)
> > > > > >     return err;
> > > > > >  }
> > > > > >
> > > > > > +static bool virtblk_request_cancel(struct request *rq, void *d=
ata) {
> > > > > > +   struct virtblk_req *vbr =3D blk_mq_rq_to_pdu(rq);
> > > > > > +   struct virtio_blk *vblk =3D data;
> > > > > > +   struct virtio_blk_vq *vq;
> > > > > > +   unsigned long flags;
> > > > > > +
> > > > > > +   vq =3D &vblk->vqs[rq->mq_hctx->queue_num];
> > > > > > +
> > > > > > +   spin_lock_irqsave(&vq->lock, flags);
> > > > > > +
> > > > > > +   vbr->in_hdr.status =3D VIRTIO_BLK_S_IOERR;
> > > > > > +   if (blk_mq_request_started(rq) &&
> > !blk_mq_request_completed(rq))
> > > > > > +           blk_mq_complete_request(rq);
> > > > > > +
> > > > > > +   spin_unlock_irqrestore(&vq->lock, flags);
> > > > > > +   return true;
> > > > > > +}
> > > > > > +
> > > > > > +static void virtblk_broken_device_cleanup(struct virtio_blk *v=
blk) {
> > > > > > +   struct request_queue *q =3D vblk->disk->queue;
> > > > > > +
> > > > > > +   if (!virtqueue_is_broken(vblk->vqs[0].vq))
> > > > > > +           return;
> > > > >
> > > > > Can a subset of virtqueues be broken? If so, then this code
> > > > > doesn't handle
> > > it.
> > > > On device removal all the VQs are broken. This check only uses a VQ
> > > > to decide
> > > on.
> > > > In future may be more elaborate API to have virtio_dev_broken() can
> > > > be
> > > added.
> > > > Prefer to keep this patch without extending many APIs given it has =
Fixes
> > tag.
> > >
> > > virtblk_remove() is called not just when a PCI device is hot
> > > unplugged. For example, removing the virtio_blk kernel module or
> > > unbinding a specific virtio device instance also calls it.
> > >
> > This is ok.
> >
> > > My concern is that virtblk_broken_device_cleanup() is only intended
> > > for the cases where all virtqueues are broken or none are broken. If
> > > just the first virtqueue is broken then it completes requests on
> > > operational virtqueues and they may still raise an interrupt.
> > >
> > I see that vq broken is extended for each reset scenario too lately in
> > vp_modern_enable_vq_after_reset().
> > So yes, this patch which was intended for original surprise removal bug=
 where
> > vq broken was not done for reset cases.
> >
> > I believe for fixing the cited patch, device->broken flag should be use=
d.
> > Max indicated this in an internal review, but I was inclined to avoid a=
dding
> > many changes.
> > And hence reuse vq broken.
> >
> > So one option is to extend,
> >
> > virtio_break_device() to have a flag like below and check during remove=
().
> >   dev->broken =3D true;
> >
>
> I dig further.
> VQ resize is the only user of dynamically break-unbreak a VQ; and specifi=
c only to vnet device.
> So vq[0].broken check in this patch is sufficient in this proposed functi=
on without adding above dev->broken check.
>
> If no further comments, I would like to post v2 addressing your and Micha=
el's inputs.
> Please let me know.

Yes, please go ahead with the next revision.

Stefan
