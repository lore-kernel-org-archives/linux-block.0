Return-Path: <SRS0=lWBJ=7K=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C63CC433DF
	for <linux-block@archiver.kernel.org>; Thu, 28 May 2020 14:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D03B206A1
	for <linux-block@archiver.kernel.org>; Thu, 28 May 2020 14:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590677744;
	bh=aeWCbJC1lVpG7XBaulzFleC3fVFsQ3XErVC65IO43tE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OAJo9WALUPIU+yvy0btrOUIk3o68ROFO7ApTsB2H+De+noJaEU1QiKDxbvhd3ysrY
	 b/kg8RtuErdikTYnpxc2oQ/kSIZNoxACVX8OUTikRnXXEZLIxxbPNfSWzHNWrsyg8O
	 ELgkZ16obENLBmcZTl61v1mShqQ1tuBn8PH4YWKo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391314AbgE1Ozn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 May 2020 10:55:43 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:39553 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391280AbgE1Ozm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 May 2020 10:55:42 -0400
Received: by mail-pj1-f65.google.com with SMTP id n15so3205474pjt.4
        for <linux-block@vger.kernel.org>; Thu, 28 May 2020 07:55:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Uu4KWUW4u3Cn+gGQE+G+FxqVnArkbnVy0FGqOMUP4vo=;
        b=VZyVQdu6KhyxQJgn7LiDYgp/rJCvUWbo0Dua9pL1bqtLKHipSJClUX+44c0eZaIWwq
         vU+i7zf8uCHzrNogZLtvv4wpDXPY1oYo6Had1G0VGDQn3/mWq4YZlkoJ+/uQLnS1qnFs
         gCnYXtIh6rx8LyXyGxTvq+NupX4j+jjUtFq+MKM4F8RourHFgcrCAkhHChRUPd79HrJb
         duAy9iacZ600ruP/ljIkFa71P8eisBCaSNW3bFH1vZj0SnkRbtTkSqOYeI4bbbLT2ymo
         UjM2OsmbhafOHdtOk8gDnC664p0dPBHtptJ4xkgCLJYcv3ugh+EOMHUshutQzdKQtSGt
         jszQ==
X-Gm-Message-State: AOAM530GY2wi5gA6XczZ8cjQksgzN63yHCXEVFHjRYrOtKfd5caLKQiY
        qbqf5Zokxr7ADAy0ZKADme8=
X-Google-Smtp-Source: ABdhPJxMCymVowtp3x/oJmCd3ytOqschsRATBYwwnN2+YbAtzfOJe1CNQlK5f5b8+pngrdoHaMRTww==
X-Received: by 2002:a17:90a:4fc6:: with SMTP id q64mr4269352pjh.34.1590677741628;
        Thu, 28 May 2020 07:55:41 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id y6sm5141812pjn.37.2020.05.28.07.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 07:55:40 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id D19F340605; Thu, 28 May 2020 14:55:39 +0000 (UTC)
Date:   Thu, 28 May 2020 14:55:39 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] blktrace: Avoid sparse warnings when assigning
 q->blk_trace
Message-ID: <20200528145539.GS11244@42.do-not-panic.com>
References: <20200528092910.11118-1-jack@suse.cz>
 <298af02a-3b58-932a-8769-72dcc52750ad@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <298af02a-3b58-932a-8769-72dcc52750ad@acm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, May 28, 2020 at 07:44:38AM -0700, Bart Van Assche wrote:
> > @@ -1669,10 +1672,7 @@ static int blk_trace_setup_queue(struct request_queue *q,
> >  
> >  	blk_trace_setup_lba(bt, bdev);
> >  
> > -	ret = -EBUSY;
> > -	if (cmpxchg(&q->blk_trace, NULL, bt))
> > -		goto free_bt;
> > -
> > +	rcu_assign_pointer(q->blk_trace, bt);
> >  	get_probe_ref();
> >  	return 0;
> 
> Shouldn't q->blk_trace only be assigned if
> q->blk_trace == NULL?

Yes but the old call checked for that and left it as NULL if
it was not NULL.

I have a patch in my series which checks for q->blkt_trace *early*
prior to continuing to avoid concurrent calls proactively, otherwise
this will fail only at the very end.

  Luis
