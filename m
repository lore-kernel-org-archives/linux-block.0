Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:33942 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S942842AbdAJBnU (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Jan 2017 20:43:20 -0500
Subject: Re: [LSF/MM TOPIC][LSF/MM ATTEND] OCSSDs - SMR, Hierarchical
 Interface, and Vector I/Os
To: Theodore Ts'o <tytso@mit.edu>
References: <05204e9d-ed4d-f97a-88f0-41b5e008af43@bjorling.me>
 <1483398761.2440.4.camel@dubeyko.com>
 <e42ff0c8-6568-d211-331f-7bfa6af94e2e@bjorling.me>
 <1483464921.2440.19.camel@dubeyko.com>
 <9319ce16-8355-3560-95b6-45e3f07220de@bjorling.me>
 <SN2PR04MB219184580108939442EBDA7E88610@SN2PR04MB2191.namprd04.prod.outlook.com>
 <a5acdf89-99c0-774d-cb08-76cb5d846f29@wdc.com>
 <20170104165745.7uuwl6phm6g6kouu@thunk.org>
Cc: Slava Dubeyko <Vyacheslav.Dubeyko@wdc.com>,
        =?UTF-8?Q?Matias_Bj=c3=b8rling?= <m@bjorling.me>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        "lsf-pc@lists.linux-foundation.org"
        <lsf-pc@lists.linux-foundation.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
From: Damien Le Moal <damien.lemoal@wdc.com>
Message-ID: <1b457b77-34d8-ab82-ae1d-279e86053af9@wdc.com>
Date: Tue, 10 Jan 2017 10:42:45 +0900
MIME-Version: 1.0
In-Reply-To: <20170104165745.7uuwl6phm6g6kouu@thunk.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


Ted,

On 1/5/17 01:57, Theodore Ts'o wrote:
> I agree with Damien, but I'd also add that in the future there may
> very well be some new Zone types added to the ZBC model.  So we
> shouldn't assume that the ZBC model is a fixed one.  And who knows?
> Perhaps T10 standards body will come up with a simpler model for
> interfacing with SCSI/SATA-attached SSD's that might leverage the ZBC
> model --- or not.

Totally agree. There is already some activity in T10 for a ZBC V2
standard which indeed may include new zone types (for instance a
"circular buffer zone type that can be sequentially rewritten without a
reset, preserving previously written data for reads after the write
pointer). Such type of zone could be a perfect match for an FS journal
log space for instance.

> Either way, that's not really relevant as far as the Linux block layer
> is concerned, since the Linux block layer is designed to be an
> abstraction on top of hardware --- and in some cases we can use a
> similar abstraction on top of eMMC's, SCSI's, and SATA's
> implementation definition of TRIM/DISCARD/WRITE SAME/SECURE
> TRIM/QUEUED TRIM, even though they are different in some subtle ways,
> and may have different performance characteristics and semantics.
> 
> The trick is to expose similarities where the differences won't matter
> to the upper layers, but also to expose the fine distinctions and
> allow the file system and/or user space to use the protocol-specific
> differences when it matters to them.

Absolutely. The initial zoned block device support was written to match
what ZBC/ZAC defines. It was simple this way and there was no other
users of the zone concept. But the device models and zone types are just
numerical values reported to the device user. The block I/O stack
currently does not use these values beyond the device initialization. It
is up to the users (e.g. FS) of the device to determine what to do to
correctly use the device according to the types reported. So this basic
design is definitely extensible to new zone types and device models.

> 
> Designing that is going to be important, and I can guarantee we won't
> get it right at first.  Which is why it's a good thing that internal
> kernel interfaces aren't cast into concrete, and can be subject to
> change as new revisions to ZBC, or new interfaces (like perhaps
> OCSSD's) get promulgated by various standards bodies or by various
> vendors.

Indeed. The ZBC case was simple as we matched the standard defined
models. Whihc in any case is not really used in any way directly by the
block I/O stack itself. Only upper layers use that.

In the case of ACSSD, this adds one hardware-defined model set by the
standard, plus a potential collection of software defined models through
different FTL implementations on the host. Getting these models and
there API right will be indeed tricky. In a first step, providing a
ZBC-like host-aware model and a host-managed model may be a good idea as
upper layer code already ready for ZBC disks will work out-of-the-box
for OCSSDs too. From there, I can see a lot of possibilities for more
SSD optimized models though.

>>> Another point that QLC device could have more tricky features of
>>> erase blocks management. Also we should apply erase operation on NAND
>>> flash erase block but it is not mandatory for the case of SMR zone.
>>
>> Incorrect: host-managed devices require a zone "reset" (equivalent to
>> discard/trim) to be reused after being written once. So again, the
>> "tricky features" you mention will depend on the device "model",
>> whatever this ends up to be for an open channel SSD.
> 
> ... and this is exposed by having different zone types (sequential
> write required vs sequential write preferred vs conventional).  And if
> OCSSD's "zones" don't fit into the current ZBC zone types, we can
> easily add new ones.  I would suggest however, that we explicitly
> disclaim that the block device layer's code points for zone types is
> an exact match with the ZBC zone types numbering, precisely so we can
> add new zone types that correspond to abstractions from different
> hardware types, such as OCSSD.

The struct blk_zone type is 64B in size but only currently uses 32B. So
there is room for new fields, and existing fields can have newly defined
values too as the ZBC standard uses only few of the possible values in
the structure fields.

>> Not necessarily. Again think in terms of device "model" and associated
>> feature set. An FS implementation may decide to support all possible
>> models, with likely a resulting incredible complexity. More likely,
>> similarly with what is happening with SMR, only models that make sense
>> will be supported by FS implementation that can be easily modified.
>> Example again here of f2fs: changes to support SMR were rather simple,
>> whereas the initial effort to support SMR with ext4 was pretty much
>> abandoned as it was too complex to integrate in the existing code while
>> keeping the existing on-disk format.
> 
> I'll note that Abutalib Aghayev and I will be presenting a paper at
> the 2017 FAST conference detailing a way to optimize ext4 for
> Host-Aware SMR drives by making a surprisingly small set of changes to
> ext4's journalling layer, with some very promising performance
> improvements for certain workloads, which we tested on both Seagate
> and WD HA drives and achieved 2x performance improvements.  Patches
> are on the unstable portion of the ext4 patch queue, and I hope to get
> them into an upstream acceptable shape (as opposed to "good enough for
> a research paper") in the next few months.

Thank you for the information. I will check this out. Is it the
optimization that aggressively delay meta-data update by allowing
reading of meta-data blocks directly from the journal (for blocks that
are not yet updated in place) ?

> So it may very well be that small changes can be made to file systems
> to support exotic devices if there are ways that we can expose the
> right information about underlying storage devices, and offering the
> right abstractions to enable the right kind of minimal I/O tagging, or
> hints, or commands as necessary such that the changes we do need to
> make to the file system can be kept small, and kept easily testable
> even if hardware is not available.
> 
> For example, by creating device mapper emulators of the feature sets
> of these advanced storage interfaces that are exposed via the block
> layer abstractions, whether it be for ZBC zones, or hardware
> encryption acceleration, etc.

Emulators may indeed be very useful for development. But we could also
go further and implement the different models using device mappers too.
Doing so, the same device could be used with different FTL through the
same DM interface. And this may also simplify the implementation of
complex models using DM stacking (e.g. the host-aware model can be
implemented on top of a host-managed model).

Best regards.

-- 
Damien Le Moal, Ph.D.
Sr. Manager, System Software Research Group,
Western Digital Corporation
Damien.LeMoal@wdc.com
(+81) 0466-98-3593 (ext. 513593)
1 kirihara-cho, Fujisawa,
Kanagawa, 252-0888 Japan
www.wdc.com, www.hgst.com
