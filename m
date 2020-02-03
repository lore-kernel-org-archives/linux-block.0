Return-Path: <SRS0=KNqY=3X=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22CA8C35247
	for <linux-block@archiver.kernel.org>; Mon,  3 Feb 2020 12:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA84F20658
	for <linux-block@archiver.kernel.org>; Mon,  3 Feb 2020 12:30:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CpqHmt9u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbgBCMaD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Feb 2020 07:30:03 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:26379 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727311AbgBCMaD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 3 Feb 2020 07:30:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580733002;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4qVqMN+L6uCBSRoaDAR0Q4AAiLaYvvliNwGYG5iPXzE=;
        b=CpqHmt9ujqkgXOsr8McmCrmuc4T/DioXAwEfNVPDD1GzLYcWWpsQxZlwNJnIz0A4gh3GLe
        rGS6vlsA7KKqIO4uz1UOD/Qur4DdvdIfFH9YYsdqWmL+jn3965Qux/+foBtBGY78aRuDUA
        W6W5gI61ny8yExYN384D55y0XGGm8sM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-210-ZFbaN34zP1efJwiZVOL76g-1; Mon, 03 Feb 2020 07:29:58 -0500
X-MC-Unique: ZFbaN34zP1efJwiZVOL76g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3D293477;
        Mon,  3 Feb 2020 12:29:57 +0000 (UTC)
Received: from ming.t460p (ovpn-8-25.pek2.redhat.com [10.72.8.25])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8FBC5108419D;
        Mon,  3 Feb 2020 12:29:50 +0000 (UTC)
Date:   Mon, 3 Feb 2020 20:29:46 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Hillf Danton <hdanton@sina.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blk-mq: fix selecting software ctx for request
Message-ID: <20200203122946.GC31450@ming.t460p>
References: <20200202102004.19132-1-hdanton@sina.com>
 <20200203102815.3940-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200203102815.3940-1-hdanton@sina.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Feb 03, 2020 at 06:28:15PM +0800, Hillf Danton wrote:
> 
> Hi Ming
> 
> On Mon, 3 Feb 2020 17:16:02 +0800 Ming Lei wrote:
> > On Sun, Feb 02, 2020 at 06:20:04PM +0800, Hillf Danton wrote:
> > > 
> > > Select the current cpu if it's mapped to hardware to make helpers like
> > > blk_mq_rq_cpu() return correct value.
> > > 
> > > Signed-off-by: Hillf Danton <hdanton@sina.com>
> > > ---
> > > 
> > > --- a/block/blk-mq.c
> > > +++ b/block/blk-mq.c
> > > @@ -454,7 +454,10 @@ struct request *blk_mq_alloc_request_hct
> > >  		blk_queue_exit(q);
> > >  		return ERR_PTR(-EXDEV);
> > >  	}
> > > -	cpu = cpumask_first_and(alloc_data.hctx->cpumask, cpu_online_mask);
> > > +	cpu = raw_smp_processor_id();
> > > +	if (!cpumask_test_cpu(cpu, alloc_data.hctx->cpumask))
> > > +		cpu = cpumask_first_and(alloc_data.hctx->cpumask,
> > > +						cpu_online_mask);
> > 
> > How can you know if there is any online CPU available for this hctx?
> 
> I don't except for the current cpu.

The current CPU may not belong to hctx->cpumask for blk_mq_alloc_request_hctx(),
that is why I think this API is very weird.


Thanks, 
Ming

