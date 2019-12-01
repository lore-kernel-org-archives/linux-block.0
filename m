Return-Path: <SRS0=5p5X=ZX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF295C43215
	for <linux-block@archiver.kernel.org>; Sun,  1 Dec 2019 00:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8583220873
	for <linux-block@archiver.kernel.org>; Sun,  1 Dec 2019 00:05:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K8Lu7LPB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbfLAAFD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 30 Nov 2019 19:05:03 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54187 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726212AbfLAAFD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 30 Nov 2019 19:05:03 -0500
Received: by mail-wm1-f65.google.com with SMTP id u18so17703980wmc.3;
        Sat, 30 Nov 2019 16:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:from:autocrypt:subject:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=8K5JMOOJuDsKtyEmvfdHN8uQfnjcYzaCihRkp/YDARc=;
        b=K8Lu7LPBCX0KlH/pacz/x+73K3l4cTJzWA+gT3N/yFqL7etKpVwsb9HvE1pRRAtMh9
         eOHJeFA+7dZDdFNRdd6OmDAeNCsxfTECAP++dGGH4UipWrSfvhSgVgrEwNNRabfWxJ53
         uafgsAvX/6WKunPtoO62bwekK6s2krfTey+RmWx/lo9zAVD+ds6ZReMR8LsMECKEUOxB
         lnYpvECYsGuC1FfDJ11GF2yomYuxR00d43pCyhHqzTAkNwrsmGHF7Bbn5pkYoZtzzP2G
         lPfT8ATI+HiCczeJ2gJmecDp6t50S1RdRtsttUSC2vYtAI51sQZpFJN7gusid9+unkXb
         Ys4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:autocrypt:subject
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=8K5JMOOJuDsKtyEmvfdHN8uQfnjcYzaCihRkp/YDARc=;
        b=aXSLQktxy20qz/Pv/QbBJnxrUP1vYMN7+XBzjvReSCv3OMbbjnXdsf18glVU1Aq59l
         lIS0jiLxRj6wYnipMKVHtq36YwJMTDyb8BiKnl1i24VBSSOYkS1tzOgWoRvBmdwK3+Sq
         oTnFNWFfN7/JrjEB8+CDnvdkPO8TGYIZTYutnsDHRXcZiFEMRQtrXcfxOLDx0LUsvOgt
         KBJ38PhpdH8l3MRxg4Ab4EERW9R81EKHbZAQc3y79N05iGNYNB79I5WSw7SY7MOhDWaY
         8njy7R8NqvTBOtQR0cRNkqggJAIZffnMvtCjLwx0GOB8iGz4H1ucO4JihR495cVEDHdP
         LnHQ==
X-Gm-Message-State: APjAAAXGn9LZtI7JlqeHwjh6NYJE6t3jIiYw0+tRmf3F0JIybMKJ7hlA
        82JHtxhNb/usBIP6NDkLI0tqh9y+
X-Google-Smtp-Source: APXvYqysgyZlyi5VWunIMaOudty5vDhVLYAUgsnIqcINuuhd2Mk/VYSDa4ZOvX+A9pdsYfesD2ODLw==
X-Received: by 2002:a1c:a750:: with SMTP id q77mr22444042wme.76.1575158700625;
        Sat, 30 Nov 2019 16:05:00 -0800 (PST)
Received: from [192.168.43.93] ([109.126.143.74])
        by smtp.gmail.com with ESMTPSA id 72sm34387300wrl.73.2019.11.30.16.04.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Nov 2019 16:04:59 -0800 (PST)
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1575144884.git.asml.silence@gmail.com>
 <b1408bd6cc3f04fe22ce64f97174b6fbf9ffea40.1575144884.git.asml.silence@gmail.com>
 <20191130220458.GA297712@rani.riverdale.lan>
From:   Pavel Begunkov <asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Subject: Re: [PATCH v2] block: optimise bvec_iter_advance()
Message-ID: <74c78d40-8b0c-2e87-d882-8396411a7be5@gmail.com>
Date:   Sun, 1 Dec 2019 03:04:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191130220458.GA297712@rani.riverdale.lan>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="CHTm4B0gVqLHJKOFLU00v8vDHQ3itIuQZ"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CHTm4B0gVqLHJKOFLU00v8vDHQ3itIuQZ
Content-Type: multipart/mixed; boundary="nRL8HNEAHx3wbdctGV9uh9llvEhqWdbVD";
 protected-headers="v1"
From: Pavel Begunkov <asml.silence@gmail.com>
To: Arvind Sankar <nivedita@alum.mit.edu>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <74c78d40-8b0c-2e87-d882-8396411a7be5@gmail.com>
Subject: Re: [PATCH v2] block: optimise bvec_iter_advance()
References: <cover.1575144884.git.asml.silence@gmail.com>
 <b1408bd6cc3f04fe22ce64f97174b6fbf9ffea40.1575144884.git.asml.silence@gmail.com>
 <20191130220458.GA297712@rani.riverdale.lan>
In-Reply-To: <20191130220458.GA297712@rani.riverdale.lan>

--nRL8HNEAHx3wbdctGV9uh9llvEhqWdbVD
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 01/12/2019 01:05, Arvind Sankar wrote:
> On Sat, Nov 30, 2019 at 11:23:52PM +0300, Pavel Begunkov wrote:
>> bvec_iter_advance() is quite popular, but compilers fail to do proper
>> alias analysis and optimise it good enough. The assembly is checked
>> for gcc 9.2, x86-64.
>>
>> - remove @iter->bi_size from min(...), as it's always less than @bytes=
=2E
>> Modify at the beginning and forget about it.
>>
>> - the compiler isn't able to collapse memory dependencies and remove
>> writes in the loop. Help it by explicitly using local vars.
>>
>> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
>> ---
>>
>> v2: simplify code (Arvind Sankar)
>>
>=20
> Thanks :)
>=20
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
>=20
> Btw, I discovered that gcc 9.2 doesn't optimize away the second
> comparison in something like

That's unfortunate. IDK, whether it could be easily done in gcc,
but maybe relay it to compiler guys?

>=20
> 	m =3D min(a,b);
> 	return m>a;
>=20
> So the WARN_ONCE bit doesn't get optimized away even in cases like
> bio_for_each_bvec where it's guaranteed at compile-time to not trigger.=

>=20

That's more like a starting point. The idea is to revise and
tune/rewrite iteration helpers including *for_each_bvec(). I assume,
all those are really poorly optimisable (especially with
-fno-strict-aliasing). So, noted to consider

--=20
Pavel Begunkov


--nRL8HNEAHx3wbdctGV9uh9llvEhqWdbVD--

--CHTm4B0gVqLHJKOFLU00v8vDHQ3itIuQZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+6JuPTjTbx479o3OWt5b1Glr+6UFAl3jA5oACgkQWt5b1Glr
+6V2vA//Q9Y17xFB7dLIXrxr8SSpVI/+BIg0h0ySn/HcPiW9T4I8anzmPkXCx0FP
0tt1dl2UhlZN+PwudjQnePNOnO4l29XyfU5UYc78aecm3n68zJJ8xQqPq8n1gZH8
Hx1GoHarsrWIXAR6d1XRM+fesHRdm7SbpIomblooCGfS0dXlx0u7gQLDM5sstQXX
VOhTipaDpgX/qFyYkce3+fF46JnVwgJevEoYSjPPpmrXqnek0l8RovObjVu5WZYN
uAlbmKnDhfpuBrz95lkz2WwobUPdu8Y2U9WYaXXB4pjvnXSH3+jArcTTBhk6/Fie
nbqshXb8R6jkSx6lt7RUe+HHjblzqi+sYGaN7sCEJT4Uawk6V/hQf/sw6yONb9ZD
ElxvCtTpUntwK5SI1MPogz052wMF/5jklU++9OkQGbP3HU6BcsoSXo96ezklqwx7
8WqRSr7D9RpBFcLXjFL8UNh0W2ZKh6npyi0Viq5nPVshst3ZkFR7oG+EYpNP3tSi
UgZ3NswymZPPM9a8Dk/W4jzLxjP1QZOO76V+0+DoxxRoJoJ+Q1mRsdkFPRF+G+Nj
IQyE1fckYgiOppobJ7N29t4veIJEWpGTkx23PQyo1vmCs+wuZCCHFbpjQstuOun0
IuifOqdh+z7AzlgU0gRtjpGee9pnbizDDOkpZdjIYzXtmXsOFFI=
=tmSe
-----END PGP SIGNATURE-----

--CHTm4B0gVqLHJKOFLU00v8vDHQ3itIuQZ--
