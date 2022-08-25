Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71426C64990
	for <linux-block@archiver.kernel.org>; Thu, 25 Aug 2022 14:50:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242122AbiHYOuE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Aug 2022 10:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236180AbiHYOuD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Aug 2022 10:50:03 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42161A1BF
        for <linux-block@vger.kernel.org>; Thu, 25 Aug 2022 07:50:01 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id t5so26409482edc.11
        for <linux-block@vger.kernel.org>; Thu, 25 Aug 2022 07:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=NVKf+yK6wLyGnLnegNanhMySNn9KuistQtT+FYZUL+Y=;
        b=NlWIDo+dvAWBAX7m59A9WK7XK/ksuO453d211ZSVC1usS96qle+ElUHat+9hfTOQXa
         tbsqMeiv4Wsj30NWJSoNzmmFtxt7hSHxxkeaVK5RF1vEkXfptWB4rxDVFztehLUNPv1d
         j2uOug+WeRsHeI/SpDCVohyYDTo5E12wp5+0ri5GQDliKDpHCNmARDk2LVtqirwjPh3M
         XfnroLYpaN3AgW4DNLHracYTjeLhybolJoSgym6bMP9i9rQpPwpluevYRkaPPjtXeXQa
         PAVZbpB3N7Oqj+exhIseCeq1ZNpprG5zAnx85yxqe81TytZGMCqxTafATIYdT75WSMmE
         2e6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=NVKf+yK6wLyGnLnegNanhMySNn9KuistQtT+FYZUL+Y=;
        b=1LiyFtfcMVTxX+Fa59IJ4kM8YXEDnaSyZu3kfxImumoJW7hEx5TsqXYG9x5jYwV9cY
         D8oUvqsqmAtJ/qsy869rK4Cd/S6NpUzmYmF96PLM8KppJWRyytCMNeuUYp87QDc97mya
         Wme7z9hIoI4tMLQCd3AcVu1UXecCSHKK26Uzh4d1CF6bje8LNmelLc9rwoOeSQ9YwBEY
         /yC24GLFVIgFBa0bR0stp2vtvBNBsVOfHcd0o1Q4wdqngr8Vf7j+xBxqGm39GPNuIXQF
         04h60PvSBkMyXBy/ZS976oTcJBu0FNJVnGZKVFshAz3ovo/cBf+Y2M6YMjoBtpFQc5d0
         VLiA==
X-Gm-Message-State: ACgBeo3cv1pCZfUAxIBp3n8tlKml2XtrHABApBUUX+Ax214yIrfqvoTU
        yM3r/M2or1NxW5xzzefwSUkS5YNGA1TiiyWqg6+VQ208apOtiQ==
X-Google-Smtp-Source: AA6agR4YJfMjZa/owghKOmgRQKWWg/pLMq27SJQBgJj6RAuvOdn93CyPxD3WG+8eatFHPwIj8EzgcdZZZ2LzizGGUog=
X-Received: by 2002:a05:6402:32a7:b0:446:e17f:111c with SMTP id
 f39-20020a05640232a700b00446e17f111cmr3607595eda.95.1661438999820; Thu, 25
 Aug 2022 07:49:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220823145005.26356-1-suwan.kim027@gmail.com>
 <YwU/EVxT0a6q2BfD@fedora> <CAFNWusaXc3H78kx1wxUDLht3PuV0A_VxvdmmY-yMJNefvih-1Q@mail.gmail.com>
 <YwZgqf5kMqKHwcxR@fedora>
In-Reply-To: <YwZgqf5kMqKHwcxR@fedora>
From:   Suwan Kim <suwan.kim027@gmail.com>
Date:   Thu, 25 Aug 2022 23:49:48 +0900
Message-ID: <CAFNWusbESeNm6f7wqvUpEhu9HYxN=FgzmBBBx3m0UvRXvzjqDQ@mail.gmail.com>
Subject: Re: [PATCH] virtio-blk: Fix WARN_ON_ONCE in virtio_queue_rq()
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     mst@redhat.com, jasowang@redhat.com, pbonzini@redhat.com,
        acourbot@chromium.org, linux-block@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Aug 25, 2022 at 2:32 AM Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> On Wed, Aug 24, 2022 at 10:16:10PM +0900, Kim Suwan wrote:
> > Hi Stefan,
> >
> > On Wed, Aug 24, 2022 at 5:56 AM Stefan Hajnoczi <stefanha@redhat.com> wrote:
> > >
> > > On Tue, Aug 23, 2022 at 11:50:05PM +0900, Suwan Kim wrote:
> > > > @@ -409,6 +409,8 @@ static bool virtblk_add_req_batch(struct virtio_blk_vq *vq,
> > > >                       virtblk_unmap_data(req, vbr);
> > > >                       virtblk_cleanup_cmd(req);
> > > >                       rq_list_add(requeue_list, req);
> > > > +             } else {
> > > > +                     blk_mq_start_request(req);
> > > >               }
> > >
> > > The device may see new requests as soon as virtblk_add_req() is called
> > > above. Therefore the device may complete the request before
> > > blk_mq_start_request() is called.
> > >
> > > rq->io_start_time_ns = ktime_get_ns() will be after the request was
> > > actually submitted.
> > >
> > > I think blk_mq_start_request() needs to be called before
> > > virtblk_add_req().
> > >
> >
> > But if blk_mq_start_request() is called before virtblk_add_req()
> > and virtblk_add_req() fails, it can trigger WARN_ON_ONCE() at
> > virtio_queue_rq().
> >
> > With regard to the race condition between virtblk_add_req() and
> > completion, I think that the race condition can not happen because
> > virtblk_add_req() holds vq lock with irq saving and completion side
> > (virtblk_done, virtblk_poll) need to acquire the vq lock also.
> > Moreover, virtblk_done() is irq context so I think it can not be
> > executed until virtblk_add_req() releases the lock.
>
> I agree there is no race condition regarding the ordering of
> blk_mq_start_request() and request completion. The spinlock prevents
> that and I wasn't concerned about that part.
>
> The issue is that the timestamp will be garbage. If we capture the
> timestamp during/after the request is executing, then the collected
> statistics will be wrong.
>
> Can you look for another solution that doesn't break the timestamp?
>
> FWIW I see that the rq->state state machine allows returning to the idle
> state once the request has been started: __blk_mq_requeue_request().

I considered blk_mq_requeue_request() to handle error cases but
I didn't use it because I think it can make the error path request
processing slower than requeuing an error request to plug list again.

But there doesn't seem to be any other option that doesn't break
the timestamp.

As you said, I will use __blk_mq_requeue_request() and send
new patch soon.

To Alexandre,

I will share new diff soon. Could you please test one more time?

Regards,
Suwan Kim
