Return-Path: <keith.busch@linux.intel.com>
Date: Thu, 10 May 2018 16:43:57 -0600
From: Keith Busch <keith.busch@linux.intel.com>
To: Ming Lei <tom.leiming@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme <linux-nvme@lists.infradead.org>,
	Ming Lei <ming.lei@redhat.com>,
	linux-block <linux-block@vger.kernel.org>,
	Jianchao Wang <jianchao.w.wang@oracle.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/2] nvme: pci: simplify timeout handling
Message-ID: <20180510224356.GE4787@localhost.localdomain>
References: <20180426123956.26039-1-ming.lei@redhat.com>
 <20180426123956.26039-2-ming.lei@redhat.com>
 <20180427175157.GB5073@localhost.localdomain>
 <20180428035015.GB5657@ming.t460p>
 <20180508153038.GA30842@localhost.localdomain>
 <CACVXFVO+CuYghN3wHyHV2cskPr2pqaKKyQqQC5Xze4vCvpb+jg@mail.gmail.com>
 <20180510210548.GB4787@localhost.localdomain>
 <CACVXFVNvsjNS0Oi15RnYQm643w-YkFZJT7eKJ+tX_qzGcnu=4A@mail.gmail.com>
 <20180510211829.GC4787@localhost.localdomain>
 <CACVXFVPcxHkuJXPGgebqJLb8wL=6svUvMwfiLhafNR_9XTi3Ew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CACVXFVPcxHkuJXPGgebqJLb8wL=6svUvMwfiLhafNR_9XTi3Ew@mail.gmail.com>
List-ID: <linux-block@vger.kernel.org>

On Fri, May 11, 2018 at 06:03:59AM +0800, Ming Lei wrote:
> Sorry, forget to mention, it isn't enough to simply sync timeout inside reset().
> 
> Another tricky thing is about freeze & unfreeze, now freeze is done in
> nvme_dev_disable(), and unfreeze is done in nvme_reset_work. That means
> we have to make sure both are paired, otherwise queues may be kept as
> freeze for ever.
> 
> This issue is covered by my V4 & V5 too.

That it isn't an issue in my patch either.
