Return-Path: <SRS0=kKib=BC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61218C433E0
	for <linux-block@archiver.kernel.org>; Thu, 23 Jul 2020 18:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 388CA208E4
	for <linux-block@archiver.kernel.org>; Thu, 23 Jul 2020 18:30:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="dTKklcAd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbgGWSaJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jul 2020 14:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbgGWSaJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jul 2020 14:30:09 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E50C7C0619E2
        for <linux-block@vger.kernel.org>; Thu, 23 Jul 2020 11:30:08 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id q4so2005265edv.13
        for <linux-block@vger.kernel.org>; Thu, 23 Jul 2020 11:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rvUCij/xI8Tu7Ds4R4Iwkd7YIUxN/AQl5LxQFfi62KU=;
        b=dTKklcAdYyc9T2742GbziTsEUjY2HzcNy5SImhgF0X1Fhhrm4yJ8R9ffGhHftDA8ma
         RJ6TQuS2iK8jd5Lv8V2v3u0jIKl9y8RpCrv6VPj19QfH2TJw9Lq+Y+g9zktW7RsHWNOW
         5bMqdegR4SP71hbyPnJPmAV+rgM3QrUrruIJKHq8gV2PnuwWS1EXr1MqwHwcFEK1pV1O
         8bNdUZ//EEyMDoxvQzwop8JmYQi5Xndb/AGD7iBTxdjxk7IuD9YugtoDQEKZwkTJ+wA7
         7G0JcoFLsVZ7iD9QLUKriP7QHeYYaxHI4WhiLyTPixIyRiR9YmHFcUsMumd8lz5ovwI+
         7zBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rvUCij/xI8Tu7Ds4R4Iwkd7YIUxN/AQl5LxQFfi62KU=;
        b=POzzC0U55qJZsJF/FKskVcNvcczHN9tuUnfx82Jgt5wwcf62hJPXWhmUznfmTRU4zR
         UC5ZQ0Zx9oHr+nuci8qtoaMIrtaBwiAPlonFB0TDE6Eq0IsMOZ8OeAdGyQXRFPSWsPYn
         qpaeNQqFkIyLEYusxfipWJMeMLr0vpuD3aMJfzpW08CzvHKYggu2QzetYnus5OANCMtj
         Km4k3GTVgCvxAxsQ73Z/MqdYDGemVo5MLzDYGlYpuyy9TBn5S+hDlsNsZfBlTyT8M5Zz
         Q0oykm2hiZmwQ2Ybowwr9nJQGcmSyFm9NfObN0HBVNdC1w5YY/H5bzaSLcY0omdG1abo
         Xu/A==
X-Gm-Message-State: AOAM531pVnC4Ce8l3HRQ0LT2cixTVjfelavIDRyYUJnsnuxEnAXRFGiZ
        FqdmiXG9ibYb4Ipm5w/K8GBTkrAd0gNPEhjT//93PA==
X-Google-Smtp-Source: ABdhPJyVldfZRT01tpueOfsZWCYZ8Wlyn4xN6inmOLzS7vk3v9ybxIZ/q0VBd5Xt23avdVB6wvmsqnMGe/KUn9RVlDM=
X-Received: by 2002:aa7:cd18:: with SMTP id b24mr5631944edw.3.1595529007532;
 Thu, 23 Jul 2020 11:30:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200717205322.127694-1-pasha.tatashin@soleen.com>
 <20200717205322.127694-2-pasha.tatashin@soleen.com> <20200723180902.GV3673@sequoia>
In-Reply-To: <20200723180902.GV3673@sequoia>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Thu, 23 Jul 2020 14:29:31 -0400
Message-ID: <CA+CK2bDC2ARTT2Q=c-p7586Xb8uedx-f6Rr7H9bYn-3U8x=d2Q@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] loop: scale loop device by introducing per device lock
To:     Tyler Hicks <tyhicks@linux.microsoft.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Tyler,

Thank you for the review comments. My replies are inlined below.

> > Scale it by introducing per-device lock: lo_mutex that proctests
> > field in struct loop_device. Keep loop_ctl_mutex to protect global
>
> s/proctests field/protects the fields/

OK

> > @@ -1890,22 +1890,23 @@ static int lo_open(struct block_device *bdev, fmode_t mode)
> >               return err;
> >       lo = bdev->bd_disk->private_data;
> >       if (!lo) {
> > -             err = -ENXIO;
> > -             goto out;
> > +             mutex_unlock(&loop_ctl_mutex);
> > +             return -ENXIO;
> >       }
> > -
> > -     atomic_inc(&lo->lo_refcnt);
> > -out:
> > +     err = mutex_lock_killable(&lo->lo_mutex);
> >       mutex_unlock(&loop_ctl_mutex);
>
> I don't see a possibility for deadlock but it bothers me a little that
> we're not unlocking in the reverse locking order here, as we do in
> loop_control_ioctl(). There should be no perf impact if we move the
> mutex_unlock(&loop_ctl_mutex) after mutex_unlock(&lo->lo_mutex).

The lo_open() was one of the top functions that showed up in
contention profiling, and the only shared data that it updates is
lo_recnt which can be protected by lo_mutex. We must have
loop_ctl_mutex in order to get a valid lo pointer, otherwise we could
race with loop_control_ioctl(LOOP_CTL_REMOVE). Unlocking in a
different order is not an issue, as long as we always preserve the
locking order.


> > @@ -2157,6 +2158,7 @@ static int loop_add(struct loop_device **l, int i)
> >               disk->flags |= GENHD_FL_NO_PART_SCAN;
> >       disk->flags |= GENHD_FL_EXT_DEVT;
> >       atomic_set(&lo->lo_refcnt, 0);
> > +     mutex_init(&lo->lo_mutex);
>
> We need a corresponding call to mutex_destroy() in loop_remove().

Yes, thank you for catching this.

> > +++ b/drivers/block/loop.h
> > @@ -62,6 +62,7 @@ struct loop_device {
> >       struct request_queue    *lo_queue;
> >       struct blk_mq_tag_set   tag_set;
> >       struct gendisk          *lo_disk;
>
> There's an instance, which is not in this patch's context, of accessing
> lo_disk that needs lo_mutex protection. In loop_probe(), we call
> get_disk_and_module(lo->lo_disk) and we need to lock and unlock lo_mutex
> around that call.

I will add it.

Thank you,
Pasha
