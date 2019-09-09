Return-Path: <SRS0=IO0U=XE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8154BC4740C
	for <linux-block@archiver.kernel.org>; Mon,  9 Sep 2019 23:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CECF20863
	for <linux-block@archiver.kernel.org>; Mon,  9 Sep 2019 23:26:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388306AbfIIX0N (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Sep 2019 19:26:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:43242 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730138AbfIIX0N (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 9 Sep 2019 19:26:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CAABEAC93;
        Mon,  9 Sep 2019 23:26:10 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Coly Li <colyli@suse.de>, Song Liu <songliubraving@fb.com>
Date:   Tue, 10 Sep 2019 09:26:01 +1000
Cc:     NeilBrown <neilb@suse.com>,
        "linux-block\@vger.kernel.org" <linux-block@vger.kernel.org>,
        linux-raid <linux-raid@vger.kernel.org>
Subject: Re: [PATCH 2/2] md: add feature flag MD_FEATURE_RAID0_LAYOUT
In-Reply-To: <b68b130c-3155-22c4-d986-b80da9dc47f7@cloud.ionos.com>
References: <10ca59ff-f1ba-1464-030a-0d73ff25d2de@suse.de> <87blwghhq7.fsf@notabene.neil.brown.name> <FBF1B443-64C9-472A-9F41-5303738C0DC7@fb.com> <f3c41c4b-5b1d-bd2f-ad2d-9aa5108ad798@suse.de> <9008538C-A2BE-429C-A90E-18FBB91E7B34@fb.com> <bede41a5-45c5-0ea0-25af-964bb854a94c@suse.de> <87pnkaardl.fsf@notabene.neil.brown.name> <87lfuyarcb.fsf@notabene.neil.brown.name> <b68b130c-3155-22c4-d986-b80da9dc47f7@cloud.ionos.com>
Message-ID: <87imq1aw6u.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 09 2019, Guoqing Jiang wrote:

> Hi Neil,
>
> On 9/9/19 8:58 AM, NeilBrown wrote:
>>=20
>> Due to a bug introduced in Linux 3.14 we cannot determine the
>> correctly layout for a multi-zone RAID0 array - there are two
>> possibiities.
>
> possibilities.

Thanks.

>
>>=20
>> It is possible to tell the kernel which to chose using a module
>> parameter, but this can be clumsy to use.  It would be best if
>> the choice were recorded in the metadata.
>> So add a feature flag for this purpose.
>> If it is set, then the 'layout' field of the superblock is used
>> to determine which layout to use.
>>=20
>> If this flag is not set, then mddev->layout gets set to -1,
>> which causes the module parameter to be required.
>
> Could you point where the flag is set? Thanks.

It isn't set by the kernel - the kernel doesn't know when to set it.

We would need to change mdadm to set the flag, either when creating an
array, or when asked to be --update.

Actually.... that would be a problem if someone used the new mdadm on an
old kernel.  The old kernel would refuse to assemble the array with the
flag set.
Maybe that is what we want anyway.  We *want* people to never use
multi-zone RAID0 on old kernels, because the result could be data
corruption.

So - mdadm needs to add the flag, and maybe warn in the kernel is too
old.


>
>>=20
>> Signed-off-by: NeilBrown <neilb@suse.de>
>> ---
>>   drivers/md/md.c                | 13 +++++++++++++
>>   drivers/md/raid0.c             |  2 ++
>>   include/uapi/linux/raid/md_p.h |  2 ++
>>   3 files changed, 17 insertions(+)
>>=20
>> diff --git a/drivers/md/md.c b/drivers/md/md.c
>> index 1f70ec595282..a41fce7f8b4c 100644
>> --- a/drivers/md/md.c
>> +++ b/drivers/md/md.c
>> @@ -1232,6 +1232,8 @@ static int super_90_validate(struct mddev *mddev, =
struct md_rdev *rdev)
>>   			mddev->new_layout =3D mddev->layout;
>>   			mddev->new_chunk_sectors =3D mddev->chunk_sectors;
>>   		}
>> +		if (mddev->level =3D=3D 0)
>> +			mddev->layout =3D -1;
>>=20=20=20
>>   		if (sb->state & (1<<MD_SB_CLEAN))
>>   			mddev->recovery_cp =3D MaxSector;
>> @@ -1647,6 +1649,10 @@ static int super_1_load(struct md_rdev *rdev, str=
uct md_rdev *refdev, int minor_
>>   		rdev->ppl.sector =3D rdev->sb_start + rdev->ppl.offset;
>>   	}
>>=20=20=20
>> +	if ((le32_to_cpu(sb->feature_map) & MD_FEATURE_RAID0_LAYOUT) &&
>> +	    sb->level !=3D 0)
>> +		return -EINVAL;
>> +
>>   	if (!refdev) {
>>   		ret =3D 1;
>>   	} else {
>> @@ -1757,6 +1763,10 @@ static int super_1_validate(struct mddev *mddev, =
struct md_rdev *rdev)
>>   			mddev->new_chunk_sectors =3D mddev->chunk_sectors;
>>   		}
>>=20=20=20
>> +		if (mddev->level =3D=3D 0 &&
>> +		    !(le32_to_cpu(sb->feature_map) & MD_FEATURE_RAID0_LAYOUT))
>> +			mddev->layout =3D -1;
>> +
>>   		if (le32_to_cpu(sb->feature_map) & MD_FEATURE_JOURNAL)
>>   			set_bit(MD_HAS_JOURNAL, &mddev->flags);
>>=20=20=20
>> @@ -6852,6 +6862,9 @@ static int set_array_info(struct mddev *mddev, mdu=
_array_info_t *info)
>>   	mddev->external	     =3D 0;
>>=20=20=20
>>   	mddev->layout        =3D info->layout;
>> +	if (mddev->level =3D=3D 0)
>> +		/* Cannot trust RAID0 layout info here */
>> +		mddev->layout =3D -1;
>>   	mddev->chunk_sectors =3D info->chunk_size >> 9;
>>=20=20=20
>>   	if (mddev->persistent) {
>> diff --git a/drivers/md/raid0.c b/drivers/md/raid0.c
>> index a8888c12308a..6f095b0b6f5c 100644
>> --- a/drivers/md/raid0.c
>> +++ b/drivers/md/raid0.c
>> @@ -145,6 +145,8 @@ static int create_strip_zones(struct mddev *mddev, s=
truct r0conf **private_conf)
>>=20=20=20
>>   	if (conf->nr_strip_zones =3D=3D 1) {
>>   		conf->layout =3D RAID0_ORIG_LAYOUT;
>> +	} else if (mddev->layout =3D=3D RAID0_ORIG_LAYOUT ||
>> +		   mddev->layout =3D=3D RAID0_ALT_MULTIZONE_LAYOUT) {
>
> Maybe "conf->layout =3D mddev->layout" here? Otherwise seems conf->layout=
 is not set accordingly, just=20
> my 2 cents.
>

Yes, of course.  thanks.

Thanks for your review,
NeilBrown


>>   	} else if (default_layout =3D=3D RAID0_ORIG_LAYOUT ||
>>   		   default_layout =3D=3D RAID0_ALT_MULTIZONE_LAYOUT) {
>>   		conf->layout =3D default_layout;
>> diff --git a/include/uapi/linux/raid/md_p.h b/include/uapi/linux/raid/md=
_p.h
>> index b0d15c73f6d7..1f2d8c81f0e0 100644
>> --- a/include/uapi/linux/raid/md_p.h
>> +++ b/include/uapi/linux/raid/md_p.h
>> @@ -329,6 +329,7 @@ struct mdp_superblock_1 {
>>   #define	MD_FEATURE_JOURNAL		512 /* support write cache */
>>   #define	MD_FEATURE_PPL			1024 /* support PPL */
>>   #define	MD_FEATURE_MULTIPLE_PPLS	2048 /* support for multiple PPLs */
>> +#define	MD_FEATURE_RAID0_LAYOUT		4096 /* layout is meaningful for RAID0=
 */
>>   #define	MD_FEATURE_ALL			(MD_FEATURE_BITMAP_OFFSET	\
>>   					|MD_FEATURE_RECOVERY_OFFSET	\
>>   					|MD_FEATURE_RESHAPE_ACTIVE	\
>> @@ -341,6 +342,7 @@ struct mdp_superblock_1 {
>>   					|MD_FEATURE_JOURNAL		\
>>   					|MD_FEATURE_PPL			\
>>   					|MD_FEATURE_MULTIPLE_PPLS	\
>> +					|MD_FEATURE_RAID0_LAYOUT	\
>>   					)
>>=20=20=20
>>   struct r5l_payload_header {
>>=20
>
> Thanks,
> Guoqing

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl1234kACgkQOeye3VZi
gbko6Q//ZMHhEKX6nr9Yd8xh94QpAe7W6m+lzrUlGQgD+7QdFeCFTbX616ZCJ9m9
uajpbNfLaF/6MscQE40w9iIboK7b9UUOR+7O3rE8/NxivrKO6LHZ4MKutGA2fUtr
5RCGkBrz4JM2G4ZkLeHVlmMYyKkl1PBRZg7MP78GUNaXV8y544HskLx2hbsVM71A
LgvNw77ZGjR5ZCqO00Aq6sa3fjpPkPb133Fl0ak/aiISEFBl56ypGQwIqQ3zTRIy
QeeT7nsZX1JG2rquCMguhQlarr4apXgu3QA5+Ga1Qr71fo7Ba4hBXvAsIAiQWVLf
KZPZ3AW1uxXcgfmpUo4yA0FQlgzinyhCoXT7kkeDDxMFGd1u+Xr3ubaJeq7aPYtk
H7kdUzQ6ng38rl4Lcsv5FZqJDfcJju0jEC4wGVxchPptbh/ULrALK0FzHV2mIzOh
Wc23Kopv8RXtN85HFR3LxW/LveYH7FcVn5TB01z7PIdURP9PBQ/va8jCbTE8Nawf
BNq1P2aj2QM5AlFBZ0icXvGVBTiv2+3NBo4nvTIMX9Vux2y7gVDgOGAbroOVwjBo
MNle29VTkOn4o1MfKg579zzMu8XrmI73MGQYjMA2g2IB5O2z5Br9r1ALXmAYiNTy
Vo+YLNKNDs6VCZB9wcUgJl03OTNkF5mtZz0vurFvYDmrZ/DA4Q0=
=HRNL
-----END PGP SIGNATURE-----
--=-=-=--
