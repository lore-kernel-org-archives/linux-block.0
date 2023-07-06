Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 128A5EB64D9
	for <linux-block@archiver.kernel.org>; Thu,  6 Jul 2023 23:41:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbjGFXlz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Jul 2023 19:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjGFXlz (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Jul 2023 19:41:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B3D1BE1
        for <linux-block@vger.kernel.org>; Thu,  6 Jul 2023 16:41:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2AA4A61476
        for <linux-block@vger.kernel.org>; Thu,  6 Jul 2023 23:41:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5E7DC433C8;
        Thu,  6 Jul 2023 23:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688686913;
        bh=XMLTXwJb9TSJlYZQVWVg+vAKVmCWr9vXbOqgTAs7jvY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=tudI53L8VJTMHFp47IYFoPqf6gwNolRGreF2YIJHGZLz9oBP7KCk7iAvxtC3GsD4O
         BOvo4UPrPl9oYp8eFAYJmc7XpBUGR5ghxbvqwOtxIJzonVqqEuLnEmTXJUQto+qJ29
         vBEyMbwCx+vAgUmrCtiTV9MdJqVACIM6MoGI5n0RCC0xqg9DW55mcEsWbJzr/5tdN1
         Va52epLW9vTacPx+irPeyEcEu79duYw/8ZxYsCXDuNC/YoRuq+lvaR1FwK4H1CE9ff
         QzejgcvOQFHU7MK6tUAs4YJFTBTTlKR/3jykRWhLMh4PxneQOkZpMNh2zUbKk89lF0
         QGSGG00liqogg==
Message-ID: <748be866-766c-e307-e0f1-13c6cc57ee5d@kernel.org>
Date:   Fri, 7 Jul 2023 08:41:51 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] block: Fix a source code comment in
 include/uapi/linux/blkzoned.h
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Hannes Reinecke <hare@suse.de>,
        Shaun Tancheff <shaun.tancheff@seagate.com>,
        Damien Le Moal <damien.lemoal@hgst.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20230706201422.3987341-1-bvanassche@acm.org>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230706201422.3987341-1-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/7/23 05:14, Bart Van Assche wrote:
> Fix the symbolic names for zone conditions in the blkzoned.h header
> file.
> 
> Cc: Hannes Reinecke <hare@suse.de>
> Cc: Damien Le Moal <dlemoal@kernel.org>
> Fixes: 6a0cb1bc106f ("block: Implement support for zoned block devices")
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

