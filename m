Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44068 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753227AbdFMCPb (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Jun 2017 22:15:31 -0400
Date: Tue, 13 Jun 2017 10:15:19 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Bart Van Assche <bart.vanassche@sandisk.com>
Subject: Re: [PATCH v5 00/12] blk-mq: fix & improve queue quiescing
Message-ID: <20170613021518.GB15043@ming.t460p>
References: <20170606152210.22806-1-ming.lei@redhat.com>
 <08a2b32d-866e-a71f-4ac6-9c131edb88e2@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <08a2b32d-866e-a71f-4ac6-9c131edb88e2@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Jun 06, 2017 at 10:03:12AM -0600, Jens Axboe wrote:
> On 06/06/2017 09:21 AM, Ming Lei wrote:
> > Hi,
> > 
> > There is one big issue in current blk_mq_quiesce_queue():
> > 
> >     - in case of direct issue or BLK_MQ_S_START_ON_RUN, dispatch won't
> >     be prevented after blk_mq_quiesce_queue() is returned.
> > 
> > 
> > The 1st two patches fix two problems in direct issue, please consider
> > it for v4.12.
> > 
> > The other 10 patches improves blk_mq_quiesce_queue(), and
> > make is easy to use, and avoid race between queue restart and
> > quiescing. These 10 patches should be for v4.13.
> 
> I've added 1-2 for 4.12, I'll review the rest for 4.13 when some
> cycles free up.

Hi Jens,

If you are fine with 3-12, could you consider it for v4.13?

The fixes on uses of blk_mq_tagset_busy_iter() depends on
this patchset.


Thanks,
Ming
