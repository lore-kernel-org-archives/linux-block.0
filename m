Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D5CC77B6E
	for <linux-block@archiver.kernel.org>; Wed, 12 Apr 2023 07:53:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjDLHxF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Apr 2023 03:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjDLHxD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Apr 2023 03:53:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95468212F
        for <linux-block@vger.kernel.org>; Wed, 12 Apr 2023 00:53:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 30C9B616C2
        for <linux-block@vger.kernel.org>; Wed, 12 Apr 2023 07:53:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15D1AC433D2;
        Wed, 12 Apr 2023 07:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681285981;
        bh=+9vC5DNmsCn7hQQ/XLbVh6gJYPfozXUkHeZmnEen6vo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Ve0K4lBCVXshml+AIzyjF2riLhrkFmmrVzdz41Y//N//HUFh9Tx+BsjnLtstk1t6L
         bhWrPxLckhQbVqsXhm4AC/B/JIrB0oINhN8GjBvgP5D28vNZm9XkwsVntrtyYJp4JG
         6FPQAJwjXN47Aug+KxuunnTpdSmcg1it9qTA803Jbw9rGfOqR20Z4JjMZbRCo3UlN+
         QaJgh8cBV0kKq3g8fBR4WVMSJ7uSII0lh/nmSRB7u/PjWkpxPYsfODHjTv+P3yPSRu
         iN7ow+y+L9oDPxYKPqsrnQ0xmVR73GfCCO2DqfQIcpxt3LyvR/DW4Vc1K8p+YcXho1
         GxtsUxhbIdEVg==
Message-ID: <3bf05197-f758-4fe3-508c-da8bcca993a7@kernel.org>
Date:   Wed, 12 Apr 2023 16:52:59 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 2/2] blk-mq: move the !async handling out of
 __blk_mq_delay_run_hw_queue
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
References: <20230412063743.618957-1-hch@lst.de>
 <20230412063743.618957-2-hch@lst.de>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230412063743.618957-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/12/23 15:37, Christoph Hellwig wrote:
> Only blk_mq_run_hw_queue can call __blk_mq_delay_run_hw_queue with
> async=false, so move the handling there.
> 
> With this __blk_mq_delay_run_hw_queue can be merged into
> blk_mq_delay_run_hw_queue.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks OK to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


