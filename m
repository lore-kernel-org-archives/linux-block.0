Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E5FC433F5
	for <linux-block@archiver.kernel.org>; Thu, 11 Nov 2021 00:56:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACB8061381
	for <linux-block@archiver.kernel.org>; Thu, 11 Nov 2021 00:56:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbhKKA6v (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Nov 2021 19:58:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbhKKA6v (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Nov 2021 19:58:51 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C0DCC061766
        for <linux-block@vger.kernel.org>; Wed, 10 Nov 2021 16:56:03 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id r130so4152093pfc.1
        for <linux-block@vger.kernel.org>; Wed, 10 Nov 2021 16:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=H81/bB3udhC68idu8DkqPLE1V097Qt1GGR9m32VZ7og=;
        b=n9ZkFvI8uG5/YxDkNcneZRadB5gnx3VnSQm2cWODrFivIBlUaSjCGR6MhMmZhUZfQ8
         9Jfg6R7ORrvgRzbF0is0N8+uMHdvedV3oOmX0QM7FlA8sXA93j/8dIxr6O/pBfQsja09
         6bcJORt/rMCSfLxaMdRjlPaY2ZJjzcL7/vVHXMkmNezU0+1jvkI3n92XN0qz6ji9SuRs
         2SZNGMXvVQBGj6ReDsSNBJaGGWYq4JPmbmt2Q+Yitj5rFWFUwwfFEGLUwTO13+2e7Vde
         YX+0BBibpA/xs0lWwsbQx1U4fd+jAQ7uMwbfVe2suiCf3RURL/ppiVode2vit/E9w2qP
         vdew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=H81/bB3udhC68idu8DkqPLE1V097Qt1GGR9m32VZ7og=;
        b=tVp27x3HIKGHeTZ4K2MVVHrE8bfjzbFjCFxlyN2KuB70Pgf0zCGleX23Zc59cMAiWl
         D+lYRj27NuRDKKClXqxAWQXg7fy42rtZ6oPNj8h1QPFSW5wDRqIjYxdjpq/tlBHj9E8a
         TxYsul9pBPlbvE3mxHzn2QHHYnj3MPgW3UmLbhjfuRMX6VWMttytXnql0CtuMWFmX5iB
         QBHJKET1RFs+Qkny0GKtzwjvtm/FxgmCSEjQB8lAs5NxvbO/Sjk9+oWggNn14bqsct6x
         pgYjxiofEaL1PF5gvqVP8dBfBqGBxzW4HbF4kisgBs5iO7GYYhxVZNodeNZoMaW/h8Jj
         KO6A==
X-Gm-Message-State: AOAM531OVtkvfZl26CXfUa+BsVO4pYCcWj6rK4NaGgRBQudoeJEiVlaq
        Xf9Q59sdoDClfNnWah7OagpRzkNuhm4=
X-Google-Smtp-Source: ABdhPJx3UZ1pZmCiif7nntR/VW56rIYzEn2RwRLyK8fvy3hSmEhhD0QMLYCKBPD22jN9Uh5qfgZd/Q==
X-Received: by 2002:a63:9255:: with SMTP id s21mr2071127pgn.256.1636592162421;
        Wed, 10 Nov 2021 16:56:02 -0800 (PST)
Received: from dschatzberg-fedora-PC0Y6AEN.dhcp.thefacebook.com ([2620:10d:c090:400::5:c24e])
        by smtp.gmail.com with ESMTPSA id a12sm6472438pjq.16.2021.11.10.16.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 16:56:01 -0800 (PST)
Date:   Wed, 10 Nov 2021 19:55:58 -0500
From:   Dan Schatzberg <schatzberg.dan@gmail.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Ming Lei <ming.lei@redhat.com>, axboe@kernel.dk,
        linux-block@vger.kernel.org
Subject: Re: [syzbot] possible deadlock in __loop_clr_fd (3)
Message-ID: <YYxqHhzEwCqhsy1Y@dschatzberg-fedora-PC0Y6AEN.dhcp.thefacebook.com>
References: <00000000000089436205d07229eb@google.com>
 <0e91a4b0-ef91-0e60-c0fc-e03da3b65d57@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e91a4b0-ef91-0e60-c0fc-e03da3b65d57@I-love.SAKURA.ne.jp>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Nov 11, 2021 at 07:10:56AM +0900, Tetsuo Handa wrote:
> Hello.
> 
> Commit 87579e9b7d8dc36e ("loop: use worker per cgroup instead of kworker")
> is calling destroy_workqueue() with lo->lo_mutex held, and syzbot is
> reporting circular locking dependency

The commit changed the logic from a separate kthread + queue to a
workqueue. So I don't believe this changed anything regarding this
circular locking dependency, it's just that the dependency is now
clear via workqueue whereas it wasn't with the kthread.

> 
>   &disk->open_mutex => &lo->lo_mutex => (wq_completion)loop$M =>
>   (work_completion)(&lo->rootcg_work) => sb_writers#$N => &p->lock =>
>   &of->mutex => system_transition_mutex/1 => &disk->open_mutex
> 
> . Can you somehow call destroy_workqueue() without holding a lock (e.g.
> breaking &lo->lo_mutex => (wq_completion)loop$M dependency chain by
> making sure that below change is safe) ?

It's really not clear to me - the lo_mutex protects a lot of entry
points (ioctls and others) and it's hard to tell if the observed state
will be sane if they can race in the middle of __loop_clr_fd.

> 
> @@ -1365,7 +1365,9 @@ static int __loop_clr_fd(struct loop_device *lo, bool release)
>         /* freeze request queue during the transition */
>         blk_mq_freeze_queue(lo->lo_queue);
> 
> +       mutex_unlock(&lo->lo_mutex);
>         destroy_workqueue(lo->workqueue);
> +       mutex_lock(&lo->lo_mutex);
>         spin_lock_irq(&lo->lo_work_lock);
>         list_for_each_entry_safe(worker, pos, &lo->idle_worker_list,
>                                 idle_list) {
> 
> On 2021/11/11 2:00, syzbot wrote:
> > Hello,
> > 
> > syzbot found the following issue on:
> > 
> > HEAD commit:    cb690f5238d7 Merge tag 'for-5.16/drivers-2021-11-09' of gi..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=1611368ab00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=9d7259f0deb293aa
> > dashboard link: https://syzkaller.appspot.com/bug?extid=63614029dfb79abd4383
> > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> 
