Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00EB6C54EE9
	for <linux-block@archiver.kernel.org>; Wed, 28 Sep 2022 17:18:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbiI1RSO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Sep 2022 13:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233290AbiI1RSK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Sep 2022 13:18:10 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC683BC16;
        Wed, 28 Sep 2022 10:18:08 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id AE88868BEB; Wed, 28 Sep 2022 19:18:05 +0200 (CEST)
Date:   Wed, 28 Sep 2022 19:18:05 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Kanchan Joshi <joshi.k@samsung.com>
Cc:     axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
        io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, gost.dev@samsung.com
Subject: Re: [PATCH for-next v10 3/7] nvme: refactor nvme_add_user_metadata
Message-ID: <20220928171805.GA17153@lst.de>
References: <20220927173610.7794-1-joshi.k@samsung.com> <CGME20220927174631epcas5p12cd6ffbd7dad819b0af75733ce6cdd2c@epcas5p1.samsung.com> <20220927173610.7794-4-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927173610.7794-4-joshi.k@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Sep 27, 2022 at 11:06:06PM +0530, Kanchan Joshi wrote:
>  		if (bdev && meta_buffer && meta_len) {
> -			meta = nvme_add_user_metadata(bio, meta_buffer, meta_len,
> -					meta_seed, write);
> +			meta = nvme_add_user_metadata(req, meta_buffer, meta_len,

Pleae avoid the overly long line here.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
