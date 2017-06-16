Return-Path: <BATV+48ca1ab4adaecdf09dc3+5045+infradead.org+hch@bombadil.srs.infradead.org>
Date: Fri, 16 Jun 2017 00:33:39 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>,
	"Darrick J. Wong" <darrick.wong@oracle.com>,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	adilger@dilger.ca, martin.petersen@oracle.com
Subject: Re: [PATCH 04/11] fs: add support for allowing applications to pass
 in write life time hints
Message-ID: <20170616073339.GC8682@infradead.org>
References: <1497498312-17704-1-git-send-email-axboe@kernel.dk>
 <1497498312-17704-5-git-send-email-axboe@kernel.dk>
 <20170615041503.GB4521@birch.djwong.org>
 <a0689580-ac50-3e2c-7c00-2d59e130c9a9@kernel.dk>
 <20170615081914.GD10599@infradead.org>
 <7f8e2e3c-fa15-6864-7afd-b82e5afb87b5@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7f8e2e3c-fa15-6864-7afd-b82e5afb87b5@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Thu, Jun 15, 2017 at 08:21:18AM -0600, Jens Axboe wrote:
> I'd still very much like to stick to the same four hints, and not

Agreed.  In fact I'd go a little further:  we should have a

	u16 hints;

that goes all the way down from fcntl to the driver, right now
we'll allocate the first 3 bits for the write lifetime hints (2.5,
so we have one value spare, as they don't need to flags but can be
enum values), leaving more space for other kinds of hints.

> require any special setup. I think the lazy setup for nvme is fine. Some
> devices can do it at probe time, others will want to do it lazily to not
> waste resources. Do we really want to have the HINT_SET bubble down to
> the device and allocate streams?

If I look at the mess for allocating the streams I think we need it
to bubble down.  That way the device can allocate the stream at time
of the fcntl and we can keep the low level driver very simple.
