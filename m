Return-Path: <SRS0=9mBv=RD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5CE4C43381
	for <linux-block@archiver.kernel.org>; Thu, 28 Feb 2019 17:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FB98218AE
	for <linux-block@archiver.kernel.org>; Thu, 28 Feb 2019 17:15:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="2AoZZNOz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730698AbfB1RPa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Feb 2019 12:15:30 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34514 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbfB1RP3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Feb 2019 12:15:29 -0500
Received: by mail-qk1-f195.google.com with SMTP id a15so12530529qkc.1
        for <linux-block@vger.kernel.org>; Thu, 28 Feb 2019 09:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=zhSGUBWxVP3rnk7s1/LlThxIAPSd6PFmQ/d+TvvukYY=;
        b=2AoZZNOzF0RfOKw8cPjZjOVyLl3G29xOrTUFh0LPtRVFmrrqHLKaYhbi1AqZqj7OJM
         +nwyhA5yR2FUkgEluhFkwnjpQOcBgVEU07/sq88Vso7FgkO4/ZOz6h/YY8VipNRV5VoA
         LjlwhLUX1FlEcu0prsajO1oU2EIluSa2IPIBwrEfqmwTuHohWL2BuwclrGyjYusZh40E
         jjZMtDGLGe2ahz8NRw3ZidcDjuQ+5O7Mt/SV6E3trznjv5HGtafrjl0bBidXlOybTFbB
         bonapXcWZcq24CKI8E1tek9XmvhGrrB8dYYNnwiUvE/3gjfzUyi3JualPbFH8UPpNMcB
         /k3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=zhSGUBWxVP3rnk7s1/LlThxIAPSd6PFmQ/d+TvvukYY=;
        b=JzAnb++HBvdvms6KIDu0aL63eCapf9sF4v0eJLleplN2xAknkGjDk/LLbgZjTjtOQa
         os6WC5ovjF0wi05vVptyhWD5aL0TuwAu4Dvk1Vela94Ydu32zOptSAiDOABirBXsY5mc
         ubzh30IIqt0Fqsy4ugPFFpaLjZV0N1OM8KB3IUU/K6DZD1qz3hK0xiKaX9lM0EfkBRjM
         qWjCojPJnNUWDuGHcNzLQpvpvBoguER5F8yZ6ENUywEe+wstrGQ5p3wtFwhI3keyE55e
         mfOveFC7/DhZzJeaXl5aiSp4GLU+WoeSGg4+/pAlLyd0HmIEiZ+utMuw2KqKZTBXHFx+
         DI2Q==
X-Gm-Message-State: APjAAAVxOMgGd1fdKF4LzRTuoeHEhEunuSmjugfH4qHEkDdmV505RuV7
        6INRRVerzWiHuBFtuHJO/IAgOBiZBzdy8w==
X-Google-Smtp-Source: APXvYqzswh0Cyb6qxgNSD5539WxT0ikzTX6MuoaJMTFT+9FmsJ5a7QpSAHGTNmoy+kyp4SqoDGG4iQ==
X-Received: by 2002:a37:4801:: with SMTP id v1mr428609qka.312.1551374127888;
        Thu, 28 Feb 2019 09:15:27 -0800 (PST)
Received: from [192.168.12.17] ([72.166.42.242])
        by smtp.gmail.com with ESMTPSA id z42sm12504907qta.28.2019.02.28.09.15.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 09:15:27 -0800 (PST)
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Message-Id: <36E5AFF8-1E24-46A4-B54B-B313BFF940D7@javigon.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_6AEFC707-F3B5-470C-A688-56FE03E58ED4";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH 00/13] lightnvm: bugfixes and improvements
Date:   Thu, 28 Feb 2019 12:15:26 -0500
In-Reply-To: <18ac8f7c-4990-073e-0fa7-b73315238bf3@lightnvm.io>
Cc:     "Konopko, Igor J" <igor.j.konopko@intel.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org
To:     =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>
References: <20190227171442.11853-1-igor.j.konopko@intel.com>
 <18ac8f7c-4990-073e-0fa7-b73315238bf3@lightnvm.io>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--Apple-Mail=_6AEFC707-F3B5-470C-A688-56FE03E58ED4
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 28 Feb 2019, at 11.36, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> On 2/27/19 6:14 PM, Igor Konopko wrote:
>> This series provides a group of the bugfixes
>> or improvements for lightnvm and pblk device.
>> Most of the patches are rather simple and covers
>> some corner cases scenario, but we were able to hit
>> most of them in some scenarios. Few others close some
>> existing gaps which we were able to found.
>> Fedback is appreciated.
>> Igor Konopko (13):
>>   lightnvm: pblk: Line reference fix in GC
>>   lightnvm: pblk: Gracefully handle GC data malloc fail
>>   lightnvm: pblk: Fix put line back behaviour
>>   lightnvm: pblk: Rollback in gc read
>>   lightnvm: pblk: Count all read errors in stats
>>   lightnvm: pblk: Ensure that erase is chunk aligned
>>   lightnvm: pblk: Cleanly fail when there is not enough memory
>>   lightnvm: pblk: Set proper read stutus in bio
>>   lightnvm: pblk: Kick writer for flush requests
>>   lightnvm: pblk: Reduce L2P DRAM footprint
>>   lightnvm: pblk: Remove unused smeta_ssec field
>>   lightnvm: pblk: close opened chunks
>>   lightnvm: Inherit mdts from the parent nvme device
>>  drivers/lightnvm/core.c          |   9 ++-
>>  drivers/lightnvm/pblk-core.c     | 128 =
+++++++++++++++++++++++++++++--
>>  drivers/lightnvm/pblk-gc.c       |  47 +++++++-----
>>  drivers/lightnvm/pblk-init.c     |  30 ++++++--
>>  drivers/lightnvm/pblk-map.c      |   2 +
>>  drivers/lightnvm/pblk-read.c     |  13 ++--
>>  drivers/lightnvm/pblk-recovery.c |   2 +-
>>  drivers/lightnvm/pblk.h          |   4 +-
>>  drivers/nvme/host/lightnvm.c     |   1 +
>>  include/linux/lightnvm.h         |   1 +
>>  10 files changed, 193 insertions(+), 44 deletions(-)
>=20
> Thanks Igor. I'll give Hans et. al. a couple of days to digest the =
changes.

If it is that difficult to spell Javier you can look at the pblk =
copyright=E2=80=A6

I=E2=80=99ll review the patches next week.

Javier

--Apple-Mail=_6AEFC707-F3B5-470C-A688-56FE03E58ED4
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEU1dMZpvMIkj0jATvPEYBfS0leOAFAlx4Fy4ACgkQPEYBfS0l
eODlhQ/+MCmUhlqIkhc/Sltcm533MIHUGixhFqMrOn+2RRKmMoCweCWNUd/IBZAK
dwKiWnVs+jumxJhYyBY5tl5fdRFSB2+n+9WTqx78cLQUFSOWG/bstLHObU5yw5LH
xlBv9Xel2AcGhR8znbxetF6ZFuCWvXNP1ULhZwtaH8pDhCf5va+6dLqv7mRMRy3a
uWSLMFtfK/0nglg9SQnjLmYnkJ7KN56aI5ScDVboV5rWLYZt5EVAt3JWnnAYeB6d
ewdECn/RGOC0kwkbTjAbOpDMBmGtonWvlkmAoG3Cr5NCjS9VkCpu8kEXor9adEWs
ZdXAP/9ygetzQ7dyUMBB9M0IUZagNro3ipxea80a9lrHrrlFvIxwmTXW7U3W9nD6
VEoPxZZ6Mvr69uRgZQiaoH9TYaE25qGxGtbL98eRU3jeJ1D7gLLeYTIZllAs5V+K
TC/9jFFsPUB15aCISRbc0s3D0Kx4z/b67SK7StDLP5ZPUcCjXev72LtB3uAo1FhE
VIuS/Z+c4vXXrtv11u98x8sJb9klUnTDF6HaBYxId9TRdMcM5nElEmde9s9gSzNE
32+gsvVhWgmvemJGWDTVQ90xB7aukzohmAsMkrhsPTfpvRAgpxNuixay3I/nCQDd
Ljf510jwEBh0fvv4ugiJoDs6SlwA0uwz4JxqjmtOBQ/z14zikhI=
=NsQe
-----END PGP SIGNATURE-----

--Apple-Mail=_6AEFC707-F3B5-470C-A688-56FE03E58ED4--
