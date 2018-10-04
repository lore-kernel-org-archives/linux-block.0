Return-Path: <axboe@kernel.dk>
Subject: Re: Why BFQ scheduler available only for NVMe device?
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
 linux-block@vger.kernel.org
References: <CABXGCsOyE2PJMem6TQVC0jpZ-2Zfgzkghwo74B66A4Mntrdoxg@mail.gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <29ab009a-ca9d-13ea-4a87-afd641e489dd@kernel.dk>
Date: Thu, 4 Oct 2018 10:26:07 -0600
MIME-Version: 1.0
In-Reply-To: <CABXGCsOyE2PJMem6TQVC0jpZ-2Zfgzkghwo74B66A4Mntrdoxg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/4/18 10:15 AM, Mikhail Gavrilov wrote:
> Sorry I don't finded answer on my question.
> Why BFQ scheduler available only for NVMe device?
> 
> $ find /sys -name scheduler -exec grep . {} +
> find: ‘/sys/kernel/debug’: Permission denied
> find: ‘/sys/fs/pstore’: Permission denied
> find: ‘/sys/fs/bpf’: Permission denied
> /sys/devices/pci0000:00/0000:00:01.3/0000:02:00.1/ata5/host4/target4:0:0/4:0:0:0/block/sda/queue/scheduler:noop
> deadline [cfq]
> /sys/devices/pci0000:00/0000:00:01.1/0000:01:00.0/nvme/nvme0/nvme0n1/queue/scheduler:[none]
> mq-deadline bfq
> /sys/devices/pci0000:00/0000:00:07.1/0000:0c:00.3/usb4/4-3/4-3.4/4-3.4.1/4-3.4.1:1.0/host9/target9:0:0/9:0:0:0/block/sdb/queue/scheduler:noop
> deadline [cfq]

It isn't, but it's only available for MQ devices. For SCSI, you want to
set:

CONFIG_SCSI_MQ_DEFAULT=y                                                        

and if that isn't feasible due to running a distro build, then you want
to add scsi_mod.use_blk_mq=1 to your boot parameters.

-- 
Jens Axboe
