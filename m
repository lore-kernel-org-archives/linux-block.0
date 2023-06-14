Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6AFBEB64D9
	for <linux-block@archiver.kernel.org>; Wed, 14 Jun 2023 19:52:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjFNTwa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Jun 2023 15:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236144AbjFNTwO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Jun 2023 15:52:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A749171C;
        Wed, 14 Jun 2023 12:52:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A0D7C62C2E;
        Wed, 14 Jun 2023 19:52:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA772C433C0;
        Wed, 14 Jun 2023 19:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1686772331;
        bh=2gKSvISyO3HxKQY3iyYvryskJx7dLwZ+tZVjxo3aPUI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nwATheEWDlcp+Q7omM1uH5YNp8Yu7rqGy8L1+P8Yh9xJUpUXLLK5ryTahVG/DWIv6
         RH0FuC1vjh9WF75kz89Tc9LyS/3t/sfAnshvOLIkRzfXJM3bWxalEElkP6XJiQTy6i
         HQT2hOOPEzygav5q95mpM60aPYq4eRxcFaHXWsOg=
Date:   Wed, 14 Jun 2023 12:52:10 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Minchan Kim <minchan@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Brian Geffon <bgeffon@google.com>
Subject: Re: [PATCH] zram: further limit recompression threshold
Message-Id: <20230614125210.3c6b5c1e34e18fbca7f59dae@linux-foundation.org>
In-Reply-To: <20230614141338.3480029-1-senozhatsky@chromium.org>
References: <20230614141338.3480029-1-senozhatsky@chromium.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 14 Jun 2023 23:13:12 +0900 Sergey Senozhatsky <senozhatsky@chromium.org> wrote:

> Recompression threshold should be below huge-size-class
> watermark.

The changelog explains what the code does, but not why it does it?

> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -1753,7 +1753,7 @@ static ssize_t recompress_store(struct device *dev,
>  		}
>  	}
>  
> -	if (threshold >= PAGE_SIZE)
> +	if (threshold >= huge_class_size)
>  		return -EINVAL;
>  
>  	down_read(&zram->init_lock);
> -- 
> 2.41.0.162.gfafddb0af9-goog
