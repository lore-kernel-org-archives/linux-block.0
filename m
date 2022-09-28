Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 035F0C04A95
	for <linux-block@archiver.kernel.org>; Wed, 28 Sep 2022 17:19:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233942AbiI1RTo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Sep 2022 13:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233426AbiI1RTm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Sep 2022 13:19:42 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47AE92AE8;
        Wed, 28 Sep 2022 10:19:35 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4630F68BEB; Wed, 28 Sep 2022 19:19:32 +0200 (CEST)
Date:   Wed, 28 Sep 2022 19:19:32 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Kanchan Joshi <joshi.k@samsung.com>
Cc:     axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
        io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, gost.dev@samsung.com
Subject: Re: [PATCH for-next v10 4/7] nvme: refactor nvme_alloc_request
Message-ID: <20220928171932.GB17153@lst.de>
References: <20220927173610.7794-1-joshi.k@samsung.com> <CGME20220927174633epcas5p4d492bdebde981e2c019e30c47cf00869@epcas5p4.samsung.com> <20220927173610.7794-5-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927173610.7794-5-joshi.k@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> +	if (!vec)
> +		ret = blk_rq_map_user(q, req, NULL, ubuffer, bufflen,
> +			GFP_KERNEL);
> +	else {
> +		struct iovec fast_iov[UIO_FASTIOV];
> +		struct iovec *iov = fast_iov;
> +		struct iov_iter iter;
> +
> +		ret = import_iovec(rq_data_dir(req), ubuffer, bufflen,
> +				UIO_FASTIOV, &iov, &iter);
> +		if (ret < 0)
>  			goto out;
> +
> +		ret = blk_rq_map_user_iov(q, req, NULL, &iter, GFP_KERNEL);
> +		kfree(iov);
> +	}

As mentioned before this is something that should got into blk-map.c
as a separate helper, and scsi_ioctl.c and sg.c should be switched to
use it as well.

Otherwise this looks good.
