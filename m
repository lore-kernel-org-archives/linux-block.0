Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E5C6C48BE8
	for <linux-block@archiver.kernel.org>; Fri, 18 Jun 2021 06:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11852611CD
	for <linux-block@archiver.kernel.org>; Fri, 18 Jun 2021 06:03:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232720AbhFRGFr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Jun 2021 02:05:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26913 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232250AbhFRGFq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Jun 2021 02:05:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623996217;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QUpTivGR5cw/8vxE6wrjCgS3JrDj7wbmIf5WsbHNX6w=;
        b=W9McfnsaVoiKP3qdygpZ4boRL09jNUs41MJzWlpF1g1DPsjdPOCI2isCBqur+/BCnMrXg1
        C08vGOWQJ2eP2syUwnMYQbnqaNAMB/p62ruW4LtbByO0w1Dudtl8IEOurDRkgB7iO8Xgvo
        xJ2K3RSqemcRyiE5eG6Lg9EM5+jZA3g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-416-eUWZQxBnOcSM4xDhjIyS3Q-1; Fri, 18 Jun 2021 02:03:35 -0400
X-MC-Unique: eUWZQxBnOcSM4xDhjIyS3Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AEEB78015F8;
        Fri, 18 Jun 2021 06:03:34 +0000 (UTC)
Received: from T590 (ovpn-12-158.pek2.redhat.com [10.72.12.158])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9CA9919D61;
        Fri, 18 Jun 2021 06:03:28 +0000 (UTC)
Date:   Fri, 18 Jun 2021 14:03:23 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     John Garry <john.garry@huawei.com>, Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        syzbot+77ba3d171a25c56756ea@syzkaller.appspotmail.com
Subject: Re: [PATCH] blk-mq: fix use-after-free in blk_mq_exit_sched
Message-ID: <YMw3K1UVJwC17FHa@T590>
References: <20210609063046.122843-1-ming.lei@redhat.com>
 <YMfTBagmPCHGkhYa@T590>
 <2c2fd2b2-c622-15dc-58f6-c588cab4f79d@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c2fd2b2-c622-15dc-58f6-c588cab4f79d@huawei.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 15, 2021 at 11:02:29AM +0100, John Garry wrote:
> > > Reported-by:syzbot+77ba3d171a25c56756ea@syzkaller.appspotmail.com
> > > Fixes: d97e594c5166 ("blk-mq: Use request queue-wide tags for tagset-wide sbitmap")
> > > Cc: John Garry<john.garry@huawei.com>
> > > Signed-off-by: Ming Lei<ming.lei@redhat.com>
> Tested-by: John Garry <john.garry@huawei.com>
> Reviewed-by: John Garry <john.garry@huawei.com>

Hello Jens,

Can you merge this patch?



Thanks,
Ming

