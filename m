Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D019C43334
	for <linux-block@archiver.kernel.org>; Tue, 14 Jun 2022 08:25:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352453AbiFNIZO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Jun 2022 04:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238830AbiFNIZJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Jun 2022 04:25:09 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A2F39BB7
        for <linux-block@vger.kernel.org>; Tue, 14 Jun 2022 01:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655195107; x=1686731107;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=RV/+/LQHUWT+KjZdXREw6LFyaH6AaAaN+drOt0Oxav8=;
  b=e1j7/NB1S2ih3Olv/BDH73CiYWEOxOPkeRNabJQPwh5MF+iFnYnJnfSo
   eC3Mbp8eJNzGgId4szUdhbw/JOzrScLcseea5KR+ReXBC6kdLMBIHR+15
   9XC2GLNzefDfVvYw0bjTuysW/JgHip8PI6No8QcX9lswHNT5bLO741E5M
   FdUQEvI7O5LMJgiuTQQzadh35XedfzsCIcxThxK+M9ZMrIWtnikDbXePc
   XxTohtKSUPbsVCKBqW1oAvm5vfmPC4DufM1s0zPGdtvL3bJgOOJuCm4jE
   +A5d5uSedRHacdLzs3B2hkT1ZG2XnrAHJl+6FpgQndAqNmd5FSP+MM1iX
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,299,1647273600"; 
   d="scan'208";a="203095622"
Received: from mail-dm6nam11lp2172.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.172])
  by ob1.hgst.iphmx.com with ESMTP; 14 Jun 2022 16:25:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k8EA4dziMKONAQsUoMv65yxAwcxfqfg3Anm8yJ1/lWp1hdqLnMHB50i8hhy6yb5T08p1RaiUEOWK8kMwT+o1qDTJAnW77AG3r0Ci6/BTtJTEjMsLwSxnici/abhkTQSLGENexjTsDXyNw/aRl1tf6LcoVD3VC/AuZqBvP1EEhLTy99eOCDBnUW5JE+iXCmaQCULwU41PmecXmDFc4tCBezFq2eXebW46DQrYFtOqluJyu5T+NrsLstqLMRtyBBW8yioz1p+LcpPioc7RH8ysCWjilh8cgoVOrWU4AY3rPxYupdyODRrPgRwGAUW0LfW9I7y0fWVJzjquzQeTTSdHqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QAglJobTJ3fF3/UfW8qDPAFATExV+c4JfGsc/bSIxlc=;
 b=ReOA7otsCGd7pg0/pD39yjn3cRGG5cSZdfwlAIWiBs0bSXu+lMawLWKClB1mGkT60fKyDD6vZp606jBTD0zarKQM5yXtCnnvPwajopHhcIijYYpSZTI9avj40CxVCOXBqJQ+oOetW6yDnzwnotOB04lcJocplsoWq+fIJ1GHHNjPeOM9YRWD+e1ZhcdA0eJv+58OuaM4/3jS5ulupA3MwRZKf0H+o6tSHD9qxDkLooyOUVh7b5hkKnA5Mo59ecnrlgxTgfF+SQDSYLjt7VtzGMBxoFQnFrb1aMAYX00ABn6prwqwaKF1XytIETn+5tx2N7jo0SJg6Mlv3uxgQQFWQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QAglJobTJ3fF3/UfW8qDPAFATExV+c4JfGsc/bSIxlc=;
 b=IE2Xpk5Ou7R6tqEfW9oHNbcTUz/VTyvBaMInkaNSMgAmo+8khklR1B5nygwv6Nqoed3yGY+B28F4WnZfHD17v6Kah2CkUrKEQq3bRnzAiXG0ClLZAQrE81o1lpyfU/2nIZnqLRxV/ILTOvLHvL07HZdJkmdedBtVoQyDT4p9LNQ=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BYAPR04MB4343.namprd04.prod.outlook.com (2603:10b6:a02:fd::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5332.13; Tue, 14 Jun 2022 08:25:04 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::39dc:d3d:686a:9e7]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::39dc:d3d:686a:9e7%3]) with mapi id 15.20.5332.022; Tue, 14 Jun 2022
 08:25:04 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Alan Adamson <alan.adamson@oracle.com>,
        Chaitanya Kulkarni <kch@nvidia.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests] nvme/039: avoid module loads for various
 transport types
Thread-Topic: [PATCH blktests] nvme/039: avoid module loads for various
 transport types
Thread-Index: AQHYfMPHELmbdoaqXEirIHLpm3ZXs61IzzsAgAXHuoA=
Date:   Tue, 14 Jun 2022 08:25:04 +0000
Message-ID: <20220614082503.dqqgar5mhjta4l6z@shindev>
References: <20220610121518.548549-1-shinichiro.kawasaki@wdc.com>
 <6D3A54D1-AB89-4291-959B-44A13E5D90AD@oracle.com>
In-Reply-To: <6D3A54D1-AB89-4291-959B-44A13E5D90AD@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 28c8e5b1-9143-48cb-f753-08da4ddf622e
x-ms-traffictypediagnostic: BYAPR04MB4343:EE_
x-microsoft-antispam-prvs: <BYAPR04MB4343AD30ABC9BFB2087CB804EDAA9@BYAPR04MB4343.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Rl+BtdK8eWwRDLMipWhi8/aVKg4ITqW2UCZuv5Rf76asb+8891EIufG8MvgkRZvruSX9WGjfI5pp9poQnYxSySFrLoZJj2RwmFFz54+Jf+8tT3GRYXYiiDBYTHUSlRZR16FOShaVBEIwJPaj7pxylSV2YTYV2EAHoseUlVCanWLXcGUXWielDp223hSbmbMRlDGrf6V3QdeLQS3l5CVWX2tg9sjlO7KuCQlKDK+708YiwhtFu1mrzu7lv17rvJ2rsTJiki5a+F0e7vDElTnoi7mSxNR3NC1ExDe4bJpvA3juk8Tf9PflMsWG9FhbkIaJomClyEjPV56ThyFYYn/TSqJpmIAzKlKbDtptu5ezK4AYmJ3iEwM42ry9mEQB8Oan3/59m67KAtC1pm0++tCHMAnSpVGrxylvpImpQ3T5xqq2/nV7mW+xiXZMwdmklw4A1vr3neoLT8OXA3ohmbNG8acA1AtKulYHA62RAmi5KOYFr0OeRa+aAHj9AlXGMtv5j0X2XT+3nfU/Zpd7PskWDyx8Y2WkQoUyRsr/6dy74q/qnL6lQjTVLfJtZdd43TL731yBy8OMuZ8OByY6tg2yq2JMhzR6Byhy/RiBC9FVgg30HnTESZeVkoBqH2VybqTE9d9ahkB+r4YOybRubxHD+B9l1l/2NYHdOAy53JjaIurDaThlyFl5DFQerMe5c/rLNLlZY/Uu+IM7SyprjlKdyw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(4636009)(366004)(6486002)(83380400001)(508600001)(71200400001)(82960400001)(38070700005)(122000001)(86362001)(38100700002)(9686003)(186003)(6512007)(1076003)(2906002)(4326008)(91956017)(66556008)(64756008)(26005)(5660300002)(4744005)(53546011)(6506007)(44832011)(110136005)(76116006)(8676002)(66476007)(66946007)(66446008)(316002)(33716001)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9beSg/v2MfpoqgjNaySXcuvDJvPCJ7vU4W7R9cArMvK/qH2MQLEY3r46nUFu?=
 =?us-ascii?Q?ncTe1+YM8i840fI3KjO1pEyx8g0QjjixFlo2a0mf0Moj0TYXXgnDt5nQxct6?=
 =?us-ascii?Q?9sxNHaDthn5mfwNGbJ+Jn307HI5DycQ8+otG9mOzTbNq71rcE+VA4aC3f/PS?=
 =?us-ascii?Q?3+9ZrrrW3cXCz6Dib5ANdNUbk7308avkhPQyp8JnsSxExCmx6OXWXj/sc3bc?=
 =?us-ascii?Q?A8CI3fwmGAsnQmKCOw6JYTyOP8hivnezOx9LiB+Qop+X1SQD7HH0DAlMx6p3?=
 =?us-ascii?Q?Mre+dlB6QQouhEBpPgh3gSfm24qs5LSa16QCcXF96gA0Bvjv7+rJAvkTTm3E?=
 =?us-ascii?Q?Cx54H+saqTc0oVFIJcL38cUiJIsrShIPSVXvIACmGrxvNuITm4hKOGpbvlL6?=
 =?us-ascii?Q?m3NVztrxuYm2y2U3cjepKEAyRmMomD2xAR6rdhMgpVrAkl5zCN58RdyPNixU?=
 =?us-ascii?Q?M20keMrzpxxoDqf6+SwiuYPfxrTqtlMac8HCi54et6Rjfvf0kHgFUT5Qlfqb?=
 =?us-ascii?Q?UrHdhp1PC8fKApjAmQdwcCQwVQezwKem3VI9RsrwMT4gN4O3t9vfs+w/rgjv?=
 =?us-ascii?Q?cihmBGFgrk+rHH0S7WH2ssXLDggaSVOQ1dgH4NmEpTch9H2ZcM/nZpMMXzxU?=
 =?us-ascii?Q?Aa4lOGIVFtfNr1IvfHtTuaKgAA4gUqS3vSTXYXzOl1N3rse2NyLpcQzz/7uP?=
 =?us-ascii?Q?UE5D/lZw22jCiUWM/hqh69MUMUQwj7OotYXTv7yANgiIm8+hKpoQkUUMzCnk?=
 =?us-ascii?Q?N+UiGGSBoumzMCjTqQQ+K8TSU/KX6Ms21Umo11rw7eedFXq2KIF6lAvkFNa+?=
 =?us-ascii?Q?PvHjjPctFSsFVNrmb7obxq+DI3shidOIqTJzPzJ3UYjaTQPrdIjx4FsLF8Zz?=
 =?us-ascii?Q?84kQH7e/xyHrJTVtkTxIcDRaMysC6rK2U+I5pRfC96euLQDneB+JYZKN/I0t?=
 =?us-ascii?Q?Og6fv6qfpYIiELA/E1syMPa2FixVTQtyM+NEdmR94IlCHQDN5YhAMdxh8TIG?=
 =?us-ascii?Q?LWPLsPYNAdVKccwyySrvSEeVuBWw/q5R/uDH7mAyrY+dwIVU7Izhr9P447G0?=
 =?us-ascii?Q?W+NxXkMqH99pckm31NvNBnAgKzXzi34bGfM/9Sg4B2tB3Il3GR3yoOVFNftv?=
 =?us-ascii?Q?P0oRf1PbDzEQqJOOAXrnEKLzd8iZnvnWJImipXcc0GdwZVHfmZE5ZN49YG8i?=
 =?us-ascii?Q?qAYH3WdWO9YB1dZalEN8NYdTUgeYHYqSG+OK6FYYzd8aATTMhnY2Q7EyvdM7?=
 =?us-ascii?Q?USaTDSHd5dbSaftZtR8Fk7Bv9/fGbQNtpA4d0NfOPJInHKMqfNHYKnxcfBle?=
 =?us-ascii?Q?JyZGsWqy3zX6PmRaNPtwRPuxbbmbWj0gmJ+ZUq3iODyFhKJB1OQmUKKxxXpG?=
 =?us-ascii?Q?xazFQHcQyVYOnNv+HPWyjuicp3gCzTa99rjbcTRYD/TP+72G+5sxXTQ7Shhw?=
 =?us-ascii?Q?6gbQTlZ3ReivauPuNAdU821311HnakZCCwnSow1/k9Nr4+Swno9NnBwQehrB?=
 =?us-ascii?Q?NN+RN/CS6LiZViztXQlZ2GL2ob0LIkr47rF4LW15vLbyVQdLfbZAoVoiJwGf?=
 =?us-ascii?Q?hmh4Ki8JwJipBQ25QyFXI6M4gatKYTTUl069kbyPP8bZI9VEbJQPpBPrXSfc?=
 =?us-ascii?Q?wWMwKqoHN/0rWDiXw78E180yByk8n3xQNzQTZzksPAupPn1hCqDrXsMXjcl1?=
 =?us-ascii?Q?xUaas+RoMJEYAGhkJ89qfNFT8XZ9tA7GQ8gvmHSjYd5y5D/xt05dL/YWpmKg?=
 =?us-ascii?Q?6atjz8C+QsmFaz6ImZIJfY/dvCrY2ZaiJYy/xBfBJdxFQJ0hYpq4?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <78794C3CDBE5C64CA0BDAF9CE898EB3A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28c8e5b1-9143-48cb-f753-08da4ddf622e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2022 08:25:04.6012
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JqVUfnL8lUsrf8rUwDBRJDd6tKdmmHjKhcO8p9SgoNU2DRfkhaJCIm8RgXm6WZNpPEJDzGL52aQiNSd0raFvIqemfjivQlWuoNpBSvBagNk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4343
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Jun 10, 2022 / 16:08, Alan Adamson wrote:
> Reviewed-by: Alan Adamson <alan.adamson@oracle.com>
>=20
>=20
> > On Jun 10, 2022, at 5:15 AM, Shin'ichiro Kawasaki <shinichiro.kawasaki@=
wdc.com> wrote:
> >=20
> > The test case nvme/039 does not depend on nvme transport type and does
> > not require modules for the transport types. The _nvme_requires call in
> > requires() loads the modules and those modules are left unloaded after
> > the test case run. This causes failures of following nvmeof-mp test run=
s
> > with message:
> >=20
> >  modprobe: FATAL: Module nvmet is in use.
> >=20
> > To avoid the unnecessary module loads, remove _nvme_requires call.
> > Instead, just check existence of nvme command.
> >=20
> > Fixes: 9accb5f86670 ("tests/nvme: add tests for error logging")
> > Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

Alan, Chaitanya, thank you for the reviewed-by tags. I've applied it.

--=20
Shin'ichiro Kawasaki=
