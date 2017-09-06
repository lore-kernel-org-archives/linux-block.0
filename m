Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:37407 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754873AbdIFOBr (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Sep 2017 10:01:47 -0400
Received: by mail-wm0-f48.google.com with SMTP id u26so31537413wma.0
        for <linux-block@vger.kernel.org>; Wed, 06 Sep 2017 07:01:46 -0700 (PDT)
From: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <jg@lightnvm.io>
Message-Id: <7C9D69B3-96AC-4038-9395-FAA618B88EE4@lightnvm.io>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_B7A1EF50-077B-4E7E-A7A5-0A3C33AA8178";
 protocol="application/pgp-signature"; micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 01/18] lightnvm: pblk: improve naming for internal req.
Date: Wed, 6 Sep 2017 16:01:43 +0200
In-Reply-To: <20170906134607.GC3960@infradead.org>
Cc: =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?utf-8?Q?Matias_Bj=C3=B8rling?= <matias@cnexlabs.com>
To: Christoph Hellwig <hch@infradead.org>
References: <1504695071-25928-1-git-send-email-javier@cnexlabs.com>
 <1504695071-25928-2-git-send-email-javier@cnexlabs.com>
 <20170906134607.GC3960@infradead.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


--Apple-Mail=_B7A1EF50-077B-4E7E-A7A5-0A3C33AA8178
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

> On 6 Sep 2017, at 15.46, Christoph Hellwig <hch@infradead.org> wrote:
> 
>> -#define ERASE 2 /* READ = 0, WRITE = 1 */
>> +/* READ = 0, WRITE (user) = 1 */
>> +#define ERASE 2
>> +#define WRITE_INT 3 /* Internal write. Not through write buffer */
> 
> enum {
> 	PBLK_READ,
> 	PBLK_WRITE,
> 	PBLK_ERASE,
> 	PBLK_WRITE,
> };
> 
> please.  Don't abuse and overload the messy READ/WRITE macros in any
> new code.

Ok. I'll resend.

Javier

--Apple-Mail=_B7A1EF50-077B-4E7E-A7A5-0A3C33AA8178
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJZr//HAAoJEGMfBTt1mRjK1OIP/jqBXgLloo3kjoia7MsaHDn4
dNMJ/aeOK/OWtM2mgeA824jbMzZXuBCS4/j6h9VqFRTbeRivINFV39XX/E5zHlM5
hRFhyUG5Hqp3upVHXE5WwAh6LLeyonxWkqLCST6ilOQF2s/6gVg+ATXGCwYWKgWA
GQvF2MBXraE7AF5Ltjhn1w2JaOrKOPbHh1bChekAttbmWi4mon3viGPLjdigtDdx
XIWH3p/Tw8hlQluxNc7gajS8D7z/hRh3b2Z5H+3RGYOQ0DiI9P431CZjpLAs6fXJ
aSnL1BVhYfdtLI4o67gOeNldz6K40pDD+93h/0zd/kpsGOMVNbrFO+1+IWPCucm/
nUCE8QXj/qNJdo/oxDiCLwaJ1QiJShlKtO0V2UVWIQy0lsO3tnAXzRijJ8frIe84
+gavowgIcxdwiISofQk21fGF2FT3Ptaz7OsksI7MTeN7MCbxk58rjJN2f4EhINNf
plc1yR2LBlt2daJiFbfxBjJqYA9uifmOoBxZ/ROuRg5Zd6zM+g42AVR/Dc4B1YhS
UNIcpfdIwV5b+M3MEoZPdAaYnLAsnGgBezx5yvlw5n+Xcn/RSC4h6FmcXI/JZee6
nBE2BfTw9GR2fD4i9DmrfYhzE8wCt7Zn1Jet6S+24ACvUVXczrQytPDl7i1TBJsz
7rl5TR5KYsGTqsYbJYAb
=78AZ
-----END PGP SIGNATURE-----

--Apple-Mail=_B7A1EF50-077B-4E7E-A7A5-0A3C33AA8178--
