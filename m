Return-Path: <SRS0=9W5b=XZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35456C32792
	for <linux-block@archiver.kernel.org>; Mon, 30 Sep 2019 20:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF59E22508
	for <linux-block@archiver.kernel.org>; Mon, 30 Sep 2019 20:39:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sMUNKTom"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730500AbfI3UjE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Sep 2019 16:39:04 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36194 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729636AbfI3UjE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Sep 2019 16:39:04 -0400
Received: by mail-wm1-f68.google.com with SMTP id m18so870558wmc.1;
        Mon, 30 Sep 2019 13:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:from:autocrypt:subject:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=aN7jZe7vdOWwmhl3JCTc+HLLeWrJF5XQXdUEeYV5ogM=;
        b=sMUNKTomr8shA/5arBH/Ksp45GwqlsYYackOPmuV1awfsAt5tYrhpXcxkrx+TQAl0f
         7enNh6Aq62WmC7Rd4CcXKhYyxjhZYbeALKnKRmkaPBT4CWolRKhRY4e5hemNsdfGP2Ry
         kqkLAGWgSlOZ/wWyojWck0O7SoZrg1YVoXG2U60B6hSObRsyN+7/3UTowsdhkFoyk9b0
         DpvRXNFxCLNRLjba7F9+hCDupmzhX8Z+XGp8AKOP70gcT8nBVm+4oNl5m1ud08E4EV8n
         /P3Pp4mIHm6q3ZGrSWG+HwRSL+y6famrCLaikjneZ04qMF+i7B7MANb1QB1GbyphalfK
         r7iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:autocrypt:subject
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=aN7jZe7vdOWwmhl3JCTc+HLLeWrJF5XQXdUEeYV5ogM=;
        b=srLZsoS4CpHcfuU+xZfjwdUEOAqJsELZdgWKxwuwSSt5nfmu3tqAy2RtJgkksf+rX0
         WxbQXCzh/XwuqMIhm7hTunWAefP/ah3Yd2qWgy6IJ79kCYYOKFDEz7SaL9kWIZm5SHLj
         PqwN9W1SGyBnckhRSlTRSXo35h2AXdd1XqH/AU0bmGnY19gp7GjMrJS+fH7IMV/eZXO6
         eJv5EGK0Vy6r+txRT2Z/kAFb4xdu+cKFiwVT5KCRnrbtWQFLmsNqpyU/vUZgCfgYboFd
         FPcgzrol8Wr1Il88QgZWaWmOveXbrVmAinKx0nwcjhVcsW/RAEhswU2J9U+zS51+CGyW
         NEzQ==
X-Gm-Message-State: APjAAAXrGkaWzQSJR520Uwq/jx45tL7koEJCHBIJ9mRV/u4sx4TQUVqp
        OxbC6iqgGJ0mvNRhduOGX/89uL2MFFU=
X-Google-Smtp-Source: APXvYqyRWdUE0PPEgBVJFNhk59Na8z/sk7UHGtVvSg+ky6v+IO2ChMibvzXVgOxFk5bMxrTnkzM+mg==
X-Received: by 2002:a1c:a6ca:: with SMTP id p193mr598686wme.103.1569872723928;
        Mon, 30 Sep 2019 12:45:23 -0700 (PDT)
Received: from [192.168.43.187] ([109.126.142.9])
        by smtp.gmail.com with ESMTPSA id d9sm16611885wrf.62.2019.09.30.12.45.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Sep 2019 12:45:23 -0700 (PDT)
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1cd320dad54bd78cb6721f7fe8dd2e197b9fbfa2.1569830796.git.asml.silence@gmail.com>
 <20190930083551.GB24152@infradead.org>
From:   Pavel Begunkov <asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Subject: Re: [PATCH 1/1] blk-mq: Inline status checkers
Message-ID: <16187bf2-b3ff-651c-ddb3-24e38c78dcf0@gmail.com>
Date:   Mon, 30 Sep 2019 22:45:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190930083551.GB24152@infradead.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="zku54IseC1yd4rl5154z91LeZWSKyMPCU"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--zku54IseC1yd4rl5154z91LeZWSKyMPCU
Content-Type: multipart/mixed; boundary="yazEqJC8wYDXiMEzqE5RCr1CFTGzz2QZS";
 protected-headers="v1"
From: Pavel Begunkov <asml.silence@gmail.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <16187bf2-b3ff-651c-ddb3-24e38c78dcf0@gmail.com>
Subject: Re: [PATCH 1/1] blk-mq: Inline status checkers
References: <1cd320dad54bd78cb6721f7fe8dd2e197b9fbfa2.1569830796.git.asml.silence@gmail.com>
 <20190930083551.GB24152@infradead.org>
In-Reply-To: <20190930083551.GB24152@infradead.org>

--yazEqJC8wYDXiMEzqE5RCr1CFTGzz2QZS
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 30/09/2019 11:35, Christoph Hellwig wrote:
> On Mon, Sep 30, 2019 at 11:25:49AM +0300, Pavel Begunkov (Silence) wrot=
e:
>> From: Pavel Begunkov <asml.silence@gmail.com>
>>
>> blk_mq_request_completed() and blk_mq_request_started() are
>> short, inline it.
>>
>> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
>> ---
>>  block/blk-mq.c         | 12 ------------
>>  block/blk-mq.h         |  9 ---------
>>  include/linux/blk-mq.h | 20 ++++++++++++++++++--
>>  3 files changed, 18 insertions(+), 23 deletions(-)
>>
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index 279b138a9e50..d97181d9a3ec 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -647,18 +647,6 @@ bool blk_mq_complete_request(struct request *rq)
>>  }
>>  EXPORT_SYMBOL(blk_mq_complete_request);
>> =20
>> -int blk_mq_request_started(struct request *rq)
>> -{
>> -	return blk_mq_rq_state(rq) !=3D MQ_RQ_IDLE;
>> -}
>> -EXPORT_SYMBOL_GPL(blk_mq_request_started);
>> -
>> -int blk_mq_request_completed(struct request *rq)
>> -{
>> -	return blk_mq_rq_state(rq) =3D=3D MQ_RQ_COMPLETE;
>> -}
>> -EXPORT_SYMBOL_GPL(blk_mq_request_completed);
>=20
> How about just killing these helpers instead?
>=20
I'm not sure that this is better. That's more intrusive and
blk_mq_request_started() looks clearer than
(blk_mq_rq_state(rq) !=3D MQ_RQ_IDLE).

Anyway, I've sent v2 and fine with both.


--=20
Yours sincerely,
Pavel Begunkov


--yazEqJC8wYDXiMEzqE5RCr1CFTGzz2QZS--

--zku54IseC1yd4rl5154z91LeZWSKyMPCU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+6JuPTjTbx479o3OWt5b1Glr+6UFAl2SW1UACgkQWt5b1Glr
+6WWahAAop/MNFxScnFlkhWLrjN9LkLpexj8NwAtrPaFflOo3k1Ldz3z1UFlkSPd
EZTcczq5SpdHJGsGoI47aSvEH8CzSU/nn9e3RAaRCoyV4CeEVk/KYJq4vqNYSeV1
VRrBCyw0tc+Rm7vyWWFm2wX5vZaXRiPGTIPgwRLFmpMcqoEG8DphVBCVpzdDKRAI
LI/rnt9ela0IXvUG1DlHnNtW3N9j2eMtpJHJFM9tDbKdUnuJRPrmEvH8MsjgDav9
iLvYoUVJWQIbcRkgTnEQuptcKDhR/NY4cR4DN3UsdsB1sPm6wRn2uDfUeg5ixUZT
oOU3YUa70adCXQ6TjUQIHaLniPFF4m2hODhtIxgY8SoQ0/sQvfcGleplXcRWqqlF
KckUiVPnJMOLz0swgkYtf0mKqouU4MEPuL8lGx0pSwlvm05q5qsReDdnvQRyE//H
Bua3APWQCVPTCE22lnWz3mPGEWdXQm7qc9wwRHb3jd9xl2wT6Zs8FofIOY/6txeA
J6KcPhE7ooXuirzu6qYztnVzlKP4mr/IO9r0ib6Pc+9cL0Yggt46UsEwgLtkiVil
j10ENgwaVQI3CzMLy3EVnHxHq7cK4/8kGfGcp0OSjtz4XdFQHTA2P/f9C50xobK9
60b+l+Fa/z2XSxzShLu1GD3zIzreVKLqrFT7AZF1xiM7P7oJoAQ=
=fkMW
-----END PGP SIGNATURE-----

--zku54IseC1yd4rl5154z91LeZWSKyMPCU--
