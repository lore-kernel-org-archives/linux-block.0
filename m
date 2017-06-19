Return-Path: <BATV+c839010d8a82889b76e4+5048+infradead.org+hch@bombadil.srs.infradead.org>
Date: Mon, 19 Jun 2017 11:53:14 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, adilger@dilger.ca,
	martin.petersen@oracle.com
Subject: Re: [PATCH 11/11] nvme: add support for streams and directives
Message-ID: <20170619185314.GA32047@infradead.org>
References: <1497633883-21230-12-git-send-email-axboe@kernel.dk>
 <20170616180942.GD27996@infradead.org>
 <9811b106-a954-2481-8a66-afb25df76812@kernel.dk>
 <20170617122106.GB8320@infradead.org>
 <1ede2083-69db-a86f-8e32-43ca293e9c8e@kernel.dk>
 <20170617150303.GA15290@infradead.org>
 <b159f6cb-a272-cd06-207a-4cce8336c86d@kernel.dk>
 <20170619062557.GA2311@infradead.org>
 <03b922f9-677e-9618-663e-09f023977fa8@kernel.dk>
 <0e920111-7846-f7f6-2288-e375f6a43843@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0e920111-7846-f7f6-2288-e375f6a43843@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Mon, Jun 19, 2017 at 08:53:08AM -0600, Jens Axboe wrote:
> Looking at it a bit more closely - there's a difference between
> assigning X number of streams (allocating) for use by the subsystem or
> per-ns, and having to manually open them. So I don't necessarily think
> there's a problem here, neither for us or on the device.

As far as I can tell the allocate resource is only supposed to be
for an individual namespace:

Section 9.3:

"Stream resources may be allocated for the exclusive use of a specified
 namespace associated with a particular Host Identifier using the Allocate
 Resources operation. Stream resources that are not allocated for the
 exclusive use of any namespace are available NVM subsystem stream
 resources as reported in NVM Subsystem Streams Available (NSSA) and may
 be used by any namespace that has the Streams Directive enabled and has
 not been allocated exclusive stream resources in response to an
 Allocate Resources operation"

Section 9.3.1.3:

"The Allocate Resources operation indicates the number of streams that the host requests for the exclusive use of the specified namespace."

I think this is pretty clear, but if not it would be good if you could
bring it into the working group so that we can clarify it further.

> Awaiting clarification from the vendor what their position/view of this
> is. Reading the spec, I do agree that it leans towards only needing
> allocation for a specific name space, but it doesn't explicitly say that
> you can use any of the available streams, without allocation, if they
> haven't been assigned to a specific name space. I would interpret it
> that way, though.

Let's get some text into an ECN either way to clarify it..
