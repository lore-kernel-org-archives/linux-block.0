Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:46002 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1764852AbdDTEyK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Apr 2017 00:54:10 -0400
Date: Wed, 19 Apr 2017 21:54:08 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Omar Sandoval <osandov@fb.com>,
        Jozef Mikovic <jmikovic@redhat.com>
Subject: Re: [PATCH 0/4] blk-mq-sched: allow to use hw tag for sched
Message-ID: <20170420045408.GB2235@infradead.org>
References: <20170415123825.32716-1-ming.lei@redhat.com>
 <cafbd7d9-1027-5282-6f1a-48f7ccec3d45@fb.com>
 <20170420004410.GA16917@ming.t460p>
 <90e249d6-996c-a8d9-f54d-e8142082bfa5@fb.com>
 <20170420010346.GC16917@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170420010346.GC16917@ming.t460p>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Apr 20, 2017 at 09:03:47AM +0800, Ming Lei wrote:
> If we don't need to reserve tag for internal command, I am happy
> to fix it in the interim. However, the mtip32xx driver has to
> ask blk-mq to reserve the tag zero for internal command. Then
> if we can't allow the driver to use that reserved tag, it looks
> quite awkward, doesn't it?

It doesn't.  Just offset the hardware tags by 1 from the blk-mq tags.

But I'm pretty sure the hardware wouldn't require a specific tag
for the internal ops.
