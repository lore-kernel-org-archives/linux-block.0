Return-Path: <SRS0=Qcaa=SK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6531C10F13
	for <linux-block@archiver.kernel.org>; Mon,  8 Apr 2019 16:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 910C321473
	for <linux-block@archiver.kernel.org>; Mon,  8 Apr 2019 16:17:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbfDHQRF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Apr 2019 12:17:05 -0400
Received: from verein.lst.de ([213.95.11.211]:43989 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726228AbfDHQRF (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 8 Apr 2019 12:17:05 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id F37D168B02; Mon,  8 Apr 2019 18:16:52 +0200 (CEST)
Date:   Mon, 8 Apr 2019 18:16:52 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        James Smart <james.smart@broadcom.com>,
        Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH V3 1/2] blk-mq: introduce blk_mq_complete_request_sync()
Message-ID: <20190408161652.GA4381@lst.de>
References: <20190408094047.29150-1-ming.lei@redhat.com> <20190408094047.29150-2-ming.lei@redhat.com> <20190408161505.GA32613@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190408161505.GA32613@localhost.localdomain>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Apr 08, 2019 at 10:15:05AM -0600, Keith Busch wrote:
> > +bool blk_mq_complete_request_sync(struct request *rq)
> > +{
> > +	if (unlikely(blk_should_fake_timeout(rq->q)))
> > +		return false;
> > +
> > +	WRITE_ONCE(rq->state, MQ_RQ_COMPLETE);
> > +	rq->q->mq_ops->complete(rq);
> > +	return true;
> > +}
> > +EXPORT_SYMBOL_GPL(blk_mq_complete_request_sync);
> 
> Could we possibly drop the fake timeout in this path? We're using this
> in error handling that is past pretending completing requests didn't
> happen.

.. and at that point we can also drop the return value.
