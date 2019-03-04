Return-Path: <SRS0=5cmc=RH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B244C43381
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 11:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE0AF2070B
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 11:45:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="KBO3N1JV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbfCDLp1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Mar 2019 06:45:27 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45669 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbfCDLp1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Mar 2019 06:45:27 -0500
Received: by mail-ed1-f66.google.com with SMTP id f19so3971297eds.12
        for <linux-block@vger.kernel.org>; Mon, 04 Mar 2019 03:45:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=RCnaCbsrI8TEeskNvJQ9bA8lf0OcfNVvt8oJbsvFHY0=;
        b=KBO3N1JVX5gYosm00jagpHYEgCbjJFRNmutyNK4N1lb7zLB976IRPaY2qXhfRz+SU5
         W9He9xIFrNBgk1FXqjRnlvBZ63wpfP5wAiOUPmvvh3uvlju81mQuQExO2pa3fUxi1X0q
         IE2A3ywnHDfVNqerBaHuQ0NMEbYgQrmuj98MmEJvkyPHy7hORtYBiev028vwht7d2TCr
         o0g1hgwkrOSOTNUQ2C2VvlYX5XhVBv6jgcT9hs1owFQ7/Sv6xmqvre8RR7GkXo7qTS8o
         +WyCCsVtd3GwxH4/P7emgDx/NmJjc6u6neriGCyA9DSzDrnOOy5JbwaoKGnq+pOx/N1g
         VRiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=RCnaCbsrI8TEeskNvJQ9bA8lf0OcfNVvt8oJbsvFHY0=;
        b=nas9HlgMg2z9OTo42YlmtIZVRezSEcEHh+f5bI8gK0W40f2h4p/jzpGyDS/nv017fb
         2gKvVpf1vt0j8lAR08kAw6o02I1E5APuNY6qbb6xYm+9aROHRXmx4/Grfp6TYa7iLYh7
         5v6B8s6sUhiRgQ7+a+fpUnHhBpT/W7qhvQbQEupkwf5wLq1ZT/v1x93hSlhPtZ2mvi2y
         q1K9bfixstYM/UdvLgAWyrYltf6iJREGMM0V5Gjc7KM81aVJs1zH24kmxJSCj1mMsLrF
         7ftFt79iuJvaeLxctFO/w9CSmwU3N/Y5mKpcWlC3iisPiE2skzg5u05LeNpg5+bM3R2+
         NeeA==
X-Gm-Message-State: APjAAAXxCrvzP1Gzi1dHk7GVVpCZdXjIie5BjdT/s9n7So62nBcEp6Z0
        1IGKtxylhRZRKwFEswDeYOMyIw==
X-Google-Smtp-Source: APXvYqzBlMpWQfgbjL0+Xpnqdl/qrAyxk8/bnCiV39Wmk1RBrakrIgYwf2VoEz8uJP1HivvPqiRscw==
X-Received: by 2002:a17:906:5e0d:: with SMTP id n13mr12354036eju.139.1551699925611;
        Mon, 04 Mar 2019 03:45:25 -0800 (PST)
Received: from [192.168.1.119] (ip-5-186-122-168.cgn.fibianet.dk. [5.186.122.168])
        by smtp.gmail.com with ESMTPSA id k18sm1154976ejc.76.2019.03.04.03.45.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 03:45:24 -0800 (PST)
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Message-Id: <04F04C0B-25B6-4F1A-AEB6-36E4D6BB32B7@javigon.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_6CCB2FCC-80B8-4E34-AEB3-C749C03FDFEA";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH 05/13] lightnvm: pblk: Count all read errors in stats
Date:   Mon, 4 Mar 2019 12:45:24 +0100
In-Reply-To: <CANr-nt2Sj13VStWC4_GeTxCCVgztxqxm3HP7+7cNn+OoN=BCaQ@mail.gmail.com>
Cc:     "Konopko, Igor J" <igor.j.konopko@intel.com>,
        =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org
To:     Hans Holmberg <hans@owltronix.com>
References: <20190227171442.11853-1-igor.j.konopko@intel.com>
 <20190227171442.11853-6-igor.j.konopko@intel.com>
 <BAC8CFE4-5D1E-4FA0-80DF-9BA655D458D1@javigon.com>
 <CANr-nt3rzEGw0wNdOmm3ba9Oz10BLh_dbHoCECobMr2cfakLhQ@mail.gmail.com>
 <3E70BD55-1CBF-4695-ADA5-91C342E40F6C@javigon.com>
 <CANr-nt2Sj13VStWC4_GeTxCCVgztxqxm3HP7+7cNn+OoN=BCaQ@mail.gmail.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--Apple-Mail=_6CCB2FCC-80B8-4E34-AEB3-C749C03FDFEA
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


> On 4 Mar 2019, at 12.41, Hans Holmberg <hans@owltronix.com> wrote:
>=20
> On Mon, Mar 4, 2019 at 10:23 AM Javier Gonz=C3=A1lez =
<javier@javigon.com> wrote:
>>> On 4 Mar 2019, at 10.02, Hans Holmberg =
<hans.ml.holmberg@owltronix.com> wrote:
>>>=20
>>> Igor: Have you seen this happening in real life?
>>>=20
>>> I think it would be better to count all expected errors and put them
>>> in the right bucket (without spamming dmesg). If we need a new =
bucket
>>> for i.e. vendor-specific-errors, let's do that instead.
>>>=20
>>> Someone wiser than me told me that every error print in the log is a
>>> potential customer call.
>>>=20
>>> Javier: Yeah, I think S.M.A.R.T is the way to deliver this
>>> information. Why can't we let the drives expose this info and remove
>>> this from pblk? What's blocking that?
>>=20
>> Until now the spec. We added some new log information in Denali =
exactly
>> for this. But since pblk supports OCSSD 1.2 and 2.0 I think it is =
needed to
>> have it here, at least for debugging.
>=20
> Why add it to the spec? Why not use whatever everyone else is using?
>=20
> https://en.wikipedia.org/wiki/S.M.A.R.T. :
> "S.M.A.R.T. (Self-Monitoring, Analysis and Reporting Technology; often
> written as SMART) is a monitoring system included in computer hard
> disk drives (HDDs), solid-state drives (SSDs),[1] and eMMC drives. Its
> primary function is to detect and report various indicators of drive
> reliability with the intent of anticipating imminent hardware
> failures."
> Sounds like what we want here.

I know what smart is=E2=80=A6 You need to define the fields. Maybe you =
want to
read Denali again - the extensions are couple with smart.

> For debugging, a trace point or something(i.e. BPF) would be a better
> solution that would not impact hot-path performance.

Cool. Look forward to the patches ;)

Javier

--Apple-Mail=_6CCB2FCC-80B8-4E34-AEB3-C749C03FDFEA
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEU1dMZpvMIkj0jATvPEYBfS0leOAFAlx9D9QACgkQPEYBfS0l
eOAA8BAAhWuuYheG1GmIBZhcaLemMVcj2/pOwiB8M2INw4x1VtsfXWur0EbwZiHe
WB30UQ+7GU/OJivKsYIYnEzuRFg39rffvfSdoWhg7jRgM6eSD5VuLxGzeX1xNrMy
6yRjxWFGmjJGrN6DhTPcVYxJlo8HKl/yNaxHGtQ66L4h9tfq/JwpBlKtpcXxG3cr
VFk2OmA6BHdNnB4WiRQIp2Uu3Kj8aWWn0qPcjKFD6aHK9SqmahjuPZckAp1eYnTQ
9cffoUY6jv/Qb8Kl9iXEZ18NclBfhQ2MP7iJjKuqn98iKWP0tfZ9aOcSmgwYRK4w
yZJ/629UsMizEGMRUX2jk5UdpRcyYJ5XsQhMfyZCcei2PR64VD+x0ccAdTfCg1yk
+egrkcQZvTGICItFKjpSzMvpPfq1v0rP/uibXFDq0h9q55iwHyGhBL+EgcSCM5un
64NyVWKgb0Gw+MumXyHIe2R3dj6ou1XAyOV2KXFf1wmqi7Eat1KDoS5+ZenvbLfx
KYYDXrYWGbTpw9Xq4FVbmmAXJPYz94xAUfrFdSWu2zFmC2pNeFHPWGqJJzwzMQVg
nFH1W8GVfylCusdEyyptkZWwyLLdsElGjx5s1zGHXnc53Op6acaeWfaTlH9Dv5+J
p72YAer4zRNO5O//1wil0Y9W6yz2vdIg3RI1wQ7ZjIza/P1TRaU=
=KF/W
-----END PGP SIGNATURE-----

--Apple-Mail=_6CCB2FCC-80B8-4E34-AEB3-C749C03FDFEA--
