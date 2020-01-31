Return-Path: <SRS0=MKaG=3U=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C20F2C2D0DB
	for <linux-block@archiver.kernel.org>; Fri, 31 Jan 2020 18:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8522320CC7
	for <linux-block@archiver.kernel.org>; Fri, 31 Jan 2020 18:55:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UPdIaX79"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbgAaSz0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 31 Jan 2020 13:55:26 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24447 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726206AbgAaSzZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 31 Jan 2020 13:55:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580496924;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w2rV2BA1+1IGal85Q1s+XQYGsNIEhFhkKtDX3+nUFqU=;
        b=UPdIaX79wFYlJ6Xn51DckDhMaGewy36uv8Twxvx2WdQGK4VsloB22l29rNVhapsaR585A4
        zcehSLToTR3d6eYcCqMiLv2B9bgyL44LB3DqOxw4SgVeWHkZws4T/u1cATT6YexGig5+k9
        gambloYgNhRSAXIug3ZXl87xZiZi3vM=
Received: from mail-yw1-f72.google.com (mail-yw1-f72.google.com
 [209.85.161.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-349-AVxiLAhqPy2Xw9QTBweeQQ-1; Fri, 31 Jan 2020 13:55:16 -0500
X-MC-Unique: AVxiLAhqPy2Xw9QTBweeQQ-1
Received: by mail-yw1-f72.google.com with SMTP id 199so8978416ywe.20
        for <linux-block@vger.kernel.org>; Fri, 31 Jan 2020 10:55:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w2rV2BA1+1IGal85Q1s+XQYGsNIEhFhkKtDX3+nUFqU=;
        b=TnaH6rkQvmWXr7zROCwEV10zNvE4oEkcLclVJ57Hae0hPb9ZqjgssAeYWlaxXqIBAh
         lzWI9Axl7JYXQCbkbsQBe7FwmqsT8Up4yRmy66z9lYwYkrpkvh4Uw7YouTWaqbUP6pL+
         XZIEwprxHheUPnJ9tE3mU2Pq3sJxbsXF83yfAFB7SEN7P51IJyoJy4giApGMz6oNhFlz
         vl33WtxmnA6Zf8eG3Qbdrq6aktD5WI0WP+VSrlsw4tXEf0zjuT1b+wJjA3EKqtDp3ByD
         hfb+0zcPijnsoKykfg7+3iKDGnNMxsvER5KRgT/oXB9b5t34vB54RHlYM0HtzBV82AOL
         8QEA==
X-Gm-Message-State: APjAAAXV21W9Qlwu9NtgJzwmA0bQzRVVeUUOP0/6a9QkScIWWVSiS2cq
        CFkTqpPSGK2y7yA+2GMyUMuvjk23ki4iNRUZ5h6xnLODXu39CwGloK/stkKhQvYnjQn6ycM4jnw
        Aa4u7VhP/vX9itlfv4l7x47M=
X-Received: by 2002:a81:980e:: with SMTP id p14mr9471978ywg.24.1580496915409;
        Fri, 31 Jan 2020 10:55:15 -0800 (PST)
X-Google-Smtp-Source: APXvYqyvlTSP0I/IRYryro4c+hTqkfmh4iUjiVfSrvBDV9PHzuBLgbIcQZ0TXk+bC9jfe+hwRw5kEg==
X-Received: by 2002:a81:980e:: with SMTP id p14mr9471960ywg.24.1580496914940;
        Fri, 31 Jan 2020 10:55:14 -0800 (PST)
Received: from loberhel7laptop ([2600:6c64:4e80:f1:4a17:2cf9:6a8a:f150])
        by smtp.gmail.com with ESMTPSA id u185sm4430677ywf.89.2020.01.31.10.55.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Jan 2020 10:55:14 -0800 (PST)
Message-ID: <40db6804eeb24636cfafca405570526ac7aafad4.camel@redhat.com>
Subject: Re: [PATCH] rbd: lock object request list
From:   Laurence Oberman <loberman@redhat.com>
To:     Ilya Dryomov <idryomov@gmail.com>, Hannes Reinecke <hare@suse.de>
Cc:     Sage Weil <sage@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Ceph Development <ceph-devel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>
Date:   Fri, 31 Jan 2020 13:55:12 -0500
In-Reply-To: <CAOi1vP8U=vpFiKmbeheMKQiy6y_XfGBgCvLZF_OQbhz78x2iTg@mail.gmail.com>
References: <20200130114258.8482-1-hare@suse.de>
         <2fc165f5ad9ea0ec8a0878eabe800ca0af3e10b8.camel@redhat.com>
         <b786e9dd-02c1-e117-db92-aa3f50804bc7@suse.de>
         <CAOi1vP8U=vpFiKmbeheMKQiy6y_XfGBgCvLZF_OQbhz78x2iTg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-5.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 2020-01-31 at 10:50 +0100, Ilya Dryomov wrote:
> On Thu, Jan 30, 2020 at 4:39 PM Hannes Reinecke <hare@suse.de> wrote:
> > 
> > On 1/30/20 3:26 PM, Laurence Oberman wrote:
> > > On Thu, 2020-01-30 at 12:42 +0100, Hannes Reinecke wrote:
> > > > The object request list can be accessed from various contexts
> > > > so we need to lock it to avoid concurrent modifications and
> > > > random crashes.
> > > > 
> > > > Signed-off-by: Hannes Reinecke <hare@suse.de>
> > > > ---
> > > >  drivers/block/rbd.c | 31 ++++++++++++++++++++++++-------
> > > >  1 file changed, 24 insertions(+), 7 deletions(-)
> > > > 
> > > > diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> > > > index 5710b2a8609c..ddc170661607 100644
> > > > --- a/drivers/block/rbd.c
> > > > +++ b/drivers/block/rbd.c
> > > > @@ -344,6 +344,7 @@ struct rbd_img_request {
> > > > 
> > > >      struct list_head        lock_item;
> > > >      struct list_head        object_extents; /* obj_req.ex
> > > > structs */
> > > > +    struct mutex            object_mutex;
> > > > 
> > > >      struct mutex            state_mutex;
> > > >      struct pending_result   pending;
> > > > @@ -1664,6 +1665,7 @@ static struct rbd_img_request
> > > > *rbd_img_request_create(
> > > >      INIT_LIST_HEAD(&img_request->lock_item);
> > > >      INIT_LIST_HEAD(&img_request->object_extents);
> > > >      mutex_init(&img_request->state_mutex);
> > > > +    mutex_init(&img_request->object_mutex);
> > > >      kref_init(&img_request->kref);
> > > > 
> > > >      return img_request;
> > > > @@ -1680,8 +1682,10 @@ static void
> > > > rbd_img_request_destroy(struct
> > > > kref *kref)
> > > >      dout("%s: img %p\n", __func__, img_request);
> > > > 
> > > >      WARN_ON(!list_empty(&img_request->lock_item));
> > > > +    mutex_lock(&img_request->object_mutex);
> > > >      for_each_obj_request_safe(img_request, obj_request,
> > > > next_obj_request)
> > > >              rbd_img_obj_request_del(img_request, obj_request);
> > > > +    mutex_unlock(&img_request->object_mutex);
> > > > 
> > > >      if (img_request_layered_test(img_request)) {
> > > >              img_request_layered_clear(img_request);
> > > > @@ -2486,6 +2490,7 @@ static int __rbd_img_fill_request(struct
> > > > rbd_img_request *img_req)
> > > >      struct rbd_obj_request *obj_req, *next_obj_req;
> > > >      int ret;
> > > > 
> > > > +    mutex_lock(&img_req->object_mutex);
> > > >      for_each_obj_request_safe(img_req, obj_req, next_obj_req)
> > > > {
> > > >              switch (img_req->op_type) {
> > > >              case OBJ_OP_READ:
> > > > @@ -2510,7 +2515,7 @@ static int __rbd_img_fill_request(struct
> > > > rbd_img_request *img_req)
> > > >                      continue;
> > > >              }
> > > >      }
> > > > -
> > > > +    mutex_unlock(&img_req->object_mutex);
> > > >      img_req->state = RBD_IMG_START;
> > > >      return 0;
> > > >  }
> > > > @@ -2569,6 +2574,7 @@ static int
> > > > rbd_img_fill_request_nocopy(struct
> > > > rbd_img_request *img_req,
> > > >       * position in the provided bio (list) or bio_vec array.
> > > >       */
> > > >      fctx->iter = *fctx->pos;
> > > > +    mutex_lock(&img_req->object_mutex);
> > > >      for (i = 0; i < num_img_extents; i++) {
> > > >              ret = ceph_file_to_extents(&img_req->rbd_dev-
> > > > >layout,
> > > >                                         img_extents[i].fe_off,
> > > > @@ -2576,10 +2582,12 @@ static int
> > > > rbd_img_fill_request_nocopy(struct
> > > > rbd_img_request *img_req,
> > > >                                         &img_req-
> > > > >object_extents,
> > > >                                         alloc_object_extent,
> > > > img_req,
> > > >                                         fctx->set_pos_fn,
> > > > &fctx-
> > > > > iter);
> > > > 
> > > > -            if (ret)
> > > > +            if (ret) {
> > > > +                    mutex_unlock(&img_req->object_mutex);
> > > >                      return ret;
> > > > +            }
> > > >      }
> > > > -
> > > > +    mutex_unlock(&img_req->object_mutex);
> > > >      return __rbd_img_fill_request(img_req);
> > > >  }
> > > > 
> > > > @@ -2620,6 +2628,7 @@ static int rbd_img_fill_request(struct
> > > > rbd_img_request *img_req,
> > > >       * or bio_vec array because when mapped, those bio_vecs
> > > > can
> > > > straddle
> > > >       * stripe unit boundaries.
> > > >       */
> > > > +    mutex_lock(&img_req->object_mutex);
> > > >      fctx->iter = *fctx->pos;
> > > >      for (i = 0; i < num_img_extents; i++) {
> > > >              ret = ceph_file_to_extents(&rbd_dev->layout,
> > > > @@ -2629,15 +2638,17 @@ static int rbd_img_fill_request(struct
> > > > rbd_img_request *img_req,
> > > >                                         alloc_object_extent,
> > > > img_req,
> > > >                                         fctx->count_fn, &fctx-
> > > > > iter);
> > > > 
> > > >              if (ret)
> > > > -                    return ret;
> > > > +                    goto out_unlock;
> > > >      }
> > > > 
> > > >      for_each_obj_request(img_req, obj_req) {
> > > >              obj_req->bvec_pos.bvecs = kmalloc_array(obj_req-
> > > > > bvec_count,
> > > > 
> > > >                                            sizeof(*obj_req-
> > > > > bvec_pos.bvecs),
> > > > 
> > > >                                            GFP_NOIO);
> > > > -            if (!obj_req->bvec_pos.bvecs)
> > > > -                    return -ENOMEM;
> > > > +            if (!obj_req->bvec_pos.bvecs) {
> > > > +                    ret = -ENOMEM;
> > > > +                    goto out_unlock;
> > > > +            }
> > > >      }
> > > > 
> > > >      /*
> > > > @@ -2652,10 +2663,14 @@ static int rbd_img_fill_request(struct
> > > > rbd_img_request *img_req,
> > > >                                         &img_req-
> > > > >object_extents,
> > > >                                         fctx->copy_fn, &fctx-
> > > > >iter);
> > > >              if (ret)
> > > > -                    return ret;
> > > > +                    goto out_unlock;
> > > >      }
> > > > +    mutex_unlock(&img_req->object_mutex);
> > > > 
> > > >      return __rbd_img_fill_request(img_req);
> > > > +out_unlock:
> > > > +    mutex_unlock(&img_req->object_mutex);
> > > > +    return ret;
> > > >  }
> > > > 
> > > >  static int rbd_img_fill_nodata(struct rbd_img_request
> > > > *img_req,
> > > > @@ -3552,6 +3567,7 @@ static void
> > > > rbd_img_object_requests(struct
> > > > rbd_img_request *img_req)
> > > > 
> > > >      rbd_assert(!img_req->pending.result && !img_req-
> > > > > pending.num_pending);
> > > > 
> > > > +    mutex_lock(&img_req->object_mutex);
> > > >      for_each_obj_request(img_req, obj_req) {
> > > >              int result = 0;
> > > > 
> > > > @@ -3564,6 +3580,7 @@ static void
> > > > rbd_img_object_requests(struct
> > > > rbd_img_request *img_req)
> > > >                      img_req->pending.num_pending++;
> > > >              }
> > > >      }
> > > > +    mutex_unlock(&img_req->object_mutex);
> > > >  }
> > > > 
> > > >  static bool rbd_img_advance(struct rbd_img_request *img_req,
> > > > int
> > > > *result)
> > > 
> > > Looks good to me. Just wonder how we escaped this for so long.
> > > 
> > > Reviewed-by: Laurence Oberman <loberman@redhat.com>
> > > 
> > 
> > The whole state machine is utterly fragile.
> > I'll be posting a patchset to clean stuff up somewhat,
> > but it's still a beast.
> 
> What do you want me to do about this patch then?
> 
> > I'm rather surprised that it doesn't break more often ...
> 
> If you or Laurence saw it break, I would appreciate the details.
> 
> Thanks,
> 
>                 Ilya
> 

That is what I mentioned when I reviewed it.
While I understand Hannes's patch and it looked right to me, here in
support, I have not seen any reported cases of panics so was wondering
how it escaped me so far.

Regards
Laurence

