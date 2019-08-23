Return-Path: <SRS0=MRnn=WT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02087C3A5A1
	for <linux-block@archiver.kernel.org>; Fri, 23 Aug 2019 00:02:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6B70233FD
	for <linux-block@archiver.kernel.org>; Fri, 23 Aug 2019 00:02:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbfHWACV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Aug 2019 20:02:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:54230 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727368AbfHWACU (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Aug 2019 20:02:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DA810AF7A;
        Fri, 23 Aug 2019 00:02:18 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Coly Li <colyli@suse.de>, Song Liu <songliubraving@fb.com>,
        linux-raid@vger.kernel.org
Date:   Fri, 23 Aug 2019 10:02:08 +1000
Cc:     "linux-block\@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [RFC] How to handle an ugly md raid0 sector map bug ?
In-Reply-To: <10ca59ff-f1ba-1464-030a-0d73ff25d2de@suse.de>
References: <10ca59ff-f1ba-1464-030a-0d73ff25d2de@suse.de>
Message-ID: <87blwghhq7.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

--=-=-=
Content-Type: text/plain

On Thu, Aug 22 2019, Coly Li wrote:

> Hi folks,
>
> First line: This bug only influences md raid0 device which applies all
> the following conditions,
> 1) Assembled by component disks with different sizes.
> 2) Created and used under Linux kernel before (including) Linux v3.12,
> then upgrade to Linux kernel after (including) Linux v3.13.
> 3) New data are written to md raid0 in new kernel >= Linux v3.13.
> Then the md raid0 may have inconsistent sector mapping and experience
> data corruption.
>
> Recently I receive a bug report that customer encounter file system
> corruption after upgrading their kernel from Linux 3.12 to 4.4. It turns
> out to be the underlying md raid0 corruption after the kernel upgrade.
>
> I find it is because a sector map bug in md raid0 code include and
> before Linux v3.12. Here is the buggy code piece I copied from stable
> Linux v3.12.74 drivers/md/raid0.c:raid0_make_request(),
>
> 547         sector_offset = bio->bi_sector;
> 548         zone = find_zone(mddev->private, &sector_offset);
> 549         tmp_dev = map_sector(mddev, zone, bio->bi_sector,
> 550                              &sector_offset);

I don't think this code is buggy.  The mapping may not be the mapping
you would expect, but it is the mapping that md/raid0 had always used up
to this time.

>
> At line 548 after find_zone() returns, sector_offset is updated to be an
> offset inside current zone. Then at line 549 the third parameter of
> calling map_sector() should be the updated sector_offset, but
> bio->bi_sector (original LBA or md raid0 device) is used. If the raid0
> device has *multiple zones*, except the first zone, the mapping <dev,
> sector> pair returned by map_sector() for all rested zones are
> unexpected and wrong.
>
> The buggy code was introduced since Linux v2.6.31 in commit fbb704efb784
> ("md: raid0 :Enables chunk size other than powers of 2."), unfortunate
> the mistaken mapping calculation has stable and unique result too, so it
> works without obvious problem until commit 20d0189b1012 ("block:
> Introduce new bio_split()") merged into Linux v3.13.
>
> This patch fixed the mistaken mapping in the following lines of change,
> 654 -       sector_offset = bio->bi_iter.bi_sector;
> 655 -       zone = find_zone(mddev->private, &sector_offset);
> 656 -       tmp_dev = map_sector(mddev, zone, bio->bi_iter.bi_sector,
> 657 -                            &sector_offset);
>
> 694 +               zone = find_zone(mddev->private, &sector);
> 695 +               tmp_dev = map_sector(mddev, zone, sector, &sector);
> At line 695 of this patch, the third parameter of calling map_sector()
> is fixed to 'sector', this is the correct value which contains the
> sector offset inside the corresponding zone.

This is buggy because, as you say, the third argument to map_sector has
changed.
Previously it was bio->bi_iter.bi_sector.  Now it is 'sector' which
find_zone has just modified.

>
> The this patch implicitly *changes* md raid0 on-disk layout. If a md
> raid0 has component disks with *different* sizes, then it will contain
> multiple zones. If such multiple zones raid0 device is created before
> Linux v3.13, all data chunks after first zone will be mapped to
> different location in kernel after (including) Linux v3.13. The result
> is, data written in the LBA after first zone will be treated as
> corruption. A worse case is, if the md raid0 has data chunks filled in
> first md raid0 zone in Linux v3.12 (or earlier kernels), then update to
> Linux v3.13 (or later kernels) and fill more data chunks in second and
> rested zone. Then in neither Linux v3.12 no Linux v3.13, there is always
> partial data corrupted.
>
> Currently there is no way to tell whether a md raid0 device is mapped in
> wrong calculation in kernel before (including) Linux v3.12 or in correct
> calculation in kernels after (including) Linux v3.13. If a md raid0
> device (contains multiple zones) created and used crossing these kernel
> version, there is possibility and different mapping calculation
> generation different/inconsistent on-disk layout in different md raid0
> zones, and results data corruption.
>
> For our enterprise Linux products we can handle it properly for a few
> product number of kernels. But for upstream and stable kernels, I don't
> have idea how to fix this ugly problem in a generic way.
>
> Neil Brown discussed with me offline, he proposed a temporary workaround
> that only permit to assemble md raid0 device with identical component
> disk size, and reject to assemble md raid0 device with component disks
> with different sizes. We can stop this workaround when there is a proper
> way to fix the problem.
>
> I suggest our developer community to work together for a solution, this
> is the motivation I post this email for your comments.

There are four separate cases that we need to consider:
 - v1.x metadata
 - v0.90 metadata
 - LVM metadata (via dm-raid)
 - no metadata (array created with "mdadm --build").

For v1.x metadata, I think we can add a new "feature_map" flag.
If this flag isn't set, raid0 with non-uniform device sizes will not be
assembled.
If it is set, then:
  if 'layout' is 0, use the old mapping
  if 'layout' is 1, use the new mapping

For v0.90 metadata we don't have feature-flags.  We could
The gvalid_words field is unused and always set to zero.
So we could start storing some feature bits there.

For LVM/dm-raid, I suspect it doesn't support varying
sized devices, but we would need to check.

For "no metadata" arrays ... we could possibly just stop supporting
them - I doubt they are used much.

Once this is decided, we then need to work out how to
make it all usable via mdadm.

mdadm needs to set the relevant flags and 'layout' values
when creating an array, and it needs to be able to set them correctly
on an existing array that doesn't have them set.

We also need to decide what happens when a new mdadm is run on an old
kernel.
If we create an array with a new feature bit, the old kernel won't
be able to assemble it.  But if we don't set the feature bit, then
the array will not assemble after an upgrade.

It might be easier to think about this when we actually have concrete
code, but if anyone does have useful input, I'd be very happy to read
it.

NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl1fLQEACgkQOeye3VZi
gbkbQA/+MQf6IQlxzmyR0AuCdPUOQdrBsjiArZqH2ZH8ps0OpcmxpmhIWzCZ0slO
Zfx9JeeYNyAJymEgNKlutoUn1sjs03AMCVU0AWKtgcuC15478YM/Rr6UOAOkwvLR
vaslIUvz2TiFujEWBjGxX2FxmBktlptmXkN7YWcTGS7IUzMA5INgP8AmfT1F63kY
vSw8OOf0u32zf8d6XTSPWD6tnMANYtNUXw2+4byKxELXf7OJjvXjSkFIZEUDplNQ
iMDKBSyFvDvHdfqrxc0jgYkVBj7Qw/+Oibj5VrgMm3Q2szQH7Yrlu9r2P9PIjQa2
cYek6GNJKIP2MDzsxV9TCo31f3X7TofkVfB509okWpyD5tDI0nkBV28q6hQ0g/h6
a+SqjavBe3y6qp+JopZcKdpMvFJWRKwSCaCvbtcGNPFWMbHpC2sTpcqCLDFAPqrJ
figs9vCgsncas1PdWYFEe1ZRXocEvdvVt4+q42+zovI6kNpRvSp0GkYK6IDM2gl0
VIkLLE03UQOJhTDlVesworJolgOSLUdjViijxoGmoyJDHY4Kgy5LuoKNQzaYi/cj
yd0zCDDlXtOOgqbIf8utNkIfos8FZtT2A6tiRYg/mgnXphzHZIUEJdwcR1K8hilZ
FSRUAhj5a9gJtIHHv2O41o1FdfFRRHXEWBseKGX4ebmBPx6Ym4Q=
=mepx
-----END PGP SIGNATURE-----
--=-=-=--
