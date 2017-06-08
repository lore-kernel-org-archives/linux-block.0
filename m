Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:48762 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750822AbdFHG47 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Jun 2017 02:56:59 -0400
Date: Wed, 7 Jun 2017 23:56:57 -0700
From: Christoph Hellwig <hch@infradead.org>
To: James Wang <jnwang@suse.com>
Cc: Christoph Hellwig <hch@infradead.org>, axboe@fb.com, hare@suse.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        mgorman@suse.com
Subject: Re: [PATCH] Fix loop device flush before configure
Message-ID: <20170608065657.GB14568@infradead.org>
References: <20170607090104.17337-1-jnwang@suse.com>
 <20170607131718.GC18252@infradead.org>
 <2D8954BF-E3D2-4A61-AAE2-A3FDD080C26A@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2D8954BF-E3D2-4A61-AAE2-A3FDD080C26A@suse.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Jun 08, 2017 at 08:45:31AM +0800, James Wang wrote:
> Ok I got it blktests is a suite. I'd like to contribute something. If you need, we adapt you,;-)!
> But I have to learn some how to do that, need time.

I haven't added test myself to blktests yet either, so I'd have to
learn it as well.  Omar can probably help you though.
