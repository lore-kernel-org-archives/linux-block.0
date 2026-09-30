Received: from mail-oa2-f12.google.com (mail-oa2-f12.google.com [74.125.231.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC4B513551
	for <linux-block@vger.kernel.org>; Wed, 30 Sep 2026 16:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790786415; cv=none; b=S1WVjjJOtkZOruJKUr8ySF347p24QZqfO7MBqqHrKr+429KjwBB1Pa9kZuAL+uoPevEwOKUfqK8WZL9TIn2dZTOF2bSbl82j0DYq4yyQjVtdboP4yBn7KusFapnk+s/VTEtyp4KKgglMsxeODFVlzqL1VwvJFGmws8VJaRaIrBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790786415; c=relaxed/simple;
	bh=0+haRPFJVrIBg/KxwiST0BnLw4HTvHOw2SUsjkpxatI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VdTuKk4A4eTu7Br7rXpP5Jt/DdhbW9zbRybJjrbdFwSJsRmNRs5oqNUTtRtUF2nqU84nGO3nwlIxwaDstOXBcvzmqZQz8nnfh6+S38LJJ8P/7VtsJL1ScEAhPYA+ND7LYnJD6lvmCyXlgLBhe77K0AIZlQzXNxt9Defh5Qtl32Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kcs1rX9q; arc=none smtp.client-ip=74.125.231.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kcs1rX9q"
Received: by mail-oa2-f12.google.com with SMTP id 586e51a60fabf-466cc88a0d7so3697439fac.2
        for <linux-block@vger.kernel.org>; Wed, 30 Sep 2026 09:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790786412; x=1791391212; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XFw9xlTGc6nwfYyMIGcXU1qXmiqHTAyDTwnu+eltMIw=;
        b=Kcs1rX9qKBKCm+6gagzO8Lbu9K7Zy4G9PDbcK7BNsB9zcCOPlXZpgU6/Zwox8LSU/a
         BculvFb5O6BRfAdI++hc4Fep465OVJcm84XaIduMIGwpqx2DElkyymTVGrqPVOa9CUxR
         FQfZ0NixeTIBZhOVUk6D5pWc0iHbqYcIHDns9BJOvrsRkTdk0Z7sBkQeRmuvik5fD4Vn
         R8q9P6Bkv7nJ7eoyjptK5YwDYW9ghxndav8tWMDMiD6pv3JGjZB4jvqX+UtuF9QZVMnk
         Hl49fHGSiMe+We+fwXJQ/awSyB+tsjn68HY0L00QH8ZmcLOUCpQkQkM7x6nSgdm/QA9b
         LqBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790786412; x=1791391212;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XFw9xlTGc6nwfYyMIGcXU1qXmiqHTAyDTwnu+eltMIw=;
        b=KBzBvVHEvSP+VPSKgJH+vHoAkQjsbvK5XyGs8oNFtOAHLHXQ2f5A+nUXwnHCkCy2bb
         ONUJXkf8HMz4DG03uum5f5Hli/BuFcZis0nNGaCBmaT1Vbza8s8YJ9xK8boOCCwnRb0t
         uVOo0iX3/b2iXqjO3ap8Y4raX/a7dIcmnBx8G9tc/z7uktbywzk09fArTfR+6r+sJtr6
         oGuJvfhd29aWpuF2DHkZDrS2EgaDqm3oIefuYZHeItP8Dki9v74KA/VEqwEATCLq1wbj
         fvGFy2Lb5e2s6yp9+dwA+4SioBACkk36pF25NI6wvfkh2v2I6B5lOwDqixryFU3lZvOg
         N6bA==
X-Forwarded-Encrypted: i=1; AKwUvBw9/PGT+vm4O9rgiwLGUdWUHA5thvXS3zvjoLYaMX7VuszkJkrnDfPBm/T7xcQ4tY8JpKjSxzwyj6FuXw==@vger.kernel.org
X-Gm-Message-State: AFuF++mv2x7OFcdA2FhdVXr4qU496PSXCpi47Frz6BeF1gFwaajy3s7y
	ktE2S2pXgnmmW7SIPYDkpv8ueAmIOP+fZBM+WDePz5S8X1zSZOmyqlho4hlXUQ==
X-Gm-Gg: AYBFou1TL6HH6n4hsg11fLjk7+QFuo81081P/vl2UTi4AEC/H6EdkIAuH9IAzsEAniJ
	NvfbY3dnezRpN3weDHBDkRXBnJZyhhSnG1/Vzun5+fVF98ILviCowS9mvfw1ut6r5zxuKPhY4gn
	IUs3nedrM2l0QZSXFC2VYjj8HUTRf4KMLw+MXIZHvUYpsmF/UL+U9Qa7shiJjCQtsj3HvKYZKGC
	ItzfBORiRQ1HrO1jaKWrLOpHQA5drUcCcUpKsyQtGI3D1DlbIIyRxAP2wn3DOY1Mz7vnzkoy7N7
	uZQ8wLcUlUlXl5hlQwFjNf5gFpmUjRqw35XBsAIrjJoA5AXrtS6zgSRaxH5dSv+syJ+mHwCp4l1
	pfxGobPpAe89xhFevKGFHiYjv0px6EW4NCyHo2er1Rdi0lsYkjEojFkyKzutGXv8aZLC3Hd/wZS
	UBzjzqtxACQJ1pOXEgKLgKZlec0yiV3jLEvMCYCS90eSaJmXyf1FddrP3VmxdcsC/y5BR4VyYza
	Q9GdjrRUxy0g9RMIFxXuVdPsabUF4rrVABCPpvX0Ld/n4VEnSsr+pY4BhFbLm9sHlczd6AL8IHp
	9DE=
X-Received: by 2002:a05:6808:4488:b0:4c3:9892:96e1 with SMTP id 5614622812f47-4f1b84ca716mr1997644b6e.25.1790786412075;
        Wed, 30 Sep 2026 09:40:12 -0700 (PDT)
Received: from fedora-laptop ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4f1b43a602csm1272690b6e.6.2026.09.30.09.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 09:40:11 -0700 (PDT)
Date: Wed, 30 Sep 2026 11:40:04 -0500
From: Ming Lei <tom.leiming@gmail.com>
To: Josef Bacik <josef@toxicpanda.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	Caleb Sander Mateos <csander@purestorage.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH 0/9] ublk: fix dispatch to canceled io commands
Message-ID: <ar07ZKeb-j2ykXxg@fedora-laptop>
References: <20260928-b4-ublk-cancel-stop-v1-0-4a4360232a46@toxicpanda.com>
 <arvOwDHOgvpVW86j@fedora-laptop>
 <e15d4e3c39e8ed1860b762cfd8e43c92.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e15d4e3c39e8ed1860b762cfd8e43c92.josef@toxicpanda.com>

On Wed, Sep 30, 2026 at 02:17:31PM +0000, Josef Bacik wrote:
> On Tue, Sep 29, 2026 at 09:44:16AM -0500, Ming Lei wrote:
> > It looks two races: STOP_DEV vs. START_DEV, STOP_DEV vs. FETCH.
> >
> > Looks fast io path shouldn't be touched for fixing the races.
> >
> > >   2. A partial FETCH round whose task exits, once another task
> > >      completes the round.
> > >   3. During recovery, the task of a queue which is ready already
> > >      exiting before the last queue is ready.
> >
> > 2 and 3 could be solved in single simpler patch by making use of the
> > ub->canceling flag, and it is easier for backport.
> 
> Agreed, yours is much simpler, and keeping the flag set for the whole
> FETCH round is the right model. I ran it on top of for-next (d70609a2f68c)
> with KASAN and lockdep through my reproducers and the ublk selftests. The
> oopses for 2 and 3 are gone, and recover_01-04, batch_01-03, generic_17,
> stress_01/02/05 and 60 batch QUIESCE_DEV/recover cycles pass.
> 
> What's left for 2 and 3 is that the device still comes up. For 2,
> START_DEV returns 0 and the new disk fails every request. For 3,
> END_USER_RECOVERY returns 0, the device is LIVE, and every read on the
> queue whose task exited sits requeued forever, since the queue stays
> canceling and nothing kicks the requeue list. With ub->canceling
> covering the whole round that's a small check: return -ENODEV from
> START_DEV and END_USER_RECOVERY when ub->canceling is set, checked under
> cancel_mutex against publishing ub->ub_disk. The server can't fetch
> those commands again anyway. Patch 9 of my series did that on the old
> model, I'll redo it on top of yours.
> 
> For 1, your patch alone still oopses in ublk_queue_rq() from the
> partition scan when START_DEV follows STOP_DEV, same as before. I'll
> respin my series as just that, on top of your patch and without touching
> the commit path: STOP_DEV marks the queues canceling and takes the
> fetched commands under ub->mutex, and FETCH marks its command cancelable
> before it publishes it, so a cancel from the control path never
> completes a command io_uring doesn't have on its cancelable list yet.
> 
> For your patch:
> 
> Tested-by: Josef Bacik <josef@toxicpanda.com>

Thanks for the test!

For STOP_DEV related races with STOP_DEV, START_DEV and FETCH, one simple
idea is to add internal device state of UB_STATE_STOPPING, which is set
in ublk_stop_dev() in case of any pending uring_cmd, and cleared in
ublk_reset_ch_dev() when the char dev is closed.

Then we can fail STOP_DEV, START_DEV and FETCH if UB_STATE_STOPPING is set.

I have written patches towards this direction, so far so good, pass all
selftests and survive in races of your reports, will post out for review
further.


Thanks,
Ming
