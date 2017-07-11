Return-Path: <linux-block-owner@vger.kernel.org>
Received: from smtp.eu.citrix.com ([185.25.65.24]:55626 "EHLO
        SMTP.EU.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933513AbdGKVZN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Jul 2017 17:25:13 -0400
Date: Tue, 11 Jul 2017 23:24:44 +0200
From: Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
To: Ming Lei <ming.lei@redhat.com>
CC: Jens Axboe <axboe@fb.com>, <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Bart Van Assche <bart.vanassche@sandisk.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH 1/6] xen-blkfront: avoid to use start/stop queue
Message-ID: <20170711212444.ttmkvlxexuduzfcj@MacBook-Pro-de-Roger.local>
References: <20170711182103.11461-1-ming.lei@redhat.com>
 <20170711182103.11461-2-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20170711182103.11461-2-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Jul 12, 2017 at 02:20:58AM +0800, Ming Lei wrote:
> This interfaces will be removed soon, so use quiesce and
> unquiesce instead, which should be more safe.
> 
> The only one usage will be removed in the following
> congestion control patches.

Would it be better to simply fix blk_mq_{start/stop}_stopped_hw_queues
rather than introducing a new interface?

Roger.
