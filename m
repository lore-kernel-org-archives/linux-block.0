Return-Path: <SRS0=WbMh=RV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41487C43381
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 16:07:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12E1D20863
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 16:07:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbfCRQHA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Mar 2019 12:07:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46942 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727089AbfCRQHA (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Mar 2019 12:07:00 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8FA333082B13;
        Mon, 18 Mar 2019 16:06:59 +0000 (UTC)
Received: from ming.t460p (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 73980600C5;
        Mon, 18 Mar 2019 16:06:53 +0000 (UTC)
Date:   Tue, 19 Mar 2019 00:06:48 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/2] blk-mq: introduce blk_mq_complete_request_sync()
Message-ID: <20190318160646.GC20371@ming.t460p>
References: <20190318032950.17770-1-ming.lei@redhat.com>
 <20190318032950.17770-2-ming.lei@redhat.com>
 <f708ee0c-dfa4-0bca-f996-8d834471f1fd@acm.org>
 <20190318073826.GA29746@ming.t460p>
 <1552921495.152266.8.camel@acm.org>
 <20190318151618.GA20371@ming.t460p>
 <1552924164.152266.21.camel@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1552924164.152266.21.camel@acm.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Mon, 18 Mar 2019 16:06:59 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 18, 2019 at 08:49:24AM -0700, Bart Van Assche wrote:
> On Mon, 2019-03-18 at 23:16 +0800, Ming Lei wrote:
> > I am not familiar with SRP, could you explain what SRP initiator driver
> > will do when the controller is in bad state? Especially about dealing with
> > in-flight IO requests under this situation.
> 
> Hi Ming,
> 
> Just like the NVMeOF initiator driver, the SRP initiator driver uses an
> RDMA RC connection for all of its communication over the network. If
> communication between initiator and target fails the target driver will
> close the connection or one of the work requests that was posted by the
> initiator driver will complete with an error status (wc->status !=
> IB_WC_SUCCESS). In the latter case the function srp_handle_qp_err() will
> try to reestablish the connection between initiator and target after a
> certain delay:
> 
> 	if (delay > 0)
> 		queue_delayed_work(system_long_wq, &rport->reconnect_work,
> 				   1UL * delay * HZ);
> 
> SCSI timeouts may kick the SCSI error handler. That results in calls of
> the srp_reset_device() and/or srp_reset_host() functions. srp_reset_host()
> terminates all outstanding requests after having disconnected the RDMA RC
> connection.

Looks the approach of NVMe's error handler is basically similar with
above.

And NVMe just uses 'blk_mq_tagset_busy_iter(nvme_cancel_request)' to abort
in-flight requests, and I guess SCSI FC may use driver's approach to do that.

> Disconnecting the RC connection first guarantees that there
> are no concurrent request completion calls from the regular completion
> path and from the error handler.

Looks no concurrent request completion guarantee requires driver's
specific implementation.

However, this patch provides one simple approach for NVMe, then no
driver specific sync mechanism is needed.

Thanks,
Ming
