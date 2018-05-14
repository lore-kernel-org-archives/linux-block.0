Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:20577 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752044AbeENV6Q (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 May 2018 17:58:16 -0400
Date: Mon, 14 May 2018 16:00:12 -0600
From: Keith Busch <keith.busch@linux.intel.com>
To: Omar Sandoval <osandov@osandov.com>
Cc: Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: [PATCHv2 blktests] nvme: Add command timeout injection test
Message-ID: <20180514220012.GA15199@localhost.localdomain>
References: <20180514204241.15300-1-keith.busch@intel.com>
 <20180514210136.GE13417@vader>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180514210136.GE13417@vader>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, May 14, 2018 at 02:01:36PM -0700, Omar Sandoval wrote:
> On Mon, May 14, 2018 at 02:42:41PM -0600, Keith Busch wrote:
> > This test will run a background IO process and inject an admin command
> > with a very short timeout that is all but guaranteed to expire without
> > a completion: the async event request.
> > 
> > Signed-off-by: Keith Busch <keith.busch@intel.com>
> > ---
> > v1 -> v2:
> > 
> >   Changed description since its not a test for a specific
> >   regression-fixing patch.
> > 
> >   Added fio requirement.
> > 
> >   Missing quotes around device name.
> 
> I tried this on my QEMU VM, which apparently doesn't emulate this
> command:

Ah, qemu mainline isn't spec compliant and doesn't support AEN requests. I
was testing on real hardware.

This older one has support:

  http://git.infradead.org/users/kbusch/qemu-nvme.git/

It is quite old, though.
 
> Can this test use a loopback target like the nvme tests Johannes has
> added recently?

It looks like the in-kernel nvme target supports it. I'll have to give
it a try.
