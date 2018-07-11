Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:54292 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388590AbeGKRPK (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Jul 2018 13:15:10 -0400
Date: Wed, 11 Jul 2018 19:11:39 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-pm@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH RFC 2/4] blk-mq: introduce blk_mq_pm_queue_idle()
Message-ID: <20180711171139.GB3500@lst.de>
References: <20180711162906.14271-1-ming.lei@redhat.com> <20180711162906.14271-3-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180711162906.14271-3-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Jul 12, 2018 at 12:29:04AM +0800, Ming Lei wrote:
> This helper will be used to decide if this block device can be
> put into runtime suspend.

This also seems like a rather odd building block, and would probably
make more sense with a user..
