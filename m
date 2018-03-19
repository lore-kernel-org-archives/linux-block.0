Return-Path: <hch@lst.de>
Date: Mon, 19 Mar 2018 20:52:24 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Cc: Scott Bauer <scott.bauer@intel.com>,
	Jonathan Derrick <jonathan.derrick@intel.com>,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 08/11] block: sed-opal: ioctl for writing to shadow
	mbr
Message-ID: <20180319195224.GA3380@lst.de>
References: <cover.1520946114.git.jonas.rabenstein@studium.uni-erlangen.de> <cover.1521482295.git.jonas.rabenstein@studium.uni-erlangen.de> <9f94be9c32887aacdcba75bd6a3902d0350eb987.1521482296.git.jonas.rabenstein@studium.uni-erlangen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9f94be9c32887aacdcba75bd6a3902d0350eb987.1521482296.git.jonas.rabenstein@studium.uni-erlangen.de>
List-ID: <linux-block@vger.kernel.org>

On Mon, Mar 19, 2018 at 07:36:50PM +0100, Jonas Rabenstein wrote:
> Allow modification of the shadow mbr. If the shadow mbr is not marked as
> done, this data will be presented read only as the device content. Only
> after marking the shadow mbr as done and unlocking a locking range the
> actual content is accessible.

I hate doing this as an ioctls.  Can we make this a sysfs binary file
so that people can use dd or cat to write the shadow mbr?
