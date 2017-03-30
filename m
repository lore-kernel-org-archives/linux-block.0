Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:48779 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933187AbdC3PQS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Mar 2017 11:16:18 -0400
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "hare@suse.de" <hare@suse.de>, "axboe@fb.com" <axboe@fb.com>
CC: "osandov@fb.com" <osandov@fb.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] blk-mq: Export queue state through
 /sys/kernel/debug/block/*/state
Date: Thu, 30 Mar 2017 15:16:08 +0000
Message-ID: <1490886955.2753.3.camel@sandisk.com>
References: <1D08B61A9CF0974AA09887BE32D889DA12B851@ULS-OP-MBXIP03.sdcorp.global.sandisk.com>
         <824697ce-3fe4-f7ab-e23b-237b280196fb@suse.de>
In-Reply-To: <824697ce-3fe4-f7ab-e23b-237b280196fb@suse.de>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, 2017-03-30 at 07:50 +0200, Hannes Reinecke wrote:
> On 03/29/2017 10:20 PM, Bart Van Assche wrote:
> > Make it possible to check whether or not a block layer queue has
> > been stopped. Make it possible to run a blk-mq queue from user
> > space.
> >=20
> > Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
> > Cc: Omar Sandoval <osandov@fb.com>
> > Cc: Hannes Reinecke <hare@suse.com>
> > ---
> >  block/blk-mq-debugfs.c | 84 ++++++++++++++++++++++++++++++++++++++++++=
++++++++
> >  1 file changed, 84 insertions(+)
> >=20
>=20
> About bloody time :-)
>=20
> Reviewed-by: Hannes Reinecke <hare@suse.com>

Hello Hannes,

Thanks for the review :-) However, had you noticed that I had already
posted a v2 of this patch? Anyway, since I have improved v2 further
after I had posted it, I will post a v3 today.

Bart.=
