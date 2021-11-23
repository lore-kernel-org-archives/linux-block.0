Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98157C433F5
	for <linux-block@archiver.kernel.org>; Tue, 23 Nov 2021 16:22:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbhKWQZL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Nov 2021 11:25:11 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:19675 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbhKWQZL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Nov 2021 11:25:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1637684523; x=1669220523;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=aMOj9cxw3DN2KI98zUODQUvFky+fQwZGVNfYTN18QIw=;
  b=TPSX6G/MWTIbsEhKWFo1P7K/X7BxUdwUySLcejvscQkmM2657HF9xbG2
   7jG6k8GugiPO0UTJjTrpImVU7qdwXviR0lm8f+6VBhn9dBlMxpQPttvr4
   dMsv86U0ZsrTdniy3q2tEb9VP0pyYblDehtENEYX8vyVKxrTcEY8uRUI3
   fC5D3+ezsOumYgHf3xuz/coiB+C5DRYMyHVXtDBebZOdDu4Pi1Pq6h2Fa
   fna5teygytGcMimvq0Cj8DLS9YifPuDzcO3ep/A/ucTclEw2ebdBBbMXA
   uFZe7chXHPP3+sRBoHO8Cp7TC3gMH+5c3i6lU3iNLOJ8iBAz+kpmnbdSg
   A==;
X-IronPort-AV: E=Sophos;i="5.87,258,1631548800"; 
   d="scan'208";a="298259994"
Received: from mail-bn8nam11lp2175.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.175])
  by ob1.hgst.iphmx.com with ESMTP; 24 Nov 2021 00:21:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nm2dS1s5UYEtXdDxw/LH3p1P6XULQiYUXnpYKCJ4UzG81glkfDmB6xqiyd7rRXyEeH/rKgXjCO74Vc/tHF6M4sShe1/45AS6+jE6wwm8EtLTIgyIZlGF23kYGj0gpMuHfJ8KcJ3uOZC1B9ss2Fv7VojCNUJSkWgFVqFjEsjHv3s4mBDXPIhvs4s8b549dhwLRn5giBi4K+FR/sxHKboyTXSjp2w21MofG4s9xv/ARhYqkNpeZyDDIae1mOt61nwPGmv0Eheopgvdpmrj6Vy1boP1csge8jPBWsc18bwfTtzEStv4eC/tvgnTuzFPX9GFR98F4qfIyCbWphW/fSoU6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5XVl7AXCbEPMNDA4sSP7OJ14P6yt+LJ+8DcI7lz90d8=;
 b=ZNOnuItYVfVgXlS7MrD/oGJWEWxK7kiOz+JUhZ3TG130UPH2WB3PyH2IVPmWSFGZQWoFerUeDeP9wmUfpmc0fmGXALIk0EpsotLjfsqo/vNJYZI6sSfR0aKf0MRaYmo+MhvS8hoedDIbSdVn0wqjXUexjk0a8YOO5ui08PLqAmQOUb4oSX1NGiR1eA3qmfMrtIlXzoEhaKY1UQHi5L+1tTCLQORZYC2fjFXPblUViifzd/xXdWFYTkUYom/0Zi9vBbT+EqVrnOkaaIDunnCtiXQ/iR5+tf5x6y/VBhuzBlZ3x8GhnQ7YsxQeK3dpLJTwTvbe4tTSoOgsrz31rnkOOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5XVl7AXCbEPMNDA4sSP7OJ14P6yt+LJ+8DcI7lz90d8=;
 b=uI2vyFqHot4T4iDw1lGwleWtKBTOvPsDPdjoMrNiSyrUuim9qkCQJp8RNYE7mHYW8E+33JRgvscGSqkcXJOPxwR7KDhA5i4s+Xpm44JW/5Fz36snm/UhwMgWNLZm7McyHeH/ddV229kAV3DsdO0RSdjmfgkp50oPOhsvyj7m8ug=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7175.namprd04.prod.outlook.com (2603:10b6:510:19::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.20; Tue, 23 Nov
 2021 16:21:44 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::3418:fa40:16a4:6e0c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::3418:fa40:16a4:6e0c%4]) with mapi id 15.20.4713.026; Tue, 23 Nov 2021
 16:21:44 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 3/3] block: only allocate poll_stats if there's a user of
 them
Thread-Topic: [PATCH 3/3] block: only allocate poll_stats if there's a user of
 them
Thread-Index: AQHX4IW9uI0StiTUMkCEogUX/b7F/w==
Date:   Tue, 23 Nov 2021 16:21:44 +0000
Message-ID: <PH0PR04MB741653C525BD926BA38793729B609@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20211123161813.326307-1-axboe@kernel.dk>
 <20211123161813.326307-4-axboe@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 71d7ebc3-43da-4d01-96a3-08d9ae9d5722
x-ms-traffictypediagnostic: PH0PR04MB7175:
x-microsoft-antispam-prvs: <PH0PR04MB7175CD5C1CB60F3D1DD90CBF9B609@PH0PR04MB7175.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sglp2C1B9X1LFvJS24N2eO1tWsqHRi/9dwWe+QTpOXWnxAGNgbomgQA/n7/nDb/oOdEtRRXkSRY8VLRRtxRLNUt8bVBjxSIeyiKuNLIiMuWD3YitBursYy0Em24EMGhzbwhL3Amaix1CpH4i9XxhI9Vzvl4gt0cEyEbj9ZlqFFrzlwSnY+4cOTAfNZc5dFu5rSifaRhLygEXG6KG5fsWuWdooMDtOj2K6Gd7UV9Fc/AQNzpO5fg4sdlhtqi7KMnArkk3cdF5cMbw7UQhluBjVHcIrjiUN09/PgFWoTwej/RLaEBXxWX8jKQf7iA+7mO+0Kl97TVYstrztG85WGbrCgp43hGBZl95vLJvdKmdIHAOYwbbW0icwbKr8/mMYLcIyfjvZ90+y+zeqH0iuj2q3ti7yp41ygaxbz2hTumJ4yEGWQOTEn91tuix5Oa8oHNbpSleNucFaUdFlRgMbKVhHqk1Ijsp7iPmKwS6KGdkf7o9y/D1V+fs9upXgCzDY39LdkEhZ2naxI5tsTiZdHAsGuV1Cmx41DCTe6kduuh+DMzMp7xcjLsTK3ri0wEeeI/eD1pN0lNc9POjomOAPL8LEQWIXq2slb47JxoTpSEPgPu0j6ukNJ+4h1uj8sFvz76XNkzy44BJVydpMVDv7D13LshZODF/WaTEAKDno8CP9lmNDtKZgcHRjzFOvUSYU7bkfAHj9HLWBsLiBaDBznoT6w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(9686003)(110136005)(71200400001)(7696005)(5660300002)(86362001)(33656002)(558084003)(38070700005)(82960400001)(26005)(53546011)(38100700002)(55016003)(508600001)(8676002)(8936002)(122000001)(66946007)(2906002)(76116006)(52536014)(91956017)(316002)(186003)(6506007)(66556008)(64756008)(66476007)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FBPSxTKDk4AlYgqoDW516Bp0cyGP0XKwWwmKeckTJwnBPT6O/fN/F21SR6By?=
 =?us-ascii?Q?0zgOsEJGk8YDA67rfBsGfQMEknCdXiLrfX3+bTOk1KlOBKyDfh8RkNTLqERO?=
 =?us-ascii?Q?4RhwhY0yLBDoUV6zHhQ5H905QAGyp6Kio7PID23fU57SYC1+jEfdqy2OtaXD?=
 =?us-ascii?Q?03TMujJRisyJ9Y+Iyv8XN92dfcUrk5UESFcDPA4HCrCRvGgbahTiCDd7aG/T?=
 =?us-ascii?Q?QpgI2FIv/Idz8Gn6LJuldw7F24dP1A5kpewxvSALv3HtRQYZeF/tmLmx/wI+?=
 =?us-ascii?Q?7PIIUV2yCDzMsL5BuX7ZSquNnyiYRtDJ02md4s3yTY/zrMcUUf/L+KgUPXMv?=
 =?us-ascii?Q?lx3wLitji9DnBJSJ4/fECaSRDYrELLXnlcbzGFjp26hQq5cNSHKlmWm3Nxc6?=
 =?us-ascii?Q?KUfwN0YQVwK1pNRWhVnof+BzxnI4vw99A3PDHFvkE289ZJ0EZE/iYMTbGv0A?=
 =?us-ascii?Q?rvfy/wQpev0ipDDu4883raFhM0T2y1ADbFhMNJHojcovMyaNuF3QpD/1yRRI?=
 =?us-ascii?Q?g/olp/RtHjsyI1KUn2c+BKkjxlNI4xxHDJi7ev9ZNEk43Q+jRk8saMokohLH?=
 =?us-ascii?Q?EVBJZkqXHWhP8jzaSqqp4TVxbSQGoZUN/6m6f9ZnO7a/50CP4Ala4d5fp9MF?=
 =?us-ascii?Q?pU5e46kGDCuP1F6lllyTdJ32KcjSED3jujNJO25gKlOrgJFhYqGMNrk6CLDQ?=
 =?us-ascii?Q?mAifGkjPLVxYCI45DkqwqlvQ27vY1h3k2FKfCgoKdcgqGegRMsyq0IDh2UKw?=
 =?us-ascii?Q?UmHEjM8XEQ0sjpbNuxpQyZNEsQVLaifTpDQynXeYpaFvB9/C5xACTSF0sNJE?=
 =?us-ascii?Q?qm42kaVD4xIY1VWHpqIReJBnGkBjjLSeGkvlRRfnUV3vgA+j1TvgOhbfK5v3?=
 =?us-ascii?Q?j1EWtVAWIyUWHsEAwJns2mQptmJVLD5AvGc8VyVVAj3lHplQBKvxGgdM1ikH?=
 =?us-ascii?Q?eD4tZsweMplC+dg+YiKmNJ740nm9RHgkhuGZ6j4fSRIc0eezbILn9hO75rUR?=
 =?us-ascii?Q?bhiwOsVfGGJvZD/Mfvme97U9zO90aSpd6qQx9Z7FXejP6A/aFMh9x2IHxrC+?=
 =?us-ascii?Q?3OJGW8m6tff083kq1JlooMlVxA/ip8hDPt6gkYJ1Js6PD2cdqJ8Of/PrS7Qf?=
 =?us-ascii?Q?3Q39nlSWQUqrGH+v2e8JA5zr51CG3HqurA3xvXz0T1t3lwzOKHJMp3+7s5Lw?=
 =?us-ascii?Q?7AHCQZPBUXDJOFbKG1QtRKAHlqvYzCJYMfW4L+4X1SIT+qUGrPYTkCkYOhJC?=
 =?us-ascii?Q?hZudPapC10xMzd/UKlkveV/rcRb+r0KPz0zFCKs4r7n6Dym0bW7oWEO/ybg/?=
 =?us-ascii?Q?HRSz3D8b9MHOBkIlbHGE4EN6MqhrMjAU8y5eCRYSmYHJoLMRaEOoru+EdKOb?=
 =?us-ascii?Q?0D8P8OLQ3vLNKcjDH+HJxYl0hkJJvCM0xZH2CIi5rGQzKNHnK1V/2m74a60e?=
 =?us-ascii?Q?qu/T0Rit7ucB8yViX0mE+IJNjDPJ+v2SptnZ0FcIKUrotFJbapmOZyes0O4A?=
 =?us-ascii?Q?ISwdgQxJodkkL122pnEuQPq2sMZ8gXMhn1LdR6f87LTzIhNMy92UFW8qwG53?=
 =?us-ascii?Q?EQXDzrA7wxAc29BgnJHcHex6X+jGJuM5iB9sonoN31Hb2LsuWnc0emJpqMdc?=
 =?us-ascii?Q?6UC2zchdSdBrblOe5ZBSg8srlgXWNEQqdpu4+tvx9s1xn44Swvm66c07/wfU?=
 =?us-ascii?Q?Yb4hVhZUp800j7RkRSqkiSl21cY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71d7ebc3-43da-4d01-96a3-08d9ae9d5722
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2021 16:21:44.3374
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8aKJfzNTZL+VMk9BSsc2+7KR+e68eaQQ8jY2K+1/p+PDP12qVD3gpfaHvTt3BJd1E+HmEOTuafZSlvphpVUnvcK7991HbJvAJe9FnM5sy/Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7175
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 23/11/2021 17:18, Jens Axboe wrote:=0A=
> +	poll_stat =3D kzalloc(BLK_MQ_POLL_STATS_BKTS * sizeof(*poll_stat),=0A=
> +				GFP_ATOMIC);=0A=
=0A=
Why not kcalloc()?=0A=
