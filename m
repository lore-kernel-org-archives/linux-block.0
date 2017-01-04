Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:15147 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964784AbdADHY7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 4 Jan 2017 02:24:59 -0500
Subject: Re: [LSF/MM TOPIC][LSF/MM ATTEND] OCSSDs - SMR, Hierarchical
 Interface, and Vector I/Os
To: Slava Dubeyko <Vyacheslav.Dubeyko@wdc.com>,
        =?UTF-8?Q?Matias_Bj=c3=b8rling?= <m@bjorling.me>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        "lsf-pc@lists.linux-foundation.org"
        <lsf-pc@lists.linux-foundation.org>
References: <05204e9d-ed4d-f97a-88f0-41b5e008af43@bjorling.me>
 <1483398761.2440.4.camel@dubeyko.com>
 <e42ff0c8-6568-d211-331f-7bfa6af94e2e@bjorling.me>
 <1483464921.2440.19.camel@dubeyko.com>
 <9319ce16-8355-3560-95b6-45e3f07220de@bjorling.me>
 <SN2PR04MB219184580108939442EBDA7E88610@SN2PR04MB2191.namprd04.prod.outlook.com>
Cc: Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
From: Damien Le Moal <damien.lemoal@wdc.com>
Message-ID: <a5acdf89-99c0-774d-cb08-76cb5d846f29@wdc.com>
Date: Wed, 4 Jan 2017 16:24:39 +0900
MIME-Version: 1.0
In-Reply-To: <SN2PR04MB219184580108939442EBDA7E88610@SN2PR04MB2191.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


Slava,

On 1/4/17 11:59, Slava Dubeyko wrote:
> What's the goal of SMR compatibility? Any unification or interface
> abstraction has the goal to hide the peculiarities of underlying
> hardware. But we have block device abstraction that hides all 
> hardware's peculiarities perfectly. Also FTL (or any other
> Translation Layer) is able to represent the device as sequence of
> physical sectors without real knowledge on software side about 
> sophisticated management activity on the device side. And, finally,
> guys will be completely happy to use the regular file systems (ext4,
> xfs) without necessity to modify software stack. But I believe that 
> the goal of Open-channel SSD approach is completely opposite. Namely,
> provide the opportunity for software side (file system, for example)
> to manage the Open-channel SSD device with smarter policy.

The Zoned Block Device API is part of the block layer. So as such, it
does abstract many aspects of the device characteristics, as so many
other API of the block layer do (look at blkdev_issue_discard or zeroout
implementations to see how far this can be pushed).

Regarding the use of open channel SSDs, I think you are absolutely
correct: (1) some users may be very happy to use a regular, unmodified
ext4 or xfs on top of an open channel SSD, as long as the FTL
implementation does a complete abstraction of the device special
features and presents a regular block device to upper layers. And
conversely, (2) some file system implementations may prefer to directly
use those special features and characteristics of open channel SSDs. No
arguing with this.

But you are missing the parallel with SMR. For SMR, or more correctly
zoned block devices since the ZBC or ZAC standards can equally apply to
HDDs and SSDs, 3 models exists: drive-managed, host-aware and host-managed.

Case (1) above corresponds *exactly* to the drive managed model, with
the difference that the abstraction of the device characteristics (SMR
here) is in the drive FW and not in a host-level FTL implementation as
it would be for open channel SSDs. Case (2) above corresponds to the
host-managed model, that is, the device user has to deal with the device
characteristics itself and use it correctly. The host-aware model lies
in between these 2 extremes: it offers the possibility of complete
abstraction by default, but also allows a user to optimize its operation
for the device by allowing access to the device characteristics. So this
would correspond to a possible third way of implementing an FTL for open
channel SSDs.

> So, my key worry that the trying to hide under the same interface the
> two different technologies (SMR and NAND flash) will be resulted in
> the loss of opportunity to manage the device in more smarter way.
> Because any unification has the goal to create a simple interface.
> But SMR and NAND flash are significantly different technologies. And
> if somebody creates technology-oriented file system, for example,
> then it needs to have access to really special features of the
> technology. Otherwise, interface will be overloaded by features of
> both technologies and it will looks like as a mess.

I do not think so, as long as the device "model" is exposed to the user
as the zoned block device interface does. This allows a user to adjust
its operation depending on the device. This is true of course as long as
each "model" has a clearly defined set of features associated. Again,
that is the case for zoned block devices and an example of how this can
be used is now in f2fs (which allows different operation modes for
host-aware devices, but only one for host-managed devices). Again, I can
see a clear parallel with open channel SSDs here.

> SMR zone and NAND flash erase block look comparable but, finally, it
> significantly different stuff. Usually, SMR zone has 265 MB in size
> but NAND flash erase block can vary from 512 KB to 8 MB (it will be
> slightly larger in the future but not more than 32 MB, I suppose). It
> is possible to group several erase blocks into aggregated entity but
> it could be not very good policy from file system point of view.

Why not? For f2fs, the 2MB segments are grouped together into sections
with a size matching the device zone size. That works well and can
actually even reduce the garbage collection overhead in some cases.
Nothing in the kernel zoned block device support limits the zone size to
a particular minimum or maximum. The only direct implication of the zone
size on the block I/O stack is that BIOs and requests cannot cross zone
boundaries. In an extreme setup, a zone size of 4KB would work too and
result in read/write commands of 4KB at most to the device.

> Another point that QLC device could have more tricky features of
> erase blocks management. Also we should apply erase operation on NAND
> flash erase block but it is not mandatory for the case of SMR zone.

Incorrect: host-managed devices require a zone "reset" (equivalent to
discard/trim) to be reused after being written once. So again, the
"tricky features" you mention will depend on the device "model",
whatever this ends up to be for an open channel SSD.

> Because SMR zone could be simply re-written in sequential order if
> all zone's data is invalid, for example. Also conventional zone could
> be really tricky point. Because it is one zone only for the whole
> device that could be updated in-place. Raw NAND flash, usually,
> hasn't likewise conventional zone.

Conventional zones are optional in zoned block devices. There may be
none at all and an implementation may well decide to not support a
device without any conventional zones if some are required.
In the case of open channel SSDs, the FTL implementation may well decide
to expose a particular range of LBAs as "conventional zones" and have a
lower level exposure for the remaining capacity whcih can then be
optimally used by the file system based on the features available for
that remaining LBA range. Again, a parallel is possible with SMR.

> Finally, if I really like to develop SMR- or NAND flash oriented file
> system then I would like to play with peculiarities of concrete
> technologies. And any unified interface will destroy the opportunity 
> to create the really efficient solution. Finally, if my software
> solution is unable to provide some fancy and efficient features then
> guys will prefer to use the regular stack (ext4, xfs + block layer).

Not necessarily. Again think in terms of device "model" and associated
feature set. An FS implementation may decide to support all possible
models, with likely a resulting incredible complexity. More likely,
similarly with what is happening with SMR, only models that make sense
will be supported by FS implementation that can be easily modified.
Example again here of f2fs: changes to support SMR were rather simple,
whereas the initial effort to support SMR with ext4 was pretty much
abandoned as it was too complex to integrate in the existing code while
keeping the existing on-disk format.

Your argument above is actually making the same point: you want your
implementation to use the device features directly. That is, your
implementation wants a "host-managed" like device model. Using ext4 will
require a "host-aware" or "drive-managed" model, which could be provided
through a different FTL or device-mapper implementation in the case of
open channel SSDs.

I am not trying to argue that open channel SSDs and zoned block devices
should be supported under the exact same API. But I can definitely see
clear parallels worth a discussion. As a first step, I would suggest
trying to try defining open channel SSDs "models" and their feature set
and see how these fit with the existing ZBC/ZAC defined models and at
least estimate the implications on the block I/O stack. If adding the
new models only results in the addition of a few top level functions or
ioctls, it may be entirely feasible to integrate the two together.

Best regards.

-- 
Damien Le Moal, Ph.D.
Sr Manager, System Software Research Group,
Western Digital
Damien.LeMoal@hgst.com
Tel: (+81) 0466-98-3593 (Ext. 51-3593)
1 kirihara-cho, Fujisawa, Kanagawa, 252-0888 Japan
www.wdc.com, www.hgst.com
