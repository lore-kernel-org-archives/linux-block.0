Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74E33CF69C
	for <linux-block@vger.kernel.org>; Wed, 15 Apr 2026 08:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776241689; cv=none; b=j0fNnu7kbZEvvUnMizU3Rf3g8Eg+K4xiEI8WcCQa/TuhA/oLkrFN3jpQbGvw1u6pCINAp1j3Mb8bBj71+3zaKz7hXgH8sSYSDBTwNswKxCAuiCK6ymJ1O61iaw20/Gm2Qnx6ToBGl6uzmRivYcK2I9kz+S2ev6RvcT6KhOdwPMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776241689; c=relaxed/simple;
	bh=KZ31+iVuJ3hjGiVu2o5PRH1lxsvTWH4MQ3mopx32FA4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mkDY46MRrMhyq6w1AQSc2Z7cGlJ/HjkMSPfAzu0AmNa9+d31v2Wts7I1bvrqCxd2lcf+4UtsE61HX0VZJwTD7M3QqFXRceOKx3yNxOmWXAB8E7wEcWbBtRl9nNeZ3JYVzhTAmpERvlRwcxQ9RoQk16Bd4MfI2RqrXNNyuIHOQ7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VJFpsSxf; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VJFpsSxf"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43cfd1f9fd1so4157458f8f.3
        for <linux-block@vger.kernel.org>; Wed, 15 Apr 2026 01:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776241685; x=1776846485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0MPHkT8FkNcBtLY+Pw7K92GBLHfnQFXFDeYyX4HYwxI=;
        b=VJFpsSxfRwLVLraetQXuPhCXJ/73WCQRviZS2LD/YvMRtWLauyQGXyp7chBzw5o/BP
         j3sTArpIOvAeh/AG7QtkNU89seNBN/oyMgVxRbNK0veSNfOdF9dzaITomy1niersAG8K
         1IOL8tKldhEl5E83l6KS2DT3CfxGMQbb2WMKtS3HRoCCHqOItQ/vZmGNSvY9y2rng3m7
         5Sqf2yjGYtExqrYvXW10+YJ6z7eKwD90uUsfzkTXdl9rkysXQS5IQy1IC4eAo/cSGjee
         NIjeAFkelaFuwPD8LElF2e+4qpZINq3Rl44O0IyK44wj3FSAIqDlVoQcZx6GhiHIqPzE
         x/6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776241685; x=1776846485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0MPHkT8FkNcBtLY+Pw7K92GBLHfnQFXFDeYyX4HYwxI=;
        b=oisw8Xjjso9YkWVE1R0E8kv4sANdQ3fqpXDE1w1tBxuvu0SbqrFw8E24tZHuvU5zee
         0jx/QsxNRxgH6JeKlPFh5rZdJgcbxmVO2dQM4NjmU1mlMZhXImdlYqnDL68BS7FtFqzQ
         MllWvRvIspfFlT0hllXv64TICtkp6nVWyLPToVkeux4Z69z2bdnGBt4Gbm9BOb6VEbI1
         5IOuCNBsefLgmiQ47hcTX5TxDEg9IvaBhiwDGB0u2nBvLcQ985LlEtjXVhgRgAnms5GX
         HkFMb288KG5I7lsVbjANOCZwo5d0Txqlq7S3lMDjSHCricv3YpAcjO9o2Od4TxgkqjpP
         /bNw==
X-Forwarded-Encrypted: i=1; AFNElJ/5/QMmGnlUgCy4FeClN/KtTY5SFlbUxo5etbykR86GFdu3WM2bmYLCgiReJrqpOWHaMoO2z7kHdaXZkQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyYQCo4u0/Vgayz8kyHdQ5lLZf5Mk/ganNY1I5rjK8EWAhiLex0
	Nt5T5UySn7IqFGyj9Iw/JF3YPGyoZqquD3EJx3mKYGCgFNM2Wy+ZsfVp
X-Gm-Gg: AeBDiet8K8J/6LsuELpXxulbnQsJIFvGtI2G5yMPP6wjMKwS4KGHSa1NCNOUX27mfob
	esgpodu9krKCbU7KaqFPqsjMM2VipAH8EItBkMdknOygfADahPP+k9AXpZnyA8QvfrsNsGx26T0
	e4v7WOTeUF/9jW/6pTqHo13+ODoRRAtbT8+wuNk89a9gHZbiHShFtZbrOr8mK3Q7XH582Jrp/LA
	W1rE+CIsIcOiBU62jLKnvecFMyfMUTgM3ea08L2kk7PUUjGaH1hgpzTo5lz+9lq5pH6PJ+0LLUj
	Yce50fA8NSnXOjKWhsfm8A4clqcFpkyq+Oxgo6iKqzmrwpP32j2Z8+9zylGTt5DjZRojOBy5DTj
	6HLVqRu0VQY3J8pCjQraKZ3H8aFuZBq4Durzvs07Nh3aqXZqng25qgb0vPe0wrrZrhQzDQ/mhre
	M81LdoaeyOGdmVjIFNVw/gCSQGLeYqUThbaB2x9oLjLQ55E8MDHz6Si8aW3dNxcwAx
X-Received: by 2002:a05:6000:268a:b0:43d:7403:4b60 with SMTP id ffacd0b85a97d-43d74034c72mr20655235f8f.3.1776241684906;
        Wed, 15 Apr 2026 01:28:04 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead3564d8sm3573210f8f.10.2026.04.15.01.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 01:28:04 -0700 (PDT)
Date: Wed, 15 Apr 2026 09:28:02 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Dave Chinner <dgc@kernel.org>
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, Christoph Hellwig <hch@lst.de>,
 Tal Zussman <tz2294@columbia.edu>, Jens Axboe <axboe@kernel.dk>, "Matthew
 Wilcox (Oracle)" <willy@infradead.org>, Christian Brauner
 <brauner@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>, Carlos
 Maiolino <cem@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Jan Kara
 <jack@suse.cz>, Bart Van Assche <bvanassche@acm.org>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, Sandeep Dhavale <dhavale@google.com>
Subject: Re: [PATCH 8/8] RFC: use a TASK_FIFO kthread for read completion
 support
Message-ID: <20260415092802.5864c457@pumpkin>
In-Reply-To: <ad2RKNo2FGhpzJQp@dread>
References: <20260409160243.1008358-1-hch@lst.de>
	<20260409160243.1008358-9-hch@lst.de>
	<adl1iqhldFvJwSw-@dread>
	<7f0d072b-97a7-405f-bff5-d3819de2e3dd@linux.alibaba.com>
	<ad2RKNo2FGhpzJQp@dread>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 14 Apr 2026 10:58:16 +1000
Dave Chinner <dgc@kernel.org> wrote:

> On Sat, Apr 11, 2026 at 07:44:43AM +0800, Gao Xiang wrote:
> > 
> > 
> > On 2026/4/11 06:11, Dave Chinner wrote:  
> > > On Thu, Apr 09, 2026 at 06:02:21PM +0200, Christoph Hellwig wrote:  
> > > > Commit 3fffb589b9a6 ("erofs: add per-cpu threads for decompression as an
> > > > option") explains why workqueue aren't great for low-latency completion
> > > > handling.  Switch to a per-cpu kthread to handle it instead.  This code
> > > > is based on the erofs code in the above commit, but further simplified
> > > > by directly using a kthread instead of a kthread_work.
> > > > 
> > > > Signed-off-by: Christoph Hellwig <hch@lst.de>  
> > > 
> > > Can we please not go back to the (bad) old days of individual
> > > subsystems needing their own set of per-cpu kernel tasks just
> > > sitting around idle most of of the time?  The whole point of the
> > > workqueue infrastructure was to get rid of this widely repeated
> > > anti-pattern.
> > > 
> > > If there's a latency problem with workqueue scheduling, then we
> > > should be fixing that problem rather than working around it in every
> > > subsystem that thinkgs it has a workqueue scheduling latency
> > > issue...  
> > 
> > It has been "fixed" but never actually get fixed:
> > https://lore.kernel.org/r/CAB=BE-QaNBn1cVK6c7LM2cLpH_Ck_9SYw-YDYEnNrtwfoyu81Q@mail.gmail.com
> > 
> > and workqueues don't have any plan to introduce RT threads;  
> 
> They don't need to (or should) introduce RT threads. Per-cpu kernel
> threads already get priority over normal user tasks on scheduling
> decisions.  However, they do not pre-empt running kernel tasks of
> the same priority.
> 
> In general, kernel threads should not use RT scheduling at all - if
> the kernel uses RT prioprity tasks then that can interfere with user
> scheduled RT tasks. This is especially true in this case where a
> non-RT tasks issue the IO, and the IO completion is then scheduled
> with RT priority. IOWs, any unprivileged user can now impact the
> processing time available to, and the response latency of, other
> RT scheduled tasks the system is running.

But might not an IO for a use RT task be sat behind it in the
completion queue?
To avoid priority inversion you need to process the completions.
The non-RT task won't be rescheduled to issue a later request.
The only other way is to force that completion work be done in
the context of the thread that issued the request.

> 
> Tejun asked Sandeep if setting the workqueue thread priority to
> -19 through sysfs (i.e. making them higher priority than normal
> kernel threads) had the same effect on latency as using a dedicated
> per-cpu RT task thread. THere was no followup.
> 
> In theory, this should provide the same benefit, because what RT
> scheduling is doing is pre-empting any user and kernel task that was
> running when the interrupt was delivered to execute the completion
> task immediately.
> 
> Setting the workqueue to use kernel threads of a higher scheduler
> prioirty should do the same thing, without the need to use dedicated
> per-cpu RT threads.

We had a related issue with the network stack's use of softint and
threaded napi when trying to receive very high packet rate UDP traffic.
(IIRC something like 500000 200byte RTP audio packets every second.)
There is an absolute requirement to run the ethernet rx processing
in order to avoid dropping packets.
Now normally the code runs as 'softint' making it higher priority
that any user process, but under load it switches to using 'normal
priority' kernel threads which are basically low priority.
Similarly 'threaded napi' uses 'normal priority' threads.
The only we made it work was to manually change the threads to be
a low 'RT FIFO' priority so they got scheduled in preference to
all user processes.
A system may need some user RT threads with a lower priority than
these kernel threads and others with a higher priority.
So defaulting to a middling RT priority may be best.

	David

