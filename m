Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "hch@lst.de" <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"konrad.wilk@oracle.com" <konrad.wilk@oracle.com>, "roger.pau@citrix.com"
	<roger.pau@citrix.com>, "linux-scsi@vger.kernel.org"
	<linux-scsi@vger.kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "jbacik@fb.com" <jbacik@fb.com>,
	"james.smart@broadcom.com" <james.smart@broadcom.com>, "dm-devel@redhat.com"
	<dm-devel@redhat.com>
Subject: Re: [PATCH 01/25] remove the mg_disk driver
Date: Thu, 13 Apr 2017 19:58:13 +0000
Message-ID: <1492113491.24345.7.camel@sandisk.com>
References: <20170406153944.10058-1-hch@lst.de>
	 <20170406153944.10058-2-hch@lst.de>
In-Reply-To: <20170406153944.10058-2-hch@lst.de>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Thu, 2017-04-06 at 17:39 +0200, Christoph Hellwig wrote:
> This drivers was added in 2008, but as far as a I can tell we never had a
> single platform that actually registered resources for the platform drive=
r.
>=20
> It's also been unmaintained for a long time and apparently has a ATA mode
> that can be driven using the IDE/libata subsystem.

Hello Christoph,

Should the person who submitted this driver be CC-ed for this patch (unsik
Kim <donari75@gmail.com>)?

Bart.=
