Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "axboe@kernel.dk" <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: for-4.12/block branch
Date: Fri, 21 Apr 2017 17:05:47 +0000
Message-ID: <1492794346.2550.12.camel@sandisk.com>
References: <1492788745.2550.1.camel@sandisk.com>
	 <f6e71f2a-ad0b-c884-1e16-a2062c70b6cf@fb.com>
	 <1492792278.2550.5.camel@sandisk.com>
	 <b248fae1-c51f-be03-d27c-a9730b65132a@fb.com>
	 <1492792852.2550.7.camel@sandisk.com>
	 <5e5870a4-bbff-8486-f28c-49127a9c60a5@fb.com>
	 <fae5b2be-b18e-cb1c-675e-79869f678c7e@kernel.dk>
In-Reply-To: <fae5b2be-b18e-cb1c-675e-79869f678c7e@kernel.dk>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Fri, 2017-04-21 at 10:56 -0600, Jens Axboe wrote:
> On 04/21/2017 10:48 AM, Jens Axboe wrote:
> > I wonder if it's an imbalance in the preempt count. Looking at it, it
> > looks like we're not clearing the alloc data. But I would think that
> > would potentially cause much worse problems, but maybe we got lucky?
> >=20
> > Let me generate a cleanup patch for that.
>=20
> Something like the below.
> [ ... ]
> +static inline void blk_mq_init_alloc_data(struct blk_mq_alloc_data *data=
,
> +					  unsigned int flags)
> +{
> +	data->q =3D NULL;
> +	data->flags =3D flags;
> +	data->shallow_depth =3D 0;
> +	data->ctx =3D NULL;
> +	data->hctx =3D NULL;
> +}

Hello Jens,

Maybe I'm overlooking something but I don't see how this patch can make
a difference since the compiler zero-initializes struct members that have
not been mentioned explicitly as designated initializers? A common way
to zero-initialize a struct is as follows:

struct <struct_name> <variable_name> =3D { };

Bart.=
