Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH RFC 01/14] block, bfq: introduce the BFQ-v0 I/O scheduler
 as an extra scheduler
To: Paolo Valente <paolo.valente@linaro.org>, Tejun Heo <tj@kernel.org>
References: <20170304160131.57366-1-paolo.valente@linaro.org>
 <20170304160131.57366-2-paolo.valente@linaro.org>
Cc: Fabio Checconi <fchecconi@gmail.com>,
 Arianna Avanzini <avanzini.arianna@gmail.com>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, ulf.hansson@linaro.org,
 linus.walleij@linaro.org, broonie@kernel.org
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <9ddb9586-d97e-e7b2-0081-216521f7be76@kernel.dk>
Date: Tue, 7 Mar 2017 16:22:48 -0700
MIME-Version: 1.0
In-Reply-To: <20170304160131.57366-2-paolo.valente@linaro.org>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

> +/**
> + * bfq_entity_of - get an entity from a node.
> + * @node: the node field of the entity.
> + *
> + * Convert a node pointer to the relative entity.  This is used only
> + * to simplify the logic of some functions and not as the generic
> + * conversion mechanism because, e.g., in the tree walking functions,
> + * the check for a %NULL value would be redundant.
> + */
> +static struct bfq_entity *bfq_entity_of(struct rb_node *node)
> +{
> +	struct bfq_entity *entity = NULL;
> +
> +	if (node)
> +		entity = rb_entry(node, struct bfq_entity, rb_node);
> +
> +	return entity;
> +}

Get rid of pointless wrappers like this, just use rb_entry() in the
caller. It's harmful to the readability of the code to have to lookup
things like this, if it's a list_entry or rb_entry() in the caller you
know exactly what is going on immediately.

-- 
Jens Axboe
