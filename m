Return-Path: <SRS0=WbMh=RV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2625C43381
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 15:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E4A22085A
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 15:16:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbfCRPQa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Mar 2019 11:16:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49846 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726837AbfCRPQ3 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Mar 2019 11:16:29 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9AC5F4E908;
        Mon, 18 Mar 2019 15:16:29 +0000 (UTC)
Received: from ming.t460p (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 481C45D70E;
        Mon, 18 Mar 2019 15:16:23 +0000 (UTC)
Date:   Mon, 18 Mar 2019 23:16:19 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/2] blk-mq: introduce blk_mq_complete_request_sync()
Message-ID: <20190318151618.GA20371@ming.t460p>
References: <20190318032950.17770-1-ming.lei@redhat.com>
 <20190318032950.17770-2-ming.lei@redhat.com>
 <f708ee0c-dfa4-0bca-f996-8d834471f1fd@acm.org>
 <20190318073826.GA29746@ming.t460p>
 <1552921495.152266.8.camel@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1552921495.152266.8.camel@acm.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Mon, 18 Mar 2019 15:16:29 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 18, 2019 at 08:04:55AM -0700, Bart Van Assche wrote:
> On Mon, 2019-03-18 at 15:38 +0800, Ming Lei wrote:
> > On Sun, Mar 17, 2019 at 09:09:09PM -0700, Bart Van Assche wrote:
> > > On 3/17/19 8:29 PM, Ming Lei wrote:
> > > > In NVMe's error handler, follows the typical steps for tearing down
> > > > hardware:
> > > > 
> > > > 1) stop blk_mq hw queues
> > > > 2) stop the real hw queues
> > > > 3) cancel in-flight requests via
> > > > 	blk_mq_tagset_busy_iter(tags, cancel_request, ...)
> > > > cancel_request():
> > > > 	mark the request as abort
> > > > 	blk_mq_complete_request(req);
> > > > 4) destroy real hw queues
> > > > 
> > > > However, there may be race between #3 and #4, because blk_mq_complete_request()
> > > > actually completes the request asynchronously.
> > > > 
> > > > This patch introduces blk_mq_complete_request_sync() for fixing the
> > > > above race.
> > > 
> > > Other block drivers wait until outstanding requests have completed by
> > > calling blk_cleanup_queue() before hardware queues are destroyed. Why can't
> > > the NVMe driver follow that approach?
> > 
> > The tearing down of controller can be done in error handler, in which
> > the request queues may not be cleaned up, almost all kinds of NVMe
> > controller's error handling follows the above steps, such as:
> > 
> > nvme_rdma_error_recovery_work()
> > 	->nvme_rdma_teardown_io_queues()
> > 
> > nvme_timeout()
> > 	->nvme_dev_disable
> 
> Hi Ming,
> 
> This makes me wonder whether the current design of the NVMe core is the best
> design we can come up with? The structure of e.g. the SRP initiator and target
> drivers is similar to the NVMeOF drivers. However, there is no need in the SRP
> initiator driver to terminate requests synchronously. Is this due to

I am not familiar with SRP, could you explain what SRP initiator driver
will do when the controller is in bad state? Especially about dealing with
in-flight IO requests under this situation.

> differences in the error handling approaches in the SCSI and NVMe core drivers?

As far as I can tell, I don't see obvious design issue in NVMe host drivers,
which tries best to recover controller and retries to complete all in-flight IO.

Thanks,
Ming
