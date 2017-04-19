Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:40831 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760184AbdDSG1P (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Apr 2017 02:27:15 -0400
Date: Tue, 18 Apr 2017 23:27:13 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Omar Sandoval <osandov@fb.com>,
        Jozef Mikovic <jmikovic@redhat.com>
Subject: Re: [PATCH 0/3] mtip32xx: make it working with mq scheduler
Message-ID: <20170419062713.GA1372@infradead.org>
References: <20170419003142.9581-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170419003142.9581-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Ming,

I don't think your patch goes int the right direction.  The mtip32xx
driver never submits the requests it allocates using blk_mq_alloc_request.

So to fix this it should simply kmalloc the request, set a tag aside
and not use a block layer request for it at all, similar to what nvme
does for the AER command.
