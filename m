Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:42764 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752970AbdFPIYL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Jun 2017 04:24:11 -0400
Date: Fri, 16 Jun 2017 01:24:09 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Bart Van Assche <bart.vanassche@sandisk.com>
Subject: Re: [PATCH] blk-tag: not touch rq->internal_tag
Message-ID: <20170616082409.GA7732@infradead.org>
References: <20170616080655.23838-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170616080655.23838-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Jun 16, 2017 at 04:06:55PM +0800, Ming Lei wrote:
> rq->internal_tag is introduced only for blk-mq, so
> it isn't necessary to touch this variable in blk-tag.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

It's not harmful either, is it?
