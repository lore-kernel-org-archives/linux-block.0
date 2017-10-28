Return-Path: <linux-block-owner@vger.kernel.org>
Received: from [45.249.212.32] ([45.249.212.32]:39848 "EHLO huawei.com"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750930AbdJ1KKF (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 28 Oct 2017 06:10:05 -0400
Subject: Re: [PATCH 06/17] block: introduce GENHD_FL_HIDDEN
To: Christoph Hellwig <hch@lst.de>
CC: Mike Snitzer <snitzer@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        "Keith Busch" <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        <linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>,
        "Hannes Reinecke" <hare@suse.de>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        niuhaoxin <niuhaoxin@huawei.com>,
        "Shenhong (C)" <shenhong09@huawei.com>
References: <20171023145126.2471-1-hch@lst.de>
 <20171023145126.2471-7-hch@lst.de> <20171024213959.GB23307@redhat.com>
 <20171028063825.GA14261@lst.de>
 <dc988a8a-8c88-fe20-34a0-de5cdd615b6b@huawei.com>
 <20171028074245.GA15510@lst.de>
From: Guan Junxiong <guanjunxiong@huawei.com>
Message-ID: <99f3c781-71ce-f915-d6f4-88d6dd115876@huawei.com>
Date: Sat, 28 Oct 2017 18:09:46 +0800
MIME-Version: 1.0
In-Reply-To: <20171028074245.GA15510@lst.de>
Content-Type: text/plain; charset="utf-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org



On 2017/10/28 15:42, Christoph Hellwig wrote:
> On Sat, Oct 28, 2017 at 03:20:07PM +0800, Guan Junxiong wrote:
>> Think of some current advanced features of DM-Multipath combined with multipath-tools
>> such as path-latency priority grouping, intermittent IO error accounting for path
>> degradation, delayed or immediate or follow-over failback feature.
>> Those features, which is significant in some scenario, need to use per-controller block devices.
>> Therefore, I think it is worthy adding a CONFIG_NVME_MULTIPATHING knob to
>> hide or show per-controller block devices.
>>
>> How about let me to add this this CONFIG_NVME_MULTIPATHING knob?
> 
> There is defintively not going to be a run-time nob, sorry.  You've
> spent this work on dm-multipath after the nvme group pretty clearly
> said that this is not what we are going to support, and we have not
> interest in supporting this.  Especially as proper path discovery,
> asymetic namespaces states and similar can only be supported properly
> with the in-kernel code.
> 
Does it mean some extra works such as:
1) showing the path topology of nvme multipath device
2) daemon to implement immediate and delayed failback
3) detecting sub-healthy path due to shaky link
4) grouping paths besides ANA
...
and so on,
need to integrate into the user-space tool such as nvme-cli
or a new invented user-space tool named "nvme-mpath" ?
Which do you prefer?

And the kernel also needs to export more setting and getting methods.

Regards
Guan
.
