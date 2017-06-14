Return-Path: <BATV+a531e2bbbc8af89517f3+5043+infradead.org+hch@bombadil.srs.infradead.org>
Date: Wed, 14 Jun 2017 09:01:27 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	adilger@dilger.ca
Subject: Re: [PATCHSET v2] Add support for write life time hints
Message-ID: <20170614160127.GA30644@infradead.org>
References: <1497412919-19400-1-git-send-email-axboe@kernel.dk>
 <yq160fyvah7.fsf@oracle.com>
 <d3e724ea-38f8-213f-a9ce-f78adc028e47@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <d3e724ea-38f8-213f-a9ce-f78adc028e47@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Wed, Jun 14, 2017 at 09:53:05AM -0600, Jens Axboe wrote:
> So how about we just call it "write_hint"? It sounds mostly like a
> naming issue to me, as you would then map that to some specific stream
> in your driver. You're free to do that right now. They are all flags,
> it's just packed as a value to not waste too much space.

I think what Martin wants (or at least what I'd want him to want) is
to define a few REQ_* bits that mirror the RWF bits, use that to
transfer the information down the stack, and then only translate it
to stream ids in the driver.
