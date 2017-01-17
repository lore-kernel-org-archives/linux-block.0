Return-Path: <linux-fsdevel-owner@vger.kernel.org>
From: Slava Dubeyko <Vyacheslav.Dubeyko@wdc.com>
To: Jan Kara <jack@suse.cz>
CC: Vishal Verma <vishal.l.verma@intel.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "lsf-pc@lists.linux-foundation.org"
        <lsf-pc@lists.linux-foundation.org>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Subject: RE: [Lsf-pc] [LSF/MM TOPIC] Badblocks checking/representation in
 filesystems
Date: Tue, 17 Jan 2017 23:15:17 +0000
Message-ID: <SN2PR04MB219128E4C8C4FD4AF3452C7C887C0@SN2PR04MB2191.namprd04.prod.outlook.com>
References: <at1mp6pou4lenesjdgh22k4p.1484345585589@email.android.com>
 <b9rbflutjt10mb4ofherta8j.1484345610771@email.android.com>
 <SN2PR04MB2191756EABCB0E9DAA3B5328887B0@SN2PR04MB2191.namprd04.prod.outlook.com>
 <20170114004910.GA4880@omniknight.lm.intel.com>
 <SN2PR04MB2191A6EDB7203AF86600FD25887D0@SN2PR04MB2191.namprd04.prod.outlook.com>
 <20170117143703.GP2517@quack2.suse.cz>
In-Reply-To: <20170117143703.GP2517@quack2.suse.cz>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>


-----Original Message-----
From: Jan Kara [mailto:jack@suse.cz]=20
Sent: Tuesday, January 17, 2017 6:37 AM
To: Slava Dubeyko <Vyacheslav.Dubeyko@wdc.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>; linux-block@vger.kernel.org; L=
inux FS Devel <linux-fsdevel@vger.kernel.org>; lsf-pc@lists.linux-foundatio=
n.org; Viacheslav Dubeyko <slava@dubeyko.com>; linux-nvdimm@lists.01.org
Subject: Re: [Lsf-pc] [LSF/MM TOPIC] Badblocks checking/representation in f=
ilesystems

> > > We don't have direct physical access to the device's address space,=20
> > > in the sense the device is still free to perform remapping of chunks =
of NVM underneath us.
> > > The problem is that when a block or address range (as small as a=20
> > > cache line) goes bad, the device maintains a poison bit for every=20
> > > affected cache line. Behind the scenes, it may have already remapped=
=20
> > > the range, but the cache line poison has to be kept so that there is =
a notification to the user/owner of the data that something has been lost.
> > > Since NVM is byte addressable memory sitting on the memory bus, such=
=20
> > > a poisoned cache line results in memory errors and SIGBUSes.
> > > Compared to tradational storage where an app will get nice and friend=
ly (relatively speaking..) -EIOs.
> > > The whole badblocks implementation was done so that the driver can=20
> > > intercept IO (i.e. reads) to _known_ bad locations, and=20
> > > short-circuit them with an EIO. If the driver doesn't catch these, th=
e reads will turn into a memory bus access, and the poison will cause a SIG=
BUS.
> > >
> > > This effort is to try and make this badblock checking smarter - and=20
> > > try and reduce the penalty on every IO to a smaller range, which only=
 the filesystem can do.

> Well, the situation with NVM is more like with DRAM AFAIU. It is quite re=
liable
> but given the size the probability *some* cell has degraded is quite high=
.
> And similar to DRAM you'll get MCE (Machine Check Exception) when you try
> to read such cell. As Vishal wrote, the hardware does some background scr=
ubbing
> and relocates stuff early if needed but nothing is 100%.

My understanding that hardware does the remapping the affected address
range (64 bytes, for example) but it doesn't move/migrate the stored data i=
n this address
range. So, it sounds slightly weird. Because it means that no guarantee to =
retrieve the stored
data. It sounds that file system should be aware about this and has to be h=
eavily protected
by some replication or erasure coding scheme. Otherwise, if the hardware do=
es everything for us
(remap the affected address region and move data into a new address region)=
 then why
does file system need to know about the affected address regions?

> The reason why we play games with badblocks is to avoid those MCEs
> (i.e., even trying to read the data we know that are bad). Even if it wou=
ld
> be rare event, MCE may mean the machine just immediately reboots
> (although I find such platforms hardly usable with NVM then) and that
> is no good. And even on hardware platforms that allow for more graceful
> recovery from MCE it is asynchronous in its nature and our error handling
> around IO is all synchronous so it is difficult to join these two models =
together.
>
> But I think it is a good question to ask whether we cannot improve on MCE=
 handling
> instead of trying to avoid them and pushing around responsibility for han=
dling
> bad blocks. Actually I thought someone was working on that.
> Cannot we e.g. wrap in-kernel accesses to persistent memory (those are no=
w
> well identified anyway so that we can consult the badblocks list) so that=
 it MCE
> happens during these accesses, we note it somewhere and at the end of the=
 magic
> block we will just pick up the errors and report them back?

Let's imagine that the affected address range will equal to 64 bytes. It so=
unds for me
that for the case of block device it will affect the whole logical block (4=
 KB). If the failure
rate of address ranges could be significant then it would affect a lot of l=
ogical blocks.
It looks like a complete nightmare for the file system. Especially, if we d=
iscover such
issue on the read operation. Again, LBA means logical block address. It sou=
nds for me
that this guy should be valid always. Otherwise, we crash the whole concept=
.

The situation is more critical for the case of DAX approach. Correct me if =
I wrong but
my understanding is the goal of DAX is to provide the direct access to file=
's memory
pages with minimal file system overhead. So, it looks like that raising bad=
 block issue
on file system level will affect a user-space application. Because, finally=
, user-space
application will need to process such trouble (bad block issue). It sounds =
for me as really
weird situation. What can protect a user-space application from encounterin=
g the issue
with partially incorrect memory page?

> > OK. Let's imagine that NVM memory device hasn't any internal error=20
> > correction hardware-based scheme. Next level of defense could be any=20
> > erasure coding scheme on device driver level. So, any piece of data=20
> > can be protected by parities. And device driver will be responsible=20
> > for management of erasure coding scheme. It will increase latency of=20
> > read operation for the case of necessity to recover the affected memory=
 page.
> > But, finally, all recovering activity will be behind the scene and=20
> > file system will be unaware about such recovering activity.
>
> Note that your options are limited by the byte addressability and
> the direct CPU access to the memory. But even with these limitations
> it is not that error rate would but unusually high, it is just not zero.
=20
Even for the case of byte addressability, I cannot see any troubles
with using some error correction or erasure coding schemes
inside of the memory chip. Especially, for the rare case of such issue
the latency of device operations will be pretty OK.

> > If you are going not to provide any erasure coding or error correction=
=20
> > scheme then it's really bad case. The fsck tool is not regular case=20
> > tool but the last resort. If you are going to rely on the fsck tool=20
> > then simply forget about using your hardware. Some file systems=20
> > haven't the fsck tool at all. Some guys really believe that file=20
> > system has to work without support of the fsck tool.  Even if a mature=
=20
> > file system has reliable fsck tool then the probability of file system=
=20
> > recovering is very low in the case of serious metadata corruptions.=20
> > So, it means that you are trying to suggest the technique when we will=
=20
> > lose the whole file system volumes on regular basis without any hope=20
> > to recover data. Even if file system has snapshots then, again, we=20
> > haven't hope because we can suffer from read error and for operation wi=
th snapshot.
>
> I hope I have cleared out that this is not about higher error rate
> of persistent memory above. As a side note, XFS guys are working on autom=
atic
> background scrubbing and online filesystem checking. Not specifically for=
 persistent
> memory but simply because with growing size of the filesystem the likelih=
ood of
> some problem somewhere is growing.=20
=20
I see your point but even for low error rate you cannot predict what logica=
l
block can be affected by such issue. Even the online file system checking s=
ubsystem
cannot prevent from file system corruption. Because, for example, if you fi=
nd
during a read operation that your btree's root node is corrupted then you
can lose the whole btree.

Thanks,
Vyacheslav Dubeyko.
=20
