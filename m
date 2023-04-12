Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3704C77B72
	for <linux-block@archiver.kernel.org>; Wed, 12 Apr 2023 07:17:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbjDLHRx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Apr 2023 03:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjDLHRx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Apr 2023 03:17:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D83499
        for <linux-block@vger.kernel.org>; Wed, 12 Apr 2023 00:17:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA75C61043
        for <linux-block@vger.kernel.org>; Wed, 12 Apr 2023 07:17:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B32DCC433D2;
        Wed, 12 Apr 2023 07:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681283871;
        bh=4s8orPR8XNayzO4EcxnoHtbmSjUq+l2buIcDSVdU7/0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=uhH+vvSd+d7+bpfrrCMuGAO49PZCtaESLgt7WMQ7UZhD+hc3jotdd2SYAQcK3VHYS
         TjOISrmpmNqC6tC4nYpf78eWHrwkkveGfY47iDbnQEfqMLvINHtaiHHEioLfLnC3IX
         bhzx8O8+NA5dQhyjoQbGYPEczsJBEeZDye97GTAurpngtebLH3olF1SvSbtb6Rijkx
         3rGUiscssIuQx3K0q/yx2eiqgf4POK9/9ZY46ArcQT8f1I+QZ+ko+E5QFvlSRUy4HE
         I1AyVMGEs8GSA0gL52h0fTmcyFPs1YT+LPrkRnV+KnS5MZwp8Q+/9oZu3kU8kjSj9A
         ObfLJYlN0VhAw==
Message-ID: <06aba60b-c3ee-05c5-c9f9-47a568ff51c4@kernel.org>
Date:   Wed, 12 Apr 2023 16:17:49 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 09/18] blk-mq: remove blk_flush_queue_rq
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org
References: <20230412053248.601961-1-hch@lst.de>
 <20230412053248.601961-10-hch@lst.de>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230412053248.601961-10-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/12/23 14:32, Christoph Hellwig wrote:
> Just call blk_mq_add_to_requeue_list directly from the two callers.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


