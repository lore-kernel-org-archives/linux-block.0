Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:28026 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933474AbdC3SLI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Mar 2017 14:11:08 -0400
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "axboe@fb.com" <axboe@fb.com>
CC: "osandov@fb.com" <osandov@fb.com>, "hare@suse.de" <hare@suse.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] blk-mq: Export queue state through
 /sys/kernel/debug/block/*/state
Date: Thu, 30 Mar 2017 18:10:57 +0000
Message-ID: <1490897421.2753.12.camel@sandisk.com>
References: <1D08B61A9CF0974AA09887BE32D889DA12BA96@ULS-OP-MBXIP03.sdcorp.global.sandisk.com>
         <f80153aa-3e7d-0a20-e426-7e58cd7c249d@fb.com>
In-Reply-To: <f80153aa-3e7d-0a20-e426-7e58cd7c249d@fb.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, 2017-03-30 at 09:27 -0600, Jens Axboe wrote:
> On 03/29/2017 03:32 PM, Bart Van Assche wrote:
> > Make it possible to check whether or not a block layer queue has
> > been stopped. Make it possible to start and to run a blk-mq queue
> > from user space.
>=20
> Looks good, minor nitpicking below.
>=20
> > +static int blk_queue_flags_show(struct seq_file *m, void *v)
> > +{
> > +	struct request_queue *q =3D m->private;
> > +	bool sep =3D false;
> > +	int i;
> > +
> > +	for (i =3D 0; i < sizeof(q->queue_flags) * BITS_PER_BYTE; i++) {
> > +		if (!(q->queue_flags & BIT(i)))
> > +			continue;
> > +		if (sep)
> > +			seq_puts(m, " ");
> > +		sep =3D true;
>=20
> Put that sep =3D true in the else branch?

I can do that, but that would result in slightly less efficient assembler
code (additional jump) while stores can be pipelined easily.

> > +	if (strcmp(op, "run") =3D=3D 0) {
> > +		blk_mq_run_hw_queues(q, true);
> > +	} else if (strcmp(op, "start") =3D=3D 0) {
> > +		blk_mq_start_stopped_hw_queues(q, true);
> > +	} else {
> > +		pr_err("%s: unsupported operation %s\n", __func__, op);
> > +		return -EINVAL;
> > +	}
>=20
> You are inconsistent with your braces. I'd prefer no braces for single
> lines.

Sorry but if braces are used for one side of an if-then-else statement then
checkpatch wants braces to be used for the other side too, even if that oth=
er
side is only a single line. From the checkpatch source code:

# check for single line unbalanced braces
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if ($sline =3D~ /^.\s*\}\s*=
else\s*$/ ||
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0$sline =3D~ /^.=
\s*else\s*\{\s*$/) {
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0CHK=
("BRACES", "Unbalanced braces around else statement\n" . $herecurr);
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0}

> Should the error case include valid commands? It'd be nice to have this
> available, and not have to resort to looking at the source to figure out
> what commands are available.

OK, I will update the error message.

Thanks for the review.

Bart.=
