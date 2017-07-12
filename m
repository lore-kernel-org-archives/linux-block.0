Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:46777 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750738AbdGLJQM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Jul 2017 05:16:12 -0400
Date: Wed, 12 Jul 2017 02:16:08 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Shaohua Li <shli@kernel.org>, linux-raid@vger.kernel.org,
        NeilBrown <neilb@suse.com>, linux-block@vger.kernel.org,
        Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 2/2] md: raid1/raid10: initialize bvec table via
 bio_add_page()
Message-ID: <20170712091608.GA27795@infradead.org>
References: <20170712082912.491-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170712082912.491-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Jul 12, 2017 at 04:29:12PM +0800, Ming Lei wrote:
> We will support multipage bvec soon, so initialize bvec
> table using the standardy way instead of writing the
> talbe directly. Otherwise it won't work any more once
> multipage bvec is enabled.

It seems to me like these callsites also should use bio_init
instead of bio_reset to get a clean slate (and eventually
phase out bio_reset), which should probably got into
the helper as well.  E.g. instead of pretending to preserve
things we should simply build a new bio here.
