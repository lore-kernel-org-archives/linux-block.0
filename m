Return-Path: <Bart.VanAssche@sandisk.com>
Subject: Re: NVMe over Fabrics target implementation
To: Christoph Hellwig <hch@lst.de>
References: <1465248177-17970-1-git-send-email-hch@lst.de>
 <6abd6fd0-3a75-8569-95a4-174d856d0043@sandisk.com>
 <20160607173105.GA13935@lst.de>
CC: "axboe@kernel.dk" <axboe@kernel.dk>, "keith.busch@intel.com"
	<keith.busch@intel.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
From: Bart Van Assche <bart.vanassche@sandisk.com>
Message-ID: <abd1bf65-dc98-7119-b6ff-97bb939e0780@sandisk.com>
Date: Tue, 7 Jun 2016 11:11:28 -0700
MIME-Version: 1.0
In-Reply-To: <20160607173105.GA13935@lst.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

On 06/07/2016 10:31 AM, Christoph Hellwig wrote:
> Of course you can, and every user of configfs relies on being able
> to create directories from the kernel using either the default_groups
> list, or through the use of configfs_register_group().

Apparently configfs_register_group() has been added last year (Nov 2015; 
commit 5cf6a51e6062)? This is interesting and I think this functionality 
would also useful for LIO target drivers, e.g. ib_srpt and tcm_qla2xxx.

Bart.
