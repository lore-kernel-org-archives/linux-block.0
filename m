Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AFB4C0502A
	for <linux-block@archiver.kernel.org>; Mon, 29 Aug 2022 02:49:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbiH2CtD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 28 Aug 2022 22:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiH2CtC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 28 Aug 2022 22:49:02 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB08C3CBCC
        for <linux-block@vger.kernel.org>; Sun, 28 Aug 2022 19:49:01 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id c24so6481657pgg.11
        for <linux-block@vger.kernel.org>; Sun, 28 Aug 2022 19:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=2jx0mwW81FasX+Vweg9adU+37g1pOQYePNCrjzO4RNE=;
        b=HUPV40vG6ZiXKHxi3+dHm70BSwWJwuibuzCEAOfDv4bt9gA8SDvaEZVy5ErmbqCCaj
         O1LgrhP5HvMcPRGLfbOFs38q3ka0jH54xC9z1Dj8OwCrDiW9VVZu1viPuONpul1q+Qma
         atfbOqCiAeiI1cL3d7zj9kVQQ1Db9bzErWXJwyTOsNTFitr2zImk9rrooGGvKLCUlOV4
         +0pUSrFw8PEjjqmR5lUDiEyU5N/0e52Yana5bq8t/qQvyTYZ3lJgYz+rpY89ab4fBxEh
         S1bJSKv0EtHWJDWLzGy7E5/opxs0eNaFZSXCCztQI/Y4JHWzJ5VP4ynauurJv2BMIIc/
         wFCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=2jx0mwW81FasX+Vweg9adU+37g1pOQYePNCrjzO4RNE=;
        b=GmMaZGWs+CQNml+HRO8gb3Cgqzppc5HdBg/Dz6iYPsKh0P+g5DP7PfIdVorQRzN0fs
         uJUSehTfgGD+dChy2Jn8ra2YeqMb3vHmd/x6O4uzl8OYkMeQzzwsLIz52OMe2FAyIaQQ
         2hidJ8ePX2x6U7ysC39rRCUctdFOW9qI9qaJ3m8Mi8Q+70wMnllL0oyg/R8Mi3gqsXNu
         dybnzk1e2qTzHz5WI+8luQIzYBZY0rT+gbfbTYB3lALf1qyGWuPEYTqkpDiuhtugYzbH
         +SNT2E126aYMKL6Y6AjXHOjzd0E4tLEVd51m3R3cy5MwOqaCshDvpmtO48sZ0p3kl17v
         1mjA==
X-Gm-Message-State: ACgBeo3iuW0EZgi+xMK3g28cLU//PogE5AbLN4Z5PgIdB8M3FEgbkaEb
        5Xp9+VxNZPl/MAMUw7pcTL0=
X-Google-Smtp-Source: AA6agR5lDFFaGB75bvCA5Uv26Wy3nwGeiTZJppyTi4faLKw5owYeYfBk00XPUbZl+3w6xw/E0P59iw==
X-Received: by 2002:a05:6a00:15cb:b0:52e:6100:e7a7 with SMTP id o11-20020a056a0015cb00b0052e6100e7a7mr14247760pfu.23.1661741341344;
        Sun, 28 Aug 2022 19:49:01 -0700 (PDT)
Received: from localhost.localdomain ([114.200.4.15])
        by smtp.gmail.com with ESMTPSA id l64-20020a622543000000b00537b1aa9191sm6113008pfl.178.2022.08.28.19.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Aug 2022 19:49:00 -0700 (PDT)
Date:   Mon, 29 Aug 2022 11:48:36 +0900
From:   Suwan Kim <suwan.kim027@gmail.com>
To:     Alexandre Courbot <acourbot@chromium.org>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, jasowang@redhat.com,
        pbonzini@redhat.com, linux-block@vger.kernel.org,
        virtualization <virtualization@lists.linux-foundation.org>,
        suwan.kim027@gmail.com
Subject: Re: [PATCH] virtio-blk: Fix WARN_ON_ONCE in virtio_queue_rq()
Message-ID: <YwwpBBQgLMqFjoPb@localhost.localdomain>
References: <20220823145005.26356-1-suwan.kim027@gmail.com>
 <YwU/EVxT0a6q2BfD@fedora>
 <CAFNWusaXc3H78kx1wxUDLht3PuV0A_VxvdmmY-yMJNefvih-1Q@mail.gmail.com>
 <YwZgqf5kMqKHwcxR@fedora>
 <CAFNWusbESeNm6f7wqvUpEhu9HYxN=FgzmBBBx3m0UvRXvzjqDQ@mail.gmail.com>
 <CAPBb6MUOP9j_Zd4tu0=rLKu2T3w6h-XhSOkU_ei70vJywHcPqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPBb6MUOP9j_Zd4tu0=rLKu2T3w6h-XhSOkU_ei70vJywHcPqA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Aug 26, 2022 at 10:41:39AM +0900, Alexandre Courbot wrote:
> On Thu, Aug 25, 2022 at 11:50 PM Suwan Kim <suwan.kim027@gmail.com> wrote:
> >
> > On Thu, Aug 25, 2022 at 2:32 AM Stefan Hajnoczi <stefanha@redhat.com> wrote:
> > >
> > > On Wed, Aug 24, 2022 at 10:16:10PM +0900, Kim Suwan wrote:
> > > > Hi Stefan,
> > > >
> > > > On Wed, Aug 24, 2022 at 5:56 AM Stefan Hajnoczi <stefanha@redhat.com> wrote:
> > > > >
> > > > > On Tue, Aug 23, 2022 at 11:50:05PM +0900, Suwan Kim wrote:
> > > > > > @@ -409,6 +409,8 @@ static bool virtblk_add_req_batch(struct virtio_blk_vq *vq,
> > > > > >                       virtblk_unmap_data(req, vbr);
> > > > > >                       virtblk_cleanup_cmd(req);
> > > > > >                       rq_list_add(requeue_list, req);
> > > > > > +             } else {
> > > > > > +                     blk_mq_start_request(req);
> > > > > >               }
> > > > >
> > > > > The device may see new requests as soon as virtblk_add_req() is called
> > > > > above. Therefore the device may complete the request before
> > > > > blk_mq_start_request() is called.
> > > > >
> > > > > rq->io_start_time_ns = ktime_get_ns() will be after the request was
> > > > > actually submitted.
> > > > >
> > > > > I think blk_mq_start_request() needs to be called before
> > > > > virtblk_add_req().
> > > > >
> > > >
> > > > But if blk_mq_start_request() is called before virtblk_add_req()
> > > > and virtblk_add_req() fails, it can trigger WARN_ON_ONCE() at
> > > > virtio_queue_rq().
> > > >
> > > > With regard to the race condition between virtblk_add_req() and
> > > > completion, I think that the race condition can not happen because
> > > > virtblk_add_req() holds vq lock with irq saving and completion side
> > > > (virtblk_done, virtblk_poll) need to acquire the vq lock also.
> > > > Moreover, virtblk_done() is irq context so I think it can not be
> > > > executed until virtblk_add_req() releases the lock.
> > >
> > > I agree there is no race condition regarding the ordering of
> > > blk_mq_start_request() and request completion. The spinlock prevents
> > > that and I wasn't concerned about that part.
> > >
> > > The issue is that the timestamp will be garbage. If we capture the
> > > timestamp during/after the request is executing, then the collected
> > > statistics will be wrong.
> > >
> > > Can you look for another solution that doesn't break the timestamp?
> > >
> > > FWIW I see that the rq->state state machine allows returning to the idle
> > > state once the request has been started: __blk_mq_requeue_request().
> >
> > I considered blk_mq_requeue_request() to handle error cases but
> > I didn't use it because I think it can make the error path request
> > processing slower than requeuing an error request to plug list again.
> >
> > But there doesn't seem to be any other option that doesn't break
> > the timestamp.
> >
> > As you said, I will use __blk_mq_requeue_request() and send
> > new patch soon.
> >
> > To Alexandre,
> >
> > I will share new diff soon. Could you please test one more time?
> 
> Absolutely! Thanks for looking into this.

Hi Alexandre,

Could you test this path?
If it works, I will send v2 patch.

Regards,
Suwan Kim

---

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 30255fcaf181..dd9a05174726 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -322,14 +322,14 @@ static blk_status_t virtblk_prep_rq(struct blk_mq_hw_ctx *hctx,
        if (unlikely(status))
                return status;

-       blk_mq_start_request(req);
-
        vbr->sg_table.nents = virtblk_map_data(hctx, req, vbr);
        if (unlikely(vbr->sg_table.nents < 0)) {
                virtblk_cleanup_cmd(req);
                return BLK_STS_RESOURCE;
        }

+       blk_mq_start_request(req);
+
        return BLK_STS_OK;
 }

@@ -391,8 +391,7 @@ static bool virtblk_prep_rq_batch(struct request *req)
 }

 static bool virtblk_add_req_batch(struct virtio_blk_vq *vq,
-                                       struct request **rqlist,
-                                       struct request **requeue_list)
+                                       struct request **rqlist)
 {
        unsigned long flags;
        int err;
@@ -408,7 +407,7 @@ static bool virtblk_add_req_batch(struct virtio_blk_vq *vq,
                if (err) {
                        virtblk_unmap_data(req, vbr);
                        virtblk_cleanup_cmd(req);
-                       rq_list_add(requeue_list, req);
+                       blk_mq_requeue_request(req, true);
                }
        }

@@ -436,7 +435,7 @@ static void virtio_queue_rqs(struct request **rqlist)

                if (!next || req->mq_hctx != next->mq_hctx) {
                        req->rq_next = NULL;
-                       kick = virtblk_add_req_batch(vq, rqlist, &requeue_list);
+                       kick = virtblk_add_req_batch(vq, rqlist);
                        if (kick)
                                virtqueue_notify(vq->vq);


