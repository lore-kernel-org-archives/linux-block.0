Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CCE9C001DE
	for <linux-block@archiver.kernel.org>; Tue, 25 Jul 2023 13:16:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjGYNQK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Jul 2023 09:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjGYNQJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Jul 2023 09:16:09 -0400
Received: from out-14.mta0.migadu.com (out-14.mta0.migadu.com [IPv6:2001:41d0:1004:224b::e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B29173F
        for <linux-block@vger.kernel.org>; Tue, 25 Jul 2023 06:16:06 -0700 (PDT)
Message-ID: <d9792de8-aaea-e848-9108-323e8e66a429@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1690290965;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hDKCYqmLWyHXFEhC5Nj4kCjQ8+MggR2zRPLevzxTPPg=;
        b=AT6j2pP3iTuXIwEM6ohKAGMBJoX9RDzGMkQr+qnHxMi4Du1eG9ubu7oHFYfiiF72gxgxyt
        tFS5P3V3EOA0VLvwDcQZGACZHkPq3hsTMzTLlQHRkeV01S/wnbFiFZc4/PIRMexRNP4V78
        2r61ZVk3kzJrbVZxTcJeKlZd0dnUUQw=
Date:   Tue, 25 Jul 2023 21:15:59 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] blk-flush: don't need to end rq twice for non
 post-flush requests
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhouchengming@bytedance.com
References: <20230710064705.1847287-1-chengming.zhou@linux.dev>
 <20230710064705.1847287-2-chengming.zhou@linux.dev>
 <20230710133308.GB23157@lst.de>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20230710133308.GB23157@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2023/7/10 21:33, Christoph Hellwig wrote:
> On Mon, Jul 10, 2023 at 02:47:05PM +0800, chengming.zhou@linux.dev wrote:
>> From: Chengming Zhou <zhouchengming@bytedance.com>
>>
>> Now we unconditionally blk_rq_init_flush() to replace rq->end_io to
>> make rq return twice back to the flush state machine for post-flush.
>>
>> Obviously, non post-flush requests don't need it, they don't need to
>> end request twice, so they don't need to replace rq->end_io callback.
>> And the same for requests with the FUA bit on hardware with FUA support.
>>
>> So we move blk_rq_init_flush() to REQ_FSEQ_DATA stage and only replace
>> rq->end_io if it needs post-flush. Otherwise, it can end like normal
>> request and doesn't need to return back to the flush state machine.
> 
> I really like the idea behind this optimization, but I kinda hate
> adding more magic to the already way too magic flush sequence.

Yes, agree.

> 
> I wonder if a better idea would be to kill the flush sequence entirely,
> and just split the flush_queue into a preflush and a postflush queue.
> This would remove a field from struct request and lead to more readable
> code as well.

I have thought about this for some time, it seems feasible. So I implement it
today and test it using blktests, it works.

I will send the patchset soon.

Thanks.
