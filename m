Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B91C6377B
	for <linux-block@archiver.kernel.org>; Thu, 22 Jul 2021 01:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C41D361263
	for <linux-block@archiver.kernel.org>; Thu, 22 Jul 2021 01:23:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbhGVAmb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Jul 2021 20:42:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34986 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229783AbhGVAma (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Jul 2021 20:42:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626916985;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p9hyN++sL6pwuYG+HV82gfVId8IkC3N/vYBIRXKylDc=;
        b=bcLpCp8PA8JZA7UfpYG15Ixmw0P0hXhtM6Zh9otxV/uVLYhDDS1Sp158rd434q5k1arcJB
        toXn0D+rfi5+ubAZlkpeq+9T8H4THl0b2MFQ/X114o8kC2KlegiyNyOX8q8Pb54459MV59
        pR4xYw3HHvoSFsJ8hABxCudw454cK/0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-51-rYlm-WgpNK2QS_grL_dwig-1; Wed, 21 Jul 2021 21:23:02 -0400
X-MC-Unique: rYlm-WgpNK2QS_grL_dwig-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 61693107ACF5;
        Thu, 22 Jul 2021 01:23:00 +0000 (UTC)
Received: from T590 (ovpn-13-66.pek2.redhat.com [10.72.13.66])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6D1661009962;
        Thu, 22 Jul 2021 01:22:51 +0000 (UTC)
Date:   Thu, 22 Jul 2021 09:22:46 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Daniel Wagner <dwagner@suse.de>,
        Wen Xiong <wenxiong@us.ibm.com>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH V5 2/3] blk-mq: mark if one queue map uses managed irq
Message-ID: <YPjIZsTZg0dx0jPC@T590>
References: <20210721091723.1152456-1-ming.lei@redhat.com>
 <20210721091723.1152456-3-ming.lei@redhat.com>
 <6d2e0c81-6efd-69eb-7b00-85565533e5b4@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d2e0c81-6efd-69eb-7b00-85565533e5b4@huawei.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jul 21, 2021 at 07:53:22PM +0100, John Garry wrote:
> On 21/07/2021 10:17, Ming Lei wrote:
> 
> FWIW,
> 
> Reviewed-by: John Garry <john.garry@huawei.com>
> 
> > diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> > index 1d18447ebebc..d54a795ec971 100644
> > --- a/include/linux/blk-mq.h
> > +++ b/include/linux/blk-mq.h
> > @@ -192,7 +192,8 @@ struct blk_mq_hw_ctx {
> >   struct blk_mq_queue_map {
> >   	unsigned int *mq_map;
> >   	unsigned int nr_queues;
> > -	unsigned int queue_offset;
> > +	unsigned int queue_offset:31;
> > +	unsigned int use_managed_irq:1;
> 
> late nit: I'd be inclined to call this "drain_hw_queue" or similar, which is
> what it means to blk-mq

But 'drain_hw_queue' isn't straightforward when it is checked in
blk_mq_alloc_request_hctx().


Thanks,
Ming

