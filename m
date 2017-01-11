Return-Path: <linux-scsi-owner@vger.kernel.org>
Date: Wed, 11 Jan 2017 17:14:10 +0100
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Bart Van Assche <Bart.VanAssche@sandisk.com>
Cc: "lsf-pc@lists.linux-foundation.org"
        <lsf-pc@lists.linux-foundation.org>,
        "Linux-scsi@vger.kernel.org" <Linux-scsi@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "keith.busch@intel.com" <keith.busch@intel.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [LSF/MM TOPIC][LSF/MM ATTEND] NAPI polling for block drivers
Message-ID: <20170111161410.GI6286@linux-x5ow.site>
References: <20170111134312.GH6286@linux-x5ow.site>
 <1484150893.2619.1.camel@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1484150893.2619.1.camel@sandisk.com>
Sender: linux-scsi-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

On Wed, Jan 11, 2017 at 04:08:31PM +0000, Bart Van Assche wrote:

[...]

> A typical Ethernet network adapter delays the generation of an interrupt
> after it has received a packet. A typical block device or HBA does not delay
> the generation of an interrupt that reports an I/O completion. I think that
> is why polling is more effective for network adapters than for block
> devices. I'm not sure whether it is possible to achieve benefits similar to
> NAPI for block devices without implementing interrupt coalescing in the
> block device firmware. Note: for block device implementations that use the
> RDMA API, the RDMA API supports interrupt coalescing (see also
> ib_modify_cq()).

Well you can always turn off IRQ generation in the HBA just before scheuduling
the poll handler and re-enable it after you've exhausted your budget or used
too much time, can't you? 

I'll do some prototyping and tests tomorrow so we have some more ground for
discussion.

Byte,
	Johannes
-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: Felix Imend�rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N�rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
