Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E561E1E12
	for <linux-block@vger.kernel.org>; Fri, 22 May 2026 09:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779442448; cv=none; b=VB8+iieot33/OgUBTD++lVsE3+kvdyQ7Mu+hZOH+chgwtxhDTOJET1x1hBzGtJSmURhMPT6qsmVn0HlhOsQv7XVCP4HzKngJmBShBJDEB+obon2PYGRa6amDjEV7av/WVEir8YWRniuZR2ouhuDP9CnX9VxF1qQRIynOg/It5Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779442448; c=relaxed/simple;
	bh=mjwyOvFVJ9CCXYqviSVFxUav5lqgy30H0LBV5R1RnLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cqetpFSxEsqsEo80qdLAA0jFIoYKTmjgRCT1RCOvtSPadkzXaCfPDEzqEHYlElt80mt6y9aEVTwqfrN7/aSLSkW4stzNwwnmzcIhASLstHN3q7d9fCIQ3U1TNhl1RSgmgLhQ0Z3s08ryUvUFNMSRpJot0M8CbSJr3HINSjhvoTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IjkBV7AI; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IjkBV7AI"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-516cc5471bdso20859791cf.2
        for <linux-block@vger.kernel.org>; Fri, 22 May 2026 02:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779442446; x=1780047246; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=n1+CvVYNRUCFAB4LXQOVgbmPYhKJKSrQIhlLwbK7SL4=;
        b=IjkBV7AIwUe+xp89EODRxXWl3/GN0OIo+LFiD+hWuulzUUSJ33zkXzHADMFYdeXxOW
         FBET43z+FM0wT50+YpYqZoeVLsiwGDJ6E/0/2aVWjtgw2+kpvKJ/3FXTCnNaR7D3Egk9
         OVbTSTy8b9w2DJaRJrK/OgNbmzbkJ7TWodGVxtutZlaOLtAiTC5JATZpWdJAzJ11VFK1
         ZO5P/2Izht6WpqbLQPEFLRKDRCqw8rwicSnSdVXwlqVCCIAF13ieFQUy6nm8xnmCBlrh
         4iBNC3XKvaL2mRxL9Ea5slDicN54lS5BJDW7w7L8Jqom6/eVD/RMnmEHwPq2dbMyYbBo
         uZMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779442446; x=1780047246;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n1+CvVYNRUCFAB4LXQOVgbmPYhKJKSrQIhlLwbK7SL4=;
        b=sJmJN3CGR+ex6BWLy9+oUWhAuNlfjyAbjfuPXxQaGJwJq3ro2RD0hrMm9arqc40amc
         5hBzNLku6srxqXmRMeT4OI2QaucLcSd+Uxp6Y4jO7+YCgVyJyYq41VTFEBcjsqajOW/r
         PW5fC/d+pIQ/z89nuoGdI+41DoaQLKFNmAg6lilYpmTvlfgXs7a5acPnoTYKd93mlChx
         RYkK6sv+90DHsmAsRgKaX+Qq/KfQBFy5pX3Esi7brfsmyHqeUloK3arrZR2WiAGt3dKg
         VLYfaqsRMwxAx/qj7+UIldnsphj2otOlXqW/z86iU3L2z8PehCiAr4/3PIaPgs8vJmeZ
         s3qA==
X-Forwarded-Encrypted: i=1; AFNElJ87aAkUaMA1aXEgAQ7eUAAFNq8heedtGe4avaBt0N9YieyoZBylRGl9bVJxEHhBz/tyrPfCgUC+cFceTQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw95DVgG3U84tR6GjYKQUz1VHj0CJYts2cuUtpw5cwfORXuhI5t
	Oe+OPNC4y4jPBTdEwMNLqU5+RX/R2xe8YN+9SN+dWFhTkDTffiKh780o
X-Gm-Gg: Acq92OFk9RlMcIfk/W/uOX9zhjOf1KJUnMFSRjBMHRyj6zrdwNf7jJBQNhziZnsuJs+
	K49o7VxAiEKM0QL9WgO4GCoTOC2gLifFEnhMUAXhpz5XtTmuMo1FtMXpBFJZj2NiAT+FbQOGoqX
	JeD17/O/IW5NYxuiJyNIqvIvBZY7euQz1BllRLXsEtl3tt28khIJ5an/gnolclroZ9QjYzbh/D7
	GSSWzG6xTJZThZi/tVZ4yQU3OOGtAAubZj+kaE5B5YQKyIZMQgWbn+hbMFJkfFqiStKFtDppqH0
	ZrBQHB9rL/7yJVx3NT2+Pzf9XzAp+QZamdBLqVuADc+QrfBfLYbLe8RUsY8PUqq/QWw6Z58RTpt
	WBwjkD/nmB6cDIGcn4+PguLjzpwQFwE3xKfcGyAVphwvBTt6U9LT1kgd/SG1csxUCkijMzVrgi5
	O16LNN9tVW7d63bfIdNwjvndgxC5jxrGdg019j5fj/FA9st3GOzyQMPJSU/1x7THypLLqvGKnJH
	vM2r4/xA+agBgJrCGHc
X-Received: by 2002:ac8:7d83:0:b0:516:dcfc:ebc3 with SMTP id d75a77b69052e-516dcfcefe3mr3946451cf.30.1779442446382;
        Fri, 22 May 2026 02:34:06 -0700 (PDT)
Received: from fedora ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516d8c91f26sm8978691cf.18.2026.05.22.02.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 02:34:05 -0700 (PDT)
Date: Fri, 22 May 2026 17:33:58 +0800
From: Ming Lei <tom.leiming@gmail.com>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	syzbot+cd8a9a308e879a4e2c28@syzkaller.appspotmail.com,
	syzbot+bc273027d5643e48e5b3@syzkaller.appspotmail.com,
	Hongling Zeng <zenghongling@kylinos.cn>,
	Bart Van Assche <bvanassche@acm.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] loop: add sync_blockdev() in __loop_clr_fd() to prevent
 UAF
Message-ID: <ahAjBvh8IfPCreRG@fedora>
References: <20260522025451.845068-1-tom.leiming@gmail.com>
 <e4deece5-d866-4a44-9097-eaa1e2727c0b@I-love.SAKURA.ne.jp>
 <ag_RZc908B64hTFG@fedora>
 <7ef76131-d077-4cfc-80ab-69720a214a5c@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7ef76131-d077-4cfc-80ab-69720a214a5c@I-love.SAKURA.ne.jp>

On Fri, May 22, 2026 at 03:54:54PM +0900, Tetsuo Handa wrote:
> On 2026/05/22 12:45, Ming Lei wrote:
> > On Fri, May 22, 2026 at 12:28:34PM +0900, Tetsuo Handa wrote:
> >> On 2026/05/22 11:54, Ming Lei wrote:
> >>> Fix this by adding sync_blockdev() in __loop_clr_fd() to flush all
> >>> pending writeback I/O before clearing lo->lo_backing_file. Since the
> >>> loop disk is already closed at this point, no new I/O can be submitted
> >>> — only writeback remains.
> >>
> >> Why can you assume that synchronize_rcu() + drain_workqueue(lo->workqueue)
> >> is unnecessary? Since we don't know exact commit which is causing this
> >> problem, we don't know what has changed.
> > 
> > When sync_blockdev() returns, there can't be any inflight IO:
> > 
> > - no one can open this loop disk
> > - no dirty page cache any more
> > 
> > So why do you want to add rcu/drain_workqueue?
> 
> The fact that __loop_clr_fd() is called before lo_rw_aio() completes suggests that
> some works queued before __loop_clr_fd() is called have not been completed.
> 
> I don't know what sync_blockdev() guarantees, but even if sync_blockdev() can guarantee
> both "loop_queue_rq() is no longer running" and "all pending AIO requests issued by
> lo_rw_aio() have been completed", I think that sync_blockdev() cannot determine whether
> lo->lo_device has pending work or not.

Please do take a look at the commit log of this one and commit 1fe0b1acb14d

> 
> Therefore, I guess that at least drain_workqueue() is needed before sync_blockdev().
> If sync_blockdev() cannot guarantee "loop_queue_rq() is no longer running",
> I guess that both synchronize_rcu() + drain_workqueue() are needed before sync_blockdev().

Not at all.

What matters is that resources cleared in __loop_clr_fd() are not used any
more, and the resource is only accessed when handling io command from both
submission and completion path.

Again:

When the loop disk is closed, no foreground IO is possible, meantime
no one can open it because of ->open_mutex. So the only remained IO are
writeback, sync_blockdev() writes out all dirty pages and waits until
all are done, then there can't be any new IO, and it is safe to clear
these resources.

work function may still be run, but command list includes nothing, so
resources to be cleared won't be touched.

> 
> (And I don't know whether sync_blockdev() is appropriate because we don't know what change
> made this problem visible. We didn't hit this problem until Linux 7.0.)
> 
> > 
> > Fixes: 1fe0b1acb14d ("loop: only freeze the queue in __loop_clr_fd when needed")
> 
> The Fixes: for these reports should be the commit which made this problem visible.
> Or, this patch will be needlessly backported to stable kernels.

Will add it in V2.


Thanks,
Ming
