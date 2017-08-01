Return-Path: <linux-block-owner@vger.kernel.org>
Received: from smtp.ctxuk.citrix.com ([185.25.65.24]:25261 "EHLO
        SMTP.EU.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751166AbdHAJsg (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Aug 2017 05:48:36 -0400
Date: Tue, 1 Aug 2017 10:48:31 +0100
From: Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
To: Benoit Depail <benoit.depail@nbs-system.com>
CC: Keith Busch <keith.busch@intel.com>, <linux-block@vger.kernel.org>,
        <xen-users@lists.xen.org>, WebDawg <webdawg@gmail.com>
Subject: Re: [Xen-users] File-based domU - Slow storage write since xen 4.8
Message-ID: <20170801094831.cr2brqudqubcinxt@dhcp-3-128.uk.xensource.com>
References: <bba4e389-b975-fbb8-b680-c9c4039617ca@nbs-system.com>
 <20170720085256.e3m35aalg6jn7qrh@dhcp-3-128.uk.xensource.com>
 <7205d904-44a3-631f-fbd8-8b62d43ca4e0@nbs-system.com>
 <20170720173606.GD1202@localhost.localdomain>
 <3443d6ac-9011-85fb-3613-bacdee184fcc@nbs-system.com>
 <20170721155333.GG1202@localhost.localdomain>
 <20170721160712.74ee5f3xztbecanw@dhcp-3-128.uk.xensource.com>
 <6d76c489-1f1a-205f-434d-8fa1a486d2c4@nbs-system.com>
 <20170725222505.GH11979@localhost.localdomain>
 <1642cf06-d9a3-1037-e3c9-6b6b3fc9db2d@nbs-system.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
In-Reply-To: <1642cf06-d9a3-1037-e3c9-6b6b3fc9db2d@nbs-system.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Jul 28, 2017 at 04:50:27PM +0200, Benoit Depail wrote:
> On 07/26/17 00:25, Keith Busch wrote:
> > On Fri, Jul 21, 2017 at 07:07:06PM +0200, Benoit Depail wrote:
> >> On 07/21/17 18:07, Roger Pau Monn� wrote:
> >>>
> >>> Hm, I'm not sure I follow either. AFAIK this problem came from
> >>> changing the Linux version in the Dom0 (where the backend, blkback is
> >>> running), rather than in the DomU right?
> >>>
> >>> Regarding the queue/sectors stuff, blkfront uses several blk_queue
> >>> functions to set those parameters, maybe there's something wrong
> >>> there, but I cannot really spot what it is:
> >>>
> >>> http://elixir.free-electrons.com/linux/latest/source/drivers/block/xen-blkfront.c#L929
> >>>
> >>> In the past the number of pages that could fit in a single ring
> >>> request was limited to 11, but some time ago indirect descriptors
> >>> where introduced in order to lift this limit, and now requests can
> >>> have a much bigger number of pages.
> >>>
> >>> Could you check the max_sectors_kb of the underlying storage you are
> >>> using in Dom0?
> >>>
> >>> Roger.
> >>>
> >> I checked the value for the loop device as well
> >>
> >> With 4.4.77 (bad write performance)
> >> $ cat /sys/block/sda/queue/max_sectors_kb
> >> 1280
> >> $ cat /sys/block/loop1/queue/max_sectors_kb
> >> 127
> >>
> >>
> >> With 4.1.42 (normal write performance)
> >> $ cat /sys/block/sda/queue/max_sectors_kb
> >> 4096
> >> $ cat /sys/block/loop1/queue/max_sectors_kb
> >> 127
> > 
> > Thank you for the confirmations so far. Could you confirm performance dom0
> > running 4.4.77 with domU running 4.1.42, and the other way around? Would
> > like to verify if this is just isolated to blkfront.
> > 
> Hi,
> 
> I've ran the tests, and I can tell that the domU kernel version have no
> influence on the performance.
> 
> Dom0 with 4.4.77 always shows bad performance, wether the domU runs
> 4.1.42 or 4.4.77.
> 
> Dom0 with 4.1.42 always shows good performance, wether the domU runs
> 4.1.42 or 4.4.77.

Hello,

I haven't yet got time to look into this sadly. Can you please try to
use fio [0] in order to run the tests against the loop device in Dom0?

If possible, could you test several combinations of block sizes, I/O
sizes and I/O depths?

Thanks, Roger.

[0] http://git.kernel.dk/?p=fio.git;a=summary
