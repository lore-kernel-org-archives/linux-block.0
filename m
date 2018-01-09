Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 9 Jan 2018 07:46:42 -0800
From: "tj@kernel.org" <tj@kernel.org>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "jbacik@fb.com" <jbacik@fb.com>, "jack@suse.cz" <jack@suse.cz>,
	"clm@fb.com" <clm@fb.com>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"kernel-team@fb.com" <kernel-team@fb.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"jianchao.w.wang@oracle.com" <jianchao.w.wang@oracle.com>,
	"hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH 3/8] blk-mq: replace timeout synchronization with a RCU
 and generation based scheme
Message-ID: <20180109154642.GK3668920@devbig577.frc2.facebook.com>
References: <20180108191542.379478-1-tj@kernel.org>
 <20180108191542.379478-4-tj@kernel.org>
 <1515454150.2909.34.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1515454150.2909.34.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Mon, Jan 08, 2018 at 11:29:11PM +0000, Bart Van Assche wrote:
> Does "gstate" perhaps stand for "generation number and state"? If so, please
> mention this in one of the above comments.

Yeah, will do.

Thanks.

-- 
tejun
