Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8CE9C433DB
	for <linux-block@archiver.kernel.org>; Tue, 26 Jan 2021 14:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BE1C230FC
	for <linux-block@archiver.kernel.org>; Tue, 26 Jan 2021 14:31:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392715AbhAZOay (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Jan 2021 09:30:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392439AbhAZOaq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Jan 2021 09:30:46 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7859CC0611BD
        for <linux-block@vger.kernel.org>; Tue, 26 Jan 2021 06:30:05 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id j13so20003419edp.2
        for <linux-block@vger.kernel.org>; Tue, 26 Jan 2021 06:30:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=US8a/kB/55AFjkFFf4UVOg+wWSaZCuyXBjpUsvs+feI=;
        b=lpn4V6P0eE+FY6dqw/ysEzqC/coXbO5OV+4q6B/Z9DSxXvvF6hCV9twibOZb1hb3IZ
         uW/yUXid/E3Rk1HIzRWfV2D7+/Xo2SUX0FegjPS8XW++udkKwsIBtDBkf1P7XwGo29w5
         c20hEJI7NzNoZDg6BZ+CjioEVbqz1EEd9wQzkq1112iJEvNEG2gusx7NH5JmQvppOaHf
         E0/rX+x3fA6eN98/fX4WqYDyYJ3UOmE3faZh3LO7XWLRQkXIac7Gv82w7Jwl+T5Xx9sn
         cT7VIwZ58SnAzZxfhQPpWrFsuBiY/NNoeoxP/9lDqnJbcRqiDXx1k293FX7j7G4IkYNz
         HngQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=US8a/kB/55AFjkFFf4UVOg+wWSaZCuyXBjpUsvs+feI=;
        b=tzPu4+LtN78LP1bIYcv4fjrtl4T+YaBHQy859oWM98MMdXTijl9nSfcS6GAcAffQV3
         k95x7IMHBKWqlJ50LoWg5ekigWKfSvPDMVuRk6camlFWgKGF3MRU+4W0JRTHCC3G5LCu
         zUbT9U56RZ48cspoWj9a0fEWbWREClPGRr+MeLP0f+pRcIMMRab+w9uZE7m3DWPjvOCv
         7azBoHIkee1DZuQ8Oo7Cis6oZL9o1q5uFH0u7mPq2NJ7h5AStCAuSHtgvEnTUiej6lp6
         eptKyJYPAQkr6Yjt9SPFpPyFGMkXCZEJoULHxFYfm0fl5CBzcsIVYDZW6d3E0dWpBwjp
         ZcnA==
X-Gm-Message-State: AOAM533+dl1gqeBX2QAXV2EJY+bK/wsOOagLXKWFC9y+F/JyUwxxcdAr
        8rN/YvwSR3CLDqG4ij4VjYatSTHJjO5yepvrBrkaDQ==
X-Google-Smtp-Source: ABdhPJz0ls97OG8+OSmc9t5sQKWLr7rZ0A9Jbf5tTkXRc1iBOLXK3fdIESF/F71aZUt8OTnFhumnht6dZlyx93lBEF4=
X-Received: by 2002:aa7:d803:: with SMTP id v3mr4667824edq.153.1611671404169;
 Tue, 26 Jan 2021 06:30:04 -0800 (PST)
MIME-Version: 1.0
References: <20210125201156.1330164-1-pasha.tatashin@soleen.com>
 <20210125201156.1330164-2-pasha.tatashin@soleen.com> <BYAPR04MB4965A6FB4ED51882E326EC1A86BC9@BYAPR04MB4965.namprd04.prod.outlook.com>
In-Reply-To: <BYAPR04MB4965A6FB4ED51882E326EC1A86BC9@BYAPR04MB4965.namprd04.prod.outlook.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Tue, 26 Jan 2021 09:29:28 -0500
Message-ID: <CA+CK2bAQcGPYtbGziyRpzTRQ8WCLsvM2DmFYLwDRMXMX6U38+w@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] loop: scale loop device by introducing per device lock
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc:     "tyhicks@linux.microsoft.com" <tyhicks@linux.microsoft.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "lukas.bulwahn@gmail.com" <lukas.bulwahn@gmail.com>,
        "hch@lst.de" <hch@lst.de>, "pvorel@suse.cz" <pvorel@suse.cz>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "mzxreary@0pointer.de" <mzxreary@0pointer.de>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "zhengbin13@huawei.com" <zhengbin13@huawei.com>,
        "maco@android.com" <maco@android.com>,
        "colin.king@canonical.com" <colin.king@canonical.com>,
        "evgreen@chromium.org" <evgreen@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 26, 2021 at 4:53 AM Chaitanya Kulkarni
<Chaitanya.Kulkarni@wdc.com> wrote:
>
> On 1/25/21 12:15 PM, Pavel Tatashin wrote:
> > Currently, loop device has only one global lock:
> > loop_ctl_mutex.
> Above line can be :-
> Currently, loop device has only one global lock: loop_ctl_mutex.

OK

>
> Also please provide a complete discretion what are the members it protects,
> i.e. how big the size of the current locking is, helps the reviewers &
> maintainer.

Sure

> > This becomes hot in scenarios where many loop devices are used.
> >
> > Scale it by introducing per-device lock: lo_mutex that protects the
> > fields in struct loop_device. Keep loop_ctl_mutex to protect global
> > data such as loop_index_idr, loop_lookup, loop_add.
> When it comes to scaling, lockstat data is more descriptive and useful along
> with thetotal time of execution which has contention numbers with increasing
> number of threads/devices/users on logarithmic scale, at-least that is
> how I've
> solved the some of file-systems scaling issues in the past.

I found this issue using perf that shows profiling. I've previously
used lockstat, it is indeed a good tool to work with lock contentions.

> >
> > Lock ordering: loop_ctl_mutex > lo_mutex.
> The above statement needs a in-detail commit log description. Usually >
> sort of statements are not a good practice for something as important as
> lock priority which was not present in the original code.

OK, I will expand this to clearly state that new lock ordering
requirement is that loop_ctl_mutex must be taken before lo_mutex.

> > Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> > Reviewed-by: Tyler Hicks <tyhicks@linux.microsoft.com>
> > ---
> >  drivers/block/loop.c | 92 +++++++++++++++++++++++++-------------------
> >
> >
> >
> >       /*
> > -      * Need not hold loop_ctl_mutex to fput backing file.
> > -      * Calling fput holding loop_ctl_mutex triggers a circular
> > +      * Need not hold lo_mutex to fput backing file.
> > +      * Calling fput holding lo_mutex triggers a circular
> >        * lock dependency possibility warning as fput can take
> > -      * bd_mutex which is usually taken before loop_ctl_mutex.
> > +      * bd_mutex which is usually taken before lo_mutex.
> >        */
> This is not in your patch, but since you are touching this comment can you
> please consider this, it save an entire line and the wasted space:-

OK

>        /*
>         * Need not hold lo_mutex to fput backing file. Calling fput holding
>         * lo_mutex triggers a circular lock dependency possibility
> warning as
>         * fput can take bd_mutex which is usually take before lo_mutex.
>         */
>
> > @@ -1879,27 +1879,33 @@ static int lo_open(struct block_device *bdev, fmode_t mode)
> >       struct loop_device *lo;
> >       int err;
> >
> > +     /*
> > +      * take loop_ctl_mutex to protect lo pointer from race with
> > +      * loop_control_ioctl(LOOP_CTL_REMOVE), however, to reduce
> > +      * contention release it prior to updating lo->lo_refcnt.
> > +      */
>
> The above comment could be :-
>
>         /*
>          * Take loop_ctl_mutex to protect lo pointer from race with
>          * loop_control_ioctl(LOOP_CTL_REMOVE), however, to reduce
> contention
>          * release it prior to updating lo->lo_refcnt.
>          */

OK

> >       err = mutex_lock_killable(&loop_ctl_mutex);
> >       if (err)

I will send an updated patch soon.

Thank you,
Pasha
