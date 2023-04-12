Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D6F3C7619A
	for <linux-block@archiver.kernel.org>; Wed, 12 Apr 2023 07:26:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbjDLH0o (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Apr 2023 03:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbjDLH0n (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Apr 2023 03:26:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C6BB8
        for <linux-block@vger.kernel.org>; Wed, 12 Apr 2023 00:26:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 10CC162EBD
        for <linux-block@vger.kernel.org>; Wed, 12 Apr 2023 07:26:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C57E1C433D2;
        Wed, 12 Apr 2023 07:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681284401;
        bh=DYBYin0LRTwO0x6lwmbLHkTMpyYtohUo3SSULVjXDIE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ciOL8T0s+FGsRT53nxrnLRwwleDsNjOYHWQ1lxYZqwaazqZfmAPEZyQhoJ40Vy//3
         wjmnmr5rifQx6XYc2ZKaHeZyxxr8tiKvh2cNk/d2XmwTaKWt62hVt8lastsfhTFeW6
         gDhT/35dtH+1/0jwkDnCUeGmYx5h68Th5gkGRCCyLzHJE7ogfXCPez5lMdnjTiNuqv
         jS+cddx8M5TN/MHC/UrXZMXDFUXkYPpnFf2kVz0f86o+ytsmNzNCWDiQASnrN5+njt
         b5UyBIZfV3meY2lo9f0R7l43hizlNlussDfyTzWbkQCkwgzUQ2MXElrJPlhjk3AMOB
         /ExCzwVq13WMg==
Message-ID: <426ec574-fbfa-8f61-57d6-c2d3a7e46398@kernel.org>
Date:   Wed, 12 Apr 2023 16:26:39 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 12/18] blk-mq: factor out a blk_mq_get_budget_and_tag
 helper
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org
References: <20230412053248.601961-1-hch@lst.de>
 <20230412053248.601961-13-hch@lst.de>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230412053248.601961-13-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/12/23 14:32, Christoph Hellwig wrote:
> Factor out a helper from __blk_mq_try_issue_directly in preparation
> of folding that function into its two callers.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


