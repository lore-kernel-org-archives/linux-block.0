Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "hch@lst.de"
	<hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"osandov@osandov.com" <osandov@osandov.com>,
	"James.Bottomley@hansenpartnership.com"
	<James.Bottomley@hansenpartnership.com>, "osandov@fb.com" <osandov@fb.com>,
	"jack@suse.cz" <jack@suse.cz>
Subject: Re: [PATCH v3] scsi, block: fix duplicate bdi name registration
 crashes
Date: Wed, 1 Feb 2017 22:23:34 +0000
Message-ID: <1485987801.2560.15.camel@sandisk.com>
References: <148598661794.11527.10024529085859239448.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <148598661794.11527.10024529085859239448.stgit@dwillia2-desk3.amr.corp.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

On Wed, 2017-02-01 at 14:05 -0800, Dan Williams wrote:
> Warnings of the following form occur because scsi reuses a devt number
> while the block layer still has it referenced as the name of the bdi

Thanks!

Reviewed-by: Bart Van Assche <bart.vanassche@sandisk.com>=
