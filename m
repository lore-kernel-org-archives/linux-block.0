Return-Path: <SRS0=kKib=BC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96BCDC433E0
	for <linux-block@archiver.kernel.org>; Thu, 23 Jul 2020 18:39:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64B9320737
	for <linux-block@archiver.kernel.org>; Thu, 23 Jul 2020 18:39:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="eQHhYRqK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbgGWSjM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jul 2020 14:39:12 -0400
Received: from linux.microsoft.com ([13.77.154.182]:60144 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbgGWSjM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jul 2020 14:39:12 -0400
Received: from sequoia (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id 70B6D20B4908;
        Thu, 23 Jul 2020 11:39:11 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 70B6D20B4908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1595529552;
        bh=iyO8fOtMCd8Oa3bgvCzuZ60FB7ceo2Gv25auKWMFM8I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eQHhYRqK2LQEH3yNSBaenm464y0EjhuefUBuL3wiokoCUwGRnODBJ/QFTdpDQs+i8
         umCP7vQaJGDdFOznGNjvixJ3jknBB1HySdmyd2aua/8/EXXjfPcDvYWit2AsEYIpTY
         J48486LhmjU1EoBgAyFzX5BcmE2Pwgk2OnH7O/TM=
Date:   Thu, 23 Jul 2020 13:39:09 -0500
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/1] loop: scale loop device by introducing per device
 lock
Message-ID: <20200723183909.GW3673@sequoia>
References: <20200717205322.127694-1-pasha.tatashin@soleen.com>
 <20200717205322.127694-2-pasha.tatashin@soleen.com>
 <20200723180902.GV3673@sequoia>
 <CA+CK2bDC2ARTT2Q=c-p7586Xb8uedx-f6Rr7H9bYn-3U8x=d2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bDC2ARTT2Q=c-p7586Xb8uedx-f6Rr7H9bYn-3U8x=d2Q@mail.gmail.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-07-23 14:29:31, Pavel Tatashin wrote:
> Hi Tyler,
> 
> Thank you for the review comments. My replies are inlined below.
> 
> > > Scale it by introducing per-device lock: lo_mutex that proctests
> > > field in struct loop_device. Keep loop_ctl_mutex to protect global
> >
> > s/proctests field/protects the fields/
> 
> OK
> 
> > > @@ -1890,22 +1890,23 @@ static int lo_open(struct block_device *bdev, fmode_t mode)
> > >               return err;
> > >       lo = bdev->bd_disk->private_data;
> > >       if (!lo) {
> > > -             err = -ENXIO;
> > > -             goto out;
> > > +             mutex_unlock(&loop_ctl_mutex);
> > > +             return -ENXIO;
> > >       }
> > > -
> > > -     atomic_inc(&lo->lo_refcnt);
> > > -out:
> > > +     err = mutex_lock_killable(&lo->lo_mutex);
> > >       mutex_unlock(&loop_ctl_mutex);
> >
> > I don't see a possibility for deadlock but it bothers me a little that
> > we're not unlocking in the reverse locking order here, as we do in
> > loop_control_ioctl(). There should be no perf impact if we move the
> > mutex_unlock(&loop_ctl_mutex) after mutex_unlock(&lo->lo_mutex).
> 
> The lo_open() was one of the top functions that showed up in
> contention profiling, and the only shared data that it updates is
> lo_recnt which can be protected by lo_mutex. We must have
> loop_ctl_mutex in order to get a valid lo pointer, otherwise we could
> race with loop_control_ioctl(LOOP_CTL_REMOVE). Unlocking in a
> different order is not an issue, as long as we always preserve the
> locking order.

It is probably a good idea to leave a comment about this in the
lo_open() so that nobody comes along and tries to "correct" the
unlocking order in the future and, as a result, introduces a perf
regression.

Tyler

> > > @@ -2157,6 +2158,7 @@ static int loop_add(struct loop_device **l, int i)
> > >               disk->flags |= GENHD_FL_NO_PART_SCAN;
> > >       disk->flags |= GENHD_FL_EXT_DEVT;
> > >       atomic_set(&lo->lo_refcnt, 0);
> > > +     mutex_init(&lo->lo_mutex);
> >
> > We need a corresponding call to mutex_destroy() in loop_remove().
> 
> Yes, thank you for catching this.
> 
> > > +++ b/drivers/block/loop.h
> > > @@ -62,6 +62,7 @@ struct loop_device {
> > >       struct request_queue    *lo_queue;
> > >       struct blk_mq_tag_set   tag_set;
> > >       struct gendisk          *lo_disk;
> >
> > There's an instance, which is not in this patch's context, of accessing
> > lo_disk that needs lo_mutex protection. In loop_probe(), we call
> > get_disk_and_module(lo->lo_disk) and we need to lock and unlock lo_mutex
> > around that call.
> 
> I will add it.
> 
> Thank you,
> Pasha
