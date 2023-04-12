Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99420C7619A
	for <linux-block@archiver.kernel.org>; Wed, 12 Apr 2023 09:35:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbjDLJfR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Apr 2023 05:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231605AbjDLJfE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Apr 2023 05:35:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFDC5E54
        for <linux-block@vger.kernel.org>; Wed, 12 Apr 2023 02:35:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 712FC62A05
        for <linux-block@vger.kernel.org>; Wed, 12 Apr 2023 09:35:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8009C4339B;
        Wed, 12 Apr 2023 09:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681292101;
        bh=t7mMtSxCmFw57sq+AarIIAqDyNm8UmJaY4L7fulocnY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ZGeIMTjxIVKG5EzAiIR895Am3CFKbORMQfImU/neLf5fYOsEqkjeAFQ8UAUdiZo0f
         SYz4maxcKYe5ZWwsuoZqmCKuRgWg0ApOEw1zhlf6bpPbCA1ib26zVtY53q0jnAgRI8
         HUfdSBObLr0KpxRJZMweq58w9Q6YWCAgNVhoxWfqz8QB38epnbwi0qr0Qxz9xDglga
         lXf7pSh8ykTQa+w0I33XxjJVGmogkRMTfgr5weB2YVZMCu9Ic0JjzEce4aucskkaFo
         yfqRonOtsAQit9ze+d14DsT8c9xCRxI9wB3EiNzvhWp3LzcXfd6KQwZxee0tLaVyKq
         xBMPfrztIdttA==
Message-ID: <82eb6864-479f-42e0-b2d0-783152e39c97@kernel.org>
Date:   Wed, 12 Apr 2023 18:34:59 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 0/1] null_blk: allow user to set QUEUE_FLAG_NOWAIT
Content-Language: en-US
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "johannes.thumshirn@wdc.com" <johannes.thumshirn@wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "vincent.fu@samsung.com" <vincent.fu@samsung.com>,
        "shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>,
        "yukuai3@huawei.com" <yukuai3@huawei.com>
References: <20230412084730.51694-1-kch@nvidia.com>
 <9d9b3d51-6d38-d6ad-b38b-ed7e287c097b@nvidia.com>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <9d9b3d51-6d38-d6ad-b38b-ed7e287c097b@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/12/23 17:50, Chaitanya Kulkarni wrote:
> + dlemoal@kenrel.org.

Missplelled email address

