Return-Path: <SRS0=D5/G=64=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C1D6C433DF
	for <linux-block@archiver.kernel.org>; Thu, 14 May 2020 00:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DEBB20659
	for <linux-block@archiver.kernel.org>; Thu, 14 May 2020 00:36:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CHY+KS67"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732796AbgENAgo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 May 2020 20:36:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52174 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730289AbgENAgo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 May 2020 20:36:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589416603;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=88LhDvnhYUKQDgSexhrhduwuPAsJkMIUENcw6/rXgok=;
        b=CHY+KS67XM21QkcGMOjb1MVhqJfQ4Q2alqpI2T4WZxdd3sFSDrhldTt1tOtxzUNKTnvAAy
        az8CrsY9LRMJ0xmwKIps4014a4xL1UdJXfC2odF6+5vU1i92l048sGkl1uvYeP//nB/GPZ
        OurlZfdA2tbTUYlMYtYqRKBsFNbyKdg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-O5Ka-97rOh-fDl0Q2APr_w-1; Wed, 13 May 2020 20:36:39 -0400
X-MC-Unique: O5Ka-97rOh-fDl0Q2APr_w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C546B8014D7;
        Thu, 14 May 2020 00:36:37 +0000 (UTC)
Received: from T590 (ovpn-12-94.pek2.redhat.com [10.72.12.94])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4F7E7391;
        Thu, 14 May 2020 00:36:30 +0000 (UTC)
Date:   Thu, 14 May 2020 08:36:26 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH V11 07/12] blk-mq: stop to handle IO and drain IO before
 hctx becomes inactive
Message-ID: <20200514003601.GB2073570@T590>
References: <20200513034803.1844579-1-ming.lei@redhat.com>
 <20200513034803.1844579-8-ming.lei@redhat.com>
 <20200513115932.GC6297@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513115932.GC6297@lst.de>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 13, 2020 at 01:59:32PM +0200, Christoph Hellwig wrote:
> > +	if (unlikely(direct_issue && rq->mq_ctx->cpu != raw_smp_processor_id()))
> > +		smp_mb();
> > +	else
> > +		barrier();
> 
> Independ of the fact that I still think this is horrible and hacky,

Why?

I believe it has been documented clearly. Or can you share better idea?

> I also still don't see what the barrier() is trying to help with.

It is a compiler barrier, the two OPs are still to be ordered in case
of single CPU.


Thanks,
Ming

