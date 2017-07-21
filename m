Return-Path: <linux-block-owner@vger.kernel.org>
Received: from smtp.eu.citrix.com ([185.25.65.24]:12392 "EHLO
        SMTP.EU.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753684AbdGUQKh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Jul 2017 12:10:37 -0400
Date: Fri, 21 Jul 2017 17:07:12 +0100
From: Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
To: Keith Busch <keith.busch@intel.com>
CC: Benoit Depail <benoit.depail@nbs-system.com>,
        <linux-block@vger.kernel.org>, <xen-users@lists.xen.org>,
        WebDawg <webdawg@gmail.com>
Subject: Re: [Xen-users] File-based domU - Slow storage write since xen 4.8
Message-ID: <20170721160712.74ee5f3xztbecanw@dhcp-3-128.uk.xensource.com>
References: <5b562ef2-36e2-a08e-1683-6ffc7cfa54de@nbs-system.com>
 <20170717124931.rsiqxkzzkmvfofd7@MacBook-Pro-de-Roger.local>
 <5dd18982-cbcf-a675-1e07-5b4c4e4da50e@nbs-system.com>
 <20170717164658.drliebetcnil3wjb@dhcp-3-128.uk.xensource.com>
 <bba4e389-b975-fbb8-b680-c9c4039617ca@nbs-system.com>
 <20170720085256.e3m35aalg6jn7qrh@dhcp-3-128.uk.xensource.com>
 <7205d904-44a3-631f-fbd8-8b62d43ca4e0@nbs-system.com>
 <20170720173606.GD1202@localhost.localdomain>
 <3443d6ac-9011-85fb-3613-bacdee184fcc@nbs-system.com>
 <20170721155333.GG1202@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20170721155333.GG1202@localhost.localdomain>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Jul 21, 2017 at 11:53:33AM -0400, Keith Busch wrote:
> On Fri, Jul 21, 2017 at 12:19:39PM +0200, Benoit Depail wrote:
> > On 07/20/17 19:36, Keith Busch wrote:
> > > 
> > > As a test, could you throttle the xvdb queue's max_sectors_kb? If I
> > > followed xen-blkfront correctly, the default should have it set to 44.
> > > Try setting it to 40.
> > > 
> > >   echo 40 > /sys/block/xvdb/queue/max_sectors_kb
> > > 
> > 
> > The default value on my domU is 128.
> > 
> > I ran a couple of tests with different values, starting from 40 and up
> > to 128, clearing the cache between each tests.
> > 
> > The only value that showed the issue is 128. Even setting max_sectors_kb
> > to 127 is enough to get normal behaviour.
> 
> Ok, I don't quite follow how it's initialized to 128k, but your
> results appear to confirm the default settings are not optimal for the
> interface. The patch you identified just submits commands to the max
> size the driver asked to use. If the largest size tanks performance,
> I think xen-blkfront should register a smaller transfer size, or maybe
> some other constraint needs to be refined.
> 
> Roger,
> 
> I'm a bit out of my depth here in the xen code. Is this something you
> may be able to help clarify?

Hm, I'm not sure I follow either. AFAIK this problem came from
changing the Linux version in the Dom0 (where the backend, blkback is
running), rather than in the DomU right?

Regarding the queue/sectors stuff, blkfront uses several blk_queue
functions to set those parameters, maybe there's something wrong
there, but I cannot really spot what it is:

http://elixir.free-electrons.com/linux/latest/source/drivers/block/xen-blkfront.c#L929

In the past the number of pages that could fit in a single ring
request was limited to 11, but some time ago indirect descriptors
where introduced in order to lift this limit, and now requests can
have a much bigger number of pages.

Could you check the max_sectors_kb of the underlying storage you are
using in Dom0?

Roger.
