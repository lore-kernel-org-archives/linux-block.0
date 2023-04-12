Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E089C77B6E
	for <linux-block@archiver.kernel.org>; Wed, 12 Apr 2023 07:07:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjDLHHQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Apr 2023 03:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjDLHHQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Apr 2023 03:07:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E65F4C2C
        for <linux-block@vger.kernel.org>; Wed, 12 Apr 2023 00:07:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE7CE62A16
        for <linux-block@vger.kernel.org>; Wed, 12 Apr 2023 07:07:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0B18C433EF;
        Wed, 12 Apr 2023 07:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681283234;
        bh=fdEXgIMN7FACS87gQG/tGJ8zAtDG2qOXWZpurr5ygYk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Azn53RMLnMprjBpFDbf6ov1nYiTe0NNYtZbigLVqofPFZJiBNHkEWn8RxSIe/EggT
         VJKzbHQFmo3ZuDGY0QIe+nqLKgmRDuzQkHCAgmGw8ayrhzmlQlnp1Wrm+O5idJJP77
         SuQQ/K7JJXFPdvIdHoTGNmFAXvDm3kNih7ede4RbJtLKG8UrVTDZratB1p1fe27P2D
         cFpFYdhQ8Wc2XqokXDpUviHyfXGUdcuk4abg8tUzbQlwTABUacxf1r8451VWYfEURh
         WsMxfX95F2xu2x6dMRgeYcaZGzF2MjC5vkY9JVBX7OkAADgrsGryl+1pV5qLtqzW9H
         LUfBUrSmoql7Q==
Message-ID: <dafdc817-6fb4-487a-f5e5-fc9caf431136@kernel.org>
Date:   Wed, 12 Apr 2023 16:07:12 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 04/18] blk-mq: move more logic into blk_mq_insert_requests
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org
References: <20230412053248.601961-1-hch@lst.de>
 <20230412053248.601961-5-hch@lst.de>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230412053248.601961-5-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/12/23 14:32, Christoph Hellwig wrote:
> Move all logic related to the direct insert into blk_mq_insert_requests
> to clean the code flow up a bit, and to allow marking
> blk_mq_try_issue_list_directly static.

Nit: maybe mention that blk_mq_insert_requests() will now call
blk_mq_run_hw_queue(), just to be clear (even though that is implied by the
"move all logic" statement).

> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>

Looks good to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

