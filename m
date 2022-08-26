Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9242AECAAA3
	for <linux-block@archiver.kernel.org>; Fri, 26 Aug 2022 01:41:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbiHZBl4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Aug 2022 21:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244405AbiHZBlz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Aug 2022 21:41:55 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C491B2DB5
        for <linux-block@vger.kernel.org>; Thu, 25 Aug 2022 18:41:53 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id cb8so333114qtb.0
        for <linux-block@vger.kernel.org>; Thu, 25 Aug 2022 18:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=xqUSge3GltL7hMvYfNTmVzGZjAXw2C9lysy6WWTZt+8=;
        b=AsOLSnuoFJCAHyf0Onfm9v+Ksctp8nyH5reY1vgwgobUxLoOwPm+q1JUoRC0bFN597
         jgWIDsDnXRDqbk6E0+ctNhXsNGN2fLf46rOqm9S7tg9Q2jrlJPUF0jjCZjqLmqhCRVX3
         3JBudBSDn4J5jo6shbflX5DXFUIHY2UdlI2QE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=xqUSge3GltL7hMvYfNTmVzGZjAXw2C9lysy6WWTZt+8=;
        b=RrJT/UzEMRXpv1+v89RiMXYvbomEbdVqSJKSLEJklzkqvPukntUE4sR8Ui4/EUMZ5r
         04R3ma8AIUBT3OJkvtuXmZAjZ6uma5ZAU/XRpERb0R+V9oMaxUPwAVKmjtfBRGEwiM6t
         dnNITgQFo2YJ+r/tijPazSYc9WdlDRo6+UQHc0EqsrB/hflf1cWV9wm52pHnsU4cXmiv
         bClvHUhLPaA1Fl+/cmkBKqyIYmjllJZcli7L+wDTMRwgZGE+pnyHQVEWlO/UFgUScM7s
         ikDMTUIFjoUIthTiDZFC6voyIykW/bxHjBGEPVbpZDR9T5g6Qe8fAB3SPqmXkoDGlPfG
         xftg==
X-Gm-Message-State: ACgBeo13xWcJYztcr9vKOmbCBHjFQHw1cO4k0K081+pto6eH9WW9Yzm+
        jcg+kiOZJJAPe1qXxeGoWYyRTA9n9s+0ZQ==
X-Google-Smtp-Source: AA6agR7T9qtI95hgsW9wMhJxWMVFbH2J3m+POh5PMxtQNq3GeqqdLQyBL8TwGwZDPY7YuqweIWAEKA==
X-Received: by 2002:a05:622a:1a92:b0:344:6866:b701 with SMTP id s18-20020a05622a1a9200b003446866b701mr6235389qtc.310.1661478112242;
        Thu, 25 Aug 2022 18:41:52 -0700 (PDT)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com. [209.85.128.181])
        by smtp.gmail.com with ESMTPSA id e64-20020a376943000000b006bc192d277csm730889qkc.10.2022.08.25.18.41.51
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Aug 2022 18:41:51 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-334dc616f86so2081787b3.8
        for <linux-block@vger.kernel.org>; Thu, 25 Aug 2022 18:41:51 -0700 (PDT)
X-Received: by 2002:a25:7616:0:b0:695:9024:1c23 with SMTP id
 r22-20020a257616000000b0069590241c23mr5722032ybc.177.1661478110731; Thu, 25
 Aug 2022 18:41:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220823145005.26356-1-suwan.kim027@gmail.com>
 <YwU/EVxT0a6q2BfD@fedora> <CAFNWusaXc3H78kx1wxUDLht3PuV0A_VxvdmmY-yMJNefvih-1Q@mail.gmail.com>
 <YwZgqf5kMqKHwcxR@fedora> <CAFNWusbESeNm6f7wqvUpEhu9HYxN=FgzmBBBx3m0UvRXvzjqDQ@mail.gmail.com>
In-Reply-To: <CAFNWusbESeNm6f7wqvUpEhu9HYxN=FgzmBBBx3m0UvRXvzjqDQ@mail.gmail.com>
From:   Alexandre Courbot <acourbot@chromium.org>
Date:   Fri, 26 Aug 2022 10:41:39 +0900
X-Gmail-Original-Message-ID: <CAPBb6MUOP9j_Zd4tu0=rLKu2T3w6h-XhSOkU_ei70vJywHcPqA@mail.gmail.com>
Message-ID: <CAPBb6MUOP9j_Zd4tu0=rLKu2T3w6h-XhSOkU_ei70vJywHcPqA@mail.gmail.com>
Subject: Re: [PATCH] virtio-blk: Fix WARN_ON_ONCE in virtio_queue_rq()
To:     Suwan Kim <suwan.kim027@gmail.com>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, jasowang@redhat.com,
        pbonzini@redhat.com, linux-block@vger.kernel.org,
        virtualization <virtualization@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Aug 25, 2022 at 11:50 PM Suwan Kim <suwan.kim027@gmail.com> wrote:
>
> On Thu, Aug 25, 2022 at 2:32 AM Stefan Hajnoczi <stefanha@redhat.com> wrote:
> >
> > On Wed, Aug 24, 2022 at 10:16:10PM +0900, Kim Suwan wrote:
> > > Hi Stefan,
> > >
> > > On Wed, Aug 24, 2022 at 5:56 AM Stefan Hajnoczi <stefanha@redhat.com> wrote:
> > > >
> > > > On Tue, Aug 23, 2022 at 11:50:05PM +0900, Suwan Kim wrote:
> > > > > @@ -409,6 +409,8 @@ static bool virtblk_add_req_batch(struct virtio_blk_vq *vq,
> > > > >                       virtblk_unmap_data(req, vbr);
> > > > >                       virtblk_cleanup_cmd(req);
> > > > >                       rq_list_add(requeue_list, req);
> > > > > +             } else {
> > > > > +                     blk_mq_start_request(req);
> > > > >               }
> > > >
> > > > The device may see new requests as soon as virtblk_add_req() is called
> > > > above. Therefore the device may complete the request before
> > > > blk_mq_start_request() is called.
> > > >
> > > > rq->io_start_time_ns = ktime_get_ns() will be after the request was
> > > > actually submitted.
> > > >
> > > > I think blk_mq_start_request() needs to be called before
> > > > virtblk_add_req().
> > > >
> > >
> > > But if blk_mq_start_request() is called before virtblk_add_req()
> > > and virtblk_add_req() fails, it can trigger WARN_ON_ONCE() at
> > > virtio_queue_rq().
> > >
> > > With regard to the race condition between virtblk_add_req() and
> > > completion, I think that the race condition can not happen because
> > > virtblk_add_req() holds vq lock with irq saving and completion side
> > > (virtblk_done, virtblk_poll) need to acquire the vq lock also.
> > > Moreover, virtblk_done() is irq context so I think it can not be
> > > executed until virtblk_add_req() releases the lock.
> >
> > I agree there is no race condition regarding the ordering of
> > blk_mq_start_request() and request completion. The spinlock prevents
> > that and I wasn't concerned about that part.
> >
> > The issue is that the timestamp will be garbage. If we capture the
> > timestamp during/after the request is executing, then the collected
> > statistics will be wrong.
> >
> > Can you look for another solution that doesn't break the timestamp?
> >
> > FWIW I see that the rq->state state machine allows returning to the idle
> > state once the request has been started: __blk_mq_requeue_request().
>
> I considered blk_mq_requeue_request() to handle error cases but
> I didn't use it because I think it can make the error path request
> processing slower than requeuing an error request to plug list again.
>
> But there doesn't seem to be any other option that doesn't break
> the timestamp.
>
> As you said, I will use __blk_mq_requeue_request() and send
> new patch soon.
>
> To Alexandre,
>
> I will share new diff soon. Could you please test one more time?

Absolutely! Thanks for looking into this.
