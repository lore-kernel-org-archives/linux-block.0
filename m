Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F921422D5
	for <linux-block@vger.kernel.org>; Wed, 22 May 2024 17:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716399446; cv=none; b=gPOhMpJe9alf75z5LUTRq8AcXdM1F5NbL9RGwuJWlWoYrbjpO6u3SM60XLw3gk0hQ+DoN3EZwUZb+TT72+fIp10jEBGWjzXAqUq37oaAXhx604P+zvN/E0aXlH7R/fCFUXqsFyB+pH/D1NzcbDpUa8MOEa+5KOHU4WdFUYWMS+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716399446; c=relaxed/simple;
	bh=BsCfFqXmskMjOpeSEN/u265PuQFM1MR/tOMn8LfJ/Y0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cInC8jIhDJvvluJsMjgjCfcgbOUMOSS86oiYKJCIzHIx7kTnfBTKJ3nZnAcRty8FCfyqLGk8iI325vbQzCO7waRNiWUWekq9mArNOVW3+9xhW89Qm8z1NmfDLe06HqPRJUhcU7XbMSlDFzLeWGCvSBQnqaT8tLUJneL2ejeYBmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mu2daiWf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mu2daiWf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716399443;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=llHIFO0/Fki+cPFoMQv30dTXRmTpbLAeQQBl/Bb7SGc=;
	b=Mu2daiWfO6NreyYRnB1elZwj/44fjszPMzqnyEo5mzaaRCZfC5jk+chI9jxvk/clo91KjA
	QYJcDiyeOgJcgK/JUpwihZWJ2krQGL5dVC0L+wFe52nLxM3WL2AGgaMc5dYt87i9CUNQSQ
	nJMyPS7D5cyFERD3RyTAswIDOmFsGoc=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-_2S5G3lGP9urYu_8j_Fsog-1; Wed, 22 May 2024 13:37:22 -0400
X-MC-Unique: _2S5G3lGP9urYu_8j_Fsog-1
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-61be530d024so255913997b3.2
        for <linux-block@vger.kernel.org>; Wed, 22 May 2024 10:37:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716399441; x=1717004241;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=llHIFO0/Fki+cPFoMQv30dTXRmTpbLAeQQBl/Bb7SGc=;
        b=vrksd0IatrmsvVHimPdsI5ZkQyuN4uISoz8ScB5S5BTIjCETBbY3eKpD/k9UE1r1On
         KKa48qsOIJErQutdLIuy6N2GuzWEb/d+pbRHpdZC9tPfGO8SOEfVYh6xOaqSchluuUEz
         xg3TD1n9nMYkOSw9AZjuGmjf93xQLYyLQpi/vAr+uyRgycVEa1BJFeJLzVlOxz3SGC+v
         g9CcebvrBtEmkC6RfNludccM0WoIfikya1dfdNQ1++ajuQG7P9YNqae1OVhv48PaKwWN
         XlcYQVzz6xoLKaRKvjI/jWC9Pcmm0YFqlBJQwoLBuP/8Q06Ns0A2Dwct1m3kaRWmZZDX
         hKGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUrLXbNtu+S5cT4VuALreXkVeUuYHW/ymS/zW+6Hyike+aeFvV+7qpfkopNf3cIxpBTFVKHMVqYcjrP0e2nvP9Ltbx6rIr6GRTMeo=
X-Gm-Message-State: AOJu0YxvlPokxgaH81oi+rrbcF1rXXfQNSHIJ7t2X+BpO8SyYIQ0QHqR
	JbCl1eKdFk+N0Y791xBtmxFI8YOw95QKwjGwJv9VONyJ0+m/NPgaV4qIJXm9G/K6mOTundQgeoL
	yNjvydH/9gQ1VaU6wux1+XD8IESLGYxrvq8Ao5lg5wS9XO3u6HhT6W5xLvXkO5AMdDXiE6eppOH
	A30/Zty+MBwR1nP2GYY10/KOoBtTTbGczyYb0=
X-Received: by 2002:a0d:df42:0:b0:619:5176:5e34 with SMTP id 00721157ae682-627e4658bd2mr25563487b3.18.1716399441525;
        Wed, 22 May 2024 10:37:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqqHn6QBnyL0lTqc0WTSwbHo1OjdUoiiNvEfqYstLHD0xqqU0pqXN9YQvZpMEZ3DT++9JhHSkyOOjLKQvcAqU=
X-Received: by 2002:a0d:df42:0:b0:619:5176:5e34 with SMTP id
 00721157ae682-627e4658bd2mr25563287b3.18.1716399441162; Wed, 22 May 2024
 10:37:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240522025117.75568-1-snitzer@kernel.org> <20240522142458.GB7502@lst.de>
 <Zk4h-6f2M0XmraJV@kernel.org>
In-Reply-To: <Zk4h-6f2M0XmraJV@kernel.org>
From: Ewan Milne <emilne@redhat.com>
Date: Wed, 22 May 2024 13:37:10 -0400
Message-ID: <CAGtn9rkzDdsq-_VQQfcRB8V9tD82_DWLx=pz+59DuBEkvuvOQw@mail.gmail.com>
Subject: Re: dm: retain stacked max_sectors when setting queue_limits
To: Mike Snitzer <snitzer@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, dm-devel@lists.linux.dev, linux-block@vger.kernel.org, 
	Marco Patalano <mpatalan@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

We tried the sd_revalidate_disk() change, just to be sure.  It didn't fix i=
t.

-Ewan

On Wed, May 22, 2024 at 12:49=E2=80=AFPM Mike Snitzer <snitzer@kernel.org> =
wrote:
>
> On Wed, May 22, 2024 at 04:24:58PM +0200, Christoph Hellwig wrote:
> > On Tue, May 21, 2024 at 10:51:17PM -0400, Mike Snitzer wrote:
> > > Otherwise, blk_validate_limits() will throw-away the max_sectors that
> > > was stacked from underlying device(s). In doing so it can set a
> > > max_sectors limit that violates underlying device limits.
> >
> > Hmm, yes it sort of is "throwing the limit away", but it really
> > recalculates it from max_hw_sectors, max_dev_sectors and user_max_secto=
rs.
>
> Yes, but it needs to do that recalculation at each level of a stacked
> device.  And then we need to combine them via blk_stack_limits() -- as
> is done with the various limits stacking loops in
> drivers/md/dm-table.c:dm_calculate_queue_limits
>
> > > This caused dm-multipath IO failures like the following because the
> > > underlying devices' max_sectors were stacked up to be 1024, yet
> > > blk_validate_limits() defaulted max_sectors to BLK_DEF_MAX_SECTORS_CA=
P
> > > (2560):
> >
> > I suspect the problem is that SCSI messed directly with max_sectors ins=
tead
> > and ignores max_user_sectors (and really shouldn't touch either, but th=
at's
> > a separate discussion).  Can you try the patch below and maybe also pro=
vide
> > the sysfs output for max_sectors_kb and max_hw_sectors_kb for all invol=
ved
> > devices?
>
> FYI, you can easily reproduce with:
>
> git clone https://github.com/snitm/mptest.git
> cd mptest
> <edit so it uses: export MULTIPATH_BACKEND_MODULE=3D"scsidebug">
> ./runtest ./tests/test_00_no_failure
>
> Also, best to change this line:
> ./lib/mpath_generic:        local _feature=3D"4 queue_if_no_path retain_a=
ttached_hw_handler queue_mode $MULTIPATH_QUEUE_MODE"
> to:
> ./lib/mpath_generic:        local _feature=3D"3 retain_attached_hw_handle=
r queue_mode $MULTIPATH_QUEUE_MODE"
> Otherwise the test will hang due to queue_if_no_path.
>
> all underlying scsi-debug scsi devices:
>
> ./max_hw_sectors_kb:2147483647
> ./max_sectors_kb:512
>
> multipath device:
>
> before my fix:
> ./max_hw_sectors_kb:2147483647
> ./max_sectors_kb:1280
>
> after my fix:
> ./max_hw_sectors_kb:2147483647
> ./max_sectors_kb:512
>
> > diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
> > index 332eb9dac22d91..f6c822c9cbd2d3 100644
> > --- a/drivers/scsi/sd.c
> > +++ b/drivers/scsi/sd.c
> > @@ -3700,8 +3700,10 @@ static int sd_revalidate_disk(struct gendisk *di=
sk)
> >        */
> >       if (sdkp->first_scan ||
> >           q->limits.max_sectors > q->limits.max_dev_sectors ||
> > -         q->limits.max_sectors > q->limits.max_hw_sectors)
> > +         q->limits.max_sectors > q->limits.max_hw_sectors) {
> >               q->limits.max_sectors =3D rw_max;
> > +             q->limits.max_user_sectors =3D rw_max;
> > +     }
> >
> >       sdkp->first_scan =3D 0;
> >
> >
>
> Driver shouldn't be changing max_user_sectors..
>
> But it also didn't fix it (mpath still gets ./max_sectors_kb:1280):
>
> [   74.872485] blk_insert_cloned_request: over max size limit. (2048 > 10=
24)
> [   74.872505] device-mapper: multipath: 254:3: Failing path 8:16.
> [   74.872620] blk_insert_cloned_request: over max size limit. (2048 > 10=
24)
> [   74.872641] device-mapper: multipath: 254:3: Failing path 8:32.
> [   74.872712] blk_insert_cloned_request: over max size limit. (2048 > 10=
24)
> [   74.872732] device-mapper: multipath: 254:3: Failing path 8:48.
> [   74.872788] blk_insert_cloned_request: over max size limit. (2048 > 10=
24)
> [   74.872808] device-mapper: multipath: 254:3: Failing path 8:64.
>
> Simply setting max_user_sectors won't help with stacked devices
> because blk_stack_limits() doesn't stack max_user_sectors.  It'll
> inform the underlying device's blk_validate_limits() calculation which
> will result in max_sectors having the desired value (which it already
> did, as I showed above).  But when stacking limits from underlying
> devices up to the higher-level dm-mpath queue_limits we still have
> information loss.
>
> Mike
>

