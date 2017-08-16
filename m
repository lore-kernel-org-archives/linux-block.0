Return-Path: <axboe@kernel.dk>
Subject: Re: migrate the block tests from Dimity to blktests?
To: Christoph Hellwig <hch@lst.de>, Omar Sandoval <osandov@fb.com>,
 Johannes Thumshirn <jth@kernel.org>, Hannes Reinecke <hare@suse.com>,
 Dmitry Monakhov <dmonakhov@openvz.org>
Cc: linux-block@vger.kernel.org
References: <20170816091733.GA22832@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <b8bf8b27-8fda-2251-9726-25f9cf6a099b@kernel.dk>
Date: Wed, 16 Aug 2017 08:46:56 -0600
MIME-Version: 1.0
In-Reply-To: <20170816091733.GA22832@lst.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 08/16/2017 03:17 AM, Christoph Hellwig wrote:
> Hi all,
> 
> Dmitry Monakhov wrote a few very useful block layers tests a while
> ago and wired them up for xfstests at that point:
> 
> 	https://github.com/dmonakhov/xfstests/commits/dif-dix-tests-v2
> 
> Is anyone interested in migrating them over to blktests?  Doing
> so has been on my todo list for a while, but given that said
> lists keeps growing I'd like to check if anyone else might be
> interested.

Yes please, that would be awesome.

-- 
Jens Axboe
