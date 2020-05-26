Return-Path: <SRS0=PnPs=7I=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E8B3C433E0
	for <linux-block@archiver.kernel.org>; Tue, 26 May 2020 07:13:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3EDC2053B
	for <linux-block@archiver.kernel.org>; Tue, 26 May 2020 07:13:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JO3vhnYw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbgEZHNH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 May 2020 03:13:07 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:41761 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727037AbgEZHNH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 May 2020 03:13:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590477185;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WN2N/BApCYukmkn4MbWXrd3uuV84H0MyGafZbyYspsU=;
        b=JO3vhnYwOgg9JZ5JQL8N9oAuk+mTOco6vY143m5wTCLf8+rmNcuPg6imi1t/4jxUtCUiv0
        t4FfcY9Ecn3DZxvagwUQof+v3YTxo58zUtN1UKOCWu3AOMHeV9J5GkS84K2P7KCI0Eg5HH
        ht+xxgBLm+N+4Ecr5e3bbXZUGvk3Bco=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-123-0MO6C4EJPqafACJvQy18mg-1; Tue, 26 May 2020 03:13:04 -0400
X-MC-Unique: 0MO6C4EJPqafACJvQy18mg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B36EA18FE860;
        Tue, 26 May 2020 07:13:01 +0000 (UTC)
Received: from T590 (ovpn-12-134.pek2.redhat.com [10.72.12.134])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9839719D7C;
        Tue, 26 May 2020 07:12:53 +0000 (UTC)
Date:   Tue, 26 May 2020 15:12:49 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Dongli Zhang <dongli.zhang@oracle.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Alan Adamson <alan.adamson@oracle.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>,
        Max Gurtovoy <maxg@mellanox.com>
Subject: Re: [PATCH 3/3] nvme-pci: make nvme reset more reliable
Message-ID: <20200526071249.GA874504@T590>
References: <20200520115655.729705-1-ming.lei@redhat.com>
 <20200520115655.729705-4-ming.lei@redhat.com>
 <9c5ac1e0-b5ca-0f54-5ee3-fd630dbdb8d4@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c5ac1e0-b5ca-0f54-5ee3-fd630dbdb8d4@oracle.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, May 25, 2020 at 10:01:18PM -0700, Dongli Zhang wrote:
> 
> 
> On 5/20/20 4:56 AM, Ming Lei wrote:
> > During waiting for in-flight IO completion in reset handler, timeout
> 
> Does this indicate the window since nvme_start_queues() in nvme_reset_work(),
> that is, just after the queues are unquiesced again?

Right, nvme_start_queues() starts to dispatch requests again, and
nvme_wait_freeze() waits completion of all these in-flight IOs.

> 
> If v2 is required in the future, how about to mention the specific function to
> that it would be much more easier to track the issue.

Not sure it is needed, cause it is quite straightforward.

> 
> > or controller failure still may happen, then the controller is deleted
> > and all inflight IOs are failed. This way is too violent.
> > 
> > Improve the reset handling by replacing nvme_wait_freeze with query
> > & check controller. If all ns queues are frozen, the controller is reset
> > successfully, otherwise check and see if the controller has been disabled.
> > If yes, break from the current recovery and schedule a fresh new reset.
> > 
> > This way avoids to failing IO & removing controller unnecessarily.
> > 
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: Sagi Grimberg <sagi@grimberg.me>
> > Cc: Keith Busch <kbusch@kernel.org>
> > Cc: Max Gurtovoy <maxg@mellanox.com>
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  drivers/nvme/host/pci.c | 37 ++++++++++++++++++++++++++++++-------
> >  1 file changed, 30 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> > index ce0d1e79467a..b5aeed33a634 100644
> > --- a/drivers/nvme/host/pci.c
> > +++ b/drivers/nvme/host/pci.c
> > @@ -24,6 +24,7 @@
> >  #include <linux/io-64-nonatomic-lo-hi.h>
> >  #include <linux/sed-opal.h>
> >  #include <linux/pci-p2pdma.h>
> > +#include <linux/delay.h>
> >  
> >  #include "trace.h"
> >  #include "nvme.h"
> > @@ -1235,9 +1236,6 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
> >  	 * shutdown, so we return BLK_EH_DONE.
> >  	 */
> >  	switch (dev->ctrl.state) {
> > -	case NVME_CTRL_CONNECTING:
> > -		nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DELETING);
> > -		/* fall through */
> >  	case NVME_CTRL_DELETING:
> >  		dev_warn_ratelimited(dev->ctrl.device,
> >  			 "I/O %d QID %d timeout, disable controller\n",
> > @@ -2393,7 +2391,8 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
> >  		u32 csts = readl(dev->bar + NVME_REG_CSTS);
> >  
> >  		if (dev->ctrl.state == NVME_CTRL_LIVE ||
> > -		    dev->ctrl.state == NVME_CTRL_RESETTING) {
> > +		    dev->ctrl.state == NVME_CTRL_RESETTING ||
> > +		    dev->ctrl.state == NVME_CTRL_CONNECTING) {
> >  			freeze = true;
> >  			nvme_start_freeze(&dev->ctrl);
> >  		}
> > @@ -2504,12 +2503,29 @@ static void nvme_remove_dead_ctrl(struct nvme_dev *dev)
> >  		nvme_put_ctrl(&dev->ctrl);
> >  }
> >  
> > +static bool nvme_wait_freeze_and_check(struct nvme_dev *dev)
> > +{
> > +	bool frozen;
> > +
> > +	while (true) {
> > +		frozen = nvme_frozen(&dev->ctrl);
> > +		if (frozen)
> > +			break;
> 
> ... and how about to comment that the below is because of nvme timeout handler
> as explained in another email (if v2 would be sent) so that it is not required
> to query for "online_queues" with cscope :)
> 
> > +		if (!dev->online_queues)
> > +			break;
> > +		msleep(5);

Fine.


Thanks,
Ming

