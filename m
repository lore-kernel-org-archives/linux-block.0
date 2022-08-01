Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBBF9C00144
	for <linux-block@archiver.kernel.org>; Mon,  1 Aug 2022 18:05:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233245AbiHASFH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Aug 2022 14:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233586AbiHASFD (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 Aug 2022 14:05:03 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55BA79FCE;
        Mon,  1 Aug 2022 11:05:02 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id A198B68AFE; Mon,  1 Aug 2022 20:04:58 +0200 (CEST)
Date:   Mon, 1 Aug 2022 20:04:58 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Yu Kuai <yukuai1@huaweicloud.com>, stable@vger.kernel.org,
        hch@lst.de, axboe@kernel.dk, snitzer@redhat.com,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com
Subject: Re: [PATCH stable 5.10 1/3] block: look up holders by bdev
Message-ID: <20220801180458.GA17425@lst.de>
References: <20220729062356.1663513-1-yukuai1@huaweicloud.com> <20220729062356.1663513-2-yukuai1@huaweicloud.com> <Yue2rU2Y+xzvGU6x@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yue2rU2Y+xzvGU6x@kroah.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Aug 01, 2022 at 01:19:09PM +0200, Greg KH wrote:
> This is very different from the upstream version, and forces the change
> onto everyone, not just those who had CONFIG_BLOCK_HOLDER_DEPRECATED
> enabled like was done in the main kernel tree.
> 
> Why force this on all and not just use the same option?

I'm really worried about backports that are significantly different
from the original commit.  To the point where if they are so different
and we don't have a grave security or data integrity bug I'm really not
very much in favor of backporting them at all.

