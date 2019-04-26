Return-Path: <SRS0=I+xz=S4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D5BFC43218
	for <linux-block@archiver.kernel.org>; Fri, 26 Apr 2019 15:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DD0220675
	for <linux-block@archiver.kernel.org>; Fri, 26 Apr 2019 15:11:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbfDZPLb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 Apr 2019 11:11:31 -0400
Received: from verein.lst.de ([213.95.11.211]:46620 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726169AbfDZPLb (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Apr 2019 11:11:31 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id AA35B227A81; Fri, 26 Apr 2019 17:11:14 +0200 (CEST)
Date:   Fri, 26 Apr 2019 17:11:14 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        Keith Busch <keith.busch@intel.com>,
        linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        Dongli Zhang <dongli.zhang@oracle.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Subject: Re: [PATCH V7 9/9] nvme: hold request queue's refcount in ns's
 whole lifetime
Message-ID: <20190426151114.GB20438@lst.de>
References: <20190424110221.17435-1-ming.lei@redhat.com> <20190424110221.17435-10-ming.lei@redhat.com> <20190424162746.GE23854@lst.de> <20190425010030.GD22636@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190425010030.GD22636@ming.t460p>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Apr 25, 2019 at 09:00:31AM +0800, Ming Lei wrote:
> The issue is driver(NVMe) specific, the race window is just between
> between blk_cleanup_queue() and removing the ns from the controller namspace
> list in nvme_ns_remove()

And I wouldn't be surprised if others have the same issue.

> 
> blk_mq_init_queue() does hold one refcount, and its counter-part is
> blk_cleanup_queue().
> 
> It is simply ugly to ask blk_mq_init_queue() to grab a refcnt for driver,
> then who is the counter-part for releasing the extra refcount?

Well, the problem is exactly that blk_cleanup_queue drops the reference.
If move the blk_put_queue() call from the end of it to the callers the
callers can keep the reference as long as they need them, and we wouldn't
need an extra reference.
