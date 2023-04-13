Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF5EC77B61
	for <linux-block@archiver.kernel.org>; Thu, 13 Apr 2023 06:26:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbjDMG0X (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Apr 2023 02:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjDMG0X (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Apr 2023 02:26:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D1261A1
        for <linux-block@vger.kernel.org>; Wed, 12 Apr 2023 23:26:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1474663BB7
        for <linux-block@vger.kernel.org>; Thu, 13 Apr 2023 06:26:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECCD5C433D2;
        Thu, 13 Apr 2023 06:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681367181;
        bh=fUz0ZriIe3eBGZUzJxFtyk2aaDnPuFBF5TYoT01WupI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=bKrzhEnuRV5/DXAlOERGXZZ4jZIzlvnSfwSw0mIgH1i1pJKuEY9SxGpDMY3X4J2si
         OFqS04a3s2lc9raWzxgsFgMZkSC5R+GY1rE8bIPjXxogZWdh5AHH/UyIPg7FwRhbvc
         vhWycPWZu9/5nRVcCApSM4tbnl5p4cUIlkAiOd88WY4wsvPSc7iTTyaz/RiJEz9xVB
         2iD/LH90NUeJd0kxPqrNYeMdiatlMNKmG+gf2oCv1UzyHxKWfvCuSyHtQ0KifKQjM3
         VyPCa0NYr3MOsPVTiH5q2AEyQAbSdw1QX4eLv7gujNfzkf+udxw2ZEwH8FL6ja1LUj
         Pgod5DABH9lgg==
Message-ID: <5afa0807-2813-43c3-fbc0-a135148397ab@kernel.org>
Date:   Thu, 13 Apr 2023 15:26:19 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 3/5] blk-mq: move the blk_mq_hctx_stopped check in
 __blk_mq_delay_run_hw_queue
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
References: <20230413060651.694656-1-hch@lst.de>
 <20230413060651.694656-4-hch@lst.de>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230413060651.694656-4-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/13/23 15:06, Christoph Hellwig wrote:
> For the in-context dispatch, blk_mq_hctx_stopped is alredy checked in
> blk_mq_sched_dispatch_requests under blk_mq_run_dispatch_ops() protetion.
> For the async dispatch case having a check before scheduling the work
> still makes sense to avoid needless workqueue scheduling, so just keep
> it for that case.

s/alredy/already
s/protetion/protection

Otherwise looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


