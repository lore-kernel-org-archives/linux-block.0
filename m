Return-Path: <SRS0=I+xz=S4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 938B4C43218
	for <linux-block@archiver.kernel.org>; Fri, 26 Apr 2019 22:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6665C2077B
	for <linux-block@archiver.kernel.org>; Fri, 26 Apr 2019 22:45:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbfDZWp6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 Apr 2019 18:45:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:22386 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726410AbfDZWp6 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Apr 2019 18:45:58 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AE42B30BC5DC;
        Fri, 26 Apr 2019 22:45:57 +0000 (UTC)
Received: from ming.t460p (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B75FE5C21F;
        Fri, 26 Apr 2019 22:45:48 +0000 (UTC)
Date:   Sat, 27 Apr 2019 06:45:43 +0800
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
Message-ID: <20190426224542.GD31470@ming.t460p>
References: <20190424110221.17435-1-ming.lei@redhat.com>
 <20190424110221.17435-10-ming.lei@redhat.com>
 <20190424162746.GE23854@lst.de>
 <20190425010030.GD22636@ming.t460p>
 <20190426151114.GB20438@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190426151114.GB20438@lst.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Fri, 26 Apr 2019 22:45:58 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Apr 26, 2019 at 05:11:14PM +0200, Christoph Hellwig wrote:
> On Thu, Apr 25, 2019 at 09:00:31AM +0800, Ming Lei wrote:
> > The issue is driver(NVMe) specific, the race window is just between
> > between blk_cleanup_queue() and removing the ns from the controller namspace
> > list in nvme_ns_remove()
> 
> And I wouldn't be surprised if others have the same issue.

SCSI hasn't such issue, and loop/null/virtio-blk doesn't too.

> 
> > 
> > blk_mq_init_queue() does hold one refcount, and its counter-part is
> > blk_cleanup_queue().
> > 
> > It is simply ugly to ask blk_mq_init_queue() to grab a refcnt for driver,
> > then who is the counter-part for releasing the extra refcount?
> 
> Well, the problem is exactly that blk_cleanup_queue drops the reference.
> If move the blk_put_queue() call from the end of it to the callers the
> callers can keep the reference as long as they need them, and we wouldn't
> need an extra reference.

It depends on driver.

Still no difference between your suggestion and the way in this patch, given
driver specific change is a must. Even it is more clean to hold the
queue refocunt by drivers explicitly because we usually do the get/put pair
in one place, instead that getting refcnt in one subsystem, and doing put in
another place.

I am going to drop this patch in V8 since my original plan is to fix block
layer's race in this patchset.


Thanks,
Ming
