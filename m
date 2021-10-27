Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B587C433F5
	for <linux-block@archiver.kernel.org>; Wed, 27 Oct 2021 02:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 419B9610A0
	for <linux-block@archiver.kernel.org>; Wed, 27 Oct 2021 02:16:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235444AbhJ0CSc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Oct 2021 22:18:32 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:63343 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232231AbhJ0CSc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Oct 2021 22:18:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1635300967; x=1666836967;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=stW/q5jy2sGtMyTXyx+Rm6QUozWSuaQyfN34M5ARkZg=;
  b=JHm4197FYERAelnAMvZxN15n4taGrp4VSiPATIPUgXtlvmTzmHz8+2er
   6L2FtFTjlxtqUL93m/nh8tdxD/Y74uOgYnLvti0JuXw0U9evvBEoBrABg
   8ss4v5HvL2POxaNSx5Z9WsepIqF0TY4dhKo6NsGm+5EYGmK90Yp95Phh3
   0LUaaRexMpC2QYt+rM6oABAJholvV4wwi4dvhjIJ1OubaozZPDrNNKT1a
   FH/imWeOzcn04nEVr2ykcez27RtqFqGxUvCarho8AOtYOVzu4Op5kaSGY
   9DTDX0KGhIU/coR/zyuOoyKEZs0FexVhB5HaGYVyuuvma9xUJVN6xI/q4
   Q==;
X-IronPort-AV: E=Sophos;i="5.87,184,1631548800"; 
   d="scan'208";a="183924390"
Received: from mail-mw2nam10lp2105.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.105])
  by ob1.hgst.iphmx.com with ESMTP; 27 Oct 2021 10:16:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uym0u1X2P/VnT4I3B5/AG32YzWIkXG4HHwimluO1eJXGkPl2SVTaKKKx3jUvQ1XkeSE+fjGWaOp3Qx03hBDDtFnDEQht1sDgMs6kEMK2hm96/wJESLR3E8auG8daeoVzHqX7lDdJgwk+M0vKJRutNMTVwMYPGLo50e4XxuHz+C0ApQph0D7pOs4QzFVQDSru02dLxWGmuURNPOKI13GN4fxhhsSCzAT8amiTFTtNGj+OkMHidHF8Xe3I0Ee57yw3SFkwq4CvjFQ/MABFlVGESIVfKzcBLKkii/yHNuL3jFqdSwAFCxlCCyhgiUITCLUkUeWFu8fjlB4tQbUMkwMx+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=stW/q5jy2sGtMyTXyx+Rm6QUozWSuaQyfN34M5ARkZg=;
 b=YxCTGWxdHD2j9iL2ymNGbuiv+3dDgYvloHcovIzuOzHTnug1M5wjc+JPGcR06M32RJVHl5bOqbZJ9OoK2/HsLOkLxGOQkb9A7nqeyXOs8VjiB7YZiG0B3V6ZHCKUtQq3q5mmj96yU2wCplOEMxltTuzVblEC0cxBsDtUI//CD0hFVAxsAVo7NM4hglAW5lfnsA9RPIQt6IUTVnLR5qVyPurDLC0nu9Z7Xp1KHpZBGcSDKHN0secc1truxNxvXZ6z63PXbDM0swuKDhf20DeSyvFmtZzzHdNXWObdVEWpygKEhZ29hq9HZuKZ+A4WYzlmQTiMdcz/ElCcHNK+ib+rZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=stW/q5jy2sGtMyTXyx+Rm6QUozWSuaQyfN34M5ARkZg=;
 b=Pk9YGzt9f2YqAn8qFxnPS68kia23cEQ58ZZKSmVK+1Rwgg2M1vX7iBnfX8RmyD8uwqFh+JL383gvG7GRnSDzjyBQUCMldx1WA8A/AOPDvam9fcFkDoSrLCUxsMo9H7oLmMCB/HwU93PgB7zLVRJ8zdLrQim337h9lQtNbLEl/DE=
Received: from SJ0PR04MB7184.namprd04.prod.outlook.com (2603:10b6:a03:291::7)
 by BYAPR04MB5573.namprd04.prod.outlook.com (2603:10b6:a03:e2::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Wed, 27 Oct
 2021 02:16:06 +0000
Received: from SJ0PR04MB7184.namprd04.prod.outlook.com
 ([fe80::30f6:c28:984d:bd79]) by SJ0PR04MB7184.namprd04.prod.outlook.com
 ([fe80::30f6:c28:984d:bd79%5]) with mapi id 15.20.4628.020; Wed, 27 Oct 2021
 02:16:06 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>, Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH 2/2] block: attempt direct issue of plug list
Thread-Topic: [PATCH 2/2] block: attempt direct issue of plug list
Thread-Index: AQHXyik1fmcfNAtqKkq85KdLXlrYzqvlWyeAgADBt4A=
Date:   Wed, 27 Oct 2021 02:16:06 +0000
Message-ID: <20211027021605.wk2hvwxlztabjjm5@shindev>
References: <20211019120834.595160-1-axboe@kernel.dk>
 <20211019120834.595160-3-axboe@kernel.dk>
 <20211026052036.xdsw6ejx2e2n7jhi@shindev>
 <e8930e4f-0359-9218-3006-14463d7fe68c@kernel.dk>
In-Reply-To: <e8930e4f-0359-9218-3006-14463d7fe68c@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d87057f7-c09b-4cf3-26e0-08d998efbbbf
x-ms-traffictypediagnostic: BYAPR04MB5573:
x-microsoft-antispam-prvs: <BYAPR04MB557381BB7525E89B42459F5FED859@BYAPR04MB5573.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:51;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U6XxSICZ/vA82BwSTyzbt1POCYevWIim2uSuNO0WL97ALK+W5cUqnjdVcpBCR8IarkVcqvASVqsTtCW9Fj1P6s8nAi15POKjJPa3kMJ5FmYpXiEpDYElUJjRrYwKDC1bxrf+EgVtyeCx87SZg5j+E9DOA3G4mCtruM9tt+jRk+p4SUJRb2GSuO8Xdxb7VnjOtekvN3t2mDFxYxfZXVq/RntjBtBFdB4vPzrWKhEY2pQe2q4RlDdGJTIXky/Fli31agxGFFLZpgc3BIfO4UfIFqJxvCfzQbZGh3JeCCGY/M7gBhZP3L5i4FIHdf+LCVGjIWzKyn/lpQUQ+fKmr1+IvV36RHMiq1/TbAqWW3tNXwa/2qSjAVlxAFd9rYptyK3LyGrFdEODys/8aqG+iBGV/pgo5OpeZREISlHsYMrR1DamxZT86J/OXcJa6sRJxkBFwMhlv7sTpKV3WGGqG4J6XzB/O0wStaThaskpqXG6urlo20EEB/sW52jO37Kx8cCLt0JZFXQYt9noS6an17QqfevRRWyyCFgbF8StY3lNZPJ0R1WkFy/XS0t0D2ru//Hj7CEpa1Uwn0kDMuSivDyrjyT1cs7bvn7HHRdIotbfnNMbtgD6hsXOmxoPfuNziOLYm8YuGErc9vyI08eWB3/GV3MfMeOajvNvpRZv3+tGBxiqHaC6fUCrVfgk5XJ8FA0CQyKYdqwlvBRGbyf8THXhXZm6Ji0rMj+E8CHgbooCr1M951/pLwpdHqlJ9ZrkhBuH7mqRyCEI62qqxqJmL4efgpn+bhv5JH8ffPKaRjo+d/s=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7184.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(366004)(8676002)(64756008)(66476007)(38100700002)(83380400001)(38070700005)(6486002)(9686003)(76116006)(91956017)(66946007)(6506007)(122000001)(82960400001)(8936002)(1076003)(316002)(33716001)(86362001)(2906002)(4326008)(54906003)(66446008)(53546011)(66556008)(6916009)(5660300002)(71200400001)(186003)(966005)(44832011)(508600001)(6512007)(26005)(4744005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nn5y/Jd8BDpCG+UT0gWP2Aljh08M+U//9ykeSjqI00bTpNjxdtNP4Za87d2B?=
 =?us-ascii?Q?hF+aDitPKOhDnCaBXsew2qyveoE2mT5oi/+lEYmvYZDtY1cYlk+rw5rFkKoK?=
 =?us-ascii?Q?MURAqALHdy1xv2czfGmpDD3TmdNjuXjDTGrU569su+vGn1AMt2s5neiTyLTq?=
 =?us-ascii?Q?Z86BmLyYeUSLOqdR5yJV8AS72ZIZ3DH0D+8SSqWORIPQHoyhsA131tBHGb7D?=
 =?us-ascii?Q?1n856xHvrim/62biCt2b51ddz2xjQVoBv73EdsjQlxHy7F5OvjsmHVlKbSdP?=
 =?us-ascii?Q?2LScwTDmYDyhFKMOhtIaCMEagoxd8PbOj72v2xRvD+6fUoq9z/+Edp8Uooms?=
 =?us-ascii?Q?IshCgAw/TzMU+BMOp1a1GInEKXQMWNJLj6FEWXKzdhzrEHVE51X2L41+c0q2?=
 =?us-ascii?Q?7zBn+MaTZ9qaiacuKd6BL7IXSg0xkbQOsuBKXb552Tg3r3Tl48FqmxB/kMol?=
 =?us-ascii?Q?Pv7wpMjKJFwULmVQts6GckRPmjFcft5croT3d1g46rfoKQgbP7Dky8qnT23v?=
 =?us-ascii?Q?K7tCsjiRLx14Nh0Bs0PFs8EEvQWIERhBrKzMLjT+xjGxxkdudFH4/UdN/4V2?=
 =?us-ascii?Q?CfRK4bu7GSQdpD6F/Yv1JcSDoRtWASU/YIOabIpmCcxbK0qxoCQvQ9LFm3A4?=
 =?us-ascii?Q?kO5i6yq6CDDltX/kDh36oZMC7aLLu3+ErtfZRXrHEfk2iCMiiPxubqUi10KH?=
 =?us-ascii?Q?TBwT+92dGQjvAY5vSFnwZoZidQ1yCj83umV0NikcQZ9JR4MU8FEdW6H0rJju?=
 =?us-ascii?Q?+fxdRbNy9DsvMGHG9JK20G9J3rDQSE3EqojqG7ah2ZcXnQa2pO9Y2rAgo7xF?=
 =?us-ascii?Q?ENrgVShzOucxZwBHAS6d5yqm4Q/3u3LW4ZbELyyD3zoYHRPciQP/CfIks3Y0?=
 =?us-ascii?Q?hNmZh/iZTldnrXsyf9lwmczE3wIWC8O9jDG1iIN80KizdJWT7eCnxzle+VA0?=
 =?us-ascii?Q?2HNoQpNcyE/WXJm1Y+5rHhUcCB3wjFup3BDqHJAOtgABR9TDRLUKh75HMajH?=
 =?us-ascii?Q?a7539C1glW/TeTqePT5IHBKhXNQWxQSLM1iFGAaMWYuh8boVHjEzd4ow7qPr?=
 =?us-ascii?Q?xDVc8TAa8SEyXnKi4wyQ4OSCnlWVAztu9L01Z6KToTXSO/gVG/qFg4eVt3lx?=
 =?us-ascii?Q?tvTsvwsvSx/qpNYzuG4Ythovilc9+cZsj/3GzH+GuGaFwuyeyhQe7G2+MBlm?=
 =?us-ascii?Q?9+CWQNKLmk539fsRqEZBZPYObxe94BUhAyAfsy9yF90wroWjIs1hLYaYd4db?=
 =?us-ascii?Q?0UtjkgXyvhtmekBVvWFDF6Bq2GVaWlJYxCIA+5iSU+3W3ONVeCzEVoJj6KOD?=
 =?us-ascii?Q?vYcp33HSjEFpxyMq5zErM1p0W5Mk/gSiYDl7nqa40ChKfNUMxUz6zbRCpE9V?=
 =?us-ascii?Q?MqsmCXzhDi1bB2CGjGb1gQQlpFGRHtI4Pl622PLB2qeQLxr8zop9AAFQMbQW?=
 =?us-ascii?Q?9Cag/Cwz7ATPjWIwAjjgrBinXNUnHzx+9OdCZAkUU9tXP5Kx/5YtxGlnK69C?=
 =?us-ascii?Q?fq5jvwJxFi8IpFQU8YjbyP5yY404EHV47oGFkbULjfe+qS44ks07c/EVMHyb?=
 =?us-ascii?Q?GdIQ9W8zEgLLJrXXmRGTH88j02r+eGqMwxkGECDBIEPYMtYm7pSzJL+ABsWB?=
 =?us-ascii?Q?9Fxlzhd4chcgcakcYkFDDx3JxX5q0TubaggCZOJ5axEW8xMiLd+13sO0NHW5?=
 =?us-ascii?Q?4RZvOn//z1Hk0fNl0xGjcTuBLco=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <95CF87B7DC75DA4A8CF8A5644B418A0C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7184.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d87057f7-c09b-4cf3-26e0-08d998efbbbf
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2021 02:16:06.2535
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SexcFVNi6d6Xg/LoQFeeVuBja2BhKBY/ZoyqzWPOMKNHaCo5EXGN8WRWNiOfpy/92/6/of/CCltAj3AK3yGAeOJZ4GIF6m282KqTjp8Q8LY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5573
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Oct 26, 2021 / 08:42, Jens Axboe wrote:
> On 10/25/21 11:20 PM, Shinichiro Kawasaki wrote:
> > On Oct 19, 2021 / 06:08, Jens Axboe wrote:
> >> If we have just one queue type in the plug list, then we can extend ou=
r
> >> direct issue to cover a full plug list as well.
> >>
> >> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> >=20
> > Hi Jens, I tried out for-next branch and observed A WARNING "do not cal=
l
> > blocking ops when !TASK_RUNNING" [1]. Reverting this patch from the for=
-next
> > branch, the warning disappears. The warning was triggered when mkfs.xfs=
 is
> > run for memory backed null_blk devices with "none" scheduler.

(snip)

>=20
> This one should fix it:
>=20
> https://git.kernel.dk/cgit/linux-block/commit/?h=3Dfor-5.16/block&id=3Dff=
1552232b3612edff43a95746a4e78e231ef3d4

I confirmed that the patch fixes the warning. Good. Thank you Ming, Jens.

--=20
Best Regards,
Shin'ichiro Kawasaki=
