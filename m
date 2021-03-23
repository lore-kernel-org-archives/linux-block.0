Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D71E9C433DB
	for <linux-block@archiver.kernel.org>; Tue, 23 Mar 2021 12:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89B116191C
	for <linux-block@archiver.kernel.org>; Tue, 23 Mar 2021 12:02:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbhCWMBb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Mar 2021 08:01:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23323 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230288AbhCWMBU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Mar 2021 08:01:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616500880;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/E56JGzD0drALGlO+o9rr+izqRkHc0omx211/69utNM=;
        b=TAQ1gPkS9pDKHsfKq/LOExo80B1ziSek6xVAicDqqnq1AdJsbFyRmINKpmNFLPKf4FhYQw
        XScdUH3fZNIImSSiQ+RrX4r3MCt/mc3R5EvVoGkC3JT0WRPhdAlugwCS+dJXwAFKAs5QKT
        E9JHZqmBs/A96XHwfa77g0IRgmLQryw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-443-dV6XP-FQPOWCORlmG3sMRg-1; Tue, 23 Mar 2021 08:01:18 -0400
X-MC-Unique: dV6XP-FQPOWCORlmG3sMRg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9932A83DD28;
        Tue, 23 Mar 2021 12:01:16 +0000 (UTC)
Received: from T590 (ovpn-13-171.pek2.redhat.com [10.72.13.171])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 61DC85D9F0;
        Tue, 23 Mar 2021 12:01:12 +0000 (UTC)
Date:   Tue, 23 Mar 2021 20:01:08 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com
Subject: Re: [RFC PATCH V2 09/13] block: use per-task poll context to
 implement bio based io poll
Message-ID: <YFnYhBIiFhiyX8Wb@T590>
References: <20210318164827.1481133-1-ming.lei@redhat.com>
 <20210318164827.1481133-10-ming.lei@redhat.com>
 <522a2c87-e9f3-e62a-e09b-084821c698a0@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <522a2c87-e9f3-e62a-e09b-084821c698a0@grimberg.me>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 22, 2021 at 08:46:04PM -0700, Sagi Grimberg wrote:
> 
> > +static void blk_bio_poll_post_submit(struct bio *bio, blk_qc_t cookie)
> > +{
> > +	bio->bi_iter.bi_private_data = cookie;
> > +}
> > +
> 
> Hey Ming, thinking about nvme-mpath, I'm thinking that this should be
> an exported function for failover. nvme-mpath updates bio.bi_dev
> when re-submitting I/Os to an alternate path, so I'm thinking
> that if this function is exported then nvme-mpath could do as little
> as the below to allow polling?
> 
> --
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 92adebfaf86f..e562e296153b 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -345,6 +345,7 @@ static void nvme_requeue_work(struct work_struct *work)
>         struct nvme_ns_head *head =
>                 container_of(work, struct nvme_ns_head, requeue_work);
>         struct bio *bio, *next;
> +       blk_qc_t cookie;
> 
>         spin_lock_irq(&head->requeue_lock);
>         next = bio_list_get(&head->requeue_list);
> @@ -359,7 +360,8 @@ static void nvme_requeue_work(struct work_struct *work)
>                  * path.
>                  */
>                 bio_set_dev(bio, head->disk->part0);
> -               submit_bio_noacct(bio);
> +               cookie = submit_bio_noacct(bio);
> +               blk_bio_poll_post_submit(bio, cookie);
>         }
>  }
> --
> 
> I/O failover will create misalignment from the polling context cpu and
> the submission cpu (running requeue_work), but I don't see if there is
> something that would break here...

I understand requeue shouldn't be one usual event, and I guess it is just
fine to fallback to IRQ based mode?

This patchset actually doesn't cover such bio submission from kernel context.

-- 
Ming

