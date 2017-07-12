Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54192 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755370AbdGLCw3 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Jul 2017 22:52:29 -0400
Date: Wed, 12 Jul 2017 10:52:17 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Bart Van Assche <bart.vanassche@sandisk.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org
Subject: Re: [PATCH 1/6] xen-blkfront: avoid to use start/stop queue
Message-ID: <20170712025216.GC13036@ming.t460p>
References: <20170711182103.11461-1-ming.lei@redhat.com>
 <20170711182103.11461-2-ming.lei@redhat.com>
 <20170711184105.GC29918@char.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170711184105.GC29918@char.us.oracle.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Jul 11, 2017 at 02:41:05PM -0400, Konrad Rzeszutek Wilk wrote:
> On Wed, Jul 12, 2017 at 02:20:58AM +0800, Ming Lei wrote:
> > This interfaces will be removed soon, so use quiesce and
> > unquiesce instead, which should be more safe.
> 
> 'should be'? That does not sound encouraging?

Sorry for the mistake, and will fix it in V2, definitely quiesce
is the preferred interface, also stop queue may not do what you
want to do as you can see from comment of blk_mq_stop_hw_queues,
and has caused much trouble already.

And I appreciate if you guys may review on this patch itself.

BTW, this patch should have been included in Sagi Grimberg's
patchset of "[PATCH v3 0/8] correct quiescing in several block drivers":

        http://marc.info/?t=149927415900006&r=1&w=2

Thanks,
Ming
