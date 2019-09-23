Return-Path: <SRS0=JlK2=XS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A317C4CEC4
	for <linux-block@archiver.kernel.org>; Mon, 23 Sep 2019 16:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C72D2089F
	for <linux-block@archiver.kernel.org>; Mon, 23 Sep 2019 16:32:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uIRt2mQj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387943AbfIWQcr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 23 Sep 2019 12:32:47 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38817 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387922AbfIWQcr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Sep 2019 12:32:47 -0400
Received: by mail-ed1-f65.google.com with SMTP id l21so8673734edr.5;
        Mon, 23 Sep 2019 09:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:references:autocrypt:subject:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=cJX4Lq7MQipASm58rHED+Etk7MU2SLIFubzctqKqN4o=;
        b=uIRt2mQjZtD3nKzfzXJL0smEqamnz1qs/J37yuObNEThzZvE0YZ7DIRrft1WYbomFZ
         wQ44kb89+2IsPB0yvdHyFbfcKMz2OLct0TuvFcD9CJZU0tqXPGDEZKSRd2yCZEFZOstT
         bzOzKps7dzp+OM8JN0f5QwJaBmo6/6Uc/h1lwholgXG2DnVPGKyNUqEHT2tNnzRFgSLE
         27wjcm+CROD4TVLyMJk/KB0UC3izSExSVlYVWBtDm/sNz9MYtURvZMb01Hgw8WBwHPac
         AecXwxvMInW08la4gI048WApc8oJF9IETIngVea3Ix9eBCfPh8D/gbd/JCCnorwu9oBz
         ZWIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:autocrypt:subject
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=cJX4Lq7MQipASm58rHED+Etk7MU2SLIFubzctqKqN4o=;
        b=DDO4Cyocf4hDNSrtB0pZZ2ClDoHiF+Og8/f9nxW/Nov/KcdOrGijJDDH/ILqd9TDA0
         dydbLlxsBHSdc82iu5q5dFQqb+pPaFKKbC9TkZzak79THiAGpDxwL72uh9IgE4CyKO3p
         JjJbJiMuSjW/M4PL7dCMUbVyfymZoBwUW02wiCwSu/abZj0uk7OdjBP+CBt7QCA9wqU0
         7EmrEmpkZyZbKty/24Ax6AbdxwtkjNS669KRFw16++P8fBp2oqVnJfNcRKbTl4Je7+Hk
         +EK90zglAy6hAdUebDX6O7m4n1NH083Xp6a+BfBaEtZn6mYgHFrdwXg9226Q6Etc6i4G
         L3dQ==
X-Gm-Message-State: APjAAAX82gvsPav1LkRoCCHrbv5vUHURN+hk1mPWxGCM5oDLfF2986D8
        wJQyKzreFIk9yTO0wxRrpuMqAVWcNgPP8g==
X-Google-Smtp-Source: APXvYqzmS53TcM9tXHkdkD8gOudmZMUNpqqSgRXX5BHsovxKbZkE/ROe6wc/A+LYKSzKL7oV4SABAw==
X-Received: by 2002:a17:907:2126:: with SMTP id qo6mr710479ejb.256.1569256365446;
        Mon, 23 Sep 2019 09:32:45 -0700 (PDT)
Received: from [192.168.43.245] ([91.135.68.130])
        by smtp.gmail.com with ESMTPSA id p1sm1184663ejg.10.2019.09.23.09.32.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2019 09:32:44 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Ingo Molnar <mingo@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1569139018.git.asml.silence@gmail.com>
 <a4996ae7-ac0a-447b-49b2-7e96275aad29@kernel.dk>
 <20190923083549.GA42487@gmail.com>
 <c15b2d54-c722-8fb4-266f-b589c1a21aa5@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Subject: Re: [PATCH v2 0/2] Optimise io_uring completion waiting
Message-ID: <df612e90-8999-0085-d2d6-4418e044e429@gmail.com>
Date:   Mon, 23 Sep 2019 19:32:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <c15b2d54-c722-8fb4-266f-b589c1a21aa5@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="3B4EqaQuciegMUNCAnz5Lzg5cTwJnM1uT"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3B4EqaQuciegMUNCAnz5Lzg5cTwJnM1uT
Content-Type: multipart/mixed; boundary="dzGye9qwqLYQx04F4ajWCDwJOPGLZdKrs";
 protected-headers="v1"
From: Pavel Begunkov <asml.silence@gmail.com>
To: Ingo Molnar <mingo@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <df612e90-8999-0085-d2d6-4418e044e429@gmail.com>
Subject: Re: [PATCH v2 0/2] Optimise io_uring completion waiting
References: <cover.1569139018.git.asml.silence@gmail.com>
 <a4996ae7-ac0a-447b-49b2-7e96275aad29@kernel.dk>
 <20190923083549.GA42487@gmail.com>
 <c15b2d54-c722-8fb4-266f-b589c1a21aa5@gmail.com>
In-Reply-To: <c15b2d54-c722-8fb4-266f-b589c1a21aa5@gmail.com>

--dzGye9qwqLYQx04F4ajWCDwJOPGLZdKrs
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Sorry, mixed the threads.

>>
>> I'm not sure an extension is needed for such a special interface, why =
not=20
>> just put a ->threshold value next to the ctx->wait field and use eithe=
r=20
>> the regular wait_event() APIs with the proper condition, or=20
>> wait_event_cmd() style APIs if you absolutely need something more comp=
lex=20
>> to happen inside?
Ingo,
io_uring works well without this patch just using wait_event_*() with
proper condition, but there are performance issues with spurious
wakeups. Detailed description in the previous mail.
Am I missing something?
Thanks


>>
>> Should result in a much lower linecount and no scheduler changes. :-)
>>
>> Thanks,
>>
>> 	Ingo
>>
>=20

--=20
Yours sincerely,
Pavel Begunkov


--dzGye9qwqLYQx04F4ajWCDwJOPGLZdKrs--

--3B4EqaQuciegMUNCAnz5Lzg5cTwJnM1uT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+6JuPTjTbx479o3OWt5b1Glr+6UFAl2I86IACgkQWt5b1Glr
+6XqNxAAm4KZCQh3M7BMDBgN/Rnq89kWjICkQLKXqvhV/nPSu9bsY6fCB3tj1C/V
s1tMQXuWEynbB6iewvBr/laIENP2hqiS27NdevYzjY12amktPxru6rpQs9GafCi7
N0Wip72JhCiaptGAmIdAair0HoWx6HQ+4WF5lMYFR2Zc8pyLIdkz+lk/xdHAs/+F
T/viybKa9v4ZQ3T5VG/1grlCT9x71bHgOLdsMW6vAGEIdzNIMkwNr+6PxQAEAwWk
sbjD0xezUN4e3W/RtXlhKL5hWUafciIZWavYlbM1f+llbk/TXRJPyw3qaKl7CZxA
lfDARP566jkt5rfAA6aS4bkzpNz3zee5qdulOWsLYPLePSC5paqPJKvUpZuBhidU
f7nx61lbsFAyI2XRN0rZDRsWaIGbtkFF0pzrFiWA8DEkrNTF2tM6MMguUcDNmRYV
TQliaArdtycCET1QI0g3lQw3G0cZQhbbbpWbsLT3/NMDbPx6yLA6WAvP0DwQFdBi
Jysi9akB/U9YrAXB/bAZyCMrKNpjYZWKIwMxU1s+1xhTTxcYyR6vtOlNhWr1ev0w
CUd0DaNH57rzRY2v/07YmRafHcCDf7r1tCZ7DS6hmHp2wAP+dal2acjxfesxd6g5
eSkSJT/2pQVnc69xciG0eC1GVP6ZnSGwAYHnZT54rhw4O1r3hD0=
=3vGs
-----END PGP SIGNATURE-----

--3B4EqaQuciegMUNCAnz5Lzg5cTwJnM1uT--
