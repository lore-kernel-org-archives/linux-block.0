Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B0BC433EF
	for <linux-block@archiver.kernel.org>; Wed,  1 Jun 2022 00:57:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348832AbiFAA54 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 31 May 2022 20:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiFAA5z (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 May 2022 20:57:55 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57143532EC
        for <linux-block@vger.kernel.org>; Tue, 31 May 2022 17:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1654045073; x=1685581073;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=GBQ0ewJwqvPgPww6XLxIwDW77/gHWm7/90d0k6ZxQTU=;
  b=WFT+DoH0tRyXLey2BnqvzXSyIbOIMYxkhXZmT1BZJ2LzywtHgxm/agpJ
   MAnN5pB/Lms1rKtheSGOPcppzFqtGABuXTw0XPl7GrJdAwqty1MlJN7xu
   KEzh/MJCyRZCERRzghuHqRv3wyh7Rd5kU4BG/PqyFDxJ+eG9wCPzRNeCV
   kueZQX7bJlLBb8ish0DrSsPjpFIL65v6v4qvXMZVzIKD1JhKJg8wtRJf3
   4fIkMt3GYrJGAoCBQJkIhPUiqKjlhjobYCqmMYVcqVxZhZMArRiVYYCqR
   JreHaThhUkckvo0Xo6Bau7ukqTMgtpr0NIgxQD8QgCmzJmJiOE2vYuurd
   g==;
X-IronPort-AV: E=Sophos;i="5.91,266,1647273600"; 
   d="scan'208";a="306184744"
Received: from mail-co1nam11lp2171.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.171])
  by ob1.hgst.iphmx.com with ESMTP; 01 Jun 2022 08:57:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E+mOp7gn6WewiGzzP97IDyPNSzla1s0yx4eHiltfQHhVvXBofj69x6+ZuGO98j/RFbmYM0oOeyGxA8KT/gUcfgPBRKt80UYmzApo7g3JFH7y41qSgqFtYVAqzvf7DpI4S/Anro6ih6hvq2L08ci61945aamiYoQ2+XL/HdmVYf3QAkwQC5u0+Z7jJ4o1h7KSBO1msr0/wvSP+sND7pjwCpIA+yW4GU/WO8MDtRkRWxiN2vpYecj09TcchTmzuCbv5+E19Y5c4+8B0EbCN4B94cFMfTaZbApxxjGDlGUeW/0qRDVvUse0XNki6OBtKHKRbvbnp94d6vA+2SQDthBbKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DqxJO2wKKk1TvSRnxLmt1HLmbUPHVRgRbO5xOIfkmL8=;
 b=Boo8T35q4b1+EWEP2AxPON42IaHCuHfL+pDUpgeeoV30CnQxvH+X/cQ75IgaRuYmvzNnmMP+ctRaAvhv8pU0kT0TONZQHQvkPpz+r76TvR7IsDPNeKElXvH5bpcQwIDLlIn3zRFSx0E0ehIVO7RUWESz40EOPM7ICAWr8ucq0mNfr91BHrcAzGrqT2YuUr6RGHXHAt1sENcI6541hAuL0T7fJgiwq/GAlk7V3LtaxImxq1cZZ1g3NYLCHD/GZemR/7PhVx9sVFajP+3xytMKN+DTKuY03EiagPuyPzdEihKU8KLrx/h2/lU/EuhXqkcj5wVW9ezRiM7QLRLXwCA/JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DqxJO2wKKk1TvSRnxLmt1HLmbUPHVRgRbO5xOIfkmL8=;
 b=ZGjvIi2F4T1kamXu6d0PHDYeagiehTrkd8fSn+4Aikg4osIIw9136FfgbxUOKfM/vPdvHu4rzUmJn6qyivcPfct2VkgRGpS5xQODRc92sovZpRZcfXJAPnSsPWKuXW6TqolYSkyFcXZjYx6Sid0HXYLMg0cKKmvL+CJt5MxxcnA=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 DM6PR04MB3850.namprd04.prod.outlook.com (2603:10b6:5:b9::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5293.13; Wed, 1 Jun 2022 00:57:50 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::39dc:d3d:686a:9e7]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::39dc:d3d:686a:9e7%3]) with mapi id 15.20.5293.019; Wed, 1 Jun 2022
 00:57:50 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: reduce the dependency on modules
Thread-Topic: reduce the dependency on modules
Thread-Index: AQHYdCZZ3c9NzDfI5ECRDQ/agTEfEq05vO4A
Date:   Wed, 1 Jun 2022 00:57:50 +0000
Message-ID: <20220601005750.aq36rjxln43ipsme@shindev>
References: <20220530130811.3006554-1-hch@lst.de>
In-Reply-To: <20220530130811.3006554-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e83e1e69-8d42-4217-8b5b-08da4369c083
x-ms-traffictypediagnostic: DM6PR04MB3850:EE_
x-microsoft-antispam-prvs: <DM6PR04MB385066560584FD14801F7435EDDF9@DM6PR04MB3850.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /LKNrIDDvea+P8xJ0Pa6rkB7cynB9oo+V2OJrA/ZKerir+GWmk7/j1rOi3oN7W81GmNc2ADjAMMDHbmXXttZSOu5fYwARxr9DgQGE5utI5t0PnaX2PoqVdgn4Tte1HD5xnFLDEw3Cg7hlomPqdABLS1CjJu1whpAKCJG3SwLZa91c1VAqGtghhTosWFAGrYlCAOOXlNZF16e3wL1KnWItazDPGoMXyn2Naweole9Hlnvjd1F0m0nh4KJwGpu2Ph06Fz2WaWTUNohBQp46cZz23dLy4U2g8FEKlcDwR0/tAacHdCzjbVDosxkUj4ywCNI0n50cyoQgOwSe6Xtjd08iv6ehZnGXZ+abgdqXW4N3ZeTnNLkJyugNFYBHTplSZa4C0EN4OZhkAdmZkJ009JyK40zD/gLc3tNyd/bXRI7PbaOQ+xeH9c0dGlAfF4TWeYVeekpkyPp41ut10snLLRITKdDE/MEliadf5lEHflJB1UzB4m3xdPySyc3F6hMdrRnBXJ7PCDx5kJAQnQA7cyrZPe1zRiaWQwvAf2WhikdvrYmVyygS68Uou8EMCE3CzelCdTV0tycFH4qdW+CuA1VhrS1rBtO1Sgw+xCVsHZ3GPhSTsgNb2RHCGLMYcsy6ZYns63ieKmGneKpS7Y4YNuaSsyCzI5SSdaALr/gZ5SE94+uFsQvjT0hDe1QrLP2DOoBi0Kt/xmB0xaJ5c8EiG9wDQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(186003)(83380400001)(38100700002)(38070700005)(122000001)(82960400001)(86362001)(1076003)(6506007)(66556008)(66476007)(66946007)(6916009)(66446008)(508600001)(316002)(6486002)(71200400001)(76116006)(64756008)(91956017)(2906002)(9686003)(4326008)(26005)(8676002)(6512007)(5660300002)(44832011)(8936002)(33716001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OD2QpffjAiX4QTtjV6NsRNlkEsOPFDJ+55kHXf1XVkT4XFGOLmnHiiAm1PBJ?=
 =?us-ascii?Q?Ou4MrYpFw18Tb92LjKsrGUrNYEBQ5QLgUpfaGTuDPayXHuvnVQnaj1AAjeHP?=
 =?us-ascii?Q?Zrz1C2eL3+5cMdMRwzCjKtuVtJt0tZeJxe4GKSK3pY5tfyqHD3mFB3OhzECB?=
 =?us-ascii?Q?4R8ULX0P9gphYRXAp66ZKt5S+oQl9TTVGY3cDkxEUqWyP4eW0Kj2kQK054gp?=
 =?us-ascii?Q?kdNkVxCVrM+3a6Zw+1PNw3tNVTyTdkgYlFLDtvOZsWz6qMdD7iEq6WLn9UN5?=
 =?us-ascii?Q?o4m/0Lg/rOtg2Dkos53M59LWSuJiJmgPcyJw5BYusHHszDaM2kJEB4F5Y94i?=
 =?us-ascii?Q?PjLP0VI8yqs+eFnHBJuMxnWceHCiMixEB77K0UWQwPMDsHL9wTDsHGQWR79u?=
 =?us-ascii?Q?OkPHUdaLRiCHEYJTeXoP611B+ojk40hnRW6xA3AHrmiGiTEOugJOj5RnCye4?=
 =?us-ascii?Q?9ftPCblpzV0rr5slsa8jLKGOFEh9I4a47MB0zkcDl1HytiouvCX/WfXF+Y1F?=
 =?us-ascii?Q?0HUdNtC4IMWdVU2VXY5YjbU/VQsQ4F7EQgGuU+HxKRsA26+aVH0PUJltpMXb?=
 =?us-ascii?Q?pvfgN76Lb1mCUm8fvOp41R+ndZGwwBYLeqnlbSbVCm7bGeP59SeUg6OYmnbZ?=
 =?us-ascii?Q?x3ApN9ytN+3CJd2aLJliIIcCjvNtd4mb9V/ORA2vL18k06hVLpnISvbPYOjG?=
 =?us-ascii?Q?WG0YdEXGs3fSq20OTbN9dgvxT7HMJRdZN6cMKoazNw38bYK4zKc4CPP736x2?=
 =?us-ascii?Q?cuqBegr3ALV40G+1UznehYfwmBIkBPlNq5KcgiR5JzzQgzCogvP6zGqe/vhj?=
 =?us-ascii?Q?yrvX+yKwvvptJtHgYKSaBEDo2/ZgF0DK1S3OxXvLzIbCh4Aas09ztauU9g5V?=
 =?us-ascii?Q?egAmV+DT31Le5aX7MZF3pOhCtrs6I+y2bw4qDlfO89FBpD8v6sWVlnLW3YF9?=
 =?us-ascii?Q?1SC5dBKIn+HiLofrqzaUyT16GThSIl5JfLXrOKC5tOYS6/5vmQ6ox5Am4G6U?=
 =?us-ascii?Q?kpmL2GGMKYFmkJKxDtFKI+rngx6SzarsLWMSM+S3WBEJ1p6/79hxWmK+ifrn?=
 =?us-ascii?Q?pc6vtQrGWYW81ew2NBdklpZlzBqYKT5t67RkRr/GsCgIooNUYkKCmlHC9jZ/?=
 =?us-ascii?Q?rjCihVxQeWSlalyKXSF/WuzKYr8+70fA54Q8IFDuEC9PAHTSuL1a+xl9v/nI?=
 =?us-ascii?Q?fP0ET5yIt+iW17E0VZ8HMSfR2G9GEWp4xaLlwww2MWTxBLSVf7MUx0ReUGUc?=
 =?us-ascii?Q?sF1jBpH0+Jb3VctsZM14XpXTOgT2VFCLTEfW0ec40Db8WxljJfH9urqYCFk1?=
 =?us-ascii?Q?NHg/nCs44tifU2Zt+AT1ffP5WV9zHuKPAH11mTyZbinJi38e5opjC+voBNs7?=
 =?us-ascii?Q?VFAjSifhlUvHzsEXB1+bHXB5NlV03HUlFJLDIj3+igHhhcjyIC5Wpx7HKwJn?=
 =?us-ascii?Q?U7+LRBl6h3yi156t3OgSa9PFvRnCQvMm5rdWpGfo8BD1cZ8irA00g8S/9E4F?=
 =?us-ascii?Q?HtLYp5V1KmpKThhONeio4NU5Hp9t6Mp0PnbIYcamypsfgW514m8lkQ1RaVIA?=
 =?us-ascii?Q?kzKMjnMOMy99UlJa9mlwR5p+n87I3fpscEi1O8i8MzNYLV6LYl9Aw7jIc9WC?=
 =?us-ascii?Q?0c+t7L9ee4KQIpRA9DRIF50sMkBEazBsNUncwRsvLpblEwr87ivjQoNvb12F?=
 =?us-ascii?Q?RU7UWTh18XPqrA3JUNskuTIU2q6dFfashmNH33NU1CC3g8TozLEVukAPCWv6?=
 =?us-ascii?Q?SE4iW/+TmOM2BpZGwmw4CIYrPVuTAIcVlr1ejgCF4tDgLZ+TqvJ6?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E518CB2312FC6D4CAD68899B0FE84D24@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e83e1e69-8d42-4217-8b5b-08da4369c083
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2022 00:57:50.6663
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6Zj1TS41WbiyJ2HqN/5+QXwpc/fGqJlLl4irEWpVeLqXkWKK0ZL85l4N+z1gqRbR+x/Sk5WHG4tNMT7vZQHyGeH0hBwIwFsWLlEZz8+HsdE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB3850
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On May 30, 2022 / 15:08, Christoph Hellwig wrote:
> Hi Shin'ichiro,
>=20
> this series reduces the dependency of blktests on modular builds
> of various block drivers.  There are still plenty of tests that
> do require modules, mostly because a lot of scsi_debug and null_blk
> can only be set at load time, but I plan to address those in the
> kernel soon.

Hi Christoph, thank you for the pathces. I think this is the nice first-ste=
p to
avoid the module load dependency.

I tried to run blktests with the patches. At first, I kept blktests depende=
nt
drivers as modules, and observed no additional failure. Good. As the next s=
tep,
I ran blktests making blktests dependent drivers built into kernel, and obs=
erved
some unexpected behaviors. For example, block/016, which calls _init_null_b=
lk,
was not skipped and failed. block/025, which calls _init_scsi_debug was
terminated unexpectedly. I made related comments on 5th and 9th patches.

My other comments are nits. Many of them are related to shellcheck warnings=
. It
will be appreciated to run 'make check' command to see the warnings and cle=
an
them up.

--=20
Shin'ichiro Kawasaki=
