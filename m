Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BF32874F8
	for <linux-block@vger.kernel.org>; Mon, 16 Feb 2026 02:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771209907; cv=none; b=Vkc1ZHxK7nN7AdMF2ZiHnWMLkq0ZmarrDt8HD4dyFZ+FWdRP2Lk4qXxzSBwirq3XKjST1csDJjjDR2ubrJlKF1HWhIi8FX4isC92MCmIbuzL77Cn2mOhbtTYVkqrfYPFRZXfeNkbZhCBJTX7ZxjM0xIPI/vz2CflTIruhXao9IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771209907; c=relaxed/simple;
	bh=uSQwrjPEVqVI44kPtq1Q0l8j2Y8UjnFgzQZfTX0W9u0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hqWCGvLHHDk0Wyh9KxkfWlioriDcLy8RpvMPQgVdgxVB4ekxRYlThSKWKgKut4E4GoS4pLVz9RPjim6Nay1z70o7oW2BzJzx5dHSRK2QT3lwjeLBqzWO5bdbRg58bX4COVmqNMUHKaRBamWHXp1WVteFRYkZ2DmsLdPoBzwlQM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=I+/3xifv; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="I+/3xifv"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-82361bcbd8fso1288886b3a.0
        for <linux-block@vger.kernel.org>; Sun, 15 Feb 2026 18:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1771209905; x=1771814705; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zUvf4dGMm0pmQTZtNbQzHUpZlrhB3ofhzPPO/AA2CBE=;
        b=I+/3xifv2kqNB94YmdnsVN00dKHo6Oq/y6DDYIRQrrW4vTrtdy+okKhHYvBjXzwNv5
         8RdTpmtojqxsPw9+7VhXhCXlOO9Dmi7+hASbE9Mm2KcCPD/9GuKVfT0eGO/j0PoQpZxn
         5U3yuoToQXZ+8hJwY+VZyKA7i7oVrArJKa3HrkFVokkWoVqpmuqPnCfCbkc+kfpmIysG
         vP4EQ4TPoHkB/9+C2Rv9ZgrIUB3yEmNPl5bMbW3Vdb8Ff6fgUmjljZVeRCh/HA2z0/xk
         Ve464CNNfTUhI5m1nV7phHkdHmAn5poP43SwIc+XbXyWstEkeY08Q7zmUVnHDnkxNLst
         u3FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771209905; x=1771814705;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zUvf4dGMm0pmQTZtNbQzHUpZlrhB3ofhzPPO/AA2CBE=;
        b=jmUqlhoDlUhItVYaXsSUZ5WvlA5YfPw63XfRPeceK7iQZnAhYLt+QWRTJyFl7dqHV9
         CT1/WOV+omjMSlICG1S29X6SghVnX5sy11aLnwbuwc4HIOSOfgpVASHR2lw2Yo2hAeMK
         QtE6M6nmWhqRjtQ4HfsJjG15+rqSaFZQTw5HHEbv6MPFHSdJP1Yp5w4nNGnkb+2/N9O6
         D8As7PmaQQsJ8PUZOfdED8w1kwURCvRVAIyPGJuQHs8uGdhAo42EwINBuD8Ty3G/xyz/
         2/BBlbIeh9KyFqgj0v1WRHuzynrplh+rW0tGOj3+QP3ZcrsVvCw1wljH6r26c+PPySzS
         xD+g==
X-Forwarded-Encrypted: i=1; AJvYcCWSA0AZiLlAoHY0H2epVXvCZv4eSUyRquWqsERKDRJK3xugWEXwC3L2eJ0wkspY6EiJ8yC/PYlVsQa3jA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwsmQ36kuAlHXQmIIrcRAvt75EH3tYq0Q8l037KlbBJQQEmtCbJ
	+zDVlP6Hp8NL59/UAzuURI8X9uW7AnxtL2XyhFFmd2es5aSxrYOOUiKJ9XU3amykc7k=
X-Gm-Gg: AZuq6aJvZUX/MUKBYfOUsgzPJ/Vpml2JlNqvvnYWqgBwpMJ6ThnwrxOsndWF2zRFpnv
	9FYbFTetXez3TmAzhgp7H1jiIqrADCaHJo+da+1/08Qxr7Te6aHA1u3PlpmkyeZKWmPLPBsDEcR
	BrC9W4Q/ZAQFZBCv22PjPQdEReCFbEAaxicVjWaQsBr8yMQz6tTaOMkKxdkXxyOpaCLYdScvGUC
	Anct8i3tUbXqiKK5Mu0QB13WgxkGVqoIwwUStkxq46cSn/stWHYsoxi9QyAnAPnvXngMYK6RC9R
	jTtQiUbdD70f9ujayDvbcCMl/eL4ATwAZl+eV7zN7ohaFZTvSvRd6r7iH8pH0rL0PVlim6a68A/
	k/e0NGfXMZgEio+vEXvPK6pWYgHve3rH6xYylMoJbT17F30gPt3ioTuqkHxv85XR+WgCT8N2WwV
	xvNBCJnY2WJApymGvADqKdb0uNFgltI1TAfyvgBg==
X-Received: by 2002:a05:6a20:d524:b0:38e:87b6:a00a with SMTP id adf61e73a8af0-39483a1c6d9mr5479729637.55.1771209904925;
        Sun, 15 Feb 2026 18:45:04 -0800 (PST)
Received: from medusa.lab.kspace.sh ([2601:640:8202:6fb0::68dd])
        by smtp.googlemail.com with UTF8SMTPSA id 41be03b00d2f7-c6e52fd0ecasm5883140a12.7.2026.02.15.18.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Feb 2026 18:45:04 -0800 (PST)
Date: Sun, 15 Feb 2026 18:45:02 -0800
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Jens Axboe <axboe@kernel.dk>, Omar Sandoval <osandov@fb.com>,
	Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>,
	Yu Kuai <yukuai@fnnas.com>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blk-mq-debugfs: Fix warning about possible deadlock
Message-ID: <20260216024502.GG2392949-mkhalfella@purestorage.com>
References: <20260213224504.3990506-1-mkhalfella@purestorage.com>
 <defde5ab-eb0b-4f1d-b930-91732367a311@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <defde5ab-eb0b-4f1d-b930-91732367a311@linux.ibm.com>

On Sun 2026-02-15 19:06:21 +0530, Nilay Shroff wrote:
> 
> 
> On 2/14/26 4:15 AM, Mohamed Khalfella wrote:
> > Commit 65d466b62984 ("blk-mq-debugfs: warn about possible deadlock")
> > added WARN_ONCE_ON() to debugfs_create_files() to prevent potential
> > deadlock if the queue is frozen. We hit this warning with the stacktrace
> > below
> > 
> > WARNING: block/blk-mq-debugfs.c:620 at debugfs_create_files+0x9c/0x1d0
> > Workqueue: nvme-wq nvme_tcp_reconnect_ctrl_work [nvme_tcp]
> > RIP: 0010:debugfs_create_files+0x9c/0x1d0
> > Call Trace:
> >  <TASK>
> >  blk_mq_debugfs_register_hctx+0x186/0x320
> >  blk_mq_debugfs_register_hctxs+0x80/0xa0
> >  blk_mq_update_nr_hw_queues+0xc8f/0xd50
> >  nvme_tcp_setup_ctrl+0xcfa/0xda0 [nvme_tcp]
> >  nvme_tcp_reconnect_ctrl_work+0x51/0x180 [nvme_tcp]
> >  process_scheduled_works+0x840/0xd80
> >  worker_thread+0x36d/0x4a0
> >  kthread+0x366/0x380
> >  ret_from_fork+0x7b/0x670
> >  ret_from_fork_asm+0x1a/0x30
> >  </TASK>
> > 
> > Here __blk_mq_update_nr_hw_queues() did set PF_MEMALLOC_NOIO flag before
> > calling blk_mq_debugfs_register_hctxs() and this should guarantee the
> > described deadlock will not happen. Warn only if the queue is frozen and
> > NOIO flag is not set.
> > 
> > Fixes: 65d466b62984 ("blk-mq-debugfs: warn about possible deadlock")
> > Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> > ---
> >  block/blk-mq-debugfs.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
> > index faeaa1fc86a7..ec6670dc0a3d 100644
> > --- a/block/blk-mq-debugfs.c
> > +++ b/block/blk-mq-debugfs.c
> > @@ -612,12 +612,14 @@ static void debugfs_create_files(struct request_queue *q, struct dentry *parent,
> >  				 void *data,
> >  				 const struct blk_mq_debugfs_attr *attr)
> >  {
> > +	unsigned int pflags = READ_ONCE(current->flags);
> > +
> >  	lockdep_assert_held(&q->debugfs_mutex);
> >  	/*
> >  	 * Creating new debugfs entries with queue freezed has the risk of
> >  	 * deadlock.
> >  	 */
> > -	WARN_ON_ONCE(q->mq_freeze_depth != 0);
> > +	WARN_ON_ONCE((q->mq_freeze_depth != 0) && !(pflags & PF_MEMALLOC_NOIO));
> >  	/*
> >  	 * debugfs_mutex should not be nested under other locks that can be
> >  	 * grabbed while queue is frozen.
> > 
> > base-commit: cd7a5651db263b5384aef1950898e5e889425134
> 
> This issue is already being addressed here:
> https://lore.kernel.org/all/20260214054350.2322436-1-yukuai@fnnas.com/

Got it. Thank you.
