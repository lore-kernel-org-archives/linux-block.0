Return-Path: <gregkh@linuxfoundation.org>
Date: Tue, 8 Aug 2017 09:43:33 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Oleksandr Natalenko <oleksandr@natalenko.name>
Cc: Jens Axboe <axboe@kernel.dk>, Mike Galbraith <efault@gmx.de>,
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: blk-mq breaks suspend even with runtime PM patch
Message-ID: <20170808164333.GB7415@kroah.com>
References: <5912148.iRCpNe8Dyb@natalenko.name>
 <20170808162252.GC23338@kroah.com>
 <843d7ee7-63b9-d34c-6d91-dea0b940d330@kernel.dk>
 <2416479.dXsOYsr7UT@natalenko.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2416479.dXsOYsr7UT@natalenko.name>
List-ID: <linux-block@vger.kernel.org>

On Tue, Aug 08, 2017 at 06:36:01PM +0200, Oleksandr Natalenko wrote:
> Could you queue "block: disable runtime-pm for blk-mq" too please? It is also 
> related to suspend-resume freezes that were observed by multiple users.

What is the git commit id of that patch?

thanks,

greg k-h
