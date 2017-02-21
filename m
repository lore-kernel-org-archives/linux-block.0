Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "Christoph
 Hellwig" <hch@infradead.org>, Dan Williams <dan.j.williams@intel.com>, Thiago
 Jung Bauermann <bauerman@linux.vnet.ibm.com>, Lekshmi Pillai
	<lekshmicpillai@in.ibm.com>, Tejun Heo <tj@kernel.org>, NeilBrown
	<neilb@suse.de>, Omar Sandoval <osandov@osandov.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
Subject: Re: [PATCH 12/13] kobject: Export kobject_get_unless_zero()
Date: Tue, 21 Feb 2017 19:39:39 +0000
Message-ID: <1D08B61A9CF0974AA09887BE32D889DA0AC6D7@ULS-OP-MBXIP03.sdcorp.global.sandisk.com>
References: <20170221170958.21845-1-jack@suse.cz>
 <20170221170958.21845-13-jack@suse.cz>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

On 02/21/2017 09:55 AM, Jan Kara wrote:=0A=
> Make the function available for outside use and fortify it against NULL=
=0A=
> kobject.=0A=
=0A=
Reviewed-by: Bart Van Assche <bart.vanassche@sandisk.com>=0A=
=0A=
