Return-Path: <SRS0=cXaM=S3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B919C10F11
	for <linux-block@archiver.kernel.org>; Thu, 25 Apr 2019 01:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A1CC206BA
	for <linux-block@archiver.kernel.org>; Thu, 25 Apr 2019 01:00:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728317AbfDYBAr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Apr 2019 21:00:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51224 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726455AbfDYBAr (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Apr 2019 21:00:47 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DB9F885A07;
        Thu, 25 Apr 2019 01:00:46 +0000 (UTC)
Received: from ming.t460p (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 47C684A8;
        Thu, 25 Apr 2019 01:00:35 +0000 (UTC)
Date:   Thu, 25 Apr 2019 09:00:31 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Hannes Reinecke <hare@suse.com>,
        Keith Busch <keith.busch@intel.com>,
        linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        Dongli Zhang <dongli.zhang@oracle.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Subject: Re: [PATCH V7 9/9] nvme: hold request queue's refcount in ns's whole
 lifetime
Message-ID: <20190425010030.GD22636@ming.t460p>
References: <20190424110221.17435-1-ming.lei@redhat.com>
 <20190424110221.17435-10-ming.lei@redhat.com>
 <20190424162746.GE23854@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424162746.GE23854@lst.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Thu, 25 Apr 2019 01:00:47 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Apr 24, 2019 at 06:27:46PM +0200, Christoph Hellwig wrote:
> On Wed, Apr 24, 2019 at 07:02:21PM +0800, Ming Lei wrote:
> > Hennes reported the following kernel oops:
> 
> Hannes?
> 
> > +	if (!blk_get_queue(ns->queue)) {
> > +		ret = -ENXIO;
> > +		goto out_free_queue;
> > +	}
> 
> If we always need to hold a reference, shouldn't blk_mq_init_queue
> return with that reference held (and yes, that means changes to
> every driver, but it seems like we need to audit all of them anyway..)

The issue is driver(NVMe) specific, the race window is just between
between blk_cleanup_queue() and removing the ns from the controller namspace
list in nvme_ns_remove()

blk_mq_init_queue() does hold one refcount, and its counter-part is
blk_cleanup_queue().

It is simply ugly to ask blk_mq_init_queue() to grab a refcnt for driver,
then who is the counter-part for releasing the extra refcount?

> 
> It seems like the queue lifetimes are a bit of a mess, and I'm not sure
> if this just papers over the problem.

Could you explain a bit what the mess is?


Thanks,
Ming
