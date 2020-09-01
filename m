Return-Path: <SRS0=kheS=CK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84512C433E2
	for <linux-block@archiver.kernel.org>; Tue,  1 Sep 2020 16:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61FD620BED
	for <linux-block@archiver.kernel.org>; Tue,  1 Sep 2020 16:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598976431;
	bh=yyssOx4X1QrHYW9ZCh+jHrrHKOxnFRz6+VT0vXiFFoo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Z3HHd7aTQURlaPPmxpFgKUQt+NQBMFeEVAw1tkG1Tz35AsQbGXLt0bsferwO4UyNe
	 cFYF2h63z5waauQPZVt8Qldw1lOkLH3qvWwocq70dlp4EB43sk8H8Fc5lKbte5mswk
	 nadFy+pdg0iuG4RxJqqnaGsx836DzFacqQH4lRmM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730590AbgIAQHH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Sep 2020 12:07:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:39088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727822AbgIAQHF (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 1 Sep 2020 12:07:05 -0400
Received: from gmail.com (unknown [104.132.1.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F95A2067C;
        Tue,  1 Sep 2020 16:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598976425;
        bh=yyssOx4X1QrHYW9ZCh+jHrrHKOxnFRz6+VT0vXiFFoo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xquu0Qutn265+QudsBCiWQDHtSHVW1c7JhBkbTw1VvmJQpb2AJ3HS8Ot+25sAWly7
         ZebbGejwMPJPApWCWbRCsBVIRKH1hvTMQAYVVVnM7aqFOx59FsSAGSrmBxdqwFZVqr
         DswQ9uFeQMQObPTHacuLlg5XzwlphK6xMRoQHMD0=
Date:   Tue, 1 Sep 2020 09:07:03 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     axboe@kernel.dk, satyat@google.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: Fix potential NULL pointer dereference in
 __bio_crypt_clone()
Message-ID: <20200901160703.GA669796@gmail.com>
References: <20200901115921.8926-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901115921.8926-1-linmiaohe@huawei.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Sep 01, 2020 at 07:59:21AM -0400, Miaohe Lin wrote:
> mempool_alloc() may return NULL if __GFP_DIRECT_RECLAIM is not set in
> gfp_mask under memory pressure. So we should check the return value of
> mempool_alloc() against NULL before dereference.
> 
> Fixes: a892c8d52c02 ("block: Inline encryption support for blk-mq")
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  block/blk-crypto.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-crypto.c b/block/blk-crypto.c
> index 2d5e60023b08..046aff85cfa3 100644
> --- a/block/blk-crypto.c
> +++ b/block/blk-crypto.c
> @@ -98,7 +98,8 @@ void __bio_crypt_free_ctx(struct bio *bio)
>  void __bio_crypt_clone(struct bio *dst, struct bio *src, gfp_t gfp_mask)
>  {
>  	dst->bi_crypt_context = mempool_alloc(bio_crypt_ctx_pool, gfp_mask);
> -	*dst->bi_crypt_context = *src->bi_crypt_context;
> +	if (likely(dst->bi_crypt_context))
> +		*dst->bi_crypt_context = *src->bi_crypt_context;
>  }
>  EXPORT_SYMBOL_GPL(__bio_crypt_clone);

It's intended that __GFP_DIRECT_RECLAIM always be set here.
Do you have an example where it isn't set here?

Also, if this can indeed happen, then we need to make __bio_crypt_clone()
(and bio_crypt_clone()) return a bool (or an error code) to indicate whether it
succeeded or failed.  We can't just ignore the allocation failure.

- Eric
