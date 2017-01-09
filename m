Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:1895 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758057AbdAIGtW (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Jan 2017 01:49:22 -0500
From: Slava Dubeyko <Vyacheslav.Dubeyko@wdc.com>
To: Theodore Ts'o <tytso@mit.edu>,
        =?iso-8859-1?Q?Matias_Bj=F8rling?= <m@bjorling.me>
CC: Damien Le Moal <Damien.LeMoal@wdc.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        "lsf-pc@lists.linux-foundation.org"
        <lsf-pc@lists.linux-foundation.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: RE: [LSF/MM TOPIC][LSF/MM ATTEND] OCSSDs - SMR, Hierarchical
 Interface, and Vector I/Os
Date: Mon, 9 Jan 2017 06:49:10 +0000
Message-ID: <SN2PR04MB21910EA8BC7A76ABDD20003888640@SN2PR04MB2191.namprd04.prod.outlook.com>
References: <05204e9d-ed4d-f97a-88f0-41b5e008af43@bjorling.me>
 <1483398761.2440.4.camel@dubeyko.com>
 <e42ff0c8-6568-d211-331f-7bfa6af94e2e@bjorling.me>
 <1483464921.2440.19.camel@dubeyko.com>
 <9319ce16-8355-3560-95b6-45e3f07220de@bjorling.me>
 <SN2PR04MB219184580108939442EBDA7E88610@SN2PR04MB2191.namprd04.prod.outlook.com>
 <a5acdf89-99c0-774d-cb08-76cb5d846f29@wdc.com>
 <SN2PR04MB2191BE43398C84C4D262960488600@SN2PR04MB2191.namprd04.prod.outlook.com>
 <20170106011144.fbfqx4ksr7dtsy5p@thunk.org>
In-Reply-To: <20170106011144.fbfqx4ksr7dtsy5p@thunk.org>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


-----Original Message-----
From: Theodore Ts'o [mailto:tytso@mit.edu]=20
Sent: Thursday, January 5, 2017 5:12 PM
To: Slava Dubeyko <Vyacheslav.Dubeyko@wdc.com>
Cc: Damien Le Moal <Damien.LeMoal@wdc.com>; Matias Bj=F8rling <m@bjorling.m=
e>; Viacheslav Dubeyko <slava@dubeyko.com>; lsf-pc@lists.linux-foundation.o=
rg; Linux FS Devel <linux-fsdevel@vger.kernel.org>; linux-block@vger.kernel=
.org; linux-nvme@lists.infradead.org
Subject: Re: [LSF/MM TOPIC][LSF/MM ATTEND] OCSSDs - SMR, Hierarchical Inter=
face, and Vector I/Os

<skipped>

> I think you've been thinking about a model where *either* the host as com=
plete control
> over all aspects of the flash management, or the FTL has complete control=
 --- and it may
> be that there are more clever ways that the work could be split between
> flash device and the host OS.

Yes, I totally agree that the better way is to split different responsibili=
ties between the flash
device and the host (file system, for example). I would like to consider an=
 SSD device as a set
of FTL primitives. Let's imagine the SSD like an automata that is able to e=
xecute FTL primitives
but the file system issues the commands orchestrate the SSD activity. I bel=
ieve it makes sense
to think about SSD like data processing accelerator engine. It means that w=
e need in good
interface that can be the basis for the offload of data processing operatio=
ns. And I clearly see
the many cases when a file system would like to say: "Hey, SSD. Please, exe=
cute this primitive
for me right now".

Let's consider operations of moving zones (or erase blocks) with high BER.
If we have completely passive SSD then it sounds for me that all operations=
 will look like:
(1) read data on the host side; (2) "reset" zone; (3) write data into the
SSD backwards. But if we talk about some zone (erase block(s)) with high BE=
R is full of valid data
then why does host need to execute the whole operation in such stupid way l=
ike "read-write"?
I mean that it completely doesn't make sense to spend the host's resources =
for such operation.
The responsibility of the host is simply to initiate such operation in the =
proper time. And responsibility
of the SSD is to execute such operation internally (offload of the operatio=
n). So, here we could
have the FTL primitive of moving of zones (erase blocks) for overcoming the=
 read disturbance.

Let's consider GC operations... Right now, we have GC subsystem on the SSD =
side (device-managed and
host-aware case) and we have GC subsystem on the host side (LFS file system=
s of host-aware case).
So, it's clear that SSD device is able to provide some primitives of GC ope=
rations. Also it's completely
unreasonable to have GC subsystem as on SSD side as on the host side. If we=
 have GC subsystem on
the host only then we need to follow the stupid paradigm "read-modify-write=
" and to spend the host's
resources for GC operations. Otherwise, if GC subsystem on the SSD side the=
n GC suffers from lack of
knowledge about valid data location (file system keeps this knowledge) and =
such solution provides
wide range of cases for unexpected performance degradation. So, we need in =
much smarter solution.
What could it be?

Again, file system (host) has to initiate the GC operation in proper time b=
ut the SSD should execute
the requested operation (offload of the operation). So, we will have the GC=
 subsystem on file system
side but the real GC operation under zone (erase block(s)) will be executed=
 by SSD device. The key point
here that: (1) file system choses the good time for GC operation; (2) file =
system is able to select a zone
(erase block(s)) that provides then cost-efficient way of GC activity from =
the point of view of valid data
amount in the aged zone; (3) file system shares information about valid pag=
es in the zone (erase block(s));
(4) SSD executes GC operation under the zone internally.

We need to take into account three possible cases: (1) zone is completely i=
nvalid; (2) zone is partially
invalid; (3) zone contains valid data only. If file system's GC selects a z=
one that doesn't contain valid data
("invalid" zone case) then GC simply needs to request "reset" zone or send =
TRIM command. The rest is
responsibility of SSD device. If zone is completely filled by valid data th=
en file system's GC needs to
request moving operation on the SSD side. If we will use a virtual zones th=
en it means that such moving
operation on the SSD side will change nothing for the file system (logical =
block numbers will be the same).
So, file system doesn't need to change internal mapping table for such oper=
ation.

The case of partially invalid zone (contains some amount of valid data) is =
more tricky. But let's consider
the situation. If file system has knowledge about position of valid logical=
 blocks or pages inside a zone
then the file system is able to share a zone's bitmap with SSD device. It m=
eans that if we have 4 KB
logical block and 256 MB zone then we need in 8 KB bitmap for representing =
positions of valid
logical blocks inside of the zone. So, file system is able to send such val=
id pages' bitmap with the
command of GC operation initiation for some zone. The responsibility of SSD=
 side will be: (1) "reset"
zone; (2) move the valid logical blocks from aged zone into new ones with c=
ompaction scheme using.
I mean that all valid pages should be written in contiguous manner in the n=
ewly allocated zone
(erase blocks). Finally, it means that SSD device can reposition logical bl=
ocks inside of the zone
without changing the initial order of logical pages (compaction scheme). Su=
ch compaction scheme
can be easily implemented on the SSD side. And if we will not change the or=
der of logical blocks
then we have deterministic case that can be easily processed on file system=
 side. If file system has
initial bitmap then it can easily re-calculate the valid logical blocks' po=
sition after compaction scheme
using. For example, F2FS can easily do such re-calculation. Finally, new va=
lues of valid logical blocks'
position should be stored into file system's mapping table. NILFS2 is sligh=
tly more complex case.
Because, NILFS2 describes logical blocks inside of the log by means of spec=
ial btree in the log's header.
So, again, compaction scheme is deterministic case that provides opportunit=
y to re-calculate the
logical blocks' position before real GC operation. It means that NILFS2 is =
able to prepare as valid
logical blocks' bitmap as log's header before GC operation and to share all=
 these stuff with SSD device.

However, every GC operation under partially invalid zone is resulted in cre=
ation of zone that will be
partially filled by valid data (the rest of zone will be completely free). =
What does it need to do in such
case? I can see the four possible approaches:

(1) Re-use the partially filled zone. If file system will track the state o=
f every zone (mapping table,
for example) or it will be possible to extract the state of zone then it me=
ans that aged zone will
change the state after GC operation. So, partially filled zone can be used =
as current zone for
writing a new data.

(2) Add valid data of aged zone into the tail of current zone. Let's imagin=
e that file system is using
some zone as current zone for adding a new data. If we know that an aged zo=
ne contains some
number of valid pages then it's possible to reserve the space in the tail o=
f current zone. Finally,
it is possible to initiate combine flush operation (write data from page ca=
che of current zone)
with GC operation under aged zone on the SSD side.=20

(3) Re-use aged zone as current zone. Let's imagine that we have some aged =
zone with small
number of valid pages. It means that we can select this zone as current zon=
e for a new data.
First of all, we need: (1) "reset" zone; (2) initiate GC operation on the S=
SD device side. We know
how many valid pages we will have in the beginning of the current zone. So,=
 we simply needs
to add a new logical blocks into page cache of current zone after reserved =
area of data from
aged zone. So, our GC operation will be in the background of a new data pre=
paration in the
page cache of current zone. And, finally, we will have the whole zone is fu=
ll of data after
flush operation.

(4) Merge several aged zones into new one.

> It's much better to use an abstraction such as Zones, and then have an ab=
straction layer
> that hides the low-level details of the hardware from the OS.
> The trick is picking an abstraction that exposes the _right_ set of detai=
ls so that the division
> of labor between the Host OS and the storage device is at a better place.=
  Hence my suggestion
> of perhaps providing a virtual mapping layer between "Zone number" and
> the low-level physical erase block.

I like the idea of some abstraction that hides the low-level details. But i=
t sounds that we still
will have two mapping tables on SSD side and file system side. Again we nee=
ds in distribution
the responsibilities between the file system and SSD device. If file system=
 will manage GC activity
but the real GC operation will be delegated on SSD side (in proper time) th=
en it sounds that
all maintenance operations will be done by SSD itself. It means that SSD de=
vice is able to manage
only one mapping table and file system simply needs to have actual copy of =
the mapping table.
Or, oppositely, file system can manage only one mapping table and to share =
the actual state
with the SSD device. But one mapping table looks like as really complicated=
 technique. From
another point of view, virtual zone can have the same ID always. So, the re=
sponsibility of the
SSD device will be mapping the virtual zone ID with physical erase block ID=
s. Such mapping
table (virtual zone ID <-> erase block(s)) can be more compact as mapping t=
able (LBA <->
physical page). The responsibility of file system (host) will be the mappin=
g inside of
the virtual zone (LBA <-> logical block inside the virtual zone). If the vi=
rtual zone ID will be
always the same then such mapping table could be lesser in size. But I don'=
t see how
such mapping table can be lesser in size for the current implementation of =
F2FS or NILFS2.=20
However, let's imagine that log will be equal to the whole zone then the he=
ader of the log
can include likewise mapping table for the log/zone.

Thanks,
Vyacheslav Dubeyko.

