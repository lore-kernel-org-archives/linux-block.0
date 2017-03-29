Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
Date: Wed, 29 Mar 2017 08:10:35 -0600
To: Omar Sandoval <osandov@osandov.com>
Cc: linux-block@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 1/3] block: warn if sharing request queue across
 gendisks
Message-ID: <20170329141035.GB8461@kernel.dk>
References: <91d938665e5386f10f8756ee8c7ef3e6496ea260.1490742717.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <91d938665e5386f10f8756ee8c7ef3e6496ea260.1490742717.git.osandov@fb.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, Mar 28 2017, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> Now that the remaining drivers have been converted to one request queue
> per gendisk, let's warn if a request queue gets registered more than
> once. This will catch future drivers which might do it inadvertently or
> any old drivers that I may have missed.

Added 1-3 for 4.12, thanks. Final nail in the coffin for shared queues.

BTW, can you include a cover letter when it's more than one patch? Makes
the flow a bit more straight forward.

-- 
Jens Axboe
