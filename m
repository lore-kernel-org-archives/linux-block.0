Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 2 Apr 2018 15:01:36 -0700
From: "tj@kernel.org" <tj@kernel.org>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "kernel-team@fb.com" <kernel-team@fb.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH 2/2] blk-mq: Fix request handover from timeout path to
 normal execution
Message-ID: <20180402220136.GI388343@devbig577.frc2.facebook.com>
References: <20180402190053.GC388343@devbig577.frc2.facebook.com>
 <20180402190120.GD388343@devbig577.frc2.facebook.com>
 <b52fa22c-c7fa-5ebd-35cb-527786e6d08e@wdc.com>
 <20180402211047.GF388343@devbig577.frc2.facebook.com>
 <afef8f4812b357deeadc0999f4c85d7b0049b738.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <afef8f4812b357deeadc0999f4c85d7b0049b738.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Hello,

On Mon, Apr 02, 2018 at 09:56:41PM +0000, Bart Van Assche wrote:
> This patch increases the time during which .aborted_gstate == .gstate if the
> timeout is reset. Does that increase the chance that a completion will be missed
> if the request timeout is reset?

It sure does, but we're comparing an outright kernel bug vs. an
inherently opportunistic mechanism being a bit more lossy.  I think
the answer is pretty clear.

Thanks.

-- 
tejun
