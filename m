Return-Path: <oleksandr@natalenko.name>
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Jens Axboe <axboe@kernel.dk>, Mike Galbraith <efault@gmx.de>, Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: blk-mq breaks suspend even with runtime PM patch
Date: Tue, 08 Aug 2017 18:46:10 +0200
Message-ID: <2028625.4MXuxr7LpB@natalenko.name>
In-Reply-To: <20170808164333.GB7415@kroah.com>
References: <5912148.iRCpNe8Dyb@natalenko.name> <2416479.dXsOYsr7UT@natalenko.name> <20170808164333.GB7415@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
List-ID: <linux-block@vger.kernel.org>

Greg,

this is 765e40b675a9566459ddcb8358ad16f3b8344bbe.

On =FAter=FD 8. srpna 2017 18:43:33 CEST Greg KH wrote:
> On Tue, Aug 08, 2017 at 06:36:01PM +0200, Oleksandr Natalenko wrote:
> > Could you queue "block: disable runtime-pm for blk-mq" too please? It is
> > also related to suspend-resume freezes that were observed by multiple
> > users.
> What is the git commit id of that patch?
>=20
> thanks,
>=20
> greg k-h
