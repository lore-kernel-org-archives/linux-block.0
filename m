Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:11765 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388457AbeGYCYt (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Jul 2018 22:24:49 -0400
Date: Tue, 24 Jul 2018 19:15:44 -0600
From: Keith Busch <keith.busch@linux.intel.com>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Jianchao Wang <jianchao.w.wang@oracle.com>,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCHv2 2/2] scsi: set timed out out mq requests to complete
Message-ID: <20180725011543.GA14596@localhost.localdomain>
References: <20180723143751.10843-1-keith.busch@intel.com>
 <20180723143751.10843-2-keith.busch@intel.com>
 <86e23e58-6f80-7957-30f7-8b0ce8cb50ce@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <86e23e58-6f80-7957-30f7-8b0ce8cb50ce@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Jul 24, 2018 at 03:46:17PM -0700, Bart Van Assche wrote:
> On 07/23/18 07:37, Keith Busch wrote:
> > +		if (req->q->mq_ops && !blk_mq_mark_complete(req))
> > +			return rtn;
> >   		if (scsi_abort_command(scmd) != SUCCESS) {
> >   			set_host_byte(scmd, DID_TIME_OUT);
> >   			scsi_eh_scmd_add(scmd);
> 
> This change looks incomplete to me. I think the following scenario is not
> handled properly by the above patch:
> - host->hostt->eh_timed_out() gets called.
> - The request "req" completes from another context while
>   host->hostt->eh_timed_out() is in progress.
> - host->hostt->eh_timed_out() calls scsi_finish_command().
> 
> I think that scenario will lead to a double completion.

A bit of a moot point, isn't it? Not a single scsi lld directly calls
scsi_finish_command() from anywhere, much less through eh_timed_out().
