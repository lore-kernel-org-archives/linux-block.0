Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3157EB64DC
	for <linux-block@archiver.kernel.org>; Tue, 11 Jul 2023 11:06:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbjGKLGb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Jul 2023 07:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbjGKLGa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Jul 2023 07:06:30 -0400
Received: from out-4.mta0.migadu.com (out-4.mta0.migadu.com [91.218.175.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5528A9B
        for <linux-block@vger.kernel.org>; Tue, 11 Jul 2023 04:06:28 -0700 (PDT)
Message-ID: <4431d779-e6e7-aff1-5cf8-4147de974d8d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1689073586;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qMioJTi4y2yktAcf9xKDTRkg/Tfq6T8MUKYPAN6XQNE=;
        b=JncusKNOhbbD+6X8VyMjkP3dbCPVKOB1W1YoXAImaqaMgwRb9fNudqbjZOdocOW5r3XCdy
        C/AXSJWtBOzGXaStNlFu75e9xwwqTeTc+hbsboLj+OxpiXUGTW/ZlmqsreKCVf2o+Mn1OR
        Dc3XDamu2g9nOnoJ6cXPbYQc4A1sz0s=
Date:   Tue, 11 Jul 2023 19:06:20 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] blk-flush: fix rq->flush.seq for post-flush requests
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhouchengming@bytedance.com
References: <20230710064705.1847287-1-chengming.zhou@linux.dev>
 <20230710133024.GA23157@lst.de>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20230710133024.GA23157@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2023/7/10 21:30, Christoph Hellwig wrote:
> On Mon, Jul 10, 2023 at 02:47:04PM +0800, chengming.zhou@linux.dev wrote:
>> From: Chengming Zhou <zhouchengming@bytedance.com>
>>
>> If the policy == (REQ_FSEQ_DATA | REQ_FSEQ_POSTFLUSH), it means that the
>> data sequence and post-flush sequence need to be done for this request.
>>
>> The rq->flush.seq should record what sequences have been done (or don't
>> need to be done). So in this case, pre-flush doesn't need to be done,
>> we should init rq->flush.seq to REQ_FSEQ_PREFLUSH not REQ_FSEQ_POSTFLUSH.
>>
>> Of course, this doesn't cause any problem in fact, since pre-flush and
>> post-flush sequence do the same thing for now.
> 
> I wonder if it really doesn't cause any problems, but the change for
> sure looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> It should probably go before your other flush optimizations and maybe
> grow a fixes tag.

Ok, will add a Fixes tag and send it as a separate patch since it's a bug fix.

Thanks.

