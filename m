Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 889B7EB64D7
	for <linux-block@archiver.kernel.org>; Thu, 22 Jun 2023 01:16:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbjFVBQb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Jun 2023 21:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjFVBQ3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Jun 2023 21:16:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C7B41BCD
        for <linux-block@vger.kernel.org>; Wed, 21 Jun 2023 18:16:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E40C3616F8
        for <linux-block@vger.kernel.org>; Thu, 22 Jun 2023 01:16:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE9E5C433C8;
        Thu, 22 Jun 2023 01:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687396587;
        bh=if8fDXK0YO0BA6d+ionkkTzpmMaJ3Aq/p948NPjSX+Y=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=POv+CREt/h0JMBjSszdGZz7ENkVA4SkZOJZW7MHaTlkKqlwOZTesQLDFtuMHHLQMP
         9S7K4P5feYqFoGBjTEUdsqfX2U9EuoD7A92kEZGmocZwEgdLfTPIOZVuXE/p8KJsRe
         /d4ToGHOHHOZimNSSO6DBsiQQqRTfSde/UCTqLKlupzq1hiaya4xPFFuoDL5lwFwCi
         yL/uMxW49D2o0deit1a1S8GD+VOoM5XU6pcpmM1S8Clf6bSp49hcV0yyT7DOJj18VO
         n8j+fZ2TxJKy9roiIHYWuJ0YsIFDbWOzIvxIxAHXKLJZiYSGst+gZXBytfC7mcJj56
         ULrjS+PbdfinA==
Message-ID: <303dfb03-88ee-dbee-bbfb-ab0b1f67db24@kernel.org>
Date:   Thu, 22 Jun 2023 10:16:25 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4 2/7] block: Simplify blk_mq_requeue_work()
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>
References: <20230621201237.796902-1-bvanassche@acm.org>
 <20230621201237.796902-3-bvanassche@acm.org>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230621201237.796902-3-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/22/23 05:12, Bart Van Assche wrote:
> Move common code in front of the if-statement.
> 
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Damien Le Moal <dlemoal@kernel.org>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Mike Snitzer <snitzer@kernel.org>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

