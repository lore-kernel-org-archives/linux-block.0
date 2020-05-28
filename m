Return-Path: <SRS0=lWBJ=7K=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 209A8C433DF
	for <linux-block@archiver.kernel.org>; Thu, 28 May 2020 18:43:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0282920814
	for <linux-block@archiver.kernel.org>; Thu, 28 May 2020 18:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590691421;
	bh=QURQ9TkoyVu9gVUj037qoeOtc2y5A0bD+QYKgI/fX7g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DWDn2UUVClzivZrfvJkZ5m3uojqWi8Xt/bj21uWrIU3/WVqxKstAxWqL0Ku3/gy4k
	 gV0FRuxEDSLxDuHFnpOnvSaAn1+ukjSDqZrZiDh3TFH8rqIh+3Ywc/FbinSfRqSe3+
	 pNqMWoVoPIfb/HV9DcNfXisGIfDA/vaatC5gles8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391511AbgE1Snj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 May 2020 14:43:39 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36176 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391503AbgE1Sng (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 May 2020 14:43:36 -0400
Received: by mail-pg1-f193.google.com with SMTP id c75so13982pga.3
        for <linux-block@vger.kernel.org>; Thu, 28 May 2020 11:43:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NDP2LL2pmO8lWrON0Ovebrs3xjJL4dL+PhNbzuOUYlg=;
        b=rIZbjBWLpYuP77dR1caCVLzd69GXVdWrFodtnTUICknT9blaM1d/QbNphM7jRC6ts9
         3evIqEGqjG20FVHKfxjq5cSMIY1r2sMCfHBavr7uB6Ky/Y0xF9vGNV5AGYj/KnSttwTz
         iHS45gyjStST+IEbldnayAFdrjnJ9w9GseIvxUAxsvnbiEw6kN3kByfM7gF6H9SQZP4K
         Yo9DwqYILI1rxNYxPLMYa5kUMmFd9FwL5duvqm/+bMt7NA7XV9J7qGj1ms4Yl/GF8KUy
         bNzZ7VEeFzuCEhbscwVVEpLQ0R2s79Gi5F3Y4WWow6Zew6hVxATsd55xl7awsu0t8U6m
         iTuQ==
X-Gm-Message-State: AOAM5318z3LRTUR2u/v1e+uQxybdLl4spSdPAh4b2yjpj7YslKJCD5hS
        UdYCgkXx9qaTa5bX30VDxS4/xZiRit0=
X-Google-Smtp-Source: ABdhPJxyXPlaoymMT4QPiB8LW3ABQXPAiTxmMgzVJ0ye5rS5t3kA0XB2sfSwdNS6MM6APKzFwrS3tQ==
X-Received: by 2002:a62:e219:: with SMTP id a25mr4511359pfi.303.1590691415386;
        Thu, 28 May 2020 11:43:35 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id g27sm5456742pfr.51.2020.05.28.11.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 11:43:34 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 624B440605; Thu, 28 May 2020 18:43:33 +0000 (UTC)
Date:   Thu, 28 May 2020 18:43:33 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] blktrace: Avoid sparse warnings when assigning
 q->blk_trace
Message-ID: <20200528184333.GU11244@42.do-not-panic.com>
References: <20200528092910.11118-1-jack@suse.cz>
 <298af02a-3b58-932a-8769-72dcc52750ad@acm.org>
 <20200528183152.GH14550@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528183152.GH14550@quack2.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, May 28, 2020 at 08:31:52PM +0200, Jan Kara wrote:
> On Thu 28-05-20 07:44:38, Bart Van Assche wrote:
> > (+Luis)
> > 
> > On 2020-05-28 02:29, Jan Kara wrote:
> > > Mostly for historical reasons, q->blk_trace is assigned through xchg()
> > > and cmpxchg() atomic operations. Although this is correct, sparse
> > > complains about this because it violates rcu annotations. Furthermore
> > > there's no real need for atomic operations anymore since all changes to
> > > q->blk_trace happen under q->blk_trace_mutex. So let's just replace
> > > xchg() with rcu_replace_pointer() and cmpxchg() with explicit check and
> > > rcu_assign_pointer(). This makes the code more efficient and sparse
> > > happy.
> > > 
> > > Reported-by: kbuild test robot <lkp@intel.com>
> > > Signed-off-by: Jan Kara <jack@suse.cz>
> > 
> > How about adding a reference to commit c780e86dd48e ("blktrace: Protect
> > q->blk_trace with RCU") in the description of this patch?
> 
> Yes, that's probably a good idea.
> 
> > > @@ -1669,10 +1672,7 @@ static int blk_trace_setup_queue(struct request_queue *q,
> > >  
> > >  	blk_trace_setup_lba(bt, bdev);
> > >  
> > > -	ret = -EBUSY;
> > > -	if (cmpxchg(&q->blk_trace, NULL, bt))
> > > -		goto free_bt;
> > > -
> > > +	rcu_assign_pointer(q->blk_trace, bt);
> > >  	get_probe_ref();
> > >  	return 0;
> > 
> > This changes a conditional assignment of q->blk_trace into an
> > unconditional assignment. Shouldn't q->blk_trace only be assigned if
> > q->blk_trace == NULL?
> 
> Yes but both callers of blk_trace_setup_queue() actually check that
> q->blk_trace is NULL before calling blk_trace_setup_queue() and since we
> hold blk_trace_mutex all the time, the value of q->blk_trace cannot change.
> So the conditional assignment was just bogus.

If you run a blktrace against a different partition the check does have
an effect today. This is because the request_queue is shared between
partitions implicitly, even though they end up using a different struct
dentry. So the check is actually still needed, however my change adds
this check early as well so we don't do a memory allocation just to
throw it away.

Even then, the last final check is neede then.

Try these:

https://github.com/mcgrof/break-blktrace

  Luis
