Return-Path: <SRS0=t9QE=7D=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91B95C433E0
	for <linux-block@archiver.kernel.org>; Thu, 21 May 2020 02:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DB642067B
	for <linux-block@archiver.kernel.org>; Thu, 21 May 2020 02:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K0jboNhx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbgEUCd6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 May 2020 22:33:58 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:23440 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726833AbgEUCd6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 May 2020 22:33:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590028436;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1f8/IfrcNATH3gWolOTKS3pgAESBVnyPUIRUgUI3NFE=;
        b=K0jboNhx7AbaDmOu5rEE09J/FF/0MG1/7QIkyS90u9jVmuP6zk9+ftNna0T1xzuy8OVlLc
        WuXfr0Z4NVEQxdWFm8BWJFdPawXv5KOXkMPoc9NbInxsGEd8V6PHk4Yc+AuLp8407YCwzS
        Yp/KmlZQEt/KXFahh64YmZRFsqSniCI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-493-U5SsDQg8MYWglF8P8MJiDQ-1; Wed, 20 May 2020 22:33:51 -0400
X-MC-Unique: U5SsDQg8MYWglF8P8MJiDQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2FD5F80183C;
        Thu, 21 May 2020 02:33:50 +0000 (UTC)
Received: from T590 (ovpn-13-123.pek2.redhat.com [10.72.13.123])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A83DB60C05;
        Thu, 21 May 2020 02:33:42 +0000 (UTC)
Date:   Thu, 21 May 2020 10:33:37 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Dongli Zhang <dongli.zhang@oracle.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Alan Adamson <alan.adamson@oracle.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>,
        Max Gurtovoy <maxg@mellanox.com>
Subject: Re: [PATCH 3/3] nvme-pci: make nvme reset more reliable
Message-ID: <20200521023337.GB730422@T590>
References: <20200520115655.729705-1-ming.lei@redhat.com>
 <20200520115655.729705-4-ming.lei@redhat.com>
 <af81f03c-cee9-f1cf-5002-48df43e824db@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af81f03c-cee9-f1cf-5002-48df43e824db@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 20, 2020 at 10:10:47AM -0700, Dongli Zhang wrote:
> 
> 
> On 5/20/20 4:56 AM, Ming Lei wrote:
> > During waiting for in-flight IO completion in reset handler, timeout
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
> > +		if (!dev->online_queues)
> > +			break;
> > +		msleep(5);
> > +	}
> > +
> > +	return frozen;
> > +}
> > +
> >  static void nvme_reset_work(struct work_struct *work)
> >  {
> >  	struct nvme_dev *dev =
> >  		container_of(work, struct nvme_dev, ctrl.reset_work);
> >  	bool was_suspend = !!(dev->ctrl.ctrl_config & NVME_CC_SHN_NORMAL);
> >  	int result;
> > +	bool reset_done = true;
> >  
> >  	if (WARN_ON(dev->ctrl.state != NVME_CTRL_RESETTING)) {
> >  		result = -ENODEV;
> > @@ -2606,8 +2622,9 @@ static void nvme_reset_work(struct work_struct *work)
> >  		nvme_free_tagset(dev);
> >  	} else {
> >  		nvme_start_queues(&dev->ctrl);
> > -		nvme_wait_freeze(&dev->ctrl);
> > -		nvme_dev_add(dev);
> > +		reset_done = nvme_wait_freeze_and_check(dev);
> 
> Once we arrive at here, it indicates "dev->online_queues >= 2".
> 
> 2601         if (dev->online_queues < 2) {
> 2602                 dev_warn(dev->ctrl.device, "IO queues not created\n");
> 2603                 nvme_kill_queues(&dev->ctrl);
> 2604                 nvme_remove_namespaces(&dev->ctrl);
> 2605                 nvme_free_tagset(dev);
> 2606         } else {
> 2607                 nvme_start_queues(&dev->ctrl);
> 2608                 nvme_wait_freeze(&dev->ctrl);
> 2609                 nvme_dev_add(dev);
> 2610                 nvme_unfreeze(&dev->ctrl);
> 2611         }
> 
> Is there any reason to check "if (!dev->online_queues)" in
> nvme_wait_freeze_and_check()?
> 

nvme_dev_disable() suspends all io queues and admin queue, so dev->online_queues
will become 0 after nvme_dev_disable() is run from timeout handler.


thanks,
Ming

