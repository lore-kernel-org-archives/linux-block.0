Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:58598 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1038094AbdDUKys (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Apr 2017 06:54:48 -0400
Date: Fri, 21 Apr 2017 03:54:46 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@fb.com>
Cc: Christoph Hellwig <hch@infradead.org>,
        Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        Omar Sandoval <osandov@fb.com>,
        Jozef Mikovic <jmikovic@redhat.com>
Subject: Re: [PATCH 0/4] blk-mq-sched: allow to use hw tag for sched
Message-ID: <20170421105446.GA31499@infradead.org>
References: <20170415123825.32716-1-ming.lei@redhat.com>
 <cafbd7d9-1027-5282-6f1a-48f7ccec3d45@fb.com>
 <20170420004410.GA16917@ming.t460p>
 <90e249d6-996c-a8d9-f54d-e8142082bfa5@fb.com>
 <20170420010346.GC16917@ming.t460p>
 <20170420045408.GB2235@infradead.org>
 <68f95811-380e-21f8-cdcb-2e47c6af4d56@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <68f95811-380e-21f8-cdcb-2e47c6af4d56@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Apr 20, 2017 at 10:10:59AM -0600, Jens Axboe wrote:
> Right, the hardware doesn't require it at all, it's just an oddity
> of the driver that it hardwares tag 0 as an internal tag. That could
> definitely get cleaned up.

That's exactly what I suspect, especially as the hardware is AHCI
on stereoids.  But I'd need a data sheet to confirm my suspicion.
