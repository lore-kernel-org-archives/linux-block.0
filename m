Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E757C433EF
	for <linux-block@archiver.kernel.org>; Wed, 15 Jun 2022 06:24:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346077AbiFOGYg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Jun 2022 02:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344650AbiFOGYf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Jun 2022 02:24:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1A67827FEE
        for <linux-block@vger.kernel.org>; Tue, 14 Jun 2022 23:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655274274;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yd0GPwWiYr+7f8pOF7k3F2WV4y4xUs3c1n6Q2E8LVBM=;
        b=KGC0O86X9LsZtRRq+rXvuCIUhGpTXvsaRYa5OlVW+qyBLRXv2MaB2Z4HXqfgI38HMF0JMs
        eku1+OxXtJ4Yxniv36JWYEMVNuHw1oMtde6j1MWdRZ2rwC2KjOhy5a+Kwl86JbVUBqfE4W
        7Cc4c62aUmpzibiPncaIxhZ4b7bW50o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-675-gefO7h-_MNWUCnLKSg2fyg-1; Wed, 15 Jun 2022 02:24:30 -0400
X-MC-Unique: gefO7h-_MNWUCnLKSg2fyg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 423AA833975;
        Wed, 15 Jun 2022 06:24:30 +0000 (UTC)
Received: from T590 (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E17781415106;
        Wed, 15 Jun 2022 06:24:26 +0000 (UTC)
Date:   Wed, 15 Jun 2022 14:24:20 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 3/3] block: Specify the operation type when calling
 blk_mq_map_queue()
Message-ID: <Yql7FCHTZbVIKWQV@T590>
References: <20220614175725.612878-1-bvanassche@acm.org>
 <20220614175725.612878-4-bvanassche@acm.org>
 <YqkoWUjOPgpqzn4E@T590>
 <20220615060851.GE22115@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220615060851.GE22115@lst.de>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 15, 2022 at 08:08:51AM +0200, Christoph Hellwig wrote:
> On Wed, Jun 15, 2022 at 08:31:21AM +0800, Ming Lei wrote:
> > > -	struct blk_mq_hw_ctx *hctx = blk_mq_map_queue(q, 0, ctx);
> > > +	struct blk_mq_hw_ctx *hctx = blk_mq_map_queue(q, REQ_OP_WRITE, ctx);
> > 
> > The change itself doesn't make a difference, since both results in choosing
> > HCTX_TYPE_DEFAULT, but passing REQ_OP_WRITE is a bit misleading.
> 
> Well, the argument is an operationm so we better pass in a correct
> operation (at some point we should look into a __bitwise annotation
> or similar to make it clean).  And as 0 is REQ_OP_READ, we will end
> up with the HCTX_TYPE_READ hctx IFF someone configures read queues
> and uses an sq only schedule.  Which is a completely stupid but
> possible setup.
> 

OK, looks here the hctx can be retrieved ctx->hctxs[HCTX_TYPE_DEFAULT]
directly.


Thanks,
Ming

