Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72677EB64DC
	for <linux-block@archiver.kernel.org>; Thu, 29 Jun 2023 06:46:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbjF2GqG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Jun 2023 02:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232277AbjF2GpO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Jun 2023 02:45:14 -0400
Received: from out-23.mta0.migadu.com (out-23.mta0.migadu.com [91.218.175.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B2A2D62
        for <linux-block@vger.kernel.org>; Wed, 28 Jun 2023 23:44:49 -0700 (PDT)
Message-ID: <585417dc-674d-5efc-c1dd-417ba9092228@linux.dev>
Date:   Thu, 29 Jun 2023 14:44:33 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v3 2/3] blk-mq: ktime_get_ns() only once for batched
 requests init
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, tj@kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhouchengming@bytedance.com,
        ming.lei@redhat.com
References: <20230628124546.1056698-1-chengming.zhou@linux.dev>
 <20230628124546.1056698-3-chengming.zhou@linux.dev>
 <20230629053001.GE16819@lst.de>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20230629053001.GE16819@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2023/6/29 13:30, Christoph Hellwig wrote:
> Can we just stash the start time into blk_mq_alloc_data instead of
> passing down yet another parameter?
> 

Yes, it's much better.

Thanks.

