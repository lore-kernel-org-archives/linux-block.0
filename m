Return-Path: <SRS0=sC6v=PZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 202CCC43387
	for <linux-block@archiver.kernel.org>; Thu, 17 Jan 2019 08:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E131D20657
	for <linux-block@archiver.kernel.org>; Thu, 17 Jan 2019 08:20:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728702AbfAQIUz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Jan 2019 03:20:55 -0500
Received: from smtp.ctxuk.citrix.com ([185.25.65.24]:7788 "EHLO
        SMTP.EU.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728331AbfAQIUz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Jan 2019 03:20:55 -0500
X-IronPort-AV: E=Sophos;i="5.56,488,1539648000"; 
   d="scan'208";a="84713258"
Date:   Thu, 17 Jan 2019 09:20:43 +0100
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     Dongli Zhang <dongli.zhang@oracle.com>
CC:     <linux-block@vger.kernel.org>, <xen-devel@lists.xenproject.org>,
        <axboe@kernel.dk>, <linux-kernel@vger.kernel.org>,
        <konrad.wilk@oracle.com>
Subject: Re: [Xen-devel] [PATCH 1/1] xen-blkback: do not wake up shutdown_wq
 after xen_blkif_schedule() is stopped
Message-ID: <20190117082043.7y4gl4uave5pgawf@mac>
References: <1547646461-29803-1-git-send-email-dongli.zhang@oracle.com>
 <20190116145215.igakzdkklc6f7h6k@mac>
 <30770f68-34e0-d707-b087-c43f0b51cd81@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <30770f68-34e0-d707-b087-c43f0b51cd81@oracle.com>
User-Agent: NeoMutt/20180716
X-ClientProxiedBy: AMSPEX02CAS01.citrite.net (10.69.22.112) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jan 17, 2019 at 10:10:00AM +0800, Dongli Zhang wrote:
> Hi Roger,
> 
> On 2019/1/16 下午10:52, Roger Pau Monné wrote:
> > On Wed, Jan 16, 2019 at 09:47:41PM +0800, Dongli Zhang wrote:
> >> There is no need to wake up xen_blkif_schedule() as kthread_stop() is able
> >> to already wake up the kernel thread.
> >>
> >> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> >> ---
> >>  drivers/block/xen-blkback/xenbus.c | 4 +---
> >>  1 file changed, 1 insertion(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/block/xen-blkback/xenbus.c b/drivers/block/xen-blkback/xenbus.c
> >> index a4bc74e..37ac59e 100644
> >> --- a/drivers/block/xen-blkback/xenbus.c
> >> +++ b/drivers/block/xen-blkback/xenbus.c
> >> @@ -254,10 +254,8 @@ static int xen_blkif_disconnect(struct xen_blkif *blkif)
> >>  		if (!ring->active)
> >>  			continue;
> >>  
> >> -		if (ring->xenblkd) {
> >> +		if (ring->xenblkd)
> >>  			kthread_stop(ring->xenblkd);
> >> -			wake_up(&ring->shutdown_wq);
> > 
> > I've now realized that shutdown_wq is basically useless, and should be
> > removed, could you please do it in this patch?
> 
> I do not think shutdown_wq is useless.
> 
> It is used to halt the xen_blkif_schedule() kthread when
> RING_REQUEST_PROD_OVERFLOW() returns true in __do_block_io_op():
> 
> 1121 static int
> 1122 __do_block_io_op(struct xen_blkif_ring *ring)
> ... ...
> 1134         if (RING_REQUEST_PROD_OVERFLOW(&blk_rings->common, rp)) {
> 1135                 rc = blk_rings->common.rsp_prod_pvt;
> 1136                 pr_warn("Frontend provided bogus ring requests (%d - %d =
> %d). Halting ring processing on dev=%04x\n",
> 1137                         rp, rc, rp - rc, ring->blkif->vbd.pdevice);
> 1138                 return -EACCES;
> 1139         }
> 
> 
> If there is bogus/invalid ring requests, __do_block_io_op() would return -EACCES
> without modifying prod/cons index.
> 
> Without shutdown_wq (just simply assuming we remove the below code without
> handling -EACCES in xen_blkif_schedule()), the kernel thread would continue the
> while loop.
> 
> 648                 if (ret == -EACCES)
> 649                         wait_event_interruptible(ring->shutdown_wq,
> 650                                                  kthread_should_stop());
> 
> 
> If xen_blkif_be_int() is triggered again (let's assume there is no optimization
> on guest part and guest would send event for every request it puts on ring
> buffer), we may come to do_block_io_op() again.
> 
> 
> As the prod/cons index are not modified last time the code runs into
> do_block_io_op() to process bogus request, we would hit the bogus request issue
> again.
> 
> 
> With shutdown_wq, the kernel kthread is blocked forever until such queue/ring is
> destroyed. If we remove shutdown_wq, we are changing the policy to handle bogus
> requests on ring buffer?

AFAICT the only wakeup call to shutdown_wq is removed in this patch,
hence waiting on it seems useless. I would replace the
wait_event_interruptible call in xen_blkif_schedule with a break, so
that the kthread ends as soon as a bogus request is found. I think
there's no point in waiting for xen_blkif_disconnect to stop the
kthread.

Thanks, Roger.
