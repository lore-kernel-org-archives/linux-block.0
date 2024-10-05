Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B16D182;
	Sat,  5 Oct 2024 00:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728088883; cv=none; b=Rxie88dpbXgl7GZzWSs8VpTL9+QDgTwSd+2zRKNGnV5/LO7IQ5Jypi56tytlFAtEmiWQgt0zTBXA2AEEEi25pVc9KicHs1KQ1wiRoFRtyxP/wfKBbBOcBb04X2q+CIPUES407V6rvtgGtMfdXrw1/XUgKyjE8DgVfWprgy1aM/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728088883; c=relaxed/simple;
	bh=LaR4kGrs9T92YX+VSRnrcfr1FVYBTPYB+H5z66zupfo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kP0z4qgiakLa5e0abZLTPOAdkqmwihhfs5fhd272xpZEUC/cW5AFCyWhbL0qr6SX0MyGceHGYhIvp0a76KKeskHkFBAX4tDPeayKxTQBh5tMnsFe/2YtNGnVN23fNAWkih4L89wsmpCiUo1pQjpr57AqXXT22Zi45L2pjjik0ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kG8inolI; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kG8inolI"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6dbb24ee2ebso28742487b3.1;
        Fri, 04 Oct 2024 17:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728088880; x=1728693680; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=owdQnnmJ0k9GqszQbsfRKFo2HloTe8ebu6VWxh7lnBE=;
        b=kG8inolIiy3EXdGrsRyhBhpeP0um7hXGz/C4oQ5LwnER00av2iDDS1t+894HDucbrP
         bVDIDVasPizH8RXncMB6CZDKooBSg9vPD/8Aa+VdjUQF3/XbycP/Xptk64v3rYKm/4aN
         jXDJlogQGl5cp+taaSR3sqtbPF8q8mhQ+7yyVC/CzKSkkX6ezU/e87zp7Yu27jIbsDxS
         dRybwFTMipLuSYuHGESgnbyP/AiDOZyB6w3BxvCFQ2RImR+2LwOknpFK+B3VpT33X2dh
         PvQ1EDFrAtjYhDnaTEb/Yfo+d0A0DGCvXvyKcye2jir0u/9/ol08By/inGyPU3wWsQOF
         T8ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728088880; x=1728693680;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=owdQnnmJ0k9GqszQbsfRKFo2HloTe8ebu6VWxh7lnBE=;
        b=dT5xyRpo7rZOjjZR/2/FlJggtKVoJwIAdTONaEKEdcBA0jAo8/eMKsdFlPPjMmd6Ov
         rW9zDpf0Iuvk0xr8qLxaFwq+GlH4qjXzPsOd0GxIzS7HXha/afszej+jXYku3kEHOTZ3
         Xn/2qBSQET79g4qb/XrW1C5kgwUnqgAEZjLYp5k6/Iabe7x0ljpOW+LIU8xi+RZmco5l
         2eRws5tQzuwuHZc1wGeOMbYpoygK6HRzOnhKHU6UN2Nc94PIcUnGvK/UOyBcfV6aCWcu
         XrklhWbvMND/UQ7rxkWDaB1jel5jKIbNta6uG1+aVabUlhoxh+gcPCmdhMNd6UfBpPve
         I8Hg==
X-Forwarded-Encrypted: i=1; AJvYcCU5w/jSdpVczZbnV0eZGw3SwbjUfdPFhg/mdqFHh7BD5Sr652dguhWlPTprHvStpauY45K04PM4BV2Inw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxnBKn8HCrFSBQjKX2AUSPAYmva9BNlGatt8NBg3LkHGMNXuIDZ
	qsrLnHiFuwr4hT82oBLv94ydgTmJulF/1pQnxT8RrgKla5XxiKRwdYkhtOKFPj2wwWqR4MijPUC
	MAsbnfBB439aoiKUDElgJZk+zx/k=
X-Google-Smtp-Source: AGHT+IEc4JsbDjOUOZUAYvNP80Xbb7FLwNWnw3A9w7KC2tYpBb8LjgwpuWtLeg559en8y1jJ5C3WUwbpFG3x3PmhmGU=
X-Received: by 2002:a05:690c:3088:b0:6e2:e3d:4dda with SMTP id
 00721157ae682-6e2c702506emr33846777b3.17.1728088880398; Fri, 04 Oct 2024
 17:41:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACzhbgTFesCa-tpyCqunUoTw-1P2EJ83zDzrcB4fbMi6nNNwng@mail.gmail.com>
 <20241004055854.GA14489@lst.de>
In-Reply-To: <20241004055854.GA14489@lst.de>
From: Leah Rumancik <leah.rumancik@gmail.com>
Date: Fri, 4 Oct 2024 17:41:08 -0700
Message-ID: <CACzhbgT_o0B7x9=c10QpRVEm1FuNaAU3Lh0cUGQ3B_+4s21cLw@mail.gmail.com>
Subject: Re: read regression for dm-snapshot with loopback
To: Christoph Hellwig <hch@lst.de>
Cc: stable@vger.kernel.org, axboe@kernel.dk, bvanassche@acm.org, 
	linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Cool, thanks. I'll poke around some more next week, but sounds good,
let's go ahead with 667ea36378 for 6.6 and 6.1 then.

- leah

On Thu, Oct 3, 2024 at 10:58=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> Hi Leah,
>
> On Thu, Oct 03, 2024 at 02:13:52PM -0700, Leah Rumancik wrote:
> > Hello,
> >
> > I have been investigating a read performance regression of dm-snapshot
> > on top of loopback in which the read time for a dd command increased
> > from 2min to 40min. I bisected the issue to dc5fc361d89 ("block:
> > attempt direct issue of plug list"). I blktraced before and after this
> > commit and the main difference I saw was that before this commit, when
> > the performance was good, there were a lot of IO unplugs on the loop
> > dev. After this commit, I saw 0 IO unplugs.
>
> /me makes a not that it might make sense to enhance the tracing to show
> which of the trace_block_unplug call sites did a particular unplug becaus=
e
> that might be helpful here, but I suspect the ones you saw the ones
> from blk_mq_dispatch_plug_list, which now gets bypassed.
>
> I'm not really sure how that changed things, except that I know in
> old kernels we had issues with reordering I/O in this path, and
> maybe your workload hit that?  Did the issue order change in the
> blktrace?
>
> > On the mainline, I was also able to bisect to a commit which fixed
> > this issue: 667ea36378cf ("loop: don't set QUEUE_FLAG_NOMERGES"). I
> > also blktraced before and after this commit, and unsurprisingly, the
> > main difference was that commit resulted in IO merges whereas
> > previously there were none being.
>
> With QUEUE_FLAG_NOMERGES even very basic merging is enabled, so that
> would fix any smaller amount of reordering.  It is in fact a bit
> stupid that this ever got set by default on the loop driver.
>
> > 6.6.y and 6.1.y and were both experiencing the performance issue. I
> > tried porting 667ea36378 to these branches; it applied cleanly and
> > resolved the issue for both. So perhaps we should consider it for the
> > stable trees, but it'd be great if someone from the block layer could
> > chime in with a better idea of what's going on here.
>
> I'm totally fine with backporting the patch.
>
