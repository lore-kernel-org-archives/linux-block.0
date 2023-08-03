Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAAF2C001DF
	for <linux-block@archiver.kernel.org>; Thu,  3 Aug 2023 15:36:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236773AbjHCPgG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Aug 2023 11:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236112AbjHCPgF (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Aug 2023 11:36:05 -0400
Received: from out-126.mta0.migadu.com (out-126.mta0.migadu.com [91.218.175.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24CE535B5
        for <linux-block@vger.kernel.org>; Thu,  3 Aug 2023 08:36:02 -0700 (PDT)
Message-ID: <405ef35e-5998-789f-8577-897b4cdf7e71@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1691076960;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iNA9YhdOKBVSAzWkF33UHYzrNYmZHaHsWeYw1qfwm/k=;
        b=ejXhT62QbtY87EsgGl7l1TPJY2FsA7iXeQsd2omraTlTBqu7ck6bOEwaNJpo3GnSKx87IL
        cjW+P5s76dFQYOLrZkSq7iAbPzB9uMf4WSCZWoUzWtL2Mh0OlAPhesOvMGau47Vixo1VAy
        KXfdf47JFacpbHHwwISN+M2tWogod2A=
Date:   Thu, 3 Aug 2023 23:35:34 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/4] blk-flush: flush_rq should inherit first_rq's
 cmd_flags
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>
Cc:     axboe@kernel.dk, ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhouchengming@bytedance.com
References: <20230725130102.3030032-1-chengming.zhou@linux.dev>
 <20230725130102.3030032-2-chengming.zhou@linux.dev>
 <20230731060957.GA30409@lst.de>
 <de6ba52c-0f14-670f-7262-93f2aced926a@suse.de> <20230801110432.GA2781@lst.de>
 <20230801110607.GB2781@lst.de>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20230801110607.GB2781@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2023/8/1 19:06, Christoph Hellwig wrote:
> On Tue, Aug 01, 2023 at 01:04:32PM +0200, Christoph Hellwig wrote:
>> On Mon, Jul 31, 2023 at 06:28:01PM +0200, Hannes Reinecke wrote:
>>> The flush machinery is sending flushes before and/or after the original 
>>> request (preflush/postflush). For blocked transports (ie during FC RSCN 
>>> handling) the transport will error out commands depending on the FAILFAST 
>>> setting. If FAILFAST is set the SCSI layer gets an STS_TRANSPORT error 
>>> (causing the I/O to be retried), but STS_ERROR if not set (causing I/O to 
>>> failed).
>>>
>>> So if the FAILFAST setting is _not_ aligned between flush_rq and the 
>>> original we'll get an error on the flush rq and a retry on the original rq, 
>>> causing the entire command to fail.
>>>
>>> I guess we need to align them.
>>
>> But you can't, because multiple pre/postflushes are coalesced into a
>> single outstanding flush request.  They can and will not match quite
>> commonly.
> 
> And if you mean the REQ_FAILFAST_TRANSPORT added by dm - this will
> never even see the flush state machine, as that is run in dm-mpath
> which then inserts the fully built flush request into the lower request
> queue.  At least for request based multipath, bio could hit it.

Yes, multiple pre/postflushes are coalesced into a single flush request.
So we can't figure out which request to use.

From the above explanation, can we just drop this inherit logic? It seems
strange or wrong here.

Thanks.
