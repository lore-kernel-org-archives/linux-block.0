Return-Path: <decui@microsoft.com>
From: Dexuan Cui <decui@microsoft.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>, Ming Lei <tom.leiming@gmail.com>
CC: Keith Busch <keith.busch@intel.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, Linux Kernel Mailing List
	<linux-kernel@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>, Dan Williams
	<dan.j.williams@intel.com>, "Martin K. Petersen"
	<martin.petersen@oracle.com>, Sagi Grimberg <sagig@mellanox.com>, Long Li
	<longli@microsoft.com>, Mike Snitzer <snitzer@redhat.com>, KY Srinivasan
	<kys@microsoft.com>, Cathy Avery <cavery@redhat.com>
Subject: RE: [PATCH RFC] block: fix bio merge checks when virt_boundary is set
Date: Thu, 15 Dec 2016 14:03:36 +0000
Message-ID: <MWHPR03MB266949004D8BB804718A0258BF9D0@MWHPR03MB2669.namprd03.prod.outlook.com>
References: <1458055076-2175-1-git-send-email-vkuznets@redhat.com>
	<CACVXFVMs-fOaNVUyedg66T83MiOc7a+op3LeHVt6ogVBQnYdeQ@mail.gmail.com>
	<87oaae4cej.fsf@vitty.brq.redhat.com>
	<20160316223804.GA6217@localhost.lm.intel.com>
	<87egb94agz.fsf@vitty.brq.redhat.com>
	<20160317163946.GC6217@localhost.lm.intel.com>
	<CACVXFVNrHJcNxcm3+ieOM8f3GzKtTgu38HndWd19ehVDZBev_g@mail.gmail.com>
	<CACVXFVO37O2Yp60E82U_YWCe2yUqsEn1ojMb6kpTDmhBk94dQA@mail.gmail.com>
 <87shyg1jdx.fsf@vitty.brq.redhat.com>
In-Reply-To: <87shyg1jdx.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

> From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-
> owner@vger.kernel.org] On Behalf Of Vitaly Kuznetsov
> Sent: Wednesday, April 20, 2016 21:48
> To: Ming Lei <tom.leiming@gmail.com>
> Cc: Keith Busch <keith.busch@intel.com>; linux-block@vger.kernel.org; Lin=
ux
> Kernel Mailing List <linux-kernel@vger.kernel.org>; Jens Axboe
> <axboe@kernel.dk>; Dan Williams <dan.j.williams@intel.com>; Martin K.
> Petersen <martin.petersen@oracle.com>; Sagi Grimberg
> <sagig@mellanox.com>; Mike Snitzer <snitzer@redhat.com>; KY Srinivasan
> <kys@microsoft.com>; Cathy Avery <cavery@redhat.com>
> Subject: Re: [PATCH RFC] block: fix bio merge checks when virt_boundary i=
s set
>=20
> Ming Lei <tom.leiming@gmail.com> writes:
>=20
> > On Fri, Mar 18, 2016 at 10:59 AM, Ming Lei <tom.leiming@gmail.com> wrot=
e:
> >> On Fri, Mar 18, 2016 at 12:39 AM, Keith Busch <keith.busch@intel.com>
> wrote:
> >>> On Thu, Mar 17, 2016 at 12:20:28PM +0100, Vitaly Kuznetsov wrote:
> >>>> Keith Busch <keith.busch@intel.com> writes:
> >>>> > been combined. In any case, I think you can get what you're after =
just
> >>>> > by moving the gap check after BIOVEC_PHYS_MERGABLE. Does the
> following
> >>>> > look ok to you?
> >>>> >
> >>>>
> >>>> Thanks, it does.
> >>>
> >>> Cool, thanks for confirming.
> >>>
> >>>> Will you send it or would you like me to do that with your Suggested=
-by?
> >>>
> >>> I'm not confident yet this doesn't break anything, particularly since
> >>> we moved the gap check after the length check. Just wanted to confirm
> >>> the concept addressed your concern, but still need to take a closer l=
ook
> >>> and test before submitting.
> >>
> >> IMO, the change on blk_bio_segment_split() is correct, because actuall=
y it
> >> is a sg gap and the check should have been done between segments
> >> instead of bvecs. So it is reasonable to move the check just before po=
pulating
> >> a new segment.
> >
> > Thinking of the 1st part change further, looks it is just correct in co=
ncept,
> > but wrong from current implementation. Because of bios/reqs merge,
> > blk_rq_map_sg() may end one segment in any bvec in theroy, so I guess
> > that is why each non-1st bvec need the check to make sure no sg gap.
> > Looks a very crazy limit, :-)
> >
> >>
> >> But for the 2nd change in bio_will_gap(), which should fix Vitaly's pr=
oblem, I
> >> am still not sure if it is completely correct. bio_will_gap() is used
> >> to check if two
> >> bios may be merged. Suppose two bios are continues physically, the las=
t bvec
> >> in 1st bio and the first bvec in 2nd bio might not be in one same segm=
ent
> >> because of segment size limit.
> >
> > How about the attached patch?
> >
>=20
> I just wanted to revive the discussion as the issue persists. I
> re-tested your patch against 4.6-rc4 and it efficiently solves the
> issue.
>=20
> pre-patch:
> # time mkfs.ntfs /dev/sdb1
> Cluster size has been automatically set to 4096 bytes.
> Initializing device with zeroes: 100% - Done.
> Creating NTFS volume structures.
> mkntfs completed successfully. Have a nice day.
>=20
> real8m10.977s
> user0m0.115s
> sys0m12.672s
>=20
> post-patch:
> # time mkfs.ntfs /dev/sdb1
> Cluster size has been automatically set to 4096 bytes.
> Initializing device with zeroes: 100% - Done.
> Creating NTFS volume structures.
> mkntfs completed successfully. Have a nice day.
>=20
> real0m42.430s
> user0m0.171s
> sys0m7.675s
>=20
> Will you send this patch? Please let me know if I can further
> assist. Thanks!
>=20
> --
>   Vitaly

Hi, I'm reviving the thread because I'm suffering from exactly the same iss=
ue.
This is the thread I created today:=20
"Big I/O requests are split into small ones due to unaligned ext4 partition=
 boundary?"
http://marc.info/?t=3D148180346100002&r=3D1&w=3D2

Ming's patch can fix this issue for me.=20

Stable 4.4 and later are affected too.
I didn't check 4.3.x kernels, but for Linux guest on Hyper-V, any kernel wi=
th the
patch "storvsc: get rid of bounce buffer"
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=
=3D81988a0e6b031bc80da15257201810ddcf989e64
should be affected.

Thanks,
-- Dexuan
