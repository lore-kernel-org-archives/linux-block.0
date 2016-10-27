Return-Path: <linux-scsi-owner@vger.kernel.org>
Date: Thu, 27 Oct 2016 08:41:15 +0200
From: Christoph Hellwig <hch@lst.de>
To: =?utf-8?B?6ZGr5oS/?= <qiuxincsu@sina.com>
Cc: Bart Van Assche <bart.vanassche@sandisk.com>,
        Jens Axboe <axboe@fb.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        James Bottomley <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Mike Snitzer <snitzer@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Ming Lei <tom.leiming@gmail.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Keith Busch <keith.busch@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        Laurence Oberman <loberman@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        "tiger.zhao" <tiger.zhao@huawei.com>, qiuxin <qiuxin@huawei.com>
Subject: Re: A question regarding "multiple SGL"
Message-ID: <20161027064115.GA5864@lst.de>
References: <20161027005230.9904DC00097@webmail.sinamail.sina.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161027005230.9904DC00097@webmail.sinamail.sina.com.cn>
Sender: linux-scsi-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

Hi Robert,

There is no feature called "Multiple SGL in one NVMe capsule".  The
NVMe over Fabrics specification allows a controller to advertise how
many SGL descriptors it supports using the MSDBD Identify field:

"Maximum SGL Data Block Descriptors (MSDBD): This field indicates the
maximum number of (Keyed) SGL Data Block descriptors that a host is allowed to
place in a capsule. A value of 0h indicates no limit."

Setting this value to 1 is perfectly valid.  Similarly a host is free
to chose any number of SGL descriptors between 0 (only for command that
don't transfer data) to the limit imposed by the controller using the
MSDBD field.

There are no plans to support a MSDBD value larger than 1 in the Linux
NVMe target, and there are no plans to ever submit commands with multiple
SGLs from the host driver either.

Cheers,
	Christoph
