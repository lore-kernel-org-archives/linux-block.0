Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "osandov@osandov.com" <osandov@osandov.com>, "kashyap.desai@broadcom.com"
	<kashyap.desai@broadcom.com>, "axboe@kernel.dk" <axboe@kernel.dk>
CC: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"hch@infradead.org" <hch@infradead.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "paolo.valente@linaro.org"
	<paolo.valente@linaro.org>
Subject: Re: Device or HBA level QD throttling creates randomness in
 sequetial workload
Date: Mon, 30 Jan 2017 16:30:59 +0000
Message-ID: <1485793840.2712.1.camel@sandisk.com>
References: <2d656e9c9fbde7206e40a635c61a6084@mail.gmail.com>
	 <298b6ff6-9feb-4b70-ec4c-d1295a0e1f41@kernel.dk>
	 7a9b012d8c7c456e9ec87d1ba5866a9d@mail.gmail.com
 <e1e827ba633f780b00d070e087204d5c@mail.gmail.com>
In-Reply-To: <e1e827ba633f780b00d070e087204d5c@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

On Mon, 2017-01-30 at 19:22 +0530, Kashyap Desai wrote:
> -   if (atomic_inc_return(&instance->fw_outstanding) >
> -           instance->host->can_queue) {
> -       atomic_dec(&instance->fw_outstanding);
> -       return SCSI_MLQUEUE_HOST_BUSY;
> -   }
> +   if (atomic_inc_return(&instance->fw_outstanding) > safe_can_queue) {
> +       is_nonrot =3D blk_queue_nonrot(scmd->device->request_queue);
> +       /* For rotational device wait for sometime to get fusion command
> from pool.
> +        * This is just to reduce proactive re-queue at mid layer which i=
s
> not
> +        * sending sorted IO in SCSI.MQ mode.
> +        */
> +       if (!is_nonrot)
> +           udelay(100);
> +   }

The SCSI core does not allow to sleep inside the queuecommand() callback
function.

Bart.=
