Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51822 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752126AbdLEQpe (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 5 Dec 2017 11:45:34 -0500
Date: Wed, 6 Dec 2017 00:45:12 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>, "hare@suse.com" <hare@suse.com>,
        "holger@applied-asynchrony.com" <holger@applied-asynchrony.com>,
        "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>
Subject: Re: [PATCH] SCSI: run queue if SCSI device queue isn't ready and
 queue is idle
Message-ID: <20171205164511.GC23788@ming.t460p>
References: <20171205075256.10319-1-ming.lei@redhat.com>
 <1512490099.2660.6.camel@sandisk.com>
 <20171205162825.GA23788@ming.t460p>
 <1512492105.2660.22.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1512492105.2660.22.camel@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Dec 05, 2017 at 04:41:46PM +0000, Bart Van Assche wrote:
> On Wed, 2017-12-06 at 00:28 +0800, Ming Lei wrote:
> > This is still a workaround for RESTART, see my comment before:
> > 
> > 	https://marc.info/?l=linux-block&m=151217500929341&w=2
> 
> A quote from that e-mail: "The theory about using BLK_MQ_S_SCHED_RESTART in
> current way is that we mark it after requests are added to hctx->dispatch".
> Reading that makes me wonder whether you understand the purpose of the
> BLK_MQ_S_SCHED_RESTART flag? That flag is not set after requests are added
> to the dispatch list but after requests have been *removed*. The purpose of
> that flag is to detect whether another thread has run the queue after
> requests were removed from the dispatch list and before these were readded.
> If so, the queue needs to be rerun.

If you want to discuss that, please reply on that thread of '[PATCH 4/7] blk-mq:
Avoid that request processing sta', I will reply on you there too.

-- 
Ming
