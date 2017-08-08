Return-Path: <efault@gmx.de>
Message-ID: <1502211054.7877.9.camel@gmx.de>
Subject: Re: blk-mq breaks suspend even with runtime PM patch
From: Mike Galbraith <efault@gmx.de>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Oleksandr Natalenko <oleksandr@natalenko.name>, Jens Axboe
 <axboe@kernel.dk>,  Christoph Hellwig <hch@lst.de>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 08 Aug 2017 18:50:54 +0200
In-Reply-To: <20170808164400.GC7415@kroah.com>
References: <5912148.iRCpNe8Dyb@natalenko.name>
	 <1501391551.17388.31.camel@gmx.de> <1662218.y9oETEnj5A@natalenko.name>
	 <20170808162252.GC23338@kroah.com> <1502210041.7877.5.camel@gmx.de>
	 <20170808164400.GC7415@kroah.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Tue, 2017-08-08 at 09:44 -0700, Greg KH wrote:
> 
> Should these go back farther than 4.12?  Looks like they apply cleanly
> to 4.9, didn't look older than that...

I met prerequisites at 4.11, but I wasn't patching anything remotely
resembling virgin source.

	-Mike
