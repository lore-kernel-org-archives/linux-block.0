Return-Path: <linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org>
Date: Thu, 17 Nov 2016 07:22:15 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Scott Bauer <scott.bauer@intel.com>
Subject: Re: [PATCH v1 1/7] Include: Add definitions for sed
Message-ID: <20161117152215.GA20335@infradead.org>
References: <1479338252-8777-1-git-send-email-scott.bauer@intel.com>
 <1479338252-8777-2-git-send-email-scott.bauer@intel.com>
MIME-Version: 1.0
In-Reply-To: <1479338252-8777-2-git-send-email-scott.bauer@intel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: hch@infradead.org, sagi@grimberg.me, axboe@fb.com,
 linux-nvme@lists.infradead.org, keith.busch@intel.com,
 Rafael.Antognolli@intel.com, linux-block@vger.kernel.org,
 jonathan.derrick@intel.com, j.naumann@fu-berlin.de
Content-Type: text/plain; charset="iso-8859-1"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org
List-ID: <linux-block@vger.kernel.org>

> @@ -0,0 +1,58 @@
> +/*
> + * Copyright =A9 2016 Intel Corporation
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a
> + * copy of this software and associated documentation files (the "Softwa=
re"),
> + * to deal in the Software without restriction, including without limita=
tion
> + * the rights to use, copy, modify, merge, publish, distribute, sublicen=
se,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice (including the =
next
> + * paragraph) shall be included in all copies or substantial portions of=
 the
> + * Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SH=
ALL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR =
OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISI=
NG
> + * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER D=
EALINGS

Can we get a proper GPLv2/GPLv2 license for this from the Intel
layers?  While the license grant looks fine from a quick look I'd really
prefer to have an official statement that this should be compatible
with the kernel licensing.

> +#define LINUX_OPAL_H
> +
> +#include <linux/sed.h>
> +#include <linux/kernel.h>
> +
> +enum {
> +	TCG_SECP_00 =3D 0,
> +	TCG_SECP_01,
> +};

These are the SPC4 security protocol defintions, aren't they?
Can you please add a separate include/scsi/sec_protocol.h header that
defines just these and documents where they come from?

Similarly for all the other constants it would be nice to refer to
the spec they are from in the header.

> +struct sec_ops {
> +	int (*send)(void *data, __u16 SPSP, __u8 SECP,
> +			void *buffer, size_t len,
> +			sec_cb *cb, void *cb_data);
> +	int (*recv)(void *data, __u16 SPSP, __u8 SECP,
> +			void *buffer, size_t len,
> +			sec_cb *cb, void *cb_data);

please use lower case names for all arguments and variables.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
