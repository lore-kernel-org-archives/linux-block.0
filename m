Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B21C77B7D
	for <linux-block@archiver.kernel.org>; Thu, 18 May 2023 13:06:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbjERNGl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 May 2023 09:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbjERNGk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 May 2023 09:06:40 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00913170B
        for <linux-block@vger.kernel.org>; Thu, 18 May 2023 06:06:35 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id A2E6968C7B; Thu, 18 May 2023 15:06:32 +0200 (CEST)
Date:   Thu, 18 May 2023 15:06:32 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 2/3] blk-mq: remove RQF_ELVPRIV
Message-ID: <20230518130632.GA31791@lst.de>
References: <20230518053101.760632-1-hch@lst.de> <20230518053101.760632-3-hch@lst.de> <ZGXPkFOWOuoLWglR@ovpn-8-21.pek2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGXPkFOWOuoLWglR@ovpn-8-21.pek2.redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, May 18, 2023 at 03:11:12PM +0800, Ming Lei wrote:
> > -		if ((rq->rq_flags & RQF_ELVPRIV) && e->type->ops.requeue_request)
> > +		if (e->type->ops.requeue_request)
> >  			e->type->ops.requeue_request(rq);
> 
> The above actually changes current behavior since RQF_ELVPRIV is only set
> iff the following condition is true:
> 
> 	(rq->rq_flags & RQF_ELV) && !op_is_flush(rq->cmd_flags) &&
> 		e->type->ops.prepare_request.

It would require an I/O scheduler that implements .requeue_request but
not .prepare_request, which doesn't exist and also is rather pointless as
this .requeue_request method would never get called in the current code.

So no, no behavior change in practice.
