Return-Path: <Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "hare@suse.de" <hare@suse.de>, "axboe@kernel.dk" <axboe@kernel.dk>
CC: "hch@lst.de" <hch@lst.de>, Bart Van Assche <Bart.VanAssche@wdc.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "hare@suse.com"
	<hare@suse.com>, "osandov@fb.com" <osandov@fb.com>, "nab@linux-iscsi.org"
	<nab@linux-iscsi.org>
Subject: Re: [PATCH v4 04/12] block: Make most scsi_req_init() calls implicit
Date: Tue, 20 Jun 2017 17:39:36 +0000
Message-ID: <1497980374.13905.15.camel@wdc.com>
References: <20170619220801.12557-1-bart.vanassche@wdc.com>
	 <20170619220801.12557-5-bart.vanassche@wdc.com>
	 <e94ddf21-5f7f-ea45-43ea-2635d9dad634@suse.de>
In-Reply-To: <e94ddf21-5f7f-ea45-43ea-2635d9dad634@suse.de>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Tue, 2017-06-20 at 08:37 +0200, Hannes Reinecke wrote:
> On 06/20/2017 12:07 AM, Bart Van Assche wrote:=20
> > +static void sas_initialize_rq(struct request *rq)
> > +{
> > +	scsi_req_init(rq);
> > +}
>=20
> Any particular reason why you didn't use scsi_initiatlize_rq() here?

Hello Hannes,

There is no particular reason why scsi_initialize_rq() is not used here but
doing so sounds like a good idea to me. I will update this patch.

Bart.=
