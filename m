Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:54416 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbeIOMVB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 15 Sep 2018 08:21:01 -0400
Date: Sat, 15 Sep 2018 00:03:01 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Dmitry Monakhov <dmonakhov@openvz.org>,
        Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH] block: remove bio_rewind_iter()
Message-ID: <20180915070301.GB15555@infradead.org>
References: <20180905033335.12666-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180905033335.12666-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Sep 05, 2018 at 11:33:35AM +0800, Ming Lei wrote:
> It is pointed that bio_rewind_iter() is one very bad API[1]:
> 
> 1) bio size may not be restored after rewinding
> 
> 2) it causes some bogus change, such as 5151842b9d8732 (block: reset
> bi_iter.bi_done after splitting bio)
> 
> 3) rewinding really makes things complicated wrt. bio splitting
> 
> 4) unnecessary updating of .bi_done in fast path
> 
> [1] https://marc.info/?t=153549924200005&r=1&w=2

Based on that this is a bug fix and should go to 4.19 instead of 4.20
as it is queued up right now..
