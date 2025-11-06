Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144B217C220
	for <linux-block@vger.kernel.org>; Thu,  6 Nov 2025 04:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762402035; cv=none; b=vCoUUOdVxeBDqWxyYgzYGrW0n8HbvOO+qk6tXYN4I2NLefeWffQlWJcNLZK2n6QeIRxehxE9ajDBIOBTJz9fUx+4CBDEVLCRFfjQo04Qn66CVdaFsUuFIcWcoIOp3v8o/qMgZWywvVy+n8d+NT0Y1GhI+0n0rMIJlPCWB/wsdaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762402035; c=relaxed/simple;
	bh=/j8IwCwfnUpo7t3t7ZYWNOWrViZy1XGN5IE6aVd3q2w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NfRsPDbDjzxeqVYrW3NBcRkGl4u8fHiy5LFaMwKpDtF2XyPCbvtjZWQ5oP7hg7Rz9/lhcjjgJ3mgS2PRhTQmE8oLwXgQP1ou6kpDWtIXl5fOHLQ0VmT/EvBxU4/dj6poG6aFWwLAeuuDfzVZekBJ5E4QCfPnb5rd1+WFJV+6qCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EHNRXLvN; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=M/oY2lKK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EHNRXLvN";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="M/oY2lKK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762402031;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LoU2+gnsfiuqREd6bvWYLEq5UZ7fNohYOQZcwDScec8=;
	b=EHNRXLvNp9nFU7DYmgynVOHFkuFY9S8zoLHKjWkIxWDApHp+VO4rduWpfI1Lay61D6jB69
	IZLnjiyhBQe4sqr0h/MFOTLzf786FOzSJpQGrtV1NtP0ens2qQrOi6fZ8ctWdXW/KH3hIP
	OfquDF/I46iCkD28qhu0jLDqMenIgbU=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-AbFLtSh8Nie5fSoIIYSnVw-1; Wed, 05 Nov 2025 23:07:09 -0500
X-MC-Unique: AbFLtSh8Nie5fSoIIYSnVw-1
X-Mimecast-MFC-AGG-ID: AbFLtSh8Nie5fSoIIYSnVw_1762402029
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-33baf262850so616712a91.0
        for <linux-block@vger.kernel.org>; Wed, 05 Nov 2025 20:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762402028; x=1763006828; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LoU2+gnsfiuqREd6bvWYLEq5UZ7fNohYOQZcwDScec8=;
        b=M/oY2lKKRaJiDPTUxwZdlbnv6Hka+sN/775RWNPUIwaLCbYNdjXZwIMZhhGIl3/1gs
         Rz7CKDDaSIlVMn4gxKFW6f33jfjWgpYYhogQQxDnsUEGblAFHzBSiG8CEPeUZloowm3n
         dP08pj97So4mbG5PuaGYACimpuiwBqGXhn6uajAugHgSdOTQx0rGVexgkr7Cl0dASOnC
         6mlpXrFRhom0rFCabAMtLL2pXiKVXMP4z7g1HctMEcxC84XhYJHiGPWaUegN2vnN0zmx
         GFJPHfLvh4b8BQPvd94aiWBp9xjKHwBSc5Sq0MjsMeQuc3TAWRZRUETcoZGU5SNroDgw
         eHyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762402028; x=1763006828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LoU2+gnsfiuqREd6bvWYLEq5UZ7fNohYOQZcwDScec8=;
        b=lXo/69hbY95O94MDP0kUdaAf/kQdzM93xHNfw2Jz+oWZr2VnKBj4p/G5M0RU9cPf28
         AQe4EC7H9TyY7YdwMpofPErxfa4wU+Isc6e4gDaylsGewl6O1zUlZT/FFsWxY5ffutmJ
         b1S8p2gEruP7ke5lsn/kWOXJRgWJsp12vjiHRfBO+Z0iZtrJElRjZRyqa1phnykm+MGX
         inAQG6tFwvJTD7W5UmiBt1gu/kttl+SJcdoxUiBDBUDml6ew4jRdnwDWttic/7vM8XHt
         /Zvl8S0F++vmOSAfEVL036xHaW6RwEP9XLVLW2OOZA5LNr+DIQJ+6alevVe9N3ExnwJ0
         /zLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtmYb4FBN0PhJIJdY6cIu9ELTbq0WjlS3gfHYUFE4+3a0uEg8bkcMkEAV40MEOE5dC2Ix8kBshWh2Sqw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyoqQi+EJk5JCNPiZuUc/8iztg+SxfKvWwLQrfhUz1bfT1t0g31
	s5Ag/9wMfqJ0qNo/60EKdyZ4hGV0123zvEQiprSIlYe/j1hks5f50/qFeDi5O4ExtgtAwzdbgQh
	bkeX0N29AMwYd/PWI5rW9dfD2EeX6B1xG9aXXAQG0uFENm9NfoEBfymPH4uVJRpE1ZyqQOdycby
	aijgUYnG3wZE+QAsmDRKuz3xmJAKctpooJ52rl6ho=
X-Gm-Gg: ASbGnct9Qn0skX410JlauiSRBc2fNhmeQdbi1V5uTrpDytD9dS8KRjk7wOPomrTcAS1
	hKtp8EZD13uPg1qJKHLWdt8ytea2RYDw6fblJCuJMvsCnkZdo+NKJb38W9pPMl9aqUZeDHyxPq9
	j/X19X8p2gCFVlld6isU3/V0MVnmhqQUz211vvQMPxT3YIIB0bcwEiWLB8
X-Received: by 2002:a17:90b:1f88:b0:340:c060:4d44 with SMTP id 98e67ed59e1d1-341a6c4d7aamr7027660a91.14.1762402028612;
        Wed, 05 Nov 2025 20:07:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGgxzLPmIUN23c30q2w75GF2Oo+BHzJVke+jXJuO4CwdOMsjKJErSE1VijPnPth7Jf9XW5Vf/Zgdu/s2JTjPzA=
X-Received: by 2002:a17:90b:1f88:b0:340:c060:4d44 with SMTP id
 98e67ed59e1d1-341a6c4d7aamr7027630a91.14.1762402028159; Wed, 05 Nov 2025
 20:07:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021-virtio_double_free-v1-1-4dd0cfd258f1@oss.qualcomm.com>
 <20251021085030-mutt-send-email-mst@kernel.org> <CACGkMEsU3+OWv=6mvQgP2iGL3Pe09=8PkTVA=2d9DPQ_SbTNSA@mail.gmail.com>
 <20251022014453-mutt-send-email-mst@kernel.org> <20251022030050-mutt-send-email-mst@kernel.org>
 <f7401703-e912-4d61-b206-f9f1de930092@oss.qualcomm.com> <8910d20d-dc47-4a12-9e83-204174154663@oss.qualcomm.com>
In-Reply-To: <8910d20d-dc47-4a12-9e83-204174154663@oss.qualcomm.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 6 Nov 2025 12:06:56 +0800
X-Gm-Features: AWmQ_bl1nw_u7Z9-YxAPWR_NNGdbr60ykEVvrchMvodD52Y0yrObCchz2OB8nro
Message-ID: <CACGkMEuD43oH7zshX-Jf+nvxZmkw730vcX4fcFH9+2z6b_8O-g@mail.gmail.com>
Subject: Re: [PATCH] virtio_blk: NULL out vqs to avoid double free on failed resume
To: Cong Zhang <cong.zhang@oss.qualcomm.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
	linux-arm-msm@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	pavan.kondeti@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 4:56=E2=80=AFPM Cong Zhang <cong.zhang@oss.qualcomm.=
com> wrote:
>
>
>
> On 10/22/2025 4:02 PM, Cong Zhang wrote:
> >
> >
> > On 10/22/2025 3:01 PM, Michael S. Tsirkin wrote:
> >> On Wed, Oct 22, 2025 at 01:45:38AM -0400, Michael S. Tsirkin wrote:
> >>> On Wed, Oct 22, 2025 at 12:19:19PM +0800, Jason Wang wrote:
> >>>> On Tue, Oct 21, 2025 at 8:58=E2=80=AFPM Michael S. Tsirkin <mst@redh=
at.com> wrote:
> >>>>>
> >>>>> On Tue, Oct 21, 2025 at 07:07:56PM +0800, Cong Zhang wrote:
> >>>>>> The vblk->vqs releases during freeze. If resume fails before vblk-=
>vqs
> >>>>>> is allocated, later freeze/remove may attempt to free vqs again.
> >>>>>> Set vblk->vqs to NULL after freeing to avoid double free.
> >>>>>>
> >>>>>> Signed-off-by: Cong Zhang <cong.zhang@oss.qualcomm.com>
> >>>>>> ---
> >>>>>> The patch fixes a double free issue that occurs in virtio_blk duri=
ng
> >>>>>> freeze/resume.
> >>>>>> The issue is caused by:
> >>>>>> 1. During the first freeze, vblk->vqs is freed but pointer is not =
set to
> >>>>>>    NULL.
> >>>>>> 2. Virtio block device fails before vblk->vqs is allocated during =
resume.
> >>>>>> 3. During the next freeze, vblk->vqs gets freed again, causing the
> >>>>>>    double free crash.
> >>>>>
> >>>>> this part I don't get. if restore fails, how can freeze be called
> >>>>> again?
> >>>>
> >>>> For example, could it be triggered by the user?
> >>>>
> >>>> Thanks
> >>>
> >>> I don't know - were you able to trigger it? how?
> >>
> >> Sorry I mean the submitter of course.
> >>
> >
> > Let me add more details:
> > Autosleep is enabled in this case. When the system wakes up from
> > suspend, it will call virtio_device_restore. The failure happens in the
> > virtio_device_restore function before vblk->vqs has been allocated. The
> > system still gets woken up after the failure happens. Since autosleep i=
s
> > enabled and there is no wakelock being held, the system will try to
> > suspend again. Then virtio_device_freeze will be called and causes the
> > issue.
> >
>
> Gentle reminder.
> Please let me know if you need any additional information.

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

>
> >>>
> >>>>>
> >>>>>> ---
> >>>>>>  drivers/block/virtio_blk.c | 13 ++++++++++++-
> >>>>>>  1 file changed, 12 insertions(+), 1 deletion(-)
> >>>>>>
> >>>>>> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk=
.c
> >>>>>> index f061420dfb10c40b21765b173fab7046aa447506..746795066d7f56a01c=
9a9c0344d24f9fa06841eb 100644
> >>>>>> --- a/drivers/block/virtio_blk.c
> >>>>>> +++ b/drivers/block/virtio_blk.c
> >>>>>> @@ -1026,8 +1026,13 @@ static int init_vq(struct virtio_blk *vblk)
> >>>>>>  out:
> >>>>>>       kfree(vqs);
> >>>>>>       kfree(vqs_info);
> >>>>>> -     if (err)
> >>>>>> +     if (err) {
> >>>>>>               kfree(vblk->vqs);
> >>>>>> +             /*
> >>>>>> +              * Set to NULL to prevent freeing vqs again during f=
reezing.
> >>>>>> +              */
> >>>>>> +             vblk->vqs =3D NULL;
> >>>>>> +     }
> >>>>>>       return err;
> >>>>>>  }
> >>>>>>
> >>>>>
> >>>>>> @@ -1598,6 +1603,12 @@ static int virtblk_freeze_priv(struct virti=
o_device *vdev)
> >>>>>>
> >>>>>>       vdev->config->del_vqs(vdev);
> >>>>>>       kfree(vblk->vqs);
> >>>>>> +     /*
> >>>>>> +      * Set to NULL to prevent freeing vqs again after a failed v=
qs
> >>>>>> +      * allocation during resume. Note that kfree() already handl=
es NULL
> >>>>>> +      * pointers safely.
> >>>>>> +      */
> >>>>>> +     vblk->vqs =3D NULL;
> >>>>>>
> >>>>>>       return 0;
> >>>>>>  }
> >>>>>>
> >>>>>> ---
> >>>>>> base-commit: 8e2755d7779a95dd61d8997ebce33ff8b1efd3fb
> >>>>>> change-id: 20250926-virtio_double_free-7ab880d82a17
> >>>>>>
> >>>>>> Best regards,
> >>>>>> --
> >>>>>> Cong Zhang <cong.zhang@oss.qualcomm.com>
> >>>>>
> >>
> >
>

