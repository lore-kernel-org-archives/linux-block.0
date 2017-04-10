Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:18030 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754435AbdDJPz6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Apr 2017 11:55:58 -0400
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "jg@lightnvm.io" <jg@lightnvm.io>
CC: "mb@lightnvm.io" <mb@lightnvm.io>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH v3] lightnvm: physical block device (pblk) target
Date: Mon, 10 Apr 2017 15:55:43 +0000
Message-ID: <1491839741.4199.7.camel@sandisk.com>
References: <1491591015-7554-1-git-send-email-javier@cnexlabs.com>
         <1491591015-7554-2-git-send-email-javier@cnexlabs.com>
         <CY1PR0401MB1536AD7F70C960D62DCA6983810F0@CY1PR0401MB1536.namprd04.prod.outlook.com>
         <E42A544D-D09C-4DDB-800A-9FCED4CBBD28@lightnvm.io>
In-Reply-To: <E42A544D-D09C-4DDB-800A-9FCED4CBBD28@lightnvm.io>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Sun, 2017-04-09 at 11:15 +0200, Javier Gonz=E1lez wrote:
> On 8 Apr 2017, at 22.56, Bart Van Assche <bart.vanassche@sandisk.com> wro=
te:
> > On 04/07/17 11:50, Javier Gonz=E1lez wrote:
> struct ppa_addr, which is the physical address format is not affected,
> but pblk's internal L2P address representation (pblk_addr) is. You can
> see that the type either represents struct ppa_addr or ppa_addr_32. How
> would you define a type that can either be u64 or u32 with different bit
> offsets at run-time? Note that address conversions to this type is in
> the fast path and this format allows us to only use bit shifts.

Selecting the appropriate representation at run-time would require to pass
pblk_addr by reference instead of by value to any function that expects a
pblk_addr. It would also require to have two versions of every data structu=
re
that depends on pblk_addr and to use casts to convert to the appropritate
version. However, this approach is probably only worth to be implemented if
it doesn't introduce too much additional complexity.

> > > +#ifdef CONFIG_NVM_DEBUG
> > > +	atomic_add(nr_entries, &pblk->inflight_writes);
> > > +	atomic_add(nr_entries, &pblk->req_writes);
> > > +#endif
> >=20
> > Has it been considered to use the "static key" feature such that
> > consistency checks can be enabled at run-time instead of having to
> > rebuild the kernel to enable CONFIG_NVM_DEBUG?
>=20
> I haven't considered it. I'll look into it. I would like to have this
> counters and the corresponding sysfs entry only available on debug mode
> since it allows us to have a good picture of the FTL state.

If there are sysfs entries that depend on CONFIG_NVM_DEBUG then the static
key mechanism is probably not a good alternative for CONFIG_NVM_DEBUG.

> > Has it been considered to add support for keeping a subset of the L2P
> > translation table in memory instead of keeping it in memory in its enti=
rety?
>=20
> Yes. L2P caching is on our roadmap and will be included in the future.

That's great. This will also help with reducing the time between discovery =
of
a lightnvm device and the time at which I/O can start since the L2P table m=
ust
be available before I/O can start.

Bart.=
