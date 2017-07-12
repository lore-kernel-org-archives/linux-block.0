Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51612 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932667AbdGLDMX (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Jul 2017 23:12:23 -0400
Date: Wed, 12 Jul 2017 11:12:13 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
Cc: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Bart Van Assche <bart.vanassche@sandisk.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org
Subject: Re: [PATCH 1/6] xen-blkfront: avoid to use start/stop queue
Message-ID: <20170712031212.GF13036@ming.t460p>
References: <20170711182103.11461-1-ming.lei@redhat.com>
 <20170711182103.11461-2-ming.lei@redhat.com>
 <20170711212444.ttmkvlxexuduzfcj@MacBook-Pro-de-Roger.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20170711212444.ttmkvlxexuduzfcj@MacBook-Pro-de-Roger.local>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Jul 11, 2017 at 11:24:44PM +0200, Roger Pau Monn� wrote:
> On Wed, Jul 12, 2017 at 02:20:58AM +0800, Ming Lei wrote:
> > This interfaces will be removed soon, so use quiesce and
> > unquiesce instead, which should be more safe.
> > 
> > The only one usage will be removed in the following
> > congestion control patches.
> 
> Would it be better to simply fix blk_mq_{start/stop}_stopped_hw_queues
> rather than introducing a new interface?

No, we do not want to expose start/stop state to drivers any more, which
has caused enough trouble already, so these APIs need to be removed, and
quiesce/unquiesce is preferred way for this purpose, as you can see
the work done by Sagi Grimberg:

        http://marc.info/?t=149927415900006&r=1&w=2


Thanks,
Ming
