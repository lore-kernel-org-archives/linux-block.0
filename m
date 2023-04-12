Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 672E8C7619A
	for <linux-block@archiver.kernel.org>; Wed, 12 Apr 2023 07:45:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjDLHpK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Apr 2023 03:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjDLHpI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Apr 2023 03:45:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA1051FEB
        for <linux-block@vger.kernel.org>; Wed, 12 Apr 2023 00:45:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7CF246287A
        for <linux-block@vger.kernel.org>; Wed, 12 Apr 2023 07:45:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BF0DC433EF;
        Wed, 12 Apr 2023 07:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681285506;
        bh=L04/kEmKku3apvix6yyCYqaV1IAs6+5dFwAOBHTLzio=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=QzVrP/nNxYvb2PN0nCsPLf4QqKcALZAIAZNAm2vHYIwYVLKp0xIL0oebVITqQWcra
         vTyFU5Pff1bYI5Ew8Yytq8t7FlDH/k+wfPcG7Q7DoK78JrHZHLV1Y/WVbBbsNGRXqp
         9+YoXhPMtixvSSe8zVJh4/7J957xSRm1wRT26D+NXfkZgS7P8ecrgva0AAodGZsOJN
         1pmcERBzayQ2PiqLprYTq720wthWTNU/KxSHkj0Um2gUijJMxxc9BfmO7fCBHwBXJH
         mvmk57uSTIfWXgs/sbiPd3wGTwcqmLoHRBW3EI/Z9M4Kih9BlLGyq8DDOjI41ZzF97
         0laZ+I1+839jw==
Message-ID: <266c1117-60ca-adaf-2ab6-31e089da6058@kernel.org>
Date:   Wed, 12 Apr 2023 16:45:04 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 16/18] blk-mq: pass a flags argument to
 blk_mq_insert_request
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org
References: <20230412053248.601961-1-hch@lst.de>
 <20230412053248.601961-17-hch@lst.de>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230412053248.601961-17-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/12/23 14:32, Christoph Hellwig wrote:
> Replace the at_head bool with a flags argument that so far only contains
> a single BLK_MQ_INSERT_AT_HEAD value.  This makes it much easier to grep
> for head insertions into the blk-mq dispatch queues.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


