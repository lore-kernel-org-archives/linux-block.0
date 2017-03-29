Return-Path: <osandov@osandov.com>
Return-Path: <osandov@osandov.com>
Date: Wed, 29 Mar 2017 10:06:08 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 1/3] block: warn if sharing request queue across
 gendisks
Message-ID: <20170329170608.GA19015@vader>
References: <91d938665e5386f10f8756ee8c7ef3e6496ea260.1490742717.git.osandov@fb.com>
 <20170329141035.GB8461@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170329141035.GB8461@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Wed, Mar 29, 2017 at 08:10:35AM -0600, Jens Axboe wrote:
> On Tue, Mar 28 2017, Omar Sandoval wrote:
> > From: Omar Sandoval <osandov@fb.com>
> > 
> > Now that the remaining drivers have been converted to one request queue
> > per gendisk, let's warn if a request queue gets registered more than
> > once. This will catch future drivers which might do it inadvertently or
> > any old drivers that I may have missed.
> 
> Added 1-3 for 4.12, thanks. Final nail in the coffin for shared queues.

Thanks!

> BTW, can you include a cover letter when it's more than one patch? Makes
> the flow a bit more straight forward.

Yeah, I'll make sure to do that in the future.
