Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36094 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750841AbdJCHV5 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 3 Oct 2017 03:21:57 -0400
Date: Tue, 3 Oct 2017 15:21:45 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        Bart Van Assche <bart.vanassche@sandisk.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Cathy Avery <cavery@redhat.com>,
        Martin Steigerwald <martin@lichtvoll.de>,
        linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        Bart Van Assche <Bart.VanAssche@wdc.com>
Subject: Re: [PATCH V7 3/6] block: pass flags to blk_queue_enter()
Message-ID: <20171003072144.GA23235@ming.t460p>
References: <20170930061214.10622-1-ming.lei@redhat.com>
 <20170930061214.10622-4-ming.lei@redhat.com>
 <20171002134032.GC19119@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171002134032.GC19119@infradead.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Oct 02, 2017 at 06:40:32AM -0700, Christoph Hellwig wrote:
> On Sat, Sep 30, 2017 at 02:12:11PM +0800, Ming Lei wrote:
> > We need to pass PREEMPT flags to blk_queue_enter()
> > for allocating request with RQF_PREEMPT in the
> > following patch.
> 
> I don't like having another name space for flags.  It seems like
> we should simply pass ops on, and then map the nowait allocations
> to RQF_PREEMPT to REQ_PREEMPT as done in the series from Bart.

OK, no problem, will integrate Bart's patches in this patchset.

-- 
Ming
