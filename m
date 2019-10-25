Return-Path: <SRS0=ZVtD=YS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F9F5CA9EA0
	for <linux-block@archiver.kernel.org>; Fri, 25 Oct 2019 09:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55DFA21D7B
	for <linux-block@archiver.kernel.org>; Fri, 25 Oct 2019 09:55:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ATWLxB7c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408928AbfJYJzf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Oct 2019 05:55:35 -0400
Received: from mail-wm1-f45.google.com ([209.85.128.45]:40868 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408923AbfJYJzf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Oct 2019 05:55:35 -0400
Received: by mail-wm1-f45.google.com with SMTP id w9so1350379wmm.5;
        Fri, 25 Oct 2019 02:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:autocrypt:subject:message-id:date:user-agent:mime-version;
        bh=ZtLgoVcxfpkFPgGgyV4HTusjzmYr47fds4JYIbcwylU=;
        b=ATWLxB7cQMrD6d6IN9LdQ+IR3SzsPKvM5wKe3ZdFOePUg3NI4fZo0kCEgNffs3Elm3
         D4kuoFTPvXgbL2VhNbSi4cAh8emx6lc2ggMqbWZWxuyzlEuY9t52LYvbWWtBntqi+Ao7
         f5TGqm2Yjzqt87FVSaOlzwczedfqlwMcm2zNAmZSLzf92A26Pda5LLrz+8ct6LSwK5u/
         rY9cE1HK3xYOERSvTwP9vz97ZHqfAZUsbFOZp5Xg0zt/5lJ/RnhIPSVPiOGuFuhYWmky
         xYWrydd8UGV3+hwfoxz4o2SSiRuSPw+HRtpWYgUGkLX9cMzL65b5STMr53WkI5VO1Txt
         M6FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:autocrypt:subject:message-id:date
         :user-agent:mime-version;
        bh=ZtLgoVcxfpkFPgGgyV4HTusjzmYr47fds4JYIbcwylU=;
        b=cXJwM4PwjQWBSxKRPcPaYRxMhIwxXq7zKqdfzcTOH81aMFmUtDNKOck8RwueN+htoW
         Er/35KpuKtG08Svuc8Qdi9viZeK1PosxHdUS1hRUHAC3ioGgPlFkYXCbh3NQ69Slq893
         ITV4ckc9fYSt6TXTzJoZJLziYBIaORmmGY7J0y2R1Wa13ho6aWkF+pKdevN88nja5Wxz
         ddqmubP003kX39c8q20LO2K4NKxyzL54bG7+NsbuBPLY+gXkhJNLABPdsw0CZH4nzUm8
         PTudtzfeV1m5mU+WbHSTIjt93ejWPHhmIIryQ3c8SDH72IKipUIiklF/PiaYPxeN4GIE
         9mHg==
X-Gm-Message-State: APjAAAUndXeIyFEkSDgZDdiNmOquceYAOSIc/g73Vo1Sf0VaD6Lvj9PO
        3TInXJUU+quuAvZqrl/LVToCIAtW
X-Google-Smtp-Source: APXvYqyZdGvzty7NyAZYeoWgBRCGwD+ro0IWJhTgOoui+d4RYZJb9KLEP6rACOuR0U8avjnEdR4ExA==
X-Received: by 2002:a1c:7401:: with SMTP id p1mr2567836wmc.144.1571997331983;
        Fri, 25 Oct 2019 02:55:31 -0700 (PDT)
Received: from [192.168.43.159] ([109.126.132.16])
        by smtp.gmail.com with ESMTPSA id l14sm1788058wrr.37.2019.10.25.02.55.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Oct 2019 02:55:31 -0700 (PDT)
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Pavel Begunkov <asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Subject: [BUG] io_uring: defer logic based on shared data
Message-ID: <5badf1c0-9a7d-0950-2943-ff8db33e0929@gmail.com>
Date:   Fri, 25 Oct 2019 12:55:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="3JLAryxEGDSKcYMZypHAtijJF96u4w1uA"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3JLAryxEGDSKcYMZypHAtijJF96u4w1uA
Content-Type: multipart/mixed; boundary="Gs26cYXp9MkxYTYA1qtNoNsNFYOku5ICy";
 protected-headers="v1"
From: Pavel Begunkov <asml.silence@gmail.com>
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <5badf1c0-9a7d-0950-2943-ff8db33e0929@gmail.com>
Subject: [BUG] io_uring: defer logic based on shared data

--Gs26cYXp9MkxYTYA1qtNoNsNFYOku5ICy
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

I found 2 problems with __io_sequence_defer().

1. it uses @sq_dropped, but doesn't consider @cq_overflow
2. @sq_dropped and @cq_overflow are write-shared with userspace, so
it can be maliciously changed.

see sent liburing test (test/defer *_hung()), which left an unkillable
process for me

--=20
Yours sincerely,
Pavel Begunkov


--Gs26cYXp9MkxYTYA1qtNoNsNFYOku5ICy--

--3JLAryxEGDSKcYMZypHAtijJF96u4w1uA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+6JuPTjTbx479o3OWt5b1Glr+6UFAl2yxo0ACgkQWt5b1Glr
+6WqtQ//Tqnc1tUZgQJmpDF1mVah9VcY4cjFrCCdZ5sZTkvqR/9VsGzVt67BHfnq
Taw1f2SH0uSPU3FnLs7WkCOQZfFiXQZnPoRsWrPLT7vOCt7HqxncORIxlBM+3gpO
0ZgN0N9WIPW44PQDLcjG4gCjI/uu7PiQKxOOcZRY1vSo0hM/aUim2RgQpfuydw0W
18ppK1Kpo8pP4G60zSOiWbRGm6Cd0x4iwYwuto9zonexaEjDUOAD8TgD8Dtpc16O
FDoad92QQuHIzgVFfLCr9kmPWM3c8doOJuXoirvoBK4+c+Hl6RpqjwuH+xEieT5r
cvva8uo12Vi2GTZQwB7j+j4szMpnG0AuQR208+VL/jvYYPgt7lFMr2rjporJ0DE+
pzPwRbl4BlvPMSgGi/k4FVD3EKP95bvMKcOccWzW8nUxfsV+c/NJO3AnBZwQB4sR
sk91eE/tpXpHjNPnsu43rqw6P+xKivZogu+EoVWR1/5OX14O6ixKki8G4CRHAGVi
wcNyur/4Xbt6oYHKlvpL6ujSvHl+rwIyLnR1PCEptfCq/LEyHPk4A7Ll3w3AfrWh
aB0hSKg5zPLVRIZvCPmMp3QCWhUT/3tyxnQQl87I6ey5lGL7vWMFYR/VVZB2Y+Jn
GPNBGKrJxxntoVT5VXbEI2zak+YAqlkge+7sZ2DfZxJB1Chbclk=
=MyZZ
-----END PGP SIGNATURE-----

--3JLAryxEGDSKcYMZypHAtijJF96u4w1uA--
