Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F898C41513
	for <linux-block@archiver.kernel.org>; Mon, 31 Jul 2023 14:28:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbjGaO2J (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 31 Jul 2023 10:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232641AbjGaO14 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 31 Jul 2023 10:27:56 -0400
Received: from out-93.mta1.migadu.com (out-93.mta1.migadu.com [95.215.58.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17621C9
        for <linux-block@vger.kernel.org>; Mon, 31 Jul 2023 07:27:52 -0700 (PDT)
Message-ID: <1f9f6c41-6b67-ef33-f7d0-9c0e42a231c9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1690813670;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dx5Chf3zAqMy7M8DF/JIJ8L29UssARWG699WHErf97A=;
        b=MfjwhR8BZuEFjG1ucDLPH2LY7TqklIan4Ec2BIIK5NbhcovgxY7fIiA812JJEueLJA2rkP
        r2OjluZ2upRIuKF8j5OVD+lO2gnKW+jE8YiORAMBJhCQGkjKlbLg/1tkG8pBnpBaom0qH5
        W6DBUJ7MsZy7hBbXOD3XlWA6vpImZq8=
Date:   Mon, 31 Jul 2023 22:27:25 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v2 3/4] blk-flush: kill the flush state machine
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhouchengming@bytedance.com
References: <20230725130102.3030032-1-chengming.zhou@linux.dev>
 <20230725130102.3030032-4-chengming.zhou@linux.dev>
 <20230731061937.GC30409@lst.de>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20230731061937.GC30409@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2023/7/31 14:19, Christoph Hellwig wrote:
> On Tue, Jul 25, 2023 at 09:01:01PM +0800, chengming.zhou@linux.dev wrote:
>> From: Chengming Zhou <zhouchengming@bytedance.com>
>>
>> Since now we put preflush and postflush requests in separate queues,
>> we don't need the flush sequence to record anymore.
>>
>> REQ_FSEQ_PREFLUSH: blk_enqueue_preflush()
>> REQ_FSEQ_POSTFLUSH: blk_enqueue_postflush()
>> REQ_FSEQ_DONE: blk_end_flush()
>>
>> In blk_flush_complete(), we have two list to handle: preflush_running
>> and postflush_running. We just blk_end_flush() directly for postflush
>> requests, but need to move preflush requests to requeue_list to
>> dispatch.
>>
>> This patch just kill the flush state machine and directly call these
>> functions, in preparation for the next patch.
> 
>> +static void blk_enqueue_postflush(struct request *rq, struct blk_flush_queue *fq)
> 
> Please avoid the overly long here.  Maybe just rename enqueue to queue
> here and for the preflush version as we don't really use enqueue in
> the flush code anyway.

Ok, will rename to queue.

> 
>> +{
>> +	unsigned int nr_requeue = 0;
>> +	struct list_head *preflush_running;
>> +	struct list_head *postflush_running;
>> +	struct request *rq, *n;
>> +
>> +	preflush_running = &fq->preflush_queue[fq->flush_running_idx];
>> +	postflush_running = &fq->postflush_queue[fq->flush_running_idx];
> 
> I'd initialize these ad declaration time:
> 
> 	struct list_head *preflush_running =
> 		&fq->preflush_queue[fq->flush_running_idx];
> 	struct list_head *postflush_running =
> 		&fq->postflush_queue[fq->flush_running_idx];
> 	unsigned int nr_requeue = 0;
> 	struct request *rq, *n;
> 

LGTM, will change these.

Thanks for your review!

>> +
>> +	list_for_each_entry_safe(rq, n, postflush_running, queuelist) {
>> +		blk_end_flush(rq, fq, error);
>>  	}
> 
> No need for the braces.
> 
