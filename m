Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: Jan Kara <jack@suse.cz>
CC: Jens Axboe <axboe@kernel.dk>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>, "Dan
 Williams" <dan.j.williams@intel.com>, Thiago Jung Bauermann
	<bauerman@linux.vnet.ibm.com>, Lekshmi Pillai <lekshmicpillai@in.ibm.com>,
	Tejun Heo <tj@kernel.org>, NeilBrown <neilb@suse.de>, Omar Sandoval
	<osandov@osandov.com>
Subject: Re: [PATCH 04/13] block: Move bdi_unregister() to del_gendisk()
Date: Wed, 22 Feb 2017 17:42:49 +0000
Message-ID: <1D08B61A9CF0974AA09887BE32D889DA0AD839@ULS-OP-MBXIP03.sdcorp.global.sandisk.com>
References: <20170221170958.21845-1-jack@suse.cz>
 <20170221170958.21845-5-jack@suse.cz>
 <1D08B61A9CF0974AA09887BE32D889DA0AC71A@ULS-OP-MBXIP03.sdcorp.global.sandisk.com>
 <20170222085107.GA23312@quack2.suse.cz>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

On 02/22/2017 01:20 AM, Jan Kara wrote:=0A=
> On Tue 21-02-17 19:53:29, Bart Van Assche wrote:=0A=
>> This change looks suspicious to me. There are drivers that create a=0A=
>> block layer queue but neither call device_add_disk() nor del_gendisk(),=
=0A=
>> e.g. drivers/scsi/st.c. Although bdi_init() will be called for the=0A=
>> queues created by these drivers, this patch will cause the=0A=
>> bdi_unregister() call to be skipped for these drivers.=0A=
> =0A=
> Well, the thing is that bdi_unregister() is the counterpart to=0A=
> bdi_register(). Unless you call bdi_register(), which happens only in=0A=
> device_add_disk() (and some filesystems which create their private bdis),=
=0A=
> there's no point in calling bdi_unregister(). Counterpart to bdi_init() i=
s=0A=
> bdi_exit() and that gets called always once bdi reference count drops to =
0.=0A=
=0A=
That makes sense to me. Hence:=0A=
=0A=
Reviewed-by: Bart Van Assche <bart.vanassche@sandisk.com>=0A=
=0A=
