Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93FCDC77B6E
	for <linux-block@archiver.kernel.org>; Thu, 13 Apr 2023 14:03:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbjDMOD5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Apr 2023 10:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbjDMOD4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Apr 2023 10:03:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DEF1901A
        for <linux-block@vger.kernel.org>; Thu, 13 Apr 2023 07:03:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 09B6F63EE0
        for <linux-block@vger.kernel.org>; Thu, 13 Apr 2023 14:03:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C317C433D2;
        Thu, 13 Apr 2023 14:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681394627;
        bh=PmE5nxO2Vww94XAom/7Da8+ydx/U57Fw7OD9Uabfns0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s7B3bND8wGztzpxThTVPUp5dUTf5o2kkZFeJ3azgJGHbLmRv/ztQPubZNi+BQUymt
         sSZ841vkGpeWH6eu2pbto4wT3xNwSHwCLy+ZGjUDTBOQCvDuxJGSn1EJ0tPSx9rRIf
         uY5FWKsAy9tZV5vReTQI31O5vR4GN60EYzgYIlXLmZ5Ns1E35qsHEZU/fYnZhovwoL
         dXv6/wIygppND/l8JdQO9gepgKsgaG9j/7CAgvH3pgjc3e2vgaBcGAu3h4553ddv06
         48O2CDWvbG89ePA9PTZfZsTyjrK618cmG7nDNys4QCDAG+N4lKFmqqn+1c5tbzW8ji
         CN0ND99bXB95g==
Date:   Thu, 13 Apr 2023 07:03:45 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Chaitanya Kulkarni <kch@nvidia.com>
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk, hch@lst.de,
        sagi@grimberg.me, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] block: fix Oops in blk_rq_poll_completion()
Message-ID: <ZDgLwcxill+2WTie@kbusch-mbp>
References: <20230413091419.6124-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230413091419.6124-1-kch@nvidia.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Apr 13, 2023 at 02:14:19AM -0700, Chaitanya Kulkarni wrote:
> Add a NULL check before we poll on req->bio in blk_rq_poll_completion().
> Without this patch blktests/nvme/047 fails :-
> 
> * Debug-diff:-
> 
> linux-block (for-next) # git diff
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 1b304f66f4e8..31473f55b374 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1335,6 +1335,8 @@ EXPORT_SYMBOL_GPL(blk_rq_is_poll);
>  static void blk_rq_poll_completion(struct request *rq, struct completion *wait)
>  {
>         do {
> +               if (!rq->bio)
> +                       BUG_ON(1);
>                 bio_poll(rq->bio, NULL, 0);
>                 cond_resched();
>         } while (!completion_done(wait));

This is already fixed upstream and stable.
