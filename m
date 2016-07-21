Return-Path: <hch@lst.de>
Date: Thu, 21 Jul 2016 07:47:04 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>, shli@fb.com, martin.petersen@oracle.com,
	snitzer@redhat.com, sitsofe@yahoo.com, linux-block@vger.kernel.org
Subject: Re: resend: zeroout fixes
Message-ID: <20160721054704.GA18157@lst.de>
References: <1468920214-32400-1-git-send-email-hch@lst.de> <5c685f2e-59e5-18e6-5205-7bf9193fbac3@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5c685f2e-59e5-18e6-5205-7bf9193fbac3@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Wed, Jul 20, 2016 at 05:36:32PM -0600, Jens Axboe wrote:
> I think we should leave 4.7 as-is. The put issue being fixed is the most 
> important one, so just roll a separate 4.8 patch for that.

Ok, in that case just merge this series as-is for now.
