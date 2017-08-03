Return-Path: <mgorman@techsingularity.net>
Date: Thu, 3 Aug 2017 11:46:57 +0100
From: Mel Gorman <mgorman@techsingularity.net>
To: Paolo Valente <paolo.valente@linaro.org>
Cc: Ming Lei <tom.leiming@gmail.com>, Christoph Hellwig <hch@infradead.org>,
	Jens Axboe <axboe@kernel.dk>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-block <linux-block@vger.kernel.org>
Subject: Re: Switching to MQ by default may generate some bug reports
Message-ID: <20170803104657.eyxuona33ar5cpp4@techsingularity.net>
References: <20170803085115.r2jfz2lofy5spfdb@techsingularity.net>
 <CACVXFVP3M64ebQQM-aaBs8-TKFqkgVCvO2TQbB6xLcp9_5Q3Sg@mail.gmail.com>
 <20170803094242.wol67mmga3om4gjp@techsingularity.net>
 <DAC70C00-B51D-4752-8EA7-EA55368918EC@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <DAC70C00-B51D-4752-8EA7-EA55368918EC@linaro.org>
List-ID: <linux-block@vger.kernel.org>

On Thu, Aug 03, 2017 at 11:44:06AM +0200, Paolo Valente wrote:
> > That series is dealing with problems with legacy-deadline vs mq-none where
> > as the bulk of the problems reported in this mail are related to
> > legacy-CFQ vs mq-BFQ.
> > 
> 
> Out-of-curiosity: you get no regression with mq-none or mq-deadline?
> 

I didn't test mq-none as the underlying storage was not fast enough to
make a legacy-noop vs mq-none meaningful. legacy-deadline vs mq-deadline
did show small regressions on some workloads but not as dramatic and
small enough that it would go unmissed in some cases.

-- 
Mel Gorman
SUSE Labs
