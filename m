Return-Path: <SRS0=IV7O=OQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 811D1C07E85
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 10:38:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 344E8208E7
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 10:38:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b="CFrDW/y3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 344E8208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tu-dortmund.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726015AbeLGKiF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Dec 2018 05:38:05 -0500
Received: from mx1.hrz.uni-dortmund.de ([129.217.128.51]:42162 "EHLO
        unimail.uni-dortmund.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725986AbeLGKiF (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Dec 2018 05:38:05 -0500
X-Greylist: delayed 790 seconds by postgrey-1.27 at vger.kernel.org; Fri, 07 Dec 2018 05:38:02 EST
Received: from [129.217.43.49] (limnos.cs.uni-dortmund.de [129.217.43.49])
        (authenticated bits=0)
        by unimail.uni-dortmund.de (8.16.0.29/8.16.0.29) with ESMTPSA id wB7AOlqA028061
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 7 Dec 2018 11:24:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-dortmund.de;
        s=unimail; t=1544178287;
        bh=5NNiEaePCEvqRYcc5BSeTbEFbFMvSFcsn+E2dWYTLCs=;
        h=To:Cc:References:From:Subject:Date:In-Reply-To;
        b=CFrDW/y3zsb6dixe8GTfGVBIll/Sq8HSaFTvMEg3hgdnUUaLCtGAC6zlYrjjncbvi
         0ul26Uneb58Ifh5Zn2eg0eZEL28HfpfkcnVKTqsjNEDI8f8WTzjcxDYhqpqKc54ynf
         vtwvVboEosGKZOph1iCB028iPgfU6c86pbWZX5kg=
To:     Jan Kara <jack@suse.cz>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Horst Schirmeier <horst.schirmeier@tu-dortmund.de>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
References: <13eaa1c6-def5-afad-89eb-6f149db90684@tu-dortmund.de>
 <20181205153254.GD30615@quack2.suse.cz>
From:   Alexander Lochmann <alexander.lochmann@tu-dortmund.de>
Openpgp: preference=signencrypt
Autocrypt: addr=alexander.lochmann@tu-dortmund.de; prefer-encrypt=mutual;
 keydata=
 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
 spNrcZJf1pbo3EKkCwUPAltq51ramtYzOu4K
Subject: Re: [PATCH] Fix sync. in inode_has_no_xattr()
Message-ID: <c4f0d66f-7cad-c3b4-79a6-ced14b9c7cc8@tu-dortmund.de>
Date:   Fri, 7 Dec 2018 11:24:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181205153254.GD30615@quack2.suse.cz>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="tPXSZBbiqdMBufTAzyzsDMwjYHRgcwaC9"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tPXSZBbiqdMBufTAzyzsDMwjYHRgcwaC9
Content-Type: multipart/mixed; boundary="NHlqAF8J7U9qcWIOq0ykp4LrGOyMI0hvE";
 protected-headers="v1"
From: Alexander Lochmann <alexander.lochmann@tu-dortmund.de>
To: Jan Kara <jack@suse.cz>
Cc: viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Horst Schirmeier <horst.schirmeier@tu-dortmund.de>,
 linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Message-ID: <c4f0d66f-7cad-c3b4-79a6-ced14b9c7cc8@tu-dortmund.de>
Subject: Re: [PATCH] Fix sync. in inode_has_no_xattr()
References: <13eaa1c6-def5-afad-89eb-6f149db90684@tu-dortmund.de>
 <20181205153254.GD30615@quack2.suse.cz>
In-Reply-To: <20181205153254.GD30615@quack2.suse.cz>

--NHlqAF8J7U9qcWIOq0ykp4LrGOyMI0hvE
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Am 05.12.18 um 16:32 schrieb Jan Kara:
>=20
> Thinking more about this I'm not sure if this is actually the right
> solution. Because for example the write(2) can set S_NOSEC flag wrongly=

> when it would race with chmod adding SUID bit. So probably we rather ne=
ed
> to acquire i_rwsem in blkdev_write_iter() if file does not have S_NOSEC=
 set
> (we don't want to acquire it unconditionally as that would heavily impa=
ct
> scalability of block device writes).
>=20
> 								Honza
>=20
Trying to implement your suggestion, I'm not sure which inode to use:
In blkdev_write_iter() there is the "bd_inode =3D bdev_file_inode(file)".=

file_remove_privs() uses "inode =3D file_inode(file)" as a parameter for
inode_has_no_xattr().
So, do file->f_mapping->host and f->f_inode refer to the identical inode?=


- Alex

--=20
Technische Universit=C3=A4t Dortmund
Alexander Lochmann                PGP key: 0xBC3EF6FD
Otto-Hahn-Str. 16                 phone:  +49.231.7556141
D-44227 Dortmund                  fax:    +49.231.7556116
http://ess.cs.tu-dortmund.de/Staff/al


--NHlqAF8J7U9qcWIOq0ykp4LrGOyMI0hvE--

--tPXSZBbiqdMBufTAzyzsDMwjYHRgcwaC9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEElhZsUHzVP0dbkjCRWT7tBbw+9v0FAlwKSm8ACgkQWT7tBbw+
9v1UHQ/6A9nBTj+yrDm6t7ctkbt2XnihrEbHLg1YJo8VPZSDGM54RtwmAxw+ioa9
OwQsW1I2L+ya/7ZhN0gAhRg8wQGbTAEdwitHDVWobxwg4JQv83HYi0WaTPS41B6O
BSXL7F3TWNBI72av5EHToE7JlfL6SzJCSvSl4f8oRVn3VogTlV7aan41jDxU64le
ud0NGjudz3/JIXwqwxP+OJP6M9PlWKUBTF12OV2rjsrGygTkxoh/HKsm+SR8v5Ts
JGFdOWx9V1LfH1PmhOxp6ffiLBopUc9WemfI4YYK4aMUX5GdMnnmyPXpvLYgt4Kj
Q89b8sSoViJAYbp+uag8tEM7DVZym9D0rdFCTbESLCdV+s4RW8lu1AhIe58azPKh
PqvtYFf7S51Hv/mCbeVF/mke4dPXaJ9qQCDEXRuFBxgnvfuWv8n+WgapoFzJyzAC
5FdFKMz6SJkldfIyYKzqWTsef97BM4AC4sRkPXLHQuTFE8FV0wLszLIi/dSQRKjU
11Iw3pleeVgfPEjE6MSpgyeha+0SFFvxP50NZoJI5kIxS3AMIyzgOzUF57q8ng9p
FZKJccgbcwjz+HMmOIOg6GYKycPev/rOBc2l3CbxWg0xvBDYwiZxRbAWMU96MOkF
WjjK0vEAI9+5TgjNdWQiY8+AgT1Mh9axuYJX1k0xH88iqGVZc4s=
=KFkQ
-----END PGP SIGNATURE-----

--tPXSZBbiqdMBufTAzyzsDMwjYHRgcwaC9--
