Return-Path: <SRS0=ObBg=6G=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0181C55186
	for <linux-block@archiver.kernel.org>; Wed, 22 Apr 2020 08:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AD0720774
	for <linux-block@archiver.kernel.org>; Wed, 22 Apr 2020 08:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587543979;
	bh=d9FhBzaeSB4lX6ein8DPxqtrESHAO9C5sPKq7ZrlO9o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DV92FRk9Az9toRXpKjPF2dHbMhofMNqCy/AAAxpC/Us2lcqCUIWhcIwqbGLLV2XYm
	 aUzCn6y6NhXgg5yvM4X/gU80/ycQLm1eJiLOoeIjTyBXvp+fdqjwUOUmydjPz30zRz
	 DXCz4LbgjOEndGkTfT6vZ9aK1U8I9X39YETs4uW4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726030AbgDVI0S (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Apr 2020 04:26:18 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39076 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbgDVI0S (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Apr 2020 04:26:18 -0400
Received: by mail-pg1-f193.google.com with SMTP id o10so723419pgb.6;
        Wed, 22 Apr 2020 01:26:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8i3s56k4FMGcvexGwr0CiDNJKnDe69VPIGR2Ex4KDzk=;
        b=VWz8I0G7RXVqXd20WMLKGKhouh0Z4MdxpwegW+SOvBA9LGD6wvtKC6JO9lH4YRWjvZ
         QY4NUdxsIk/rXXZxhkMbG0+oqtyhIll9rF0GW3QbW0SFc+f7CdubXckQWh1n4zDQ894X
         Zf4yory0A5plZ9bEfcwSZFKdH3QPVopzLpRj8Dcn6Z7ZIrW07aqR6eHBOL5OQNdyv9RV
         7cSm/j5rmACiNw+k909cn5JP9QOR6QvKZRHcV2KalDykypKJ2mkjXZkGAUU/3xI9rlvD
         vJDjNiglUhflmFNHmJKNgFMWt7HvfpLPHB/mMq1WyS4P33Ba31guaetr93LJ3dfzqgeq
         6WMg==
X-Gm-Message-State: AGi0Pua4XsIzUC8YG+is5Nsh7Z3ZyFh6rv7cn9yo1s1Xm+c5bNDfuV2A
        Bbe4LsH7scRS1Px1i5nL+CU=
X-Google-Smtp-Source: APiQypIGS3BmOJ3kOCU3MzTcBmmcDehn1M4KxdV6lt1hvbYSD4+iDCsRidjNpHdHB5Di/2A0u0IqDg==
X-Received: by 2002:aa7:9811:: with SMTP id e17mr25216152pfl.70.1587543977422;
        Wed, 22 Apr 2020 01:26:17 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id b20sm4626488pff.8.2020.04.22.01.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 01:26:09 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 8C3D2402A1; Wed, 22 Apr 2020 08:26:04 +0000 (UTC)
Date:   Wed, 22 Apr 2020 08:26:04 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     axboe@kernel.dk, viro@zeniv.linux.org.uk, bvanassche@acm.org,
        gregkh@linuxfoundation.org, rostedt@goodmis.org, mingo@redhat.com,
        jack@suse.cz, ming.lei@redhat.com, nstange@suse.de,
        akpm@linux-foundation.org, mhocko@suse.com, yukuai3@huawei.com,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Omar Sandoval <osandov@fb.com>,
        Hannes Reinecke <hare@suse.com>,
        Michal Hocko <mhocko@kernel.org>,
        syzbot+603294af2d01acfdd6da@syzkaller.appspotmail.com
Subject: Re: [PATCH v2 03/10] blktrace: fix debugfs use after free
Message-ID: <20200422082604.GT11244@42.do-not-panic.com>
References: <20200419194529.4872-1-mcgrof@kernel.org>
 <20200419194529.4872-4-mcgrof@kernel.org>
 <20200422072715.GC19116@infradead.org>
 <20200422074802.GS11244@42.do-not-panic.com>
 <20200422081011.GA22409@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422081011.GA22409@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Apr 22, 2020 at 01:10:11AM -0700, Christoph Hellwig wrote:
> On Wed, Apr 22, 2020 at 07:48:02AM +0000, Luis Chamberlain wrote:
> > > I don't see why we need this check.  If it is valueable enough we
> > > should have a debugfs_create_dir_exclusive or so that retunrns an error
> > > for an exsting directory, instead of reimplementing it in the caller in
> > > a racy way.  But I'm not really sure we need it to start with.
> > 
> > In short races, and even with synchronous request_queue removal I'm
> > seeing the race is still possible, but that's due to some other races
> > I'm going to chase down now.
> > 
> > The easier solution really is to just have a debugfs dir created for
> > each partition if debugfs is enabled, this way the directory will
> > always be there, and the lookups are gone.
> 
> That sounds like the best plan to me.

Groovy.

> > > > +
> > > > +	q->debugfs_dir = debugfs_create_dir(kobject_name(q->kobj.parent),
> > > > +					    blk_debugfs_root);
> > > > +	if (!q->debugfs_dir)
> > > > +		return -ENOMEM;
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +void blk_queue_debugfs_unregister(struct request_queue *q)
> > > > +{
> > > > +	debugfs_remove_recursive(q->debugfs_dir);
> > > > +	q->debugfs_dir = NULL;
> > > > +}
> > > 
> > > Which to me suggests we can just fold these two into the callers,
> > > with an IS_ENABLED for the creation case given that we check for errors
> > > and the stub will always return an error.
> > 
> > Sorry not sure I follow this.
> 
> Don't both with the two above functions and just open code them in
> the callers.  IFF you still want to check for errors after the
> discussion with Greg, wrap the call in a
> 
> 	if (IS_ENABLED(CONFIG_DEBUG_FS))
> 
> to ensure that you don't fail queue creation in the !DEBUG_FS
> case.

Got it, thanks.

  Luis
