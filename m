Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH RFC 01/14] block, bfq: introduce the BFQ-v0 I/O scheduler as an extra scheduler
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <9ddb9586-d97e-e7b2-0081-216521f7be76@kernel.dk>
Date: Sat, 18 Mar 2017 08:41:52 -0400
Cc: Tejun Heo <tj@kernel.org>,
 Fabio Checconi <fchecconi@gmail.com>,
 Arianna Avanzini <avanzini.arianna@gmail.com>,
 linux-block@vger.kernel.org,
 Linux-Kernal <linux-kernel@vger.kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 broonie@kernel.org
Message-Id: <08CE1658-04B0-48F4-BF3D-A6DB0F032905@linaro.org>
References: <20170304160131.57366-1-paolo.valente@linaro.org> <20170304160131.57366-2-paolo.valente@linaro.org> <9ddb9586-d97e-e7b2-0081-216521f7be76@kernel.dk>
To: Jens Axboe <axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>


> Il giorno 07 mar 2017, alle ore 18:22, Jens Axboe <axboe@kernel.dk> ha =
scritto:
>=20
>> +/**
>> + * bfq_entity_of - get an entity from a node.
>> + * @node: the node field of the entity.
>> + *
>> + * Convert a node pointer to the relative entity.  This is used only
>> + * to simplify the logic of some functions and not as the generic
>> + * conversion mechanism because, e.g., in the tree walking =
functions,
>> + * the check for a %NULL value would be redundant.
>> + */
>> +static struct bfq_entity *bfq_entity_of(struct rb_node *node)
>> +{
>> +	struct bfq_entity *entity =3D NULL;
>> +
>> +	if (node)
>> +		entity =3D rb_entry(node, struct bfq_entity, rb_node);
>> +
>> +	return entity;
>> +}
>=20
> Get rid of pointless wrappers like this, just use rb_entry() in the
> caller. It's harmful to the readability of the code to have to lookup
> things like this, if it's a list_entry or rb_entry() in the caller you
> know exactly what is going on immediately.
>=20


Ok.  Just a quick request for help about this.  The code seems to become
quite ugly with a verbatim replacement of this function with its body
(and there are several occurrences of it), so there is probably =
something I'm
missing.  For example, given the following loop:

	for (; entity ; entity =3D bfq_entity_of(rb_first(active)))
		bfq_reparent_leaf_entity(bfqd, entity);

the only non-cryptic, but heavier solution I see is:

	for (; entity ; ) {
		bfq_reparent_leaf_entity(bfqd, entity);
		if (rb_first(active))
			entity =3D rb_entry(rb_first(active), struct =
bfq_entity, rb_node);
		else
			entity =3D NULL;
	}

Am I missing something?  Or are these extra lines of code a reasonable
price to pay for increased transparency?

Thanks,
Paolo

> --=20
> Jens Axboe
>=20
