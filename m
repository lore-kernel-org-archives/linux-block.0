Return-Path: <SRS0=N4qE=SZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F44C10F14
	for <linux-block@archiver.kernel.org>; Tue, 23 Apr 2019 06:20:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE23E206BA
	for <linux-block@archiver.kernel.org>; Tue, 23 Apr 2019 06:20:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ucvkKdtw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725946AbfDWGUg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Apr 2019 02:20:36 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53080 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfDWGUf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Apr 2019 02:20:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=BLv0rHRz9CXcxoASrw5ey7xKD0ZDhcwo/LyYXdZR0zY=; b=ucvkKdtwk5bV/gOsBe+knGOmX
        f4kRDtsptHHdnrGB5w7OxlzPASiNm4JTD1ACS+NNe6gpOyyEBD5lgBQMGsDIen17avJQ0G4xAIwdm
        wWdZEdlEMea0v2smJ0J941QMJxvEGVuSOWOouVlDr4lvJgQh2mPLAVMgSS1l4RHfcD15J4S+6xQlH
        eeOfuANG1venI99lfG+v4JeH3WPnusFLLp1frCpwQfLduMaAzRPTdREnmkUC/hBt8fQhLZXTrZdCf
        tQGTwewCQf8OpMt13KO0ETG/SSOsEw4MF/lxrnYNfhu6wyiJ6/kIGVAlm97vSoDxQxOY0QQkhMxyr
        3LVrw0N/g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hIonC-0000FB-Hd; Tue, 23 Apr 2019 06:20:34 +0000
Date:   Mon, 22 Apr 2019 23:20:34 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH V2] block: clarify that bio_add_page() and related
 helpers can add multi pages
Message-ID: <20190423062034.GB28518@infradead.org>
References: <20190422100207.13057-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190422100207.13057-1-ming.lei@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Apr 22, 2019 at 06:02:07PM +0800, Ming Lei wrote:
> bio_add_page() and __bio_add_page() are capable of adding pages into
> bio, and now we have at least two such usages alreay:
> 
> 	- __bio_iov_bvec_add_pages()
> 	- nvmet_bdev_execute_rw().
> 
> So update comments on these two helpers.
> 
> The thing is a bit special for __bio_try_merge_page(), given the caller
> needs to know if the new added page is same with the last added page,
> then it isn't safe to pass multi-page in case that 'same_page' is true,
> so adds warning on potential misuse, and updates comment on
> __bio_try_merge_page().
> 
> Cc: linux-xfs@vger.kernel.org
> Cc: linux-fsdevel@vger.kernel.org
> Cc: Christoph Hellwig <hch@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
> V2:
> 	- add Reviewed-by tag
> 	- rebase on latest for-5.2/block
> 
>  block/bio.c | 26 +++++++++++++++-----------
>  1 file changed, 15 insertions(+), 11 deletions(-)
> 
> diff --git a/block/bio.c b/block/bio.c
> index 5959141d4e46..e92c37ce20a6 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -688,6 +688,8 @@ static bool can_add_page_to_seg(struct request_queue *q,
>  	if (bv->bv_len + len > queue_max_segment_size(q))
>  		return false;
>  
> +	WARN_ON_ONCE(same_page && (len + off) > PAGE_SIZE);

No need for the inner braces.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
