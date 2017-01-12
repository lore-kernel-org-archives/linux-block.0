Return-Path: <linux-scsi-owner@vger.kernel.org>
Subject: Re: [Lsf-pc] [LSF/MM TOPIC][LSF/MM ATTEND] NAPI polling for block
 drivers
To: Johannes Thumshirn <jthumshirn@suse.de>
References: <20170111134312.GH6286@linux-x5ow.site>
 <cc00cc1f-17d7-105e-ef2c-61791b7cc676@kernel.dk>
 <d60d4499-6ed8-0a69-edbf-db205a6dba6a@kernel.dk>
 <8b47ca34-d2ff-26dc-721e-2cb1e18f1efc@grimberg.me>
 <20170112100251.GB3598@linux-x5ow.site>
 <879a91ba-eff7-682d-12a9-5d83f26e7e09@grimberg.me>
 <20170112125338.GH3598@linux-x5ow.site>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>,
        Linux-scsi@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        "lsf-pc@lists.linux-foundation.org"
        <lsf-pc@lists.linux-foundation.org>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <91262998-8dd7-107a-06e7-6f333df59a91@grimberg.me>
Date: Thu, 12 Jan 2017 16:41:00 +0200
MIME-Version: 1.0
In-Reply-To: <20170112125338.GH3598@linux-x5ow.site>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-scsi-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>


>> **Note: when I ran multiple threads on more cpus the performance
>> degradation phenomenon disappeared, but I tested on a VM with
>> qemu emulation backed by null_blk so I figured I had some other
>> bottleneck somewhere (that's why I asked for some more testing).
>
> That could be because of the vmexits as every MMIO access in the guest
> triggers a vmexit and if you poll with a low budget you do more MMIOs hence
> you have more vmexits.
>
> Did you do testing only in qemu or with real H/W as well?

I tried once. IIRC, I saw the same phenomenons...
