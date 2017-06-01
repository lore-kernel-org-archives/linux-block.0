Return-Path: <hch@lst.de>
Date: Thu, 1 Jun 2017 08:28:45 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Nicholas A. Bellinger" <nab@linux-iscsi.org>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
	martin.petersen@oracle.com, philipp.reisner@linbit.com,
	lars.ellenberg@linbit.com, target-devel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
	drbd-dev@lists.linbit.com, dm-devel@redhat.com
Subject: Re: [PATCH 2/8] target: remove iblock WRITE_SAME passthrough
	support
Message-ID: <20170601062845.GA16682@lst.de>
References: <20170410160807.23674-1-hch@lst.de> <20170410160807.23674-3-hch@lst.de> <1491975041.8231.131.camel@haakon3.risingtidesystems.com> <1496298421.27407.206.camel@haakon3.risingtidesystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1496298421.27407.206.camel@haakon3.risingtidesystems.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, May 31, 2017 at 11:27:01PM -0700, Nicholas A. Bellinger wrote:
> Hey HCH & Jens,
> 
> Is this already queued up for v4.13 to address the missing LBPRZ feature
> bit..?
> 
> If not, I'll happy to take it via target-pending along with the
> following to re-enable it via max_write_zeroes_sectors.

It's not queued up.  Feel free to take it through the target tree.
