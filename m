Return-Path: <msnitzer@redhat.com>
Date: Thu, 30 Mar 2017 11:12:58 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, martin.petersen@oracle.com, agk@redhat.com,
	shli@kernel.org, philipp.reisner@linbit.com,
	lars.ellenberg@linbit.com, linux-block@vger.kernel.org,
	linux-raid@vger.kernel.org, dm-devel@redhat.com,
	linux-scsi@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: Re: RFC: always use REQ_OP_WRITE_ZEROES for zeroing offload
Message-ID: <20170330151257.GA910@redhat.com>
References: <20170323143341.31549-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170323143341.31549-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Would be very useful, particularly for testing, if
drivers/scsi/scsi_debug.c were updated to support WRITE ZEROES.
