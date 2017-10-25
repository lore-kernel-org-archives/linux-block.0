Return-Path: <hch@lst.de>
Date: Wed, 25 Oct 2017 21:37:52 +0200
From: "hch@lst.de" <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Bart Van Assche <Bart.VanAssche@wdc.com>, "hch@lst.de" <hch@lst.de>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"mst@redhat.com" <mst@redhat.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"dann.frazier@canonical.com" <dann.frazier@canonical.com>
Subject: Re: [PATCH v2] virtio_blk: Fix an SG_IO regression
Message-ID: <20171025193752.GA6164@lst.de>
References: <20171025095617.7315-1-bart.vanassche@wdc.com> <11a35a46-dc51-c32f-cb64-793d9dd02c53@kernel.dk> <1508959556.5073.1.camel@wdc.com> <83926138-e6aa-6792-5275-31f5c1330c90@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <83926138-e6aa-6792-5275-31f5c1330c90@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

Honestly I think the right fix is to just kill the SCSI passthrough
in virtio.  It has been replaced by virtio-scsi a long time ago, and
has been disabled by default in qemu for a long time (and I don't think
any other hypervisor ever supported it).

It should never have been added (saying that as the person who added it).
