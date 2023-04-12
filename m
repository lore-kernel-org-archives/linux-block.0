Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 252CDC77B6E
	for <linux-block@archiver.kernel.org>; Wed, 12 Apr 2023 07:50:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbjDLHt7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Apr 2023 03:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbjDLHt5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Apr 2023 03:49:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F7EE659A
        for <linux-block@vger.kernel.org>; Wed, 12 Apr 2023 00:49:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7DD3B62EED
        for <linux-block@vger.kernel.org>; Wed, 12 Apr 2023 07:49:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63FDBC4339B;
        Wed, 12 Apr 2023 07:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681285784;
        bh=X8LWpaV1BpxCliG2Fipg5VdR590+I/3AteMdTt6Q/kE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=POJvoK/iRNt/edjmqS//Y3QxP+OEKa5wdDZmj7ldYeir4BW9GpxDmKeD50GqxGSpm
         zGIjWkjFumop92ejyyM512hjvdBlB/MkgU64cGfQuUtz04gbpKFZGmuQV9CB4LeYvK
         8lTCQMYraAl3mzUCUYhalhv3ZzLHC238i85h3X+jZEuBK03KZve70fSGbGaYr+f79Z
         Z/AvvplP7860tF1QsQHQ0AQF74iIBQKIdI+Nj/sBo98DsjfHPsa/uiQHNYObVjYpN8
         SwZzbJd1/mGGjprGQpUUv5dGlK3N+ReKFDUN+9P4huKBAC/Wpwiwj+QaiQW15dL0UO
         7L6w+chJ9630Q==
Message-ID: <d9f83625-3d74-53c2-1c23-972d63470ab9@kernel.org>
Date:   Wed, 12 Apr 2023 16:49:43 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 1/2] blk-mq: call blk_mq_hctx_stopped in
 __blk_mq_run_hw_queue
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
References: <20230412063743.618957-1-hch@lst.de>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230412063743.618957-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/12/23 15:37, Christoph Hellwig wrote:
> Instead of calling blk_mq_hctx_stopped in both callers, move it right
> next to the dispatching.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


