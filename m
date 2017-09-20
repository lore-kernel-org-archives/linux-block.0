Return-Path: <jthumshirn@suse.de>
Date: Wed, 20 Sep 2017 13:09:59 +0200
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: Re: nvme multipath support V2
Message-ID: <20170920110959.hwvujtis6ywnbb5p@linux-x5ow.site>
References: <20170918231453.27128-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20170918231453.27128-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Hi Christoph,

I wanted to test your patches, but I fail to see how I have to set it up.

I do have a host with two RDMA HCAs connected to the target (Linux), for "normal
dm-mpath" test I do nvme connect with the host traddr argument for both of the
HCAs and get two nvme block devices which I can add to multipath.

Using your patchset and doing the sanme double connect trick I get the same
two block devices of cause.

How do I connect using both paths?

Thanks,
	Johannes
-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: Felix Imend�rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N�rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
