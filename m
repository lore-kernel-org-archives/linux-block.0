Return-Path: <SRS0=IO0U=XE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64954C00307
	for <linux-block@archiver.kernel.org>; Mon,  9 Sep 2019 06:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C62821479
	for <linux-block@archiver.kernel.org>; Mon,  9 Sep 2019 06:57:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730980AbfIIG5x (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Sep 2019 02:57:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:53024 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727385AbfIIG5x (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 9 Sep 2019 02:57:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4E11DAF3E;
        Mon,  9 Sep 2019 06:57:51 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Coly Li <colyli@suse.de>, Song Liu <songliubraving@fb.com>
Date:   Mon, 09 Sep 2019 16:57:42 +1000
Cc:     NeilBrown <neilb@suse.com>,
        "linux-block\@vger.kernel.org" <linux-block@vger.kernel.org>,
        linux-raid <linux-raid@vger.kernel.org>
Subject: [PATCH] md/raid0: avoid RAID0 data corruption due to layout
 confusion.
In-Reply-To: <bede41a5-45c5-0ea0-25af-964bb854a94c@suse.de>
References: <10ca59ff-f1ba-1464-030a-0d73ff25d2de@suse.de> <87blwghhq7.fsf@notabene.neil.brown.name> <FBF1B443-64C9-472A-9F41-5303738C0DC7@fb.com> <f3c41c4b-5b1d-bd2f-ad2d-9aa5108ad798@suse.de> <9008538C-A2BE-429C-A90E-18FBB91E7B34@fb.com> <bede41a5-45c5-0ea0-25af-964bb854a94c@suse.de>
Message-ID: <87pnkaardl.fsf@notabene.neil.brown.name>
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


If the drives in a RAID0 are not all the same size, the array is
divided into zones.
The first zone covers all drives, to the size of the smallest.
The second zone covers all drives larger than the smallest, up to
the size of the second smallest - etc.

A change in Linux 3.14 unintentionally changed the layout for the
second and subsequent zones.  All the correct data is still stored, but
each chunk may be assigned to a different device than in pre-3.14 kernels.
This can lead to data corruption.

It is not possible to determine what layout to use - it depends which
kernel the data was written by.
So we add a module parameter to allow the old (0) or new (1) layout to be
specified, and refused to assemble an affected array if that parameter is
not set.

Fixes: 20d0189b1012 ("block: Introduce new bio_split()")
cc: stable@vger.kernel.org (3.14+)
Signed-off-by: NeilBrown <neilb@suse.de>
=2D--

This and the next patch are my proposal for how to address
this problem.  I haven't actually tested .....

NeilBrown

 drivers/md/raid0.c | 28 +++++++++++++++++++++++++++-
 drivers/md/raid0.h | 14 ++++++++++++++
 2 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/drivers/md/raid0.c b/drivers/md/raid0.c
index bf5cf184a260..a8888c12308a 100644
=2D-- a/drivers/md/raid0.c
+++ b/drivers/md/raid0.c
@@ -19,6 +19,9 @@
 #include "raid0.h"
 #include "raid5.h"
=20
+static int default_layout =3D -1;
+module_param(default_layout, int, 0644);
+
 #define UNSUPPORTED_MDDEV_FLAGS		\
 	((1L << MD_HAS_JOURNAL) |	\
 	 (1L << MD_JOURNAL_CLEAN) |	\
@@ -139,6 +142,19 @@ static int create_strip_zones(struct mddev *mddev, str=
uct r0conf **private_conf)
 	}
 	pr_debug("md/raid0:%s: FINAL %d zones\n",
 		 mdname(mddev), conf->nr_strip_zones);
+
+	if (conf->nr_strip_zones =3D=3D 1) {
+		conf->layout =3D RAID0_ORIG_LAYOUT;
+	} else if (default_layout =3D=3D RAID0_ORIG_LAYOUT ||
+		   default_layout =3D=3D RAID0_ALT_MULTIZONE_LAYOUT) {
+		conf->layout =3D default_layout;
+	} else {
+		pr_err("md/raid0:%s: cannot assemble multi-zone RAID0 with default_layou=
t setting\n",
+		       mdname(mddev));
+		pr_err("md/raid0: please set raid.default_layout to 0 or 1\n");
+		err =3D -ENOTSUPP;
+		goto abort;
+	}
 	/*
 	 * now since we have the hard sector sizes, we can make sure
 	 * chunk size is a multiple of that sector size
@@ -547,10 +563,12 @@ static void raid0_handle_discard(struct mddev *mddev,=
 struct bio *bio)
=20
 static bool raid0_make_request(struct mddev *mddev, struct bio *bio)
 {
+	struct r0conf *conf =3D mddev->private;
 	struct strip_zone *zone;
 	struct md_rdev *tmp_dev;
 	sector_t bio_sector;
 	sector_t sector;
+	sector_t orig_sector;
 	unsigned chunk_sects;
 	unsigned sectors;
=20
@@ -584,8 +602,16 @@ static bool raid0_make_request(struct mddev *mddev, st=
ruct bio *bio)
 		bio =3D split;
 	}
=20
+	orig_sector =3D sector;
 	zone =3D find_zone(mddev->private, &sector);
=2D	tmp_dev =3D map_sector(mddev, zone, sector, &sector);
+	switch (conf->layout) {
+	case RAID0_ORIG_LAYOUT:
+		tmp_dev =3D map_sector(mddev, zone, orig_sector, &sector);
+		break;
+	case RAID0_ALT_MULTIZONE_LAYOUT:
+		tmp_dev =3D map_sector(mddev, zone, sector, &sector);
+		break;
+	}
 	bio_set_dev(bio, tmp_dev->bdev);
 	bio->bi_iter.bi_sector =3D sector + zone->dev_start +
 		tmp_dev->data_offset;
diff --git a/drivers/md/raid0.h b/drivers/md/raid0.h
index 540e65d92642..3816e5477db1 100644
=2D-- a/drivers/md/raid0.h
+++ b/drivers/md/raid0.h
@@ -8,11 +8,25 @@ struct strip_zone {
 	int	 nb_dev;	/* # of devices attached to the zone */
 };
=20
+/* Linux 3.14 (20d0189b101) made an unintended change to
+ * the RAID0 layout for multi-zone arrays (where devices aren't all
+ * the same size.
+ * RAID0_ORIG_LAYOUT restores the original layout
+ * RAID0_ALT_MULTIZONE_LAYOUT uses the altered layout
+ * The layouts are identical when there is only one zone (all
+ * devices the same size).
+ */
+
+enum r0layout {
+	RAID0_ORIG_LAYOUT =3D 1,
+	RAID0_ALT_MULTIZONE_LAYOUT =3D 2,
+};
 struct r0conf {
 	struct strip_zone	*strip_zone;
 	struct md_rdev		**devlist; /* lists of rdevs, pointed to
 					    * by strip_zone->dev */
 	int			nr_strip_zones;
+	enum r0layout		layout;
 };
=20
 #endif
=2D-=20
2.14.0.rc0.dirty


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl119+YACgkQOeye3VZi
gbkG1g/+M5ELC/pTYYI0N7bROGws+aym1X9YsUy9YmEReemslggGTSZPSzeQtEbh
yijDV9q697cKbnnKNIEKyRQDEJB4pL/A+TUJ8bUnPQB6jlFdgqz4JBwKe+iagfS9
NOaAISaqmSRJpvT2cWyGVNk1DhA1nu8b6V5iTj4cO1XzLZbvKtAcP0RuxVBcH4kl
6Rw3rTqGhd8IhAF8zFdIizkTPXMfzS/OGIIuT6f45/GEBi4Eh4T1hXLIPbQz3Hxg
eciUdtRA+0KO0JRZf6YT7zStSQYHsSghJNQkF5M62/i2sH0Jcu9XstOEJhZ3b+Ci
nm/n2mXNCjSsxmgxvd1lJCcsixuVM4T7QDNxPK/baHeHKVHtg40XwdDEhgNW9MdC
pqHAa2S93Qb6va9cCH7IzneoKGUewj4TiyGZj6MJVE47jyKIfx0duy0flDetD6j5
PDuqj06GKNDiH1fvToXnGxnYOOgL4bzM2oxy5fD6vrmHlOOV6KZTlY0Zl6m+86gT
/eZM0ia2nJzYjtqTg/x5+g6KyeCkiKD/I8qoBpUs1kuDTf4P2GqO4Seiit1z/YNL
WFd7ZbKkKe32zUJ61FA64cqEjMGivGsfN3NSeYyAAvzFwMKE7iFTMoyrXpNQtUw/
yL30C3f0dx2WYLkS8/oP415gRFhzWAPcVS9FNZcPVdITVUewuHI=
=VlM2
-----END PGP SIGNATURE-----
--=-=-=--
