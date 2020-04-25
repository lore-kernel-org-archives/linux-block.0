Return-Path: <SRS0=horf=6J=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C1A0C55191
	for <linux-block@archiver.kernel.org>; Sat, 25 Apr 2020 03:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E85D120704
	for <linux-block@archiver.kernel.org>; Sat, 25 Apr 2020 03:49:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RFk79l9+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbgDYDtM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Apr 2020 23:49:12 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:22069 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726038AbgDYDtM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Apr 2020 23:49:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587786551;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tgfES7VrOX7XhGW2Ppl/LaWQp6gSyjmcuaEU6OybsjE=;
        b=RFk79l9+szOmErC1Uo1lHc581SevcUJ2lzaWkG6zv/AqcWg+bu/D8rBuCyX3tulrtSEr9K
        nRwhBNiXRL43V45nCVEUNl9TIZmpfEDn2l/A1Idlyi+RjHO8Djz3YLZRrtXISHzKzsbLj/
        CSSsw7sc/90Z5YjTXqO3QpBNWAJmA0g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-82-gLZCrwnGMWq0rTKSkiyFFg-1; Fri, 24 Apr 2020 23:49:09 -0400
X-MC-Unique: gLZCrwnGMWq0rTKSkiyFFg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 127CA100A8E7;
        Sat, 25 Apr 2020 03:49:08 +0000 (UTC)
Received: from T590 (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9CACF610AB;
        Sat, 25 Apr 2020 03:49:00 +0000 (UTC)
Date:   Sat, 25 Apr 2020 11:48:54 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH V8 09/11] blk-mq: add blk_mq_hctx_handle_dead_cpu for
 handling cpu dead
Message-ID: <20200425034854.GI477579@T590>
References: <20200424102351.475641-1-ming.lei@redhat.com>
 <20200424102351.475641-10-ming.lei@redhat.com>
 <20200424104238.GF28156@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200424104238.GF28156@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Apr 24, 2020 at 12:42:38PM +0200, Christoph Hellwig wrote:
> > +static int blk_mq_hctx_notify_dead(unsigned int cpu, struct hlist_node *node)
> > +{
> > +	struct blk_mq_hw_ctx *hctx = hlist_entry_safe(node,
> > +			struct blk_mq_hw_ctx, cpuhp_dead);
> > +
> > +	if (!cpumask_test_cpu(cpu, hctx->cpumask))
> > +		return 0;
> > +
> > +	blk_mq_hctx_handle_dead_cpu(hctx, cpu);
> >  	return 0;
> 
> As commented last time:
> 
> why not simply:
> 
> 	if (cpumask_test_cpu(cpu, hctx->cpumask))
> 		blk_mq_hctx_handle_dead_cpu(hctx, cpu);
> 	return 0;

Hammm, it is just done on another handler, looks this one is missed.

Thanks,
Ming

