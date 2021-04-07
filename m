Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02DA0C433B4
	for <linux-block@archiver.kernel.org>; Wed,  7 Apr 2021 14:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE92D6121E
	for <linux-block@archiver.kernel.org>; Wed,  7 Apr 2021 14:43:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbhDGOoF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 7 Apr 2021 10:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239804AbhDGOoF (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 7 Apr 2021 10:44:05 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB6DEC06175F;
        Wed,  7 Apr 2021 07:43:55 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id o11so4855628qvh.11;
        Wed, 07 Apr 2021 07:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/btP8VyRZ+PtRHEtHpKhEBU92313kMIz6dauarfwMLw=;
        b=FGKaXVsd1J+4FesmYRgTHlNBQriTvi5/iDTaOcVP69WtLq6kN3edC0JqVIFnlLsYCA
         L72IWqTaluslQzvNuGEb7aMe3IME2oWNyoARDuYUeRNb3welcW+9okrJ7XAOC+swKB4v
         dMVZ1vwObj+LmQxNnjAWnDXIx49wdxr69g2CrT35DofA+OxaPgZqdQ2NjBafPNOZq8za
         IdG91Gjcaj0dJ3qIsp2CXt9SOgAWykDlCyJwJmXog8jWDKPbMM+3PA94uAw0Dg5E5jSY
         6r5WeWHI1+TX5j0RBeDnWTHBfvVDq1edl1gDZywRllmKWg4xKZ28aCg+MrLm+65tRXbP
         nSqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/btP8VyRZ+PtRHEtHpKhEBU92313kMIz6dauarfwMLw=;
        b=M1c4qI5jNQEPRi0jVskt57Y/UbhfYFKQFvgX7lOJhO8u5EDSBVLsSDXWOEgOIi7RED
         krqA/ESt0tGhhlYqd4g/3QzfunOd5CDZ1cvZoSbavCxttr0A5SaNKF82AX+rUkGA6Xoc
         OUeBVHPNTGW42mjXqULzsjmv++8ytzPhUjxNTmHCb9+RNV1aDdyh4FhZ6g5ioEIfEwsK
         qcNhc2MgQVD1kaB6Bew0FJPXXOjNLu4QN5Z0Hp0BrX6P7vje2ea8mMC6TXmdySXywOLx
         B2bna2plJqlZkKEkQ6lcKt/yqVmbsDmLwhZObGRdYP2rOoxYABWRrXRizxQ2qIVR9OjX
         kKog==
X-Gm-Message-State: AOAM532jg7KiL7MJ4FOia+ZQhfJwqcH6Csro3ie6dGka+e33JZr/J8hN
        xyYVVysDUzoY6eO38FzFegiD1id93eg=
X-Google-Smtp-Source: ABdhPJx72scUaq5TlcVed08ZTISLmlNbmEHtmG617kEvTB0RSvFRyEXWpI7TqiBxKteAikcYxNjhiQ==
X-Received: by 2002:a0c:9e5e:: with SMTP id z30mr3809678qve.61.1617806634967;
        Wed, 07 Apr 2021 07:43:54 -0700 (PDT)
Received: from dschatzberg-fedora-PC0Y6AEN.dhcp.thefacebook.com ([2620:10d:c091:480::1:781f])
        by smtp.gmail.com with ESMTPSA id 75sm18097680qkj.134.2021.04.07.07.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 07:43:54 -0700 (PDT)
Date:   Wed, 7 Apr 2021 10:43:52 -0400
From:   Dan Schatzberg <schatzberg.dan@gmail.com>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/3] loop: Use worker per cgroup instead of kworker
Message-ID: <YG3FKCkcwk7eGdpc@dschatzberg-fedora-PC0Y6AEN.dhcp.thefacebook.com>
References: <20210402191638.3249835-1-schatzberg.dan@gmail.com>
 <20210403020902.1384-1-hdanton@sina.com>
 <20210407065300.1478-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210407065300.1478-1-hdanton@sina.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Apr 07, 2021 at 02:53:00PM +0800, Hillf Danton wrote:
> On Tue, 6 Apr 2021 Dan Schatzberg wrote:
> >On Sat, Apr 03, 2021 at 10:09:02AM +0800, Hillf Danton wrote:
> >> On Fri,  2 Apr 2021 12:16:32 Dan Schatzberg wrote:
> >> > +queue_work:
> >> > +	if (worker) {
> >> > +		/*
> >> > +		 * We need to remove from the idle list here while
> >> > +		 * holding the lock so that the idle timer doesn't
> >> > +		 * free the worker
> >> > +		 */
> >> > +		if (!list_empty(&worker->idle_list))
> >> > +			list_del_init(&worker->idle_list);
> >> 
> >> Nit, only queue work if the worker is inactive - otherwise it is taking
> >> care of the cmd_list.
> >
> >By worker is inactive, you mean worker is on the idle_list? Yes, I
> >think you're right that queue_work() is unnecessary in that case since
> >each worker checks empty cmd_list then adds itself to idle_list under
> >the lock.

A couple other corner cases - When worker is just allocated, it needs
a queue_work() and rootcg always needs a queue_work() since it never
sits on the idle_list. It does add to the logic a bit rather than just
unconditionally invoking queue_work()

> >
> >> 
> >> > +		work = &worker->work;
> >> > +		cmd_list = &worker->cmd_list;
> >> > +	} else {
> >> > +		work = &lo->rootcg_work;
> >> > +		cmd_list = &lo->rootcg_cmd_list;
> >> > +	}
> >> > +	list_add_tail(&cmd->list_entry, cmd_list);
> >> > +	queue_work(lo->workqueue, work);
> >> > +	spin_unlock_irq(&lo->lo_work_lock);
> >> >  }
> >> [...]
> >> > +	/*
> >> > +	 * We only add to the idle list if there are no pending cmds
> >> > +	 * *and* the worker will not run again which ensures that it
> >> > +	 * is safe to free any worker on the idle list
> >> > +	 */
> >> > +	if (worker && !work_pending(&worker->work)) {
> >> 
> >> The empty cmd_list is a good enough reason for worker to become idle.
> >
> >This is only true with the above change to avoid a gratuitous
> >queue_work(), right?
> 
> It is always true because of the empty cmd_list - the idle_list is the only
> place for the worker to go at this point.
> 
> >Otherwise we run the risk of freeing a worker
> >concurrently with loop_process_work() being invoked.
> 
> My suggestion is a minor optimization at most without any change to removing
> worker off the idle_list on queuing work - that cuts the risk for you.

If I just change this line from

if (worker && !work_pending(&worker->work)) {

to

if (worker) {

then the following sequence of events is possible:

1) loop_queue_work runs, adds a command to the worker list
2) loop_process_work runs, processes a single command and then drops
the lock and reschedules
3) loop_queue_work runs again, acquires the lock, adds to the list and
invokes queue_work() again
4) loop_process_work resumes, acquires lock, processes work, notices
list is empty and adds itself to the idle_list
5) idle timer fires and frees the worker
6) loop_process_work runs again (because of the queue_work in 3) and
accesses freed memory

The !work_pending... check prevents 4) from adding itself to the
idle_list so this is not possible. I believe we can only make this
change if we also make the other change you suggested to avoid
gratuitous queue_work()
