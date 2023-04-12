Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6BFCC7619A
	for <linux-block@archiver.kernel.org>; Wed, 12 Apr 2023 07:15:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbjDLHP3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Apr 2023 03:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjDLHP2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Apr 2023 03:15:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4500FF1
        for <linux-block@vger.kernel.org>; Wed, 12 Apr 2023 00:15:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC4EF628AD
        for <linux-block@vger.kernel.org>; Wed, 12 Apr 2023 07:15:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90E82C433D2;
        Wed, 12 Apr 2023 07:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681283726;
        bh=GyU1lHmHxp6M2qcOWF+qs5mCTOoYsENXqjTRZjf1cpY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=TUiz/rBi1MkAdkMpuT1t0sVTwIBG8C72Y7qGD84TSi7Ibs99G94RWdLtzigqGqFZc
         WyAUZ9oBU4ux12Ol8Ft6+oe2nC1uc5pvkXL7Td2hUJWajpbcCTsugqLWmvkwfc7YSV
         ED2rocbAxD7NjEyPKN/zekX1kB0ohfGQIPRkjidPfdYQwmPkGzFcFQDKK5jB2digvu
         EYV2HIldI8Y4IvhpQsfptAc6W4NKkmPj/LmY+tNYJ+jttvEigUqH6ZN3dQYReZRTNR
         heA9spsXHUTPPLCifVubnZw15riRemllI4Fiyu7Xh1aTi3A+SGhgwaDP35L3uNmc6h
         WlWlKVWfD8IFw==
Message-ID: <66b58339-401c-a243-acc0-28790d97ac0e@kernel.org>
Date:   Wed, 12 Apr 2023 16:15:24 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 07/18] blk-mq: fold __blk_mq_insert_request into
 blk_mq_insert_request
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org
References: <20230412053248.601961-1-hch@lst.de>
 <20230412053248.601961-8-hch@lst.de>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230412053248.601961-8-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/12/23 14:32, Christoph Hellwig wrote:
> There is no good point in keeping the __blk_mq_insert_request around
> for two function calls and a singler caller.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>



