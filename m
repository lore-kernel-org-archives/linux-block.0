Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "hch@lst.de" <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>
CC: "dm-devel@redhat.com" <dm-devel@redhat.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>
Subject: Re: [PATCH 04/15] dm: fix REQ_RAHEAD handling
Date: Wed, 24 May 2017 16:07:32 +0000
Message-ID: <1495642051.2823.9.camel@sandisk.com>
References: <20170518131812.22956-1-hch@lst.de>
	 <20170518131812.22956-5-hch@lst.de>
In-Reply-To: <20170518131812.22956-5-hch@lst.de>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Thu, 2017-05-18 at 15:18 +0200, Christoph Hellwig wrote:
> A few (but not all) dm targets use a special EWOULDBLOCK error code for
> failing REQ_RAHEAD requests that fail due to a lack of available resource=
s.
> But no one else knows about this magic code, and lower level drivers also
> don't generate it when failing read-ahead requests for similar reasons.
>=20
> So remove this special casing and ignore all additional error handling fo=
r
> REQ_RAHEAD - if this was a real underlying error we'd get a normal read
> once the real read comes in.

Reviewed-by: Bart Van Assche <Bart.VanAssche@sandisk.com>=
