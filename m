Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAC43C001DC
	for <linux-block@archiver.kernel.org>; Mon, 31 Jul 2023 14:07:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233205AbjGaOHC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 31 Jul 2023 10:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233214AbjGaOGb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 31 Jul 2023 10:06:31 -0400
Received: from out-108.mta0.migadu.com (out-108.mta0.migadu.com [IPv6:2001:41d0:1004:224b::6c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B575F1BF2
        for <linux-block@vger.kernel.org>; Mon, 31 Jul 2023 07:03:08 -0700 (PDT)
Message-ID: <0ee17228-4938-6ab7-3fc4-f83a81cbed8f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1690812186;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r0Xei3Zm1daHRy1itcMrY96v4n4keK9eRkuLyVzagVw=;
        b=TEMvXNrOedWtUAvNhNxUCn63M0TflhKOVoQv6pbBqSyv4ssJuB04UMHaTB2RGgcjK6dvs9
        csYU2Dyo2TSJzhu0xhGLALuExTFl5Y6sXE1N5ONmqiEcD4pkE9EgJO0k35jJgirJZJ69H4
        PvFk+fScf/B6w8QQCnl5oR3rfPd1anM=
Date:   Mon, 31 Jul 2023 22:02:39 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/4] blk-flush: flush_rq should inherit first_rq's
 cmd_flags
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, hare@suse.de
Cc:     axboe@kernel.dk, ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhouchengming@bytedance.com
References: <20230725130102.3030032-1-chengming.zhou@linux.dev>
 <20230725130102.3030032-2-chengming.zhou@linux.dev>
 <20230731060957.GA30409@lst.de>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20230731060957.GA30409@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2023/7/31 14:09, Christoph Hellwig wrote:
> On Tue, Jul 25, 2023 at 09:00:59PM +0800, chengming.zhou@linux.dev wrote:
>> From: Chengming Zhou <zhouchengming@bytedance.com>
>>
>> The cmd_flags in blk_kick_flush() should inherit the original request's
>> cmd_flags, but the current code looks buggy to me:
> 
> Should it?  I know the code is kinda trying to do it, but does it really
> make sense?  Adding Hannes who originally added this inheritance and
> discussing the details below:

I'm not sure, actually I don't get what the current code is doing...
Hope Hannes could provide some details.

blk_flush_complete_seq(rq) -> blk_kick_flush(rq->cmd_flags)

flush_rq will use the cmd_flags of request which just complete a sequence,
there are three cases:

1. blk_insert_flush(rq):	rq is pending, wait for flush
2. flush_end_io(flush_rq):	rq flush seq done
3. mq_flush_data_end_io(rq):	rq data seq done

Only in the 1st case, the rq is the pending request that wait for flush_rq.
In the 2nd and 3rd cases, the rq has nothing to do with the next flush_rq?

So it's more reasonable for flush_rq to use its pending first_rq's cmd_flags?

> 
>>  	flush_rq->cmd_flags = REQ_OP_FLUSH | REQ_PREFLUSH;
>> -	flush_rq->cmd_flags |= (flags & REQ_DRV) | (flags & REQ_FAILFAST_MASK);
>> +	flush_rq->cmd_flags |= (first_rq->cmd_flags & REQ_DRV) |
>> +			       (first_rq->cmd_flags & REQ_FAILFAST_MASK);
> 
> Two cases here:
> 
>  1) REQ_FAILFAST_MASK:  I don't think this is actually set on flush request
>     currently, and even if it was applying it to the flush that serves more
>     than a single originating command seems wrong to me.
>  2) REQ_DRV is only set by drivers that have seen a bio.  For dm this
>     is used as REQ_DM_POLL_LIST which should never be set for a flush/fua
>     request.  For nvme-mpath it is REQ_NVME_MPATH, which is set in the
>     bio based driver and used for decision making in the I/O completion
>     handler.  So I guess this one actually does need to get passed
>     through.
> 

The commit 84fca1b0c461 ("block: pass failfast and driver-specific flags to
flush requests") says:
If flush requests are being sent to the device we need to inherit the
failfast and driver-specific flags, too, otherwise I/O will fail.

1) REQ_FAILFAST_MASK: agree, shouldn't set to the flush_rq I think?
2) REQ_DRV: I don't get why this flag not set would cause I/O fail?

Thanks!
