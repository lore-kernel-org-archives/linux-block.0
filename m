Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B475C433FE
	for <linux-block@archiver.kernel.org>; Tue, 28 Dec 2021 21:30:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237358AbhL1VaP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Dec 2021 16:30:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:32725 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236380AbhL1VaP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Dec 2021 16:30:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640727011;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=A/YdqQbiYan/8puYBvi5XsqHp47yRlJpMdsMFPVf0MI=;
        b=Q+NK/Z9G+5/MEUvHMUidRXZ1iLqUp8yCyyW5228ng0UhrVZ3aNwxyFyhDAEMSAs/8ilE42
        tHt97ld62YdcRDQ4Nm42L85DC+Dc0w4VePFinqR3tsQ0J4QL2+eCQOfT0Q6gce7zkciUe0
        jfJsR5gmgB5vtossIuB3QauqsDKiJas=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-215-3A3vF876NFqmBuMcQvEsKA-1; Tue, 28 Dec 2021 16:30:10 -0500
X-MC-Unique: 3A3vF876NFqmBuMcQvEsKA-1
Received: by mail-qv1-f69.google.com with SMTP id 13-20020a0562140d0d00b00411590233e8so15473470qvh.15
        for <linux-block@vger.kernel.org>; Tue, 28 Dec 2021 13:30:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=A/YdqQbiYan/8puYBvi5XsqHp47yRlJpMdsMFPVf0MI=;
        b=niKoJq9CwxGlJKqmAxF9pkXK7+FwbfGSRAWcdMy6HJOAO+5wDnSvAehpGsEMiUqcRt
         p3j1eYJLuqhSjCu0c3ERnqP3c2A8JJEiWxW/QEp0ahhwU9zVPh5zLQpqCUh3VJ6K08jm
         t4fFG32UJRPCd6SDLc8EPS4mFYp5eteqrjtcxIx5ZwgUhNlvPryEd3ValB5KTOzcOiJe
         10x1xYvKvsJ7caFWdFkgGFNhPIJff7Fgmg4mZJAyTNRo43/wG8rWqIuFwKMf1IfgTD/m
         llwQvGmYYTvgKL+yzRykv645rF6XJDJsz1bSSSruZ8onoFNuFanBd8bZ/GZtEfVhZHpx
         wzOA==
X-Gm-Message-State: AOAM533JQdirTNbWm9MOc7lQ+iTn8HKi5e6KpbFEHgoxjkAFW9RVG1BE
        SMYBTCpUmLTdVoY8zj46Y2Kg+7biarKjoTvEaKU4fHR+YwxohU9wmkPmEIGo+5fgkakF7tPI6jn
        UFMBUHCf/aAMYHlIyYmXnHQ==
X-Received: by 2002:a05:6214:21ae:: with SMTP id t14mr20997602qvc.36.1640727010237;
        Tue, 28 Dec 2021 13:30:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzfEjMfPqR60C5of2U4nOV8i5dTSbhNYRsXcPJ5AM9RUqI3+1pyKKK7TeYmr4kflXNZSC7gQg==
X-Received: by 2002:a05:6214:21ae:: with SMTP id t14mr20997592qvc.36.1640727010045;
        Tue, 28 Dec 2021 13:30:10 -0800 (PST)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id u6sm16668245qki.129.2021.12.28.13.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 13:30:09 -0800 (PST)
Date:   Tue, 28 Dec 2021 16:30:08 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        dm-devel@redhat.com
Subject: Re: [PATCH 0/3] blk-mq/dm-rq: support BLK_MQ_F_BLOCKING for dm-rq
Message-ID: <YcuB4K8P2d9WFb83@redhat.com>
References: <20211221141459.1368176-1-ming.lei@redhat.com>
 <YcH/E4JNag0QYYAa@infradead.org>
 <YcP4FMG9an5ReIiV@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YcP4FMG9an5ReIiV@T590>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Dec 22 2021 at 11:16P -0500,
Ming Lei <ming.lei@redhat.com> wrote:

> On Tue, Dec 21, 2021 at 08:21:39AM -0800, Christoph Hellwig wrote:
> > On Tue, Dec 21, 2021 at 10:14:56PM +0800, Ming Lei wrote:
> > > Hello,
> > > 
> > > dm-rq may be built on blk-mq device which marks BLK_MQ_F_BLOCKING, so
> > > dm_mq_queue_rq() may become to sleep current context.
> > > 
> > > Fixes the issue by allowing dm-rq to set BLK_MQ_F_BLOCKING in case that
> > > any underlying queue is marked as BLK_MQ_F_BLOCKING.
> > > 
> > > DM request queue is allocated before allocating tagset, this way is a
> > > bit special, so we need to pre-allocate srcu payload, then use the queue
> > > flag of QUEUE_FLAG_BLOCKING for locking dispatch.
> > 
> > What is the benefit over just forcing bio-based dm-mpath for these
> > devices?
> 
> At least IO scheduler can't be used for bio based dm-mpath, also there should
> be other drawbacks for bio based mpath and request mpath is often the default
> option, maybe Mike has more input about bio vs request dm-mpath.

Yeah, people use request-based for IO scheduling and more capable path
selectors. Imposing bio-based would be a pretty jarring workaround for 
BLK_MQ_F_BLOCKING. request-based DM should properly support it.

I'm on vacation for the next week but will have a look at this
patchset once I'm back.

Thanks,
Mike

