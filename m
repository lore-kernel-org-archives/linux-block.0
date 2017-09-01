Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:41220 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751778AbdIAMo4 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 1 Sep 2017 08:44:56 -0400
Date: Fri, 1 Sep 2017 14:44:54 +0200
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Bart Van Assche <bart.vanassche@sandisk.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>
Subject: Re: [PATCH 4/9] blk-mq: only run hw queues for blk-mq
Message-ID: <20170901124454.pfo37ycozp5knubw@linux-x5ow.site>
References: <20170831172728.15817-1-ming.lei@redhat.com>
 <20170831172728.15817-5-ming.lei@redhat.com>
 <20170901081634.gliggrnp3wlrysrv@linux-x5ow.site>
 <20170901123339.GA20709@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20170901123339.GA20709@ming.t460p>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Sep 01, 2017 at 08:33:40PM +0800, Ming Lei wrote:
> Given it is the only case that blk_mq_run_hw_queues() is run on
> !q->mq_ops now, I suggest to check q->mq_ops outside, otherwise
> it can be a bit overkill.

Fair enough,
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: Felix Imend�rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N�rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
