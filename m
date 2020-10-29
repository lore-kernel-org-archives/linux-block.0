Return-Path: <SRS0=RRdq=EE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 304E8C2D0A3
	for <linux-block@archiver.kernel.org>; Thu, 29 Oct 2020 14:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D516520838
	for <linux-block@archiver.kernel.org>; Thu, 29 Oct 2020 14:52:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbgJ2OwJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Oct 2020 10:52:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:40858 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726166AbgJ2OwI (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Oct 2020 10:52:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9A338AC1F;
        Thu, 29 Oct 2020 14:52:07 +0000 (UTC)
Date:   Thu, 29 Oct 2020 15:52:06 +0100
From:   David Disseldorp <ddiss@suse.de>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, Douglas Gilbert <dgilbert@interlog.com>
Subject: Re: [PATCH] lib/scatterlist: use consistent sg_copy_buffer() return
 type
Message-ID: <20201029155206.7cfcb7a2@suse.de>
In-Reply-To: <20201026210310.30169-1-ddiss@suse.de>
References: <20201026210310.30169-1-ddiss@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Ping - is there any feedback on this trivial change?

On Mon, 26 Oct 2020 22:03:10 +0100, David Disseldorp wrote:

> sg_copy_buffer() returns a size_t with the number of bytes copied.
> Return 0 instead of false if the copy is skipped.
> 
> Signed-off-by: David Disseldorp <ddiss@suse.de>
> Reviewed-by: Douglas Gilbert <dgilbert@interlog.com>
> ---
>  lib/scatterlist.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/scatterlist.c b/lib/scatterlist.c
> index 0a482ef988e5..a59778946404 100644
> --- a/lib/scatterlist.c
> +++ b/lib/scatterlist.c
> @@ -933,7 +933,7 @@ size_t sg_copy_buffer(struct scatterlist *sgl, unsigned int nents, void *buf,
>  	sg_miter_start(&miter, sgl, nents, sg_flags);
>  
>  	if (!sg_miter_skip(&miter, skip))
> -		return false;
> +		return 0;
>  
>  	while ((offset < buflen) && sg_miter_next(&miter)) {
>  		unsigned int len;

