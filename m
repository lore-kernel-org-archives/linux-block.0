Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D9BC7EE22
	for <linux-block@archiver.kernel.org>; Thu, 18 May 2023 13:21:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjERNVp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 May 2023 09:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbjERNVo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 May 2023 09:21:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB0CAC
        for <linux-block@vger.kernel.org>; Thu, 18 May 2023 06:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684416055;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Kdkbhd8g08JsfRDFZbmdVZXIKongioEN7yITfp51oLo=;
        b=RTEJVflkoKIvLFDttQtSfpy2RIl3qaWl6fLVUxcijet4mNuMxOttmCeAVT04jG7+b7o16W
        EK+vv//lKYXdAXHoFccpsAm8XoDzKpl4XzbddiJGfWV47PxJfL7kugK2Pxqaq8dhEBtgbU
        Fb8yz8AaNgt2NLAroXW6rq2LNkYkQro=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-383-cdUJEtJbNHm3czRJ3ApIGw-1; Thu, 18 May 2023 09:20:51 -0400
X-MC-Unique: cdUJEtJbNHm3czRJ3ApIGw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 63E4B88B76E;
        Thu, 18 May 2023 13:20:51 +0000 (UTC)
Received: from ovpn-8-21.pek2.redhat.com (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F2B5EC15BA0;
        Thu, 18 May 2023 13:20:48 +0000 (UTC)
Date:   Thu, 18 May 2023 21:20:43 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 2/3] blk-mq: remove RQF_ELVPRIV
Message-ID: <ZGYmK/y/TXuYk3tN@ovpn-8-21.pek2.redhat.com>
References: <20230518053101.760632-1-hch@lst.de>
 <20230518053101.760632-3-hch@lst.de>
 <ZGXPkFOWOuoLWglR@ovpn-8-21.pek2.redhat.com>
 <20230518130632.GA31791@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230518130632.GA31791@lst.de>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, May 18, 2023 at 03:06:32PM +0200, Christoph Hellwig wrote:
> On Thu, May 18, 2023 at 03:11:12PM +0800, Ming Lei wrote:
> > > -		if ((rq->rq_flags & RQF_ELVPRIV) && e->type->ops.requeue_request)
> > > +		if (e->type->ops.requeue_request)
> > >  			e->type->ops.requeue_request(rq);
> > 
> > The above actually changes current behavior since RQF_ELVPRIV is only set
> > iff the following condition is true:
> > 
> > 	(rq->rq_flags & RQF_ELV) && !op_is_flush(rq->cmd_flags) &&
> > 		e->type->ops.prepare_request.
> 
> It would require an I/O scheduler that implements .requeue_request but
> not .prepare_request, which doesn't exist and also is rather pointless as
> this .requeue_request method would never get called in the current code.
> 
> So no, no behavior change in practice.

Fair enough, just found that all three schedulers have implemented
e->type->ops.prepare_request.

Thanks, 
Ming

