Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC32EC433FE
	for <linux-block@archiver.kernel.org>; Mon, 31 Jan 2022 23:43:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbiAaXno (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 31 Jan 2022 18:43:44 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:39856 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbiAaXnn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 31 Jan 2022 18:43:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BE210B82CC5
        for <linux-block@vger.kernel.org>; Mon, 31 Jan 2022 23:43:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42617C340EC;
        Mon, 31 Jan 2022 23:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1643672621;
        bh=7F7rGKin8kFBYulVUr3maZBnBl+p1ysUFkm3zq518Yw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MpkeaLQThVMk9vfPEzYRm/b8NRdBh0k8KXiVDsoGl55i8Fno7JreuLashX0g3BiT8
         16BteH0eL9Cf0ibNod1n9oxCLFPYLIX7y+6JqTIN9vOZylB+9cwUpYvaQB+0xVA0yC
         ZCYLbqvvY8nBKRA6PhqnHJkgXU8NTH/2QtS/y8CY=
Date:   Mon, 31 Jan 2022 15:43:40 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mauricio Faria de Oliveira <mfo@canonical.com>
Cc:     Minchan Kim <minchan@kernel.org>,
        "Huang, Ying" <ying.huang@intel.com>, Yu Zhao <yuzhao@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>, linux-mm@kvack.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH v3] mm: fix race between MADV_FREE reclaim and blkdev
 direct IO read
Message-Id: <20220131154340.e65ebe932d8933bc68c4ddf4@linux-foundation.org>
In-Reply-To: <20220131230255.789059-1-mfo@canonical.com>
References: <20220131230255.789059-1-mfo@canonical.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 31 Jan 2022 20:02:55 -0300 Mauricio Faria de Oliveira <mfo@canonical.com> wrote:

> Problem:
> =======
> 
> Userspace might read the zero-page instead of actual data from a
> direct IO read on a block device if the buffers have been called
> madvise(MADV_FREE) on earlier (this is discussed below) due to a
> race between page reclaim on MADV_FREE and blkdev direct IO read.
> 
> ...
>
> Fixes: 802a3a92ad7a ("mm: reclaim MADV_FREE pages")

Five years ago.  As it doesn't seem urgent I targeted 5.18-rc1 for
this, and added a cc:stable so it will trickle back into earlier trees.

How does this plan sound?
