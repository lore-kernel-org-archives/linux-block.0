Return-Path: <linux-scsi-owner@vger.kernel.org>
Date: Wed, 4 Oct 2017 09:20:59 +0200
From: Christoph Hellwig <hch@lst.de>
To: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, linux-scsi@vger.kernel.org,
        linux-block@vger.kernel.org,
        Benjamin Block <bblock@linux.vnet.ibm.com>
Subject: Re: [PATCH 9/9] bsg: split handling of SCSI CDBs vs transport
        requeues
Message-ID: <20171004072059.GA21411@lst.de>
References: <20171003104845.10417-1-hch@lst.de> <20171003104845.10417-10-hch@lst.de> <mqd7ewbidos.fsf@linux-x5ow.site>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <mqd7ewbidos.fsf@linux-x5ow.site>
Sender: linux-scsi-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

On Wed, Oct 04, 2017 at 09:18:11AM +0200, Johannes Thumshirn wrote:
> Wouldn't it make sense to put the ->release() method into bsg_ops as
> well? The current prototype of bsg_register_queue isn't exactly what I
> would call a sane API.

It's a different level of callback - ops are the type of request
passed through (scsi vs transport) and ->release is s whacky
implementation detail of the SAS passthrough.  If at all ->release
should go away eventually by cleaning that mess up.
