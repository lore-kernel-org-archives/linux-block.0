Return-Path: <ak@linux.intel.com>
Date: Mon, 22 Jan 2018 10:08:09 -0800
From: Andi Kleen <ak@linux.intel.com>
To: Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, darrick.wong@oracle.com,
	Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH v5 1/2] Return bytes transferred for partial direct I/O
Message-ID: <20180122180809.GM7844@tassilo.jf.intel.com>
References: <20180119005741.32058-1-rgoldwyn@suse.de>
 <87zi58rmf7.fsf@linux.intel.com>
 <c7661c89-1deb-c967-4b19-c1897937f4a3@suse.de>
 <b6847555-6295-0f28-08f2-ad871bf91332@kernel.dk>
 <35fe5b08-aed3-2819-89d1-41dbe6a81ee5@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <35fe5b08-aed3-2819-89d1-41dbe6a81ee5@suse.de>
List-ID: <linux-block@vger.kernel.org>

> The only way I can think is that a DIO write should check early enough
> that the write(N) will complete with N bytes without an error. Is it
> possible to completely guarantee that?

Probably not.

> 
> Leaving it as it is incorrect as quoted in the artificial test case. You
> should not be changing the file and yet conveying to the user an error
> for the same write() call. It should either be an error and the file
> contents are unchanged, or it should be change in contents and the write
> size returned.

There are already lots of syscall cases that don't completely
undo changes on error handling.  Fixing that would likely require
a transaction system higher level in the kernel, or lots of 
complicated code everywhere, which is unlikely to happen. 

Also the complicated code would be difficult to test,
and likely bit rot over time, because it would be only an error handling
path that is infrequently exercised.

So yes it's not nice, but the alternative would be worse.

I think we're best of leaving it as it is now.

Adding some comments/documentation to explain this would be good though.
Perhaps you could submit a patch to the manpage?

-Andi
