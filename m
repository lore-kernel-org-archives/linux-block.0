Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71803C83F10
	for <linux-block@archiver.kernel.org>; Sun, 27 Aug 2023 09:11:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbjH0JKv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 27 Aug 2023 05:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbjH0JKY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 27 Aug 2023 05:10:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE89CE;
        Sun, 27 Aug 2023 02:10:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B6A3960B4D;
        Sun, 27 Aug 2023 09:10:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB386C433C8;
        Sun, 27 Aug 2023 09:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693127419;
        bh=3ENdR8Avkv75G4jC4qHBHUxW3T7qirhqAhfGDTz/D2E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RChM+iOTrbdxzULLZXjs7Y0KsjcL8P/0KxZ3absd1RpyoBR64VJ2Kcx+8VyJGN8u4
         +bup9H8gIkaEbMNYacFHo/DFaEUJUWJl5PvC/Oja+UGggtQ0b5+363V2+H9hb+xsZc
         ZuUVVEgOrjMBbJAqe1j84x0P3B7aBYfkzsjUHnM8=
Date:   Sun, 27 Aug 2023 11:10:16 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     stable@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 6.1 -stable] ublk: remove check IO_URING_F_SQE128 in
 ublk_ch_uring_cmd
Message-ID: <2023082709-whisking-pruning-28d0@gregkh>
References: <20230824052203.1751458-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230824052203.1751458-1-ming.lei@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Aug 24, 2023 at 01:22:03PM +0800, Ming Lei wrote:
> commit 9c7c4bc986932218fd0df9d2a100509772028fb1 upstream
> 
> sizeof(struct ublksrv_io_cmd) is 16bytes, which can be held in 64byte SQE,
> so not necessary to check IO_URING_F_SQE128.
> 
> With this change, we get chance to save half SQ ring memory.
> 
> Fixed: 71f28f3136af ("ublk_drv: add io_uring based userspace block driver")
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> Link: https://lore.kernel.org/r/20230220041413.1524335-1-ming.lei@redhat.com
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>  drivers/block/ublk_drv.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index f48d213fb65e..09d29fa53939 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -1271,9 +1271,6 @@ static int ublk_ch_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags)
>  			__func__, cmd->cmd_op, ub_cmd->q_id, tag,
>  			ub_cmd->result);
>  
> -	if (!(issue_flags & IO_URING_F_SQE128))
> -		goto out;
> -
>  	if (ub_cmd->q_id >= ub->dev_info.nr_hw_queues)
>  		goto out;
>  
> -- 
> 2.40.1
> 

Now queued up, thanks.

greg k-h
