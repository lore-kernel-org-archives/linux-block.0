Return-Path: <SRS0=ALdW=7C=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87BADC433E0
	for <linux-block@archiver.kernel.org>; Wed, 20 May 2020 17:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5096F2072C
	for <linux-block@archiver.kernel.org>; Wed, 20 May 2020 17:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589997130;
	bh=ti1WjseTOpUkll0Pp/RDFQPT5PbKehiG1FR9vcyaXhM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DVt54HNDhFEgM9EJAADZ3yJowo2SFEW6G/3cJbFF1OH3r0//ZfgSj1L7ja0o7jqBz
	 qH9xG2hfNY2p52R6Gv3JrwPYnTJoKwW6vE6c33vaz8kBykhA25G00sScg2GKtZKwO5
	 4gSzugz9aqVOioknLYMunwPTAdom6TCQnHFDbbr0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgETRwJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 May 2020 13:52:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:58794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726439AbgETRwJ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 May 2020 13:52:09 -0400
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE89B206B6;
        Wed, 20 May 2020 17:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589997129;
        bh=ti1WjseTOpUkll0Pp/RDFQPT5PbKehiG1FR9vcyaXhM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wU2lOGs3YIURROgGLkLHDx3s8886LDycW8Nd9dp3y6UQfBBMUaJf9UGI89tUv3GxF
         9NeQQC9GeIsSDuSw3d5CeecjsMYuu/xJROjso5QglHAD3jieVa0V8KoyxQwFgBDU+M
         J1dAZ9KnSPAyuYE4zGeY2Pi0JCRuprehvCWKxmOI=
Date:   Thu, 21 May 2020 02:52:02 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     Dongli Zhang <dongli.zhang@oracle.com>
Cc:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Christoph Hellwig <hch@lst.de>,
        Alan Adamson <alan.adamson@oracle.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Max Gurtovoy <maxg@mellanox.com>
Subject: Re: [PATCH 3/3] nvme-pci: make nvme reset more reliable
Message-ID: <20200520175202.GA2151@redsun51.ssa.fujisawa.hgst.com>
References: <20200520115655.729705-1-ming.lei@redhat.com>
 <20200520115655.729705-4-ming.lei@redhat.com>
 <af81f03c-cee9-f1cf-5002-48df43e824db@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af81f03c-cee9-f1cf-5002-48df43e824db@oracle.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 20, 2020 at 10:10:47AM -0700, Dongli Zhang wrote:
> On 5/20/20 4:56 AM, Ming Lei wrote:
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

Looks correct to me. If the queues fail to freeze, that means a timeout
occured, and the nvme timeout handler tears down all online queues, so
this patch uses that for the criteria to break out of the loop. 
