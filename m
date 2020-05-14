Return-Path: <SRS0=D5/G=64=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C78F3C433E0
	for <linux-block@archiver.kernel.org>; Thu, 14 May 2020 03:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B08C0205CB
	for <linux-block@archiver.kernel.org>; Thu, 14 May 2020 03:10:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WpkxxDjY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726011AbgENDKw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 May 2020 23:10:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29423 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725977AbgENDKv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 May 2020 23:10:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589425850;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k4LU8uOqSg2TdETiYBVfiVStOV0ayahtzV6l5tMorqI=;
        b=WpkxxDjYADdwMCN4ZZEj+6Nk0KzgH/AI6OMgOQ/Z5orn52Mz01pv/leeREPxCdCC/boHlt
        13EpHVBOwR8mPVWzgAxZp2yhViByDRX7pNCtDhtbmciEVZ/ewIU/laefMthV4eL9K1V/gb
        rlML254i+Izpu68ah+UQpgwSB5xJc8I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-125-lO2zIXuXOUef-hv5pRBadw-1; Wed, 13 May 2020 23:10:46 -0400
X-MC-Unique: lO2zIXuXOUef-hv5pRBadw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 186751005510;
        Thu, 14 May 2020 03:10:45 +0000 (UTC)
Received: from T590 (ovpn-12-94.pek2.redhat.com [10.72.12.94])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 341232E179;
        Thu, 14 May 2020 03:10:37 +0000 (UTC)
Date:   Thu, 14 May 2020 11:10:33 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH V11 07/12] blk-mq: stop to handle IO and drain IO before
 hctx becomes inactive
Message-ID: <20200514031033.GJ2073570@T590>
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
> I also still don't see what the barrier() is trying to help with.

It is correct and clean to only add smp_mb() for ordering setting
rq->tag/assigning req and checking INACTIVE, and just a normal usage
of memory barrier.

barrier() is used in most likely case because smp_mb() is only required
when direct io issue process is migrated to other CPU, that seldom
happens, so just an optimization.

So I do not agree it is horrible and hacky.

Thanks,
Ming

