Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C36EC433E0
	for <linux-block@archiver.kernel.org>; Thu, 18 Mar 2021 18:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9F0864F1F
	for <linux-block@archiver.kernel.org>; Thu, 18 Mar 2021 18:13:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232483AbhCRSMa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 Mar 2021 14:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229467AbhCRSMB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Mar 2021 14:12:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D258AC06174A;
        Thu, 18 Mar 2021 11:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=AhWQBtnDNYvH/ya/AilgCW5hgqljREfLQqYtgqmwu64=; b=KPjEv644KlKlam1JpsXjkJj3Nq
        h3Y5CFAy9TnlWYUg+woZccdZBWvl+XiynfTjFsbHEsZ2ZGGxr9KUvJMTfnH/ueRGKvb4wQ/OxxpC4
        G4mGFov2DA7K0poTnaiCcYiFHK7vU6S7KSm80ShiEoWfUXQFjkMbxlIPyPpdmPB9NZpf6phDLQslz
        4KlfFhfxzltlnuUICyC3Tyu+3VzQ6mTYYdA4vbW+lxtpw3ugTTnxD19owlSGzIc0KcJf76rLcuWhA
        wqfK1WiYC+y/YRQ0ULHsafCBL//fuC0WzpjqNoKEOLj8CxtpcOKnZyxHfU+Z7KBMqqkIxTfOZyKzj
        Q8oiMedA==;
Received: from [2601:1c0:6280:3f0::9757]
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lMx7W-003KeR-PX; Thu, 18 Mar 2021 18:11:49 +0000
Subject: Re: [PATCH] block: Fix a typo
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210318111204.20873-1-unixbhaskar@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <d4ee01e7-b627-71cc-c4da-fa004a6309b9@infradead.org>
Date:   Thu, 18 Mar 2021 11:11:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210318111204.20873-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/18/21 4:12 AM, Bhaskar Chowdhury wrote:
> s/trival/trivial/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

> ---
>  block/blk-merge.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index ffb4aa0ea68b..ba112cffd49f 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -283,7 +283,7 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
>  	/*
>  	 * Bio splitting may cause subtle trouble such as hang when doing sync
>  	 * iopoll in direct IO routine. Given performance gain of iopoll for
> -	 * big IO can be trival, disable iopoll when split needed.
> +	 * big IO can be trivial, disable iopoll when split needed.
>  	 */
>  	bio->bi_opf &= ~REQ_HIPRI;
> 
> --
> 2.26.2
> 


-- 
~Randy

