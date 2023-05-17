Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18BEEC77B7A
	for <linux-block@archiver.kernel.org>; Wed, 17 May 2023 00:01:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjEQABe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 May 2023 20:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbjEQABd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 May 2023 20:01:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D92D55A6
        for <linux-block@vger.kernel.org>; Tue, 16 May 2023 17:01:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C046463F5B
        for <linux-block@vger.kernel.org>; Wed, 17 May 2023 00:01:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 663EBC433D2;
        Wed, 17 May 2023 00:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684281691;
        bh=CRwB8XOAAPvyMrbr3+rjSigayuuWroh5QVwT76DavxE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=WEx6cxXhSG3WqTXEGs6wUVCSZ2n9wxRueFwAvTa46J0w58fznR6beTeDQyS+rIFhb
         hhiqgzHCMYC2sz5lop+PIrGBDj2yS/lLxTA0zeUfYSOzDYz2+qH13pzjGDYm9t8CH5
         Yr/1sLvloLSY4G1T8G6w3LadrgfsGsWu0MCOeG8ayGjjjwLmKv7Jmot++fflwTzOiA
         PHOJ/HC9SWpI/3VZd2wnHP2owCSWVFE7uKkRGtiGTDr5czSynQ6Q5Bn7vISENq+kQ2
         gKZIv10cZbbalQiBqPpVYS0VXKxbxM9PB/MoHMnmXbYLMzBK01xwl7BogdHizstqgY
         CwzbrxHBcM9PA==
Message-ID: <30db3b57-d63d-5522-dbce-81c70836fc50@kernel.org>
Date:   Wed, 17 May 2023 09:01:29 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v5 04/11] block: Introduce blk_rq_is_seq_zoned_write()
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
References: <20230516223323.1383342-1-bvanassche@acm.org>
 <20230516223323.1383342-5-bvanassche@acm.org>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230516223323.1383342-5-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/17/23 07:33, Bart Van Assche wrote:
> Introduce the function blk_rq_is_seq_zoned_write(). This function will
> be used in later patches to preserve the order of zoned writes that
> require write serialization.
> 
> This patch includes an optimization: instead of using
> rq->q->disk->part0->bd_queue to check whether or not the queue is
> associated with a zoned block device, use rq->q->disk->queue.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Cc: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

