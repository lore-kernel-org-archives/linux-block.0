Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B30C433F5
	for <linux-block@archiver.kernel.org>; Tue, 15 Feb 2022 08:40:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232532AbiBOIkO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Feb 2022 03:40:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233178AbiBOIkM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Feb 2022 03:40:12 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80883106101;
        Tue, 15 Feb 2022 00:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1644914402; x=1676450402;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Xru2nx7zYmCRZ4aeE1WPjpU3oSbG1NZCRqUc87+lxBQ=;
  b=cYihmAZfaPfS6RlT+ihT4ThM9hQrvz9kGRxgmldVi0a7rV0k4aZfIyZu
   YhezMO/oBfmNv9GoWWz3MKDBndDGNLaKPBfjiavrHq9Amw7Lb9vBVvgvc
   Ew9nqdHh+Mjx8lb04PlWvsfoavUb9fk9r2XWtw/caOvIVUoQpENWtZBe4
   zy2QLfa07S4xtNOxZJgojozh9ydBaihkIWzKwFmMAO9ic+p+EdpikEOso
   zyDfnH8bmaPXjXfRDtlGqv2cYyquyCGPAX/TQxp3/6uInjr73blGC6APJ
   kieGf+7Oms/nDY1E//z36wipaqigJdze5nLnAjiN184crxRsJjolL14UL
   g==;
X-IronPort-AV: E=Sophos;i="5.88,370,1635177600"; 
   d="scan'208";a="191921056"
Received: from mail-bn8nam12lp2170.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.170])
  by ob1.hgst.iphmx.com with ESMTP; 15 Feb 2022 16:40:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XHsav6ikADxtnLx5NP470hXgNLVGNQJQn5Hj0Px1XfF8SCoOjzUe3PDxZ1upPPT/tAmsKtXKIpa2CufLlnmkE4BY5vTC8R4KviYYTI50biF1wccgiTrpiyXxSHmV5Ef4qypmiHgvF6oKqgL/pYGGES1BN+aXifC5lIVfxKS0E6Zru7kjzkAP+qymzKqgjp52YIO6yPDx3SgBlFw++D9GllVkK9v7Nut6uDdEZUph2JfzZNXw6FHx/ncR/5tFYVdIQWWwAQEdi4Szd3e3lad4PrwPKDgoIN8ggXRmhx8ARLnvD+wzT34VuPFj1PrJkiksPeDFI7GZ/DEYAWRmstvVlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=57qDBTp78tiHtxz2ioLDK1aLHWY3fYBm8ViBo3uq7e8=;
 b=SjjskwO1lLd2Gg2efiTN08nUVITfuYR1+tBIYiDAAqCeSEvZD8uRlTPWR09L45j9AdldZMovSz5dJU9iJABpMVUaMWireP+kGrK/tzhRyTrM6Xh7QxKqHhggBPXatpixBKMri9Lcg4RGVXgLf/HHS87UD+i+x2rMNm8jdl09nXUqrUsCLtLCEfY/jRld25X6aL9Mdt579cPUqPrEsDR12fFHxbAQbEf3cmCsE98ezTmWa+kImdjl3pNK8MIeYgMSt0wE+23Yvev94b54lvDNvG/F5RcMG7489tsma4Xk8Ebwi2ajzi0nmec94rMVRy3qJVmLZ5NS593JlKLZ+xyzMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=57qDBTp78tiHtxz2ioLDK1aLHWY3fYBm8ViBo3uq7e8=;
 b=AeA/DFD1RXB/ppNWORVQl3eYIbbqZxCJZJ42A+NHboA0B3PIGNwO2rZ+Wq8e1m2BqRyp6Y2NdChixIOsZbZ1iuTg9s58WMlsv3X7bL6zu3Fwt0E2BhacqNK7SpKAaCFsWllNgrxz8HdCJdGboR7OASKGIzP42PdzWRVSmKroY58=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM8PR04MB8151.namprd04.prod.outlook.com (2603:10b6:8:2::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4975.15; Tue, 15 Feb 2022 08:39:59 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8d9e:d733:bca6:bc0f]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8d9e:d733:bca6:bc0f%5]) with mapi id 15.20.4975.019; Tue, 15 Feb 2022
 08:39:59 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "corbet@lwn.net" <corbet@lwn.net>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH] block: remove biodoc.rst
Thread-Topic: [PATCH] block: remove biodoc.rst
Thread-Index: AQHYIkOgIWhf5ZFmCUex/NCUdQwRYA==
Date:   Tue, 15 Feb 2022 08:39:59 +0000
Message-ID: <PH0PR04MB7416A420F3C0162994BAFA789B349@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220215081047.3693582-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eb651076-3742-4ee2-b143-08d9f05ec087
x-ms-traffictypediagnostic: DM8PR04MB8151:EE_
x-microsoft-antispam-prvs: <DM8PR04MB8151DBE3C25961BAAA0A57739B349@DM8PR04MB8151.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iS6BST+P+62PRbY50LhbCUwajk/u0cKxWulG4pzzUF0YUUqmUFPgGs0ForxfXlaGMw+d0JEE3l+Zkrqu3j0GKh0r/NckDMzYFn5UZ7CChVsRR9c7xeMO6sUflgu3ciHMgxSFPxhgBOwoDlTM95BjDfSkHMBV2AogahvxlZ4c3iFGuNxbq3PdKiV39jXnajm0Wxm7EaXd7oqsZX6p9df+J5FR1AiMFUlSguq7LuK/VTiXZFNPfWpiRIlt1Sw2r/e4QZ1qhDhjgNaeFkCqcpHL9AQbdei2HdH+cIbc74rkiK0iZbzVXX3x7uTWH+vW0KBCaXSYkVPxVviP5NI9VQTrWf1MrDc+7wawqzg+yhD4dKliBPLaxIjSid5AuqVqKrGjwhKj+8CHK3SNDFBe7uvTkxf2bYyC2LjcS+4nAlU8SJkpjjd+EyKYW3y328u1mef6W6AQjzfKAsE5PQxT9gGoT6mYokoxG4OH84o29dN/vxGDd9rV4h6pNAONruCiwTTqtzZpt707dHPQZHugxTaix7+7nunOgMly/fSpDt3gSM4mVnsDpXxYUsCuwPhGIZKwoVptxp/X6Jf74c3kP8mM89JVryhA24MbIlyPsg7QoQrZ7S/XjbdvvOj6oEmiv8Gju/aCzCqkUnaapOPH2blwc19F9mzsg+dQ/NWzg717mdWTXBMq3zMpUoPRHXoin8crOC+zYrukliVVjOtekRW2Fw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(110136005)(55016003)(54906003)(316002)(76116006)(38100700002)(4326008)(8936002)(66556008)(66476007)(66946007)(8676002)(508600001)(91956017)(82960400001)(38070700005)(66446008)(122000001)(64756008)(52536014)(86362001)(558084003)(2906002)(53546011)(6506007)(5660300002)(7696005)(33656002)(71200400001)(9686003)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VeIA16ACIvbG9GYrfTGbp9punV8YTLwODkLn0dpnfP8rkrskWVJz5RjrYzFb?=
 =?us-ascii?Q?Nkjq5IPeuhQaIJLl+VS+eyvkcJPV3QmbojrWP+13GO/V5+VWSyGyY5Pb8+J/?=
 =?us-ascii?Q?UOEoSiKnVBGKDLWy2htcghvc7tkLo1X17nAI0MoOn4qVkbstr+vecpVgncc3?=
 =?us-ascii?Q?roeRgEadkUW9+DgoEMkTuMQbMQ5wWygecZLA3kLJoTyVN+XImQtMT2zW+JPm?=
 =?us-ascii?Q?nLT296pJG0KNu4ON5JupD4krRqoD4x2ffhiY/MOfLw5hYN5HOvu36zBHLylz?=
 =?us-ascii?Q?p4JJXo02UvLOT8w7PnHzvNb6K64nukaIVx8s/l1mFptnEyPBxNEvCu8z1kCH?=
 =?us-ascii?Q?lYBXtVWdq3LJheSv3e7E1Xut7WBoIvWAobOCjM+4HkGQrnGB5MRm5xsObluG?=
 =?us-ascii?Q?Z0M5RAIstwA2iLkQuYTvCy+1DNiZxYyVnNMHB9NoUUUkXn8TF5DJjMtZ0j4l?=
 =?us-ascii?Q?nwT2602XQDUJ/RSpZ37TphjelLF2OQf4+bNRhTBwhKrlUTy6CmdQi+TOt1cf?=
 =?us-ascii?Q?Brr9GfTctRIH7+oGwMolNSJya+4yuQ4zQlc01rMSEey8ngSexUBQCAwyiH/N?=
 =?us-ascii?Q?jWRm5N1WUu36KT+T6BaytyLzBhb2Td9OCfulf4g4LBrkFMbJVT5v+pTAQ1E6?=
 =?us-ascii?Q?iMttuxqf2OslpdbJMGkIzCLeysRwMHLDUZBQ/6ppIKlK4QZcIIZ5kiJDw/V2?=
 =?us-ascii?Q?6Snbu3WPvfzxDGhS447yhCuw51nDBJeK1pGN+iETic7bYTaVGwhMI3f5iVsr?=
 =?us-ascii?Q?6F1bqWBou11escYA5ilPUlyPDlhNGZPa9COQQ/j0y+V1/MHOlL4NylLAsdt6?=
 =?us-ascii?Q?SPeLdOLJsjCrKAd+IXpHj9euEGesJMTPvTFo/2cHZaKDrcRKKf2FAMZ1tDCc?=
 =?us-ascii?Q?youwke+EW9n58eWBOPRJ51BcndoFH7W48Gp6atEI3HP64h4qRQNOd1ePi3/F?=
 =?us-ascii?Q?53IAVi+WjYnrpv8yyz4Czai8So4AdGWtty5CXtBeR9yPgFeDrCX6t0a79T6C?=
 =?us-ascii?Q?rwiBC1M4aakrkW+HWjBMAgM/Q/Hv7tGjsUob25IoL2lJwwIPbVg3YhZFYCAw?=
 =?us-ascii?Q?SOhR7iNMwcH7H6yx4UNJLugE4oACZBjWNwepEAQK8zV/R8UH1VMXJ5zA8vNu?=
 =?us-ascii?Q?JGgmFpHeuq5ez6FBkF2KgJVtBqs5/L8P8GO1Rs3kHpoMjIOB2cZ/G42S16nt?=
 =?us-ascii?Q?oS9i/H2+gurvJywEpV3IO0/mhN+GOYzwZ7yDfgXY/vcbQIQZNSQvcvoXq/bR?=
 =?us-ascii?Q?J1b+qUMp8h1z/Bz4a8iyMhHIASC/N4uGQhz1foXi0mftwSV16Jm3uwe+74Sw?=
 =?us-ascii?Q?+noG82OEI8vxOPkZhnn1Jw0t3go514aZ8yxUHMMEU097FKduw2I5Joys42cf?=
 =?us-ascii?Q?E7X+lhwDygC56KhJhJmbeDc0kOCGJU01wmAfjOjfw0UHXRvWeSmWDwORjN9j?=
 =?us-ascii?Q?Iu4+nGzp1+8NR4XocJS34Gelx870kMbzzGrjJQf5Ha7tQx6G0DgQp9PZk5nm?=
 =?us-ascii?Q?NyiTmmZfrVbYcgz2xwMvGr86h01b+CvCT63kmiSuti1ytLTcHKby8AJbbQG5?=
 =?us-ascii?Q?j2FslUABUO1Iqj1j9btzp9Yt3F8JPPi6YDp32PIjgfnMGpXi5zQe5Uy0amlc?=
 =?us-ascii?Q?BR71nkL8ySBJ5LPNQE37qxpKqosKfNoYFoRSwTfKbRCdO6qVRsAtk1Zs4yiX?=
 =?us-ascii?Q?c23dpc6pr1S49KH2x3kb00iCVqh/N8CYPg89bcO2bI/iRmZggh11g4DOQ70x?=
 =?us-ascii?Q?ODHX1xFzLtG43mXxdnAisD8hKI9gZq0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb651076-3742-4ee2-b143-08d9f05ec087
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2022 08:39:59.5627
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bw9+pJkQKKj+N2mTVRBeIcimaXFo3GQTubwWfndDS9mC1EwbDRPYo6VIAY1+cubZ1TGNlCyYPxmhseLbBc8FZuyCI232D0Q8dKXac6CPicA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB8151
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 15/02/2022 09:11, Christoph Hellwig wrote:=0A=
> This document is completely out of data and extremely misleading.  In=0A=
                              date ~^=0A=
=0A=
> general the existing kerneldoc comment serve as a much better            =
           comments ~^=0A=
=0A=
=0A=
Otherwise, so long and thanks for all the fish.=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
