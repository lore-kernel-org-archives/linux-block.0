Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48550 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753679AbdLDI6U (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 4 Dec 2017 03:58:20 -0500
Date: Mon, 4 Dec 2017 16:58:03 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        Bart Van Assche <bart.vanassche@sandisk.com>,
        linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH] SCSI: delay run queue if device is blocked in
 scsi_dev_queue_ready()
Message-ID: <20171204085802.GA12133@ming.t460p>
References: <20171202163150.1273-1-ming.lei@redhat.com>
 <mqdindmoqga.fsf@linux-x5ow.site>
 <20171204083440.GA10261@ming.t460p>
 <mqdo9nenapk.fsf@linux-x5ow.site>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <mqdo9nenapk.fsf@linux-x5ow.site>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Dec 04, 2017 at 09:44:55AM +0100, Johannes Thumshirn wrote:
> Ming Lei <ming.lei@redhat.com> writes:
> 
> 
> > I am happy to do that, but recently I am very busy, so it may be done
> > a bit late by me.
> >
> > But anyone should reproduce the issue 100% with V4.15-rc kernel by just
> > running the above script, not any specific hardware is required at all,
> > so that means anyone can make a patch for blktest to test block/SCSI
> > timeout if he/she is interested in doing that.
> 
> OK, let me see if I can spent some time on this the next days.

That is great, thanks!

-- 
Ming
