Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76792C433ED
	for <linux-block@archiver.kernel.org>; Tue,  4 May 2021 07:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 424AA611CB
	for <linux-block@archiver.kernel.org>; Tue,  4 May 2021 07:29:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbhEDHaf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 May 2021 03:30:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20742 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229607AbhEDHae (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 4 May 2021 03:30:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620113380;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EWr6gsC5qADDiQYYPg2fD6vVefc5Po56DpnCBdNM/7A=;
        b=GHlI3YJrDeWno7jXXT36q2GTt/uOxm0mvb9WM3jQGPRevwm5mSZ96a/kT9o2NZm9LEQB2r
        OKbgzWoKhuWh/p6or0cRZ+81VS8bYPe1cIchajyKoMsmCGKE94gJuYqe8r1WIwQ018XJG0
        IY7/B2mxBiXnC53R2BedJFW+Ul0qcxk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-458-NBwn1mh9Mh-_oI_8pKvq7w-1; Tue, 04 May 2021 03:29:36 -0400
X-MC-Unique: NBwn1mh9Mh-_oI_8pKvq7w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D68A5800D62;
        Tue,  4 May 2021 07:29:34 +0000 (UTC)
Received: from T590 (ovpn-12-77.pek2.redhat.com [10.72.12.77])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A6A6060C5C;
        Tue,  4 May 2021 07:29:27 +0000 (UTC)
Date:   Tue, 4 May 2021 15:29:22 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Khazhy Kumykov <khazhy@google.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        John Garry <john.garry@huawei.com>,
        David Jeffery <djeffery@redhat.com>
Subject: Re: [PATCH V4 0/4] blk-mq: fix request UAF related with iterating
 over tagset requests
Message-ID: <YJD30thBPeqUIQ2L@T590>
References: <20210429023458.3044317-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210429023458.3044317-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Apr 29, 2021 at 10:34:54AM +0800, Ming Lei wrote:
> Hi Jens,
> 
> This patchset fixes the request UAF issue by one simple approach,
> without clearing ->rqs[] in fast path.
> 
> 1) grab request's ref before calling ->fn in blk_mq_tagset_busy_iter,
> and release it after calling ->fn, so ->fn won't be called for one
> request if its queue is frozen, done in 2st patch
> 
> 2) clearing any stale request referred in ->rqs[] before freeing the
> request pool, one per-tags spinlock is added for protecting
> grabbing request ref vs. clearing ->rqs[tag], so UAF by refcount_inc_not_zero
> in bt_tags_iter() is avoided, done in 3rd patch.
> 
> 
> V4:
> 	- remove hctx->fq-flush_rq from tags->rqs[] before freeing hw queue,
> 	patch 4/4 is added, which is based on David's patch.

Hello Jens,

Any chance to merge the patch to 5.13 if you are fine?


Thanks,
Ming

