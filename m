Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E9F1EB64DC
	for <linux-block@archiver.kernel.org>; Tue, 11 Jul 2023 11:52:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbjGKLwX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Jul 2023 07:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbjGKLwU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Jul 2023 07:52:20 -0400
Received: from out-50.mta1.migadu.com (out-50.mta1.migadu.com [95.215.58.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B929136
        for <linux-block@vger.kernel.org>; Tue, 11 Jul 2023 04:52:19 -0700 (PDT)
Message-ID: <6825f687-9573-51eb-bb89-17eadb60f71b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1689076337;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xAlCKMbHrJaFchyjxLhK4XN3M9/LmqiAnoNyHkr0+GY=;
        b=EcPgXd6jVyp0eZFnTWRCJaE4qOA3TO+dNOwpZqCFhTdoSIb4pG5wgivWJtQkYygUMOTwFj
        UBPjPNqkcRVdiX0cyG9sPd4O6jbu7h0AjRCxENcQWrFEqG8SxTGInP4MYhbI1vQwyKV2gq
        R8kVaCHJqWKVuy5SryRBTn0jYz1ImKk=
Date:   Tue, 11 Jul 2023 19:52:11 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] blk-flush: fix rq->flush.seq for post-flush requests
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhouchengming@bytedance.com
References: <20230710064705.1847287-1-chengming.zhou@linux.dev>
 <20230710133024.GA23157@lst.de>
 <4431d779-e6e7-aff1-5cf8-4147de974d8d@linux.dev>
 <20230711113126.GA26978@lst.de>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20230711113126.GA26978@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2023/7/11 19:31, Christoph Hellwig wrote:
> On Tue, Jul 11, 2023 at 07:06:20PM +0800, Chengming Zhou wrote:
>> Ok, will add a Fixes tag and send it as a separate patch since it's a bug fix.
> 
> Btw, it's probably not worth resending patch 2 until we've figured out
> and dealt with the SATA flush regression that Chuck reported.

Ok, I will not resend patch 2. As for the patch 1, should I resend it as a separate patch
or just put it in that series [1] before other flush optimizations ?

I search on the block mail list, find the issue [2] you mentioned, will look into it too.

[1] https://lore.kernel.org/lkml/20230707093722.1338589-1-chengming.zhou@linux.dev/
[2] https://lore.kernel.org/linux-block/7A57C7AE-A51A-4254-888B-FE15CA21F9E9@oracle.com/
