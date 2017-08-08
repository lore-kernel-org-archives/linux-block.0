Return-Path: <tom.leiming@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20170808103023.2b2tks5y5lniuq2k@techsingularity.net>
References: <20170803085115.r2jfz2lofy5spfdb@techsingularity.net>
 <1B2E3D98-1152-413F-84A9-B3DAC5A528E8@linaro.org> <20170803110144.vvadm3cc5oetf7up@techsingularity.net>
 <4B181ED1-8605-4156-9BBF-B61A165BE7F5@linaro.org> <20170804110103.oljdzsy7bds6qylo@techsingularity.net>
 <34B4C2EB-18B2-4EAB-9BBC-8095603D733D@linaro.org> <70979B37-6F91-49C3-9C77-CB3364035DDF@linaro.org>
 <20170808103023.2b2tks5y5lniuq2k@techsingularity.net>
From: Ming Lei <tom.leiming@gmail.com>
Date: Tue, 8 Aug 2017 18:43:03 +0800
Message-ID: <CACVXFVPCBaFwGXnR_2f+g5VuXYCYK-3L8menfQrG2VLv2UHoLw@mail.gmail.com>
Subject: Re: Switching to MQ by default may generate some bug reports
To: Mel Gorman <mgorman@techsingularity.net>
Cc: Paolo Valente <paolo.valente@linaro.org>, Christoph Hellwig <hch@infradead.org>,
	Jens Axboe <axboe@kernel.dk>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

Hi Mel Gorman,

On Tue, Aug 8, 2017 at 6:30 PM, Mel Gorman <mgorman@techsingularity.net> wrote:
....
>
> o I've queued a subset of tests with Ming's v3 patchset as that was the
>   latest branch at the time I looked. It'll take quite some time to execute
>   as the grid I use to collect data is backlogged with other work

The latest patchset is in the following post:

      http://marc.info/?l=linux-block&m=150191624318513&w=2

And you can find it in my github:

      https://github.com/ming1/linux/commits/blk-mq-dispatch_for_scsi.V4

-- 
Ming Lei
