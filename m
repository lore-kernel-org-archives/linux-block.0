Return-Path: <keith.busch@linux.intel.com>
Date: Tue, 8 May 2018 09:09:33 -0600
From: Keith Busch <keith.busch@linux.intel.com>
To: Laurence Oberman <loberman@redhat.com>
Cc: Ming Lei <ming.lei@redhat.com>, Keith Busch <keith.busch@intel.com>,
	Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	Jianchao Wang <jianchao.w.wang@oracle.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V4 0/7] nvme: pci: fix & improve timeout handling
Message-ID: <20180508150933.GA30736@localhost.localdomain>
References: <20180505135905.18815-1-ming.lei@redhat.com>
 <1525561893.3082.1.camel@redhat.com>
 <1525563110.4007.1.camel@redhat.com>
 <1525564282.4007.3.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1525564282.4007.3.camel@redhat.com>
List-ID: <linux-block@vger.kernel.org>

On Sat, May 05, 2018 at 07:51:22PM -0400, Laurence Oberman wrote:
> 3rd and 4th attempts slightly better, but clearly not dependable
> 
> [root@segstorage1 blktests]# ./check block/011
> block/011 => nvme0n1 (disable PCI device while doing I/O)����[failed]
> ����runtime����...��81.188s
> ����--- tests/block/011.out	2018-05-05 18:01:14.268414752 -0400
> ����+++ results/nvme0n1/block/011.out.bad	2018-05-05
> 19:44:48.848568687 -0400
> ����@@ -1,2 +1,3 @@
> �����Running block/011
> ����+tests/block/011: line 47: echo: write error: Input/output error
> �����Test complete
> 
> This one passed 
> [root@segstorage1 blktests]# ./check block/011
> block/011 => nvme0n1 (disable PCI device while doing I/O)����[passed]
> ����runtime��81.188s��...��43.400s
> 
> I will capture a vmcore next time it panics and give some information
> after analyzing the core

We definitely should never panic, but I am not sure this blktest can be
reliable on IO errors: the test is disabling memory space enabling and
bus master without the driver's knowledge, and it does this repeatedly
in a tight loop. If the test happens to disable the device while the
driver is trying to recover from the previous iteration, the recovery
will surely fail, so I think IO errors may possibly be expected.

As far as I can tell, the only way you'll actually get it to succeed is
if the test's subsequent "enable" happen's to hit in conjuction with the
driver's reset pci_enable_device_mem(), such that the pci_dev's enable_cnt
is > 1, which prevents the disabling for the remainder of the test's
looping.

I still think this is a very good test, but we might be able to make it
more deterministic on what actually happens to the pci device.
