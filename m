Return-Path: <mgorman@techsingularity.net>
Date: Tue, 8 Aug 2017 12:55:12 +0100
From: Mel Gorman <mgorman@techsingularity.net>
To: Ming Lei <tom.leiming@gmail.com>
Cc: Paolo Valente <paolo.valente@linaro.org>,
	Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-block <linux-block@vger.kernel.org>
Subject: Re: Switching to MQ by default may generate some bug reports
Message-ID: <20170808115512.zjcrpn4tiljomtrw@techsingularity.net>
References: <1B2E3D98-1152-413F-84A9-B3DAC5A528E8@linaro.org>
 <20170803110144.vvadm3cc5oetf7up@techsingularity.net>
 <4B181ED1-8605-4156-9BBF-B61A165BE7F5@linaro.org>
 <20170804110103.oljdzsy7bds6qylo@techsingularity.net>
 <34B4C2EB-18B2-4EAB-9BBC-8095603D733D@linaro.org>
 <70979B37-6F91-49C3-9C77-CB3364035DDF@linaro.org>
 <20170808103023.2b2tks5y5lniuq2k@techsingularity.net>
 <CACVXFVPCBaFwGXnR_2f+g5VuXYCYK-3L8menfQrG2VLv2UHoLw@mail.gmail.com>
 <20170808112711.om7z6djl6igsuvnm@techsingularity.net>
 <CACVXFVMmcU8SWVFsMfRS9co7gZ=0docvm8Y=-HJJG0v9xSRAVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <CACVXFVMmcU8SWVFsMfRS9co7gZ=0docvm8Y=-HJJG0v9xSRAVw@mail.gmail.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, Aug 08, 2017 at 07:49:53PM +0800, Ming Lei wrote:
> On Tue, Aug 8, 2017 at 7:27 PM, Mel Gorman <mgorman@techsingularity.net> wrote:
> > On Tue, Aug 08, 2017 at 06:43:03PM +0800, Ming Lei wrote:
> >> Hi Mel Gorman,
> >>
> >> On Tue, Aug 8, 2017 at 6:30 PM, Mel Gorman <mgorman@techsingularity.net> wrote:
> >> ....
> >> >
> >> > o I've queued a subset of tests with Ming's v3 patchset as that was the
> >> >   latest branch at the time I looked. It'll take quite some time to execute
> >> >   as the grid I use to collect data is backlogged with other work
> >>
> >> The latest patchset is in the following post:
> >>
> >>       http://marc.info/?l=linux-block&m=150191624318513&w=2
> >>
> >> And you can find it in my github:
> >>
> >>       https://github.com/ming1/linux/commits/blk-mq-dispatch_for_scsi.V4
> >>
> >
> > Unfortunately, the tests were queued last Friday and are partially complete
> > depending on when machines become available. As it is, v3 will take a few
> > days to complete and a requeue would incur further delays. If you believe
> > the results will be substantially different then I'll discard v3 and requeue.
> 
> Firstly V3 on github(never posted out) causes boot hang if CPU cores is >= 16,
> so you need to check if the test is still running, :-(
> 

By co-incidence, the few machines that have completed had core counts
below this so I'll discard existing results and requeue.

Thanks.

-- 
Mel Gorman
SUSE Labs
