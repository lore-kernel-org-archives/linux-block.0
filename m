Return-Path: <BATV+3b6ae1af95979780b024+5046+infradead.org+hch@bombadil.srs.infradead.org>
Date: Sat, 17 Jun 2017 08:03:03 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, adilger@dilger.ca,
	martin.petersen@oracle.com
Subject: Re: [PATCH 11/11] nvme: add support for streams and directives
Message-ID: <20170617150303.GA15290@infradead.org>
References: <1497633883-21230-1-git-send-email-axboe@kernel.dk>
 <1497633883-21230-12-git-send-email-axboe@kernel.dk>
 <20170616180942.GD27996@infradead.org>
 <9811b106-a954-2481-8a66-afb25df76812@kernel.dk>
 <20170617122106.GB8320@infradead.org>
 <1ede2083-69db-a86f-8e32-43ca293e9c8e@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1ede2083-69db-a86f-8e32-43ca293e9c8e@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Sat, Jun 17, 2017 at 08:20:01AM -0600, Jens Axboe wrote:
> We can certainly go that route. So you'd be fine with allocating 4
> streams controller wide by default, and dump the lazy alloc? We can make
> this depend on the streams module parameter, so people could turn it
> off, if needed.

We don't even need to allocate the streams - streams are implicitly
allocated on first use:

"Stream resources that are not allocated for the exclusive use of any
 namespace are available NVM subsystem stream resources as reported in
 NVM Subsystem Streams Available (NSSA) and may be used by any namespace
 that has the Streams Directive enabled and has not been allocated
 exclusive stream resources in response to an Allocate Resources
 operation."

so the only thing you need to do is to enable streams on the namespace,
or just for whole whole controller using nsid=0xffffffff
