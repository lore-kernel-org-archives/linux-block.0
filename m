Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9146B28EF
	for <linux-block@vger.kernel.org>; Mon,  9 Sep 2024 01:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725843626; cv=none; b=DevK91UfY9GTtWkU2ZvGbjkUR1e+XTwxbjV9t6WRaMna3RZjSmOuw6zpwsJka5pqM06XKuR1VXz9Vr+Zy9Wkuf3evqhwHk5v1CsmiUiK4tmUmSS5Wfd9yyKXTfJwxBcXgB954JKot5WNDVcyQryuWJlV7YmZNP+BtKEiDjAppHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725843626; c=relaxed/simple;
	bh=LENb559i3gtdmxRorJ/+T5bygb13Nhm7BQayvUjmpWE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZpO2pvQ0n5Z7tJ4HJohVJaWxdvfLJO5xcn50bgF2rlxOHx4VrShCTkomU7h/Pta9p6eZoVsjhOUf0tHO8ZqQixAjqvGOoQd+v4FGO4xB3GWtL2LgobFvm28MO8pnXXXvzLnvQjXr3ydSA2AIQ4iM75QLr12hux3mWffU0vnBsG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FlbGUL/p; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FlbGUL/p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725843623;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tzfWvFNCLsuZfCjReptvrPBIP7wuqPxZYgfoKlq9KI8=;
	b=FlbGUL/p7dZG2sN0uB+frnrrc9pUR/BF5g5MdNFDN7jCbR5NlbRT8Krj4F6pFdJsv4t58U
	zcV+818wl3GdpNRvzlpU48tOhYR2kLsBSHId8fgOsv0V3usnfetAtuEhQAZGIOQp01Mfb7
	Y0fbPkcAscm36uVEDvV8fa+owD1K9uk=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-8RPQKU5mMnKIN0WsfU6QPw-1; Sun, 08 Sep 2024 21:00:22 -0400
X-MC-Unique: 8RPQKU5mMnKIN0WsfU6QPw-1
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-49bc2df862aso1243358137.1
        for <linux-block@vger.kernel.org>; Sun, 08 Sep 2024 18:00:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725843621; x=1726448421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tzfWvFNCLsuZfCjReptvrPBIP7wuqPxZYgfoKlq9KI8=;
        b=cauk4xVuef+Nq+CVn3STi/+ZiIjkKdsPEfW+i1BSdngFxV6RGLue5+ODXNaoGAiGrf
         95BrCiZ7krIuTH8t0HSDs2+uBCDSGp4CdZZ0GeN1PBl4zG6vWipWKGwUVFyxsM2yW1C4
         tm4wg33ejRf4LobN+ZDElmzcUwfHrukZTTZ9GEjis7LvMtMObVjKEBVZgZzHLZd8A2KB
         L7WGIQiscyXLW5DBhENpynzd1E36FY0jlKjbilo/WdbHVab17/VmppeZzu1dnWZpvPQs
         EM6SZcFH1tjpEuOQda/a9azb2ON6L2hpCpQ13y0VaVgQCG0MjcqPNWqJntiPJyAGoN/q
         yW9A==
X-Forwarded-Encrypted: i=1; AJvYcCVpHy9bMD7XkJevMIdz/6VFXy6Glbp5WU9DMHC5lU44+i0X9uPP8dA9CJQwtKWyH3RNLppahd5t0PabIQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzgTRNUvWg2zDX1MVUCIZC4IOSVyWEdbIPmKdRBVkSdpcmUtgI3
	+J31Od52JVih9Of25CvZb58fWlkVmvtXEBxg0F6cgWZE4ZlJsIvSopfPJxN0gAecBOSy+0zEfA/
	OaCO2RYepYCLdTqCZEO7GKSyF1ky60lMsCWxqQS/o7EgD2MUyyuOkFAqGaxNr7ywiM5Cit42PXv
	RJfEry0aSPBZE04a3TlC9R0KM9CsWZHy2o9qc=
X-Received: by 2002:a05:6102:3230:b0:492:9f6a:e980 with SMTP id ada2fe7eead31-49bece53fb4mr2415618137.27.1725843621573;
        Sun, 08 Sep 2024 18:00:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwmi/j3scNS+oVUs06dKJmTo/v/SoYg6g2RWxfVUIYfqU1ahQ2BwX1AgrlqyRcJCWb/0Lo09CeXZUXSwJjCmA=
X-Received: by 2002:a05:6102:3230:b0:492:9f6a:e980 with SMTP id
 ada2fe7eead31-49bece53fb4mr2415587137.27.1725843620998; Sun, 08 Sep 2024
 18:00:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240907014331.176152-1-ming.lei@redhat.com> <20240907073522.GW1450@redhat.com>
 <ZtwHwTh6FYn+WnGD@fedora> <4d7280eb-7f26-4652-a1d4-4f82c4d99a4c@kernel.org>
 <ZtwhfCtDpTrBUFY+@fedora> <20240907100213.GY1450@redhat.com>
 <Ztwl2RvR0DGbNuex@fedora> <20240907103632.GZ1450@redhat.com>
 <ZtwyxukuaXAscXsz@fedora> <20240907111453.GA1450@redhat.com> <2d50513f-bdcb-4af1-b365-e080be43d420@kernel.org>
In-Reply-To: <2d50513f-bdcb-4af1-b365-e080be43d420@kernel.org>
From: Ming Lei <ming.lei@redhat.com>
Date: Mon, 9 Sep 2024 09:00:09 +0800
Message-ID: <CAFj5m9LeQy2sCbzxFHTmemskf5X2+tueG9NGHD1X7wHzWGLcvQ@mail.gmail.com>
Subject: Re: [PATCH] block: elevator: avoid to load iosched module from this disk
To: Damien Le Moal <dlemoal@kernel.org>
Cc: "Richard W.M. Jones" <rjones@redhat.com>, Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Jeff Moyer <jmoyer@redhat.com>, Jiri Jaburek <jjaburek@redhat.com>, Christoph Hellwig <hch@lst.de>, 
	Bart Van Assche <bvanassche@acm.org>, Hannes Reinecke <hare@suse.de>, Chaitanya Kulkarni <kch@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 8, 2024 at 8:03=E2=80=AFAM Damien Le Moal <dlemoal@kernel.org> =
wrote:
>
> On 9/7/24 20:14, Richard W.M. Jones wrote:
> > On Sat, Sep 07, 2024 at 07:02:30PM +0800, Ming Lei wrote:
> >> BTW, the issue can be reproduced 100% by:
> >>
> >> echo "deadlock" > /sys/block/$ROOT_DISK/queue/scheduler
>
> This probably should be:
>
> echo "mq-deadline" > /sys/block/$ROOT_DISK/queue/scheduler
>
> and make sure that:
> 1) mq-deadline is compiled as a module
> 2) mq-deadline is not already used by a device (so not loaded already)
> 3) The mq-deadline module file is stored on the target device of the sche=
duler
> change
> 4) The mq-deadline module file is not already cahced in the page cache.
>
> For (4), you may want to do a "echo 3 > /proc/sys/vm/drop_caches" before =
trying
> to switch the scheduler.
>
> >
> > That doesn't reproduce it for me (reliably).  Although I'm not
> > surprised as this bug has been _very_ tricky to reproduce!  Sometimes
> > I think I have a definite reproducer, only for it to go away when some
> > tiny detail changes.
> >
> >>> This seems like the neatest (or shortest) fix so far, but doesn't it
> >>> "mix up layers" by checking elv_iosched_store?
> >>
> >> It is just one exception for 'scheduler' sysfs attribute wrt. freezing
> >> queue for storing, and the check can be done via the attribute
> >> name("scheduler") too.
> >
> > Fair enough.
> >
> > Rich.
> >
>
> --
> Damien Le Moal
> Western Digital Research
>

