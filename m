Return-Path: <linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org>
Date: Mon, 9 Jan 2017 09:55:31 -0500
From: Theodore Ts'o <tytso@mit.edu>
To: Slava Dubeyko <Vyacheslav.Dubeyko@wdc.com>
Subject: Re: [LSF/MM TOPIC][LSF/MM ATTEND] OCSSDs - SMR, Hierarchical
 Interface, and Vector I/Os
Message-ID: <20170109145531.vty7fwposnih7pqy@thunk.org>
References: <05204e9d-ed4d-f97a-88f0-41b5e008af43@bjorling.me>
 <1483398761.2440.4.camel@dubeyko.com>
 <e42ff0c8-6568-d211-331f-7bfa6af94e2e@bjorling.me>
 <1483464921.2440.19.camel@dubeyko.com>
 <9319ce16-8355-3560-95b6-45e3f07220de@bjorling.me>
 <SN2PR04MB219184580108939442EBDA7E88610@SN2PR04MB2191.namprd04.prod.outlook.com>
 <a5acdf89-99c0-774d-cb08-76cb5d846f29@wdc.com>
 <SN2PR04MB2191BE43398C84C4D262960488600@SN2PR04MB2191.namprd04.prod.outlook.com>
 <20170106011144.fbfqx4ksr7dtsy5p@thunk.org>
 <SN2PR04MB21910EA8BC7A76ABDD20003888640@SN2PR04MB2191.namprd04.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <SN2PR04MB21910EA8BC7A76ABDD20003888640@SN2PR04MB2191.namprd04.prod.outlook.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Damien Le Moal <Damien.LeMoal@wdc.com>,
 Matias =?iso-8859-1?Q?Bj=F8rling?= <m@bjorling.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Viacheslav Dubeyko <slava@dubeyko.com>,
 Linux FS Devel <linux-fsdevel@vger.kernel.org>,
 "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org
List-ID: <linux-block@vger.kernel.org>

So in the model where the Flash-side is tracking logical to physical
zone mapping, and host is merely expecting the ZBC interface, one way
it could work is as follows.

1)  The flash signals that a particular zone should be reset soon.

2)  If the host does not honor the request, eventually the flash will
    have to do a forced copy of the zone to a new erase block.  (This
    is a fail-safe and shouldn't happen under normal circumstances.)

    (By the way, this model can be used for any number of things.  For
    example, for cloud workloads where tail latency is really
    important, it would be really cool if T10/T13 adopted a way that
    the host could be notified about the potential need for ATI
    remediation in a particular disk region, so the host could
    schedule it when it would be least likely to impact high priority,
    low latency workloads.  If the host fails to give permission to
    the firmware to do the ATI remediation before the "gotta go"
    deadline is exceed, the disk would could the ATI remediation at
    that point to assure data integrity as a fail safe.)

3) The host, since it has better knowledge of which blocks belong to
    which inode, and which inodes are more likely to have identical
    object lifetimes (example, all of the .o files in a directory are
    likely to be deleted at the same time when the user runs "make
    clean"; there was a Usenix or FAST paper over a decade ago the
    pointed out that doing hueristics based on file names were likely
    to be helpful), can do a better job of distributing the blocks to
    different partially filled sequential write preferred / sequential
    write required zones.

    The idea here is that you might have multiple zones that are
    partially filled based on expected object lifetime predictions.
    Or the host could move blocks based on the knowledge that a
    particular already has blocks that will share the same fate (e.g.,
    belong to the same inode) --- this is knowledge that the FTL can
    not know, so with a sufficiently smart host file system, it ought
    to be able to do a better job than the FTL.

4) Since we assumed that the Flash is tracking logical to physial zone
   mappings, and the host is responsible for everything else, if the
   host decides to move blocks to different SMR zones, the host file
   system will be responsible for updating its existing (inode,
   logical block) to physical block (SMR zone plus offset) mapping
   tables.

The main advantage of this model is to the extent that there are
cloud/enterprise customers who are already implementing Host Aware SMR
storage solutions, they might be able to reutilize code already
written for SMR HDD's, and reuse it for this model/interface.  Yes,
some tweaks would probably be needed since the design tradeoffs for
disks and flash are very different.  But the point is that the Host
Managed and Host Aware SMR models is one that is well understood by
everyone.

				 ----

There is another model you might consider, and it's one which
Christoph Hillwig suggested at a LSF/MM at least 2-3 years ago, and
this is a model where the flash or the SMR disk could use a division
of labor similar to Object Based Disks (except hopefully with a less
awful interface).  The idea here is that you give up on LBA numbers,
and instead you move the entire responsibility of mapping (inode,
logical block) to (physical location) to the storage device.  The file
system would then be responsibile for managing metadata (mod times,
user/group ownership, permission bits/ACL's, etc) and namespace issues
(e.g., directory pathnames to inode lookups).

So this solves the problem you seem to be concerned about in terms of
keeping mapping information at two layers, and it solves it
completely, since the file system no longer has to do a mapping
between inode+logical offset to LBA number, which it would in the
models you've outlined to date.  It also solves the problem of giving
the storage device more information about which blocks belong to which
inode/object, and it would also make it easier for the OS to pass
object lifetime and shared fate hints to the storage device.  This
should hopefully allow the FTL or STL to do a better job, since it now
has access to low-level hardware inforation (e.g., BER / Soft ECC
failures) as well as higher-level object information to do a better
job making storage layout and garbage collection activities.

				 ----

A fair criticism of any of the models discussed to date (one based on
ZBC, the object-based storage model, or OCSSD) don't have any mature
implementations, either in the open source or the clost source world.
But since it's true for *all* of them, we should be using other
criteria for deciding which model is the best one to choose for the
long term.

The advantage of the ZBC model is that people have had several years
to consider and understand the model, so in terms of mind share it has
an advantage.

The advantage of the object-based model is that it transfers a lot of
the complexity to the storage device, so the job that needs to be done
by the file system is much simpler than either of the other two models.

The advantage of the OCSSD model is that it exposes a lot of the raw
flash complexities to the host.  This can be good in that the host can
now do a really good job optimize for a particular flash technology.
The downside is that by exposing all of that complexity to the host,
it makes file system design very fragile, since as the number of chips
changes, or the size of erase blocks changes, or as flash developes
new capabilities such as erase suspend/resume, *all* of that hair gets
exposed to the file system implementor.

Personally, I think that's why either the ZBC model or the
object-based model makes a lot more sense than something where we
expose all of the vagaries of NAND flash to the file system.

Cheers,

					- Ted

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
