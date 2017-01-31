Return-Path: <James.Bottomley@hansenpartnership.com>
Message-ID: <1485888674.3199.49.camel@HansenPartnership.com>
Subject: Re: remove the cmd_type field from struct request
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 31 Jan 2017 10:51:14 -0800
In-Reply-To: <bbe16fc1-5652-bbc2-03a5-0298c3f16645@kernel.dk>
References: <1485878251-6107-1-git-send-email-hch@lst.de>
	 <bbe16fc1-5652-bbc2-03a5-0298c3f16645@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Tue, 2017-01-31 at 10:02 -0800, Jens Axboe wrote:
> On 01/31/2017 07:57 AM, Christoph Hellwig wrote:
> > [1] which were a pain in the ass to untangle and debug during 
> > development, it's really time for it to die..
> 
> Outside of the patch series in question, how to we expedite the
> euthanasia of IDE? What explicit features/support are we missing 
> through libata that would need to be added, before we can git rm 
> drivers/ide/?

I thought the primary objection was actually embedded in that libata
with its reliance on SCSI was just too large a dependency, so they have
to keep using drivers/ide.  Perhaps nvme and flash is obviating this
problem and we can ask them again, though?

James
