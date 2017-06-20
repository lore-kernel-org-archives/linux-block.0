Return-Path: <BATV+36629bb5a09a6c0004be+5049+infradead.org+hch@bombadil.srs.infradead.org>
Date: Tue, 20 Jun 2017 05:47:38 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, adilger@dilger.ca,
	martin.petersen@oracle.com
Subject: Re: [PATCH 04/11] fs: add support for allowing applications to pass
 in write life time hints
Message-ID: <20170620124738.GA16917@infradead.org>
References: <b04642e6-4ecc-f2e8-8184-6fff302d3d0b@kernel.dk>
 <8db675e7-b868-bae1-784a-33cba67d0874@kernel.dk>
 <20170619185805.GC32047@infradead.org>
 <5259a1ba-1c5f-2d89-3b47-3a81cd0a3e4e@kernel.dk>
 <0c3c6a33-77c5-337e-66e0-49fe22d3cc4e@kernel.dk>
 <3e6f7b97-8372-b268-f55a-cc88812c1a68@kernel.dk>
 <20170620085739.GB31386@infradead.org>
 <6f1be22c-b172-3645-f0ab-8124188756df@kernel.dk>
 <20170620124355.GA6199@infradead.org>
 <6793e5b9-b324-727a-6227-69b5fe233bc4@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6793e5b9-b324-727a-6227-69b5fe233bc4@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Tue, Jun 20, 2017 at 06:45:45AM -0600, Jens Axboe wrote:
> To the page? Where do you want to find room for that?

In the page we don't.  In the buffer_head we have plenty (as will
the replacement for it if I ever get time to get back to that)
