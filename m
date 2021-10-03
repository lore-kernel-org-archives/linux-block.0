Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE342C433EF
	for <linux-block@archiver.kernel.org>; Sun,  3 Oct 2021 05:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8834F61B23
	for <linux-block@archiver.kernel.org>; Sun,  3 Oct 2021 05:24:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbhJCF0j (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 3 Oct 2021 01:26:39 -0400
Received: from mail-bo1ind01olkn0178.outbound.protection.outlook.com ([104.47.101.178]:18880
        "EHLO IND01-BO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229450AbhJCF0i (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 3 Oct 2021 01:26:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PiAmWkjCi56kGLvi0YzL3ytMzOP3viA6fOXlKJEU4aKiOqxs/NwefBtd90CQGav+nbrpFKT4X/xNofNo6hCHotdtZt5oRWJyDatNGLY02h4kb9znivR9jeRuPK7GH3wZxTtDVqzronIqhue2lAmgXTF2XBXA0KGvOwNPHLfk7QCfIUI89bWWIYdHjID6wCD/9JkKXiiWznkd2jAbvjSF8/3EUAdNx7QQzrCypjjpwq+L03ONaRdpxW9TcKOl8UzuwYdE31oYzqY+eKZL/oq7x6vivV6T6BfZ5WFvvmXkGnKwjrZstP3E1f4caFAjYxKMwsOzs6GrNhrm/1c3iGuERQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Y97+RcgnnWaSDQg71P8G9nlahyUHusGgC7MfJnBtuI=;
 b=FTQYUIwfKsAnP78ULHxHLCipkcj9vhVviLAMQOb1+uZnzOXT6LWGQ+4KEpiixGxZV/hCzl3uyunu+gnt7HnOBImzmCxjn5/ClLLtcfjpDZdI+otDA23c9NvWqsdKhpwhQht9z8zbyJW0P4N7trjVA0h8mvB6bW6VI7igGHOFADdL2n3cpLDoTHqZ7ctueaUIv/07dHZYl/UmDKdPVkvCKBy5oLXC22FRPyN4Y222hiZyYQUrAQhnF12vVYrS4wSTGCSbeQ2JrKcjtE4Uxb8Hb9LbUyEFVpjEktQjmT1mzBuHRB2Ezf8lLn9kETQ2UWSjVwyLejAVcXcKiCX+LRsBFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Y97+RcgnnWaSDQg71P8G9nlahyUHusGgC7MfJnBtuI=;
 b=fQYNiB/exw767LxpZNr5YUJfsCY2FGmKiy9BvL6Ee8Tidh3bqYFYO+tjBosVMCbnkWzdsV9HKxhYgL1Srahs3qF2Qk/aeAyLAgZY+RGzi9O6kQBu8jngl+VtUjjU/DPUvskbEus5jzF3QWJL4CMCZCoyFuJnDofqtYqXgzwEuAO1sPVfKhfJeCHY7iWFPKNyGVbu7Mdm1enEsyzV4eV+fQmHK/hgfu0erQyfSAylOlGFGbC2tavbfLYq4Cx/Mxdpo8R9HOoHEDFRxH0mbzlGZMFDgmCh3vthvWHT8HHJlbJCDIH6G9BeS9XcsgL1RtQSAKCBpEjffYQx6/633v1x9Q==
Received: from PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:1b::13)
 by PNZPR01MB4413.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.19; Sun, 3 Oct
 2021 05:24:49 +0000
Received: from PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::fc30:dd98:6807:9ea]) by PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::fc30:dd98:6807:9ea%3]) with mapi id 15.20.4566.022; Sun, 3 Oct 2021
 05:24:49 +0000
From:   Aditya Garg <gargaditya08@live.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [GIT PULL] Block fixes for 5.15-rc4
Thread-Topic: [GIT PULL] Block fixes for 5.15-rc4
Thread-Index: AQHXt7hBYK5bVBTy80Grd/tGhlyULKvArkMKgAAQPYA=
Date:   Sun, 3 Oct 2021 05:24:48 +0000
Message-ID: <1F256E1A-B7C5-4473-BF01-2B38A9AAF857@live.com>
References: <0ff68ebd-ae42-6b85-74bb-6ef114c948d0@kernel.dk>
 <CAHk-=wi2sX142TVRhhKZ=HgFzatZv2wt8yT=sR7r3Ob-p2d_hA@mail.gmail.com>
 <PNZPR01MB4415C6C1CED76358BC8089A4B8AD9@PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM>
In-Reply-To: <PNZPR01MB4415C6C1CED76358BC8089A4B8AD9@PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [+bmoj1luY9wfCxk0VWxxNHfS7ajbYEWQRSlXycvdM1Yu4L0b/r1rLgoU12+o3FdX]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7889d313-54db-4169-0c33-08d9862e1ea7
x-ms-traffictypediagnostic: PNZPR01MB4413:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yaVb+SWOXBTD3BFI23AT684gWJBPyq4CCguZsVAG0XAM0SPQilOibX7W/ZggF6jfBWicTLrlRgqYucJ6+F7LQLaIIMroC9OJKzUQYPZpWLjlUtbAKnZNPLEGhoyrHH/thAzWyUetNWCGCZve04ymzQjxR6z3t4D46vUwVXG0ahND/aOThCgzCyinnGt+7Nkn6Lz6Gw35II1rNYkDHXUpPQAMlmnBy6UGV2/5s1xc1vmlHfKGIzIuSb0KnkDCmKHDeh1GPK52EDs7SQBiAw1mSTZ6snXdXTn7sAfzXYq5/BYi03cxUbPDFIYD5gywz9q2nPLFKpdYJSVeStn9xDA4VNWu3vXjHp0ranngmOZ+og32EmQqLslZ4MN5rF7vmJcLfoYfECbfZsNxcgPMiDxXDGDLkeOcNXjPpH+ibM5inQ//EfJm8jaqir0iXPpkCGQ5
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: o1OKrMN2RTrw+e7Stneas+zvVH+zMfS38UGGeyDOVhkmZkbfdETWD7mbtEEzUifMb9RtADDRrAk7UDti8Z0QT9e0Bx0SmM5QTJGjzteJBsFx2OUV39kvpHEK8x4ysfGj7AgLQbD8lLpnm4xt7ZjhiF8t3lUs+vbTaYuojBYcWXeUKTTXIxNzpH+h4icMG3dJbXiEor3J42T4wZCFOpLojA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E2F906E71ED7454FBFFBA2BB2683EDB7@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-3174-20-msonline-outlook-a1a1a.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 7889d313-54db-4169-0c33-08d9862e1ea7
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2021 05:24:48.9452
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PNZPR01MB4413
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

One thing I forgot to mention was that some of the hunks of this patch fail=
ed to apply on 5.10.69 LTS, making me unable to test it over there, since 5=
.10.67 onwards, the same issue was seen.

> On 03-Oct-2021, at 9:57 AM, Aditya Garg <gargaditya08@live.com> wrote:
>=20
> I tested this and it works for me. Thank you for the time of all the deve=
lopers who helped to get this issue resolved.
> From: Linus Torvalds <torvalds@linux-foundation.org>
> Sent: Saturday, October 2, 2021 11:36:21 PM
> To: Jens Axboe <axboe@kernel.dk>; Aditya Garg <gargaditya08@live.com>
> Cc: linux-block@vger.kernel.org <linux-block@vger.kernel.org>
> Subject: Re: [GIT PULL] Block fixes for 5.15-rc4
> =20
> On Fri, Oct 1, 2021 at 7:06 PM Jens Axboe <axboe@kernel.dk> wrote:
> >
> > - Add a quirk for Apple NVMe controllers, which due to their
> >   non-compliance broke due to the introduction of command sequences
> >   (Keith)
>=20
> Pulled.
>=20
> Did we get confirmation that this fixes the issue for Aditya? I just
> remember seeing issues with some of the proposed patches, but I think
> there was an additional problem that was specific to the Apple M1, so
> I may be confused.
>=20
>               Linus

