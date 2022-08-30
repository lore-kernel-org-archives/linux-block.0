Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22050ECAAD4
	for <linux-block@archiver.kernel.org>; Tue, 30 Aug 2022 08:23:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbiH3IXr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Aug 2022 04:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231450AbiH3IXn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Aug 2022 04:23:43 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE82A1A47
        for <linux-block@vger.kernel.org>; Tue, 30 Aug 2022 01:23:42 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id g14so7960030qto.11
        for <linux-block@vger.kernel.org>; Tue, 30 Aug 2022 01:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=iG2MDDhdSYgIrpBsVIAmTk9O0AvGRQyN5exiSjwuI2Q=;
        b=deXmV7Zt/2Ide2qObYaHM1L0gqxU5AgrwIoKbVHZen4r02I2NjYH9ulif0tGufKGz3
         9YTDOfD1B6zxQBAf8kWLPh9HBCJEmC9UaZWNnfacLltKglUpBtQT221xDXXA2D1m1sbO
         K7xeJQZciLgFdiCJtUgOIRerDifi9t88tSbjM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=iG2MDDhdSYgIrpBsVIAmTk9O0AvGRQyN5exiSjwuI2Q=;
        b=kbYP6ITWIznZVPqxav+OkEkBnih+SKf50QH4OvbbM9X6qDDbaVGj9OKOBseRbLQB86
         FK8mQdkCzEPJgWsTW3JMKT0Ae2enO96Yo1OSH2xhI6AU9k76heTpixBN+A5fByU/+IdZ
         AwxqEf2W3HDrcN5CezwIadxJZpCvSzkUPwdGy7UaHnoXdXtSCe2uZuw3vjOWOepS3ZjI
         ZED8G/z51re7hsI63fSJeYsSesXaJuIO12CrzaxGKyemBreurXssad5Kucyw48pG5vq1
         G4GHx4lR++nKZDvPH9ecj8nCzZX6VW0xP0eDnLOXdUkuLk7lx9/fymv5wM9vM8+AVq+S
         uWBQ==
X-Gm-Message-State: ACgBeo0/AnuGFx8NiV8gDOWoLBxXV/YIWEfG14J0BgNLKdKc7r/gfw4c
        GTwbnTR+7s4/R1/1kXMjpirflDgLbMgRQpgz
X-Google-Smtp-Source: AA6agR7OtSrhvuR0VM7b/kYq/k69I+HOm7IoVezECw9J9f9jbcm7s6PTYHiDnljcT8bSuct3u/CCaw==
X-Received: by 2002:ac8:5f0d:0:b0:343:6e79:f1a2 with SMTP id x13-20020ac85f0d000000b003436e79f1a2mr13658681qta.657.1661847821088;
        Tue, 30 Aug 2022 01:23:41 -0700 (PDT)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id dt47-20020a05620a47af00b006b61b2cb1d2sm7534984qkb.46.2022.08.30.01.23.39
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 01:23:39 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-3321c2a8d4cso255064027b3.5
        for <linux-block@vger.kernel.org>; Tue, 30 Aug 2022 01:23:39 -0700 (PDT)
X-Received: by 2002:a05:6902:1243:b0:696:717b:81be with SMTP id
 t3-20020a056902124300b00696717b81bemr11217671ybu.170.1661847818800; Tue, 30
 Aug 2022 01:23:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220823145005.26356-1-suwan.kim027@gmail.com>
 <YwU/EVxT0a6q2BfD@fedora> <CAFNWusaXc3H78kx1wxUDLht3PuV0A_VxvdmmY-yMJNefvih-1Q@mail.gmail.com>
 <YwZgqf5kMqKHwcxR@fedora> <CAFNWusbESeNm6f7wqvUpEhu9HYxN=FgzmBBBx3m0UvRXvzjqDQ@mail.gmail.com>
 <CAPBb6MUOP9j_Zd4tu0=rLKu2T3w6h-XhSOkU_ei70vJywHcPqA@mail.gmail.com> <YwwpBBQgLMqFjoPb@localhost.localdomain>
In-Reply-To: <YwwpBBQgLMqFjoPb@localhost.localdomain>
From:   Alexandre Courbot <acourbot@chromium.org>
Date:   Tue, 30 Aug 2022 17:23:27 +0900
X-Gmail-Original-Message-ID: <CAPBb6MX5hAbjaBv=LwSEYvC3Xbh-hdxKChqj47o1EF1RwoWV7w@mail.gmail.com>
Message-ID: <CAPBb6MX5hAbjaBv=LwSEYvC3Xbh-hdxKChqj47o1EF1RwoWV7w@mail.gmail.com>
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

Hi Suwan,

On Mon, Aug 29, 2022 at 11:49 AM Suwan Kim <suwan.kim027@gmail.com> wrote:
>
> On Fri, Aug 26, 2022 at 10:41:39AM +0900, Alexandre Courbot wrote:
> > On Thu, Aug 25, 2022 at 11:50 PM Suwan Kim <suwan.kim027@gmail.com> wrote:
> > >
> > > On Thu, Aug 25, 2022 at 2:32 AM Stefan Hajnoczi <stefanha@redhat.com> wrote:
> > > >
> > > > On Wed, Aug 24, 2022 at 10:16:10PM +0900, Kim Suwan wrote:
> > > > > Hi Stefan,
> > > > >
> > > > > On Wed, Aug 24, 2022 at 5:56 AM Stefan Hajnoczi <stefanha@redhat.com> wrote:
> > > > > >
> > > > > > On Tue, Aug 23, 2022 at 11:50:05PM +0900, Suwan Kim wrote:
> > > > > > > @@ -409,6 +409,8 @@ static bool virtblk_add_req_batch(struct virtio_blk_vq *vq,
> > > > > > >                       virtblk_unmap_data(req, vbr);
> > > > > > >                       virtblk_cleanup_cmd(req);
> > > > > > >                       rq_list_add(requeue_list, req);
> > > > > > > +             } else {
> > > > > > > +                     blk_mq_start_request(req);
> > > > > > >               }
> > > > > >
> > > > > > The device may see new requests as soon as virtblk_add_req() is called
> > > > > > above. Therefore the device may complete the request before
> > > > > > blk_mq_start_request() is called.
> > > > > >
> > > > > > rq->io_start_time_ns = ktime_get_ns() will be after the request was
> > > > > > actually submitted.
> > > > > >
> > > > > > I think blk_mq_start_request() needs to be called before
> > > > > > virtblk_add_req().
> > > > > >
> > > > >
> > > > > But if blk_mq_start_request() is called before virtblk_add_req()
> > > > > and virtblk_add_req() fails, it can trigger WARN_ON_ONCE() at
> > > > > virtio_queue_rq().
> > > > >
> > > > > With regard to the race condition between virtblk_add_req() and
> > > > > completion, I think that the race condition can not happen because
> > > > > virtblk_add_req() holds vq lock with irq saving and completion side
> > > > > (virtblk_done, virtblk_poll) need to acquire the vq lock also.
> > > > > Moreover, virtblk_done() is irq context so I think it can not be
> > > > > executed until virtblk_add_req() releases the lock.
> > > >
> > > > I agree there is no race condition regarding the ordering of
> > > > blk_mq_start_request() and request completion. The spinlock prevents
> > > > that and I wasn't concerned about that part.
> > > >
> > > > The issue is that the timestamp will be garbage. If we capture the
> > > > timestamp during/after the request is executing, then the collected
> > > > statistics will be wrong.
> > > >
> > > > Can you look for another solution that doesn't break the timestamp?
> > > >
> > > > FWIW I see that the rq->state state machine allows returning to the idle
> > > > state once the request has been started: __blk_mq_requeue_request().
> > >
> > > I considered blk_mq_requeue_request() to handle error cases but
> > > I didn't use it because I think it can make the error path request
> > > processing slower than requeuing an error request to plug list again.
> > >
> > > But there doesn't seem to be any other option that doesn't break
> > > the timestamp.
> > >
> > > As you said, I will use __blk_mq_requeue_request() and send
> > > new patch soon.
> > >
> > > To Alexandre,
> > >
> > > I will share new diff soon. Could you please test one more time?
> >
> > Absolutely! Thanks for looking into this.
>
> Hi Alexandre,
>
> Could you test this path?
> If it works, I will send v2 patch.

This version is working fine for me!

Cheers,
Alex.
