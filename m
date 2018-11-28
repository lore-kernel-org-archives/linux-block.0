Return-Path: <SRS0=FxMo=OH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70EA4C43441
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 07:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CC3F20832
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 07:58:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cnexlabs.onmicrosoft.com header.i=@cnexlabs.onmicrosoft.com header.b="lMIE9FHv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CC3F20832
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cnexlabs.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbeK1S7b (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Nov 2018 13:59:31 -0500
Received: from mail-eopbgr690046.outbound.protection.outlook.com ([40.107.69.46]:50573
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727501AbeK1S7b (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Nov 2018 13:59:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cnexlabs.onmicrosoft.com; s=selector1-cnexlabs-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uo8mhzlr0odKgltjJe/EvwQ10Wca2kYZPfYnZ6wmOes=;
 b=lMIE9FHvA938RP94yF5UDvuzkoYFhPEuGLLLDcMagkM5kbNWRI4WgbfVfhv2lHjO8KQHwknqoRNfIwHi6oLAc/jcEswgFH+jql+qOflDcVM+9oH8AacA2ElSShCJVGqlTEHs8xexCd8i5kPj7lJXzMGNGWWcgphDcksM1ZfR/Ro=
Received: from DM6PR06MB5178.namprd06.prod.outlook.com (20.178.25.19) by
 DM6PR06MB3961.namprd06.prod.outlook.com (20.176.67.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.19; Wed, 28 Nov 2018 07:58:42 +0000
Received: from DM6PR06MB5178.namprd06.prod.outlook.com
 ([fe80::c450:96ae:b322:78c7]) by DM6PR06MB5178.namprd06.prod.outlook.com
 ([fe80::c450:96ae:b322:78c7%4]) with mapi id 15.20.1361.019; Wed, 28 Nov 2018
 07:58:42 +0000
From:   Javier Gonzalez <javier@cnexlabs.com>
To:     HUA SU <suhua.tanke@gmail.com>
CC:     =?iso-8859-1?Q?Matias_Bj=F8rling?= <mb@lightnvm.io>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] lightnvm: pblk: adjust the position of the lock
Thread-Topic: [PATCH] lightnvm: pblk: adjust the position of the lock
Thread-Index: AQHUhfRSbN5Xcbn6ZEKx/nEy0nBdB6VjlbWAgAAXgoCAAACRVIAA64xrgAA7HYA=
Date:   Wed, 28 Nov 2018 07:58:42 +0000
Message-ID: <CC448D4A-0372-419E-8742-6BC2CBE6A539@cnexlabs.com>
References: <20181127015309.2374-1-suhua.tanke@gmail.com>
 <F75BC3C7-FACE-4C04-A9BE-5A3AA25D3466@cnexlabs.com>
 <a53eb78d-90d3-f84e-a0bf-9acbc32671f4@lightnvm.io>
 <ACAA275B-AC2C-4147-AF88-E250771CA1DD@cnexlabs.com>
 <633950CD-FBB6-4228-BB8C-8FD946FB3286@gmail.com>
In-Reply-To: <633950CD-FBB6-4228-BB8C-8FD946FB3286@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=javier@cnexlabs.com; 
x-originating-ip: [193.106.164.211]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM6PR06MB3961;6:Um7qI/tjkT0pRxIL9mbuHztHHYIgnXQQPzPVdO5Gns8EGswZgrCGGXYDo7h7XVr4+f5a/tSKsKfZ/JkufK+EWEplVDc5d9kLhROUHEWw6p0LKWZcKJTL9+eUrqc+QGpTMvcdRpjSt7XznOW68dLV6wmsCjFyt5W6BmWkZPhQ3RUUKxzJ8X79LEDqeVi0TF9Q3Xu6cG8tyqvDGzoUW2X0p16D9TzbEiv5J0GyrW0ktZ2fb+R98ogcihB7/18o79KYwuXSWE8i3YpB0K9eB3jN8UdjY79Fzwiqveos883rr0ok0biFtE5aaq9aL0BeRm3NGlizHvizppm6o5eaSydTefA3akIhTAOii2Y/FH4eDsVHEy7A0glkD1kBDluZOMIK+Hcwi5P0B4sh/9rDLeQUsdXSWNjbp46KptrMAQXcdXoVbTUEsgUly4Odq9PNBFc37umvZa5hQaFKHY84lHJ2wg==;5:26/kKAZVmHPe25LpTT1TNHmKQ676czXp+w2lQefocTypQ02Dc+M3MIUZ0VQ3QJX1I5mOTXS00niJnQJSIzJ3+eZRCDEGEqNhulfZsGknNZdmXzv1eew9AfJRJWJwkGfEyfWzdkmKT+DkpiH8ELQfdWJZdVM9+8VgrjUSyrwkZEs=;7:SMLtRZBRVTF8ykzna1VjKl6q/DunauUkHJdAG12b7OMUDdBP9l4omhXRIKLfluIB7efPGmsv4Zn8Nc23ZKcX7SbEbr6DQzufjfNgn7GxdvFzC0F7fB9J7/ssGiXGkVpbSqWKdlVnIdY8JWmQrLFdvQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 3adbe26d-f44c-4d0e-a845-08d6550750b8
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(49563074)(7193020);SRVR:DM6PR06MB3961;
x-ms-traffictypediagnostic: DM6PR06MB3961:
x-microsoft-antispam-prvs: <DM6PR06MB39619621B5FB22952B0E2835BAD10@DM6PR06MB3961.namprd06.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(102415395)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231443)(999002)(944501410)(4983020)(52105112)(3002001)(148016)(149066)(150057)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:DM6PR06MB3961;BCL:0;PCL:0;RULEID:;SRVR:DM6PR06MB3961;
x-forefront-prvs: 0870212862
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(376002)(346002)(396003)(39840400004)(199004)(189003)(6512007)(6506007)(26005)(106356001)(102836004)(33656002)(53936002)(186003)(99286004)(81156014)(81166006)(8936002)(478600001)(76176011)(105586002)(345774005)(83716004)(71200400001)(71190400001)(256004)(68736007)(6246003)(25786009)(36756003)(99936001)(4326008)(14454004)(6116002)(3846002)(229853002)(82746002)(97736004)(446003)(39060400002)(486006)(54906003)(316002)(86362001)(5660300001)(11346002)(6486002)(6436002)(2616005)(66066001)(305945005)(8676002)(6916009)(2906002)(476003)(7736002)(93886005);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR06MB3961;H:DM6PR06MB5178.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cnexlabs.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 9ft6HplYs3Og2esWdqELi20LgxYye5pfFXKH1sxlUNJRLCsi+7Y/WOmu9lW7K8V2EDcOWKn0Mrqh0WG4RFTLpcSw0wycOfErszo7c0XFyZiU0dCKZCxoXAYSzgxMTgua821EXnTYHL3jWgttKoaHWHmTJzDHdpoFQ43Hb2Q1Odmsyxg90ftTUYsBpt21iVl7OMC+X5sOqQFffOtgdkM5XMBJ/kmfIZspqouux8uqF98aHg/FDSSmpikPtgLxY+1CHcj7E2Ve8onh0hMtKs576ESnkrwxHNeg8PlfbAHaPYEymGG+D08OyB6q4sDPE7p2p1tPQF++SUkojtYVxF9EqGK0qzkTVDYaMFbhp3anAmU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: multipart/signed;
        boundary="Apple-Mail=_C83D3F9B-6561-44DD-B0B4-7231E93B1703";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
MIME-Version: 1.0
X-OriginatorOrg: cnexlabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3adbe26d-f44c-4d0e-a845-08d6550750b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2018 07:58:42.5934
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e40dfc2e-c6c1-463a-a598-38602b2c3cff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR06MB3961
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

--Apple-Mail=_C83D3F9B-6561-44DD-B0B4-7231E93B1703
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

> On 28 Nov 2018, at 05.26, HUA SU <suhua.tanke@gmail.com> wrote:
>=20
> Thank you for your kind correction, I ignored some of the content, it =
will be perfected by Javier.
>=20

You are welcome to re-send the patch with the code I proposed. I'll move
a couple of things around to better comment the single-threaded recovery
path afterwards.

Javier

--Apple-Mail=_C83D3F9B-6561-44DD-B0B4-7231E93B1703
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAlv+SrEACgkQIX4xUKFR
nnTkPA//UTBT7VcEgiArXh6l1X6GkkCxMpO/OSx/ZjB+wrS+NnPVkXtTXG2sTLXP
mBFfGozuydEDczM88zDXqv6ghVGhz4dQsNxoWk6Ow1CM69ut0vWEHXxx1Wpnal+y
NvyO8zzCGD71v73RADlEYBCZ5jC+2rf+YZfrd1FhfywtUC7YDs/ldf1GtDSlplU9
c6IAUyFngkS14W8LW/5hbbLkQJXNXXbtQtgQJnfHIRJCFSn79d/agckFaP+Gryav
8hERDXg0iYdvQ92Xl02Rpx718+tXxOBbZH91/b3AKQfQSZ14JIBinsyMgTuiPLGW
GNs/vuaEGxzgxiQ90nWL9kRO1V2Z96E/toa4FDL9K430xKremJ4SMoQXdSqEwS/I
8i6wLhNVIeYc9uM/Z8vrXhmOvd/4knrMapqaZv79adh6H11hWDmOUGwiUbqYyM3C
NSkMoL2U0qihmgHEquUyaIRPQenMjUy2tDKexG/HKfJzuq2swGLdEyt/EZZ79c7r
rGV2nORtcc8i291PRKHw1UR7rwX8qPG3cGfSh2U/Q2uTJ64PPBLjbsNVdD/kNOgB
5wfyuqfDzIaxK5U//L5kampZuCS1NgZzhzWcV4o+CsLh8WtdIYK/Ecsv9HKBGvTt
V1Kj7S1iL96mZi6e8wclaLgY3mmrkHgrA73yWsZv1cFL9dftVvA=
=WWZ3
-----END PGP SIGNATURE-----

--Apple-Mail=_C83D3F9B-6561-44DD-B0B4-7231E93B1703--
