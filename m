Return-Path: <SRS0=JlK2=XS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE74C4CEC4
	for <linux-block@archiver.kernel.org>; Mon, 23 Sep 2019 16:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 412B320820
	for <linux-block@archiver.kernel.org>; Mon, 23 Sep 2019 16:22:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e3iZYIcO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387942AbfIWQWE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 23 Sep 2019 12:22:04 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40000 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387922AbfIWQWE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Sep 2019 12:22:04 -0400
Received: by mail-ed1-f68.google.com with SMTP id v38so13435351edm.7;
        Mon, 23 Sep 2019 09:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:from:autocrypt:subject:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=XO4nluBwAnkALBMrv3geKWJHOwaVyOGozrAuQK+CJ8o=;
        b=e3iZYIcOhhBaZHYnOvBkU+QjT3v/OKpdhlj+o9pYqUNSiT+3YaRJS8SCNH8tGzUsF9
         kISFRkDen74CA2I/agH9PmNw+cHkWLD0Rkg9HRTrz6YdQLOXCyBFv0uMYPrt0STLO5JT
         DwVQAujQhdmbWcw+E5n3QuRnI7iwdSycC8LlXYYnqWk7wTeqwiHP+aXrdMwdiX5WIto9
         RLbE2fSa59MaqX09CfH0UaH83PbAyk49FEYB1tBY0wJC2UrnZGF7i6Mj0awXgmUby1qk
         tRVb8xP/ip+HbYyLemz7CRQaGUij+tvTERJPgWW3Eo/UXL4kHZw6nwjjVizScfsnVbny
         IR9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:autocrypt:subject
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=XO4nluBwAnkALBMrv3geKWJHOwaVyOGozrAuQK+CJ8o=;
        b=GCr3lCmvHnzxoojVIyFIsNfuk6QeBxnIGJ4P9mFwWhlm4FgeC39bQARm6jPeUIHZeO
         kED+hV9wBsSM1RG3mXPEgsOqQ7EwrIRESpGcHnalvwe4Ad6qWgI+5HA9btlyogXPMrSO
         +mwehLLpSaFRC19DS+ikXMlvlXQu6OrZrKijuwjT/SSDqB/DET8+lNeQ1/3xnqV6gHkX
         ro6Oi20LAVBU5/I5U6toz3clkcx6TLilX+RJdplIIyQyB33cpymSaRIb2RsyvaGwWf0k
         DGh/oNHefPKhiD/ZG9JbmO9zbaY+QXi4gEgTM1lMZs1YgqBqqxL/QPlnQqHcbxqKCSQh
         uSwg==
X-Gm-Message-State: APjAAAX/QE35Hur52L40yfZTrpGCSO9Wqe/eaA4zGBBWyv3atpVw/CY0
        w6KwaUDeNQCb9fRYnMcUFCzhpVXShI5Jpw==
X-Google-Smtp-Source: APXvYqwJ/V4MzBFtK5lXufrWotnU3rkSZrM5pPFoOBvJWcyjnZIGDPKTsjC8309sjEvhZSv3xQKZgg==
X-Received: by 2002:a17:907:20c4:: with SMTP id qq4mr634468ejb.161.1569255721481;
        Mon, 23 Sep 2019 09:22:01 -0700 (PDT)
Received: from [192.168.43.245] ([91.135.68.130])
        by smtp.gmail.com with ESMTPSA id c6sm1165992ejz.79.2019.09.23.09.21.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2019 09:22:00 -0700 (PDT)
To:     Ingo Molnar <mingo@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1569139018.git.asml.silence@gmail.com>
 <a4996ae7-ac0a-447b-49b2-7e96275aad29@kernel.dk>
 <20190923083549.GA42487@gmail.com>
From:   Pavel Begunkov <asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Subject: Re: [PATCH v2 0/2] Optimise io_uring completion waiting
Message-ID: <c15b2d54-c722-8fb4-266f-b589c1a21aa5@gmail.com>
Date:   Mon, 23 Sep 2019 19:21:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190923083549.GA42487@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="pkpadXJFgKQuTRicpNtAVkYzWf82w2hOP"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pkpadXJFgKQuTRicpNtAVkYzWf82w2hOP
Content-Type: multipart/mixed; boundary="mLo0yNkE23QoIG5hhHeO1hC8id759wxQ7";
 protected-headers="v1"
From: Pavel Begunkov <asml.silence@gmail.com>
To: Ingo Molnar <mingo@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <c15b2d54-c722-8fb4-266f-b589c1a21aa5@gmail.com>
Subject: Re: [PATCH v2 0/2] Optimise io_uring completion waiting
References: <cover.1569139018.git.asml.silence@gmail.com>
 <a4996ae7-ac0a-447b-49b2-7e96275aad29@kernel.dk>
 <20190923083549.GA42487@gmail.com>
In-Reply-To: <20190923083549.GA42487@gmail.com>

--mLo0yNkE23QoIG5hhHeO1hC8id759wxQ7
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi, and thanks for the feedback.

It could be done with @cond indeed, that's how it works for now.
However, this addresses performance issues only.

The problem with wait_event_*() is that, if we have a counter and are
trying to wake up tasks after each increment, it would schedule each
waiting task O(threshold) times just for it to spuriously check @cond
and go back to sleep. All that overhead (memory barriers, registers
save/load, accounting, etc) turned out to be enough for some workloads
to slow down the system.

With this specialisation it still traverses a wait list and makes
indirect calls to the checker callback, but the list supposedly is
fairly  small, so performance there shouldn't be a problem, at least for
now.

Regarding semantics; It should wake a task when a value passed to
wake_up_threshold() is greater or equal then a task's threshold, that is
specified individually for each task in wait_threshold_*().

In pseudo code:
```
def wake_up_threshold(n, wait_queue):
	for waiter in wait_queue:
		waiter.wake_up_if(n >=3D waiter.threshold);
```

Any thoughts how to do it better? Ideas are very welcome.

BTW, this monster is mostly a copy-paste from wait_event_*(),
wait_bit_*(). We could try to extract some common parts from these
three, but that's another topic.


On 23/09/2019 11:35, Ingo Molnar wrote:
>=20
> * Jens Axboe <axboe@kernel.dk> wrote:
>=20
>> On 9/22/19 2:08 AM, Pavel Begunkov (Silence) wrote:
>>> From: Pavel Begunkov <asml.silence@gmail.com>
>>>
>>> There could be a lot of overhead within generic wait_event_*() used f=
or
>>> waiting for large number of completions. The patchset removes much of=

>>> it by using custom wait event (wait_threshold).
>>>
>>> Synthetic test showed ~40% performance boost. (see patch 2)
>>
>> I'm fine with the io_uring side of things, but to queue this up we
>> really need Peter or Ingo to sign off on the core wakeup bits...
>>
>> Peter?
>=20
> I'm not sure an extension is needed for such a special interface, why n=
ot=20
> just put a ->threshold value next to the ctx->wait field and use either=
=20
> the regular wait_event() APIs with the proper condition, or=20
> wait_event_cmd() style APIs if you absolutely need something more compl=
ex=20
> to happen inside?
>=20
> Should result in a much lower linecount and no scheduler changes. :-)
>=20
> Thanks,
>=20
> 	Ingo
>=20

--=20
Yours sincerely,
Pavel Begunkov


--mLo0yNkE23QoIG5hhHeO1hC8id759wxQ7--

--pkpadXJFgKQuTRicpNtAVkYzWf82w2hOP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+6JuPTjTbx479o3OWt5b1Glr+6UFAl2I8SMACgkQWt5b1Glr
+6XVdxAAlOxTFlkfTpBloZnEn2ptSWZu1ExTS93aEit7W8f1Qkb2LNLF2tczKX9Q
9s0htG7oeuDWvFcnKrvGO2DR2siMpqqnGbI6sMxcLlos4FHo8lYFtVdqlj6XLbNA
kIAQ0eMpS49EHugZnWmcD3JAvA0cjTgQzRBAmyFr9JN5fJilohA8wPVw2CqIgvgW
H2UJiAPTx4lLr+ImrfKQLL2owLDoAokmg40SULSxTelfVvQ+fcnaFwyNsxcUkc8Z
qKD0HFS6ukMPR5hIlFvOo057lHn16rMatB2iA3C2n93JeNMDUg5Vi+fvbPsClzOs
oGvHLhbyvvv4BE9rLnPYI9Pm5/tcwvWYLzvrvDt5gFx1hpclrmfJ4XNlEq6J4dc8
nsn3ixauEK4OPWK9KXAfHvbsBUl286JokAlK3TpjCzJw7pQr9RWlNgxnjWF+UFxc
35LLt8iwDiWXgzEoIvtsdDwxL+CfRbC4CXRZJ+2wOgYgC79qGS/kBpBtNhTwMUA0
59JMeVzS0b6oAAvv09XmqmXL2gGw+fni3Gg5Ce3ysCcwYt92sb7mxuNQgl07nBcE
TDOpe/spgBR3+6iuLt3MuREzIul2Rl58rAoG2RJW+AE53uNaRp+UAhPJ7gOF1Aex
Ucm9smVHRPyrK6dkoxmJqaZdpJ0OR+Tq5mIDICFfKUumzHuyewA=
=nmJ2
-----END PGP SIGNATURE-----

--pkpadXJFgKQuTRicpNtAVkYzWf82w2hOP--
