Return-Path: <SRS0=FxMo=OH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DDB0C43610
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 19:38:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA25C208E7
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 19:38:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20150623.gappssmtp.com header.i=@dilger-ca.20150623.gappssmtp.com header.b="QyBGaT/C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA25C208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728446AbeK2Glg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Nov 2018 01:41:36 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34557 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728542AbeK2Glg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Nov 2018 01:41:36 -0500
Received: by mail-pl1-f194.google.com with SMTP id w4so855949plz.1
        for <linux-block@vger.kernel.org>; Wed, 28 Nov 2018 11:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=8bQFWKBjiGrYiU8FacAN+YIRavoiuZsYEdpz9LRoF0U=;
        b=QyBGaT/C4HEetrqDyESuU9yPgennW/eIcdW/G6XY0bnLZquyFMTcRDR70V/AqDFXBs
         qUh/goUGSySK5DcE0qrYo8a0SVT+MbHcvRRLeZdLtdJ1UKO0rhXgZ7Cep5rO06S28XVG
         SOrlh8GyE7ql5DOP+6ecv83IM+PbduDX6h2L2OZdle5532eCWE35Afj1pIXGQ8QbeoGb
         PmaLwPXFtX8Ku+4fTGY8xHonJjLpsR6vVyd6LbbJoF0dwj+cLC5mUfVZgSCmh477MCRz
         xW/sxAtVFn14aV3sIVH9OIVuwOFUlzx9JRl3M/rnnepF3r8g3cmqUIN/4ebYw9g2Ao3k
         XUGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=8bQFWKBjiGrYiU8FacAN+YIRavoiuZsYEdpz9LRoF0U=;
        b=BKWoI7Iowg2Need4fT3akkOBmBCTzxLeNJgaUEnHQm/DGi0+oq6QbpctI6peQnyJJW
         L9vc7vubaRRboxzeMQo09l8CyAl6KTY+X/ZQf3AlVyh7TouXmXOJi8Z6MGmac07HAxaq
         tNZMbJGuxFgkfGdypkdA7N1iZCtsBG2A7K2/LM89PmuXROpqK8pAXCXr+HoaqpHENklf
         TGI9OtIzJ+e/Uq1Lb5e+Tr9HSbyaXBvQuatpggmwPMac/qVg4fFmJnN+ukjTBUvhmVdm
         Lx7d2WdQC/vIvIgJA4XIj+odcnRHpr/2VzXBqGozlHqVWatHqIneMGHgouTVIATRvw7T
         jV0Q==
X-Gm-Message-State: AA+aEWZPPcNYhc2h6Iv7QY+TPFKWWE8VQLDdTlq6gu1Ar65rCPf1IAce
        kD3I2Y7+atEQV9upJLdKf84RXA==
X-Google-Smtp-Source: AFSGD/XHJFk9Bnq0etBnECrMVC9ECjIwCFlC5kJ5hw6WXpSCV8xsJWLGxEfyaKnsSWmNANYtiD4gAw==
X-Received: by 2002:a17:902:29ab:: with SMTP id h40mr38088486plb.238.1543433930933;
        Wed, 28 Nov 2018 11:38:50 -0800 (PST)
Received: from cabot-wlan.adilger.int (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id g2sm10028732pfi.95.2018.11.28.11.38.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Nov 2018 11:38:50 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <4C297F47-C508-4DC9-8360-5E0873873833@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_E18FEC91-F3F9-48CF-BEDA-01D625B3A34F";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [RFC PATCH v1 0/7] Block/XFS: Support alternative mirror device
 retry
Date:   Wed, 28 Nov 2018 12:38:47 -0700
In-Reply-To: <20181128054923.GF8125@magnolia>
Cc:     Dave Chinner <david@fromorbit.com>,
        Allison Henderson <allison.henderson@oracle.com>,
        linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Martin Petersen <martin.petersen@oracle.com>,
        shirley.ma@oracle.com, bob.liu@oracle.com
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
References: <1543376991-5764-1-git-send-email-allison.henderson@oracle.com>
 <20181128053303.GL6311@dastard> <20181128054923.GF8125@magnolia>
X-Mailer: Apple Mail (2.3273)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--Apple-Mail=_E18FEC91-F3F9-48CF-BEDA-01D625B3A34F
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Nov 27, 2018, at 10:49 PM, Darrick J. Wong <darrick.wong@oracle.com> =
wrote:
> On Wed, Nov 28, 2018 at 04:33:03PM +1100, Dave Chinner wrote:
>> On Tue, Nov 27, 2018 at 08:49:44PM -0700, Allison Henderson wrote:
>>> Motivation:
>>> When fs data/metadata checksum mismatch, lower block devices may =
have other
>>> correct copies. e.g. If XFS successfully reads a metadata buffer off =
a raid1
>>> but decides that the metadata is garbage, today it will shut down =
the entire
>>> filesystem without trying any of the other mirrors.  This is a =
severe
>>> loss of service, and we propose these patches to have XFS try harder =
to
>>> avoid failure.
>>>=20
>>> This patch prototype this mirror retry idea by:
>>> * Adding @nr_mirrors to struct request_queue which is similar as
>>>  blk_queue_nonrot(), filesystem can grab device request queue and =
check max
>>>  mirrors this block device has.
>>>  Helper functions were also added to get/set the nr_mirrors.
>>>=20
>>> * Expanding bi_write_hint to bi_rw_hint, now @bi_rw_hint has three =
meanings.
>>> 1.Original write_hint.
>>> 2.end_io() will update @bi_rw_hint to reflect which mirror this i/o =
really happened.
>>> 3.Fs set @bi_rw_hint to force driver e.g raid1 read from a specific =
mirror.
>>>=20
>>> * Modify md/raid1 to support this retry feature.
>>>=20
>>> * Add b_rw_hint to xfs_buf
>>>  This patch adds a new field b_rw_hint to xfs_buf.  We will use this =
to set the
>>>  new bio->bi_rw_hint when submitting the read request, and also to =
store the
>>>  returned mirror when the read completes
>=20
>> the retry iterations. That allows us to let he block layer ot pick
>> whatever leg it wants for the initial read, but if we get a failure
>> we directly control the mirror we retry from and all bios in the
>> buffer go to that same mirror.
>> 	- is it generic/abstract enough to be able to work with
>> 	  RAID5/6 to trigger verification/recovery from the parity
>> 	  information in the stripe?
>=20
> In theory we could supply a raid5 implementation, wherein rw_hint =3D=3D=
 0
> lets the raid do as it pleases; rw_hint =3D=3D 1 reads from the =
stripe; and
> rw_hint =3D=3D 2 forces stripe recovery for the given block.

Definitely this API needs to be useful for RAID-5/6 storage as well, and
I don't think that needs too complex an interface to achieve.

Basically, the "nr_mirrors" parameter would instead be "nr_retries" or
similar, so that the caller knows how many possible data combinations
there are to try and validate.  For mirrors this is easy, and as it is
currently implemented.  For RAID-5/6 this would essentially be the
number of data rebuild combinations in the RAID group (e.g. 8 in a
RAID-5 8+1 setup, and 16 in a RAID-6 8+2).

For each call with nr_retries !=3D 0, the MD RAID-5/6 driver would skip
one of the data drives, and rebuild that part of the data from parity.
This wouldn't take too long, since the blocks are already in memory,
they just need the parity to be recomputed in a few different ways to
try and find a combination that returns valid data (e.g. if a drive
failed and the parity also has a latent corrupt sector, not uncommon).

The next step is to have an API that says "retry=3DN returned the =
correct
data, rebuild the parity/drive with that combination of devices" so
that the corrupt parity sector isn't used during the rebuild.

Cheers, Andreas






--Apple-Mail=_E18FEC91-F3F9-48CF-BEDA-01D625B3A34F
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAlv+7sgACgkQcqXauRfM
H+BeOw//Uxw6p/zGQaKjPUSXqnxgyftkyceAkIzeVS82sSgLCxntgcAitmsam3+H
r6aNJglW47gAn0SufpWkidA1pJGiV5zxSU4frApyGbGaVOl9AqzgfV1JGoWxVggw
O0cr/MSECJmQD/Za/9hIEY5ENF5PMhIOyaXe8vP0sEH45yKzlL02Fafyy3vR2Fxj
CRijCgOj7AYv+0BZayjmHT0yPK1psbchWxR7eezXNK1ggebJ3EaMFCSmalRNTUV6
k2XvUHl+SyiRn6zr+CORoZXPnu+mmOpvdERxcjmeAF0fDRtyER3kbEJc0unqL7Tm
5JiXWD/SlCLRMEMNsv0XdexNdzjD4fvnScJZ/GG92EktfgkjD/6IpStEmwmTflTQ
u98S8Fws/hOrvJSW1pDdobmxrSmI4UviVj98BDzZQbkPLvUHW8fJy+us7a7iwBS4
euECiA4J0XAREwtROnfpvJSyYQ1W758669H7bylydI8Pu29gt4XISWgIJA18ZaIo
YXTO8YAJCTpF/okwBgEfJ6i6ad05bYjQjAXjKNZf/Y7fV9f4rkoUNhnBTkETZsvR
SZlZkwljw9nAqPtjqbuyoQ2hZAK8o6IlyNwhHHhqw3POKIYdmsnqNtZplKauVw98
HZSChSjU156Xc+axJ4YpYdMTAI5aQf61uvUWtr9hdnHJF8DRaIQ=
=DyFV
-----END PGP SIGNATURE-----

--Apple-Mail=_E18FEC91-F3F9-48CF-BEDA-01D625B3A34F--
