Return-Path: <linux-fsdevel-owner@vger.kernel.org>
Date: Wed, 4 Jan 2017 11:57:45 -0500
From: Theodore Ts'o <tytso@mit.edu>
To: Damien Le Moal <damien.lemoal@wdc.com>
Cc: Slava Dubeyko <Vyacheslav.Dubeyko@wdc.com>,
        Matias =?iso-8859-1?Q?Bj=F8rling?= <m@bjorling.me>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        "lsf-pc@lists.linux-foundation.org"
        <lsf-pc@lists.linux-foundation.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [LSF/MM TOPIC][LSF/MM ATTEND] OCSSDs - SMR, Hierarchical
 Interface, and Vector I/Os
Message-ID: <20170104165745.7uuwl6phm6g6kouu@thunk.org>
References: <05204e9d-ed4d-f97a-88f0-41b5e008af43@bjorling.me>
 <1483398761.2440.4.camel@dubeyko.com>
 <e42ff0c8-6568-d211-331f-7bfa6af94e2e@bjorling.me>
 <1483464921.2440.19.camel@dubeyko.com>
 <9319ce16-8355-3560-95b6-45e3f07220de@bjorling.me>
 <SN2PR04MB219184580108939442EBDA7E88610@SN2PR04MB2191.namprd04.prod.outlook.com>
 <a5acdf89-99c0-774d-cb08-76cb5d846f29@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <a5acdf89-99c0-774d-cb08-76cb5d846f29@wdc.com>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

I agree with Damien, but I'd also add that in the future there may
very well be some new Zone types added to the ZBC model.  So we
shouldn't assume that the ZBC model is a fixed one.  And who knows?
Perhaps T10 standards body will come up with a simpler model for
interfacing with SCSI/SATA-attached SSD's that might leverage the ZBC
model --- or not.

Either way, that's not really relevant as far as the Linux block layer
is concerned, since the Linux block layer is designed to be an
abstraction on top of hardware --- and in some cases we can use a
similar abstraction on top of eMMC's, SCSI's, and SATA's
implementation definition of TRIM/DISCARD/WRITE SAME/SECURE
TRIM/QUEUED TRIM, even though they are different in some subtle ways,
and may have different performance characteristics and semantics.

The trick is to expose similarities where the differences won't matter
to the upper layers, but also to expose the fine distinctions and
allow the file system and/or user space to use the protocol-specific
differences when it matters to them.

Designing that is going to be important, and I can guarantee we won't
get it right at first.  Which is why it's a good thing that internal
kernel interfaces aren't cast into concrete, and can be subject to
change as new revisions to ZBC, or new interfaces (like perhaps
OCSSD's) get promulgated by various standards bodies or by various
vendors.

> > Another point that QLC device could have more tricky features of
> > erase blocks management. Also we should apply erase operation on NAND
> > flash erase block but it is not mandatory for the case of SMR zone.
> 
> Incorrect: host-managed devices require a zone "reset" (equivalent to
> discard/trim) to be reused after being written once. So again, the
> "tricky features" you mention will depend on the device "model",
> whatever this ends up to be for an open channel SSD.

... and this is exposed by having different zone types (sequential
write required vs sequential write preferred vs conventional).  And if
OCSSD's "zones" don't fit into the current ZBC zone types, we can
easily add new ones.  I would suggest however, that we explicitly
disclaim that the block device layer's code points for zone types is
an exact match with the ZBC zone types numbering, precisely so we can
add new zone types that correspond to abstractions from different
hardware types, such as OCSSD.

> Not necessarily. Again think in terms of device "model" and associated
> feature set. An FS implementation may decide to support all possible
> models, with likely a resulting incredible complexity. More likely,
> similarly with what is happening with SMR, only models that make sense
> will be supported by FS implementation that can be easily modified.
> Example again here of f2fs: changes to support SMR were rather simple,
> whereas the initial effort to support SMR with ext4 was pretty much
> abandoned as it was too complex to integrate in the existing code while
> keeping the existing on-disk format.

I'll note that Abutalib Aghayev and I will be presenting a paper at
the 2017 FAST conference detailing a way to optimize ext4 for
Host-Aware SMR drives by making a surprisingly small set of changes to
ext4's journalling layer, with some very promising performance
improvements for certain workloads, which we tested on both Seagate
and WD HA drives and achieved 2x performance improvements.  Patches
are on the unstable portion of the ext4 patch queue, and I hope to get
them into an upstream acceptable shape (as opposed to "good enough for
a research paper") in the next few months.

So it may very well be that small changes can be made to file systems
to support exotic devices if there are ways that we can expose the
right information about underlying storage devices, and offering the
right abstractions to enable the right kind of minimal I/O tagging, or
hints, or commands as necessary such that the changes we do need to
make to the file system can be kept small, and kept easily testable
even if hardware is not available.

For example, by creating device mapper emulators of the feature sets
of these advanced storage interfaces that are exposed via the block
layer abstractions, whether it be for ZBC zones, or hardware
encryption acceleration, etc.

Cheers,

					- Ted
