Return-Path: <SRS0=IO0U=XE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E18BEC4740C
	for <linux-block@archiver.kernel.org>; Mon,  9 Sep 2019 23:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B181721479
	for <linux-block@archiver.kernel.org>; Mon,  9 Sep 2019 23:34:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730391AbfIIXe2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Sep 2019 19:34:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:44042 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728358AbfIIXe1 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 9 Sep 2019 19:34:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 789DAAD31;
        Mon,  9 Sep 2019 23:34:25 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Coly Li <colyli@suse.de>, Song Liu <songliubraving@fb.com>
Date:   Tue, 10 Sep 2019 09:34:18 +1000
Cc:     NeilBrown <neilb@suse.com>,
        "linux-block\@vger.kernel.org" <linux-block@vger.kernel.org>,
        linux-raid <linux-raid@vger.kernel.org>
Subject: Re: [PATCH] md/raid0: avoid RAID0 data corruption due to layout confusion.
In-Reply-To: <02a0d884-0a7a-63ed-2987-f5d07b93491b@cloud.ionos.com>
References: <10ca59ff-f1ba-1464-030a-0d73ff25d2de@suse.de> <87blwghhq7.fsf@notabene.neil.brown.name> <FBF1B443-64C9-472A-9F41-5303738C0DC7@fb.com> <f3c41c4b-5b1d-bd2f-ad2d-9aa5108ad798@suse.de> <9008538C-A2BE-429C-A90E-18FBB91E7B34@fb.com> <bede41a5-45c5-0ea0-25af-964bb854a94c@suse.de> <87pnkaardl.fsf@notabene.neil.brown.name> <02a0d884-0a7a-63ed-2987-f5d07b93491b@cloud.ionos.com>
Message-ID: <87d0g9avt1.fsf@notabene.neil.brown.name>
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

> On 9/9/19 8:57 AM, NeilBrown wrote:
>>=20
>> If the drives in a RAID0 are not all the same size, the array is
>> divided into zones.
>> The first zone covers all drives, to the size of the smallest.
>> The second zone covers all drives larger than the smallest, up to
>> the size of the second smallest - etc.
>>=20
>> A change in Linux 3.14 unintentionally changed the layout for the
>> second and subsequent zones.  All the correct data is still stored, but
>> each chunk may be assigned to a different device than in pre-3.14 kernel=
s.
>> This can lead to data corruption.
>>=20
>> It is not possible to determine what layout to use - it depends which
>> kernel the data was written by.
>> So we add a module parameter to allow the old (0) or new (1) layout to be
>> specified, and refused to assemble an affected array if that parameter is
>> not set.
>>=20
>> Fixes: 20d0189b1012 ("block: Introduce new bio_split()")
>> cc: stable@vger.kernel.org (3.14+)
>> Signed-off-by: NeilBrown <neilb@suse.de>
>> ---
>>=20
>> This and the next patch are my proposal for how to address
>> this problem.  I haven't actually tested .....
>>=20
>> NeilBrown
>>=20
>>   drivers/md/raid0.c | 28 +++++++++++++++++++++++++++-
>>   drivers/md/raid0.h | 14 ++++++++++++++
>>   2 files changed, 41 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/drivers/md/raid0.c b/drivers/md/raid0.c
>> index bf5cf184a260..a8888c12308a 100644
>> --- a/drivers/md/raid0.c
>> +++ b/drivers/md/raid0.c
>> @@ -19,6 +19,9 @@
>>   #include "raid0.h"
>>   #include "raid5.h"
>>=20=20=20
>> +static int default_layout =3D -1;
>> +module_param(default_layout, int, 0644);
>> +
>>   #define UNSUPPORTED_MDDEV_FLAGS		\
>>   	((1L << MD_HAS_JOURNAL) |	\
>>   	 (1L << MD_JOURNAL_CLEAN) |	\
>> @@ -139,6 +142,19 @@ static int create_strip_zones(struct mddev *mddev, =
struct r0conf **private_conf)
>>   	}
>>   	pr_debug("md/raid0:%s: FINAL %d zones\n",
>>   		 mdname(mddev), conf->nr_strip_zones);
>> +
>> +	if (conf->nr_strip_zones =3D=3D 1) {
>> +		conf->layout =3D RAID0_ORIG_LAYOUT;
>> +	} else if (default_layout =3D=3D RAID0_ORIG_LAYOUT ||
>> +		   default_layout =3D=3D RAID0_ALT_MULTIZONE_LAYOUT) {
>> +		conf->layout =3D default_layout;
>> +	} else {
>> +		pr_err("md/raid0:%s: cannot assemble multi-zone RAID0 with default_la=
yout setting\n",
>> +		       mdname(mddev));
>> +		pr_err("md/raid0: please set raid.default_layout to 0 or 1\n");
>
> Maybe "1 or 2" to align with the definition of below r0layout?

Thanks.  Fixed.

NeilBrown

>
> [snip]
>
>> +enum r0layout {
>> +	RAID0_ORIG_LAYOUT =3D 1,
>> +	RAID0_ALT_MULTIZONE_LAYOUT =3D 2,
>> +};
>>   struct r0conf {
>>   	struct strip_zone	*strip_zone;
>>   	struct md_rdev		**devlist; /* lists of rdevs, pointed to
>>   					    * by strip_zone->dev */
>>   	int			nr_strip_zones;
>> +	enum r0layout		layout;
>>   };
>>=20=20=20
>>   #endif
>>=20
>
> Thanks,
> Guoqing

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl124XsACgkQOeye3VZi
gbmsHg/+LwvIigGQj/AjztL4ht/oVXEVbzWp+k8Hzo/qgsLzQDdRCMqEYCVByUQp
RXpN7oNq7HKZj/3H0q0Ma8/Nqe9SVGWNb/DRd/JpRPFpcmaRR5sS3THWG9qbrITd
4xJGqWwcxn7lLBVIcPRsTfQCkBxcugTTh/5Dpqakf0KafZ3z3JCx6C8pMfVTFhhE
WzppVRHQZxo4/GDPFdQE+mmDhKxkttqc1hRz8ndaSDS5PH/NOXfCfrlIhWOSuxsp
vW+B+d2FqwiLgV0qA6a3oEoDnbjIOfzm7urcMAcx6HPl9uQb/zdCy6u6Py02WbJL
ILA0dhPyhV/QQR6o6xW3E2yIq0atIZzWw15ZRCxJh4oemeuAcyHOPf+51+JVqtgO
IZGTO4smFxHFOak2vCsAx7yoYmwD6iQAkG4hWQ6AAto7JWqTtOmEM2lpXMnhurXq
auTj8ut0MP74j9eh3wxvDCd/Le/AB+CROPQia2VoXZ5IQN2XUhu/ALJoPoox/SV+
58iZip+BykgsewqGwxCflWpVyaT4FOczLOPg6782zOONvPgF1GRQTnnP6q/auCbv
GgEm464jropT79F5bP7b9c6dYVEzExgvG+oNLrwbSetxyyOUbYAsbys8oM96lci8
vzgKOz5Wz0YwiPfAi5vc6j/Gz50HTDL37+ALPdqK4sO/zX9zzRs=
=ee5L
-----END PGP SIGNATURE-----
--=-=-=--
