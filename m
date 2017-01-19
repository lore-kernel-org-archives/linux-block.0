Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:33509 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751775AbdASC4n (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Jan 2017 21:56:43 -0500
From: Slava Dubeyko <Vyacheslav.Dubeyko@wdc.com>
To: Jeff Moyer <jmoyer@redhat.com>
CC: Jan Kara <jack@suse.cz>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@ml01.01.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        "Linux FS Devel" <linux-fsdevel@vger.kernel.org>,
        "lsf-pc@lists.linux-foundation.org"
        <lsf-pc@lists.linux-foundation.org>
Subject: RE: [Lsf-pc] [LSF/MM TOPIC] Badblocks checking/representation in
 filesystems
Date: Thu, 19 Jan 2017 02:56:39 +0000
Message-ID: <SN2PR04MB21916B138434803EA9AF4C18887E0@SN2PR04MB2191.namprd04.prod.outlook.com>
References: <at1mp6pou4lenesjdgh22k4p.1484345585589@email.android.com>
        <b9rbflutjt10mb4ofherta8j.1484345610771@email.android.com>
        <SN2PR04MB2191756EABCB0E9DAA3B5328887B0@SN2PR04MB2191.namprd04.prod.outlook.com>
        <20170114004910.GA4880@omniknight.lm.intel.com>
        <SN2PR04MB2191A6EDB7203AF86600FD25887D0@SN2PR04MB2191.namprd04.prod.outlook.com>
        <20170117143703.GP2517@quack2.suse.cz>
        <SN2PR04MB219128E4C8C4FD4AF3452C7C887C0@SN2PR04MB2191.namprd04.prod.outlook.com>
 <x49mveo6qom.fsf@segfault.boston.devel.redhat.com>
In-Reply-To: <x49mveo6qom.fsf@segfault.boston.devel.redhat.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


-----Original Message-----
From: Jeff Moyer [mailto:jmoyer@redhat.com]=20
Sent: Wednesday, January 18, 2017 12:48 PM
To: Slava Dubeyko <Vyacheslav.Dubeyko@wdc.com>
Cc: Jan Kara <jack@suse.cz>; linux-nvdimm@lists.01.org <linux-nvdimm@ml01.0=
1.org>; linux-block@vger.kernel.org; Viacheslav Dubeyko <slava@dubeyko.com>=
; Linux FS Devel <linux-fsdevel@vger.kernel.org>; lsf-pc@lists.linux-founda=
tion.org
Subject: Re: [Lsf-pc] [LSF/MM TOPIC] Badblocks checking/representation in f=
ilesystems

>>> Well, the situation with NVM is more like with DRAM AFAIU. It is=20
>>> quite reliable but given the size the probability *some* cell has degra=
ded is quite high.
>>> And similar to DRAM you'll get MCE (Machine Check Exception) when you=20
>>> try to read such cell. As Vishal wrote, the hardware does some=20
>>> background scrubbing and relocates stuff early if needed but nothing is=
 100%.
>>
>> My understanding that hardware does the remapping the affected address=20
>> range (64 bytes, for example) but it doesn't move/migrate the stored=20
>> data in this address range. So, it sounds slightly weird. Because it=20
>> means that no guarantee to retrieve the stored data. It sounds that=20
>> file system should be aware about this and has to be heavily protected=20
>> by some replication or erasure coding scheme. Otherwise, if the=20
>> hardware does everything for us (remap the affected address region and=20
>> move data into a new address region) then why does file system need to=20
>> know about the affected address regions?
>
>The data is lost, that's why you're getting an ECC.  It's tantamount to -E=
IO for a disk block access.

I see the three possible cases here:
(1) bad block has been discovered (no remap, no recovering) -> data is lost=
; -EIO for a disk block access, block is always bad;
(2) bad block has been discovered and remapped -> data is lost; -EIO for a =
disk block access.
(3) bad block has been discovered, remapped and recovered -> no data is los=
t.

>> Let's imagine that the affected address range will equal to 64 bytes.=20
>> It sounds for me that for the case of block device it will affect the=20
>> whole logical block (4 KB).
>
> 512 bytes, and yes, that's the granularity at which we track errors in th=
e block layer, so that's the minimum amount of data you lose.

I think it depends what granularity hardware supports. It could be 512 byte=
s, 4 KB, maybe greater.

>> The situation is more critical for the case of DAX approach. Correct=20
>> me if I wrong but my understanding is the goal of DAX is to provide=20
>> the direct access to file's memory pages with minimal file system=20
>> overhead. So, it looks like that raising bad block issue on file=20
>> system level will affect a user-space application. Because, finally,=20
>> user-space application will need to process such trouble (bad block=20
>> issue). It sounds for me as really weird situation. What can protect a=20
>> user-space application from encountering the issue with partially=20
>> incorrect memory page?
>
> Applications need to deal with -EIO today.  This is the same sort of thin=
g.
> If an application trips over a bad block during a load from persistent me=
mory,
> they will get a signal, and they can either handle it or not.
>
> Have a read through this specification and see if it clears anything up f=
or you:
>  http://www.snia.org/tech_activities/standards/curr_standards/npm

Thank you for sharing this. So, if a user-space application follows to the
NVM Programming Model then it will be able to survive by means of catching
and processing the exceptions. But these applications have to be implemente=
d yet.
Also such applications need in special technique(s) of recovering. It sound=
s
that legacy user-space applications are unable to survive for the NVM.PM.FI=
LE mode
in the case of load/store operation's failure.

Thanks,
Vyacheslav Dubeyko.

