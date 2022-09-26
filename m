Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D765C6FA8E
	for <linux-block@archiver.kernel.org>; Mon, 26 Sep 2022 16:06:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234046AbiIZQGv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Sep 2022 12:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233680AbiIZQGE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Sep 2022 12:06:04 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8127110E;
        Mon, 26 Sep 2022 07:54:05 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 914A868AFE; Mon, 26 Sep 2022 16:54:01 +0200 (CEST)
Date:   Mon, 26 Sep 2022 16:54:01 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Kanchan Joshi <joshi.k@samsung.com>
Cc:     axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
        io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, gost.dev@samsung.com,
        Anuj Gupta <anuj20.g@samsung.com>
Subject: Re: [PATCH for-next v9 6/7] block: introduce helper to map bvec
 iterator
Message-ID: <20220926145401.GA20939@lst.de>
References: <20220925202304.28097-1-joshi.k@samsung.com> <CGME20220925203336epcas5p39e910479f992d7d9e233210e0647a6bf@epcas5p3.samsung.com> <20220925202304.28097-7-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220925202304.28097-7-joshi.k@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Sep 26, 2022 at 01:53:03AM +0530, Kanchan Joshi wrote:
> Add blk_rq_map_user_bvec which maps the pages from bvec iterator into a
> bio, and places the bio into the request. This helper will be used by
> nvme for uring-passthrough path with pre-mapped buffers.

I still don't think this should be separate per the ongoing discussion.

It would also be nice if we had a chance to finish the discussion
without seeing a reposted series before we've made much progress on
it.
