Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16085C77B61
	for <linux-block@archiver.kernel.org>; Mon, 24 Apr 2023 07:01:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjDXHBG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Apr 2023 03:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbjDXHBF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Apr 2023 03:01:05 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 986B513A
        for <linux-block@vger.kernel.org>; Mon, 24 Apr 2023 00:01:04 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 643A06732D; Mon, 24 Apr 2023 09:00:59 +0200 (CEST)
Date:   Mon, 24 Apr 2023 09:00:58 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH v2 06/11] block: mq-deadline: Disable head insertion
 for zoned writes
Message-ID: <20230424070058.GA11830@lst.de>
References: <20230418224002.1195163-1-bvanassche@acm.org> <20230418224002.1195163-7-bvanassche@acm.org> <20230419043044.GC25329@lst.de> <e6adbe81-c45f-9801-bee6-a5a7ccad8945@acm.org> <20230420050619.GC4371@lst.de> <05e3962f-73c8-a721-a457-605243b64e66@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05e3962f-73c8-a721-a457-605243b64e66@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Apr 20, 2023 at 10:00:07AM -0700, Bart Van Assche wrote:
> I'm fine with not inserting requeued requests at the head of the queue. 
> Inserting requeued requests at the head of the queue only preserves the 
> original submission order if a single request is requeued.

Yes.

> If multiple 
> requests are requeued inserting at the head of the queue will cause 
> inversion of the order of the requeued requests.
>
> This implies that the I/O scheduler or disk controller (if no I/O scheduler 
> is configured) will become responsible for optimizing the request order if 
> requeuing happens.

I think we need to understand why these requeues even happen.
Unfortunately blk_mq_requeue_request has quite a few callers, so they'll
need a bit of an audit.

Quite a few are about resource constraints in the hardware and or driver.
In this case I suspect it is essential that they are prioritized over
incoming new commands in the way I suggested before.

A different case is nvme_retry_req with the CRD field set, in which
case we want to wait some time before retrying this particular command,
so having new command bypass it makes sense.

Another one is the SCSI ALUA transition delay, in which case we want
to wait before sending commands to the LU again.  In this case we
really don't want to resend any commands until the delay in kicking
the requeue list.

So I'm really not sure what the right thing to is here.  But I'm
pretty sure just skipping head inserts for zoned locked writes is
even more wrong than what we do right now.  And I also don't see
what it would be useful for.  All zoned writes should either be
locked by higher layers, or even better just use zone append and
just get a new new location assigned when requeing as discussed
before.
