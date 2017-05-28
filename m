Return-Path: <hch@lst.de>
Date: Sun, 28 May 2017 11:49:18 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
	linux-block@vger.kernel.org, dm-devel@redhat.com,
	linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 02/13] scsi/osd: don't save block errors into
	req_results
Message-ID: <20170528094918.GC14199@lst.de>
References: <20170526085620.3113-1-hch@lst.de> <20170526085620.3113-3-hch@lst.de> <yq17f13qsc5.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <yq17f13qsc5.fsf@oracle.com>
List-ID: <linux-block@vger.kernel.org>

On Fri, May 26, 2017 at 04:24:42PM -0400, Martin K. Petersen wrote:
> 
> Christoph,
> 
> > We will only have sense data if the command exectured and got a SCSI
> > result, so this is pointless.
> 
> "executed"

Thanks, fixed.
