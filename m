Return-Path: <SRS0=cXaM=S3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DFDFC10F03
	for <linux-block@archiver.kernel.org>; Thu, 25 Apr 2019 05:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1A2C217FA
	for <linux-block@archiver.kernel.org>; Thu, 25 Apr 2019 05:32:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725942AbfDYFcw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Apr 2019 01:32:52 -0400
Received: from verein.lst.de ([213.95.11.211]:59161 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725900AbfDYFcw (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Apr 2019 01:32:52 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 4CA0168AA6; Thu, 25 Apr 2019 07:32:34 +0200 (CEST)
Date:   Thu, 25 Apr 2019 07:32:34 +0200
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
Subject: Re: [PATCH V7 1/9] blk-mq: grab .q_usage_counter when queuing
 request from plug code path
Message-ID: <20190425053234.GA7166@lst.de>
References: <20190424110221.17435-1-ming.lei@redhat.com> <20190424110221.17435-2-ming.lei@redhat.com> <20190424161834.GA23854@lst.de> <20190425005332.GB22636@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190425005332.GB22636@ming.t460p>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Apr 25, 2019 at 08:53:34AM +0800, Ming Lei wrote:
> It isn't in other callers of blk_mq_sched_insert_requests(), it is just
> needed in some corner case like flush plug context.
> 
> For other callers of blk_mq_sched_insert_requests(), it is guaranteed
> that request queue's ref is held.

In both Linus' tree and Jens' for-5.2 tree I only see these two
callers of blk_mq_sched_insert_requests.  What am I missing?
