Return-Path: <elliott@hpe.com>
From: "Elliott, Robert (Persistent Memory)" <elliott@hpe.com>
To: "markus@trippelsdorf.de" <markus@trippelsdorf.de>, Bart Van Assche
	<Bart.VanAssche@sandisk.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: RE: [PATCH] block: Remove leading whitespace and trailing newline in
 elevator switch error message
Date: Tue, 9 May 2017 02:18:01 +0000
Message-ID: <TU4PR84MB03040339EFF3AB676CBD1382ABEF0@TU4PR84MB0304.NAMPRD84.PROD.OUTLOOK.COM>
References: <20170506052243.GB291@x4>
In-Reply-To: <20170506052243.GB291@x4>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>



> -----Original Message-----
> From: linux-block-owner@vger.kernel.org [mailto:linux-block-
> owner@vger.kernel.org] On Behalf Of markus@trippelsdorf.de
> Sent: Saturday, May 06, 2017 12:23 AM
> To: Bart Van Assche <Bart.VanAssche@sandisk.com>
> Cc: linux-block@vger.kernel.org; axboe@kernel.dk
> Subject: [PATCH] block: Remove leading whitespace and trailing
> newline in elevator switch error message
>=20
>=20
> Trying to switch to a non-existing elevator currently results in
> garbled
> dmesg output, e.g.:
>=20
>  # echo "  foo" > /sys/block/sda/queue/scheduler
>=20
> elevator: type   foo not found
> elevator: switch to   foo
>  failed
...
> @@ -1063,15 +1062,14 @@ static int __elevator_change(struct
> request_queue *q, const char *name)
>  	if (q->mq_ops && !strncmp(name, "none", 4))
>  		return elevator_switch(q, NULL);
>=20
> -	strlcpy(elevator_name, name, sizeof(elevator_name));
> -	e =3D elevator_get(strstrip(elevator_name), true);
> +	e =3D elevator_get(name, true);
>  	if (!e) {
> -		printk(KERN_ERR "elevator: type %s not found\n",
> elevator_name);
> +		printk(KERN_ERR "elevator: type %s not found\n", name);
>  		return -EINVAL;
>  	}
...
> @@ -1112,16 +1110,19 @@ static inline bool elv_support_iosched(struct
> request_queue *q)
>  ssize_t elv_iosched_store(struct request_queue *q, const char *name,
>  			  size_t count)
>  {
...
> +	strlcpy(elevator_name, skip_spaces(name),
> sizeof(elevator_name));
> +	strstrip(elevator_name);
> +	ret =3D __elevator_change(q, elevator_name);
>  	if (!ret)
>  		return count;
>=20
> -	printk(KERN_ERR "elevator: switch to %s failed\n", name);
> +	printk(KERN_ERR "elevator: switch to %s failed\n",
> elevator_name);
>  	return ret;
>  }

That leaves two lines of error prints for a single error, and
the second line doesn't convey additional information.
