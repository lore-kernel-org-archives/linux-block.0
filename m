Return-Path: <linux-scsi-owner@vger.kernel.org>
Date: Thu, 26 Jan 2017 20:37:34 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>,
        Mike Snitzer <snitzer@redhat.com>, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, dm-devel@redhat.com
Subject: Re: [PATCH 15/16] block: split scsi_request out of struct request
Message-ID: <20170126193734.GA26037@lst.de>
References: <1485185361-29786-1-git-send-email-hch@lst.de> <1485185361-29786-16-git-send-email-hch@lst.de> <455a58ef-905c-abf9-ae59-ca98f003f31e@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <455a58ef-905c-abf9-ae59-ca98f003f31e@sandisk.com>
Sender: linux-scsi-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

On Thu, Jan 26, 2017 at 11:12:51AM -0800, Bart Van Assche wrote:
> Where does the '* 3' come from? I think that deserves a comment.
> Additionally, this patch introduces a new warning when building with W=1:

It's a magic factor copied from the old code :(

That beeing said I really wonder if we should keep the tracing for
the scsi_requests fields at all.  We have tracing in SCSI, and poking
into these SCSI fields from block code is painful and just screams
layering violations.

Jens, any opinion on just removing the printout of the SCSI CDB
for blktrace?
