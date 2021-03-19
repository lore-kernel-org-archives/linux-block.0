Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E6B8C433DB
	for <linux-block@archiver.kernel.org>; Fri, 19 Mar 2021 20:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B67B16197B
	for <linux-block@archiver.kernel.org>; Fri, 19 Mar 2021 20:03:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbhCSUDO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Mar 2021 16:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbhCSUDF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Mar 2021 16:03:05 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A4DC06175F;
        Fri, 19 Mar 2021 13:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Type:MIME-Version:
        References:Message-ID:In-Reply-To:Subject:cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=H9TVLTs0SAR5cjkhDMA+XL7+PGP9n15oF8lvWPcKczo=; b=4mKqEEp+7+I6isHbXdQfk4zpmw
        mrC9t7tMJPBls/2SlDOb5A4u7ri2OURuW1oT+lifznQxKoTz6oODqAYMMzJ9XqjjujfsI+XyJ9luH
        du+vbXvIMurbATtT1JGN7CPSXSe3Pk77LNC7pBoIHRphatnCBhDw9LzOZvKqIgz0hzL4g7sNEZNI9
        66+zAHK7aSiLYxIcl1u1NgcQpSokyAxiv57JV2K9lLgZXycbHe+1yUlZShM1sLvwcvtmr9PTnQ9ma
        +p/VkvNx50zG/zxekhZjPCw/ZY8S/aKJYjE70Qao0zBFcS1ZmzuhthiZnqoWvDz5OFUs5OnjKOHh+
        1FA1EvTA==;
Received: from rdunlap (helo=localhost)
        by bombadil.infradead.org with local-esmtp (Exim 4.94 #2 (Red Hat Linux))
        id 1lNLKo-001VP2-Vi; Fri, 19 Mar 2021 20:03:04 +0000
Date:   Fri, 19 Mar 2021 13:03:02 -0700 (PDT)
From:   Randy Dunlap <rdunlap@bombadil.infradead.org>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] Trivial typo fix and sentence construction for better
 readability
In-Reply-To: <20210319195451.32456-1-unixbhaskar@gmail.com>
Message-ID: <5ac591a4-2ed-311a-fcc2-3cc8443d71ef@bombadil.infradead.org>
References: <20210319195451.32456-1-unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: Randy Dunlap <rdunlap@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210319_130303_040409_6C85C857 
X-CRM114-Status: GOOD (  12.67  )
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Hm, needs some spacing fixes IMO. See below.


On Sat, 20 Mar 2021, Bhaskar Chowdhury wrote:

>
> s/funtion/functions/
>
> Plus the sentence reconstructed for better readability.
>
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> ---
> Changes from V1:
>  Randy's suggestions incorporated.
>
> block/blk-mq-tag.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> index 9c92053e704d..c2bef283db63 100644
> --- a/block/blk-mq-tag.c
> +++ b/block/blk-mq-tag.c
> @@ -373,8 +373,8 @@ static bool blk_mq_tagset_count_completed_rqs(struct request *rq,
> }
>
> /**
> - * blk_mq_tagset_wait_completed_request - wait until all completed req's
> - * complete funtion is run
> + * blk_mq_tagset_wait_completed_request - wait until all the  req's

                                                             the req's

> + *  functions completed their run

and more indentation + wording on that line above:
  *        functions have completed their run

>  * @tagset:	Tag set to drain completed request
>  *
>  * Note: This function has to be run after all IO queues are shutdown
> --

Thanks.
