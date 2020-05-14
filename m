Return-Path: <SRS0=D5/G=64=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C173C433E0
	for <linux-block@archiver.kernel.org>; Thu, 14 May 2020 02:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F271C20575
	for <linux-block@archiver.kernel.org>; Thu, 14 May 2020 02:19:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QhOnDbaZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725973AbgENCTq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 May 2020 22:19:46 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:55475 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbgENCTq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 May 2020 22:19:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589422784;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yVejNr04z3VNBKbf21HMjsYwMiy0dh4CcK9QH+0tJXM=;
        b=QhOnDbaZlIBE+tbxRE3U8HhzTt2068XKTunJ7bnP7M6YSTP4CA5M+uqFQYZRlqMvH68Sn1
        Ap4njIMgNHYxjy56Bk5qiubJlTHl+biTHHNvnNYvokcFF2mIdFEpdS4Orqk8ronaIcPSN7
        RNP8tX+dLNSKwCjtALzP3Sm5CQLsAbQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-21-rqdxvsqcMlO_vGYTtpy3Fw-1; Wed, 13 May 2020 22:19:41 -0400
X-MC-Unique: rqdxvsqcMlO_vGYTtpy3Fw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E612D801503;
        Thu, 14 May 2020 02:19:39 +0000 (UTC)
Received: from T590 (ovpn-12-94.pek2.redhat.com [10.72.12.94])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5EC7A7049C;
        Thu, 14 May 2020 02:19:34 +0000 (UTC)
Date:   Thu, 14 May 2020 10:19:29 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        Baolin Wang <baolin.wang7@gmail.com>
Subject: Re: [PATCH 3/9] blk-mq: don't predicate last flag in
 blk_mq_dispatch_rq_list
Message-ID: <20200514021929.GI2073570@T590>
References: <20200513095443.2038859-1-ming.lei@redhat.com>
 <20200513095443.2038859-4-ming.lei@redhat.com>
 <20200513122753.GC23958@infradead.org>
 <20200514020955.GH2073570@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200514020955.GH2073570@T590>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, May 14, 2020 at 10:09:55AM +0800, Ming Lei wrote:
> On Wed, May 13, 2020 at 05:27:53AM -0700, Christoph Hellwig wrote:
> > On Wed, May 13, 2020 at 05:54:37PM +0800, Ming Lei wrote:
> > > .commit_rqs() is supposed to handle partial dispatch when driver may not
> > > see .last of flag passed to .queue_rq().
> > > 
> > > We have added .commit_rqs() in case of partial dispatch and all consumers
> > > of bd->last have implemented .commit_rqs() callback, so it is perfect to
> > > pass real .last flag of the request list to .queue_rq() instead of faking
> > > it by trying to allocate driver tag for next request in the batching list.
> > 
> > The current case still seems like a nice optimization to avoid an extra
> > indirect function call.  So if you want to get rid of it I think it at
> > least needs a better rationale.
> 
> Forget to mention, trying to predicate the last request via allocating
> tag for next request can't avoid extra .commit_rqs() because this
> indirect call is always called when the rq list isn't done.
> 
> Also no matter .last is set or not, every implementation of .commit_rqs
> always grabs one lock, so looks this patch can get real win without any
> performance loss.
> 
> On the other side, .commit_rqs() can be avoided iff the last queued(successful)
> rq is marked as .last, and the cost is to keep current estimate on .last.
> However, why is .commit_rqs() required? Why doesn't .queue_rq() handle the batching
> submission before non-STS_OK is returned? And the inline handling can be quite
> efficient because one more spin lock acquire can be avoided usually. Then
> .commit_rqs() can be killed.

The only chance we need .commit_rqs() should be:

- requests are queued successfully, and the last queued rq isn't marked
  as last
- running out of budget or driver tag before queueing one new request

I think we need to document the interfaces(.commit_rqs & .queue_rq) clearly.

thanks,
Ming

