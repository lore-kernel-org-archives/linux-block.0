Return-Path: <hch@lst.de>
Date: Wed, 22 Mar 2017 19:59:08 +0100
From: "hch@lst.de" <hch@lst.de>
To: Bart Van Assche <Bart.VanAssche@sandisk.com>
Cc: "hch@lst.de" <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: unify and streamline the blk-mq make_request implementations V2
Message-ID: <20170322185908.GA5737@lst.de>
References: <20170320203930.12533-1-hch@lst.de> <1490100001.2602.0.camel@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1490100001.2602.0.camel@sandisk.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, Mar 21, 2017 at 12:40:17PM +0000, Bart Van Assche wrote:
> On Mon, 2017-03-20 at 16:39 -0400, Christoph Hellwig wrote:
> > Changes since V1:
> >��- rebase on top of the recent blk_mq_try_issue_directly changes
> >��- incorporate comments from Bart
> 
> Hi Christoph,
> 
> It seems to me like none of the three comments I had posted on patch 4/4
> have been addressed. Please have another look at these comments.

I had a look but resend the same old series again due to a rebase bug.
I'll resend it ASAP with what should address your comments to the previous
series as well as this one.
