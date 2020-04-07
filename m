Return-Path: <SRS0=69Bb=5X=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2609C2BA80
	for <linux-block@archiver.kernel.org>; Tue,  7 Apr 2020 19:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EF9620768
	for <linux-block@archiver.kernel.org>; Tue,  7 Apr 2020 19:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586286014;
	bh=Lde45rsVR94vCtmaheBgWUpbSHu4NQK23JdF7kYO79Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Rd72OcnFvDsb8E7lw9NfpxzoGdx06AdzqZ290JL9dPabgKn0GuBLb3/whYtjysa7n
	 heTYh1Ycv5pemclh63oVboJN51uEnVUTGSEdFeWXlgyX8YU6oaQecZ+W7vp7q628SN
	 Ut56BqVJM9rJ9yrssQi3lKHTlDfC5ju0vA+/KZKE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbgDGTAK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Apr 2020 15:00:10 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44153 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbgDGTAK (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Apr 2020 15:00:10 -0400
Received: by mail-pg1-f196.google.com with SMTP id n13so725394pgp.11;
        Tue, 07 Apr 2020 12:00:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=8g+YOhto+FId7IOGUsnB9ouZCy1lzdR5Jj8DGscjgPI=;
        b=lZ1KjvpXvtj33QhvN+6L47Fl7nyV9BQgah/WiiuNfrJRnXXoKpzRIASMmJI1U6DJfY
         Nspm7KlQkEt9JzC7SRfIaVSOe1OehX5PlhgO0i1EM7L2HwITRo0Nk6y5o2ZVyMPrrcb/
         iavfpmP/lhUyvEXk4x17fzVzR+zJ4RSxho4zpA4x/wERThmineXfAH3Ra1HtldHJKYJ6
         Csg3C6XedQAV6sqrYlv1bOw7g9HOntHqEP1TfRUnc869NpCp/TJKIu1VODW7ukO261FL
         QeZi45Au/nwwBrgThMeuD5kqtCsRYeVm98qFKaZLciXpJHPtnPaRiPLZO/VHBGSrIf0c
         rcTg==
X-Gm-Message-State: AGi0PubnlF2qgaelbQlFdCLc6H5OXhjdRcsOyGR2mC0TQ1E4yIiwJrwD
        WzGrP1UDE0eaDI1TRQMDJrI=
X-Google-Smtp-Source: APiQypKZLouSqK9lQOJSsWNqRvqKEIfChEwiU3Z9h3IB3dcC5wNVv88wHOM+aJPwonteOJ90kXqfDQ==
X-Received: by 2002:aa7:96c1:: with SMTP id h1mr3991833pfq.212.1586286007677;
        Tue, 07 Apr 2020 12:00:07 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id i2sm14616408pfr.203.2020.04.07.12.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 12:00:05 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 60B4B40246; Tue,  7 Apr 2020 19:00:04 +0000 (UTC)
Date:   Tue, 7 Apr 2020 19:00:04 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     "yukuai (C)" <yukuai3@huawei.com>
Cc:     Ming Lei <ming.lei@redhat.com>, axboe@kernel.dk,
        viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org,
        rostedt@goodmis.org, mingo@redhat.com, jack@suse.cz,
        nstange@suse.de, mhocko@suse.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC 0/3] block: address blktrace use-after-free
Message-ID: <20200407190004.GG11244@42.do-not-panic.com>
References: <20200402000002.7442-1-mcgrof@kernel.org>
 <20200403081929.GC6887@ming.t460p>
 <0e753195-72fb-ce83-16a1-176f2c3cea6a@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0e753195-72fb-ce83-16a1-176f2c3cea6a@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 07, 2020 at 10:47:01AM +0800, yukuai (C) wrote:
> On 2020/4/3 16:19, Ming Lei wrote:
> 
> > BTW, Yu Kuai posted one patch for this issue, looks that approach
> > is simpler:
> > 
> > https://lore.kernel.org/linux-block/20200324132315.22133-1-yukuai3@huawei.com/
> > 
> > 
> 
> I think the issue might not be fixed with the patch seires.
> 
> At first, I think there are two key points for the issure:
> 1. The final release of queue is delayed in a workqueue
> 2. The creation of 'q->debugfs_dir' might failed(only if 1 exist)
> And if we can fix any of the above problem, the UAF issue will be fixed.
> (BTW, I did not come up with a good idea for problem 1, and my approach
> is for problem 2.)
> 
> The third patch "block: avoid deferral of blk_release_queue() work" is
> not enough to fix problem 1:
> a. if CONFIG_DEBUG_KOBJECT_RELEASE is enable:
> static void kobject_release(struct kref *kref)
> {
>         struct kobject *kobj = container_of(kref, struct kobject, kref);
> #ifdef CONFIG_DEBUG_KOBJECT_RELEASE
>         unsigned long delay = HZ + HZ * (get_random_int() & 0x3);
>         pr_info("kobject: '%s' (%p): %s, parent %p (delayed %ld)\n",
>                 ┊kobject_name(kobj), kobj, __func__, kobj->parent, delay);
>         INIT_DELAYED_WORK(&kobj->release, kobject_delayed_cleanup);
> 
>         schedule_delayed_work(&kobj->release, delay);
> #else
>         kobject_cleanup(kobj);
> #endif
> }
> b. when 'kobject_put' is called from blk_cleanup_queue, can we make sure
> it is the last reference?

You are right, I think I know the fix for this now. Will run some more
tests.

  Luis
