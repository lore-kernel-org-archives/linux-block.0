Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40067C433EF
	for <linux-block@archiver.kernel.org>; Wed, 16 Feb 2022 17:05:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234217AbiBPRFR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Feb 2022 12:05:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233496AbiBPRFQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Feb 2022 12:05:16 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7042A2A5981
        for <linux-block@vger.kernel.org>; Wed, 16 Feb 2022 09:05:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0CZ8qbx6NpxNXoIfMtNTqILzMF7xapSDpFvAf3Y68B0=; b=CNxvvBtBhjHF1gA/xf4OahI3GC
        HeBmE2dCQEuP7T4zqJga4Vs7nztgkTgqOjqTjAeRLfxGXRcFVDatL0LqgEMQmNzS5cYKNjnzDisBe
        wA4YhLUQzxeCxJXFYOTHID5nPsuIdhZwx+cR/fX2GwIh3bKNz/F7e45fCtLK54FxEf9pqJQ9yQeYg
        rZysm6l4IsKTshAq2fZoRD1//+3jC+dsv6iv/4yBN3LAVSQLaah5vfFLGd+tvjEz0D3s2E5ifgI4Q
        oljhHrrSkxzR2qBu9ISTuglZhBG5LAyCJNv5qIxS0bMGH8dGrQWEqj2rpGff6chcbuvv74075kKyA
        jMEvyImQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nKNji-007qWe-GN; Wed, 16 Feb 2022 17:05:02 +0000
Date:   Wed, 16 Feb 2022 09:05:02 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc:     Haimin Zhang <tcs.kernel@gmail.com>, Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block-map: add __GFP_ZERO flag for alloc_page in
 function bio_copy_kern
Message-ID: <Yg0uvqBK/n6fdDfL@infradead.org>
References: <20220216084038.15635-1-tcs.kernel@gmail.com>
 <47002290-3064-7de1-25e6-0716a89b94c0@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47002290-3064-7de1-25e6-0716a89b94c0@nvidia.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Feb 16, 2022 at 09:12:21AM +0000, Chaitanya Kulkarni wrote:
> but blk_rq_map_kern() does accept gfp_mask for exactly this same case
> and that is passed on to the bio_copy_kern() unless I'm wrong here,
> so you need to pass the __GFP_ZERO flag in the step 3 above
> (sg_scsi_ioctl) and not force zzeroed allocation the generic API..

We only want the zeroing for the payload, and other callers have the
same issue, so I think this patch is the right thing to do.
