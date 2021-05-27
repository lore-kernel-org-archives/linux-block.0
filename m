Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FED9C47089
	for <linux-block@archiver.kernel.org>; Thu, 27 May 2021 08:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73D506135F
	for <linux-block@archiver.kernel.org>; Thu, 27 May 2021 08:56:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235543AbhE0I5q (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 May 2021 04:57:46 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:46855 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235392AbhE0I5o (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 May 2021 04:57:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1622105771; x=1653641771;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=RNA7H0LqBFQBc02Zpv7aaRIP0YTHhXpzXaVtxIhbkn0=;
  b=rEZ9IGdbS2n79i+CDLDeQp3gYi+tR+yPhLg815HHltwx4fl79kPEXIzb
   NbzYcDmFySfa+TuL+vpNFARLk8bQ5OWvGmbl2hqtxmsJmVZeC++0LLgN2
   DclNdmeSt2Sy0GOSAaI3+TiKZeFBkYeXmLQgjIUYUF5oVBhe1Fc4h6Pdt
   PaZCkGd2SX1C5H4oCS4wUWA6JlLYnLOFwhkZ5YW1u4aFC6o6pWpdvnmCr
   6GNuW6RN5iN3FQTAZQ8XA+umAJLbT7e3/YxMyOGPZlCBDO+uD/gwjzN/E
   ii2u9+LkTZD6X+6llCdFhs8mcvaLR3Zo+Xf3w8GQbZ1zJJu1hWKh9F/ee
   A==;
IronPort-SDR: CJ/SVVDsVolm2dqxiOAAXjFQlOiT3KRRkRBIdjrQnapZH63rMl6Qj5RbHS9WuoKVkN+MENoN45
 MFFTQpq90bmy2SajRLcpSZq7eJgQAm8APg+aGKZzQ9ns5CMUwalsfZ85YDfoq9Y6EAeG/9Eusp
 uU8/FlSVolBQqr2YmELwa6pz6pVQ5A8aMiOj0fwZbyB8yB6RtXUuTZmqZp64Mj5DWOWTVNtYn3
 RXykhtBExFViN4xVxZAGE5GhsaiXnpY2ZZ4fpRpZlSr9rKiKT8MDHyeyaqjqGgAxi3XZ8Gzimr
 BBU=
X-IronPort-AV: E=Sophos;i="5.82,334,1613404800"; 
   d="scan'208";a="168926628"
Received: from mail-co1nam11lp2171.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.171])
  by ob1.hgst.iphmx.com with ESMTP; 27 May 2021 16:56:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CSEP5xLLFfSiTlwWMPY9aAg7G3gPDUGkviS7MrQrA4NTuYBfglzDK9qrCadg13HizWkkJbYk9LVhZeDG+B0AYaZchgWSkZRdTTIymUOxQ6n1nE5AKb/IilgCSalhZq7TIQVC/c5B4H5l6Mnu1qG7DyIEuW6msueHWZch97lsJ/XNSjAUfmpulHAl1nhDenX3eR+GfhM6GzbBdYr5IEfNNciydyXYbV2LrK2CerOZsvm+GqCeoXAXfFGv4cYsn+DqaVR2tXQL2bCwmY5leip0s6el7OBj6xnNOz44oMOAIoY2gy3ZgCFogijBqhkwseQrciz2ALPQwplE2tm1Q/+P9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k23+Rzda4ziEijh2ko8rsa+sN5ZXcC0asgVYAxlHXJs=;
 b=dgpbnVz9SeQpF05XFB1BjiDFZp6lc5tf/nky2aDbE6q+ZvHmskcDQlhNxmGQEN6B4aWCHSivAu2eS5FmJhHjAeWv0rRDfHbKQMfQr/niqgQ1eoL5Apuv24jTifDJcRs8DVBXYidRBe4JSIE41f8jKiRimb05iHlw/wlirXgUG+Ev91AdPRiX2M5GLIqaN3tDgd6/vG/PJ8SKRSJwgHSHrRLwAzMrRYzjZo2XzXHNM2NsOVPXWfBgVhzFyPk2qKO20jMqZmhqTmUUEVOw5nlohOwheMMekVYZSMOHQJCfVPphMTK6RJJcWZaYM8xkCPCmqa7r3oz3LnajMyH9wlsTsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k23+Rzda4ziEijh2ko8rsa+sN5ZXcC0asgVYAxlHXJs=;
 b=oXEh/JZJtDlDh84ePtw0kVI5+XLW+l/4f5UzCUF7D9kopbpB8xknVhb4jgvz4oiLMXo5jnoSVags/Jy9CcxmopUwQ5DXFQORT3GRrvU6XIgMifEv4mMDAY0CmTXFh1mEzlJFLn9/VLjsH4kP4V7LAt+eMoAGOnaW8dRad9Wahdk=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7365.namprd04.prod.outlook.com (2603:10b6:510:d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Thu, 27 May
 2021 08:56:08 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3%4]) with mapi id 15.20.4150.027; Thu, 27 May 2021
 08:56:08 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Adam Manzanares <Adam.Manzanares@wdc.com>
Subject: Re: [PATCH 0/9] Improve I/O priority support
Thread-Topic: [PATCH 0/9] Improve I/O priority support
Thread-Index: AQHXUpPklg7OeKtgH0K0uxfCVbdVCQ==
Date:   Thu, 27 May 2021 08:56:08 +0000
Message-ID: <PH0PR04MB7416F36FCACCE792DCC5AC1D9B239@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20210527010134.32448-1-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: afb22a44-6db6-4632-0c93-08d920ed4515
x-ms-traffictypediagnostic: PH0PR04MB7365:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB7365FCFFBA4A24229F2525A69B239@PH0PR04MB7365.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i1m+V7IGAouDQrsZcB4qETbDIEg0DAZlg0H2GmjS299whAmQ+8+glJxcCai4876KcB8+8c5Haoa1jY00FPhPk6/hZFEtN+73lcSySAtAjjqv6nBetR6qDGwr1GIxMw3Bea3J4Vs7mh46xA1Sy7hBL17B+0qa42qGralzmWEpRtvGn5qG6nA6o+j72e1VUmm2ke5OD2O2zeGHM3zUjbtjb3HKhaPwkQ7daY/Rp6Qh4Cl+XyOn2SunJcbHan85Lt3acrvoK9k8hWLqrD03OZrDtcPqZwdyErRXt0gEFV7FfHs1n63tfkspba0+8TsURQGcvVyIpl5/Pv2ZTRNIsS9hqrYSwE2ZVHH3T4YGmXKu2hLk0rVY8M3TiS/tPvmuy6vaoGRmB9qLPLCLo9xgZrfKQzwp0fcdCRrVJBNjxklCL1la68mK0Bjp/gfMZ4ptfE3+fy+rxMWpCo790UAcqK5RsRuhYO+5T0iWcoGq62LEw+yMhV10pB3ZvBSxs+khMDenE4KAyn0KJr5yUKm2eUGRCFd9Vv+vGePg+FCGSHdJG/q2U63fTb2CpcUfyx2Fa6a30eW6jdrSljd2VxxEBdFMZSkPhent1ErbJtyw4hg7Jsw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(396003)(136003)(376002)(39860400002)(66556008)(66476007)(64756008)(66946007)(76116006)(316002)(71200400001)(7696005)(52536014)(66446008)(54906003)(110136005)(478600001)(5660300002)(55016002)(38100700002)(186003)(33656002)(26005)(9686003)(83380400001)(2906002)(53546011)(6506007)(4326008)(8936002)(86362001)(122000001)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?GpeZra85Tar+6kXX6JFliNgp2Sbv0M4cxZFjze2GUp7VUvewOCZxibZsGgm7?=
 =?us-ascii?Q?0B/px5j6a3h1NUqgoAUz07KujfXhFluacI/MGjZvBdB0gjjVyXltdsqZH+Jc?=
 =?us-ascii?Q?eUSvwuohGC/c4wxwlO+waYyEGvDmrKr7fjdNpF+HdV2APk5YwuaQXC6HCHP9?=
 =?us-ascii?Q?egyfq/AiLNQweP0K/LZRgwQ/I5AK/qGiMIxRxMg926FkHXv4aEJ4Q/ryq4z6?=
 =?us-ascii?Q?f2YTMayv9dmNJ3r/jRuCZcwlGQnE50cNscFtHIhVk3/l1C2Grdl4OxDFT9td?=
 =?us-ascii?Q?oz4PoVGgyC0wRLP+oN9jkpOscYGbrUxK2Q8+aQovuaH4B35WNfpd3AndsyC/?=
 =?us-ascii?Q?yZnaIP2Ut9pq4GTw3ZW6dc8H1PMAjqcTZk5RwZqB/XKtudMf/R6MZVBswbVn?=
 =?us-ascii?Q?sTfXPH5dWpKiBK1Sp2tVanOuvdqHP37ptxh1dIMomOVu3Lpav1iDaMKPBlHp?=
 =?us-ascii?Q?lvJl4gDAw1z6bOVEvzInuaYkgA/F6UQayliqxoO8jpS55/9fc31bbrqTVDoG?=
 =?us-ascii?Q?ZhPO4e6z95udJjzzK79T+5GBwRkowrsHznikduu50KMI5w+n9uSb+Go/EXo0?=
 =?us-ascii?Q?NEqcvT0GNDi+hmLUJCa95vAWuuwfPBxPU1yFol9GDUCaxQbfhq5bOYmtVxZ2?=
 =?us-ascii?Q?EwCd04BhiigCGc99qFMUPHi7jFeFcsHGpcCXnMYRZFNIodR94mnqYJzxMF58?=
 =?us-ascii?Q?RlUWSb4kvQ8uUeph7EXx4LjWsVU5mG6+EeitZL76NMip2f867N+xuabbeW2v?=
 =?us-ascii?Q?M2SLAW/86raN7HPKeIIc54+7LiCKtB+gS1O0sBBLhUvpr1LwEfiKc0nmGHTB?=
 =?us-ascii?Q?EOrq+ma4qoBB0AxA/Pp52ZwbUbHUq+y1XI1aQNKUmYLeo++8dUb7pEJE1CIx?=
 =?us-ascii?Q?Xwv7sBZOt6vcWgi5Ttt1Q0jkYU8nPJ1phtUuj3+2TzaOgTAODfOMxNs4Oxko?=
 =?us-ascii?Q?xIBiMbnPhZhCZ0DXhIb4ZuBuVwGNeYv9PTMr0M/5UOyqrvpBBxwXu/KnIbu2?=
 =?us-ascii?Q?5jjj9F2tA0IBYl4iikvI6NDzB2XC6S4LzpSPGz7onD84ZPvHPSNxtYexXHom?=
 =?us-ascii?Q?VY6yp9F3ksmCE8mhZ/GutrMsRXISJI+m/CouDtmx+Dz81uDmPutscr9mHoBw?=
 =?us-ascii?Q?EFZxIBcgQ5eHqyevikCTEBtxSlzislYg7pNYJbss4sx7n+hMza0v1uoslq1/?=
 =?us-ascii?Q?Ng/KthP9WqUNnuAubLUrhWWa/8XGK2MlYFuG/wMbySi0wyyTMIaCtoE312ii?=
 =?us-ascii?Q?LFGiA/Qd1Fdx9jCb8Ai9BJPAQrCsIxvi/hnMlvpfZYNyx4smP3Ywvp+nNQQT?=
 =?us-ascii?Q?XPjt+vW7uLYfHkN6Ms7/yljygtILu5WqkRsXNfv9uITxLw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afb22a44-6db6-4632-0c93-08d920ed4515
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2021 08:56:08.6786
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mv/0SGm4WNXt4lgVlIzhDvi9lbgEQBFZPTjJYzBdWHEOsKFK3r2i0lvyTGBw+GUICA7TzGffpwjFC2f+qYYba+g/Sgf0626R0aUBwgTa0F8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7365
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 27/05/2021 03:01, Bart Van Assche wrote:=0A=
> Hi Jens,=0A=
> =0A=
> A feature that is missing from the Linux kernel for storage devices that=
=0A=
> support I/O priorities is to set the I/O priority in requests involving p=
age=0A=
> cache writeback. Since the identity of the process that triggers page cac=
he=0A=
> writeback is not known in the writeback code, the priority set by ioprio_=
set()=0A=
> is ignored. However, an I/O cgroup is associated with writeback requests=
=0A=
> by certain filesystems. Hence this patch series that implements the follo=
wing=0A=
> changes for the mq-deadline scheduler:=0A=
> * Make the I/O priority configurable per I/O cgroup.=0A=
> * Change the I/O priority of requests to the lower of (request I/O priori=
ty,=0A=
>   cgroup I/O priority).=0A=
> * Introduce one queue per I/O priority in the mq-deadline scheduler.=0A=
> =0A=
> Please consider this patch series for kernel v5.14.=0A=
> =0A=
> Thanks,=0A=
> =0A=
> Bart.=0A=
> =0A=
> Bart Van Assche (9):=0A=
>   block/mq-deadline: Add several comments=0A=
>   block/mq-deadline: Add two lockdep_assert_held() statements=0A=
>   block/mq-deadline: Remove two local variables=0A=
>   block/mq-deadline: Rename dd_init_queue() and dd_exit_queue()=0A=
>   block/mq-deadline: Improve compile-time argument checking=0A=
>=0A=
=0A=
I think the above 5 patches can go in independently as cleanups.=0A=
