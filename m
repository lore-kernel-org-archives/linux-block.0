Return-Path: <SRS0=ntoj=XG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C787DC49ED6
	for <linux-block@archiver.kernel.org>; Wed, 11 Sep 2019 22:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1F3E20CC7
	for <linux-block@archiver.kernel.org>; Wed, 11 Sep 2019 22:49:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbfIKWs7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Sep 2019 18:48:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:47546 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726761AbfIKWs7 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Sep 2019 18:48:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4797EABBE;
        Wed, 11 Sep 2019 22:48:57 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Song Liu <liu.song.a23@gmail.com>
Date:   Thu, 12 Sep 2019 08:48:41 +1000
Cc:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Song Liu <songliubraving@fb.com>,
        Guoqing Jiang <jgq516@gmail.com>, Coly Li <colyli@suse.de>,
        NeilBrown <neilb@suse.com>,
        "linux-block\@vger.kernel.org" <linux-block@vger.kernel.org>,
        linux-raid <linux-raid@vger.kernel.org>
Subject: Re: [PATCH] md/raid0: avoid RAID0 data corruption due to layout confusion.
In-Reply-To: <CAPhsuW6obHkwKdYU=dt2x0t4kPK=eMfXO6S3a79i4PnMgskcqg@mail.gmail.com>
References: <10ca59ff-f1ba-1464-030a-0d73ff25d2de@suse.de> <87blwghhq7.fsf@notabene.neil.brown.name> <FBF1B443-64C9-472A-9F41-5303738C0DC7@fb.com> <f3c41c4b-5b1d-bd2f-ad2d-9aa5108ad798@suse.de> <9008538C-A2BE-429C-A90E-18FBB91E7B34@fb.com> <bede41a5-45c5-0ea0-25af-964bb854a94c@suse.de> <87pnkaardl.fsf@notabene.neil.brown.name> <242E3FBD-C969-44E1-8DC7-BFE9E7CBE7FD@fb.com> <87ftl5avtx.fsf@notabene.neil.brown.name> <33AD3B45-E20D-4019-91FA-CA90B9B3C3A9@fb.com> <58722139-ebc0-f49f-424a-c3b1aa455dd8@cloud.ionos.com> <877e6fbvh2.fsf@notabene.neil.brown.name> <CAPhsuW6obHkwKdYU=dt2x0t4kPK=eMfXO6S3a79i4PnMgskcqg@mail.gmail.com>
Message-ID: <874l1ibgae.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

--=-=-=
Content-Type: text/plain

On Wed, Sep 11 2019, Song Liu wrote:

> On Wed, Sep 11, 2019 at 12:10 AM NeilBrown <neilb@suse.de> wrote:
>>
>> On Tue, Sep 10 2019, Guoqing Jiang wrote:
>>
>> > On 9/10/19 5:45 PM, Song Liu wrote:
>> >>
>> >>
>> >>> On Sep 10, 2019, at 12:33 AM, NeilBrown <neilb@suse.de> wrote:
>> >>>
>> >>> On Mon, Sep 09 2019, Song Liu wrote:
>> >>>
>> >>>> Hi Neil,
>> >>>>
>> >>>>> On Sep 9, 2019, at 7:57 AM, NeilBrown <neilb@suse.de> wrote:
>> >>>>>
>> >>>>>
>> >>>>> If the drives in a RAID0 are not all the same size, the array is
>> >>>>> divided into zones.
>> >>>>> The first zone covers all drives, to the size of the smallest.
>> >>>>> The second zone covers all drives larger than the smallest, up to
>> >>>>> the size of the second smallest - etc.
>> >>>>>
>> >>>>> A change in Linux 3.14 unintentionally changed the layout for the
>> >>>>> second and subsequent zones.  All the correct data is still stored, but
>> >>>>> each chunk may be assigned to a different device than in pre-3.14 kernels.
>> >>>>> This can lead to data corruption.
>> >>>>>
>> >>>>> It is not possible to determine what layout to use - it depends which
>> >>>>> kernel the data was written by.
>> >>>>> So we add a module parameter to allow the old (0) or new (1) layout to be
>> >>>>> specified, and refused to assemble an affected array if that parameter is
>> >>>>> not set.
>> >>>>>
>> >>>>> Fixes: 20d0189b1012 ("block: Introduce new bio_split()")
>> >>>>> cc: stable@vger.kernel.org (3.14+)
>> >>>>> Signed-off-by: NeilBrown <neilb@suse.de>
>> >>>>
>> >>>> Thanks for the patches. They look great. However, I am having problem
>> >>>> apply them (not sure whether it is a problem on my side). Could you
>> >>>> please push it somewhere so I can use cherry-pick instead?
>> >>>
>> >>> I rebased them on block/for-next, fixed the problems that Guoqing found,
>> >>> and pushed them to
>> >>>   https://github.com/neilbrown/linux md/raid0
>> >>>
>> >>> NeilBrown
>> >>
>> >> Thanks Neil!
>> >
>> > Thanks for the explanation about set the flag.
>> >
>> >>
>> >> Guoqing, if this looks good, please reply with your Reviewed-by
>> >> or Acked-by.
>> >
>> > No more comments from my side, but I am not sure if it is better/possible to use one
>> > sysfs node to control the behavior instead of module parameter, then we can support
>> > different raid0 layout dynamically.
>>
>> A strength of module parameters is that you can set them in
>>   /etc/modprobe.d/00-local.conf
>> and then they are automatically set on boot.
>> For sysfs, you need some tool to set them.
>>
>> >
>> > Anyway, Acked-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
>> >
>
> I am adding the following change to the 1/2. Please let me know if it doesn't
> make sense.

I don't object, through with the current code it is impossible for that
warning to fire.
Code might change in the future though, and it's better to be safe than
sorry.

Thanks,
NeilBrown

>
> Thanks,
> Song
>
> diff --git i/drivers/md/raid0.c w/drivers/md/raid0.c
> index a9fcff50bbfc..54d0064787a8 100644
> --- i/drivers/md/raid0.c
> +++ w/drivers/md/raid0.c
> @@ -615,6 +615,10 @@ static bool raid0_make_request(struct mddev
> *mddev, struct bio *bio)
>         case RAID0_ALT_MULTIZONE_LAYOUT:
>                 tmp_dev = map_sector(mddev, zone, sector, &sector);
>                 break;
> +       default:
> +               WARN("md/raid0:%s: Invalid layout\n", mdname(mddev));
> +               bio_io_error(bio);
> +               return true;
>         }
>
>         if (unlikely(is_mddev_broken(tmp_dev, "raid0"))) {

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl15ecoACgkQOeye3VZi
gblNbBAApwgTJAdRntP2iwLSl/clM+7wOdmLaNH0udoQNSA2JvSCXr/Hum4m8+4K
wldnD48axnqW484k0yDvR3ibQYkmokavlPOIdsQa6TOOV2Vp900oAe1GDRRMhK5+
Y4qsV9+UEzzJA7acQKn44EBlNPV2CACfvcUvxCVfefF36mBWg+4gRqNRlhArQxk4
WoP522COQ9rceUe0z1igo0JHtRkZIcu7b3Nr8yrPQQhf5Gcx5db1xbXqq6OKR3I1
6yeog+rWgVkHiF9s0y10+jajrx2O5z1fNEd2tvB+RP7h8p59G/NJJhgEGWS3rI2r
bueIMPUU2rVXlajQTGsS3EAbLuAv6HrcgKO4t8tzMfcS0oNixYp9CXq9aKxzxH/P
LnB3EzI6M5uaClkefw4Q37Io1G8VBOrCmrg62Az6POs5ZDLpqf9khJXmpw4lwwVG
vUfuE8J52IgJI16rIS5fgzA9OsBykRvxJiqt/5yXKqZnG3G/8zRn7lE8Rpz8SwWD
IX5A/6s6N2hpBHX1jM1ytRRn6DLfC6l3CQyv/+GPl6qpNy9g58rT2I01HfdIixPC
LjV2famMlvJt4NlhOsJzs05jvyyP8eVmwt1UtFUTnEyAdfYusMG2CREC78fj78Yi
o7uJ9FVdqA6hCBLEJaycEKvonuw3GpfnsqiZrSzjMH6ViaZf61U=
=ijDV
-----END PGP SIGNATURE-----
--=-=-=--
