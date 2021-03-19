Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A4A8C433E1
	for <linux-block@archiver.kernel.org>; Fri, 19 Mar 2021 19:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D174C6197A
	for <linux-block@archiver.kernel.org>; Fri, 19 Mar 2021 19:06:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbhCSTGB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Mar 2021 15:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbhCSTFk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Mar 2021 15:05:40 -0400
X-Greylist: delayed 3999 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 19 Mar 2021 12:05:39 PDT
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46657C06174A
        for <linux-block@vger.kernel.org>; Fri, 19 Mar 2021 12:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Type:MIME-Version:
        References:Message-ID:In-Reply-To:Subject:cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BVtn4jZe1+Hd8lgefRld0vpJmP6ReTR/Khq2Tqo5RDI=; b=xUqBn1G4XNe6Jim+zsEh9EOaCN
        zeVw5Lrq47WsKawCQ+mLmi1z9+iQLaALkNsDm+9XrCtCOdmTmJHxoL2t/7Is3O3TYwEBdeB2Wx34/
        o77zPGvV9PH+Agc3k/jPwrREYC1j0wQGbHMhmliFe8vDPc9BJrRyVXPONutzBBIXj43JaKNU0XZnl
        yfIr++IH24Q4p0oo1UCzqhg/1Lg1Vr6zkNgfscZU/ELM8lfK10XbZzh38JLOMLD2Vn8jAB5mpb7g7
        SAlmHcV+qVDG+s/jWi/EURgGDhyeemGi69j7Ny5962laWNqFvDY/n+lHZVclhJH99GNqOeq8WatQa
        Y+lGMKQA==;
Received: from rdunlap (helo=localhost)
        by bombadil.infradead.org with local-esmtp (Exim 4.94 #2 (Red Hat Linux))
        id 1lNJOk-001RHf-2y; Fri, 19 Mar 2021 17:58:59 +0000
Date:   Fri, 19 Mar 2021 10:58:58 -0700 (PDT)
From:   Randy Dunlap <rdunlap@bombadil.infradead.org>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blk-mq: Trivial typo fix
In-Reply-To: <20210319012419.16778-1-unixbhaskar@gmail.com>
Message-ID: <d390c9d5-a72-7c88-48b6-5994ef26fe0@bombadil.infradead.org>
References: <20210319012419.16778-1-unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: Randy Dunlap <rdunlap@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210319_105858_151166_C0158479 
X-CRM114-Status: GOOD (  12.74  )
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On Fri, 19 Mar 2021, Bhaskar Chowdhury wrote:

> s/funtion/function/
>
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

The change is correct, but it doesn't help me when I try to read
that function description.  :(

Acked-by: Randy Dunlap <rdunlap@infradead.org>

> ---
> block/blk-mq-tag.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> index 9c92053e704d..ad91e98dbc43 100644
> --- a/block/blk-mq-tag.c
> +++ b/block/blk-mq-tag.c
> @@ -374,7 +374,7 @@ static bool blk_mq_tagset_count_completed_rqs(struct request *rq,
>
> /**
>  * blk_mq_tagset_wait_completed_request - wait until all completed req's
> - * complete funtion is run
> + * complete function is run
>  * @tagset:	Tag set to drain completed request
>  *
>  * Note: This function has to be run after all IO queues are shutdown
> --
> 2.26.2
>
>
