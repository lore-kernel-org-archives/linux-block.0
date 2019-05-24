Return-Path: <SRS0=cawq=TY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C868C072B5
	for <linux-block@archiver.kernel.org>; Fri, 24 May 2019 15:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5805020815
	for <linux-block@archiver.kernel.org>; Fri, 24 May 2019 15:38:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XdghJBTL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389583AbfEXPip (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 May 2019 11:38:45 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35297 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389303AbfEXPip (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 May 2019 11:38:45 -0400
Received: by mail-wr1-f67.google.com with SMTP id m3so10491520wrv.2
        for <linux-block@vger.kernel.org>; Fri, 24 May 2019 08:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=LCRvF9gM85JPE15pYJ7c4cPg5dNsC9rQxww9nzJape0=;
        b=XdghJBTLyt4zmZ7Y6wBqB+3fvWWVap7fNS9E5Eqkt/MmCkS4RY/CAVGzrbga7I1yYi
         pAB7n0GMWYWZffDt3Mcu9ehaT/w2utnnycDx1UCPOzKRhlgqp+IFsbABPAwtqfAmdAdw
         o0ypragsz+J3nmEmwRLF+kMwPPn3Dj5RPXamVOA3n+PTCFXTJ5EFuGFJbm/ydTi0k/M9
         eJ4doEznLwZ/qi+JB8VYrXcDwCYvi/Vl7V1jjX7m3aNFZcyeFgAXJb7M7a4k4jjTka4u
         QPatXtsLtTNDyaETrfiiQ/14W1YXLNcyzb2154nHB5z682hcWxUnQ+w+tQt98XQvX9Bx
         jypw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=LCRvF9gM85JPE15pYJ7c4cPg5dNsC9rQxww9nzJape0=;
        b=OaXjuFCkSzgLUoc57pPQOwUKn8XE7GvWesDe1TEiNIyCi+j+2YW82PH0+5X1esZEDm
         rQwT8Zv3kRL+Tv5YoLZ3MzqDbEkXDLUnJ7u7FMk4jyBAq9EjQnuV7eMtbiUISv8Iqd3X
         9UCVPttYYhtxkaTj27EvDqBS0H97yGuLNXoINjNa0Zc4O/+2tQZQYAEXpMvdK1Kocx82
         J1c7cQjsVS4HAqEShj+WsDPkIssM2zc7YMLfCJS9hdtoHHUkzk5LR/YxA2aAaOhnjZxg
         srXWr4x2JD759UxvcrEHEOJSaqjKKzpvquO+61b2vKKD35c0nn774KDdseUBa1E/b/oL
         hGBg==
X-Gm-Message-State: APjAAAXpaLH9lZimojkltag3NXB8Uck6Zw9HUQd9SEfBgXKh2rDWqzGT
        Ai0//NmSabzqqndXvaDYANqaew==
X-Google-Smtp-Source: APXvYqwDgsVjTHY1U9BHRlsj6D6zyid/eypOWh/exqSgUoM1xmlBBdxUK0W0fRZpKnwCGGFCdeVweg==
X-Received: by 2002:a5d:54c2:: with SMTP id x2mr2791432wrv.214.1558712323937;
        Fri, 24 May 2019 08:38:43 -0700 (PDT)
Received: from [192.168.0.104] (84-33-69-73.dyn.eolo.it. [84.33.69.73])
        by smtp.gmail.com with ESMTPSA id v13sm2721074wmj.46.2019.05.24.08.38.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 08:38:43 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
Message-Id: <262EE1CC-7473-4D4C-B108-734ACED1623C@linaro.org>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_41048615-DE5F-4A8E-B59D-183EE385D00E";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: Setting up default iosched in 5.0+
Date:   Fri, 24 May 2019 17:38:41 +0200
In-Reply-To: <x49ftp329lt.fsf@segfault.boston.devel.redhat.com>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        Omar Sandoval <osandov@fb.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Jeff Moyer <jmoyer@redhat.com>
References: <20190518093310.GA3123@avx2>
 <x49ftp329lt.fsf@segfault.boston.devel.redhat.com>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--Apple-Mail=_41048615-DE5F-4A8E-B59D-183EE385D00E
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii



> Il giorno 24 mag 2019, alle ore 16:46, Jeff Moyer <jmoyer@redhat.com> =
ha scritto:
>=20
> Hi, Alexey,
>=20
> Alexey Dobriyan <adobriyan@gmail.com> writes:
>=20
>> 5.0 deleted three io schedulers and more importantly =
CONFIG_DEFAULT_IOSCHED
>> option:
>>=20
>> 	commit f382fb0bcef4c37dc049e9f6963e3baf204d815c
>> 	block: remove legacy IO schedulers
>>=20
>> After figuring out that I silently became "noop" customer enabling =
just
>> BFQ didn't work: "noop" is still being selected by default.
>>=20
>> There is an "elevator=3D" command line option but it does nothing.
>>=20
>> Are users supposed to add stuff to init scripts now?
>=20
> A global parameter was never a good idea, because systems often have
> different types of storage installed which benefit from different I/O
> schedulers.  The goal is for the default to just work.
>=20

Just for completeness, the current default is the worst possible
choice on all systems with a speed below 500 KIOPS, which includes
practically all personal systems ;) But this is a different story ...

Thanks,
Paolo

> If you feel that the defaults don't work for you, then udev rules are
> the way to go.
>=20
> If you also feel that you really do want to set the default for all
> devices, then you can use the following udev rule to emulate the old
> elevator=3D kernel command line parameter:
>=20
> =
https://github.com/lnykryn/systemd-rhel/blob/rhel-8.0.0/rules/40-elevator.=
rules
>=20
> Cheers,
> Jeff


--Apple-Mail=_41048615-DE5F-4A8E-B59D-183EE385D00E
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEpYoduex+OneZyvO8OAkCLQGo9oMFAlzoEAEACgkQOAkCLQGo
9oN6qg/+NnwtZyPAdAGGfdoBrdQpYEKaZKAbkuGx7UGFPfLttBVZOmW5E2AWNDZp
3pr1Pxw0qCPf9kIDe54ZfeR+bh/YApfq6bco3ZibbjSy0L0qzKryE3JpcQ1CQcjp
EklD4QyT85qbMVKkODbpLxr6CjzT05dZXADYbRzdBqdhmWazh88yn8frlsT0PAYA
oE2hClXLf0grZCg41eD1bCQCZWCLRe3qPj75nI95J2HSbhp+43DoakCN7qnhjfDI
CYe7GWcx989ofktVxPO0YDTQSDoiNVk+8EFWVVy2zgzwzrtqcQI07jkCQd3KHRI0
Ygo1UHxTi0d5361oFoRIcX/cbtXsSbvK7xohiQHaChAyNSjD9GGocxGBwWoX1ljb
ElzWEKN0MCoNakEIR5y94beTip/CrVMzaxaRIl698WZ/tLJI4Dh6R1Tlxkd+NJ+X
h+BWu4/NuKxHQZvRVkltNxI8pDmF0rWzw49+f60yEcecJJzx4Wf6RGWcmj/CKjws
7jieWgT/G7V6p5PYY3MzrVe8fbSTu5OvSXGvgslNaWs256P0cc+0IKVxBwb+rzz0
b36Tji2LPwv3ElwF5r46INCJhGrX/EggwPMWDrVy7cyUyd9g035ryzJ1xmIGae8G
9FoqHS+ha/jzcLI216OHUbp+oJ8rojKrlBUH+MlQbgfbGShr1M8=
=Punj
-----END PGP SIGNATURE-----

--Apple-Mail=_41048615-DE5F-4A8E-B59D-183EE385D00E--
