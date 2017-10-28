Return-Path: <guanjunxiong@huawei.com>
Subject: Re: [PATCH 06/17] block: introduce GENHD_FL_HIDDEN
To: Christoph Hellwig <hch@lst.de>, Mike Snitzer <snitzer@redhat.com>
CC: Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>,
        "Sagi
 Grimberg" <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>,
        <linux-block@vger.kernel.org>, Hannes Reinecke <hare@suse.de>,
        "Johannes
 Thumshirn" <jthumshirn@suse.de>,
        niuhaoxin <niuhaoxin@huawei.com>,
        "Shenhong
 (C)" <shenhong09@huawei.com>
References: <20171023145126.2471-1-hch@lst.de>
 <20171023145126.2471-7-hch@lst.de> <20171024213959.GB23307@redhat.com>
 <20171028063825.GA14261@lst.de>
From: Guan Junxiong <guanjunxiong@huawei.com>
Message-ID: <dc988a8a-8c88-fe20-34a0-de5cdd615b6b@huawei.com>
Date: Sat, 28 Oct 2017 15:20:07 +0800
MIME-Version: 1.0
In-Reply-To: <20171028063825.GA14261@lst.de>
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-block@vger.kernel.org>

Hi Christoph,

On 2017/10/28 14:38, Christoph Hellwig wrote:
> On Tue, Oct 24, 2017 at 05:40:00PM -0400, Mike Snitzer wrote:
>> Having the NVme driver go to such lengths to hide its resources from
>> upper layers is certainly the work of an evil genius experiencing some
>> serious territorial issues.  Not sugar-coating it.. you wouldn't.
> 
> I'm pretty surre Hannes will appreciate being called an evil genius :)
> 
>> I kept meaning to reply to your earlier iterations on this series to
>> ask: can we please get a CONFIG_NVME_MULTIPATHING knob to make it so
>> that the NVMe driver doesn't implicitly consume (and hide) all
>> per-controler devices?
> 
> I thought about adding it, but mostly for a different reason: it's
> quite a bit of code, and we now start to see NVMe in deeply embedded
> contexts, e.g. the latest Compact Flash spec is based on NVMe, so it
> might be a good idea to give people a chance to avoid the overhead.
> 

Think of some current advanced features of DM-Multipath combined with multipath-tools
such as path-latency priority grouping, intermittent IO error accounting for path
degradation, delayed or immediate or follow-over failback feature.
Those features, which is significant in some scenario, need to use per-controller block devices.
Therefore, I think it is worthy adding a CONFIG_NVME_MULTIPATHING knob to
hide or show per-controller block devices.

How about let me to add this this CONFIG_NVME_MULTIPATHING knob?

Regards
Guan



>> Ah well.  There is only one correct way to do NVMe multipathing after
>> all right?
> 
> I don't think you'll get very useful results, even if you try.  But I
> guess we'll just have to tell people to use SuSE if they want NVMe
> multipathing to work then :)
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
> 
> 
