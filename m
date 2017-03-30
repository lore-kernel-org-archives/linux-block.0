Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:47879 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934103AbdC3PXZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Mar 2017 11:23:25 -0400
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "hare@suse.de" <hare@suse.de>, "axboe@fb.com" <axboe@fb.com>
CC: "osandov@fb.com" <osandov@fb.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] blk-mq: Export queue state through
 /sys/kernel/debug/block/*/state
Date: Thu, 30 Mar 2017 15:23:15 +0000
Message-ID: <1490887381.2753.5.camel@sandisk.com>
References: <1D08B61A9CF0974AA09887BE32D889DA12B851@ULS-OP-MBXIP03.sdcorp.global.sandisk.com>
         <824697ce-3fe4-f7ab-e23b-237b280196fb@suse.de>
         <1490886955.2753.3.camel@sandisk.com>
         <fe04eba2-a67d-9e02-83f4-1f519f79ed4b@fb.com>
In-Reply-To: <fe04eba2-a67d-9e02-83f4-1f519f79ed4b@fb.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, 2017-03-30 at 09:19 -0600, Jens Axboe wrote:
> On 03/30/2017 09:16 AM, Bart Van Assche wrote:
> > On Thu, 2017-03-30 at 07:50 +0200, Hannes Reinecke wrote:
> > > On 03/29/2017 10:20 PM, Bart Van Assche wrote:
> > > > Make it possible to check whether or not a block layer queue has
> > > > been stopped. Make it possible to run a blk-mq queue from user
> > > > space.
> > > >=20
> > > > Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
> > > > Cc: Omar Sandoval <osandov@fb.com>
> > > > Cc: Hannes Reinecke <hare@suse.com>
> > > > ---
> > > >  block/blk-mq-debugfs.c | 84 ++++++++++++++++++++++++++++++++++++++=
++++++++++++
> > > >  1 file changed, 84 insertions(+)
> > > >=20
> > >=20
> > > About bloody time :-)
> > >=20
> > > Reviewed-by: Hannes Reinecke <hare@suse.com>
> >=20
> > Hello Hannes,
> >=20
> > Thanks for the review :-) However, had you noticed that I had already
> > posted a v2 of this patch? Anyway, since I have improved v2 further
> > after I had posted it, I will post a v3 today.
>=20
> I didn't see a v2 posting?

Hello Jens,

The label "v2" was missing from the subject, maybe that's why it didn't get
noticed. Anyway, v2 is available e.g. at URL
http://marc.info/?l=3Dlinux-block&m=3D149082319230648.

Bart.=
