Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51DE0C2B9F4
	for <linux-block@archiver.kernel.org>; Thu, 17 Jun 2021 23:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E7DC613BA
	for <linux-block@archiver.kernel.org>; Thu, 17 Jun 2021 23:09:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232601AbhFQXL2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Jun 2021 19:11:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53001 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231800AbhFQXL2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Jun 2021 19:11:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623971359;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UsF9y5hoqwXneEcFpT1aHIm7J+GdYxUeqZjcU2Ndeg8=;
        b=gsp4ChLDvovSs/WUxB4CNDY6EOPJx8C/pVtKC5npCwpUGBAAEqWIxk90EgC0zDrahNRJmD
        +iTr3Uh6xBfYRypKazxCgqAe370H8jkZLyFJ5bv8mcKIano20G4xIvf71CreEEB9ddAyT3
        j87sAeTQxMGJ/48cpluNSVZDDtzHVsw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-8-BFgmqn1INEiVuJQRhGeIEQ-1; Thu, 17 Jun 2021 19:09:17 -0400
X-MC-Unique: BFgmqn1INEiVuJQRhGeIEQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DC7EB801B13;
        Thu, 17 Jun 2021 23:09:16 +0000 (UTC)
Received: from T590 (ovpn-12-22.pek2.redhat.com [10.72.12.22])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0C12C5C22A;
        Thu, 17 Jun 2021 23:09:03 +0000 (UTC)
Date:   Fri, 18 Jun 2021 07:08:59 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@redhat.com>
Cc:     linux-block@vger.kernel.org,
        Jeffle Xu <jefflexu@linux.alibaba.com>, dm-devel@redhat.com,
        Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Subject: Re: [RFC PATCH V2 3/3] dm: support bio polling
Message-ID: <YMvWC2vNCsnTkfrc@T590>
References: <20210617103549.930311-1-ming.lei@redhat.com>
 <20210617103549.930311-4-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210617103549.930311-4-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 17, 2021 at 06:35:49PM +0800, Ming Lei wrote:
> Support bio(REQ_POLLED) polling in the following approach:
> 
> 1) only support io polling on normal READ/WRITE, and other abnormal IOs
> still fallback on IRQ mode, so the target io is exactly inside the dm
> io.
> 
> 2) hold one refcnt on io->io_count after submitting this dm bio with
> REQ_POLLED
> 
> 3) support dm native bio splitting, any dm io instance associated with
> current bio will be added into one list which head is bio->bi_end_io
> which will be recovered before ending this bio
> 
> 4) implement .poll_bio() callback, call bio_poll() on the single target
> bio inside the dm io which is retrieved via bio->bi_bio_drv_data; call
> dec_pending() after the target io is done in .poll_bio()
> 
> 4) enable QUEUE_FLAG_POLL if all underlying queues enable QUEUE_FLAG_POLL,
> which is based on Jeffle's previous patch.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

...

> @@ -938,8 +945,12 @@ static void dec_pending(struct dm_io *io, blk_status_t error)
>  		end_io_acct(io);
>  		free_io(md, io);
>  
> -		if (io_error == BLK_STS_DM_REQUEUE)
> +		if (io_error == BLK_STS_DM_REQUEUE) {
> +			/* not poll any more in case of requeue */
> +			if (bio->bi_opf & REQ_POLLED)
> +				bio->bi_opf &= ~REQ_POLLED;

It becomes not necessary to clear REQ_POLLED before requeuing since
every dm_io is added into the hlist_head which is reused from
bio->bi_end_io, so all dm-io(include the one to be requeued) will be
polled.

Thanks,
Ming

