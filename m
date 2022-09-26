Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB956C07E9D
	for <linux-block@archiver.kernel.org>; Mon, 26 Sep 2022 15:56:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234536AbiIZP4q (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Sep 2022 11:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234488AbiIZP40 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Sep 2022 11:56:26 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6031C18B39
        for <linux-block@vger.kernel.org>; Mon, 26 Sep 2022 07:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yd+7xPXxutp7BMz4CBbE8owqija+W0l0RgE5zhq40bw=; b=IhEc7ztHXDV+p89G2zat6RrXXl
        ZEQOl7wpL4a9ZiA2aFW01gJkUXQIZSapKtXsEPQzgi2GpJhRBxZmJ3nxfbDZgIZAgor+u3OucfUi7
        JHZZ51Y5yS7fP8qB5gvUyNlj4Rte7QZg7zxHqnTYJlz/4TrmLTCmjaJ5Veu9PPO8+FVOtP4+dVNP7
        Bt7e9s2vpZwLDOAAShXXEzrpbQXudfb9x9awttp/Cr7eR4vk8glEFVN/YnpC7ETR29zDfUwvv/4Zi
        aMjtjmMZOdXrGCKWda3fZNW5S4DpMqx15zguXyryDyOYwlKFeDqfjcHDrQawSQDyN5PES+TaSabeJ
        xyidgwpw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ocpK9-005QwG-Aw; Mon, 26 Sep 2022 14:43:09 +0000
Date:   Mon, 26 Sep 2022 07:43:09 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Pankaj Raghav <p.raghav@samsung.com>,
        linux-block@vger.kernel.org, damien.lemoal@opensource.wdc.com,
        gost.dev@samsung.com
Subject: Re: [PATCH 1/2] block: modify blk_mq_plug() to allow only reads for
 zoned block devices
Message-ID: <YzG6fZdz6XBDbrVB@infradead.org>
References: <20220925185348.120964-1-p.raghav@samsung.com>
 <CGME20220925185350eucas1p1fc354429027a88de7e548a3a4529b4ef@eucas1p1.samsung.com>
 <20220925185348.120964-2-p.raghav@samsung.com>
 <YzG5RgmWSsH6rX08@infradead.org>
 <d5975b62-f2e9-dcde-e332-a73cca1f7fbf@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5975b62-f2e9-dcde-e332-a73cca1f7fbf@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Sep 26, 2022 at 08:40:54AM -0600, Jens Axboe wrote:
> On 9/26/22 8:37 AM, Christoph Hellwig wrote:
> > On Sun, Sep 25, 2022 at 08:53:46PM +0200, Pankaj Raghav wrote:
> >> Modify blk_mq_plug() to allow plugging only for read operations in zoned
> >> block devices as there are alternative IO paths in the linux block
> >> layer which can end up doing a write via driver private requests in
> >> sequential write zones.
> > 
> > We should be able to plug for all operations that are not
> > REQ_OP_ZONE_APPEND just fine.
> 
> Agree, I think we just want to make this about someone doing a series
> of appends. If you mix-and-match with passthrough you will have a bad
> time anyway.

Err, sorry - what I wrote about is compelte garbage.  I initially
wanted to say you can plug for REQ_OP_ZONE_APPEND just fine, and then
realized that we also want various other ones that have the write bit
set batched.  So I suspect we really want to explicitly check for
REQ_OP_WRITE here.

