Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CA21993B6
	for <linux-block@vger.kernel.org>; Thu, 27 Jun 2024 17:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719508189; cv=none; b=hpIDEw3fqqpASAqf0dZF8vEOI6tzIPN89tKRmdiBDsw3jpPLG9exUKgD38zAULkgD2Nhw2PSRZnWlMEXaz3wnPyvZmqi6JU4lEsg5KoE+zgYx59u71M4GFWXEaeJohRv/EzNBFxf4bYZdWUTyfYKuJisrWhQzTzVGLZMD4wQMvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719508189; c=relaxed/simple;
	bh=UasIsFgC/Np7owc61PPznWhFbrGni4PAljcsDfeiJ3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dEwJzxoPJNE8MlpnEaK51ypBQN/5CwNppM8tlGvignoriG0VQtAPu5y8j09q2oFcn48scPtGRKF8Y53Ayl8oEySbbQsN14aYna8TRCqUHU7WSRs152OrJvVKR4JmQmTgjKUkmexzKg9URrGkOZyMAZCxBqlbKB6xFL3AQaIwUjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=HR49OlVk; arc=none smtp.client-ip=209.85.214.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="HR49OlVk"
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-1fa9f540f45so12867745ad.1
        for <linux-block@vger.kernel.org>; Thu, 27 Jun 2024 10:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1719508187; x=1720112987; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5Ey7PDxlbBydmaDDR4O+E1QsS0ExfjQTrEnzypmXxfQ=;
        b=HR49OlVkKy0OI0OGBa6uQ8CWSoy9pnL79LPTWyGo+C8Cj3F92MK7HMoe+E/oa3SBil
         2yTW2yCROS3zJzZhBxI2ggt/LQEGZPYWHLSNx0LpcN/xaQupv6mxJacaa1Zgts22j3rX
         B1W80zqUnjbaKp4i4cypLN5QmT1oNqOfj+tuJ+WeIeMBVTqxLWx2zFAD5LD4thRVIFv0
         F0bcQJflIbRGWsmWodVRJt3i71LbysDNGxg0LUfuDd+71ZZP6qIDihMNYzGirTQmM24G
         OwPEOQodSeMjw5btsxU9S0QdATlEeOLuVZY6FUX8gW53rNurjY2REewPhFTXj0f1BDN3
         OpHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719508187; x=1720112987;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Ey7PDxlbBydmaDDR4O+E1QsS0ExfjQTrEnzypmXxfQ=;
        b=FdKQmy9QKvKoRsM072tIBHzp6iYMYNPgwjAPUGduwfw+s6kbQkpS/5ZKTE0FGfOUO4
         gW/lSWq1xPa8LjXEV7EQKZ0G2JLZbCMN+8He5xboCIL9d8fbgZ2RG9eQPvrGXA6XHs6P
         hr49rYMH6TIc5SqbZiZE0E9Fox4a8YnvRtSQIr/+9BHR43wBZoCto5Sx0ZGJAEaJbybF
         nSqm3bpaExCWsq7huK4Adj1s62VYwlxkuy3GkcKcQ+CChVjZ8bcUwFNzx+LcN5lKZ+gL
         ++lIhx0wv0gVta32+Lon9OI6SsSqrPitd9820l00GIV1m6lOmtfSOEWtO/JSV2cHzcLh
         fUQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFgPQnAPRcx/mWGDmGEyD2MTWqw7YoaIXm4mmh2s7uob4kpg8HNcI2if2Ylk8SPkIuQHj0XgutUaLmwxuTcf75zQdnu45HCRyrMoU=
X-Gm-Message-State: AOJu0YxdksSv+soH2CLJksStrcahvkzm5ZcQl8HU58wQWVabOuW3YFkG
	AvOBiiCeNZwRiDhSnh4uiHGHsQm9oTvW4SewJx48HE5B8Q7vj5cHB6BG2XH+f7Wp7AyBib+S0Od
	P/m8TFqHBamm2s3ipPxw5e27b2pvhoxLK
X-Google-Smtp-Source: AGHT+IGoXBqC4LP5PEevJmvuW0GeUxY+m7FHBcQAD6IX8+DKfHeyU8LA/PnVIQJJHUD607O9cTl9QnWkx3HA
X-Received: by 2002:a17:902:da86:b0:1f9:d817:1fb0 with SMTP id d9443c01a7336-1fa158d0809mr149482135ad.14.1719508186774;
        Thu, 27 Jun 2024 10:09:46 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-1faac9a5f08sm594455ad.125.2024.06.27.10.09.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 10:09:46 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 4EEC63404A4;
	Thu, 27 Jun 2024 11:09:45 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 39045E40301; Thu, 27 Jun 2024 11:09:15 -0600 (MDT)
Date: Thu, 27 Jun 2024 11:09:15 -0600
From: Uday Shankar <ushankar@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 2/4] ublk: refactor recovery configuration flag helpers
Message-ID: <Zn2cuwpM+/dK/682@dev-ushankar.dev.purestorage.com>
References: <20240617194451.435445-1-ushankar@purestorage.com>
 <20240617194451.435445-3-ushankar@purestorage.com>
 <ZnDs5zLc5oA1jPVA@fedora>
 <ZnxOYyWV/E54qOAM@dev-ushankar.dev.purestorage.com>
 <Zny9vr/2iHIkc2bC@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zny9vr/2iHIkc2bC@fedora>

When I say "behavior A + 2," I mean behavior A and behavior 2 at the
same time on the same ublk device. I still think this is not supported
with current ublk_drv, see below.

> > the ublk server can "handle" the I/O error because during this time,
> > there is no ublk server and all decisions on how to handle I/O are made
> > by ublk_drv directly (based on configuration flags specified when the
> > device was created).
> > 
> > If the ublk server created the device with UBLK_F_USER_RECOVERY, then
> > when the ublk server has crashed (and not restarted yet), I/Os issued by
> > the application will queue/hang until the ublk server comes back and
> > recovers the device, because the underlying request_queue is left in a
> > quiesced state. So in this case, behavior A is not possible.
> 
> When ublk server is crashed, ublk_abort_requests() will be called to fail
> queued inflight requests. Meantime ubq->canceling is set to requeue
> new request instead of forwarding it to ublk server.
> 
> So behavior A should be supported easily by failing request in
> ublk_queue_rq() if ubq->canceling is set.

This argument only works for devices created without
UBLK_F_USER_RECOVERY. If UBLK_F_USER_RECOVERY is set, then the
request_queue for the device is left in a quiesced state and so I/Os
will not even get to ublk_queue_rq. See the following as proof (using a
build of ublksrv master):

# ./ublk add -t loop -f file -r 1
dev id 0: nr_hw_queues 1 queue_depth 128 block size 4096 dev_capacity 2097152
        max rq size 524288 daemon pid 244608 flags 0x4a state LIVE
        ublkc: 240:0 ublkb: 259:0 owner: 0:0
        queue 0: tid 244610 affinity(0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 )
        target {"backing_file":"file","dev_size":1073741824,"direct_io":1,"name":"loop","type":1}
# kill -9 244608
# dd if=/dev/urandom of=/dev/ublkb0 count=1 bs=4096 oflag=direct
(hung)

# ps aux | grep " D"
root      244626  0.0  0.0   5620  1880 pts/0    D+   16:57   0:00 dd if=/dev/urandom of=/dev/ublkb0 count=1 bs=4096 oflag=direct
root      244656  0.0  0.0   6408  2188 pts/1    S+   16:58   0:00 grep --color=auto  D
# cat /proc/244626/stack
[<0>] submit_bio_wait+0x63/0x90
[<0>] __blkdev_direct_IO_simple+0xd9/0x1e0
[<0>] blkdev_write_iter+0x1b4/0x230
[<0>] vfs_write+0x2ae/0x3d0
[<0>] ksys_write+0x4f/0xc0
[<0>] do_syscall_64+0x5d/0x160
[<0>] entry_SYSCALL_64_after_hwframe+0x4b/0x53
# cat /sys/kernel/debug/block/ublkb0/state
SAME_COMP|NONROT|IO_STAT|INIT_DONE|STATS|REGISTERED|QUIESCED|NOWAIT|SQ_SCHED

Therefore, in order to obtain behavior A with current ublk_drv, one must
not set UBLK_F_USER_RECOVERY.

> > 
> > If the ublk server created the device without UBLK_F_USER_RECOVERY, then
> > when the ublk server has crashed (and not restarted yet), I/Os issued by
> > the application will immediately error (since in this case, ublk will
> > call del_gendisk).  However, when the ublk server restarts, it cannot
> > recover the existing ublk device - the disk has been deleted and the
> > ublk device is in state UBLK_S_DEV_DEAD from which recovery is not
> > permitted. So in this case, behavior 2 is not possible.
> 
> UBLK_F_USER_RECOVERY is supposed for supporting to recover device, and
> if this flag isn't enabled, we don't support the feature simply, so
> looks behavior 2 isn't one valid case, is it?

Sure, so we're in agreement that recovery is impossible if
UBLK_F_USER_RECOVERY is not set.

So:
- To get behavior A, UBLK_F_USER_RECOVERY must be unset
- To get behavior 2, UBLK_F_USER_RECOVERY must be set

Hence, having behavior A and behavior 2, at the same time, on the same
device, would require UBLK_F_USER_RECOVERY to be both set and unset when
that device is created. Obviously that's impossible.

