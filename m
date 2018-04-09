Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 9 Apr 2018 11:56:16 -0700
From: "tj@kernel.org" <tj@kernel.org>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "hch@lst.de" <hch@lst.de>, "maxg@mellanox.com" <maxg@mellanox.com>,
	"israelr@mellanox.com" <israelr@mellanox.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH] blk-mq: Fix recently introduced races in the timeout
 handling code
Message-ID: <20180409185616.GG3126663@devbig577.frc2.facebook.com>
References: <20180409052038.5391-1-bart.vanassche@wdc.com>
 <20180409164737.GE3126663@devbig577.frc2.facebook.com>
 <4e32290f8d5901fbd16116d1623d37dbfdc1e1b8.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4e32290f8d5901fbd16116d1623d37dbfdc1e1b8.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Hello,

On Mon, Apr 09, 2018 at 05:03:05PM +0000, Bart Van Assche wrote:
> My opinion is not only that the two patches that you posted recently do not
> fix all the races that are fixed by this patch but also that the races that

The race was with the path where the ownership of a timed out request
is passed back to normal completion path and those two patches fix
that, right?

> exist today in the blk-mq timeout handling code cannot be fixed completely
> using RCU only.

I really don't think that is that complicated.  Let's first confirm
the race fix and get to narrowing / closing that window.

> That race window did not exist in the legacy block layer. I don't think

IIRC, it did.  It was there when I first started working on libata EH
years ago.

Thanks.

-- 
tejun
