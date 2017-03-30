Return-Path: <msnitzer@redhat.com>
Date: Thu, 30 Mar 2017 11:38:51 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk, agk@redhat.com,
	shli@kernel.org, philipp.reisner@linbit.com,
	lars.ellenberg@linbit.com, linux-block@vger.kernel.org,
	linux-raid@vger.kernel.org, dm-devel@redhat.com,
	linux-scsi@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: Re: RFC: always use REQ_OP_WRITE_ZEROES for zeroing offload
Message-ID: <20170330153850.GA1031@redhat.com>
References: <20170323143341.31549-1-hch@lst.de>
 <20170330151257.GA910@redhat.com>
 <yq1lgrm3i36.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <yq1lgrm3i36.fsf@oracle.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, Mar 30 2017 at 11:22am -0400,
Martin K. Petersen <martin.petersen@oracle.com> wrote:

> Mike Snitzer <snitzer@redhat.com> writes:
> 
> > Would be very useful, particularly for testing, if
> > drivers/scsi/scsi_debug.c were updated to support WRITE ZEROES.
> 
> There is no WRITE ZEROES in SCSI. You should be able to get the right
> behavior with lbpws=1 lbprz=1.

OK, thanks.
