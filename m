Return-Path: <SRS0=Ayt2=5W=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6831DC2BA19
	for <linux-block@archiver.kernel.org>; Mon,  6 Apr 2020 14:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3560A23D4E
	for <linux-block@archiver.kernel.org>; Mon,  6 Apr 2020 14:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586183032;
	bh=sEFsw8MjNaxxL6UouVgj5T3wez3PlOS9Vez445xmNLw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bQPrYbz+L7Upfs4+fYDVgwys1puiBooEHTPqUmGLiRjL7oVXd2+BZZ8c8AtDd8mP0
	 BdXEWBgD5/LX3rq1sKEp58ok2U7C81L1wnjkiDEjEqItHZ4duqGd8e9eMWC9WvW/t6
	 QY0QevWn49LkAhDsNoVOxGC8/C7iVXGwMm1d6+/I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728601AbgDFOXv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 Apr 2020 10:23:51 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35298 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728539AbgDFOXv (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 Apr 2020 10:23:51 -0400
Received: by mail-pg1-f194.google.com with SMTP id k5so7648793pga.2;
        Mon, 06 Apr 2020 07:23:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=l4jUivbNeT/tXISEa3mLl14aIqDVskamynqyyyoeohY=;
        b=YsU9jbSzp8588IOyvGG+4YHrxffe3iPQeAwpZRZh4dJI6hn59XpIB0vFzvHRetcMWa
         qH1JDaLYqlmIqMWRsgk60Rlr1+Bfs1EMQshyB7bOcWb4iU9plUGV1kElXNJXVwamhVeF
         6vFKchI2tetJNWTUzBVreFKGSkuJ/zhf/7bFzP4iQfFdpGbrAvC4Sm0T28thh+UgGMP3
         2GfqKFhBrqz74NoGL6SNMm57MzprEBmuXxTKKUOu3v/6NzPZhLFK1OoHl0J6wHOGWao2
         k5If+SIeZfF9N9VpYD+4RIj7yYON8hrFO+aUP5jr0jQLn7fgJCZdzTMVWAp1id+C+q2v
         Y1vQ==
X-Gm-Message-State: AGi0PuZlcIPRY0x1C7Kaw87JZ+5MbvMZPnswBrkBmlEe1q1fn/bwVgmk
        eyTo/sJuFSBaerqSkuMIjCw=
X-Google-Smtp-Source: APiQypIOvcLGL/Zcaffq3CvgymvIweGawVr0JJIIPq4D6r0SEbYJXtqbU0CFu7sYyeuNreyhJjYWYw==
X-Received: by 2002:a63:eb15:: with SMTP id t21mr5705274pgh.279.1586183029353;
        Mon, 06 Apr 2020 07:23:49 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id q71sm11874573pfc.92.2020.04.06.07.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 07:23:48 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 8D41C40246; Mon,  6 Apr 2020 14:23:47 +0000 (UTC)
Date:   Mon, 6 Apr 2020 14:23:47 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     axboe@kernel.dk, viro@zeniv.linux.org.uk,
        gregkh@linuxfoundation.org, rostedt@goodmis.org, mingo@redhat.com,
        jack@suse.cz, ming.lei@redhat.com, nstange@suse.de,
        mhocko@suse.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Omar Sandoval <osandov@fb.com>,
        Hannes Reinecke <hare@suse.com>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [RFC 1/3] block: move main block debugfs initialization to its
 own file
Message-ID: <20200406142347.GB11244@42.do-not-panic.com>
References: <20200402000002.7442-1-mcgrof@kernel.org>
 <20200402000002.7442-2-mcgrof@kernel.org>
 <cef15625-3814-aec2-d10c-1344a6f063a9@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cef15625-3814-aec2-d10c-1344a6f063a9@acm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Apr 04, 2020 at 08:12:53PM -0700, Bart Van Assche wrote:
> On 2020-04-01 17:00, Luis Chamberlain wrote:
> > Single and multiqeueue block devices share some debugfs code. By
>              ^^^^^^^^^^^
>              multiqueue?
> > moving this into its own file it makes it easier to expand and audit
> > this shared code.
> 
> [ ... ]
> 
> > diff --git a/block/blk-debugfs.c b/block/blk-debugfs.c
> > new file mode 100644
> > index 000000000000..634dea4b1507
> > --- /dev/null
> > +++ b/block/blk-debugfs.c
> > @@ -0,0 +1,15 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +/*
> > + * Shared debugfs mq / non-mq functionality
> > + */
> 
> The legacy block layer is gone, so not sure why the above comment refers
> to non-mq?

Will adjust the language, thanks.

> 
> > diff --git a/block/blk.h b/block/blk.h
> > index 0a94ec68af32..86a66b614f08 100644
> > --- a/block/blk.h
> > +++ b/block/blk.h
> > @@ -487,5 +487,12 @@ struct request_queue *__blk_alloc_queue(int node_id);
> >  int __bio_add_pc_page(struct request_queue *q, struct bio *bio,
> >  		struct page *page, unsigned int len, unsigned int offset,
> >  		bool *same_page);
> > +#ifdef CONFIG_DEBUG_FS
> > +void blk_debugfs_register(void);
> > +#else
> > +static inline void blk_debugfs_register(void)
> > +{
> > +}
> > +#endif /* CONFIG_DEBUG_FS */
> 
> Do we really need a new header file that only declares a single
> function? How about adding the above into block/blk-mq-debugfs.h?

Moving forward rq->debugfs_dir will created when CONFIG_DEBUG_FS is
enabled to enable blktrace to use it. This creation won't depend on
CONFIG_BLK_DEBUG_FS, so we can definitely sprinkly the #ifdef
CONFIG_DEBUG_FS stuff in block/blk-mq-debugfs.h but it just didn't
seem the best place. Let me know.

  Luis
