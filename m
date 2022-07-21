Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4165C433EF
	for <linux-block@archiver.kernel.org>; Thu, 21 Jul 2022 07:12:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbiGUHMm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Jul 2022 03:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231407AbiGUHMl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Jul 2022 03:12:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1D7687B780
        for <linux-block@vger.kernel.org>; Thu, 21 Jul 2022 00:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658387559;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bvLrPntz/6SExPF+W5AyZ/J4mi7PTlDR9flvywxolLE=;
        b=gLRXMWFfy1ltuoW5zsNkoMFV5PO/HgQGaFDIcgMyVpbaIR3eKRJkdMvTTbiLevRjJrRYRC
        n/uJmNN3dk9Log0ATvr+SN9lHOq1mdIFfty52RxNCjkQwd6G6rD8VXvy5vGbJcOYHT1YMz
        MUuL/3sa7ooDhcCITRY4p1ipXbE0HQ4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-629-TDzxaQ2rPo28XmKEeFqn7Q-1; Thu, 21 Jul 2022 03:12:35 -0400
X-MC-Unique: TDzxaQ2rPo28XmKEeFqn7Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4A5942801766;
        Thu, 21 Jul 2022 07:12:35 +0000 (UTC)
Received: from T590 (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B884A18ECB;
        Thu, 21 Jul 2022 07:12:32 +0000 (UTC)
Date:   Thu, 21 Jul 2022 15:12:27 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/2] blk-mq: fix error handling in __blk_mq_alloc_disk
Message-ID: <Ytj8WwwxH+ZxpSSJ@T590>
References: <20220720130541.1323531-1-hch@lst.de>
 <YtiV148hTcpsjTZ+@T590>
 <20220721050332.GA19443@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220721050332.GA19443@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jul 21, 2022 at 07:03:32AM +0200, Christoph Hellwig wrote:
> On Thu, Jul 21, 2022 at 07:55:03AM +0800, Ming Lei wrote:
> > > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > > index d716b7f3763f3..70177ee74295b 100644
> > > --- a/block/blk-mq.c
> > > +++ b/block/blk-mq.c
> > > @@ -3960,7 +3960,7 @@ struct gendisk *__blk_mq_alloc_disk(struct blk_mq_tag_set *set, void *queuedata,
> > >  
> > >  	disk = __alloc_disk_node(q, set->numa_node, lkclass);
> > >  	if (!disk) {
> > > -		blk_put_queue(q);
> > > +		blk_mq_destroy_queue(q);
> > >  		return ERR_PTR(-ENOMEM);
> >  
> > The same change is needed in case of blk_mq_init_allocated_queue() failure too.
> 
> I don't think so.  blk_mq_init_allocated_queue only calls
> blk_mq_add_queue_tag_set at the very end, after any failure point,
> and the last failure point is blk_mq_realloc_hw_ctxs not mapping
> any queues.  So what would we clean up when
> blk_mq_init_allocated_queue fails?
 
OK, miss that, so looks fine:

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming

