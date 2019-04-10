Return-Path: <SRS0=Dmuf=SM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB292C10F11
	for <linux-block@archiver.kernel.org>; Wed, 10 Apr 2019 15:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82E4C21741
	for <linux-block@archiver.kernel.org>; Wed, 10 Apr 2019 15:04:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732875AbfDJPEz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Apr 2019 11:04:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43878 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732868AbfDJPEz (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Apr 2019 11:04:55 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 649A22D81A;
        Wed, 10 Apr 2019 15:04:55 +0000 (UTC)
Received: from ming.t460p (ovpn-8-28.pek2.redhat.com [10.72.8.28])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 511781073027;
        Wed, 10 Apr 2019 15:04:43 +0000 (UTC)
Date:   Wed, 10 Apr 2019 23:04:38 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        James Smart <james.smart@broadcom.com>,
        Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH V4 0/2] blk-mq/nvme: cancel request synchronously
Message-ID: <20190410150436.GA23621@ming.t460p>
References: <20190408223122.29844-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190408223122.29844-1-ming.lei@redhat.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Wed, 10 Apr 2019 15:04:55 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 09, 2019 at 06:31:20AM +0800, Ming Lei wrote:
> Hi,
> 
> This patchset introduces blk_mq_complete_request_sync() for canceling
> request synchronously in error handler context, then one race between
> completing request remotely and destroying contoller/queues can be fixed.
> 
> 
> V4:
> 	- drop return value
> 	- don't handle fake timeout
> 
> V3:
> 	- avoid extra cost to blk_mq_complete_request
> 
> V2:
> 	- export via EXPORT_SYMBOL_GPL
> 	- minor commit log change
> 
> Ming Lei (2):
>   blk-mq: introduce blk_mq_complete_request_sync()
>   nvme: cancel request synchronously
> 
>  block/blk-mq.c           | 7 +++++++
>  drivers/nvme/host/core.c | 2 +-
>  include/linux/blk-mq.h   | 1 +
>  3 files changed, 9 insertions(+), 1 deletion(-)
> 
> Cc: Keith Busch <kbusch@kernel.org>
> Cc: Sagi Grimberg <sagi@grimberg.me>
> Cc: Bart Van Assche <bvanassche@acm.org>
> Cc: James Smart <james.smart@broadcom.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: linux-nvme@lists.infradead.org
> 

Hi Jens,

These two patches have been posted for a while, any chance to make them
in v5.1?

Thanks,
Ming
