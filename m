Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A5ECC77B73
	for <linux-block@archiver.kernel.org>; Thu, 20 Apr 2023 05:06:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbjDTFGZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Apr 2023 01:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjDTFGY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Apr 2023 01:06:24 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 622C1C1
        for <linux-block@vger.kernel.org>; Wed, 19 Apr 2023 22:06:23 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id EDC9868AFE; Thu, 20 Apr 2023 07:06:19 +0200 (CEST)
Date:   Thu, 20 Apr 2023 07:06:19 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH v2 06/11] block: mq-deadline: Disable head insertion
 for zoned writes
Message-ID: <20230420050619.GC4371@lst.de>
References: <20230418224002.1195163-1-bvanassche@acm.org> <20230418224002.1195163-7-bvanassche@acm.org> <20230419043044.GC25329@lst.de> <e6adbe81-c45f-9801-bee6-a5a7ccad8945@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6adbe81-c45f-9801-bee6-a5a7ccad8945@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Apr 19, 2023 at 03:43:41PM -0700, Bart Van Assche wrote:
>> As said before this is not correct.  What we need to instead is to
>> support proper patch insertation when the at_head flag is set so
>> that the requests get inserted before the existing requests, but
>> in ordered they are passed to the I/O scheduler.
>
> It is not clear to me how this approach should work if the AT_HEAD flag is 
> set for some zoned writes but not for other zoned writes for the same zone? 
> The mq-deadline scheduler uses separate lists for at-head and for other 
> requests. Having to check both lists before dispatching a request would 
> significantly complicate the mq-deadline scheduler.
>
>> This also needs to be done for the other two I/O schedulers.
>
> As far as I know neither Kyber nor BFQ support zoned storage so we don't 
> need to worry about how these schedulers handle zoned writes?

The problem is that we now run into different handling depending
on which kind of write is coming in.  So we need to find a policy
that works for everyone.  Remember that as of the current for-6.4/block
branch the only at_head inservations remaining are:

 - blk_execute* for passthrough requests that never enter the I/O
   scheduler
 - REQ_OP_FLUSH that never enter the I/O scheduler
 - requeues using blk_mq_requeue_request
 - processing of the actual writes in the flush state machine

with the last one going away in my RFC series.

So if we come to the conclusion that requeues from the driver do not
actually need at_head insertations to avoid starvation or similar
we should just remove at_head insertations from the I/O scheduler.
If we can't do that, we need to handle them for zoned writes as well.
