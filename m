Return-Path: <SRS0=JlK2=XS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B775C4CEC4
	for <linux-block@archiver.kernel.org>; Mon, 23 Sep 2019 16:37:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6E7F2089F
	for <linux-block@archiver.kernel.org>; Mon, 23 Sep 2019 16:37:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LQFMdUYG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389368AbfIWQh5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 23 Sep 2019 12:37:57 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36886 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389180AbfIWQh4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Sep 2019 12:37:56 -0400
Received: by mail-ed1-f65.google.com with SMTP id r4so13529132edy.4;
        Mon, 23 Sep 2019 09:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=PKL1OnAoqd4fWRaYtf5I4i+d8Fob8QaTlO5UTt3MjN0=;
        b=LQFMdUYGSHpXKPlyS7ebp1zn/LjmZLaHiTAo3T3VxFEu6sWFedbnnaxTfUlll7fUqe
         qjv27J4Zm+ezQU39L7TblsF7/xMWCeDZTEhqYuHw7QS+d6kat8GAUwXlxMZg+uTbmFZx
         f4O7lpaEx9L4FsnDR6y+BqpkWzMGb+fj+/UZhq8d/ZO/54B5MxPjGdnEI6IZOmuyHv62
         gh3iyleB/WXNBZpNpJD2QlXHFKxdRqdRkf7CkaauSFrrFO93OeEwwIGwnTdmtVOJu3cD
         Hvnq8aDrQJCLwco1iT8z2HhfeS2KJbBhk0KiPM/EnL78Idm4w7tj++Obn4UpJ0Q2UWMr
         pfXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=PKL1OnAoqd4fWRaYtf5I4i+d8Fob8QaTlO5UTt3MjN0=;
        b=eFJ5iFnLCETKThXiPFQ7xmRMhBYoY2GofLX0kIdpKKdafVgTNMpv0LmCdFzQlA+o1X
         7st1Dc+jV0PunEajPmEMz+4FanoFr0j1ghqh9gapdBbpK5nf1sw87gJxPx0n4Pj1clIq
         /ZevYHKz1ZApLm+jk80adePoam7OxyyjVoJYVQYDDRKxEK0dbWm9XGuOFFEtTc17UU4c
         s0ed5XMF+uLsLS4EXIStGqM5zR+J8F4CzS9BeU7f4iKreFSTSISq+41YM8knomSrQS5j
         OwqN5eaL3Vhw/yzeHKTLaFB0p26t52NN06U3svnOHa8hKJ6featJ/sUjS6owfhFGIoxq
         XecQ==
X-Gm-Message-State: APjAAAUd2os4v9eqytJ+Qp0lMepODprVKjFYRLkwg/lqCBZBi43Cu9B9
        VpsL17U0oIH9f/+rLcFa6Dxl9ZFyrXQC2A==
X-Google-Smtp-Source: APXvYqzogl3ErlrqCY7SRzq4aqKtm4Zx30Hs/q0f+9YTK6RUM0h+the6FF0xtiXEUq2ykJAeWyF7+Q==
X-Received: by 2002:a50:f0dd:: with SMTP id a29mr999536edm.219.1569256673705;
        Mon, 23 Sep 2019 09:37:53 -0700 (PDT)
Received: from [192.168.43.245] ([91.135.68.130])
        by smtp.gmail.com with ESMTPSA id s24sm2470091edx.5.2019.09.23.09.37.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2019 09:37:53 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] sched/wait: Add wait_threshold
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Ingo Molnar <mingo@redhat.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1569139018.git.asml.silence@gmail.com>
 <d99ce2f7c98d4408aea50f515bbb6b89bc7850e8.1569139018.git.asml.silence@gmail.com>
 <20190923071932.GD2349@hirez.programming.kicks-ass.net>
From:   Pavel Begunkov <asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Message-ID: <3e359937-5b19-8a4c-4243-ba2edff68504@gmail.com>
Date:   Mon, 23 Sep 2019 19:37:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190923071932.GD2349@hirez.programming.kicks-ass.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="afwh8Yn56RhJBUf9WB5Zf5rnPoIZsPbEd"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--afwh8Yn56RhJBUf9WB5Zf5rnPoIZsPbEd
Content-Type: multipart/mixed; boundary="sioDMMgZJs6jpfgK812OHuEHse6sCnGbc";
 protected-headers="v1"
From: Pavel Begunkov <asml.silence@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, Ingo Molnar <mingo@redhat.com>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <3e359937-5b19-8a4c-4243-ba2edff68504@gmail.com>
Subject: Re: [PATCH v2 1/2] sched/wait: Add wait_threshold
References: <cover.1569139018.git.asml.silence@gmail.com>
 <d99ce2f7c98d4408aea50f515bbb6b89bc7850e8.1569139018.git.asml.silence@gmail.com>
 <20190923071932.GD2349@hirez.programming.kicks-ass.net>
In-Reply-To: <20190923071932.GD2349@hirez.programming.kicks-ass.net>

--sioDMMgZJs6jpfgK812OHuEHse6sCnGbc
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Just in case duplicating a mail from the cover-letter thread:


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


On 23/09/2019 10:19, Peter Zijlstra wrote:
> On Sun, Sep 22, 2019 at 11:08:50AM +0300, Pavel Begunkov (Silence) wrot=
e:
>> From: Pavel Begunkov <asml.silence@gmail.com>
>>
>> Add wait_threshold -- a custom wait_event derivative, that waits until=

>> a value is equal to or greater than the specified threshold.
>=20
> This is quite insufficient justification for this monster... what exact=

> semantics do you want?
>=20
> Why can't you do this exact same with a slightly more complicated @cond=

> ?
>=20

--=20
Yours sincerely,
Pavel Begunkov


--sioDMMgZJs6jpfgK812OHuEHse6sCnGbc--

--afwh8Yn56RhJBUf9WB5Zf5rnPoIZsPbEd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+6JuPTjTbx479o3OWt5b1Glr+6UFAl2I9NoACgkQWt5b1Glr
+6Vv+BAAn48KtuECZJP43/AXvRPRyf3HrK7yvgmvlYX8AutwGPo4qO+0SGjwo5kM
YLdodOixGzYWPUCHPgsdrBTyVhe5LMvUeFrNRGRHxzC+BwAkpAf5vOyiMlN+P+YG
i0IvOffLgdHR8z14lQjbwwThxlaK7INW1+H/jUBll7sAF3NceH9zjJbDW5f0l2rK
jPRpVEwahcM9nmSGc4s1XLxiSQpJLuGTStwhQfSilzbFod5A6moj1u63zBUuJ+gc
oeqN0fZ32uv3DZmegJrQ1yY0QNRN7ck4cAnO0i5aPhOYVwGqrwgUEXNnpxiM6geM
jnkAErcD7Y5OPFNngnkCY5Zrqucm9x4zy1+Jg8xPHajtC1z+a771v0XGyi5B3WjW
YrnM8bJhOFj+4C3sam6DCXTSbHgSgsPLvIhYjx3d/JgwcSMbRt9jD3l8caqnv7XH
Z3/E317auOBfZldTwmAx8WeaBsNw5QcpF+s1HrCnvFBoiso6wXv3baunrK4T8ab0
uQhwLbJwQ4w6bLhz2MpZzqzi47zc7sPDiSMmMBc5lEyA1P2Scyp6GPvShRgI3bVK
fYwA+1I+Xdsr2FuUTi87Hi4J2Jif+UTc4gLlE4ib+mRF35mvyj0lt/h5JRb/dsiW
yz1lA3bqY5uPJGVvhxAlguNo9bOJsNjcFu3csiwa4yxeckwMEcE=
=HQjJ
-----END PGP SIGNATURE-----

--afwh8Yn56RhJBUf9WB5Zf5rnPoIZsPbEd--
