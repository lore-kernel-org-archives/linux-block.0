Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1757EC7EE21
	for <linux-block@archiver.kernel.org>; Thu,  4 May 2023 16:17:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjEDQQ7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 May 2023 12:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjEDQQ6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 May 2023 12:16:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C84981FC3;
        Thu,  4 May 2023 09:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zFZTZFGHSAaSaRqnlF9L7Mtetmpu66yO8W+jO7gZ4I8=; b=j9+9AV0iknIZd5Bxy8jMMN7joo
        KgIOfrpe2djpey8XRz8Eb3d3iK4yT0wVCClkbuOK/N5PBQrKLEHoZabloBoe7IzblwMeik9NylOl4
        06FlUKctHO5+LU9jWJOHJolNiRBJx1oWezv7u9WvXW2eqCvtEBVwjga8j/oh7a/ZtmfOutpjP2Eia
        xqUnK5byNVUUH2iVpxBg7ORKCYWZUm+zyWJiFdE2x9AxfblMmMSyPFOk63OWz1PE6lL3io2wHK2UF
        sT9PQjNjCR60MlYbGjiBfceJ+YnxuOP1f8Dff1k8Q2b9VA88H3R9MCTbN6QsvAmVeV5iP8qW/vffd
        +PfS0YdQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pubdQ-00Akfm-Hg; Thu, 04 May 2023 16:16:48 +0000
Date:   Thu, 4 May 2023 17:16:48 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Christoph Hellwig <hch@lst.de>, Ilya Dryomov <idryomov@gmail.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: always respect QUEUE_FLAG_STABLE_WRITES on the block
 device
Message-ID: <ZFPacOW6XMq+o4YU@casper.infradead.org>
References: <20230504105624.9789-1-idryomov@gmail.com>
 <20230504135515.GA17048@lst.de>
 <ZFO+R0Ud6Yx546Tc@casper.infradead.org>
 <20230504155556.t6byee6shgb27pw5@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230504155556.t6byee6shgb27pw5@quack3>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, May 04, 2023 at 05:55:56PM +0200, Jan Kara wrote:
> For bdev address_space that's easy but what Ilya also mentioned is a
> problem when 'stable_write' flag gets toggled on the device and in that
> case having to propagate the flag update to all the address_space
> structures is a nightmare...

We have a number of flags which don't take effect when modified on a
block device with a mounted filesystem on it.  For example, modifying
the readahead settings do not change existing files, only new ones.
Since this flag is only modifiable for debugging purposes, I think I'm
OK with it not affecting already-mounted filesystems.  It feels like a
decision that reasonable people could disagree on, though.
