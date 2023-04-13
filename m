Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33E2DC77B61
	for <linux-block@archiver.kernel.org>; Thu, 13 Apr 2023 06:23:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjDMGXv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Apr 2023 02:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbjDMGXv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Apr 2023 02:23:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E2A772A8
        for <linux-block@vger.kernel.org>; Wed, 12 Apr 2023 23:23:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B4CD63571
        for <linux-block@vger.kernel.org>; Thu, 13 Apr 2023 06:23:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A6B7C433EF;
        Thu, 13 Apr 2023 06:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681367029;
        bh=znkB9xh9ran6OfnvBJLy2Ba8XoKI4L//ucndYk0XZ3Y=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=GHunDtGANCjWVxV+rG2ZlGJWRZHemtr0Qaeg/r6wwV7wmYjc5uuCOrg6OJgHdfy6a
         nJbZvFMq5gofQdSteaILlKnHw24CuixiJ0dIiT1yUmL891akZM8sltoJ0fl5hv22e2
         n2/IeoLRi3AXmlFxxh9qAQq/zsPPy4IMpisGHqmRKJA9nGUC7lHtTTyoIFj2WilzKl
         bmiwAFkivWXReTB/B/TbcfnlDIKZGiODJe4Lzidvq3xYEYN/t2FQN77aNcyZtOXjVD
         FQXgHoIQy6EDVPWaO9p48F/KUsH+Mq8itmq57zqNlOgDXMHXqIXfhlcJcLRYS7ggT2
         SIOR+bPa0fBmg==
Message-ID: <85db9dd3-e170-d0c4-0f15-d5fd38ce1a13@kernel.org>
Date:   Thu, 13 Apr 2023 15:23:47 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 1/5] blk-mq: cleanup __blk_mq_sched_dispatch_requests
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
References: <20230413060651.694656-1-hch@lst.de>
 <20230413060651.694656-2-hch@lst.de>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230413060651.694656-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/13/23 15:06, Christoph Hellwig wrote:
> __blk_mq_sched_dispatch_requests currently has duplicated logic
> for the cases where requests are on the hctx dispatch list or not.
> Merge the two with a new need_dispatch variable and remove a few
> pointless local variables.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks OK to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


