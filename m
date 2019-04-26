Return-Path: <SRS0=I+xz=S4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EDA0C43218
	for <linux-block@archiver.kernel.org>; Fri, 26 Apr 2019 22:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 581B72077B
	for <linux-block@archiver.kernel.org>; Fri, 26 Apr 2019 22:49:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbfDZWtf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 Apr 2019 18:49:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38542 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726410AbfDZWtf (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Apr 2019 18:49:35 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 02C3130BCBF6;
        Fri, 26 Apr 2019 22:49:35 +0000 (UTC)
Received: from ming.t460p (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B5126194A0;
        Fri, 26 Apr 2019 22:49:25 +0000 (UTC)
Date:   Sat, 27 Apr 2019 06:49:20 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <keith.busch@intel.com>,
        Hannes Reinecke <hare@suse.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        Sagi Grimberg <sagi@grimberg.me>, linux-scsi@vger.kernel.org,
        Dongli Zhang <dongli.zhang@oracle.com>,
        James Smart <james.smart@broadcom.com>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <bart.vanassche@wdc.com>
Subject: Re: [PATCH V7 9/9] nvme: hold request queue's refcount in ns's whole
 lifetime
Message-ID: <20190426224919.GE31470@ming.t460p>
References: <20190424110221.17435-1-ming.lei@redhat.com>
 <20190424110221.17435-10-ming.lei@redhat.com>
 <20190424162746.GE23854@lst.de>
 <20190425010030.GD22636@ming.t460p>
 <20190426151114.GB20438@lst.de>
 <1556298263.161891.152.camel@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556298263.161891.152.camel@acm.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Fri, 26 Apr 2019 22:49:35 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Apr 26, 2019 at 10:04:23AM -0700, Bart Van Assche wrote:
> On Fri, 2019-04-26 at 17:11 +0200, Christoph Hellwig wrote:
> > On Thu, Apr 25, 2019 at 09:00:31AM +0800, Ming Lei wrote:
> > > The issue is driver(NVMe) specific, the race window is just between
> > > between blk_cleanup_queue() and removing the ns from the controller namspace
> > > list in nvme_ns_remove()
> > 
> > And I wouldn't be surprised if others have the same issue.
> > 
> > > 
> > > blk_mq_init_queue() does hold one refcount, and its counter-part is
> > > blk_cleanup_queue().
> > > 
> > > It is simply ugly to ask blk_mq_init_queue() to grab a refcnt for driver,
> > > then who is the counter-part for releasing the extra refcount?
> > 
> > Well, the problem is exactly that blk_cleanup_queue drops the reference.
> > If move the blk_put_queue() call from the end of it to the callers the
> > callers can keep the reference as long as they need them, and we wouldn't
> > need an extra reference.
> 
> Hi Christoph,
> 
> There are more than hundred callers of blk_cleanup_queue() so that change
> would cause a lot of churn. Since blk_get_queue() and blk_put_queue() are
> available, how inserting a pair of calls to these functions where necessary?

The problem is that queue might be used after blk_cleanup_queue() is
returned by some drivers.

Gendisk is removed before cleanup queue, and the other activities on queue
depends on driver itself. There can't be universal way to deal with that.

Thanks,
Ming
