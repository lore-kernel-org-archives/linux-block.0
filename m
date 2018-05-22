Return-Path: <andriy.shevchenko@linux.intel.com>
Message-ID: <d00e1db87dec40dcc2a78f06a62e7df8fbfbdd51.camel@linux.intel.com>
Subject: Re: [PATCH 2/5] bcache: Split out crc64 to library
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Coly Li <colyli@suse.de>, axboe@kernel.dk, linux-bcache@vger.kernel.org
Cc: linux-block@vger.kernel.org
Date: Tue, 22 May 2018 14:42:35 +0300
In-Reply-To: <b7b0e4a9-10bf-dbff-f8ab-979345f3cd3b@suse.de>
References: <20180522093200.67193-1-colyli@suse.de>
	 <20180522093200.67193-3-colyli@suse.de>
	 <b7b0e4a9-10bf-dbff-f8ab-979345f3cd3b@suse.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Tue, 2018-05-22 at 18:33 +0800, Coly Li wrote:
> On 2018/5/22 5:31 PM, Coly Li wrote:
> > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > 
> > For generic use split out crc64 code to a separate module
> > in the library folder.
> > 
> > No functional change intended.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Signed-off-by: Coly Li <colyli@suse.de>
> 
> Hi Jens and Andy,
> 
> After discussed on mailing list, I realize the original crc64 code was
> copied from postgreSQL with PostgreSQL license. So we are not able to
> move the code into lib/crc64 and grant GPL license to the symbols.

Indeed, I also didn't pay much attention to the exporting the symbols.
Another question if that code may be present in kernel in the first
place.

> I will ask lawyers about how to handle the license issue.
> For this moment I will hold this patch and not submit it to Linux
> v4.18.

You still can apply the rest of clean ups which do not touch this part.

> Sorry for the inconvenience.

I have to apologize as well for not being picky about licenses when was
cooking a patch.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
