Return-Path: <BATV+f0546c30ddc9806fdc7a+5193+infradead.org+hch@bombadil.srs.infradead.org>
Date: Sat, 11 Nov 2017 01:07:51 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Subject: Re: for-4.15/block rebased
Message-ID: <20171111090751.GA13421@infradead.org>
References: <7217b2a1-12cb-966d-5dd8-0d290f8be695@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7217b2a1-12cb-966d-5dd8-0d290f8be695@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

Yikes.  Can you at least re-pull the nvme bits so we can keep
the original commit dates for those?  Those actually are a huge
part of the rebased commits, and that way we might not get Linus
shouting at us this merge window at least..

On Fri, Nov 10, 2017 at 08:02:00PM -0700, Jens Axboe wrote:
> Hi,
> 
> Just a heads up that due to a fuckup of mine, I have rebased the above
> mentioned branch. The code is the same, but the history was screwed up.
> Not great timing coming up on the merge window, but it is what it is...
> 
> -- 
> Jens Axboe
> 
---end quoted text---
