Return-Path: <SRS0=lHMQ=S2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24AAFC10F11
	for <linux-block@archiver.kernel.org>; Wed, 24 Apr 2019 16:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F27AA208E4
	for <linux-block@archiver.kernel.org>; Wed, 24 Apr 2019 16:19:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730818AbfDXQTM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Apr 2019 12:19:12 -0400
Received: from verein.lst.de ([213.95.11.211]:55028 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730035AbfDXQTM (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Apr 2019 12:19:12 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 58B3C67358; Wed, 24 Apr 2019 18:18:56 +0200 (CEST)
Date:   Wed, 24 Apr 2019 18:18:56 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Hannes Reinecke <hare@suse.com>,
        Keith Busch <keith.busch@intel.com>,
        linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        Dongli Zhang <dongli.zhang@oracle.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Subject: Re: [PATCH V7 2/9] blk-mq: move cancel of requeue_work into
 blk_mq_release
Message-ID: <20190424161856.GB23854@lst.de>
References: <20190424110221.17435-1-ming.lei@redhat.com> <20190424110221.17435-3-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424110221.17435-3-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Apr 24, 2019 at 07:02:14PM +0800, Ming Lei wrote:
> With holding queue's kobject refcount, it is safe for driver
> to schedule requeue. However, blk_mq_kick_requeue_list() may
> be called after blk_sync_queue() is done because of concurrent
> requeue activities, then requeue work may not be completed when
> freeing queue, and kernel oops is triggered.
> 
> So moving the cancel of requeue_work into blk_mq_release() for
> avoiding race between requeue and freeing queue.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
