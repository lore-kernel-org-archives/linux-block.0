Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 10 Apr 2018 08:40:43 -0700
From: "tj@kernel.org" <tj@kernel.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Bart Van Assche <Bart.VanAssche@wdc.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"israelr@mellanox.com" <israelr@mellanox.com>,
	"sagi@grimberg.me" <sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"maxg@mellanox.com" <maxg@mellanox.com>
Subject: Re: [PATCH v4] blk-mq: Fix race conditions in request timeout
 handling
Message-ID: <20180410154043.GP3126663@devbig577.frc2.facebook.com>
References: <20180410013455.7448-1-bart.vanassche@wdc.com>
 <20180410084133.GB9133@ming.t460p>
 <b36ea1107be4f32fb04fffdde3ee45a2e0fcc36c.camel@wdc.com>
 <20180410135541.GA22340@ming.t460p>
 <7c4a8b019182d5a9259ef20e6462b3f6a533abed.camel@wdc.com>
 <20180410143007.GB22340@ming.t460p>
 <e2762e359649946543ee22cf6ebf0c08410f7963.camel@wdc.com>
 <20180410152553.GC22340@ming.t460p>
 <20180410153031.GO3126663@devbig577.frc2.facebook.com>
 <20180410153812.GA3219@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180410153812.GA3219@ming.t460p>
List-ID: <linux-block@vger.kernel.org>

Hello,

On Tue, Apr 10, 2018 at 11:38:18PM +0800, Ming Lei wrote:
> I agree, the issue should be in driver's irq handler and .timeout in
> theory.
> 
> For example, even though one request has been done by irq handler, .timeout
> still may return RESET_TIMER.

blk-mq can use a separate flag to track normal completions during
timeout and complete the request normally on RESET_TIMER if the flag
is set while EH was in progress.  With a bit of care, we'd be able to
plug the race completely.

Thanks.

-- 
tejun
