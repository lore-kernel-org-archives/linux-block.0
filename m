Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 28 Jun 2017 17:25:25 -0400
From: Tejun Heo <tj@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: gregkh@linuxfoundation.org, Shaohua Li <shli@kernel.org>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	hch@lst.de, rostedt@goodmis.org, lizefan@huawei.com,
	Kernel-team@fb.com, Shaohua Li <shli@fb.com>
Subject: Re: [PATCH V4 00/12] blktrace: output cgroup info
Message-ID: <20170628212525.GB32311@htj.duckdns.org>
References: <cover.1498666964.git.shli@fb.com>
 <f458724a-464b-6039-4893-a2584540044d@kernel.dk>
 <20170628165316.nozfbdvmpflqwt3f@kernel.org>
 <15d71514-4f24-0cff-8f85-3e70268fc7a7@kernel.dk>
 <20170628181159.GB24647@htj.duckdns.org>
 <c6fb1aba-f836-bac1-bd7c-572b1bcb1ae8@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <c6fb1aba-f836-bac1-bd7c-572b1bcb1ae8@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

Hello,

On Wed, Jun 28, 2017 at 02:57:38PM -0600, Jens Axboe wrote:
> Personally I don't care that much, but the risk of conflicts is much
> higher on the block side, than on the kernfs side. So might be the
> path of less resistance to pull it through the block tree. And I'd be
> happy to do that, if the sign offs on the kernfs side are sufficient.

Block tree it is then.  Let's wait for Greg to respond.

Thanks.

-- 
tejun
