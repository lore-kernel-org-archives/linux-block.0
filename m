Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96E8FC6FA8E
	for <linux-block@archiver.kernel.org>; Thu,  2 Mar 2023 07:45:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbjCBHpp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Mar 2023 02:45:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjCBHpo (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Mar 2023 02:45:44 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0DC928216
        for <linux-block@vger.kernel.org>; Wed,  1 Mar 2023 23:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1677743143; x=1709279143;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=hc+IrG3Q3cjGc0Qt4wXL+JCEjUbJXeYm+kK8GDRD4kg=;
  b=f39vEO+yJK4sbSHABLuW3eQFysIvZuvZdlPNxkfje271o03sDVWEJXQj
   xYYETQz/3Po0U1AVCa6bv5xsxaIlTVIkB1ODupCc/ULMeCV0Z1zAQ3hUv
   0VzF2dQUIRo4xJQbyEaU3wpYHyfgPfjmLMBEfciU/Y3EBWRXNywNz+DFD
   Vd82qbS0uSXfDqOcunRFYTZgosHXopQ31QlNlnVoHorvEn5FDF3ECe3FM
   Ll456W8skMojpi+0t/zjKrqR/BDei4cR52eEiYiOsi2q1105LwjCRtMnY
   rI0XnS18ZZsc7vQYMFXWw3bnZnfBgC74s1FVnQaSD5Zxoi3Q0+2/FHIZO
   A==;
X-IronPort-AV: E=Sophos;i="5.98,227,1673884800"; 
   d="scan'208";a="224606945"
Received: from mail-mw2nam10lp2103.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.103])
  by ob1.hgst.iphmx.com with ESMTP; 02 Mar 2023 15:45:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VlHS8TVc296NrpBpu30k00m/d1uXkBz1hLtzld2VSzshz4fy/VrWRf6OFIytDBfFcgqcLwK84Bj7j84rejW3gNvPLL6jWozq9ZTKHH/rnWVXlk/1A+6zJ9vvZ3JEiJb8voWRhnRUVqYf//mrmVsgVA4F4teKiZvN39Z6vtB6mTJdLx9mIjoT9t0+/MJBKLVr3bdmMwzMkpLwTz8ngJnzgW0Y2pxWSX7lKXyQOp8fUcea0CcUKuyeJLq9r8zfk5O9XZP7oPIHvGU3G1Uo0wIllv0jwE2YZqpkhr4g5PJadsS5o+ETRTc8OvQ+riJxq479pfAtof4vXeQnNi98jqfieQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hc+IrG3Q3cjGc0Qt4wXL+JCEjUbJXeYm+kK8GDRD4kg=;
 b=OnfNKHycHGsuLMcBMMUgU4eYU0kM04KyUUf9FACLSvhMp78brdkhVVs9iOMqq4Sioklr4jJUzr7KYtMrFvhwyw0jdKx630GUqmS6zhr2VOR29F0ttLnSvimMEsANZsH3+KJeMN6aBrUcROn/NBjnxF1Fle71eY46ix73Gh5GZ0ZQ/Fus699TpCIr2pMzwb/WDAhn1jmMmHmmfQz7/rOy88XzkysfangCH4xicSMgECQ+VVQ8fJwT4EXFouSin2DBOejCMP0XXsOvtlmycp/s8149JUfMlAe4wDr9MfMbHmH+55ChJOyEl4ccPRQ3N/9pWxFDQy0E+x+UwZRDQgJvFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hc+IrG3Q3cjGc0Qt4wXL+JCEjUbJXeYm+kK8GDRD4kg=;
 b=pmi+JTVALpxi5CagekUUcEg3tQ1tw69JzfxFRHCXIenj/gttJUbG2mRLa/AKqgu8/hqBbNLmQ47w6X5QQEojTNqhJFd04cTdHyMnpIGa1QrG8SO431mRlIAngVMl6SIR2yo9diVHIrxq9NTjdaU1YyPlFoCZlYR4aQXr7z/QNA4=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 CH2PR04MB6840.namprd04.prod.outlook.com (2603:10b6:610:9d::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.19; Thu, 2 Mar 2023 07:45:41 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::1b90:14dd:1cae:8529]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::1b90:14dd:1cae:8529%8]) with mapi id 15.20.6156.018; Thu, 2 Mar 2023
 07:45:41 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Ziyang Zhang <ZiyangZhang@linux.alibaba.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH blktests] src/Makefile: fix number sign handling in macro
Thread-Topic: [PATCH blktests] src/Makefile: fix number sign handling in macro
Thread-Index: AQHZTBRFKdePE7etVUKQCHPuTKTOYa7m8BoAgAAttQA=
Date:   Thu, 2 Mar 2023 07:45:41 +0000
Message-ID: <20230302074540.ab3btky7psigv7nq@shindev>
References: <20230301080301.2410060-1-shinichiro.kawasaki@wdc.com>
 <82baea2d-0fa6-53a4-fd97-7378b2d41833@nvidia.com>
In-Reply-To: <82baea2d-0fa6-53a4-fd97-7378b2d41833@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|CH2PR04MB6840:EE_
x-ms-office365-filtering-correlation-id: d5da2871-6f44-4ec9-946e-08db1af21f43
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wZvCjaFc448ye/flIniCRtiVvBSawy1UCmJui3kgU0QZXMeLdJommzVD8D1tV3HGFuBZ38DmKISj3zjjK5Dj/PPLUbQ9ClPmVxVvZKXsJeCVhW5w0UkhVNQbdDQam15FUuiFQcpZcn4l69SZb/zH0eNthqZpiZa5LxJyWQwuIEt1wbc2fNIuI2APaeUpVO1PbakBlRpGhu6UkAVzFWFmJJvQ0e9iMcZ6ThVbHh3Qyf/PDR2OHBxnhpUujRZeHp7MmVCRgCU2zKShdTWykM5+NdiGlHny/9NoOjPq5tAMrwwTrHxsQ7OHqaV7FWu+4ALZ0IyMghyb4ziJNWyRRFx+Omu8cwdW6lTWXKrihWTKvL/un1Z6qFWdUjcea2AL7la3gEjt3PFULRtKQYuLbN5XRt+aVbWYgVmS1F7w47RJyDW/rYSmoxxL2/ov8Y9764lHGBHPKkckVHW9UF0PoLgUNaoBNIz5DloJJmPfyI38VJbg2c8xpcgWdbyJGAm4l9LGPPX3Y+/kAtUgDE34E/dHGYWckYzVILcI3mkhAfGP/EhSEXwNZHW7JHnWkl7dOibK0hZTC+OyxstQdb990sXnW09Vkgw5+p7UN5Pbwgk/lfU7CRaHUzRpt2SuN3q62jTFFVQ9XC/J3rV7/wZTX2oXlHgqSeT2r0/0eZlaYsTyw8aK4EOXE5b5IllfG4hGZIhqJgZUOqnfaak2sH+RqliKpiIMelYSPvLg/UZDVzTDKFg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(7916004)(39860400002)(396003)(366004)(376002)(136003)(346002)(451199018)(53546011)(6506007)(1076003)(6486002)(966005)(9686003)(6512007)(186003)(26005)(316002)(41300700001)(54906003)(91956017)(4326008)(6916009)(8676002)(76116006)(64756008)(66446008)(66476007)(66556008)(66946007)(44832011)(4744005)(2906002)(71200400001)(8936002)(5660300002)(478600001)(82960400001)(122000001)(38100700002)(33716001)(86362001)(38070700005)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?t4HKFYZqBZfB5lQtC0rhI6TGJHfNVfkJeGDExjsDuoatNN3W0eKyqFWmBR0a?=
 =?us-ascii?Q?IOyCvhLzLZEtjLFnqMSaDmZK248yUJWYLm7QGoS9mzR+0V2E2ZRycx4iut6r?=
 =?us-ascii?Q?8xQubv3fu4Aa58dtpTZlFtMdN40z12Yb9IwPqJH/MGW8pbkHSFcfPhf2s2DD?=
 =?us-ascii?Q?/MxprGjXzl/UKvkrq+UbP6nrkTtx0lBOQaZP35uKsNc9Y5L3lzxQhZDeTt9k?=
 =?us-ascii?Q?SfI4Ut9tKx46+zW8pBX1wUrX1x3pY58axEWvMOACJQGWc4HNVUpqAKHVjgZM?=
 =?us-ascii?Q?H8/IL8TjznD52etoWsdp27N3Iz/9EVHwp6D4gRyGk+/fuZJx+/XOPJKid3/l?=
 =?us-ascii?Q?Pl6crewngKGJiYKytVjRJuNgAyDtTgg5Vlk2f2GMUUVHJJrJEgIW0mGHYxmd?=
 =?us-ascii?Q?JdK1fDSk+zUjLXT+mR67mUxiSZ3nLcvL8wuvn31Iv1eIwI1dl/S5MxQ3vvhU?=
 =?us-ascii?Q?n9Fn3F8N0gFjer7smFznL57k2y4h98P2DwglBeKC6y2NMBBsCeuzHbGFihQw?=
 =?us-ascii?Q?RO89wjZz+/1hFDiuccKpIKhPLu6yyno517DsatfQseWK3NiKMqt3wMol/m9/?=
 =?us-ascii?Q?1oO2XyvsgJZq9xn6a/Ku4/0ik9ZvKeqYFhBkpziUDHtyCm57YMnKgqGDcIei?=
 =?us-ascii?Q?zLD/HXeI++9+OGGiweELUKE2IN4qlP0QHHMUPNxsPvRunYtH2OQ4m6S3ZwlM?=
 =?us-ascii?Q?c5tKdE2oQViU5L/HVaSZgWKULsYMiNXpk2Rdy08IEn2D1fPDR/1AVPXUp6E8?=
 =?us-ascii?Q?S9HzjXyxvyYMo5/1NYy1Qp83Y2R/nBlugPntJQHftBW28AulUl2dB3kNZi+i?=
 =?us-ascii?Q?kJvrAXzVfrifC5RmcQHpVfaWeN29XH8nuMSLZXbKW7iKVWEoGN7x05Tn9YKw?=
 =?us-ascii?Q?oWKtvKOFCxIulvr2PFYzGV0u1hrR9aahZ/VyV+M1D1+xmoCnCoTgs9h1rbKS?=
 =?us-ascii?Q?X4clk2sfFAv6D7+B31Gq/LNwyehenR9kuDnZZ+YbRuWF2CCuoNGPziiqJRjC?=
 =?us-ascii?Q?IbFeZnZsaXPfjByCRfYbLVtLyahGdThKc6SnYIFj9rBLC8juYUs5FRDo9z5v?=
 =?us-ascii?Q?+OINqKQaJGbzPANBOBgeTWyzh51DqR+/cb3HC1iwl6lwwQisOG7Cd+kF+bEH?=
 =?us-ascii?Q?uT7RUhCBTkV/cjlNSazOmbXNAreybIwI7F0r+fysPUKHK7XrWFAgzdylPej1?=
 =?us-ascii?Q?hYsOIP1/4nYjecMVHuc2fbnAxjH30X4vT/efEgAeu4FZs43fCoIWcsdixGFy?=
 =?us-ascii?Q?j7pNaUnNaD5T/xic0TaTUcXKksrz5vUWaPcdmgyhL0LalAVPq+TXYZRaGeoB?=
 =?us-ascii?Q?/Lfzm4gPi/+fdG3JbwcSCqwOT7VlomndoznHi/rWdNqjIMQcOiUC9CZ30liT?=
 =?us-ascii?Q?LLGqRYr/6aCMo9Hepn1A5Hc/djB+7yimPa2RFNlOTRFvxrynGyMzYfzLIY09?=
 =?us-ascii?Q?RsRrXcQL+rzVPc8KK9/WeCMNAGQq9zBhNlaOwwOjdKKZT/TejGRQG7+hhY5R?=
 =?us-ascii?Q?4h7GCBzymMGSLTPyhMc3yrFZOKm0awNc146dx68whwLDZGzJdvzp9yzEipov?=
 =?us-ascii?Q?PtI0SD46iLi//QsXWX6DrVFqAQv9uIun7Q2tsjUsc78lpoGMCShRUEHP850l?=
 =?us-ascii?Q?xM92+lVZ3atDaropFxGTf/8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3019AB4FF6AA7246A050E97A9BD08734@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: maVwq83J0+IRJuXzquewYJsh8x3ow5mNFnrh5IYzKU188NcvhNUeYveQ9qa1ZCi4vAdRq1LzUsdyBHMdblWBH1cVaoA2LlXvFljGsUb0FsBMeAp3FMC4I8O+OhS0R+4QLtArI8W02rxwiOmJJSO/N40HeR8yMlKXiV+baziH3QiZdB05S1uJ3/Uf5hCr0xOIQb+Uak6cbyX4Z4b000fs/PSlnw1RdhmmWk6p3Fj/JPUpAclXe1MnJ44yjxUTQL12XUkfYPBBbau4ENckLKk+QBlcizvcmMoOV0d02zI36J6JkTrFVAvATw6YX7dM9+0tP2tGxNCLNgRxiUC8bpV/vN9ZbNUIHoMIodvdE3c1aB+qlW9QwISmQa4+okjokQ05FZJ3kijXOrjC2M78gRv768UlN2goZ29AAtDo06MLbAaqrr+doh4p2oldiU/DHlgemkQBgcUvqF7nJzmMOCon8O/E5bhWzLNeEZnqzVWXZIXltES8mc9gJNuuIpkp5lrqb4GuzWPXIA7MJtyZLn0fjJDgxvM3x/584CuA2uz4QW2GIkPo9tdj1nv/J5bh5YgmV23z1h3ehDML+QwZO3aqSccjxLbXngUh8swQj3J73rE0/7TahIbHzzgtRMTFTjk98uykJv4GjZQ/apxNKjvFF2K1DBYcGLjmqT1QODTfRKmi8Gw4SB09TFgzT6BqtYnNSwI+0EEKuExWd5mIiFTGQqEwAgh2e3vPpu1ZHiRedjXW3SkDWaS6OM0YL8ZLKAPfA93lFdiJ5xEres2hyGaj4pQbRrUT2XWI4MC1R/G9H3ZTXS4/+/zjY9aeQKPkBKR+YhB99iXlqmbl97GMnlScKWb++5UZVjxAGR7hB8L4TJk7F1d6rehN+F9cTRsHblW8
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5da2871-6f44-4ec9-946e-08db1af21f43
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2023 07:45:41.1832
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t2GM8qBfl0WKUqDLYObQjymhXLedUPXtHzXLwb574kYxT5C6WWwMLyI0jNIce0fwWw2JpEJTMY9Rs4/3STle2WDWHvZ/lUTWnyBE3YuNVKo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6840
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mar 02, 2023 / 05:02, Chaitanya Kulkarni wrote:
> On 3/1/2023 12:03 AM, Shin'ichiro Kawasaki wrote:
> > GNU make version 4.3 introduced a backward-incompatible change. The
> > number sign '#' now should not have preceding backslash in a macro [1].
> > To make macros with number signs work regardless of make versions,
> > assign the number sign to a variable.
> >=20
> > [1] https://lwn.net/Articles/810071/
> >=20
> > Reported-by: Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
> > Link: https://lore.kernel.org/linux-block/cfccc895-5a9b-f45b-5851-74c94=
219d743@linux.alibaba.com/
> > Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> > ---
> > This patch can be applied on top of Ming Lei's series for miniublk [2].
> >=20
> > [2] https://lore.kernel.org/linux-block/20230224124502.1720278-1-ming.l=
ei@redhat.com/
>=20
>=20
> Looks good. I've reviewed Ming's ublk series, feel free to add this one
> too.
>=20
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>

Thanks, I've merged this together with the ublk series.

--=20
Shin'ichiro Kawasaki=
