Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E68C433F5
	for <linux-block@archiver.kernel.org>; Thu, 26 May 2022 07:35:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346457AbiEZHfK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 26 May 2022 03:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346421AbiEZHe6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 May 2022 03:34:58 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7ED095494
        for <linux-block@vger.kernel.org>; Thu, 26 May 2022 00:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1653550496; x=1685086496;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=tHHe+qKSNoJf+HsKCoSqw8zexntkfo4GKRqsU4rQRok=;
  b=myd+ZQPfrfx9QoHEvBVJjEq2swKIZv2GU/WVG0ZDB2vHkOOkHg9+Kx4G
   uoONrt7sPYlULbhFupy5xYtj/xBVlI+EqJf7LJAxNoyhfpG/0DLC4F3wg
   sPfKSWVK5dGCcqvO5eiFfYKDKAlvP0P+0SwScyHM7zhGQqgtNkHDEegW0
   6+pv+yQcB5CVyBxVQKcZjOLdjSDwDdvVh+qXpAywR3dY5d5E9uywawTq5
   vdDum1tgqalKbH3lU0npEIx4rObB8Ow8P1SsHYfAerBzslhh8D0UBYD6u
   Pr3ez2cughMhSonaIEUM740IIrobePZtsUOycFl2RlLzRJ+sUFcsm6Jbu
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,252,1647273600"; 
   d="scan'208";a="200261429"
Received: from mail-sn1anam02lp2046.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.57.46])
  by ob1.hgst.iphmx.com with ESMTP; 26 May 2022 15:34:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kCsmgSfDs5QFYtIdRYzgsamlH/eTuKfQq5Hr88lBA4i4k7Xrzs/Q7CA0RzfXxvbiMsaMYG4bbMqbCPSPK6oEc0twaozMYtN4z+p22f+xKT4C3YIi+rm6evP43tWP/FqieqebE4qBLuqdrAW0ujuBK9yLMeS9GoORtRrpqLLVj64WV4nheu4BvHHgWzo7s3Rh1AcvNLmmL/T4iAC97H/g2qtQU3HOKeP8Hb3K8Hxd7fuZoXAOjm/MNV4laaUpYawK7lRUERTXunvG81AWApTnK9ORtg9M/UMRhdjc0g6/uhfqK6PQHpZuerLLNHNke6ESkSzyZAxnN92a8IViW9ZMLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aWvO3b63pgUR7Nf8NsgJTkmxLtm2OapDbZKpZFwb4F8=;
 b=AxW9qdRXxxp3Pqrg7HHA7yYhjTsonNhRRrZYahffiW2f+VQBagRyImYqq7nRtZeqjY07c2k3YpX1qFyZamCdHIQXljtDfLhSztPBiT4PXUkzYjxzD243rTzQJ/Z1zQsWV8S0FRFChnocUSLjA3kuYd3ibKsXL7vpxXfoWpgNF1YJ2BqkFZZ93ptcwqzhjDnQIf0diUXIUiF+K6SZEs0J2lOuus7BpWc71LL3nP6dKJVtFoJJC8pitOJ+ILbnddLbPrEW2aBYyVKf6uWaQnPoR9jWdYyJWfnuktR+UesOaV3S/DczZHJCXCGWLq3Jlm2xqfSJyWjg8gkBt09trHDspQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aWvO3b63pgUR7Nf8NsgJTkmxLtm2OapDbZKpZFwb4F8=;
 b=Ilx/OuUGDixDrZ2PrmEPtR3wZK3BAAvxTHcYFzx4jGHeBfguRTwXhVaVuWj8jR1uqAnd6go2nSrHV9CA6jl+VHybXnKrVPcV7bUvM+71vX2uP3FEuI1vr8cAqv7ldAxa9JYq+R8giV4QQ11rvAkhBOTqkzrj2/wVs5KSiXLbKdk=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 DM5PR04MB0602.namprd04.prod.outlook.com (2603:10b6:3:a3::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5293.13; Thu, 26 May 2022 07:34:53 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::39dc:d3d:686a:9e7]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::39dc:d3d:686a:9e7%3]) with mapi id 15.20.5293.013; Thu, 26 May 2022
 07:34:53 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Xiao Yang <yangx.jy@fujitsu.com>
CC:     "osandov@fb.com" <osandov@fb.com>,
        "yi.zhang@redhat.com" <yi.zhang@redhat.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests] srp/011: Avoid $dev becoming invalid during test
Thread-Topic: [PATCH blktests] srp/011: Avoid $dev becoming invalid during
 test
Thread-Index: AQHYcNMWB2+1P+ICEEOyiRv/Yjs6iw==
Date:   Thu, 26 May 2022 07:34:53 +0000
Message-ID: <20220526073452.t2u7gqzy4zaegxal@shindev>
References: <20220518064417.47473-1-yangx.jy@fujitsu.com>
In-Reply-To: <20220518064417.47473-1-yangx.jy@fujitsu.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ae421391-62ff-43b2-ea7b-08da3eea39bc
x-ms-traffictypediagnostic: DM5PR04MB0602:EE_
x-microsoft-antispam-prvs: <DM5PR04MB06020BEC60415807B8757E96EDD99@DM5PR04MB0602.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PbTuZXpxU8L7zXydopzRK8sBmttHEPT0sCm9xwJrbqUPtC7xSlhKmnhyzS7JKyjFJyu5v3KbuLb3WjOBZQlbGWp/43gKHr8vqQdrdyzi2Si52NJKQvukrCKK1MVIWWQ9z0A+sd8Vwcv1UhqL577bonGKYApttZoJBi7ll/jCVzYNiTxbShauz9fy/MhtoxePzKuVY0Q7E33HwdJOLHzSw6jfUmINc/9CCreptn/LQQOY0VkQ4XXJaDryuy9VMYNtH5pzLLoh1kSL5NL7Gy7ZWRA2/aU3ry64slw7mAvG3uUTVmingu/gviUElHX/fL7eV1UqM0PorEayPJaVyiUWfA3ymnURsjpmWfLnpTONG8A2Q8s8Q8URTO5UjDsxZckeDAxgEZpyKlDLze9jlt7KzW8Z7IVQUFVlLj0H6lVXB3QtAVjLLytRFCg4cRthL6JjZAAbgo1jEfEh85JGzGP8Ok4v+e/ch7anNAHnDPIf08jzffWfrgs8mWAVrctqKCnrOW7ACqaBbmgaYuxrMRsqvQuqd6xhdVtIby9oGgjXwLTT4/jlasT/jMSwGQwCKyxjiybsQEgwlxh1xPfsUDFUl42p9X996GgLyUtpZYcXP703yp1XNA3UAts938+eFbZZa+I+3bqQFcenthOnF9OhFRKenWZcGJ6njL2Eic6xqqEtslTg7AIfaRdaQo6OjhBFijM8/W1w+0gmRC5hgbNdQw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(6486002)(508600001)(71200400001)(6512007)(26005)(1076003)(186003)(86362001)(33716001)(9686003)(54906003)(4744005)(2906002)(38100700002)(6916009)(5660300002)(44832011)(316002)(6506007)(76116006)(66446008)(66946007)(66556008)(82960400001)(122000001)(66476007)(8676002)(64756008)(4326008)(38070700005)(91956017)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MAm1eBg6tCBDFdhP94ZOp5rguU3JU8dd0ALBN6bBitS15aEjsSxTJnIrhmeQ?=
 =?us-ascii?Q?MAoGC9ZoWOdvG5io/e3F3YhZFHFoyMW6WfKSYKsEqsXMz/zrla6KKB55ssIk?=
 =?us-ascii?Q?TpwQhe3FZMDQyMZlYqdm4hSnHWt3YzDGfZDmzBfEDIsiJGwVRJDz0tJjt7wL?=
 =?us-ascii?Q?KQn6pm0b7dvssh0n3ugQSwVdgud44e7NS0BnVn6lGSbiZigKlrqwfSvxCikC?=
 =?us-ascii?Q?VNDX+oNN76mam8I/WwH+G50dq7bZIlAaHSjlIgtKZpiTUlJlSMwH/IMk5ClR?=
 =?us-ascii?Q?EURoUVqnkzADeJHRe06pIgphMtWfXW0FWTo80MnltzXAJERNEr3FXe67z/+5?=
 =?us-ascii?Q?K9oKSECchIKD9uLYPywCMY0LjK7LokHCjVhqMKNvl++bTBLOzgtx0vUOg6C0?=
 =?us-ascii?Q?Jx0d7L2KBlW3dPURLl0oMwdb7I5pf69N6vIOPgCc3XOXZFkqdvgaAbNzx00m?=
 =?us-ascii?Q?HfXUot6LIRRmvQKVdOKHyUZDKWj2llqjsBpFFjmiG7VofgfoEexlQijCt9rv?=
 =?us-ascii?Q?M3kKHEuTq6Ikup5B5Atk7JZrhEKk491cL+f16YEuO2WTFedk+UTnBZQNJ98L?=
 =?us-ascii?Q?lehovz7OIqzX6jMJXgHcIR0DOcl0hb37iIli8115s3QSgLkRkrGvyVCNpc1L?=
 =?us-ascii?Q?6Wy76nEUQojz5Y/O13i0zhgw50l/z7aZg1UcVKgm77dvfyxE7MLIR+4ei1t+?=
 =?us-ascii?Q?mHI9Bd9uw60/6SLJYlHO80c7UiUiV05HStTbiuQqgEbnpKxFDpgcZVSoyLeU?=
 =?us-ascii?Q?Afkj0ldhGTbof5PA765i13Cw29GkOcr9zLmZtYJ0j4PlBw4wO6BC94RWBmA9?=
 =?us-ascii?Q?Dh5ISu6F5g1KhAL733KY9w8yufeN43FCvsE1NNGkqnzqhxyxkdmcGx9AFDEt?=
 =?us-ascii?Q?0/8OMxjm52Zrpkfgg9Sj8LiBCduK3XWsIQiTRfQzzeeXgkN0ELGY3h6qBzsA?=
 =?us-ascii?Q?HY3V/XzyPlznlvfgxB+7K61kBYG7xUtpt8A0JSvwlkF7sdniXj439mswoCfX?=
 =?us-ascii?Q?PUQj/VX5BnGqzKP5KNnk/dVZz0DSgePKrDNlVtqXlwr59s3347esMBAHnLgb?=
 =?us-ascii?Q?HyqZSRKxTozSLE1OG9s6dfKULsYtbtqCnNfNRA3tVK5yn4Wxp9bzRTUum2d+?=
 =?us-ascii?Q?2Rh2U75y/tkIQw6EhJIz2VpVpS1RgC3bGH+vQeYoJWKZ6Y+RfQTWPPh+A504?=
 =?us-ascii?Q?ZvgHLW9N5b9W8IS/X2Cp3P8pev4E2uo16gWmTx8cf4b+qaaKwtMv+QDHfood?=
 =?us-ascii?Q?lscgHfYKix8sQjNltIhSF5bChVghCyeldNvTCYyVWItrdMaOSrr6wXpS+hrL?=
 =?us-ascii?Q?KrKRLD1CQwzLI0ToCGtFyumbplKsV/RyGvMyCu3GVs23Vr4O4sZoF/pWjJGx?=
 =?us-ascii?Q?DIO/p1viqWIZkz9uqHpCF5WdQjCzrOLm/OVNUGMKCD/hk/mE4EmJ0Q98ELi+?=
 =?us-ascii?Q?AiI7lFzbBtYhJ8YniY6/0J8YpXNJksqcbHXp83paqfk9KlOomxVnelUAb9bA?=
 =?us-ascii?Q?PLwC3ruvUyQ9MB6c01F6d/AI6uB/H4jXmZ891tBOL4FCp7PrgodBE+GmrEcN?=
 =?us-ascii?Q?ti0UtbJC2K/2u+/+j0oZ7LYu6NSB2UZS5umCJzcaampsMGQekcwX0Xmk8+hF?=
 =?us-ascii?Q?5082ZesmSFekdpMrlOSuB/zCnF9KDJydDzbsXPM56bMxfYRNA5F06tVJ8uCG?=
 =?us-ascii?Q?9KrPiCFLc5OOsSwWN12nonMxFPl7MKVPmz/ymiJzbjA0YR3X4aBzsj1GjP1H?=
 =?us-ascii?Q?UJyOuZXa4zvdRIy+Vn0pVVwR3cHwCjGoHMIZI74SY9iu+UkCIaCu?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3FA75808B11669479BE22DDADAB434F2@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae421391-62ff-43b2-ea7b-08da3eea39bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2022 07:34:53.7829
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TMj4hGS+sVq/UgzQsyYWfu6a7p2llqdr/qpkXZCHAAu+Dk5YRy2EGqSiQ8dKJmEOVM9qu1PpW0Az0NCvHYsYnUIsnZkMh30885a9w0OAW34=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB0602
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On May 18, 2022 / 14:44, Xiao Yang wrote:
> $dev will become invalid when log_out has been done
> and fio doesn't run yet. In this case subsequent fio
> throws the following error:
> -------------------------------------
>     From diff -u 011.out 011.out.bad
>     Configured SRP target driver
>     -Passed
>=20
>     From 011.full:
>     fio: looks like your file system does not support direct=3D1/buffered=
=3D0
>     fio: destination does not support O_DIRECT
>     run_fio exit code: 1
> -------------------------------------
> This issue happens randomly.
>=20
> Try to fix the issue by holding $dev before test.
>=20
> Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>

Thanks, applied.

--=20
Shin'ichiro Kawasaki=
