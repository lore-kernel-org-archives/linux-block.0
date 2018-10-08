Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH V2] blk-mq: complete req in softirq context in case of
 single queue
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, Dongli Zhang <dongli.zhang@oracle.com>,
 Zach Marano <zmarano@google.com>, Christoph Hellwig <hch@lst.de>,
 Bart Van Assche <bvanassche@acm.org>,
 Jianchao Wang <jianchao.w.wang@oracle.com>
References: <20180928084220.32026-1-ming.lei@redhat.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <d72826db-1ce5-dde6-8940-24878f3ef9c1@kernel.dk>
Date: Mon, 8 Oct 2018 10:49:01 -0600
MIME-Version: 1.0
In-Reply-To: <20180928084220.32026-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 9/28/18 2:42 AM, Ming Lei wrote:
> Lot of controllers may have only one irq vector for completing IO
> request. And usually affinity of the only irq vector is all possible
> CPUs, however, on most of ARCH, there may be only one specific CPU
> for handling this interrupt.
> 
> So if all IOs are completed in hardirq context, it is inevitable to
> degrade IO performance because of increased irq latency.
> 
> This patch tries to address this issue by allowing to complete request
> in softirq context, like the legacy IO path.
> 
> IOPS is observed as ~13%+ in the following randread test on raid0 over
> virtio-scsi.
> 
> mdadm --create --verbose /dev/md0 --level=0 --chunk=1024 --raid-devices=8 /dev/sdb /dev/sdc /dev/sdd /dev/sde /dev/sdf /dev/sdg /dev/sdh /dev/sdi
> 
> fio --time_based --name=benchmark --runtime=30 --filename=/dev/md0 --nrfiles=1 --ioengine=libaio --iodepth=32 --direct=1 --invalidate=1 --verify=0 --verify_fatal=0 --numjobs=32 --rw=randread --blocksize=4k

Looks fine to me, and imho it makes a lot of sense to apply the same
logic for remote completions to single queue as we did for the legacy
parts. I have applied it for 4.20.

-- 
Jens Axboe
