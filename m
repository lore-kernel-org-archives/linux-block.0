Return-Path: <SRS0=4xS2=OV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DEB1C67839
	for <linux-block@archiver.kernel.org>; Wed, 12 Dec 2018 04:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D89F12086D
	for <linux-block@archiver.kernel.org>; Wed, 12 Dec 2018 04:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544587614;
	bh=bTojYj96orVx/F0wYSWApX51heQTe1cw0xy0l+U3mto=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xovTKEyAHtpuZy/c6Bna+IgV5nAK+A5gsAd5C7rbEUWx+vqbksGxT+CQCQuAjSWe+
	 ovuXc7Ap646EoZqIFDbT+qxMOLc4S/HTWcM+ozF8V0YSMRUxwJbl837P1gzbZoPjXd
	 rzF2JVEQCzC3OSrHbQ4wdU44e0SUqEqCNCEZAo9E=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D89F12086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbeLLEGu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Dec 2018 23:06:50 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:35482 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbeLLEGt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Dec 2018 23:06:49 -0500
Received: by mail-qk1-f193.google.com with SMTP id w204so10020862qka.2;
        Tue, 11 Dec 2018 20:06:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fFhZ3CklTcCwufhpP2IZWbh+thBFUwMG/ZFw2lmBUJE=;
        b=ahvfWM6VsgQ9tViyKzEiKcdEZR5wGyzmUODhmbaeUOwz/CczVXfkl5EQ6gM8OQ4/Wa
         0ckIaI/+YpJCFPb68bOLDWgm9pYpcz3fhSY2/Vssz9u5mvAPWfh/wkOocU1yT81TVrrh
         ccNY4Z00OTdxvD8AO8i+V9az2+e9Kl6yuz1XqVOsdIsAeMp0BJJRY852pkyzJ/+09FkI
         +Gh192zgpBG68ybbYonmnf274Rn9uBtT5XfQrvpZlRvpNKLZeY/U/Remr4xleI1AG10B
         2wS5TQHmKgoLUaTLnLU3AogV6eyaq9TexmAofpKR8i04D+HWx8iabuqE4FirI/O7C126
         V2IQ==
X-Gm-Message-State: AA+aEWb4E1QY1Q1oNG+YCv0N5jNtmELe5dQacVLTASvC5kAQ0tMFAqFy
        kMa4ORqyp2SQP2Ub5G/sQ6aCz4Oy3rw=
X-Google-Smtp-Source: AFSGD/XspDqGS5hNAu270Obft2CTo/nITtYwKGsb234gbarnDfKn2RPVS1YZiqvhXwVvDwpWUSYR3g==
X-Received: by 2002:a37:8781:: with SMTP id j123mr16575830qkd.68.1544587608303;
        Tue, 11 Dec 2018 20:06:48 -0800 (PST)
Received: from dennisz-mbp.dhcp.thefacebook.com ([2620:10d:c091:180::1:cdcb])
        by smtp.gmail.com with ESMTPSA id b20sm11690712qkb.17.2018.12.11.20.06.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 20:06:47 -0800 (PST)
Date:   Tue, 11 Dec 2018 23:06:43 -0500
From:   Dennis Zhou <dennis@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH] blkcg: handle dying request_queue when associating a blkg
Message-ID: <20181212040643.GA73727@dennisz-mbp.dhcp.thefacebook.com>
References: <20181211230308.66276-1-dennis@kernel.org>
 <1544570173.185366.397.camel@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544570173.185366.397.camel@acm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Bart,

On Tue, Dec 11, 2018 at 03:16:13PM -0800, Bart Van Assche wrote:
> On Tue, 2018-12-11 at 18:03 -0500, Dennis Zhou wrote:
> > diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> > index 6bd0619a7d6e..c30661ddc873 100644
> > --- a/block/blk-cgroup.c
> > +++ b/block/blk-cgroup.c
> > @@ -202,6 +202,12 @@ static struct blkcg_gq *blkg_create(struct blkcg *blkcg,
> >  	WARN_ON_ONCE(!rcu_read_lock_held());
> >  	lockdep_assert_held(&q->queue_lock);
> >  
> > +	/* request_queue is dying, do not create/recreate a blkg */
> > +	if (blk_queue_dying(q)) {
> > +		ret = -ENODEV;
> > +		goto err_free_blkg;
> > +	}
> > +
> >  	/* blkg holds a reference to blkcg */
> >  	if (!css_tryget_online(&blkcg->css)) {
> >  		ret = -ENODEV;
> 
> What prevents that the queue state changes after blk_queue_dying() has returned
> and before blkg_create() returns? Are you sure you don't need to protect this
> code with a blk_queue_enter() / blk_queue_exit() pair?
> 

Hmmm. So I think the idea is that we rely on normal shutdown as I don't
think there is anything wrong with creating a blkg on a dying
request_queue. When we are doing association, the request_queue should
be pinned by the open call. What we are racing against is when the
request_queue is shutting down, it goes around and destroys the blkgs.
For clarity, QUEUE_FLAG_DYING is set in blk_cleanup_queue() before
calling blk_exit_queue() which eventually calls blkcg_exit_queue().

The use of blk_queue_dying() is to determine whether blkg shutdown has
already started as if we create one after it has started, we may
incorrectly orphan a blkg and leak it. Both blkg creation and
destruction require holding the queue_lock, so if the QUEUE_FLAG_DYING
flag is set after we've checked it, it means blkg destruction hasn't
started because it has to wait on the queue_lock. If QUEUE_FLAG_DYING is
set, then we have no guarantee of knowing what phase blkg destruction is
in leading to a potential leak.

Thanks,
Dennis
