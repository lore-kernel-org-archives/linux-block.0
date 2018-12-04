Return-Path: <SRS0=ovnK=ON=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE97EC04EB8
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 22:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86D0F20834
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 22:28:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86D0F20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=willer.it
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725895AbeLDW2o (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Dec 2018 17:28:44 -0500
Received: from mail-wr1-f41.google.com ([209.85.221.41]:46280 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbeLDW2o (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Dec 2018 17:28:44 -0500
Received: by mail-wr1-f41.google.com with SMTP id l9so17623141wrt.13
        for <linux-block@vger.kernel.org>; Tue, 04 Dec 2018 14:28:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=sdYSvM+3B4Xfdyg8pCZfzbPgKDpfIpo5nn+31ooOtXM=;
        b=qCcdOiimxOqQazNQEXbrp94GgtEJj+yyjy5BHQZmduyVdZsoLI+KOHKbsZhhuc8mSC
         ygplUb94u2aV3If+I+IdloNt7bai1KBmtX4j3N75dDWoCm08aLIycF431phrh0v0pvf/
         jlEtX5gtlUtq7+qGeVfxKB0CHZVHJaVPDWu99x+GjFXXOE32yJj/rKsezsJO72ZhYu6d
         +t82NdZqSUT4UMa9OuFrKWsW/G+oQxXnHPO8V8n8QPjdPew2S+eu444MYzV5dSE0h4Xr
         VcXCu/u6F0tJmxMnZdYOEgewIB1eeZTQhJT0UjZeIwADa0sRjXERGMz7tDq7cFbN/NO1
         KS6A==
X-Gm-Message-State: AA+aEWYko+ROO/40G+4f3h8FU0ymOmbCeekpupMb63OkgIcUPFK4cX73
        IGESXIbFS3LP9ozfBntIWXM=
X-Google-Smtp-Source: AFSGD/XPoQUOp1Cs/rlsrmC2eyvNF11fZgwrRpH+2N4Y6cg5nFybcWizDPxGlsfs0tX5c8JvslazsA==
X-Received: by 2002:adf:e983:: with SMTP id h3mr18977530wrm.232.1543962521733;
        Tue, 04 Dec 2018 14:28:41 -0800 (PST)
Received: from [192.168.1.8] (net-2-37-146-146.cust.vodafonedsl.it. [2.37.146.146])
        by smtp.gmail.com with ESMTPSA id u204sm12716619wmu.30.2018.12.04.14.28.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 14:28:40 -0800 (PST)
Subject: Re: [PATCH 2/3] blktests: add python scripts for parsing fio json
 output
To:     Josef Bacik <josef@toxicpanda.com>, linux-block@vger.kernel.org,
        kernel-team@fb.com, osandov@fb.com
References: <20181204174733.7423-1-josef@toxicpanda.com>
 <20181204174733.7423-3-josef@toxicpanda.com>
From:   Federico Motta <federico@willer.it>
Openpgp: preference=signencrypt
Autocrypt: addr=federico@willer.it; keydata=
 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
Message-ID: <9af3232a-cef4-eeb0-98c5-07a9871c2f77@willer.it>
Date:   Tue, 4 Dec 2018 23:28:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <20181204174733.7423-3-josef@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="MbqN3Dnwzd1hCfcXoDH7O5T7cQWQ8lIbQ"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MbqN3Dnwzd1hCfcXoDH7O5T7cQWQ8lIbQ
Content-Type: multipart/mixed; boundary="Mb6brYPtonIr2WbGmTwD71LMYwvRPPgV1";
 protected-headers="v1"
From: Federico Motta <federico@willer.it>
To: Josef Bacik <josef@toxicpanda.com>, linux-block@vger.kernel.org,
 kernel-team@fb.com, osandov@fb.com
Message-ID: <9af3232a-cef4-eeb0-98c5-07a9871c2f77@willer.it>
Subject: Re: [PATCH 2/3] blktests: add python scripts for parsing fio json
 output
References: <20181204174733.7423-1-josef@toxicpanda.com>
 <20181204174733.7423-3-josef@toxicpanda.com>
In-Reply-To: <20181204174733.7423-3-josef@toxicpanda.com>

--Mb6brYPtonIr2WbGmTwD71LMYwvRPPgV1
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 12/4/18 6:47 PM, Josef Bacik wrote:
> I wrote these scripts for xfstests, just copying them over to blktests
> as well.  The terse output fio support that blktests doesn't get all of=

> the various fio performance things that we may want to look at, this
> gives us a lot of flexibility around getting specific values out of the=

> fio results data.
>=20
Hi,
some suggestions below :)

> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  src/FioResultDecoder.py | 64 +++++++++++++++++++++++++++++++++++++++++=
++++++++
>  src/fio-key-value.py    | 28 ++++++++++++++++++++++
>  2 files changed, 92 insertions(+)
>  create mode 100644 src/FioResultDecoder.py
>  create mode 100644 src/fio-key-value.py
>=20
> diff --git a/src/FioResultDecoder.py b/src/FioResultDecoder.py
> new file mode 100644
> index 000000000000..d004140c0fdf
> --- /dev/null
> +++ b/src/FioResultDecoder.py
> @@ -0,0 +1,64 @@
I think a shebang could clarify this runs under python2.

> +# SPDX-License-Identifier: GPL-2.0
> +
> +import json
> +
> +class FioResultDecoder(json.JSONDecoder):
> +    """Decoder for decoding fio result json to an object for our datab=
ase
> +
> +    This decodes the json output from fio into an object that can be d=
irectly
> +    inserted into our database.  This just strips out the fields we do=
n't care
> +    about and collapses the read/write/trim classes into a flat value =
structure
> +    inside of the jobs object.
> +
> +    For example
> +        "write" : {
> +            "io_bytes" : 313360384,
> +            "bw" : 1016,
> +        }
> +
> +    Get's collapsed to
> +
> +        "write_io_bytes" : 313360384,
> +        "write_bw": 1016,
> +
> +    Currently any dict under 'jobs' get's dropped, with the exception =
of 'read',
> +    'write', and 'trim'.  For those sub sections we drop any dict's un=
der those.
> +
> +    Attempt to keep this as generic as possible, we don't want to brea=
k every
> +    time fio changes it's json output format.
> +    """
> +    _ignore_types =3D ['dict', 'list']
> +    _override_keys =3D ['lat_ns', 'lat']
> +    _io_ops =3D ['read', 'write', 'trim']
> +
> +    _transform_keys =3D { 'lat': 'lat_ns' }
> +
> +    def decode(self, json_string):
> +        """This does the dirty work of converting everything"""
> +        default_obj =3D super(FioResultDecoder, self).decode(json_stri=
ng)
> +        obj =3D {}
> +        obj['global'] =3D {}
> +        obj['global']['time'] =3D default_obj['time']
> +        obj['jobs'] =3D []
> +        for job in default_obj['jobs']:
> +            new_job =3D {}
> +            for key,value in job.iteritems():
> +                if key not in self._io_ops:
> +                    if value.__class__.__name__ in self._ignore_types:=

> +                        continue
> +                    new_job[key] =3D value
> +                    continue
> +                for k,v in value.iteritems():
> +                    if k in self._override_keys:
> +                        if k in self._transform_keys:
> +                            k =3D self._transform_keys[k]
> +                        for subk,subv in v.iteritems():
> +                            collapsed_key =3D "{}_{}_{}".format(key, k=
, subk)
> +                            new_job[collapsed_key] =3D subv
> +                        continue
> +                    if v.__class__.__name__ in self._ignore_types:
> +                        continue
> +                    collapsed_key =3D "{}_{}".format(key, k)
> +                    new_job[collapsed_key] =3D v
> +            obj['jobs'].append(new_job)
> +        return obj
> diff --git a/src/fio-key-value.py b/src/fio-key-value.py
> new file mode 100644
> index 000000000000..208e9a453a19
> --- /dev/null
> +++ b/src/fio-key-value.py
> @@ -0,0 +1,28 @@
Also here a shebang could be fine.

> +# SPDX-License-Identifier: GPL-2.0
> +
> +import FioResultDecoder
> +import json
> +import argparse
> +import sys
> +import platform
> +
> +parser =3D argparse.ArgumentParser()
> +parser.add_argument('-j', '--jobname', type=3Dstr,
> +                    help=3D"The jobname we want our key from.",
> +                    required=3DTrue)
> +parser.add_argument('-k', '--key', type=3Dstr,
> +                    help=3D"The key we want the value of", required=3D=
True)
> +parser.add_argument('result', type=3Dstr,
If here you set type=3Dopen              ^

> +                    help=3D"The result file read")
> +args =3D parser.parse_args()
> +
> +json_data =3D open(args.result)
you could avoid this line ^

> +data =3D json.load(json_data, cls=3DFioResultDecoder.FioResultDecoder)=

and substitute json_data with args.result which would return a file objec=
t.

In short the above piece of patch would become something like:

parser.add_argument('result', type=3Dopen, help=3D"The result file read")=

args =3D parser.parse_args()
data =3D json.load(args.result, cls=3DFioResultDecoder.FioResultDecoder)

Which still raises IOError if bad arguments are passed.

> +
> +for job in data['jobs']:
> +    if job['jobname'] =3D=3D args.jobname:
> +        if args.key not in job:
> +            print('')
> +        else:
> +            print("{}".format(job[args.key]))
> +        break
>=20


Have a nice day,
Federico


--Mb6brYPtonIr2WbGmTwD71LMYwvRPPgV1--

--MbqN3Dnwzd1hCfcXoDH7O5T7cQWQ8lIbQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEAREKAB0WIQQjpLt31k10FTLpDwzdnkSUycSdYAUCXAb/lwAKCRDdnkSUycSd
YJsOAP9cIqEjNzQpCclwH/RNG2DyWw0O/hTBrQvlNDjvQTaACgD3TwqlDp/5NHNh
IlgQAjytRF/JKKo8ei1vg5iPrPB9zQ==
=9Xmv
-----END PGP SIGNATURE-----

--MbqN3Dnwzd1hCfcXoDH7O5T7cQWQ8lIbQ--
