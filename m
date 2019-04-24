Return-Path: <SRS0=lHMQ=S2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A45C10F11
	for <linux-block@archiver.kernel.org>; Wed, 24 Apr 2019 16:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AF7221900
	for <linux-block@archiver.kernel.org>; Wed, 24 Apr 2019 16:28:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731034AbfDXQ2D (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Apr 2019 12:28:03 -0400
Received: from verein.lst.de ([213.95.11.211]:55112 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730794AbfDXQ2D (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Apr 2019 12:28:03 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id A28AF67358; Wed, 24 Apr 2019 18:27:46 +0200 (CEST)
Date:   Wed, 24 Apr 2019 18:27:46 +0200
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
Subject: Re: [PATCH V7 9/9] nvme: hold request queue's refcount in ns's
 whole lifetime
Message-ID: <20190424162746.GE23854@lst.de>
References: <20190424110221.17435-1-ming.lei@redhat.com> <20190424110221.17435-10-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424110221.17435-10-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Apr 24, 2019 at 07:02:21PM +0800, Ming Lei wrote:
> Hennes reported the following kernel oops:

Hannes?

> +	if (!blk_get_queue(ns->queue)) {
> +		ret = -ENXIO;
> +		goto out_free_queue;
> +	}

If we always need to hold a reference, shouldn't blk_mq_init_queue
return with that reference held (and yes, that means changes to
every driver, but it seems like we need to audit all of them anyway..)

It seems like the queue lifetimes are a bit of a mess, and I'm not sure
if this just papers over the problem.
