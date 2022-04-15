Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A61C433F5
	for <linux-block@archiver.kernel.org>; Fri, 15 Apr 2022 17:42:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242599AbiDORpW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Apr 2022 13:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243665AbiDORpV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Apr 2022 13:45:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A928B7C59
        for <linux-block@vger.kernel.org>; Fri, 15 Apr 2022 10:42:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D9D862302
        for <linux-block@vger.kernel.org>; Fri, 15 Apr 2022 17:42:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77D6FC385A5;
        Fri, 15 Apr 2022 17:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650044571;
        bh=UzS+Oc9IcLvGMsajJzgi9HP2qMZLBAyAEQm+OyFjMhI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=TI+Qp4cvbRM3O9Dzk7T6j+id6uniw8HPnd3tjxo4VcCGpkz04EzXSMFqa2MZGL/Pd
         uW4tZcyWsUxPlgFNH2TB1d/o6aMViEyLAjz+lAC6Pv1mzN2ySlzA7py7qQVpCNULzz
         Wj3d/8VW5ndd2XuSliyfMfjwwkf0yB0E/XzBbOrjB6xQlUGuUh0cqjriwprwpU9/k/
         KacFVzSckeKf13U5KZ1hkI1wiZF2wyuquo/TB1rbyG18/UAYTDlCaD+4KkgdeG3iiJ
         0XMDYBj7QK/fzxpjpm6yO4X41qhgIhm3AQt4yTjGLZocS8MDAGcQihdoT+5LMR++eC
         498HIoEYW0Fyg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 1EDF85C04C8; Fri, 15 Apr 2022 10:42:51 -0700 (PDT)
Date:   Fri, 15 Apr 2022 10:42:51 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Klaus Jensen <its@irrelevant.dk>, shinichiro.kawasaki@wdc.com,
        linux-block@vger.kernel.org, Pankaj Raghav <pankydev8@gmail.com>,
        Pankaj Raghav <p.raghav@samsung.com>,
        Adam Manzanares <a.manzanares@samsung.com>
Subject: Re: blktests with zbd/006 ZNS triggers a possible false positive RCU
 stall
Message-ID: <20220415174251.GM4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <YliZ9M6QWISXvhAJ@bombadil.infradead.org>
 <20220415010945.wvyztmss7rfqnlog@offworld>
 <YlmsTCBLg6hB2eNn@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlmsTCBLg6hB2eNn@bombadil.infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Apr 15, 2022 at 10:33:00AM -0700, Luis Chamberlain wrote:
> On Thu, Apr 14, 2022 at 06:09:45PM -0700, Davidlohr Bueso wrote:
> > No idea, however, why this would happen when using qemu as opposed to
> > nbd.
> 
> Sorry I keep saying nbd often when I mean null_blk, but yeah, same concept,
> in that I meant an nvme controller is involved *with* the RCU splat.
> 
> The qemu nvme driver and qemu controller would be one code run time surface
> to conside here, the two consecutive nvme controller IO timeouts seem
> to be telling of a backlog of some sort:
> 
> [493305.769531] run blktests zbd/006 at 2022-04-14 20:03:55
> [493336.979482] nvme nvme9: I/O 192 QID 5 timeout, aborting
> [493336.981666] nvme nvme9: Abort status: 0x0
> [493367.699440] nvme nvme9: I/O 192 QID 5 timeout, reset controller
> <-- rcu possible stall and NMIs-->
> [493426.706021] nvme nvme9: 8/0/0 default/read/poll queues
> 
> So that seems to be pattern here. First puzzle is *why* we end up with
> the IO timeout on the qemu nvme controller. And for this reason I CC'd
> Klaus, in case he might have any ideas.
> 
> The first "timeout, aborting" happens when we have a first timeout of
> a request for IO tag 192 sent to the controller and it just times out.
> This seems to happen about 30 seconds after the test zbd/006 starts.
> 
> The "reset controller" will happen if we already issued the IO command
> with tag 192 before and had already timed out before and hadn't been returned
> to the driver. Resetting the controller is the stop gap measure.
> 
> The nvme_timeout() is just shared blk_mq_ops between nvme_mq_admin_ops
> and nvme_mq_ops.
> 
> Inspecting the logs of running test zbd/005 and zbd/006 in a loop I can
> see that not all nvme resets of the controller end up in the RCU stall splat
> though.
> 
> The timeout of an IO happens about after 30 seconds the test starts, then
> the reset 30 seconds after that first timeout, then the RCU stall about
> 30 seconds after. For instance follow these now mapped times:
> 
> Apr 13 23:02:33 linux517-blktests-zbd unknown: run blktests zbd/006 at 2022-04-13 23:02:33
> 30 seconds go by ...
> Apr 13 23:03:05 linux517-blktests-zbd kernel: nvme nvme9: I/O 651 QID 3 timeout, aborting
> Apr 13 23:03:05 linux517-blktests-zbd kernel: nvme nvme9: Abort status: 0x0
> 30 seconds go by ...
> Apr 13 23:03:36 linux517-blktests-zbd kernel: nvme nvme9: I/O 651 QID 3 timeout, reset controller
> 30 seconds go by ...
> Apr 13 23:04:04 linux517-blktests-zbd kernel: rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> 
> So the reset happens and yet we stay put. The reset work for the PCI
> nvme controller is on nvme_reset_work() drivers/nvme/host/pci.c and
> I don't see that issue'ing stuff back up the admin queue, however,
> the first IO timeout did send an admin abort, on the same file:
> 
> drivers/nvme/host/pci.c
> static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
> {
> 	...
> 	dev_warn(nvmeq->dev->ctrl.device,                                       
>                 "I/O %d QID %d timeout, aborting\n",                            
>                  req->tag, nvmeq->qid);                                         
>                                                                                 
>         abort_req = blk_mq_alloc_request(dev->ctrl.admin_q, nvme_req_op(&cmd),  
>                                          BLK_MQ_REQ_NOWAIT);                    
>         if (IS_ERR(abort_req)) {                                                
>                 atomic_inc(&dev->ctrl.abort_limit);                             
>                 return BLK_EH_RESET_TIMER;                                      
>         }                                                                       
>         nvme_init_request(abort_req, &cmd);                                     
>                                                                                 
>         abort_req->end_io_data = NULL;                                          
>         blk_execute_rq_nowait(abort_req, false, abort_endio);  
> 	...
> }
> 
> So this is all seems by design. What's puzzling is why it takes
> about 30 seconds to get to the possible RCU stall splat *after* we
> reset the nvme controller. It make me wonder if we left something
> lingering in a black hole somewhere after our first reset. Is it
> right to gather from the RCU splat that whatever it was, it was stuck
> in a long spin lock?

One way that this could happen would be for an earlier RCU grace period
to have taken up the first 9 seconds of that 30-second interval.

Tracing might help here.  The rcu_gp_init() function is invoked at the
beginning of a grace period and the rcu_gp_cleanup() function is invoked
at its end.  Either way, it might be interesting to see how the grace
periods line up with those other events.

Oh, and another way that this sort of thing can happen is if something
prevents the jiffies counter from advancing.  Rare, but it does happen,
for example: https://paulmck.livejournal.com/62071.html

							Thanx, Paul
