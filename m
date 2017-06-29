Return-Path: <gregkh@linuxfoundation.org>
Date: Thu, 29 Jun 2017 14:50:20 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Tejun Heo <tj@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Shaohua Li <shli@kernel.org>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	hch@lst.de, rostedt@goodmis.org, lizefan@huawei.com,
	Kernel-team@fb.com, Shaohua Li <shli@fb.com>
Subject: Re: [PATCH V4 00/12] blktrace: output cgroup info
Message-ID: <20170629125020.GA26046@kroah.com>
References: <cover.1498666964.git.shli@fb.com>
 <f458724a-464b-6039-4893-a2584540044d@kernel.dk>
 <20170628165316.nozfbdvmpflqwt3f@kernel.org>
 <15d71514-4f24-0cff-8f85-3e70268fc7a7@kernel.dk>
 <20170628181159.GB24647@htj.duckdns.org>
 <c6fb1aba-f836-bac1-bd7c-572b1bcb1ae8@kernel.dk>
 <20170628212525.GB32311@htj.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170628212525.GB32311@htj.duckdns.org>
List-ID: <linux-block@vger.kernel.org>

On Wed, Jun 28, 2017 at 05:25:25PM -0400, Tejun Heo wrote:
> Hello,
> 
> On Wed, Jun 28, 2017 at 02:57:38PM -0600, Jens Axboe wrote:
> > Personally I don't care that much, but the risk of conflicts is much
> > higher on the block side, than on the kernfs side. So might be the
> > path of less resistance to pull it through the block tree. And I'd be
> > happy to do that, if the sign offs on the kernfs side are sufficient.
> 
> Block tree it is then.  Let's wait for Greg to respond.

block tree is fine with me, I'll go ack the kernfs patches now.

thanks,

greg k-h
