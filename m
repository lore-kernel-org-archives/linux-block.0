Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E4CC433F5
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 18:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC9AB611AE
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 18:43:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbhJSSpP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Oct 2021 14:45:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:53694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230059AbhJSSpO (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Oct 2021 14:45:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 64A7A60FD8;
        Tue, 19 Oct 2021 18:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634668981;
        bh=XJEIl4y9Dc8RponWxNXSpOvH9+HVN7iQ6Mc9b89tFZs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JA/X77Jm6I3R/y73RI1CEkKRXD6Tu/dcdO4FBtFhxIADN/4DiKrh3OlKPlMT+2qzd
         4mgU7OHmxpEVw4h+1/4yWnEOCMN0DVfoT8+ZS/oPVJhqf8mq5BuQlsviodbdwoW9nb
         ikrF5lyBvP8zpRG76KpaBIxqXRwm7BBtiUS8E/Fce8z+cGTvvBChGHXNYBVVaLatYq
         jx+BvuyMc2UheivOrI0/yXxhGsWurzrMYk0w6G8Kh2BQ6d1fejqRKupOJuIPPZ+hAn
         qYn3us4QC32QH7QmvM8e3w187St6KKXtSMOVaJ/lCtGyxm94ZLzz59tGDIdLPtzaY4
         P+LAINLY4W7Lw==
Date:   Tue, 19 Oct 2021 11:42:59 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: Re: [PATCH 1/4] block: add rq_flags to struct blk_mq_alloc_data
Message-ID: <20211019184259.GD2083665@dhcp-10-100-145-180.wdc.com>
References: <20211019153300.623322-1-axboe@kernel.dk>
 <20211019153300.623322-2-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211019153300.623322-2-axboe@kernel.dk>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Oct 19, 2021 at 09:32:57AM -0600, Jens Axboe wrote:
> There's a hole here we can use, and it's faster to set this earlier

<snip>

> @@ -148,6 +148,7 @@ struct blk_mq_alloc_data {
>  	blk_mq_req_flags_t flags;
>  	unsigned int shallow_depth;
>  	unsigned int cmd_flags;
> +	unsigned int rq_flags;
>  
>  	/* allocate multiple requests/tags in one go */
>  	unsigned int nr_tags;

The patch looks good, but the new field doesn't appear to occupy a hole.
