Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF71731A045
	for <linux-block@vger.kernel.org>; Mon,  1 Jun 2026 23:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780356990; cv=none; b=iWzvPWQM+OeVaOfukI673PtKvs1NPgbtS8RoaYclxqLKcjO781AOcUHrTOw9RpBqHgPE6eOZLJPlKSU6Iw8X1ONAcSx99WSGDOYkHtBbvBaa59BBP+HGfZ8CeKOAysHg2qNA/wbDGoJORlJow5wvReXbM+JXLkQc2tyGPNz+QlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780356990; c=relaxed/simple;
	bh=ubxfeLPdcu1tVOhHcYgp2xMfaoJ97BNsAlzIcGHV6/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PNK3ptUEVzZv8jh3zJBKZ3ZU6qmWwwChmMQ4H13MLJfHdWdXWN9eJyLwLiu0fR50pUfw3hCn+tdmnCppaB24TS+WNtinUuGwar++6sVknjXwoUXZlNaRqOfnaMc6ON5fO1Zjz2sSKONrQk4Had1SQLEvcnlB+YBQdLt0iuJizxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ddwHSC9V; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ddwHSC9V"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8ccf18ef922so37897216d6.3
        for <linux-block@vger.kernel.org>; Mon, 01 Jun 2026 16:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780356989; x=1780961789; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Auwu0u4sLco5ByZK6OrYXLLV/GCMBjlydMcsMEYP59Q=;
        b=ddwHSC9V9/TqoKM1sk0TKX+APtKM3XPoAaVruNWBXQXs5Ps+BhIKIFnJvBKhgqw81V
         6OnNpKSjlKWIAppTM9ST1L9H0hBaGBcxkM6BXePPCitpsQRzm6ewwDtmUqw96wiLFD/0
         sp1gDOMM64HA/yLiPth/HZiJEaparID8bEOwTFM5IuKAP48J4+Voh7O9IWEai+EIepfq
         pKcPaAhJUa5NaPAN6/ZcfJB4ajKEJV1FZ6ReZmaZYESI6Yi+3sX1uWQXE9lri/Tc8h55
         NR5LwTHlptvOwspP6PIw5CrtkUmLqBT7pvMVHSMwpQkNIKIDm4QsI+42iUSiIoBLd74F
         7N8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780356989; x=1780961789;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Auwu0u4sLco5ByZK6OrYXLLV/GCMBjlydMcsMEYP59Q=;
        b=qoQlpXnpEW0FzIk+Oau3GYaWPojzDPXhzaPn1a637A7Ce+mmSgPvAfnrfysLjfqR7J
         Zp+yQWJ5wd/Bo3Yjy2gyBnfjGaXCNs+qgJY5j6STXzEF5Erz/ou7c4VI0pF2epauL+PS
         bDjScxt8w5Yce3e87f8a1QGkeGAv2/Kp9H/tYVAorgfn5OItmhRYblgYVjg9JAxBURMK
         UczUiCkP5Tnh6bDFd7id81LP5PuB//bmiFRiznnaOmURnqbcyNF1nMCgEPIaKcDTpczh
         645/q15gc9XMd/4aFtRNBmJOaHBQRSxcKoRAjEOJBJ+U0hNagc61xqWV+M32zIwdAuIH
         jDiA==
X-Forwarded-Encrypted: i=1; AFNElJ/oY7ULqKndhtSkWkw0K7bHKi87YR2BgBI635TcFaug6gAg32TId9dHSEMz8uZjnkuvQLFdjKALffd5hQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx39JDV4UODkE9mNmafrsurN0TDPq/62V+BGpaPQ+OyNs/dSMjg
	2yJoVYOZZ8cpUPsB0qqDpmhtMnTsrkPKmfQotNX1hd6KBz5M+1zyWrv6
X-Gm-Gg: Acq92OGUIVYiPRGpw56nY8NKUb8X60qRPaXYS/U5QdX1GjHTqnlob6Jmn9zCQWf96Pq
	k5uvjo7qoBAVYsOw9NPpz4s9+fdA7Hw8ExTwSqvXrbmifO8TqIM0lPCIMqBrCLQkadeJ6ihsr+f
	uHSNd8JAmwnXf+dKpIr2A+sk+zwxB1qfKfb9DjASteVDxg6hfEQHI83b9wFNbxR3dhoNctMMVto
	8BaaiYKyGvocVz+i+a+uUPOO4esgn5Cb25aVrvHpWdYcIYWDuBGRdYj0o0zc03mXwqQ6VbVYQtI
	rkMCipADSFi67JvaaeGRE7Sc0rPVGwFJqz0foLY2n/fE2IrOT1Y91s/0Lr3qcUJ80ShNtJN5UGy
	sRoEiztdUPl7dXpONksvjgzKiLmIelAX/EVjHEvYsjzbZ27uTJLv+/6WI/oe79L+1KFqQRe4NN0
	XOzfnvBNhRaIRQM/CwlnxWvtYeL4XsiDAOjQ1FHz6MhNTOhABPTHXABMxuT9V6H0JPnffDFdc6V
	OgUWAVhqnaHC9O+dGl12wbYwY4qY3fv19GskRstNA==
X-Received: by 2002:a05:622a:299b:b0:517:58f6:29c3 with SMTP id d75a77b69052e-51758f642edmr75885911cf.32.1780356988761;
        Mon, 01 Jun 2026 16:36:28 -0700 (PDT)
Received: from fedora ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ccea042bb5sm105823496d6.8.2026.06.01.16.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 16:36:27 -0700 (PDT)
Date: Mon, 1 Jun 2026 18:36:19 -0500
From: Ming Lei <tom.leiming@gmail.com>
To: Hillf Danton <hdanton@sina.com>
Cc: Qu Wenruo <wqu@suse.com>, Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bvanassche@acm.org>,
	linux-block <linux-block@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v3] loop: Fix NULL pointer dereference in lo_rw_aio()
Message-ID: <ah4Xc7OmGle_C5M3@fedora>
References: <ah4EY2nhPxEETufZ@fedora>
 <20260601231731.1403-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260601231731.1403-1-hdanton@sina.com>

On Tue, Jun 02, 2026 at 07:17:30AM +0800, Hillf Danton wrote:
> On Mon, 1 Jun 2026 17:14:59 -0500 Ming Lei wrote:
> > On Tue, Jun 02, 2026 at 05:51:26AM +0800, Hillf Danton wrote:
> > > On OnMon, 1 Jun 2026 10:29:25 -0500 Ming Lei wrote:
> > > > syzbot log shows the null-ptr-deref  is on WRITE, instead of DISCARD.
> > > >
> > > > https://syzkaller.appspot.com/bug?extid=cd8a9a308e879a4e2c28
> > > >
> > > > Adding WARN_ON(!lo->lo_backing_file) in loop_queue_rq() might capture
> > > > this bio submission context if this req isn't issued via wq.
> > > >
> > > I suspect this makes $.02 sense given the check of Lo_bound upon queuing rq.
> > 
> > Can't lo->lo_state be updated after the check? It is totally lockless...
> >
> Sounds good hm... do you mean it is UNWISE to not flush the loop workqueue
> when closing disk?

Quite the opposite, it is wise to not flush wq in __loop_clr_fd(), please
see my previous comment.


Thanks,
Ming
