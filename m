Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:62817 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753617AbdFPMWp (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Jun 2017 08:22:45 -0400
Date: Fri, 16 Jun 2017 20:22:29 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Bart Van Assche <bart.vanassche@sandisk.com>
Subject: Re: [PATCH] blk-tag: not touch rq->internal_tag
Message-ID: <20170616122228.GB25190@ming.t460p>
References: <20170616080655.23838-1-ming.lei@redhat.com>
 <20170616082409.GA7732@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170616082409.GA7732@infradead.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Jun 16, 2017 at 01:24:09AM -0700, Christoph Hellwig wrote:
> On Fri, Jun 16, 2017 at 04:06:55PM +0800, Ming Lei wrote:
> > rq->internal_tag is introduced only for blk-mq, so
> > it isn't necessary to touch this variable in blk-tag.
> > 
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> 
> It's not harmful either, is it?

Yes, it is not harmful, also not necessary.

Thanks,
Ming
