Return-Path: <SRS0=gXx0=YU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73409CA9EAF
	for <linux-block@archiver.kernel.org>; Sun, 27 Oct 2019 17:37:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A79120679
	for <linux-block@archiver.kernel.org>; Sun, 27 Oct 2019 17:37:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fKkqjyvQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbfJ0Rh0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 27 Oct 2019 13:37:26 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41873 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726930AbfJ0Rh0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 27 Oct 2019 13:37:26 -0400
Received: by mail-wr1-f67.google.com with SMTP id p4so7491766wrm.8;
        Sun, 27 Oct 2019 10:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=wdifRDOsJdDjPHlJdct9xteQ58pRMgHevCJJNfD3tLc=;
        b=fKkqjyvQseEQToRxbtFHyiAi+YFKvOP76ZorEfRuUX6xUyNZsOzjKo04Vbc4fEfWzQ
         EQeg8Mq72u9uQAmbFH+A1muhk1cLJQ8WTj2ne4JthAZXX1y8iuzuo0ul1PUX0Th+QRI7
         Zpu/hKOfPBkr02fA5NZc3ObipyYs8R3eIMxaxTWLLKdwEvCv5P7Cyk5PMNPNr3NcdYUV
         +F0MV9iYgCDQ3ATnLNFQwSQETtEeO7/9OzuhnB+Qf9pGz6U/ik9kob/X0ckl5+P2IYOm
         bD4LQHUW9VRkZOnuFVe2h6PQFiWryjiLlWEch4VyEOrPRDJrauICTHnKQMhq6TAmMtDe
         YUww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to;
        bh=wdifRDOsJdDjPHlJdct9xteQ58pRMgHevCJJNfD3tLc=;
        b=gc8PNIF4iQ8vpV251qOvtFJeZKUSw3/TxYWLKtA6Ubf1Epwrq4gxMp2N/JzlJCRNOM
         gz3Zd1lGQeZdMOkjXElTNmsYjsbqRH259JVWMySUaohtNUC4aQlvTxd0GVXnxBQfQgdC
         /GTMQ+OYY0+Y/OdL8IXdBeSPvvAtRkso3W8NkkU4tzthGL267O+ZCgNKhxVJl/tfqkMu
         VlurCJCOgkhvqhdfB6wmj08xxaywimYi+Iwtc85rMi5SUBIjIO4nNS/bvIBmoj8ddl5H
         cegvQf3DzHffEKq+z2ggpxaDGDvCX9JN1Slnop7Js4QY53iyM/3eMy+InMKFO3hIwzoW
         O6TQ==
X-Gm-Message-State: APjAAAX0EFFp+GzceenSx8ORKwh+0JZVjNH3jBbJHuMzEGtNhwRh3uHS
        3HAP6Ak5BsPuafJPR1QxFBms5ta2
X-Google-Smtp-Source: APXvYqwij6y/IOt4UyHYySaKXa4fiWw2S4XoC31ZVN3+FuQG+MAzCMq5ztGd8X5LwK7cz7o709UHUw==
X-Received: by 2002:adf:c401:: with SMTP id v1mr11362525wrf.375.1572197842678;
        Sun, 27 Oct 2019 10:37:22 -0700 (PDT)
Received: from [192.168.43.222] ([109.126.132.16])
        by smtp.gmail.com with ESMTPSA id h124sm1611456wmf.30.2019.10.27.10.37.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Oct 2019 10:37:21 -0700 (PDT)
Subject: Re: [PATCH 0/2][for-next] cleanup submission path
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1572189860.git.asml.silence@gmail.com>
 <666ed447-ba8f-29e7-237f-de8044aa63ea@kernel.dk>
 <5ec9bd14-d8f2-32e6-7f25-0ca7256c408a@gmail.com>
 <aac65fe2-6c51-3baf-eee7-af5a8f633bf2@kernel.dk>
 <d39a878f-9dac-1457-6bba-01afc6268a84@kernel.dk>
 <57db9960-0b31-9f40-c13b-1db6dcc88920@gmail.com>
 <02a25d12-1f44-de18-f233-b5421c608469@kernel.dk>
From:   Pavel Begunkov <asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Message-ID: <2ab7134b-2f09-55af-b808-bb6f1285ce16@gmail.com>
Date:   Sun, 27 Oct 2019 20:37:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <02a25d12-1f44-de18-f233-b5421c608469@kernel.dk>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="eW966YNqTlJGKzQ6ae8NnCi8WmClhceT0"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--eW966YNqTlJGKzQ6ae8NnCi8WmClhceT0
Content-Type: multipart/mixed; boundary="Xvb36k2riyaievWDGC3zShEzzSb24GcKD";
 protected-headers="v1"
From: Pavel Begunkov <asml.silence@gmail.com>
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <2ab7134b-2f09-55af-b808-bb6f1285ce16@gmail.com>
Subject: Re: [PATCH 0/2][for-next] cleanup submission path
References: <cover.1572189860.git.asml.silence@gmail.com>
 <666ed447-ba8f-29e7-237f-de8044aa63ea@kernel.dk>
 <5ec9bd14-d8f2-32e6-7f25-0ca7256c408a@gmail.com>
 <aac65fe2-6c51-3baf-eee7-af5a8f633bf2@kernel.dk>
 <d39a878f-9dac-1457-6bba-01afc6268a84@kernel.dk>
 <57db9960-0b31-9f40-c13b-1db6dcc88920@gmail.com>
 <02a25d12-1f44-de18-f233-b5421c608469@kernel.dk>
In-Reply-To: <02a25d12-1f44-de18-f233-b5421c608469@kernel.dk>

--Xvb36k2riyaievWDGC3zShEzzSb24GcKD
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 27/10/2019 20:26, Jens Axboe wrote:
> On 10/27/19 11:19 AM, Pavel Begunkov wrote:
>> On 27/10/2019 19:56, Jens Axboe wrote:
>>> On 10/27/19 10:49 AM, Jens Axboe wrote:
>>>> On 10/27/19 10:44 AM, Pavel Begunkov wrote:
>>>>> On 27/10/2019 19:32, Jens Axboe wrote:
>>>>>> On 10/27/19 9:35 AM, Pavel Begunkov wrote:
>>>>>>> A small cleanup of very similar but diverged io_submit_sqes() and=

>>>>>>> io_ring_submit()
>>>>>>>
>>>>>>> Pavel Begunkov (2):
>>>>>>>       io_uring: handle mm_fault outside of submission
>>>>>>>       io_uring: merge io_submit_sqes and io_ring_submit
>>>>>>>
>>>>>>>      fs/io_uring.c | 116 ++++++++++++++--------------------------=
----------
>>>>>>>      1 file changed, 33 insertions(+), 83 deletions(-)
>>>>>>
>>>>>> I like the cleanups here, but one thing that seems off is the
>>>>>> assumption that io_sq_thread() always needs to grab the mm. If
>>>>>> the sqes processed are just READ/WRITE_FIXED, then it never needs
>>>>>> to grab the mm.
>>>>>> Yeah, we removed it to fix bugs. Personally, I think it would be
>>>>> clearer to do lazy grabbing conditionally, rather than have two
>>>>> functions. And in this case it's easier to do after merging.
>>>>>
>>>>> Do you prefer to return it back first?
>>>>
>>>> Ah I see, no I don't care about that.
>>>
>>> OK, looked at the post-patches state. It's still not correct. You are=

>>> grabbing the mm from io_sq_thread() unconditionally. We should not do=

>>> that, only if the sqes we need to submit need mm context.
>>>
>> That's what my question to the fix was about :)
>> 1. Then, what the case it could fail?
>> 2. Is it ok to hold it while polling? It could keep it for quite
>> a long time if host is swift, e.g. submit->poll->submit->poll-> ...
>>
>> Anyway, I will add it back and resend the patchset.
>=20
> If possible in a simple way, I'd prefer if we do it as a prep patch and=

> then queue that up for 5.4 since we now lost that optimization.  Then
> layer the other 2 on top of that, since I'll just rebase the 5.5 stuff
> on top of that.

Sure, will do this way. There won't be much difference.

>=20
> If not trivially possible for 5.4, then we'll just have to leave with i=
t
> in that release. For that case, you can fold the change in with these
> two patches.
>=20

--=20
Yours sincerely,
Pavel Begunkov


--Xvb36k2riyaievWDGC3zShEzzSb24GcKD--

--eW966YNqTlJGKzQ6ae8NnCi8WmClhceT0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+6JuPTjTbx479o3OWt5b1Glr+6UFAl211cwACgkQWt5b1Glr
+6XIIQ/7B2WyxXfRrxwLpuJgGCVLilg4Pbw7UBhLKUlmoErlsvfSf8Mkg5YvKEXi
hDcbZlXyLD7NMcHPuZbHGD3Ud/seZAbxojpqO6I90kqfE3bPgUCYhtWxG+0+eem2
awsm7uLSIQmLN+qdZwxpkFiC7BCOmV5IsyrH+BeoywOegqYW2UC97HcBXS1DMg6w
V/gx/77cs94FK8aPtKf0WdsqcaAkTeV6hRCLOQcgMPmQHnPJWyeWqM9/2vvoHcPb
WnuD4p1Y+XtQZYiS0EiC16f8PSqIrS2+xkMPI+Um3aEw+IYhiU0BkieHVS8/zypB
60i+N/6/hzrw+BomIUwBjyhU00krzeRwoNuAZWzUI4/DWUl1pJu7vDVgwLrOzOkV
kok+pTur6Nq1poPkyGoIs9NSyMdllm0wn53OGj0aIqrDidloOb6ZL3oOOkCSAl/n
tfaO8BcRZ+rIuwOKGpSs/J0+DrtsN37G4bCoYGEDkZk7FjDYJEVk9Y6L9Hm4tOwV
IrCUcX9tyb0xwE+YvNeVtMPr64eLTvBA1i27uCTjGZ/z5OmdbPF0+2grQ4nkWSOT
MJvlUjHGgbfqVyi8xRt8LGyl0fH4Tzs1Tnpw+LsjGvlYFvFyQlxUcLRLnY6Jh5WM
0NEV8SbKbxgSnC8lmNnLewlVcRK2c0SNzCP+0aSO+6jLcJtxCws=
=7RTD
-----END PGP SIGNATURE-----

--eW966YNqTlJGKzQ6ae8NnCi8WmClhceT0--
