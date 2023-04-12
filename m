Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 501F4C7619A
	for <linux-block@archiver.kernel.org>; Wed, 12 Apr 2023 06:58:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbjDLG6p (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Apr 2023 02:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjDLG6o (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Apr 2023 02:58:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F07120
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2023 23:58:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F1DC62E97
        for <linux-block@vger.kernel.org>; Wed, 12 Apr 2023 06:58:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC0C4C433D2;
        Wed, 12 Apr 2023 06:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681282722;
        bh=nQSO+xRRlVKH+nMilwKThYU0h2q67xPQaQMs0NSjmcw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=NERzZfd2SaLsY9EYmN0rwg8tweW1c1NxZOql9FAlRiMQOpR9rT23LNRZc5vgUCwZH
         7qqbEwCUKeziGaxkznUFU8aAS1+XzZSHNWZDGwd/sN+wl97/1KqGU04wYF6oc1ei4w
         U/BqlbUebVyx3i3/gBRA5J8X1HxJdcO1uOJQxMgkivwGqCE8LZYxoHHu0xJ6lRIda7
         CiceEG8kgZOtX5YN2/h5vF6/5216IogjiHPiUuZ4adxXDt83pvECoS0bmG26J6PTAJ
         5pHEcTfH/FfVDjz5X4ULsy4VlGVWu9lTga3L7kggOMSlbj1LPSF6I4+HFR/cZnD7si
         6YLUainZSmoIQ==
Message-ID: <958cf97e-ddff-52a9-d42a-a6fce20144a1@kernel.org>
Date:   Wed, 12 Apr 2023 15:58:40 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 03/18] blk-mq: include <linux/blk-mq.h> in block/blk-mq.h
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org
References: <20230412053248.601961-1-hch@lst.de>
 <20230412053248.601961-4-hch@lst.de>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230412053248.601961-4-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/12/23 14:32, Christoph Hellwig wrote:
> block/blk-mq.h needs various definitions from <linux/blk-mq.h>,
> include it there instead of relying on the source files to include
> both.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


