Return-Path: <tglx@linutronix.de>
Date: Tue, 8 Nov 2016 17:27:52 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Christoph Hellwig <hch@lst.de>
cc: Hannes Reinecke <hare@suse.de>, axboe@kernel.dk,
    linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] genirq/affinity: Handle pre/post vectors in
 irq_create_affinity_masks()
In-Reply-To: <20161108150040.GA13184@lst.de>
Message-ID: <alpine.DEB.2.20.1611081727410.3501@nanos>
References: <1478544462-9549-1-git-send-email-hch@lst.de> <1478544462-9549-4-git-send-email-hch@lst.de> <a7e25633-b9fb-468f-fd33-28dbc0368cc1@suse.de> <20161108145508.GA12519@lst.de> <c9ba9026-8ff8-8717-60dc-92672724d5d8@suse.de>
 <20161108150040.GA13184@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-block@vger.kernel.org>

On Tue, 8 Nov 2016, Christoph Hellwig wrote:

> On Tue, Nov 08, 2016 at 03:59:16PM +0100, Hannes Reinecke wrote:
> >
> > Which you don't in this patch:
> 
> True.  We will always in the end, but the split isn't right, we'll
> need to pass the non-NULL argument starting in this patch.

No, in the previous one ....
 
