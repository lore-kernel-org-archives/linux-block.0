Return-Path: <SRS0=GE/Q=S5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 578FFC43218
	for <linux-block@archiver.kernel.org>; Sat, 27 Apr 2019 05:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25948208C2
	for <linux-block@archiver.kernel.org>; Sat, 27 Apr 2019 05:55:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726030AbfD0FzL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 27 Apr 2019 01:55:11 -0400
Received: from verein.lst.de ([213.95.11.211]:52181 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726005AbfD0FzL (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 27 Apr 2019 01:55:11 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 154EB68BFE; Sat, 27 Apr 2019 07:54:53 +0200 (CEST)
Date:   Sat, 27 Apr 2019 07:54:53 +0200
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
Message-ID: <20190427055453.GA21483@lst.de>
References: <20190424110221.17435-1-ming.lei@redhat.com> <20190424110221.17435-10-ming.lei@redhat.com> <20190424162746.GE23854@lst.de> <20190425010030.GD22636@ming.t460p> <20190426151114.GB20438@lst.de> <20190426224542.GD31470@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190426224542.GD31470@ming.t460p>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Apr 27, 2019 at 06:45:43AM +0800, Ming Lei wrote:
> Still no difference between your suggestion and the way in this patch, given
> driver specific change is a must. Even it is more clean to hold the
> queue refocunt by drivers explicitly because we usually do the get/put pair
> in one place, instead that getting refcnt in one subsystem, and doing put in
> another place.
> 
> I am going to drop this patch in V8 since my original plan is to fix block
> layer's race in this patchset.

Doing the untegistration and final reference drop is just a bad pattern,
leading to possible bugs.  I'm fine with you just dropping it for now,
I guess I'll just send a scripted conversion moving the put to the drivers
to Jens after -rc1 to sort it out.  Probably including a rename
of blk_cleanup_queue so that everyone notices the difference.
