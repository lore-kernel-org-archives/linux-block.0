Return-Path: <linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org>
Date: Thu, 17 Nov 2016 09:10:02 -0700
From: Scott Bauer <scott.bauer@intel.com>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v1 1/7] Include: Add definitions for sed
Message-ID: <20161117161001.GA13836@sbauer-Z170X-UD5>
References: <1479338252-8777-1-git-send-email-scott.bauer@intel.com>
 <1479338252-8777-2-git-send-email-scott.bauer@intel.com>
 <20161117152215.GA20335@infradead.org>
MIME-Version: 1.0
In-Reply-To: <20161117152215.GA20335@infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: linux-block@vger.kernel.org, sagi@grimberg.me, Rafael.Antognolli@intel.com,
 axboe@fb.com, linux-nvme@lists.infradead.org, keith.busch@intel.com,
 jonathan.derrick@intel.com, j.naumann@fu-berlin.de
Content-Type: text/plain; charset="iso-8859-1"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org
List-ID: <linux-block@vger.kernel.org>

On Thu, Nov 17, 2016 at 07:22:15AM -0800, Christoph Hellwig wrote:
> > @@ -0,0 +1,58 @@
> > +/*
> > + * Copyright =A9 2016 Intel Corporation
> > + *
> > + * Permission is hereby granted, free of charge, to any person obtaini=
ng a
> > + * copy of this software and associated documentation files (the "Soft=
ware"),
> > + * to deal in the Software without restriction, including without limi=
tation
> > + * the rights to use, copy, modify, merge, publish, distribute, sublic=
ense,
> > + * and/or sell copies of the Software, and to permit persons to whom t=
he
> > + * Software is furnished to do so, subject to the following conditions:
> > + *
> > + * The above copyright notice and this permission notice (including th=
e next
> > + * paragraph) shall be included in all copies or substantial portions =
of the
> > + * Software.
> > + *
> > + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXP=
RESS OR
> > + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABI=
LITY,
> > + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT =
SHALL
> > + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES O=
R OTHER
> > + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARI=
SING
> > + * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER=
 DEALINGS
> =

> Can we get a proper GPLv2/GPLv2 license for this from the Intel
> layers?  While the license grant looks fine from a quick look I'd really
> prefer to have an official statement that this should be compatible
> with the kernel licensing.
> =

Sure, I will send them some mail to see if we can change them to something =
else.


> > +#define LINUX_OPAL_H
> > +
> > +#include <linux/sed.h>
> > +#include <linux/kernel.h>
> > +
> > +enum {
> > +	TCG_SECP_00 =3D 0,
> > +	TCG_SECP_01,
> > +};
> =

> These are the SPC4 security protocol defintions, aren't they?
> Can you please add a separate include/scsi/sec_protocol.h header that
> defines just these and documents where they come from?
> =

> Similarly for all the other constants it would be nice to refer to
> the spec they are from in the header.
 =

Sure I can specify what spec/location they're pulled from.

> > +struct sec_ops {
> > +	int (*send)(void *data, __u16 SPSP, __u8 SECP,
> > +			void *buffer, size_t len,
> > +			sec_cb *cb, void *cb_data);
> > +	int (*recv)(void *data, __u16 SPSP, __u8 SECP,
> > +			void *buffer, size_t len,
> > +			sec_cb *cb, void *cb_data);
> =

> please use lower case names for all arguments and variables.
I think we chose the uppercase because that's how it was in the specificati=
on,
none the less we'll swap them up.


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
