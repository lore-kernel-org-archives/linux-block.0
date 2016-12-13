Return-Path: <linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org>
To: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
From: Coly Li <i@coly.li>
Subject: extend bi_size to unsigned long ?
Message-ID: <82fdc4e9-3573-f5a5-6d27-34ea49d5f047@coly.li>
Date: Tue, 13 Dec 2016 22:53:32 +0800
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org
List-ID: <linux-block@vger.kernel.org>

Hi linux-block and linux-nvme lists,

Recently when I work on md-raid0 DISCARD optimization, I found the
maximum DISCARD bio length that raid0_make_request() receives is 8388608
sectors. I find it is because of the limitation of bi_size, which is
unsigned int and 32 bits length.

A 32 bits bi_size means a DISCARD bio can only cover UINT_MAX>>9
sectors, see commit a22c4d7e3440 ("block: re-add discard_granularity and
alignment checks"). To format a xfs volume on 4x4TB NVMe SSDs, the
original DISCARD bio has to be split for 4x1024 times. If bi_size is a
64 bits unsigned long, in ideal condition the original DISCARD bio can
only be split for 4 times, that is one split bio for each device.

Now days it won't be a big issue since block layer may merge the split
bios (or may not if its block-mq and NVMe). When the underlying device
becomes larger and larger, maybe a 32 bits bi_size will hurt DISCARD
performance.

I know this is not simple, it changes a very important KABI. But this is
really an interesting question to ask: do we have any idea to extend
bi_size from unsigned int to unsigned long ?

Thanks in advance.

-- 
Coly Li

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
