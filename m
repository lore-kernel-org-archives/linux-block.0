Return-Path: <natechancellor@gmail.com>
Return-Path: <natechancellor@gmail.com>
Date: Thu, 4 Oct 2018 12:22:31 -0700
From: Nathan Chancellor <natechancellor@gmail.com>
To: Lars Ellenberg <lars.ellenberg@linbit.com>
Cc: Philipp Reisner <philipp.reisner@linbit.com>,
	Jens Axboe <axboe@kernel.dk>, drbd-dev@lists.linbit.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH RESEND] drbd: avoid clang warning about pointless switch
 statement
Message-ID: <20181004192231.GA29744@localhost>
References: <20181002171447.10765-1-natechancellor@gmail.com>
 <20181004191854.GD10984@soda.linbit>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20181004191854.GD10984@soda.linbit>
List-ID: <linux-block@vger.kernel.org>

On Thu, Oct 04, 2018 at 09:18:54PM +0200, Lars Ellenberg wrote:
> On Tue, Oct 02, 2018 at 10:14:48AM -0700, Nathan Chancellor wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> > 
> > The drbd code causes warnings that we cannot easily disable when building with clang:
> > 
> > In file included from drivers/block/drbd/drbd_debugfs.c:10:
> > In file included from drivers/block/drbd/drbd_int.h:48:
> > In file included from include/linux/drbd_genl_api.h:53:
> > In file included from include/linux/genl_magic_struct.h:237:
> > include/linux/drbd_genl.h:300:1: warning: no case matching constant switch condition '0'
> > 
> > There is nothing wrong with the code, and adding 'default:' labels
> > in the right place is enough to let clang shut up about the warning.
> 
> Actually, I think I'd prefer a "case 0:" instead of the "default:",
> because that would assert that we don't use a 0 for op or field numbers.
> 
> As at least some people seem to care, I suggest we bundle up
> this and the other clang warning you just resent the patch for
> with whatever else we may come up with for the next merge window
> and send a pull request to Jens then.
> In case we forget, please send a friendly reminder.
> 
> Thanks,
> 
>     Lars
> 

Hi Lars,

I will go ahead and test that change shortly and send it over for
review.

Thanks for the quick reply!
Nathan
