Return-Path: <SRS0=L3Py=WS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FCACC3A59E
	for <linux-block@archiver.kernel.org>; Thu, 22 Aug 2019 00:59:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BF42206BA
	for <linux-block@archiver.kernel.org>; Thu, 22 Aug 2019 00:59:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729704AbfHVA7T (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Aug 2019 20:59:19 -0400
Received: from verein.lst.de ([213.95.11.211]:42348 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727962AbfHVA7T (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Aug 2019 20:59:19 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 43E6E68BFE; Thu, 22 Aug 2019 02:59:16 +0200 (CEST)
Date:   Thu, 22 Aug 2019 02:59:16 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc:     linux-block@vger.kernel.org, hch@lst.de, axboe@kernel.dk
Subject: Re: [PATCH V3 6/6] null_blk: create a helper for req completion
Message-ID: <20190822005916.GG10938@lst.de>
References: <20190821061314.3262-1-chaitanya.kulkarni@wdc.com> <20190821061314.3262-7-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821061314.3262-7-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Aug 20, 2019 at 11:13:14PM -0700, Chaitanya Kulkarni wrote:
> This patch creates a helper function for handling the request
> completion in the null_handle_cmd().
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> ---
>  drivers/block/null_blk_main.c | 49 +++++++++++++++++++----------------
>  1 file changed, 27 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
> index 501af79bffb2..fe12ec59b3a6 100644
> --- a/drivers/block/null_blk_main.c
> +++ b/drivers/block/null_blk_main.c
> @@ -1202,6 +1202,32 @@ static inline blk_status_t null_handle_zoned(struct nullb_cmd *cmd,
>  	return sts;
>  }
>  
> +static inline void nullb_handle_cmd_completion(struct nullb_cmd *cmd)

Maybe cal this nullb_complete_cmd instead?

Otherwise looks fine:

Reviewed-by: Christoph Hellwig <hch@lst.de>
