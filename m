Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC849C77B6E
	for <linux-block@archiver.kernel.org>; Wed, 12 Apr 2023 07:22:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjDLHWO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Apr 2023 03:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjDLHWN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Apr 2023 03:22:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 676671713
        for <linux-block@vger.kernel.org>; Wed, 12 Apr 2023 00:22:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 02AF262EB7
        for <linux-block@vger.kernel.org>; Wed, 12 Apr 2023 07:22:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC196C433D2;
        Wed, 12 Apr 2023 07:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681284131;
        bh=E3wRRr5G9QJwTQswOVuthpAZmjzBL1JkO3dCL8FoL8A=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=nVL+KtqQor1/8vSPIgVnBhUQy93KQIHr8beSbplL9E4PBlB7hLbNqiHM5UjZjIkCL
         zzzCVP/hVghS/8biwV5Jvlc6yPXIW3PkC6id1pL/IK4RDbhtKV+mYRHxCj4D+rbrKo
         z5CDCTHF6T/0caOnEjYvg6qHEEeGGvQidQ7Cma3OKzI3mFdNIUlxrz8xT672ochaXz
         YILkr1xaB5sG1i3l1fTCTZ35+GA5k9qw2I9ohmqRxLaY6MdwpH/lKBD0x6JKPVelIu
         ynE38oGyQK/4YyjIhNbmFfO8AhWdHvwkQvktGRc5NS3JPbzAuggdQnQyND99p/z6IC
         AoWyU1WUGNk/Q==
Message-ID: <c7f339e6-a88e-fdc0-20d4-655f4bcadf84@kernel.org>
Date:   Wed, 12 Apr 2023 16:22:09 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 10/18] blk-mq: refactor passthrough vs flush handling in
 blk_mq_insert_request
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org
References: <20230412053248.601961-1-hch@lst.de>
 <20230412053248.601961-11-hch@lst.de>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230412053248.601961-11-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/12/23 14:32, Christoph Hellwig wrote:
> While both passthrough and flush requests call directly into
> blk_mq_request_bypass_insert, the parameters aren't the same.
> Split the handling into two separate conditionals and turn the whole
> function into an if/elif/elif/else flow instead of the gotos.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

