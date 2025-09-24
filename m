Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79D32DC33B
	for <linux-block@vger.kernel.org>; Wed, 24 Sep 2025 10:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758708313; cv=none; b=GqRgBrnTk1ahZdgDLy2wysbJemE3mnp/1HxjquEX8Wn+vsp9T7n8g9PJx8b0HHv3wWSKVjJRAhs2wV71VDyaf9Fbc2ntqzyW0cUD/Xl3RcrpGuvPrtNsNNY8bf0eZnTNFmLtBMtkt5VdsfcOkFjCwC7dMHf0qNkwXYCxCRZTh0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758708313; c=relaxed/simple;
	bh=pKcp8RbB9qIjTq//aq8x3wJaE/cjRo/2DCN671q8C4I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RZqI1uAlVns0qieLbQvW17ZpYB3hdtYzqPjuEcLkTowma7NU0pQ/aJxqWi9osU/yopy28OhJy+SNvrcD+PvoGZihoonfxDq0mZ4wWmtw4rpZuVIrxo51RxxeJmr5y2QRyPakfa1IDKlVOJrA81LaalpC44wkgRk1uDa3htxporA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ErseWRNi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ErseWRNi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758708306;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pKcp8RbB9qIjTq//aq8x3wJaE/cjRo/2DCN671q8C4I=;
	b=ErseWRNi+6pJT6rKd0Mk78BAFvCuIqVS0VG20GInb8pg6q3dCLsekUUBZ/4kZ2rAlknRKu
	EA7+Qio9wr3ckp8WfSmNpuSt+/UY8AsY1FM8DgGgdISiK3zWSh8QW+Kx/8YCKAkjp0ysPd
	sJ0RBJ+OJcnjx1aiDK3NPzOLbBO+h2I=
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624--D7mvjrmPgOhMdDrK_y8Jw-1; Wed, 24 Sep 2025 06:05:05 -0400
X-MC-Unique: -D7mvjrmPgOhMdDrK_y8Jw-1
X-Mimecast-MFC-AGG-ID: -D7mvjrmPgOhMdDrK_y8Jw_1758708305
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-54a7d8436a4so1811954e0c.3
        for <linux-block@vger.kernel.org>; Wed, 24 Sep 2025 03:05:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758708305; x=1759313105;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pKcp8RbB9qIjTq//aq8x3wJaE/cjRo/2DCN671q8C4I=;
        b=egZw2mHonm8N4IgwvvHSWbLr2zuQ0RTaUZBdHgz/n1HIVa+lFvrTxwUUfLL3d22FLB
         e32z/jmx5rDX3+H/DJ8i87htIP9PGxdCtahMvVlWMlURYn+BQ+ubQoQ0zlSiFVfWexXp
         uUS8qedT8z5J/fec9NOzPb+I0F4x7qwXiYp8qOsYb9sCCITeY0kIZfMJZu0qjhVVhC7b
         50WjZjABDXnm45An6zQg63s3wjjiCvEwfbZWRKVHYQToJmNWxYwox0NPKz8tyJ9VyQYu
         K3BcORLS4yjMsKeJwU36Z8yNtXpD8YrVYTg7XlgqzLvA7naqrEBZVPmpAyCD0bfTne02
         tIIw==
X-Forwarded-Encrypted: i=1; AJvYcCWBHLMfoKaPRl8Act3NSv1IK3k7oygAvBGsRYyo02GMTtbfEtzbXGaPSzBDMVzeMF2QI0/eAhIlT436sg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyxJLzpxOlX1yKHM/We9zSI03B+a6oI3BihSRVAEpGEXpQDzdMv
	BqmwjBi1yAVB+Rld/J+H4XncEfVTFTjHQ+AMSPKwR5pHr7bLQ8iDuT/qkU7drgYzKx4MZ+32Nqu
	8UCnl8ZztS0mbGOqpwDEUGUA2hAUMR3t3AyY8KAM1KlwuJwIUm7iHTrAxfIHEVvTJctPdewio9M
	8ppbOMwTLNlOAMbBgEoxzp/pAPR0JoDMoTgM+gke0=
X-Gm-Gg: ASbGnctqB9KIRMpPA93bgrXvwBljyNkvKBJcI1KAhvTAB7KWL2BHjtD7I0SnSrRUAP9
	lBhhr3A9OvxUJJzpTrQVTWeh3Xe3NVyZumhOdX+lLMfXQYj9veKCASf0z/m/fYatVO3TS3TvOS8
	0M6hFkehYezFNhANJvlcxt7Q==
X-Received: by 2002:a05:6122:46a7:b0:54a:a874:6e4e with SMTP id 71dfb90a1353d-54bcb11e0c6mr1653516e0c.8.1758708304812;
        Wed, 24 Sep 2025 03:05:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPptVrEMQd0wcOTvVhc2Oe3+W+CQLov4+tsA34aiA7Aw3gYYXeQI2LOHtMUYKKnuN1qYBzcewy7H1XCDRJWDE=
X-Received: by 2002:a05:6122:46a7:b0:54a:a874:6e4e with SMTP id
 71dfb90a1353d-54bcb11e0c6mr1653503e0c.8.1758708304461; Wed, 24 Sep 2025
 03:05:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250922032915.3924368-1-zhaoyang.huang@unisoc.com>
 <aNGQ66CD9F82BFP-@infradead.org> <CAGWkznGf1eN-iszG21jGNq13C9yz8S0PW03hLc40Gjhn6LRp0Q@mail.gmail.com>
 <31091c95-1d0c-4e5a-a53b-929529bf0996@acm.org> <CAGWkznGv3jwTLW2nkBds9NrUeNQ1GHK=2kijDotH=DN762PyEQ@mail.gmail.com>
In-Reply-To: <CAGWkznGv3jwTLW2nkBds9NrUeNQ1GHK=2kijDotH=DN762PyEQ@mail.gmail.com>
From: Ming Lei <ming.lei@redhat.com>
Date: Wed, 24 Sep 2025 18:04:52 +0800
X-Gm-Features: AS18NWAzS4ovR9ej7R-yAyhG3XtRFr7Vvnznyh6lks2oABccTIKfG0VXhGRlpdg
Message-ID: <CAFj5m9K4yv4wkX2bhXSOf141dY9O96WdNfjMMYXCOoyM_Fdndg@mail.gmail.com>
Subject: Re: [RFC PATCH] driver: loop: introduce synchronized read for loop driver
To: Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc: Bart Van Assche <bvanassche@acm.org>, Suren Baghdasaryan <surenb@google.com>, Todd Kjos <tkjos@android.com>, 
	Christoph Hellwig <hch@infradead.org>, "zhaoyang.huang" <zhaoyang.huang@unisoc.com>, 
	Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, steve.kang@unisoc.com, 
	Minchan Kim <minchan@kernel.org>, Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 5:13=E2=80=AFPM Zhaoyang Huang <huangzhaoyang@gmail=
.com> wrote:
>
> loop google kernel team. When active_depth of the cgroupv2 is set to
> 3, the loop device's request I2C will be affected by schedule latency
> which is introduced by huge numbers of kworker thread corresponding to
> blkcg for each. What's your opinion on this RFC patch?

There are some issues on this RFC patch:

- current->plug can't be touched by driver, cause there can be request
from other devices

- you can't sleep in loop_queue_rq()

The following patchset should address your issue, and I can rebase & resend
if no one objects.

https://lore.kernel.org/linux-block/20250322012617.354222-1-ming.lei@redhat=
.com/

Thanks,


>
> On Wed, Sep 24, 2025 at 12:30=E2=80=AFAM Bart Van Assche <bvanassche@acm.=
org> wrote:
> >
> > On 9/22/25 8:50 PM, Zhaoyang Huang wrote:
> > > Yes, we have tried to solve this case from the above perspective. As
> > > to the scheduler, packing small tasks to one core(Big core in ARM)
> > > instead of spreading them is desired for power-saving reasons. To the
> > > number of kworker threads, it is upon current design which will creat=
e
> > > new work for each blkcg. According to ANDROID's current approach, eac=
h
> > > PID takes one cgroup and correspondingly a kworker thread which
> > > actually induces this scenario.
> >
> > More cgroups means more overhead from cgroup-internal tasks, e.g.
> > accumulating statistics. How about requesting to the Android core team
> > to review the approach of associating one cgroup with each PID? I'm
> > wondering whether the approach of one cgroup per aggregate profile
> > (SCHED_SP_BACKGROUND, SCHED_SP_FOREGROUND, ...) would work.
> >
> > Thanks,
> >
> > Bart.
>

