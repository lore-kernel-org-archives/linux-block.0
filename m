Return-Path: <linux-ide-owner@vger.kernel.org>
Date: Wed, 28 Jun 2017 14:33:55 -0400
From: Tejun Heo <tj@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
        Scott Bauer <scott.bauer@intel.com>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Rafael Antognolli <rafael.antognolli@intel.com>,
        Robert Elliott <elliott@hpe.com>, linux-ide@vger.kernel.org,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] sd: add support for TCG OPAL self encrypting disks
Message-ID: <20170628183355.GA27833@htj.duckdns.org>
References: <20170619122646.32666-1-hch@lst.de>
 <20170619122646.32666-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170619122646.32666-2-hch@lst.de>
Sender: linux-ide-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

On Mon, Jun 19, 2017 at 02:26:46PM +0200, Christoph Hellwig wrote:
> Just wire up the generic TCG OPAL infrastructure to the SCSI disk driver
> and the Security In/Out commands.
> 
> Note that I don't know of any actual SCSI disks that do support TCG OPAL,
> but this is required to support ATA disks through libata.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Applied to libata/for-4.13 w/ Martin's ack added.

Thanks.

-- 
tejun
