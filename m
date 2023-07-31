Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1018C001E0
	for <linux-block@archiver.kernel.org>; Mon, 31 Jul 2023 14:16:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbjGaOQF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 31 Jul 2023 10:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232159AbjGaOQC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 31 Jul 2023 10:16:02 -0400
Received: from out-124.mta0.migadu.com (out-124.mta0.migadu.com [IPv6:2001:41d0:1004:224b::7c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F2F18E
        for <linux-block@vger.kernel.org>; Mon, 31 Jul 2023 07:16:00 -0700 (PDT)
Message-ID: <259badcd-fa15-8194-9e2c-d8fc2e1593bd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1690812958;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HeEUzkF79lBXq57+RcWU7yI9W3Zv3/3872M0/6uzT64=;
        b=kXyeW4VLIyxM2Kd43Odk825OSkOAWSg9lTDqnMryr8+pCYzakVHv8fTGpA6abcE3ToQoae
        2hQJwpvTkU5dX4lDhwnjVjlKjIe5fL4oVqfQQg0YODN8bCPshl0iBawr/BMTWW3XzOj447
        2XIyErv5QiNf2cgmbAtI+QjVzMRVbHw=
Date:   Mon, 31 Jul 2023 22:15:46 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/4] blk-flush: split queues for preflush and postflush
 requests
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhouchengming@bytedance.com
References: <20230725130102.3030032-1-chengming.zhou@linux.dev>
 <20230725130102.3030032-3-chengming.zhou@linux.dev>
 <20230731061521.GB30409@lst.de>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20230731061521.GB30409@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2023/7/31 14:15, Christoph Hellwig wrote:
>> -	list_for_each_entry_safe(rq, n, running, queuelist) {
>> +	list_for_each_entry_safe(rq, n, preflush_running, queuelist) {
>> +		unsigned int seq = blk_flush_cur_seq(rq);
>> +
>> +		BUG_ON(seq != REQ_FSEQ_PREFLUSH && seq != REQ_FSEQ_POSTFLUSH);
>> +		blk_flush_complete_seq(rq, fq, seq, error);
>> +	}
>> +
>> +	list_for_each_entry_safe(rq, n, postflush_running, queuelist) {
>>  		unsigned int seq = blk_flush_cur_seq(rq);
>>  
>>  		BUG_ON(seq != REQ_FSEQ_PREFLUSH && seq != REQ_FSEQ_POSTFLUSH);
> 
> Shouldn't the BUG_ON be split into one that only checks for PREFLUSH and
> one only for POSTFLUSH?

Ah yes, will fix it.

> 
>> +	if (fq->flush_pending_idx != fq->flush_running_idx)
>> +		return;
>> +
>> +	if (!list_empty(preflush_pending))
>> +		first_rq = list_first_entry(preflush_pending, struct request, queuelist);
>> +	else if (!list_empty(postflush_pending))
>> +		first_rq = list_first_entry(postflush_pending, struct request, queuelist);
>> +	else
>>  		return;
> 
> Hmm, I don't think both lists can be empty here?

Yes if check fq->flush_pending_since != 0 before.

> 
> I'd simplify this and avoid the overly long lines as:
> 
> 	first_rq = list_first_entry_or_null(preflush_pending, struct request,
> 					    queuelist);
> 	if (!first_rq)
> 		first_rq = list_first_entry_or_null(postflush_pending,
> 						    struct request, queuelist);
> 

This is better, will change it.

Thanks.

