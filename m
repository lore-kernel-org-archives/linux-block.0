Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F554C7619A
	for <linux-block@archiver.kernel.org>; Wed, 12 Apr 2023 06:57:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjDLG5I (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Apr 2023 02:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjDLG5H (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Apr 2023 02:57:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6699D5260
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2023 23:57:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 024E262885
        for <linux-block@vger.kernel.org>; Wed, 12 Apr 2023 06:57:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD645C433D2;
        Wed, 12 Apr 2023 06:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681282626;
        bh=VpECB9OAnOmbEWTD+vGvyeBs4GpG6NHk5ReiWwMW0NA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=tPgkjWzsUlPZ/FGU2voe0WqKMZIH5SmqHFvd/jGx6X0lz3gIioNdcQcCJk+dJ6aRT
         UiN855mwl2Dafv4JTrBrtJemsJaXF8TLupb1noetfUzEVYbA6gSRgzoavVhhkDOoe0
         Y+fjo7YUEe8SaLnMXmANVG7XslCWhs0fRax5n5sv5Jjj/fU4+SFCojuEbPRltQE/YR
         3uOM9FcmQPs53KUvP3+9T1Wlgvg5ZU/bJXOqrfAbSbiuXoCYRRuXLuZCmhRlG6OImJ
         fi9iyC5MoP9Y/HWyCYvoSNTecgcZy1Q8pxjoGZpxqdUwZFfppv9EFnlvuqcb4TZWos
         eZZ4+C0Q9MjWA==
Message-ID: <c0b7dcce-d76f-4469-f14e-4d3bb365a7d1@kernel.org>
Date:   Wed, 12 Apr 2023 15:57:04 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 02/18] blk-mq: remove blk-mq-tag.h
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org
References: <20230412053248.601961-1-hch@lst.de>
 <20230412053248.601961-3-hch@lst.de>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230412053248.601961-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/12/23 14:32, Christoph Hellwig wrote:
> blk-mq-tag.h is always included by blk-mq.h, and causes recursive
> inclusion hell with further changes.  Just merge it into blk-mq.h
> instead.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


