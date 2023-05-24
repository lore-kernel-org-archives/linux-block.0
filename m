Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C079C77B7E
	for <linux-block@archiver.kernel.org>; Wed, 24 May 2023 00:36:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233264AbjEXAgI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 May 2023 20:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232594AbjEXAgI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 May 2023 20:36:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 668A6B5
        for <linux-block@vger.kernel.org>; Tue, 23 May 2023 17:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684888521;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T15nmRk3Z/5GrwgwuXc7V9cpBuFkNG7B+X8PST1FsC4=;
        b=ZO0C2kjGTiEgbA/vuRVV8uXMjWcmA6JAqTLDHd8602dEvQ/oa6vX46irUyGpuwhJ2NXz9q
        ziAORLY8eMu7AU0z7o5acrRDyYy+k/PHjWlkEU8ZfL/WopyFKUp32pzz8P+Jc8W+i0dYXb
        o/hK4KOfP3/E2CauI5suwIYmx1A7H58=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-588-9zYnt78QMbqJ-XU704_w-Q-1; Tue, 23 May 2023 20:35:16 -0400
X-MC-Unique: 9zYnt78QMbqJ-XU704_w-Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E748E8032F1;
        Wed, 24 May 2023 00:35:15 +0000 (UTC)
Received: from ovpn-8-17.pek2.redhat.com (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BDBB340D1B60;
        Wed, 24 May 2023 00:35:11 +0000 (UTC)
Date:   Wed, 24 May 2023 08:35:06 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Mike Snitzer <snitzer@kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH v3 3/7] block: Requeue requests if a CPU is unplugged
Message-ID: <ZG1butYP/ZVEyR7R@ovpn-8-17.pek2.redhat.com>
References: <20230522183845.354920-1-bvanassche@acm.org>
 <20230522183845.354920-4-bvanassche@acm.org>
 <CAFj5m9+dhpqYSOVBQ+H0tCb1Y2i1wpFqn_anbDsfs=mYCTqgCg@mail.gmail.com>
 <8b1d876b-fd37-5a0c-1e9d-253bf96e718f@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8b1d876b-fd37-5a0c-1e9d-253bf96e718f@acm.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, May 23, 2023 at 01:15:55PM -0700, Bart Van Assche wrote:
> On 5/23/23 01:17, Ming Lei wrote:
> > On Tue, May 23, 2023 at 2:39 AM Bart Van Assche <bvanassche@acm.org> wrote:
> > > 
> > > Requeue requests instead of sending these to the dispatch list if a CPU
> > > is unplugged. This gives the I/O scheduler the chance to preserve the
> > > order of zoned write requests.
> > 
> > But the affected code path is only for queue with none scheduler, do you
> > think none can maintain the order for write requests?
> 
> Hi Ming,
> 
> Doesn't blk_mq_insert_requests() insert requests in ctx->rq_lists[type]
> whether or not an I/O scheduler is active?

blk_mq_insert_requests() is only called for inserting passthrough
request in case of !q->elevator.

> 
> I haven't found any code in blk_mq_hctx_notify_dead() that makes this
> function behave differently based on whether or not an I/O scheduler has
> been associated with the request queue. Did I perhaps overlook something?

blk_mq_hctx_notify_dead() is only for handling request from sw queue
which is used for !q->elevator.

Thanks,
Ming

