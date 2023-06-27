Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56874EB64D9
	for <linux-block@archiver.kernel.org>; Tue, 27 Jun 2023 01:07:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjF0BHr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Jun 2023 21:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjF0BHl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Jun 2023 21:07:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80CE3E6F
        for <linux-block@vger.kernel.org>; Mon, 26 Jun 2023 18:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687828013;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z/QuhCgLfQ0cTt2LHBXFiBZJEoF4b33bRGUoQqh3ooM=;
        b=WbKIZlziyQf/8JbrKle2qI1VEeB5fhcg/BwnkusaihS3m7KcWrkz2XF0qenH94qaPAXCPP
        31iKq7PU1vMw3uzqCR1lEQMfmibtk03470MRmxd34EInRA6skt3Pl8R4P7uSliF2kySygq
        io1U5cT9Q/4Ps6MtqBY1S7weCjyn4CE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-192-FzCbmDjdOSejNpJC3HERSg-1; Mon, 26 Jun 2023 21:06:48 -0400
X-MC-Unique: FzCbmDjdOSejNpJC3HERSg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F0B3F1C03DA9;
        Tue, 27 Jun 2023 01:06:47 +0000 (UTC)
Received: from ovpn-8-21.pek2.redhat.com (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2B1F8492B01;
        Tue, 27 Jun 2023 01:06:37 +0000 (UTC)
Date:   Tue, 27 Jun 2023 09:06:33 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Mike Snitzer <snitzer@kernel.org>
Subject: Re: [PATCH v4 4/7] block: One requeue list per hctx
Message-ID: <ZJo2GfthBQ4QaJ+x@ovpn-8-21.pek2.redhat.com>
References: <20230621201237.796902-1-bvanassche@acm.org>
 <20230621201237.796902-5-bvanassche@acm.org>
 <ZJlHtQySAAVYLbNy@ovpn-8-20.pek2.redhat.com>
 <79a4bb66-31b5-f383-020c-952541653608@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79a4bb66-31b5-f383-020c-952541653608@acm.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jun 26, 2023 at 09:54:01AM -0700, Bart Van Assche wrote:
> On 6/26/23 01:09, Ming Lei wrote:
> > On Wed, Jun 21, 2023 at 01:12:31PM -0700, Bart Van Assche wrote:
> > > Prepare for processing the requeue list from inside __blk_mq_run_hw_queue().
> > 
> > Please add more details about the motivation for this kind of change.
> > 
> > IMO requeue is supposed to be run in slow code path, not see reason why
> > it has to be moved to hw queue level.
> 
> As Damien explained, the code for sending requeued requests to the I/O
> scheduler should be dropped because this is not necessary in order to
> prevent reordering of requeued zoned writes.
> 
> The remaining advantages of this patch series are:
> * Simplification of the block layer API since the
>   blk_mq_{,delay_}kick_requeue_list() functions are removed.
> * Faster requeuing. Although I don't have any use case that needs
>   faster requeuing, it is interesting to see that this patch series
>   makes the blktest test that tests requeuing run twice as fast.

Not sure if it is good, cause requeue is supposed to be slow.

> 
> Is there agreement to proceed with this patch series if all review
> comments are addressed?

One concern is that you added requeue stuff into hctx, which may
add one extra L1 cache fetch in fast path.


Thank,
Ming

