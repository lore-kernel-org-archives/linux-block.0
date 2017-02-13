Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "tj@kernel.org" <tj@kernel.org>, "paolo.valente@linaro.org"
	<paolo.valente@linaro.org>, "axboe@kernel.dk" <axboe@kernel.dk>
CC: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"broonie@kernel.org" <broonie@kernel.org>, "linus.walleij@linaro.org"
	<linus.walleij@linaro.org>
Subject: Re: [PATCH BUGFIX] block: make elevator_get robust against cross
 blk/blk-mq choice
Date: Mon, 13 Feb 2017 21:12:59 +0000
Message-ID: <1487020366.2719.5.camel@sandisk.com>
References: <20170213210107.4848-1-paolo.valente@linaro.org>
	 <20170213210107.4848-2-paolo.valente@linaro.org>
In-Reply-To: <20170213210107.4848-2-paolo.valente@linaro.org>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Mon, 2017-02-13 at 22:01 +0100, Paolo Valente wrote:
> -static struct elevator_type *elevator_get(const char *name, bool try_loa=
ding)
> +static struct elevator_type *elevator_get(const char *name, bool try_loa=
ding,
> +					  bool mq_ops)

Please choose a better name for that argument, e.q. "mq". To me the name "m=
q_ops"
means "a pointer to a data structure with operation function pointers".

> +	if (e && (e->uses_mq !=3D mq_ops)) {
> +		pr_err("ERROR: attempted to choose %s %s I/O scheduler in blk%s",
> +		       name, e->uses_mq ? "blk-mq" : "legacy", mq_ops ? "-mq" : "");
> +		e =3D NULL;
> +	}

How about changing the above into:

+=A0=A0=A0=A0=A0=A0=A0if (e && e->uses_mq !=3D mq) {
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0pr_err("ERROR: attempt to con=
figure %s as I/O scheduler for a %s queue\n",
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0name, mq=
 ? "blk-mq" : "legacy");
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0e =3D NULL;
+=A0=A0=A0=A0=A0=A0=A0}

Thanks,

Bart.
Western Digital Corporation (and its subsidiaries) E-mail Confidentiality N=
otice & Disclaimer:

This e-mail and any files transmitted with it may contain confidential or l=
egally privileged information of WDC and/or its affiliates, and are intende=
d solely for the use of the individual or entity to which they are addresse=
d. If you are not the intended recipient, any disclosure, copying, distribu=
tion or any action taken or omitted to be taken in reliance on it, is prohi=
bited. If you have received this e-mail in error, please notify the sender =
immediately and delete the e-mail in its entirety from your system.
