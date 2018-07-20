Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:56980 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731000AbeGTOyA (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Jul 2018 10:54:00 -0400
Date: Fri, 20 Jul 2018 08:05:27 -0600
From: Keith Busch <keith.busch@linux.intel.com>
To: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@kernel.dk>,
        linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org,
        Jianchao Wang <jianchao.w.wang@oracle.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/2] scsi: set timed out out mq requests to complete
Message-ID: <20180720140527.GA4093@localhost.localdomain>
References: <20180719212618.2406-1-keith.busch@intel.com>
 <20180719212618.2406-2-keith.busch@intel.com>
 <20180720065258.cucvur7n5tugl75u@linux-x5ow.site>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180720065258.cucvur7n5tugl75u@linux-x5ow.site>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Jul 20, 2018 at 08:52:58AM +0200, Johannes Thumshirn wrote:
> On Thu, Jul 19, 2018 at 03:26:18PM -0600, Keith Busch wrote:
> > The scsi block layer requires requests claimed be the error handling be
> > completed by the error handler. A previous commit allowed completions
> > to proceed for blk-mq, breaking that assumption.
> 
> Ahm the first sentence is a bit hard to parse, sorry.
> Did you mean something like:
> 
> "The scsi block later requires requests claimed by the error handling
> to be completed by the error handler"?

Ugh, sorry. Yes, you are correct on the intended phrasing.
