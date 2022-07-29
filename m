Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 865A6C00144
	for <linux-block@archiver.kernel.org>; Fri, 29 Jul 2022 14:20:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236948AbiG2OUS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 Jul 2022 10:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236981AbiG2OUP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Jul 2022 10:20:15 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAF43A1BB
        for <linux-block@vger.kernel.org>; Fri, 29 Jul 2022 07:20:13 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 373E568AA6; Fri, 29 Jul 2022 16:20:11 +0200 (CEST)
Date:   Fri, 29 Jul 2022 16:20:11 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V3 2/5] ublk_drv: fix ublk device leak in case that
 add_disk fails
Message-ID: <20220729142011.GB32321@lst.de>
References: <20220729072954.1070514-1-ming.lei@redhat.com> <20220729072954.1070514-3-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220729072954.1070514-3-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jul 29, 2022 at 03:29:51PM +0800, Ming Lei wrote:
>  	get_device(&ub->cdev_dev);
>  	ret = add_disk(disk);
>  	if (ret) {
> +		/*
> +		 * has to drop the reference since ->free_disk won't be
> +		 * called in case of add_disk failure
> +		 */

Nit: Multi-line comments typically start with a capitalized word and
end with a dot to form a proper sentence.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
