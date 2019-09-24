Return-Path: <SRS0=56XS=XT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B080C432C1
	for <linux-block@archiver.kernel.org>; Tue, 24 Sep 2019 06:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCB3620665
	for <linux-block@archiver.kernel.org>; Tue, 24 Sep 2019 06:44:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QBqX+MLM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391335AbfIXGoh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 Sep 2019 02:44:37 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35958 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391061AbfIXGog (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Sep 2019 02:44:36 -0400
Received: by mail-wr1-f65.google.com with SMTP id y19so554413wrd.3;
        Mon, 23 Sep 2019 23:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:from:autocrypt:subject:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=sMhvWgFPcuRwEHSjDUrW9cVesWXOZIMAHLptE0MuNEw=;
        b=QBqX+MLMzLwfcv4rjTHq36YVkhIVdd36xCVJjleugQ454LiZgIH0DvddlpC8jbcP/T
         SqB5dT/Nuo7zJXJJUmAsnP2SqMwOxSCx/hIGx8KChaFLZ7yBPf/kjAkCI3o9mQuiHUl5
         0z1ErbNmIC4SsfnZKcySfTlcVezJBbc1U8PCrPZDvDhGESaTsc34mW2XoyU9DK81IyAn
         IP/DFv5dl09T0v7jNehO591xm/UAnwspW8dHZeKwKkwVbUxSOV5dbO9uXYZuqKsNyvqn
         G4RZ7fPELkJS4MnIIYpzIojjk/3D/0ex9jaFK/vJobmtOvljpv4y7iB1WbP5yb2vaSa6
         YqSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:autocrypt:subject
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=sMhvWgFPcuRwEHSjDUrW9cVesWXOZIMAHLptE0MuNEw=;
        b=e7yjwYx8gTPaEKO4q0shdr/K4hPpjB+LHZ68zIhyKSY7fmwrmptfEENx4Jajm4XzJG
         iKJSQwGYZCPDG/pXbw9YhfRYje+GDzXZYFTdhTLtogPaYV0gopwQ3FT+b928EE76D655
         AkPQzoIh+t01DUNat2hirYmjpSP39HL1KLyIi/dOpeDO76OXKNYmxqgK3FPp2SBv3+YD
         cupJeZ47EVZO3/lCJYqf9JtVvLijW9VnUfGQn2OhVbQGwVKh5KU+htqiIhXM95DLjPON
         HORUtnj4S4ff60vsQpH67vgGvPYjlUWROZ66pVGeXhrLw0CEEgH7Tvp0stoBE/0YhJcF
         bpMw==
X-Gm-Message-State: APjAAAXkW1c6q8SQjWr2gtwFPI2Ncqf1pJPqdNt75vMVn8yyP0lbTlpt
        3CyDDk/rKSEJ6O5flByODuxkVHEcKdTykw==
X-Google-Smtp-Source: APXvYqyb+iPynmtaYm65GM7nJV4z7+3axzPlcXgCkxWf4Tkrr26u00AJ2MlS5kQJfj36bn15hwVNew==
X-Received: by 2002:adf:fe07:: with SMTP id n7mr896956wrr.90.1569307473107;
        Mon, 23 Sep 2019 23:44:33 -0700 (PDT)
Received: from [192.168.8.30] (lneuilly-656-1-59-14.w80-11.abo.wanadoo.fr. [80.11.63.14])
        by smtp.gmail.com with ESMTPSA id b194sm1447071wmg.46.2019.09.23.23.44.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2019 23:44:32 -0700 (PDT)
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Ingo Molnar <mingo@redhat.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1569139018.git.asml.silence@gmail.com>
 <d99ce2f7c98d4408aea50f515bbb6b89bc7850e8.1569139018.git.asml.silence@gmail.com>
 <20190923071932.GD2349@hirez.programming.kicks-ass.net>
 <3e359937-5b19-8a4c-4243-ba2edff68504@gmail.com>
 <20190923192742.GH2369@hirez.programming.kicks-ass.net>
From:   Pavel Begunkov <asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Subject: Re: [PATCH v2 1/2] sched/wait: Add wait_threshold
Message-ID: <8c83b046-5c8a-7303-5541-180c094c875e@gmail.com>
Date:   Tue, 24 Sep 2019 09:44:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190923192742.GH2369@hirez.programming.kicks-ass.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="wUDcp9ReHPFbKHIMBDPwE48ahAdhUiuKN"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wUDcp9ReHPFbKHIMBDPwE48ahAdhUiuKN
Content-Type: multipart/mixed; boundary="dbvsh10GjxbNpjdrbHkJFIaxLPkiCmEBz";
 protected-headers="v1"
From: Pavel Begunkov <asml.silence@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, Ingo Molnar <mingo@redhat.com>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <8c83b046-5c8a-7303-5541-180c094c875e@gmail.com>
Subject: Re: [PATCH v2 1/2] sched/wait: Add wait_threshold
References: <cover.1569139018.git.asml.silence@gmail.com>
 <d99ce2f7c98d4408aea50f515bbb6b89bc7850e8.1569139018.git.asml.silence@gmail.com>
 <20190923071932.GD2349@hirez.programming.kicks-ass.net>
 <3e359937-5b19-8a4c-4243-ba2edff68504@gmail.com>
 <20190923192742.GH2369@hirez.programming.kicks-ass.net>
In-Reply-To: <20190923192742.GH2369@hirez.programming.kicks-ass.net>

--dbvsh10GjxbNpjdrbHkJFIaxLPkiCmEBz
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable


On 23/09/2019 22:27, Peter Zijlstra wrote:
>=20
> A: Because it messes up the order in which people normally read text.
> Q: Why is top-posting such a bad thing?
> A: Top-posting.
> Q: What is the most annoying thing in e-mail?
>=20
> On Mon, Sep 23, 2019 at 07:37:46PM +0300, Pavel Begunkov wrote:
>> Just in case duplicating a mail from the cover-letter thread:
>=20
> Just because every patch should have a self contained and coherent
> Changelog.

Well, I will expand the patch description, if we agree on the
implementation (at least conceptually).


>>
>> BTW, this monster is mostly a copy-paste from wait_event_*(),
>> wait_bit_*(). We could try to extract some common parts from these
>> three, but that's another topic.
>=20
> I don't think that is another topic at all. It is a quality of
> implementation issue. We already have too many copies of all that (3).

For example, ___wait_event() is copied in ___wait_var_event(). Instead
it could accept a wait entry generator or just accept entry from above
and be reused in both cases. I've had such a patch, but want to think
what else could be done.

e.g.
```
#define generic_wait_event(ENTRY_GEN, ...)
	ENTRY_GEN(wq_entry_name);
	do_wait_event(wq_entry_name);

#define WBQ_ENTRY_GEN(name)
	struct wait_bit_queue_entry tmp =3D WBQ_INITIALIZER;
	struct wait_queue_entry	name =3D &tmp->wq_entry;
```


>=20
> So basically you want to fudge the wake function to do the/a @cond test=
,
> not unlike what wait_bit already does, but differenly.
>=20
Yes

> I'm really rather annoyed with C for not having proper lambda functions=
;
> that would make all this so much easier. Anyway, let me have a poke at
> this in the morning, it's late already.
>=20
> Also, is anything actually using wait_queue_entry::private ? I'm
> not finding any in a hurry.
>=20
>=20

--=20
Yours sincerely,
Pavel Begunkov


--dbvsh10GjxbNpjdrbHkJFIaxLPkiCmEBz--

--wUDcp9ReHPFbKHIMBDPwE48ahAdhUiuKN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+6JuPTjTbx479o3OWt5b1Glr+6UFAl2Ju0oACgkQWt5b1Glr
+6V7jhAAjffsfaXaHfWydGfYxTJ/0b1pXmjU2TDl9MHNSBYT8k5bMWHhCl95BfkZ
bVKqg+3avqjVoBou3Vz44C/xd7OuleSnXfz+5NXWrBV4twTwOpQPqWGPgblHh3iW
6PEgAXjjP1/D2FoSSVUobw3cC2UUDhNh3R+vLES6PZOS0ktxqIway4T8sWJciPYM
K4x48t7O+Teg5LQDXBfLqmCoNb5tRdaBDyzvLOi5B7QQei/Uw72K77pMs8QJCWnb
dd5Dxz5J7ZZY9Q+d1rN4gT2uKhnFj51eueHrN/j/ffVk3s8FR0yESoTXqvPslcto
DqMtrxUD0z2ssiN4DkiV121w8biCnbBfqbgqI6j+DHkQhCrliRplmyJPDayzlRu2
z/w222jNJSq7JyH+Ezpitk37fVnv8QLmeGW49Yx5VKVxZU+ER6SFbp+ZzImWExWC
H5gmD8tGuHv4gBCjq4FDBEg0tEfhnPF5CWp/1hGoWP0zwEHWku4ea74OUh0m3Ocq
VfGBkdqE9XKVMNRMQhbtwEAiDazItREUw/SFLnHivpqSXTmyzj08i5Jk+47pkTbF
+necWNB37dVmmPZYIlmFRX8Ce/bXxSRDiEyuPgiZq4XqEjRkOpu6eLXZ1pRBsPsL
JZo4uh2rmjdj/H5RbkWfGuJx1Yy+QcZ1r3bDtpuS6+IZJrnIwFs=
=BN0u
-----END PGP SIGNATURE-----

--wUDcp9ReHPFbKHIMBDPwE48ahAdhUiuKN--
