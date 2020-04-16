Return-Path: <SRS0=Ef4g=6A=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A08CEC352BE
	for <linux-block@archiver.kernel.org>; Thu, 16 Apr 2020 06:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80AFA2078A
	for <linux-block@archiver.kernel.org>; Thu, 16 Apr 2020 06:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587018166;
	bh=mQHOk95nt5MavfdVE5FO7f/34LV/2w9cEYqNt9syS6o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FHDgKaxoVJw0Cddy94H+iPZQZxh4rpTOShlTEpaZm47amu6lf8JNemvd6OBltgp8j
	 O4OpxUKaZKK54GZ5xYnEqCaBeORMPMDMaBFBOzBTt1cp3uBxpLc8Qsl7qIac9N7L4p
	 D+eErKxnp5gU88SlIpOUXV4cWQ0edcP98VUw8qkw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407851AbgDPGWo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Apr 2020 02:22:44 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34934 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407768AbgDPGWk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Apr 2020 02:22:40 -0400
Received: by mail-pl1-f193.google.com with SMTP id y12so999385pll.2;
        Wed, 15 Apr 2020 23:22:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=k27Be6sd1Yc09djkEIgQideX2oHMZDOH9/7c5zs2sCc=;
        b=UrfsfCP48hRFvskEspBLAuBT8+9ZF22buldeOcgDFg1so3URLPfBMRsrd2DCOJl2gt
         2B3Jx0JzpI4p2q+8oXGa92W6wJmanSdQzXJQfxEeIPbeKINh1WFhf5MY6ifq0hCel26I
         jZDQs4D5Jakq5Wv2H4mCn3fXkVD53mSLhLWESEIIhMh32IoiK0PcAuZ4r7XCPhNffTRS
         Ci6h3cH/3K6L7/GgBJ7Bdv+F1kDbfkK34tXTXpJPrDpQElVBIIVmQrq950wstG4kj/l0
         g+zhVYPUbB4BnqOLYdJUPXxOQaE1uPBgPCTU5PSnOCMfpW4Y4ZLwAjGsiXIlhrGdugVo
         1lBA==
X-Gm-Message-State: AGi0PuaS0WMxJQNIGC6hEl2tOoGnZLFGwldBK2T2yCq2F9UZsyxMs/E3
        0XELc079bNBBPPfJ3gXzdac=
X-Google-Smtp-Source: APiQypIQ51ni3Je5IKOGJuKEzLtGVk37MLMrhVVcjFEkKHx5TdRw0XNEdFYvpD1Pu+HekUaYWJdUZQ==
X-Received: by 2002:a17:90b:20a:: with SMTP id fy10mr3426003pjb.9.1587018158495;
        Wed, 15 Apr 2020 23:22:38 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id f21sm1896083pfn.71.2020.04.15.23.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 23:22:37 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id BFD6C40277; Thu, 16 Apr 2020 06:22:36 +0000 (UTC)
Date:   Thu, 16 Apr 2020 06:22:36 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     axboe@kernel.dk, viro@zeniv.linux.org.uk, bvanassche@acm.org,
        gregkh@linuxfoundation.org, rostedt@goodmis.org, mingo@redhat.com,
        jack@suse.cz, nstange@suse.de, akpm@linux-foundation.org,
        mhocko@suse.com, yukuai3@huawei.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Hannes Reinecke <hare@suse.com>,
        Michal Hocko <mhocko@kernel.org>,
        syzbot+603294af2d01acfdd6da@syzkaller.appspotmail.com
Subject: Re: [PATCH 2/5] blktrace: fix debugfs use after free
Message-ID: <20200416062236.GM11244@42.do-not-panic.com>
References: <20200414041902.16769-1-mcgrof@kernel.org>
 <20200414041902.16769-3-mcgrof@kernel.org>
 <20200416021036.GA2717677@T590>
 <20200416052524.GH11244@42.do-not-panic.com>
 <20200416054750.GA2723777@T590>
 <20200416060921.GB2723777@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416060921.GB2723777@T590>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Apr 16, 2020 at 02:09:21PM +0800, Ming Lei wrote:
> On Thu, Apr 16, 2020 at 01:47:50PM +0800, Ming Lei wrote:
> > On Thu, Apr 16, 2020 at 05:25:24AM +0000, Luis Chamberlain wrote:
> > > On Thu, Apr 16, 2020 at 10:10:36AM +0800, Ming Lei wrote:
> > > > In theory, multiple partitions can be traced concurrently, but looks
> > > > it never works, so it won't cause trouble for multiple partition trace.
> > > > 
> > > > One userspace visible change is that blktrace debugfs dir name is switched 
> > > > to disk name from partition name in case of partition trace, will it
> > > > break some utilities?
> > > 
> > > How is this possible, its not clear to me, we go from:
> > > 
> > > -	q->debugfs_dir = debugfs_create_dir(kobject_name(q->kobj.parent),
> > > -					    blk_debugfs_root);
> > > 
> > > To this:
> > > 
> > > +	q->debugfs_dir = debugfs_create_dir(kobject_name(q->kobj.parent),
> > > +					    blk_debugfs_root);
> > > 
> > > 
> > > Maybe I am overlooking something.
> > 
> > Your patch removes the blktrace debugfs dir:
> > 
> > do_blk_trace_setup()
> > 
> > -       dir = debugfs_lookup(buts->name, blk_debugfs_root);
> > -       if (!dir)
> > -               bt->dir = dir = debugfs_create_dir(buts->name, blk_debugfs_root);
> > -
> > 
> > Then create blktrace attributes under the dir of q->debugfs_dir.
> > 
> > However, buts->name could be one partition device name, but
> > q->debugfs_dir has to be disk name.
> > 
> > This change is visible to blktrace utilities.
> 
> Just test the 1st two patches via "blktrace /dev/sda2", follows the
> result, so this way can't be accepted.
> 
> [root@ktest-01 ~]# blktrace /dev/sda2
> Thread 0 failed open /sys/kernel/debug/block/sda2/trace0: 2/No such file or directory
> Thread 4 failed open /sys/kernel/debug/block/sda2/trace4: 2/No such file or directory
> Thread 1 failed open /sys/kernel/debug/block/sda2/trace1: 2/No such file or directory
> Thread 2 failed open /sys/kernel/debug/block/sda2/trace2: 2/No such file or directory
> Thread 5 failed open /sys/kernel/debug/block/sda2/trace5: 2/No such file or directory
> Thread 3 failed open /sys/kernel/debug/block/sda2/trace3: 2/No such file or directory
> Thread 6 failed open /sys/kernel/debug/block/sda2/trace6: 2/No such file or directory
> Thread 7 failed open /sys/kernel/debug/block/sda2/trace7: 2/No such file or directory
> FAILED to start thread on CPU 0: 1/Operation not permitted
> FAILED to start thread on CPU 1: 1/Operation not permitted
> FAILED to start thread on CPU 2: 1/Operation not permitted
> FAILED to start thread on CPU 3: 1/Operation not permitted
> FAILED to start thread on CPU 4: 1/Operation not permitted
> FAILED to start thread on CPU 5: 1/Operation not permitted
> FAILED to start thread on CPU 6: 1/Operation not permitted
> FAILED to start thread on CPU 7: 1/Operation not permitted

Thanks, as I noted, I think we'd need to pre-create the directories per
parition. Let me know if you think of a better alternative.

  Luis
