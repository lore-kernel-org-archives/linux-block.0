Return-Path: <SRS0=lHMQ=S2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC62C10F11
	for <linux-block@archiver.kernel.org>; Wed, 24 Apr 2019 05:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DF9D2089F
	for <linux-block@archiver.kernel.org>; Wed, 24 Apr 2019 05:40:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729334AbfDXFke (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Apr 2019 01:40:34 -0400
Received: from verein.lst.de ([213.95.11.211]:51418 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726232AbfDXFke (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Apr 2019 01:40:34 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 9819E68AFE; Wed, 24 Apr 2019 07:40:18 +0200 (CEST)
Date:   Wed, 24 Apr 2019 07:40:18 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/2] block: integrity: enable multi-page bvec for bio
 integrity
Message-ID: <20190424054018.GD12136@lst.de>
References: <20190423071550.20806-1-ming.lei@redhat.com> <20190423071550.20806-2-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190423071550.20806-2-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 23, 2019 at 03:15:49PM +0800, Ming Lei wrote:
> +	if (bip->bip_vcnt) {
> +		iv = bip->bip_vec + bip->bip_vcnt - 1;
>  
> +		if (bvec_gap_to_prev(bio->bi_disk->queue, iv, offset))
> +			return 0;
>  
> +		if (page_is_mergeable(iv, page, len, offset, false)) {
> +			iv->bv_len += len;
> +			goto done;
> +		}
> +	}
> +
> +	iv = bip->bip_vec + bip->bip_vcnt;
>  	iv->bv_page = page;
>  	iv->bv_len = len;
>  	iv->bv_offset = offset;
>  	bip->bip_vcnt++;
> -
> + done:
>  	return len;

Just do an early return instead of the goto..

Otherwise this looks fine:

Reviewed-by: Christoph Hellwig <hch@lst.de>
