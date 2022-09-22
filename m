Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 935AEC6FA82
	for <linux-block@archiver.kernel.org>; Thu, 22 Sep 2022 17:01:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbiIVRBb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Sep 2022 13:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbiIVRB3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Sep 2022 13:01:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 027C2F685F
        for <linux-block@vger.kernel.org>; Thu, 22 Sep 2022 10:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663866088;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=U9Sr8YICdCu6GQF/2wHQLM2nRHwhuk3bcum4Id2WWLU=;
        b=cufOzWEjBhgxzvnqAgGzpwxsUwpfswNH22V+nGpUJeb9Fd2J+0ToO6/lGCSiBeXhEuljZ1
        X5syWSu+jr4+hc9LkXN/puD1O6KTsJq2NmPrJ0WNYWjR3VGfEXhImJExUpppoZS7MvTUiq
        sOfogXXU3z4CAK2OZv5aFeaKlH7ymnA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-126-yVGiC3IfMDyYGT3J20zBww-1; Thu, 22 Sep 2022 13:01:26 -0400
X-MC-Unique: yVGiC3IfMDyYGT3J20zBww-1
Received: by mail-wm1-f70.google.com with SMTP id k21-20020a7bc415000000b003b4fac53006so982217wmi.3
        for <linux-block@vger.kernel.org>; Thu, 22 Sep 2022 10:01:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=U9Sr8YICdCu6GQF/2wHQLM2nRHwhuk3bcum4Id2WWLU=;
        b=njBIunwMlacqSItE8pU6oQmrjK9uupbNlqXHZ9EGPuzuVaBYO0/oEH17zRCy8WBGHl
         x5TfEkbDR05nxFvK9yFbIVQH/t/Z+uiff2+BH+Y8JEplc0YRBxrghynMwHSZyqVVofJQ
         X5K7C06QSr7m/eDjVU42dZgpUo5FxgJKBLW7BZzoCBNC+P0vcNNCogafe0ilkUaucku/
         GBJTVOeVlRdypMp+lJz8nMAhf7igBJBu8LXPTMUuURb6W9EgehfFkRAo8mRAHsOXz5vH
         0I7GlRI94Jda5DZRVniNVxz1mgXm+JdQW2V1ZTbTnvcfQwppSzIwEYjPVfLbpyZ2oD8S
         PzDw==
X-Gm-Message-State: ACrzQf0tlN5lwXcqD8NwCC6GxwvqDMMX+IKg9rqwZNfyIz4ipD8DV5CO
        PoSXkC50ZMuaWEjr7PvDGWqUEGog17LcCceJDpb4TRBKWAaZf0svrq/rYSdXyGwmxpuIkfOS7fG
        gHBVoGacmbuveR/lKp7YfyrM=
X-Received: by 2002:a5d:6388:0:b0:228:c792:aabe with SMTP id p8-20020a5d6388000000b00228c792aabemr2669938wru.689.1663866085185;
        Thu, 22 Sep 2022 10:01:25 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4sIQov4Lsx8/ngj+iGn4/VThzrMM0tkQAqwA6Ev7a1KO6j4dy1ldlQi7uOpVH6LWOm6CaapA==
X-Received: by 2002:a5d:6388:0:b0:228:c792:aabe with SMTP id p8-20020a5d6388000000b00228c792aabemr2669912wru.689.1663866084887;
        Thu, 22 Sep 2022 10:01:24 -0700 (PDT)
Received: from redhat.com ([2.55.16.18])
        by smtp.gmail.com with ESMTPSA id l18-20020a05600c27d200b003b4868eb6bbsm53966wmb.23.2022.09.22.10.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 10:01:24 -0700 (PDT)
Date:   Thu, 22 Sep 2022 13:01:19 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Suwan Kim <suwan.kim027@gmail.com>
Cc:     Pankaj Raghav <pankydev8@gmail.com>, jasowang@redhat.com,
        pbonzini@redhat.com, stefanha@redhat.com, acourbot@chromium.org,
        hch@infradead.org, linux-block@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v2] virtio-blk: Fix WARN_ON_ONCE in virtio_queue_rq()
Message-ID: <20220922130102-mutt-send-email-mst@kernel.org>
References: <20220830150153.12627-1-suwan.kim027@gmail.com>
 <20220831124441.ai5xratdpemiqmyv@quentin>
 <CAFNWusaxT38RyQBFZu6jN_kaL3p3hTQ0oXPQZkZdEJ3VjUMVWg@mail.gmail.com>
 <20220922125632-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922125632-mutt-send-email-mst@kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Sep 22, 2022 at 12:57:01PM -0400, Michael S. Tsirkin wrote:
> On Thu, Sep 22, 2022 at 11:45:15PM +0900, Suwan Kim wrote:
> > Hi Michael,
> > 
> > Can this patch be merged to the next rc?
> > We received two bug reports about this issue and need to fix it.
> > 
> > Regards,
> > Suwan Kim
> > 
> > 
> > On Wed, Aug 31, 2022 at 9:44 PM Pankaj Raghav <pankydev8@gmail.com> wrote:
> > >
> > > On Wed, Aug 31, 2022 at 12:01:53AM +0900, Suwan Kim wrote:
> > > > If a request fails at virtio_queue_rqs(), it is inserted to requeue_list
> > > > and passed to virtio_queue_rq(). Then blk_mq_start_request() can be called
> > > > again at virtio_queue_rq() and trigger WARN_ON_ONCE like below trace because
> > > > request state was already set to MQ_RQ_IN_FLIGHT in virtio_queue_rqs()
> > > > despite the failure.
> > > >
> > > > To avoid calling blk_mq_start_request() twice, This patch moves the
> > > > execution of blk_mq_start_request() to the end of virtblk_prep_rq().
> > > > And instead of requeuing failed request to plug list in the error path of
> > > > virtblk_add_req_batch(), it uses blk_mq_requeue_request() to change failed
> > > > request state to MQ_RQ_IDLE. Then virtblk can safely handle the request
> > > > on the next trial.
> > > >
> > > > Fixes: 0e9911fa768f ("virtio-blk: support mq_ops->queue_rqs()")
> > > > Reported-by: Alexandre Courbot <acourbot@chromium.org>
> > > > Tested-by: Alexandre Courbot <acourbot@chromium.org>
> > > > Signed-off-by: Suwan Kim <suwan.kim027@gmail.com>
> > > > ---
> > > Looks good.
> > > Reviewed-by: Pankaj Raghav <p.raghav@samsung.com>
> 
> Stefan, Paolo, any feedback here?

Oh, Stefan acked. Sorry. Will queue now.


> -- 
> MST

