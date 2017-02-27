Return-Path: <linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org>
Date: Mon, 27 Feb 2017 14:15:00 -0500
From: Keith Busch <keith.busch@intel.com>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCHv2 2/2] nvme: Complete all stuck requests
Message-ID: <20170227191459.GA1170@localhost.localdomain>
References: <1487896561-10454-1-git-send-email-keith.busch@intel.com>
 <1487896561-10454-2-git-send-email-keith.busch@intel.com>
 <b66a614e-140e-86e9-56bf-d3eafb750aa5@grimberg.me>
 <20170227150107.GA5789@localhost.localdomain>
 <4c952c67-9871-249d-86b0-5f81acf00571@grimberg.me>
MIME-Version: 1.0
In-Reply-To: <4c952c67-9871-249d-86b0-5f81acf00571@grimberg.me>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@fb.com>,
 Marc MERLIN <marc@merlins.org>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org
List-ID: <linux-block@vger.kernel.org>

On Mon, Feb 27, 2017 at 07:27:51PM +0200, Sagi Grimberg wrote:
> OK, I think we can get it for fabrics too, need to figure out how to
> handle it there too.
> 
> Do you have a reproducer?

To repro, I have to run a buffered writer workload then put the system into S3.

This fio job seems to reproduce for me:

  fio --name=global --filename=/dev/nvme0n1 --bsrange=4k-128k --rw=randwrite --ioengine=libaio --iodepth=8 --numjobs=8 --name=foobar

I use rtcwake to test suspend/resume:

  rtcwake -m mem -s 10

Without the patch we'll get stuck after "Disabling non-boot CPUs ..."
when blk-mq waits to freeze some entered queues after nvme was disabled.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
