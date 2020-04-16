Return-Path: <SRS0=Ef4g=6A=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64A49C2BB55
	for <linux-block@archiver.kernel.org>; Thu, 16 Apr 2020 12:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49F45206E9
	for <linux-block@archiver.kernel.org>; Thu, 16 Apr 2020 12:03:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634704AbgDPMDV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Apr 2020 08:03:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:39000 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2634695AbgDPMDQ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Apr 2020 08:03:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 9DAA3ABF4;
        Thu, 16 Apr 2020 12:03:10 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id AD0D71E1250; Thu, 16 Apr 2020 14:03:10 +0200 (CEST)
Date:   Thu, 16 Apr 2020 14:03:10 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, yuyufen@huawei.com, tj@kernel.org, jack@suse.cz,
        bvanassche@acm.org, tytso@mit.edu, gregkh@linuxfoundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/8] bdi: unexport bdi_register_va
Message-ID: <20200416120310.GJ23739@quack2.suse.cz>
References: <20200416071519.807660-1-hch@lst.de>
 <20200416071519.807660-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416071519.807660-6-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu 16-04-20 09:15:16, Christoph Hellwig wrote:
> bdi_register_va is only used by super.c, which can't be modular.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  mm/backing-dev.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/mm/backing-dev.c b/mm/backing-dev.c
> index 4f6c05df72f9..a7eb91146c9c 100644
> --- a/mm/backing-dev.c
> +++ b/mm/backing-dev.c
> @@ -969,7 +969,6 @@ int bdi_register_va(struct backing_dev_info *bdi, const char *fmt, va_list args)
>  	trace_writeback_bdi_register(bdi);
>  	return 0;
>  }
> -EXPORT_SYMBOL(bdi_register_va);
>  
>  int bdi_register(struct backing_dev_info *bdi, const char *fmt, ...)
>  {
> -- 
> 2.25.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
