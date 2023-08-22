Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78A79EE4996
	for <linux-block@archiver.kernel.org>; Tue, 22 Aug 2023 02:36:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbjHVCgf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Aug 2023 22:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbjHVCge (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Aug 2023 22:36:34 -0400
Received: from out-32.mta1.migadu.com (out-32.mta1.migadu.com [IPv6:2001:41d0:203:375::20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9220F184
        for <linux-block@vger.kernel.org>; Mon, 21 Aug 2023 19:36:32 -0700 (PDT)
Message-ID: <af30544d-981a-ebc9-bed6-5cd979bc688d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1692671790;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LnZ75isbzphwqpWNrDlIwg8VEbSLJKhwo3dHL3iElnA=;
        b=q2dHCMAl2i1lBsXZFkaFTXEPvoSZ7d0FVVswqLN5OVxPdRUHONsLtcImYuzFaDWtWeGdVV
        xBUvCnrBIBwnkHLaX167KiZZFeSk1gIpPr1j1EJqeAiYJiRR4C5PZI/BigHZjY/253qSe8
        cTP3p/im5yXAWL34mGxnrguPieVtBGE=
Date:   Tue, 22 Aug 2023 10:36:24 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 4/4] blk-mq-tag: update or fix functions documentation
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, axboe@kernel.dk,
        ming.lei@redhat.com, hch@lst.de
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhouchengming@bytedance.com
References: <20230821073528.3469210-1-chengming.zhou@linux.dev>
 <20230821073528.3469210-5-chengming.zhou@linux.dev>
 <01b61118-a192-dde2-09aa-de73f2ab2b5c@acm.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <01b61118-a192-dde2-09aa-de73f2ab2b5c@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2023/8/22 05:32, Bart Van Assche wrote:
> On 8/21/23 00:35, chengming.zhou@linux.dev wrote:
>> From: Chengming Zhou <zhouchengming@bytedance.com>
>>
>> There are some misleading or wrong documentation in the functions of
>> blk-mq-tag, update it as we're here.
> 
> Are all changes in this patch updates for documentation that should have been
> updated by commit 2dd6532e9591 ("blk-mq: Drop 'reserved' arg of busy_tag_iter_fn")?
> If not, please move any unrelated changes into a separate patch.
> 
> Please also consider adding the following to this patch:
> 
> Fixes: 2dd6532e9591 ("blk-mq: Drop 'reserved' arg of busy_tag_iter_fn")
> 

Yes, most is related to that commit, will put into two patches.

Thanks.
