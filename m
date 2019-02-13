Return-Path: <SRS0=Y8Hj=QU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CC4EC282CA
	for <linux-block@archiver.kernel.org>; Wed, 13 Feb 2019 10:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A3A520842
	for <linux-block@archiver.kernel.org>; Wed, 13 Feb 2019 10:26:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20150623.gappssmtp.com header.i=@dilger-ca.20150623.gappssmtp.com header.b="ttzXSzxz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389494AbfBMK0S (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Feb 2019 05:26:18 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42281 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388076AbfBMK0S (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Feb 2019 05:26:18 -0500
Received: by mail-pl1-f193.google.com with SMTP id s1so951602plp.9
        for <linux-block@vger.kernel.org>; Wed, 13 Feb 2019 02:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=BvomFzNrjx7zkOuMRj7ZBuC6lhcHtwTPGgUBQHLf6wg=;
        b=ttzXSzxzgmf8g3d8RB/15GJD4zN7A7Y9sNaLBszVQ0PLLmuTSaPB+BVLmTylm8hiNW
         KQq1w+fOXeZeLOCv3HPQ/5B+niN9Hn5tBr/Z+mV2xkzbyqFHNWAvdIla6To/NxOn98N5
         TBsJfMF0GGG+2OqQpjIO1N02iTGs6kdym4qz5kESs7zm34ZsLi0oVXIUl3TvYM8LXy5S
         zoF+liamCLWUSq5YH6qfMAnLxBv7yFv2IrjkATF5XZNcAsqgj60V8CVn2leBQ+CHP37u
         LHcQJvse2qOwkJ2x3F2rz876HBH8onLqdTk5aAhTduiu1OF6YSDBuftyGgNwi4aO63Xv
         VOpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=BvomFzNrjx7zkOuMRj7ZBuC6lhcHtwTPGgUBQHLf6wg=;
        b=fl/2E4vhjtARVZR4bHWT+K4PigVXoord0furWEHFltCTrxsXdUMxKvrlluxPY6QnJO
         0Hxl+V7Y15nLZVI/W8MrPrUHbSk/8omi1sC44mHsXoUzmKW4CyyuixvaQML3YOC26rK2
         xn1ILK8WrmMksXePH1n//9vObrGlfjSj/jhGZEEL5kAibFMmeb6OJ1MKYN44awY1HtOG
         ENIiok56C2HT2XNoJeHLb5wKBHQKQ83GOQDbV4dKxzwfS7nh2NnZ8WkPMtL+X+lJfbC3
         e1KRqK46v/MnulZtSpEbmTJmgjTGQmj23vV+Ixl+zHxtaNAZzMm4lfE0RswVRXOJ1q7G
         2hOw==
X-Gm-Message-State: AHQUAubXlVkodDGJbTS0WGKjT0U0oKbMZsJMmMyAKW61rQhyNm5Tw/Q0
        HyB0202r0KQu76/5GlX9gIooKA==
X-Google-Smtp-Source: AHgI3IaRUl4mZWe5STWBozpcpIeAX7qZ8iqWPso7PfZQPFiXSpKQ6beAyJZ0qYBxN239k71zEVcXPg==
X-Received: by 2002:a17:902:20e2:: with SMTP id v31mr9157171plg.307.1550053577216;
        Wed, 13 Feb 2019 02:26:17 -0800 (PST)
Received: from cabot.adilger.ext (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id f67sm29518516pfc.141.2019.02.13.02.26.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 02:26:16 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <D2BD41DA-D7B3-4C76-B4BC-40B012E3D6A4@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_E0D7658E-65DD-4C51-93A2-A655AC5B8FF4";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [RFC PATCH v2 1/9] block: add nr_mirrors to request_queue
Date:   Wed, 13 Feb 2019 03:26:14 -0700
In-Reply-To: <20190213095044.29628-2-bob.liu@oracle.com>
Cc:     linux-block <linux-block@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Martin Petersen <martin.petersen@oracle.com>,
        shirley.ma@oracle.com, allison.henderson@oracle.com,
        david@fromorbit.com, darrick.wong@oracle.com, hch@infradead.org
To:     Bob Liu <bob.liu@oracle.com>
References: <20190213095044.29628-1-bob.liu@oracle.com>
 <20190213095044.29628-2-bob.liu@oracle.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--Apple-Mail=_E0D7658E-65DD-4C51-93A2-A655AC5B8FF4
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Feb 13, 2019, at 2:50 AM, Bob Liu <bob.liu@oracle.com> wrote:
>=20
> When fs data/metadata checksum mismatch, lower block devices may have =
other
> correct copies. e.g if we did raid1 for protecting fs metadata.
> Then fs could try other copies of metadata instead of panic, but fs =
need be
> awared how many mirrors the block devices have.
>=20
> This patch add @nr_mirrors to struct request_queue which is similar as
> blk_queue_nonrot(), filesystem can grab device request queue and check =
the
> number of mirrors of this block device.
>=20
> @nr_mirrors is 1 by default which means only one copy, drivers e.g =
raid1 are
> responsible for setting the right value. The maximum value is
> BITS_PER_LONG which is 32 or 64. That should be big enough else retry =
lantency
> may be too high.
>=20
> Also added helper functions for get/set the number of mirrors for a =
specific
> device request queue.
>=20
> Todo:
> * Export nr_mirrors through /sysfs.
>=20
> Signed-off-by: Bob Liu <bob.liu@oracle.com>

> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index 3e7038e475ee..38e4d7e675e6 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -844,6 +844,30 @@ void blk_queue_write_cache(struct request_queue =
*q, bool wc, bool fua)
> +/*
> + * Set the number of read redundant mirrors.
> + */
> +bool blk_queue_set_mirrors(struct request_queue *q, unsigned short =
mirrors)
> +{
> +	if(q->nr_mirrors >=3D BLKDEV_MAX_MIRRORS) {
> +		printk("blk_queue_set_mirrors: %d exceed max =
mirrors(%d)\n",
> +				mirrors, BLKDEV_MAX_MIRRORS);

Need to supply a KERN_ level here.

Cheers, Andreas






--Apple-Mail=_E0D7658E-65DD-4C51-93A2-A655AC5B8FF4
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAlxj8MYACgkQcqXauRfM
H+CRcA//a0CdSKWwc/HVXVC2l3nkn7Vv8PnaBcVBfTAzXaZFFH/AInHO9YWhjdge
0tHZ5UMWEe4JZ8qc+9M5g+LD5btA2CXPeimysqW2Rv29Rq86ASF0fqUU+Ayf0ouS
oxKYW4HfJpu6QzovSbltwFuw0rnRymeRV3wul4gqkJheFJkyDv509+OHzyh+BE8a
ImHKDfghT5y/w//2+h3uSz0Kp4MfOY/5W1omn0Cjg/CLUSJflYrj8LS4y+HTR56B
rkgZO2pdjEt17kkIQ8E4LWSHVdVwPgcX3GKzIDjcwEZaIpxH7ilV9AqjTQEABrYG
q6sRs/PRLyw6ag1KJRkbEz+qZ0U/kNB8E47PFuh9MKaT9o/d8z4SEvELvPjibnAb
fKrrgGJR90575B1GeK0Vif+vriwPUmi2GlukcbkSu7KAEn3NqAEwpIhAlIr4w4Eo
nLsmsS4V3hHMmypDzsiA5iuq8Ll16RR2RQFeVsZ0NcWR6l76PLRpv+dEHtzGRsxQ
S+yUPodcDJuL61OkHptCtpQQto3o/WVsKbI7aJMXyeSZhPZ8Hk1FvYW44976pARI
T+FkKkeHJSbujD8KPzHgmRis94nxKfKzCBHe4x59VvX1FOpXmuldNh9W2W2EOz52
Eb4oibGn3Wo4j9wbMsatYbcm3a9tvpO8LOxhXT9FQvrr13vIjqM=
=v45Z
-----END PGP SIGNATURE-----

--Apple-Mail=_E0D7658E-65DD-4C51-93A2-A655AC5B8FF4--
