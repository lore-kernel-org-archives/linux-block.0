Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:21150 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751200AbdLDWpW (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 4 Dec 2017 17:45:22 -0500
Date: Tue, 5 Dec 2017 06:45:08 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hare@suse.com" <hare@suse.com>
Subject: Re: [PATCH] SCSI: delay run queue if device is blocked in
 scsi_dev_queue_ready()
Message-ID: <20171204224507.GB6888@ming.t460p>
References: <20171202163150.1273-1-ming.lei@redhat.com>
 <1512400159.23838.1.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1512400159.23838.1.camel@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Dec 04, 2017 at 03:09:20PM +0000, Bart Van Assche wrote:
> On Sun, 2017-12-03 at 00:31 +0800, Ming Lei wrote:
> > Fixes: 0df21c86bdbf ("scsi: implement .get_budget and .put_budget for blk-mq")
> 
> It might be safer to revert commit 0df21c86bdbf instead of trying to fix all
> issues introduced by that commit for kernel version v4.15 ...

What are all issues in v4.15-rc? Up to now, it is the only issue reported,
and can be fixed by this simple patch, which one can be thought as cleanup
too.

-- 
Ming
