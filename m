Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF203C54EE9
	for <linux-block@archiver.kernel.org>; Wed, 28 Sep 2022 17:13:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234577AbiI1RNi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Sep 2022 13:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234607AbiI1RNG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Sep 2022 13:13:06 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C20B7EEB45;
        Wed, 28 Sep 2022 10:12:48 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id B979668BEB; Wed, 28 Sep 2022 19:12:44 +0200 (CEST)
Date:   Wed, 28 Sep 2022 19:12:44 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Kanchan Joshi <joshi.k@samsung.com>, hch@lst.de, kbusch@kernel.org,
        io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, gost.dev@samsung.com
Subject: Re: [PATCH for-next v10 0/7] Fixed-buffer for uring-cmd/passthru
Message-ID: <20220928171244.GA16907@lst.de>
References: <CGME20220927174622epcas5p1685c0f97a7ee2ee13ba25f5fb58dff00@epcas5p1.samsung.com> <20220927173610.7794-1-joshi.k@samsung.com> <96154f6c-c02a-4364-c2a8-c714d79806d3@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96154f6c-c02a-4364-c2a8-c714d79806d3@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Sep 28, 2022 at 08:28:02AM -0600, Jens Axboe wrote:
> Christoph, are you happy with the changes at this point?

I'll look at it now.  Too much on my plate for less than 24 hour turn
around times..
