Return-Path: <SRS0=o3qj=RY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EC17C43381
	for <linux-block@archiver.kernel.org>; Thu, 21 Mar 2019 01:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3D76218C3
	for <linux-block@archiver.kernel.org>; Thu, 21 Mar 2019 01:39:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbfCUBjU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Mar 2019 21:39:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39164 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726487AbfCUBjT (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Mar 2019 21:39:19 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 84FE930832CD;
        Thu, 21 Mar 2019 01:39:19 +0000 (UTC)
Received: from ming.t460p (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2110D600C1;
        Thu, 21 Mar 2019 01:39:13 +0000 (UTC)
Date:   Thu, 21 Mar 2019 09:39:09 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/2] blk-mq: introduce blk_mq_complete_request_sync()
Message-ID: <20190321013908.GA15115@ming.t460p>
References: <20190318032950.17770-1-ming.lei@redhat.com>
 <20190318032950.17770-2-ming.lei@redhat.com>
 <f708ee0c-dfa4-0bca-f996-8d834471f1fd@acm.org>
 <20190318073826.GA29746@ming.t460p>
 <1552921495.152266.8.camel@acm.org>
 <20190318151618.GA20371@ming.t460p>
 <1552924164.152266.21.camel@acm.org>
 <448615db-64e2-cbe7-c09e-19b2d86a720a@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <448615db-64e2-cbe7-c09e-19b2d86a720a@grimberg.me>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Thu, 21 Mar 2019 01:39:19 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 20, 2019 at 05:47:01PM -0700, Sagi Grimberg wrote:
> 
> > Hi Ming,
> > 
> > Just like the NVMeOF initiator driver, the SRP initiator driver uses an
> > RDMA RC connection for all of its communication over the network. If
> > communication between initiator and target fails the target driver will
> > close the connection or one of the work requests that was posted by the
> > initiator driver will complete with an error status (wc->status !=
> > IB_WC_SUCCESS). In the latter case the function srp_handle_qp_err() will
> > try to reestablish the connection between initiator and target after a
> > certain delay:
> > 
> > 	if (delay > 0)
> > 		queue_delayed_work(system_long_wq, &rport->reconnect_work,
> > 				   1UL * delay * HZ);
> > 
> > SCSI timeouts may kick the SCSI error handler. That results in calls of
> > the srp_reset_device() and/or srp_reset_host() functions. srp_reset_host()
> > terminates all outstanding requests after having disconnected the RDMA RC
> > connection. Disconnecting the RC connection first guarantees that there
> > are no concurrent request completion calls from the regular completion
> > path and from the error handler.
> 
> Hi Bart,
> 
> If I understand the race correctly, its not between the requests
> completion and the queue pairs removal nor the timeout handler
> necessarily, but rather it is between the async requests completion and
> the tagset deallocation.
> 
> Think of surprise removal (or disconnect) during I/O, drivers
> usually stop/quiesce/freeze the queues, terminate/abort inflight
> I/Os and then teardown the hw queues and the tagset.
> 
> IIRC, the same race holds for srp if this happens during I/O:
> 1. srp_rport_delete() -> srp_remove_target() -> srp_stop_rport_timers() ->
> __rport_fail_io_fast()
> 
> 2. complete all I/Os (async remotely via smp)
> 
> Then continue..
> 
> 3. scsi_host_put() -> scsi_host_dev_release() -> scsi_mq_destroy_tags()
> 
> What is preventing (3) from happening before (2) if its async? I would
> think that scsi drivers need the exact same thing...

blk_cleanup_queue() will do that, but it can't be used in device recovery
obviously.

BTW, blk_mq_complete_request_sync() is a bit misleading, maybe
blk_mq_complete_request_locally() is better.

Thanks,
Ming
