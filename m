Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5919BC61DA4
	for <linux-block@archiver.kernel.org>; Tue, 14 Feb 2023 04:57:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbjBNE5N (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 13 Feb 2023 23:57:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjBNE5M (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 Feb 2023 23:57:12 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E512D4D
        for <linux-block@vger.kernel.org>; Mon, 13 Feb 2023 20:57:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1676350630; x=1707886630;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=XgnSUjhaaAP3yCX5msEPE8jB2Gd2rl3fCuJYVLaKu8g=;
  b=CrrrwprHzsB/g4Yv7uSMGQpciTbsjbjxB+Y6cLheDRqPpqyr/O6DjK3T
   iKa8k2EAPuWwLEbIx8hkIe4alK0DeIOUCLSyECTG4Ho0H4W03jogqzTPz
   j+TrYcvviQt24wKvoO40xPHpVAL3d0BG6AUrY/jwBCzHPgkRLnx6ZrkdD
   ba9HC+Y7lGobVG9fSxlM80iO3z8fKmlS2U/4tZ824WdJvd4RuGZ3qVheA
   iyRXvK7+PGAUpXkCC+f5hGJehWhggRw2d1BnXkVkz4hZeTpOraztjcZdN
   ljeMVgFEiMbHDVW4LJbBla0q/WJH44ZiXQjp1/O5zMxwDs6tTjR/XzTAX
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,294,1669046400"; 
   d="scan'208";a="223262032"
Received: from mail-bn8nam04lp2047.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.47])
  by ob1.hgst.iphmx.com with ESMTP; 14 Feb 2023 12:57:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wj62CvhLiZIXLeFwZFomjbAz0xAEHeVkPcswTcX/auyeKIlua6LvjYTruUZOTYgUf1I5HkimbJbED6wmPBjd8mWN1IEPOa9PtPEoE0rZar8Ti1GTPeSWMavQ62flSGGgxJVPHfEPYbhyPtsT6JOxYMDyqZiIdSvvxgdPf3kUKajiWB85k7DDX9v5Fk1eEDsrCmM5KAqCCuRDkrxSxJ5rfGF+SzPcX/EIa2dRSzTGhGZdaJ3Iz9wYKWKj6jT0YdJGGy8iV5wsA1fTqiqxLM52iDCQZWCa1OddHUAxOdnAU3wa5ZqxudBMCE1AUBKudmP5lnuOx4E5d2EHlUScGgfFxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A1wDzZ4bGmlVEsS1+nSwC7JGUX9zsRS0gyoOXafrEUs=;
 b=lcKB7ihKywOOoUmJqatkOergTPWsbva9ycyWLWAJinSvbOKg9uqGdk1bQUTqS3pf4lOTqntenxGhhYByHtU1pvgv4mSDxIUoirce8RQkfROw1fxVwaO2ld9arIMQsENySC9I8a/wIK/8WnTWW8DdTmGMTtprpPSG1xQRPhJ9sCiP9ZGFs8YD8BbPq5jrMEvm3b406GaSxK4cynzDsuVxdgNkFgiBFoGSeasv/pRhwS2FVmfr2xjwItZKuTWvVlGwVzUKrpAnXzx2K76ZIKzZV/v5g1VLNSAxMNJIbtXPvOXdLd35Y8CP7BUenYZyMbw7W1OGrRf+mxIg/7AA0ft2Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A1wDzZ4bGmlVEsS1+nSwC7JGUX9zsRS0gyoOXafrEUs=;
 b=oJwifvq3auDDuNI7uhbEr21I8hl/Pb0XnAFKPPAzi2WlQ2yRQyHewunq6FpJgxG7R13A6LAu/GMmiFp+cTJH9vrZzr1RGoMN9x2EHNaGLLL8NMLDxkFKlsqrAFftQ+95zkNguI+6ODXW39bvcKbUV+DQtRmF6775RCt/rosO3Kc=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 DM6PR04MB4089.namprd04.prod.outlook.com (2603:10b6:5:a9::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.19; Tue, 14 Feb 2023 04:57:07 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::f2ed:2204:b02f:9bfa]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::f2ed:2204:b02f:9bfa%5]) with mapi id 15.20.6086.024; Tue, 14 Feb 2023
 04:57:07 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Kanchan Joshi <joshi.k@samsung.com>
CC:     "hch@lst.de" <hch@lst.de>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests] nvme/046: add test for unprivileged passthrough
Thread-Topic: [PATCH blktests] nvme/046: add test for unprivileged passthrough
Thread-Index: AQHZPGtrXToTKK9KXkmyiPMPihGYAq7HbkUAgACZ8ACABeCHgA==
Date:   Tue, 14 Feb 2023 04:57:07 +0000
Message-ID: <20230214045707.sf7hu4b7hzgzbyns@shindev>
References: <CGME20230209094631epcas5p436d4f54caa91ff6d258928bba76206de@epcas5p4.samsung.com>
 <20230209094541.248729-1-joshi.k@samsung.com>
 <20230210020114.zzmazatkxeomowxq@shindev> <20230210111212.GA17396@green5>
In-Reply-To: <20230210111212.GA17396@green5>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|DM6PR04MB4089:EE_
x-ms-office365-filtering-correlation-id: 8513d368-7f5c-48eb-a555-08db0e47ec89
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IdaaLc+FnMbm+V1JeV6jq7ffMqY5T6g7pUV9PYMae3wRiw1ahkAkRuP6vep2lXoQW6Q3o7R7PmuhQSmwRSDwrDGUUp058MChhAXTTa+MudbTiqM9npkhhVRc7Bgsq/7ALay8G+N6Mi0lqiOdSuDVGly3S1qOZWpjMa2/1OzNuME8Qkg44TKmaUQLyJIaihB9ZyA7x9EJgQ407YwxyFEQhSnNN2O7widYakWoh+ElG/Pn6wpgERQnbDwn5bKOKdlte34p0Fx0+D8o/+SMgogwU1WqV6eE4z7e4oiFtsbkYjzQM/oISHqLL4JCNIatc0Ru5XwVW8qW7BNJRsqd2tZhNIjLk6rkUWK/FghlK5rXNfaMSldrU4FU8Lp+wxBiFE161bkyVuWPISqSw9aZeONJpn0cvDKvBKMLv4UHfI3I/zQt7l1G4Hhs5rjlVFAISRg7YPYoJU/V5GXMgms8keqjFWUN+/7NRtQX3Z1E2Lp1IrrwzFq0uCudttcPQS8tdQHMAllbPHuJsHlI8Mnx6DQL5trdoH2dX5CNXlIq8LtkAMu9GG6YoQsntRkr9jLQZIIG5JxE3m3WVHQIH68yR4X10DHXW0Q11rWMQ+zdkQg/Qq0v6EPJCLmPmJsAqVTA+vV7Ny3/Qr0QDYekVxg8/CW7Q2h/W/bDAX6uRmQY02V4EMiiqU2Rcap9SnfsX/9FkAS5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(7916004)(376002)(39860400002)(396003)(366004)(346002)(136003)(451199018)(38100700002)(82960400001)(186003)(1076003)(26005)(122000001)(86362001)(66556008)(91956017)(8936002)(5660300002)(66446008)(4744005)(66946007)(64756008)(4326008)(8676002)(41300700001)(44832011)(66476007)(76116006)(6916009)(71200400001)(6486002)(54906003)(316002)(9686003)(966005)(38070700005)(2906002)(6512007)(6506007)(478600001)(33716001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3CXIuAFyXYvHHbO7InHtQIGS16tC56OVTLoJ/W/hDO3ipeKWrRnPg9sbKClL?=
 =?us-ascii?Q?onYpSF4hF+oO0jCCGw5ILzIvrk0iQFJf+2WJfbaccXe6fAwqwwNYEB6VYzOv?=
 =?us-ascii?Q?LKsFz6IODnklhxJ7cdedndfi5dmowyEiaVFcVG7TOu9fEkjt2UDzGKVDYq8J?=
 =?us-ascii?Q?vrs2j7LzQsswxy/m57e2TVd/GBzjehb/YuyUwChITmQS8Pv5VUIylgERT7rh?=
 =?us-ascii?Q?5ev9XnWLg4dleBemGjYmKBlBN+Jpuqjp2AKac/j+jZwOIh2PQT7GISA869NK?=
 =?us-ascii?Q?SJti2RL1prMHEiW58C91fFs3bhbeYydk/fIQFp1lcGOTmsjJhvmD6HBloaVE?=
 =?us-ascii?Q?KAY/rLtwgg1zZ+uqRUhOzp2CLNqfIrrXHGrvLrYNtepwYjdRS46BMb2/6Li/?=
 =?us-ascii?Q?+cdG+VV1YrXb3EZS1stzMHrZBLyy9CRFVud7lOQdbsXEebcjByllOdnifgh6?=
 =?us-ascii?Q?h0WMuwmrQfG78WNA4q/O0Mo/9RwkIBlCdM1tff5RdhtFNoto2flN6Rn3Q5oO?=
 =?us-ascii?Q?WiToRzY9ibgreoF0OGvecTjh6h0KKYRNWUS2MkiqQ8NaIgTrTBv23pMlvMl4?=
 =?us-ascii?Q?9JUjHIaHn2cY8gHcpzqnLCYHHjvnnJklzQKEzgJPjz+RQOHr1nYKTaanqDpE?=
 =?us-ascii?Q?98NibO/nLs4oOL4UZY5pQga7G4SspehIu6cgugwNzPN4rpyD9hgTPzoPkuTa?=
 =?us-ascii?Q?xLsY/uo7KyZRZWBnzCRyOVdhPSxRqMkcYkT8g40sJijPzvdSSdcLUykTBst7?=
 =?us-ascii?Q?VziYwUtS++iLVqRkj4RK9MLlomOGtQiY4rl72DxBOb6Q/RJNwHPePTwE2g9n?=
 =?us-ascii?Q?Z8T/QCpoJaas9hzh/nB7SZTGpS1OnHRk+xxQ9//8U/TcmfN2Awjy5UbXgPR+?=
 =?us-ascii?Q?qib/O7g6GjyHt9VVOuZNuGCr4ZF50xqmTjL4Ql+N7szeqcnNlLWwi0p3vg1O?=
 =?us-ascii?Q?KoC7nEu0pJuFcAPIit9qXlsBzf5OcPVaHDZ/akod3cWLfFwD4Saa0pzCT34H?=
 =?us-ascii?Q?3hP4MdTEMLLARrOdZD7/Sbdf84Am5lKiBmcpBHFeIjrDRY/XSsk3XhkNMlfN?=
 =?us-ascii?Q?XEj1zpLfNZlEWacNuKJaw7NJ1PgkeZh+jbSo5E2DDyGVr9nqzkD2+3e0/7ty?=
 =?us-ascii?Q?roLVoQx1OBUL9cZtVu5VVGyYwo9JyxlMOjh1csqhEeEotPCg515w3dn8YRwS?=
 =?us-ascii?Q?Dqhf/PaJmqWoAr0higvizVuOPzktKO/UCo4NDRK5+212dxRNTTfiaLYzZrxa?=
 =?us-ascii?Q?Y20Fd3FqAD+r5HUP4QJEwQ+e7zDWvRBFGc8adKz8Y6yYlGMstmGji2Yp8WQD?=
 =?us-ascii?Q?sYLsvkdohVK6e2gau9rY8B/ktc2BK7NLpFRQVECCQx7UNHo5r3grjrzk3iQt?=
 =?us-ascii?Q?qkdAI2nAdoYYwDvA9kys8pdKv60marGqC14wN+evwQAoUYIwd0jcsUM6Au8c?=
 =?us-ascii?Q?sjqBr8LFfwB3Icl93VigT7cax6rPDQejMjkI6FGZC9j/vtDkVoWoW03K5iaa?=
 =?us-ascii?Q?bJLBDILfVGdRBDnZQFdoHHlim9vLHopwuyUfd8BUJeqy5or5QyZSA7bcAljL?=
 =?us-ascii?Q?aNp8jDxtL9j2ZPYWVAN/W/c1gjoztFZoyz4WCotIPuNT/x2ml/GBkfO3vR+s?=
 =?us-ascii?Q?m8mYVk864wRGGn/dGaxRBKo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <24ED7B4414AC8749904E5276EFA660DA@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 6gdWBGPfR0s30uvLF+LuzK/hcZjlvne3CVe+JNQQVXML+vYZLrRHroF6aLZ+J/Ef3IVzLRJ1ob/Rnd4kG4Dqr2Djcf2VB5hKvJj91x8cV9J7+TyTWy9TmWf1vszJCJDcFGfsao/twqBv+bC/2GHtpges8sz2iAJscD3+0rNRTzzQMFtbsnuRZE+sEa+gRfFxD5frFNFyKO/3OFUkC3Tfdu0I754YZ0HEXrmYKL1Y4bJNm7fhhMiKtnhZLrfw59/hLkTq+1V4nLv3U47OFxBIgIqPOQnWdDCZCX+5bN9ND3pNVCs7Y8Ufr640yT+vjaUIIrgm86bWsna/dgOQUUO1a1o/udtSkJp/bLdM9b7ctd/uymA1dw0zBLZcxHqxAEl4V4+TbY2yUgxVQ1GVt3V1Nn6k+naeQZCsgWO5TmDMvGTu9roAHwXGZKEczNfHQ9FqyUNR/b/68+fcBVFvUwlKV2D+Pj6z7L6M2shzPixLoWFvEdlbm2rOcUyCYpRH6PQB8usnYu2THcWA4s/EeA33GnLRnHUGio4upbH/Utg3knv/RIEis2V+Ww0DoREU9jtaSH5AxkcJzTZ15lpy4PDMkzjD1T+f5PjWlqdfF345mpjDIza2OBbA4Yi7YItd9Nh/aSdyEV2pNfZ9o2hj20XxXdmXTPgKquuLoepcdF5S01qI3gaV6BQnY+jLu0b5b+nUGlrBCwtgiWkGAYBbK+SKh3mW1kUcy8GuGJU+DNu/yuSaQU2mGM4okfyRfUzhiHf7yYSzQxp1EC8icp6e+XbW9SaF0xH912LLZ0IO+i4vYZnmZt2SgNBysKl8W0C2qOYF8gry61cKDz5NuW2TgLQkb/dV3DwIegg6AMe68cPMWSC4OKCYYNauj15GL0xux2C4
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8513d368-7f5c-48eb-a555-08db0e47ec89
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2023 04:57:07.6499
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lLboTsUcBEXOJOuFv7sqhJrp57MLmFS2vnxJJYUaz5DCEs4bMC9xmo+aGvruDAyicC1eisks5DNXTKBGMzTL0fSA6AOtj8w/jI6AzKkx9Rw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4089
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Feb 10, 2023 / 16:42, Kanchan Joshi wrote:
> On Fri, Feb 10, 2023 at 02:01:14AM +0000, Shinichiro Kawasaki wrote:
[...]
> > If you don't mind, I can create another patch for further discussion ba=
sed on
> > the suggestion above, and modify your patch to use the new helper funct=
ions.
> Sure. Please remove "_have_fio" line also in v2.

Okay. I've sent out v2 [1]. Please check and confirm that it works for you.

FYI, I did a couple of more nit edits:

- No need to call _require_test_dev_is_nvme, since it is called from
  group_device_requires in tests/nvme/rc.
- Separated local variable declarations and initialization. ('make check'
  reported shellcheck complaints about it.)

[1] https://lore.kernel.org/linux-block/20230214044739.1903364-1-shinichiro=
.kawasaki@wdc.com/

--=20
Shin'ichiro Kawasaki=
