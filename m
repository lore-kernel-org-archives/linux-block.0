Return-Path: <keith.busch@intel.com>
Date: Tue, 17 Apr 2018 16:19:27 -0600
From: Keith Busch <keith.busch@intel.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Matias =?iso-8859-1?Q?Bj=F8rling?= <mb@lightnvm.io>,
	Wei Xu <wxu@cnexlabs.com>, linux-nvme@lists.infradead.org,
	javier@cnexlabs.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: lightnvm: add granby support
Message-ID: <20180417221926.GH11513@localhost.localdomain>
References: <1523930112-7402-1-git-send-email-wxu@cnexlabs.com>
 <6e50972d-f806-52ac-7983-2642bd211afa@lightnvm.io>
 <20180417220901.GG11513@localhost.localdomain>
 <6701f433-e865-5a17-f1c7-4c0e0c5effaa@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <6701f433-e865-5a17-f1c7-4c0e0c5effaa@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Tue, Apr 17, 2018 at 04:15:38PM -0600, Jens Axboe wrote:
> >> Looks good to me.
> >>
> >> Reviewed-by: Matias Bj�rling <mb@lightnvm.io>
> >>
> >> Keith, when convenient can you pick this up for 4.18?
> > 
> > This looks safe for 4.17-rc2, no? Unless you want to wait for the next
> > release.
> 
> It should wait for the next release, it's not a fix.

Okay, queued up for the next release. I'll wait a few more rc's before
posting the  nvme-4.18 branch.
