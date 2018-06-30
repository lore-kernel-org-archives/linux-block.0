Return-Path: <jdow@earthlink.net>
Subject: Re: Subject: [PATCH RFC] block: fix Amiga RDB partition support for
 disks >= 2 TB
To: Martin Steigerwald <martin@lichtvoll.de>,
 Michael Schmitz <schmitzmic@gmail.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Jens Axboe <axboe@kernel.dk>,
 linux-m68k <linux-m68k@lists.linux-m68k.org>, linux-block@vger.kernel.org
References: <20180627012421.80B8F24E094@nmr-admin>
 <af252a47-a22e-5f40-f412-e5dbfaa6858c@earthlink.net>
 <c02bbd73-d946-9d1b-7f10-03aacae1f1ee@gmail.com> <8748093.MpWLty1hLz@merkaba>
From: jdow <jdow@earthlink.net>
Message-ID: <5f5d1ca9-58ab-0f97-8d23-8b1304e9b4de@earthlink.net>
Date: Sat, 30 Jun 2018 02:28:05 -0700
MIME-Version: 1.0
In-Reply-To: <8748093.MpWLty1hLz@merkaba>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

For Linux:
1) Make a change to the Linux RDB parser so that the product of the "CHS" values 
goes to at least a 64 bit entity, It may need to go to a 128 bit entity when we 
are encoding data in DNA, crystal lattices, or something else super dense. The 
parser simply feeds data to the OS. No warnings are needed. No errors are 
expected but if they happen do not mount the disk and post an error message the 
user can use to diagnose the problem. "It's broken," is insufficient.
2) if there is an mkfs-(amiga file system of some sort) utility audit it for 
generating values as proper as possible. For the interim a warning of heads 
times sectors overflows uint32_t size storage.

For AmigaDOS:
1) Be aware that there is a potential for problems in the AmigaDOS utilities, 
filesystem, and device driver interfaces. This should be audited for overflow 
issues and to see of the rdb_CylinderBlocks value propagates through the system 
or an equivalent is created as a uint32_t size value. This is a potential 
problem. And fix them.
2) If 4.1 cannot handle block sizes other than 512 bytes it is broken and should 
be fixed. This goes for all tools and utilities as well. Incompatible utilities 
that are found should be flagged to users. This might include old versions of 
AmigaDOS partitioning tools as well as most anything else found to use the "CHS" 
and "block size" values. The size of this audit is unknown. If source code is in 
one place it can be searched for the use of these values as well as 
rdb_CylinderBlocks itself.

Regardless of how you fiddle the values the limit is beyond the size needed to 
have each atom in the visible universe individually addressed by several orders 
of magnitude. The ultimate limit is 2^128. Your value is too small by a few 
orders of magnitude. It's academic, though. This is all predicted on auditing 
the system's use of the "CHS" and block size values and repairing errors found.

Logical block sizes come from using say 16 sectors as one block, or in MS 
parlance "cluster". Call it an space allocation unit.

"Even if we´d find out the possible combinations of the official tools,
there are RDB tools like RDBSalv and what not." "All" means "All." If no 
maintainer exists then flag the tool as broken, and for God's sake don't 
distribute it with the OS.

Re hdwrench.library, I have all the source code. I've wasted enough time that I 
am HIGHLY unmotivated to dig into this morass any further.

On a side note, if HAAGE&PARTNER developed 3.whatever which included 
hdwrench.library as a work for hire for you then that source code can be 
located, including a fairly complete history if its development. Once located it 
can be posted to you if you cannot find it. It's copyrighted to H&P. I did it as 
a consultant for them. If you hired them to do the work then the copyright is 
misattributed and can be rectified.

Regarding hard block writing limitations - THAT must be near the front of super 
large disks. On an 18 gigabyte disk you can even get away with putting the RDBs 
at the end of the disk except for the RDSK block which must be in the first 16 
physical sectors. Everything else is uint32_t block number pointers. {^_-} Use 
your imagination, Luke! {^_-}

Any code that uses the "CHS" values to calculate a position or size of a disk is 
potentially broken. Hopefully there are only a very few. But I do not know and 
am a known paranoid.

At one time I had the impression that filesystems worked based on block numbers 
on the disk, first block and last block of the partition with no particular 
attention being paid to the "CHS" values. Of course the filesystem must think 
properly in terms of cluster size aka logical block size aka N * sector size. 
Erm, usually N is expected to be a power of 2. Non-powers of 2 MIGHT work in 
some cases. The filesystem gets an fssm message. That includes a DosEnvec. 
DosEnvec includes disk information for block size and "CHS" but at the moment I 
don't see a CylinderBlocks value hiding in it. I thought I had seen such at one 
time so in my hurry I may be going past it.

Somebody ****ELSE**** has some work to do now.

{^_^}

On 20180630 01:48, Martin Steigerwald wrote:
> Michael. Joanne.
> 
> I do think this discussion is slightly getting out of hand… so I suggest
> to focus on what its up to the kernel to do and what is not. And to
> focus only on what is up to the RDB parser, cause the patch is on
> changing that. The RDB parser is not responsible for what any file
> system may do. Securing AFFS would be a different, important, topic.
> 
> With that mail I am probably out as this discussion took already quite a
> bit of time.
> 
> But for details, read on:
> 
> Michael Schmitz - 30.06.18, 07:26:
>> Am 30.06.18 um 15:56 schrieb jdow:
>>>>>> As far as I can guess from the code, pb_Environment[3] (number
>>>>>> of
>>>>>
>>>>> heads)
>>>>>
>>>>>> and pb_Environment[5] (number of sectors per cylinder) are
>>>>>> abitrarily
>>>>>> chosen so the partition size can be expressed as a difference
>>>>>> between
>>>>>> pb_Environment[9] and pb_Environment[10] (low and high cylinder
>>>>>> addresses), which places restrictions on both partition size and
>>>>>> alignment that depend on where on the disk a partition is
>>>>>> placed?
>>>>>
>>>>> If you do not teach the OS to ignore Cylinder Blocks type entries
>>>>> and
>>>>> use some math on heads and blocks per track the disk size is
>>>>> relatively stuck modulo using large blocks.
>>>>
>>>> As long as AmigaOS and Linux agree on how to express start and end
>>>> offset for the partitions, that's fine.
>>>>
>>>> But I read your other mail to mean that we're stuck to 2 TB disks
>>>> for
>>>> now. I don't follow that - we can have partitions of 2 TB each by
>>>
>>> maxing
>>>
>>>> out rdb_CylBlocks as long as we use 512 bytes per block (since the
>>>> product of cylinders and blocks per cylinder is limited to 32
>>>> bits) and using one cylinder per partition (32 bits available
>>>> there as well)?
>>>>
>>>> But the rdb_CylBlocks limit also means we're safe with 64 bit
>>>> sector_t in Linux. Best add a check in the parser to warn us if
>>>> the product of head count and sectors per cylinder overflows 32
>>>> bit though.
>>>>
>>>> Cheers,
>>>>
>>>>       Michael
>>>
>>> How long did it tale s to get to 10 TB disks from 2 TB disks. And a
>>> new SD Card spec allows for 128 TB disks. Block sizes get sort of
>>> ridiculous as you get past about 8k bytes or about 32 TB or about
>>> two
>>> years from now.
>>
>> I get that - I just don't get why 32 bits for cylinders plus 32 bits
>> for blocks per cylinder equals 2 TB (4G of 512 byte blocks). But I
>> don't know what other limits exist that may restrict the total number
>> of blocks to 32 bits.
> 
> I think for the total device size:
> 
>> The raw, theoretical limit on the maximum device capacity is about
>> 2^105 bytes:
>>
>> 32 bit rdb_Cylinders * 32 bit rdb_Heads * 32 bit rdb_Sectors * 512
>> bytes/sector for the HD size in struct RigidDiskBlock
> 
> is correct. Do you agree, Joanne?
> 
> http://wiki.amigaos.net/wiki/RDB
> 
> If so, we can remove that limit from the discussion and focus on what
> remains.
> 
> 
> As for the partition sizes, how about
> 
>> Partition size
>>
>> For the partitions the maximum size is:32 bit (de_HighCyl + 1 - de_LowCyl) (to get the partition size) * 32
>> bit de_Surfaces * 32 bit de_SectorsPerTrack * 512 bytes/sector in
>> struct DosEnvec (=pb_Environment[]) in struct PartitionBlock.
>> That's from the physical drive part, the actual disk size limit for >
>> the partitions may be much smaller depending on the partitioning
>> software, if it's only using the logical sizes instead, which is
>> likely the case, it's only 8 ZiB with 512 bytes/sector: 32 bit
>> rdb_HiCylinder * 32 bit rdb_CylBlocks * 512 bytes/sector = 2^73
>> bytes. For using the logical sizes using simple uint64 calculations
>> (with some overflow checks) should be enough, for more a math library
>> with support for larger integers needs to be used which probably no
>> partitioning software does.
> 
> taken from the same wiki page?
> 
> I however do not get what it means with "logical sizes".
> 
> Joanne, what is your feedback on this?
> 
>>> Do you want to create disks that will fail on AmigaDOS? AmigaDOS, as
>>> far as I know, makes heavy use of Cylinder Blocks values. It
>>> calculating Cylinder Blocks overflows when creating the disk's RDBs
>>> the user MUST be informed it is
>>
>> I'm not at all planning to create disks for AmigaDOS. I just need to
>> know what combinations of cylinders, heads and sectors are possible to
>> encounter on disks that have been created with native tools. Well,
> 
> Do we really need to add checks to those possible combinations values,
> Joanne? Cause, if we do, how do we find out?
> 
> Again, the Linux RDB parser just *reads* the RDB.
> 
> And already on the Amiga side it can happen that one partitioning tool
> does not understand the other. That Rigid Disk Block is not quite as
> rigid as the name would suggest, you already said its very flexible and
> that is not always a good thing. I have seen a Phase 5 RDB partitioning
> tool *crush* an RDB created by HDToolBox cause one calculated from 0 and
> one from zero.
> 
> I do think is neither the duty nor the responsibility of the Linux
> kernel to check for such crap.
> 
> Especially as, as I will point out further down in the mail, it is
> difficult to impossible to actually know for sure which combinations any
> of the partitioning tools on native os´s allowed.
> 
> Even if we´d find out the possible combinations of the official tools,
> there are RDB tools like RDBSalv and what not.
> 
> I´d say it is important to avoid over complicating things. We cannot
> fulfill and it is not our responsibility to save the user from any brain
> damage any partitioning tool on either native OS or Linux created
> *within* the kernel.
> 
> So I´d recommend:
> 
> - Make the calculations bail out on overflows and refuse to load the RDB
> if any calculation overflows.
> 
> - Ideally also secure AFFS this way.
> 
> - Have the warning about 64 bit disk support on native OS
> 
> and *be done with it*. For the kernel.
> 
>> assuming sufficient amounts of braindamage in the corresponding Linux
>> tools, knowing the absolute outer limits of what these tools could do
>> would be nice as well, but someone using amiga-fdisk to create a RDSK
>> block for a 10 TB disk fully deserves any punishment that invites.
> 
> If there is any warning due to using limits that exceed what HDToolBox
> (AmigaOS upto 3.1), HDToolbox using hdwrench.library (AmigaOS 3.5
> onwards), Media Toolbox using SP_engine (AmigaOS 4 onwards) as well as
> all the tools in Morphos, AROS and on AmiNet woul use, it would be up to
> amiga-fdisk and parted to issue such a warning.
> 
> As for the RDB parser, I´d go with robustness principle:
> 
> Be conservative in what you send, be liberal in what you accept.
> 
> https://en.wikipedia.org/wiki/Robustness_principle
> 
> So what ever crap or non crap any partitioning tool creates, check for
> any overflow in calculations and only refuse to accept the result in
> case there have been an overflow in calculations.
> 
> If a value is an ULONG, accept the full 32 bit unsigned integer. Cause
> if you don´t, it could mean the user is not able to access the disk with
> that RDB.
> 
> Partitioning tools however can impose any they think make sense.
> 
> As for limits with in native OS partitioning tools, for HDToolbox with
> and without hdwrench.library you probably remember, Joanne. As for Media
> Toolbox we´d have to ask AmigaOS developers. Remember AmigaOS and
> Morphos development are still closed source. So there is nothing except
> the SDKs and their Documentation which we can use to know for sure.
> 
> The latest AmigaOS 4.1 development kit appears to be version 53.30,
> found at. It is for AmigaOS 4.1 Final Edition:
> 
> https://www.hyperion-entertainment.biz/index.php/downloads?
> view=files&parent=30
> 
> (you need to click the link to arrive an an extra page and click the
> link there)
> 
> base.lha in SDK_Install contains the documentation. I was able to unpack
> it with lha x on Linux. However I have no idea where that lha command on
> my Debian GNU/Sid setup came from:
> 
> % LANG=C dpkg -S /usr/bin/lha
> dpkg-query: no path found matching pattern /usr/bin/lha
> 
> I bet there is some Linux lha downloadable somewhere, if need be I can
> dig for it.
> 
> However I used grep and find on various variations of Media Toolbox,
> SP_Engine and RDB as well as Rigid Disk Block and found nothing of
> interest for our topic.
> 
> So it appears that the workings of SP_Engine are buried in source code
> we don´t have access to. And well I won´t base any limit checking on
> assumptions. So I won´t set any additional limits than the check for
> overflowing calculations.
> 
> The AmigaOS 3.9 NDK still appears to be available on the website of my
> former employee HAAGE&PARTNER GmbH:
> 
> https://www.haage-partner.de/download/AmigaOS/NDK39.lha
> 
> This one included the hdwrench.library autodocs and releasenotes. I do
> not know whether they have something about limits. However, it does not
> appear so:
> 
>> […] NDK_3.9/Documentation% grep limit Autodocs/hdwrench.doc
>>
>>      This function is intentionally limited writing only to the lower
>>      block
> 
> This is a limit about writing the data section of a BootBlock, so
> unrelated to our topic.
> 
>> […] NDK_3.9/Documentation% grep limit
>> Releasenotes/hdwrench_lib_relnotes
> 
> Michael:
>> (Actually, I lied there. I do plan to create a RDSK block for a 2 TB
>> disk image where cylinder, head and sector counts all approach the 32
>> bit limit, just to see that my overflow checks work as intended. But
>> that's strictly for Linux testing).
> 
> I think that is a good test for the patch. I am impressed you are
> willing to put the effort for that into this work.
> 
> Okay, that is what I was able to dig out on what is officially
> available. It appears that the official developer documentation for
> AmigaOS is pretty sparse on any of that. For anything else I´d need to
> contact current AmigaOS developers. I am no longer a member of the
> AmigaOS team.
> 
> Maybe the ADF Format FAQ I mentioned has a bit more, but I did not find
> anything obvious on a short glance
> 
> http://lclevy.free.fr/adflib/adf_info.html
> 
> Also it is a third party source.
> 
>>> unsafe to put on a real Amiga. (I'd also suggest teaching Linux to
>>> understand RDSL, which would be RDSK++ sort of. Then use that if
>>> Cylinder Blocks overflows.) The value you will not be able to fill
>>> in
>>> the DosEnvec structure is:
>>>      ULONG de_HighCyl;         /* max cylinder. drive specific */
>>
>> OK, so Cylinder Blocks overflowing is a red flag, and requires to
>> abort parsing the partition table right away? And HighCyl really
>> means the max. number of logical blocks, not cylinders (which would
>> have nr_heads*nr_sects many blocks)? That's probably the cause for my
>> confusion.
> 
> When can they actually overflow? How are they calculated?
> 
> If there is no calculation to calculate it and it is just a static value
> within the RDB, I´d accept what ever the value is in the RDB, unless a
> calculation based on it overflows.
> 
> Again, keep it simple.
> 
> I think it does not make sense for the Linux kernel to try to outsmart
> the user or any of the partitioning tools out there.
> 
> The only question is:
> 
> Can the partitions be calculated in a way that it is safe to access
> them, i.e. that their calculated start and end is really at the location
> the start and end is on the disk? Then accept it.
> 
> For the file systems: Can the file system safely access this? Then
> accept. If not, then decline. *In the filesystem*. This is nothing for
> the RDB parser to check so out of scope for the discussion of this
> patch.
> 
>>> So accessing larger disks once you hit 2 TB means you must increase
>>> the logical block size. And eventually that will waste HUGE amounts
>>> of files when small files are being stored.
>>
>> Just like small inodes wastes huge amounts of space for metadata. It's
>> a tradeoff, and AFFS on a RDSK format disk probably isn't the right
>> choice for huge disks. Never mind that - if someone _does_ go that
>> way, we need to make sure we can parse the RDSK information
>> correctly. And if such a disk causes the 64 bit sector_t in Linux to
>> overflow, I'd like the parser to spot that, too.
>>
>> Thanks for your immense patience in explaining all these subtleties to
>> me.
>>
>> Cheers,
>>
>>      Michael
>>
>>> Any solution will require action on the part of the people
>>> developing
>>> AmigaDOS follow-ons. You might want to get them motivated, somehow,
>>> and proceed from there with a request to be informed of any RDB
>>> changes. I'd suggest to them that removing sensitivity to Cylinder
>>> Blocks sorts of values from the entire system probably would be
>>> painful but the simplest solution.
>>>
>>> {^_^}
> […]
> 
