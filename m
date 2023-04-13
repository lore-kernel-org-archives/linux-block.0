Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 146D7C77B6C
	for <linux-block@archiver.kernel.org>; Thu, 13 Apr 2023 06:28:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbjDMG2E (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Apr 2023 02:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjDMG2D (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Apr 2023 02:28:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9E717DAA
        for <linux-block@vger.kernel.org>; Wed, 12 Apr 2023 23:28:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 845BD611B9
        for <linux-block@vger.kernel.org>; Thu, 13 Apr 2023 06:28:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A103C433D2;
        Thu, 13 Apr 2023 06:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681367280;
        bh=XaIkh9S5y2aXMBLv+giiqilwgW+dkw6UDRp8nYKFKeo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=PDnjKkgDAFlpmSBLw8xDOm6BGJFiWrbgkDvH5VLukW3wHc/pU3ti65OdpkDDNLJN0
         gnVZHBSyebXMofy0n3K5G7SgU8TA1SObs9Kws+aWXsIXCta8YvKIr2Ehy1sD5xtLl6
         D/WsN0kXw/m3uhEIXLP0CNkv9vVnL+L1UYHWlrayznWDh4kEM9JaZraxMdj+5kNVGG
         hzXAERYJgXrk6VZc5Wz/PGZTJMdOP8VnD5d41yuukaWHeaiV7SmRjxiwJZ05iPfA9E
         tH8ZOMTMbyPB510lUykEo9btzZHMY7Umw0iU+0++O8OrVx857KWMMfjrpVW0sZguk/
         HlyoNL0+BGkJw==
Message-ID: <d8f608bf-8b05-4e10-09cb-01f50a275b1c@kernel.org>
Date:   Thu, 13 Apr 2023 15:27:59 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 5/5] blk-mq: remove __blk_mq_run_hw_queue
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
References: <20230413060651.694656-1-hch@lst.de>
 <20230413060651.694656-6-hch@lst.de>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230413060651.694656-6-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/13/23 15:06, Christoph Hellwig wrote:
> __blk_mq_run_hw_queue just contains a WARN_ON_ONCE for calls from
> interrupt context and a blk_mq_run_dispatch_ops-protected call to
> blk_mq_sched_dispatch_requests.  Open code the call to
> blk_mq_sched_dispatch_requests in both callers, and move the WARN_ON_ONCE
> to blk_mq_run_hw_queue where it can be extented to all !async calls,

s/extented/extended

> while the other call is from workqueue context and thus obviously does
> not need the assert.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


