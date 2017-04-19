Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:46766 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937755AbdDSPyQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Apr 2017 11:54:16 -0400
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "hch@lst.de" <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>
CC: "m@bjorling.me" <m@bjorling.me>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 4/5] block: Inline blk_rq_set_prio()
Date: Wed, 19 Apr 2017 15:54:10 +0000
Message-ID: <1492617249.2543.5.camel@sandisk.com>
References: <20170418231037.3968-1-bart.vanassche@sandisk.com>
         <20170418231037.3968-5-bart.vanassche@sandisk.com>
         <20170419062051.GD6412@lst.de>
         <352b4d72-d6ed-692b-a3d9-a664f445ad76@kernel.dk>
In-Reply-To: <352b4d72-d6ed-692b-a3d9-a664f445ad76@kernel.dk>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, 2017-04-19 at 08:38 -0600, Jens Axboe wrote:
> On 04/19/2017 12:20 AM, Christoph Hellwig wrote:
> > > +	req->ioprio =3D ioprio_valid(bio_prio(bio)) ? bio_prio(bio) : ioc ?
> > > +		ioc->ioprio : IOPRIO_PRIO_VALUE(IOPRIO_CLASS_NONE, 0);
> >=20
> > I think this would be a tad cleaner with a traditional if / else if / e=
lse
> > chain, e.g.
> >=20
> > 	if (ioprio_valid(bio_prio(bio)))
> > 		req->ioprio =3D bio_prio(bio);
> > 	else if (ioc)
> > 		req->ioprio =3D ioc->ioprio;
> > 	else
> > 		req->ioprio =3D IOPRIO_PRIO_VALUE(IOPRIO_CLASS_NONE, 0);
>=20
> Agree, I hate ternaries with a vengeance, and a doubly nested one is
> almost a shooting offense.
>=20
> Bart, care to respin with this fixed and the GPL export modification?

Hello Christoph and Jens,

Thanks for the review and the feedback. I will make the proposed changes
and repost this patch series.

Bart.=
