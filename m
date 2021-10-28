Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 334D5C433F5
	for <linux-block@archiver.kernel.org>; Thu, 28 Oct 2021 15:16:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 175796113B
	for <linux-block@archiver.kernel.org>; Thu, 28 Oct 2021 15:16:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbhJ1PS7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Oct 2021 11:18:59 -0400
Received: from verein.lst.de ([213.95.11.211]:42396 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231221AbhJ1PS6 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Oct 2021 11:18:58 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5648768AFE; Thu, 28 Oct 2021 17:16:29 +0200 (CEST)
Date:   Thu, 28 Oct 2021 17:16:28 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Alexander V. Buev" <a.buev@yadro.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Mikhail Malygin <m.malygin@yadro.com>, linux@yadro.com
Subject: Re: [PATCH 1/3] block: bio-integrity: add PI iovec to bio
Message-ID: <20211028151628.GA9468@lst.de>
References: <20211028112406.101314-1-a.buev@yadro.com> <20211028112406.101314-2-a.buev@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211028112406.101314-2-a.buev@yadro.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Oct 28, 2021 at 02:24:04PM +0300, Alexander V. Buev wrote:
>   * Written by: Martin K. Petersen <martin.petersen@oracle.com>
>   */
> -
>  #include <linux/blkdev.h>

Spurious whitespace change.

> +void bio_integrity_payload_release_pages(struct bio_integrity_payload *bip)
> +{
> +	unsigned short i;
> +	struct bio_vec *bv;
> +
> +	for (i = 0; i < bip->bip_vcnt; ++i) {
> +		bv = bip->bip_vec + i;
> +		put_page(bv->bv_page);
> +	}

The bv declaration can move into the loop (or we can just nuke the
single use local variable entirely).

> +	nr_vec_page = (pi_iov->iov_len + PAGE_SIZE - 1) >> PAGE_SHIFT;
> +	nr_vec_page += 1; // we need this die to data of size N pages can be pinned to N+1 page

Pleae avoid overly long line and //-style comments.

> +	size = iov_iter_get_pages(&pi_iter, pi_page, LONG_MAX, nr_vec_page, &offset);
> +	if (unlikely(size < 0)) {
> +		pr_err("Failed to pin PI buffer to page");
> +		ret = -EFAULT;
> +		goto exit;
> +	}

Instead of the local page this should use the same scheme as
__bio_iov_iter_get_pages.

> +
> +	// calc count of pined pages
> +	if (size > (PAGE_SIZE-offset)) {
> +		size = DIV_ROUND_UP(size - (PAGE_SIZE-offset), PAGE_SIZE)+1;
> +	} else

No need for braces around single line statements, please always
put whitespaces around your operators.

> +EXPORT_SYMBOL(bio_integrity_add_pi_iovec);

EXPORT_SYMBOL_GPL, please.
