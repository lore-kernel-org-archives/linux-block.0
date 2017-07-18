Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:48532 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751596AbdGRPJa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Jul 2017 11:09:30 -0400
Date: Tue, 18 Jul 2017 08:09:29 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Bart Van Assche <bart.vanassche@sandisk.com>
Subject: Re: [PATCH 2/2] blk-mq-sched: use q->queue_depth as hint for
 q->nr_requests
Message-ID: <20170718150929.GB23687@infradead.org>
References: <20170717083923.22014-1-ming.lei@redhat.com>
 <20170717083923.22014-3-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170717083923.22014-3-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This looks pretty reasonable:

Reviewed-by: Christoph Hellwig <hch@lst.de>
