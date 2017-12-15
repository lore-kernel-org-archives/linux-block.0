Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 15 Dec 2017 05:30:48 -0800
From: "tj@kernel.org" <tj@kernel.org>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"kernel-team@fb.com" <kernel-team@fb.com>,
	"oleg@redhat.com" <oleg@redhat.com>, "hch@lst.de" <hch@lst.de>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"jianchao.w.wang@oracle.com" <jianchao.w.wang@oracle.com>,
	"osandov@fb.com" <osandov@fb.com>
Subject: Re: [PATCH 2/6] blk-mq: replace timeout synchronization with a RCU
 and generation based scheme
Message-ID: <20171215133048.GI3919388@devbig577.frc2.facebook.com>
References: <20171212190134.535941-1-tj@kernel.org>
 <20171212190134.535941-3-tj@kernel.org>
 <1513277469.2475.43.camel@wdc.com>
 <20171214191935.GB3919388@devbig577.frc2.facebook.com>
 <1513286010.2475.58.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1513286010.2475.58.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Hello, Bart.

On Thu, Dec 14, 2017 at 09:13:32PM +0000, Bart Van Assche wrote:
...
> however is called before a every use of a request. Sorry but I'm not
> enthusiast about the code in blk_rq_init() that reinitializes state
> information that should survive request reuse.

If it wasn't clear, me neither.  I think what'd be better is making
those paths use the usual request allocation path instead of custom
one but for flush handling, that's not gonna be trivial, so let's deal
with that later.

Thanks.

-- 
tejun
