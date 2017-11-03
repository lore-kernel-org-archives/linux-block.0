Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:48796 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752252AbdKCNAL (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Nov 2017 09:00:11 -0400
Received: by mail-wm0-f50.google.com with SMTP id p75so1352452wmg.3
        for <linux-block@vger.kernel.org>; Fri, 03 Nov 2017 06:00:10 -0700 (PDT)
From: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <jg@lightnvm.io>
Message-Id: <AE86953D-041E-4FFA-8DE8-E8FC95F95087@lightnvm.io>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_00ED9334-FF4B-405C-86F1-B32963AAF0FF";
 protocol="application/pgp-signature"; micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 1/3] nvme: do not check for ns on rw path
Date: Fri, 3 Nov 2017 14:00:08 +0100
In-Reply-To: <20171103125339.GA25186@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, keith.busch@intel.com,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
References: <1509703370-20379-1-git-send-email-javier@cnexlabs.com>
 <1509703370-20379-2-git-send-email-javier@cnexlabs.com>
 <20171103125339.GA25186@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


--Apple-Mail=_00ED9334-FF4B-405C-86F1-B32963AAF0FF
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

> On 3 Nov 2017, at 13.53, Christoph Hellwig <hch@lst.de> wrote:
> 
>> -	if (ns && ns->ms &&
>> +	if (ns->ms &&
>> 	    (!ns->pi_type || ns->ms != sizeof(struct t10_pi_tuple)) &&
>> 	    !blk_integrity_rq(req) && !blk_rq_is_passthrough(req))
>> 		return BLK_STS_NOTSUPP;
> 
> blk_rq_is_passthrough also can't be true here.
> 
> How about:
> 
> 	if (ns->ms && !blk_integrity_rq(req) &&
> 	    (!ns->pi_type || ns->ms != sizeof(struct t10_pi_tuple)))
> 		return BLK_STS_NOTSUPP;
> 

Sure.

> Although I have to admit I don't really understand what this check
> is even trying to do.  It basically checks for a namespace that has
> a format with metadata that is not T10 protection information and
> then rejects all I/O to it.  Why are we even creating a block device
> node for such a thing?

Looking at the history (i) the check has changed location and (ii) some
checks have been added through time. So it looks like leftovers from
here and there.

If we end up not needing these checks at all here, you can just fix it
all in the same commit. Just wanted to get rid of sparse/smatch
complains...


--Apple-Mail=_00ED9334-FF4B-405C-86F1-B32963AAF0FF
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEm1mT7zen+vs9+T8kYx8FO3WZGMoFAln8aFgACgkQYx8FO3WZ
GMq3vA//Ybut4701CVRq/hTAvrX/iZOjCFgblJwidezMKezMMA7NoprAJi6Yc3Da
tN4BDv9w5kInmxndYVZ/QLs3Zhrxog4ZsPTU7M85k9xd2q4L65wT2EDAMnjudBrb
29Mt+8aG91p1NdqT0tifxIjBTNNDHry6HTgsHg56QVGaXhHdWvHI8UqNDVX4FzP0
LQISXbx6HiLj1qm3ZCcGohAbbV/kRPZaNwya8SIV/WuSDxSOjzMxqWUVtncHXn9O
QAHPSxSzO2AyULfYQfC5Wy8xqO6fCxSBNFACBm4r60lQ0+U+sx2u0tWOnqSZr2cw
atnfKKZyxGmB7gMLTbEW2+1S2FZluCAg4FQlaGPlm116IIrm3kGn3S4grkNF/IRf
4b7V84BuJBipYLcjdpIIR1C2YPguC17gxmfmt51cilWyNUyjKKZY6v+I3j4m6w7P
5MsP6FhqF7YcCEbCmJXv2fdzVhePa64PPXLaVtGxC1Yagb64gCiYlzzOb+yFkTzS
PT02yMJK2yG7mZOe2S1FkWgI+tOk7L3tRGekH4RH7uJT82kn804QKR9qS1Ec3hS6
p/llf2KqtXC0DZti3N8jKYZzsNt8s9P6XMPWSWJvBMXZvIk0iPQr52n3soClZhuq
H/qdM6lLuL0gb6TisorqJdntfutWMPsF/kHMn9WRV1LVUFmMPaI=
=tDQQ
-----END PGP SIGNATURE-----

--Apple-Mail=_00ED9334-FF4B-405C-86F1-B32963AAF0FF--
