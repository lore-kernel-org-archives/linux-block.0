Return-Path: <SRS0=/LTC=27=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D29C282DD
	for <linux-block@archiver.kernel.org>; Fri, 10 Jan 2020 17:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96B5D2146E
	for <linux-block@archiver.kernel.org>; Fri, 10 Jan 2020 17:24:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbgAJRYD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 10 Jan 2020 12:24:03 -0500
Received: from ms.lwn.net ([45.79.88.28]:52070 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726114AbgAJRYB (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 10 Jan 2020 12:24:01 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 89CE07DA;
        Fri, 10 Jan 2020 17:24:00 +0000 (UTC)
Date:   Fri, 10 Jan 2020 10:23:59 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     jgq516@gmail.com
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: Re: [PATCH] docs: block/biovecs: update the location of bio.c
Message-ID: <20200110102359.6adf4a37@lwn.net>
In-Reply-To: <20200106103735.10327-1-guoqing.jiang@cloud.ionos.com>
References: <20200106103735.10327-1-guoqing.jiang@cloud.ionos.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon,  6 Jan 2020 11:37:35 +0100
jgq516@gmail.com wrote:

> From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
> 
> Replace fs with block since bio.c had been moved to block folder.
> 
> Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
> ---
>  Documentation/block/biovecs.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/block/biovecs.rst b/Documentation/block/biovecs.rst
> index 86fa66c87172..ad303a2569d3 100644
> --- a/Documentation/block/biovecs.rst
> +++ b/Documentation/block/biovecs.rst
> @@ -47,7 +47,7 @@ Having a real iterator, and making biovecs immutable, has a number of
>  advantages:
>  
>   * Before, iterating over bios was very awkward when you weren't processing
> -   exactly one bvec at a time - for example, bio_copy_data() in fs/bio.c,
> +   exactly one bvec at a time - for example, bio_copy_data() in block/bio.c,
>     which copies the contents of one bio into another. Because the biovecs

Applied, thanks.

jon
