Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B293DC433B4
	for <linux-block@archiver.kernel.org>; Fri,  7 May 2021 07:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FB43613EB
	for <linux-block@archiver.kernel.org>; Fri,  7 May 2021 07:15:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233136AbhEGHQF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 May 2021 03:16:05 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:11259 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232796AbhEGHQF (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 May 2021 03:16:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1620371705; x=1651907705;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=V4qZ7PEXZtJmEgdK7tUr0Mfzd9d3L+PBPYeKQDTFxf8=;
  b=U4rHa2/vqKjW/sJsYbo20ro6BUNFX83pdIxGJwqoUw4eIFTUsdO1vrry
   IIx0OY4MGLIIRCM0BnR+R4mGuWThJojVDz6rsgZOa/IGDWFgP+qFyw7PI
   PLfZbtsjLqz6Y3a4h99kF21nlAtcF7PvyUZDRK19D60hz6LDylWk3u+2X
   1tU1WCAZQTH3AiqnTSwBJuESITDs/4KqZ0wSLRTQ9pQwk7YafZeJ01Vf5
   Dy7aWNadm8xHCXQjmSVuFq1o6TV9Ozcnowy4w4wkQCmWjKb8KVfpH/tep
   NAZSa9Abb4IVA0j7h54p5eoP+J9DwSKBNYZSwdiZ5HuwpXRWsZJXPOiSq
   g==;
IronPort-SDR: G8zddCuyIAS/oboqsnZcWQalvJWnjEH99oI9wg3ALILyayX36EcjpTZwgQ+fWTprLXH5fKW/Uy
 eTXFTy672W3pgaH5+0qKfXrDnW2T0vpd6aVmInt95/fWGKwHHbUsj88IhIgb5cN0a1HvT89/kd
 74CR/tUwDOqp37CS+dDb2/Z/VQ/ErjbkDh39KhsngmIy8PvmEx1qK8JFJlG/4LwXofAoigIVPf
 hCfE/clwrJL0Kd8FuT7xy7uCDDgGJSYYiQVZnl3C5OapD4PTzJUC9oxAy4uNO7bKVIU+vCvZwK
 gn4=
X-IronPort-AV: E=Sophos;i="5.82,280,1613404800"; 
   d="scan'208";a="278526468"
Received: from mail-bn1nam07lp2045.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([104.47.51.45])
  by ob1.hgst.iphmx.com with ESMTP; 07 May 2021 15:15:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VvPKAX9bAcaehRXeklpMp6RuxDEGdQU3HE+TlPaVyr/ptJtDLDLFITbcSW+PzIdCYXKnPXU8WINgNX8JP+JCqRgzFYMtgxgPSBWqVQDrzPjgVly+nrka2sl6v1PudihCp5lEQqCXm1sIYh5wxfDww7F5vqtP8vbLAurXrH6K7j9EhjQjv7f2YKvb2TqcYCcl+Y2O6d2tGFTveJUodxDQ52AQ44FA/UvDw7m+qB943BwhqJKwcbGT2Bp4pK6PmvuziP6W3zaHHpkhfMKsRO/vpS0FF17EcMfonWJhLFlpPvCXNSl6DGArgXEdfITK90s98gG+K67/kOUnfa6E7193Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V4qZ7PEXZtJmEgdK7tUr0Mfzd9d3L+PBPYeKQDTFxf8=;
 b=YEVqJ//X261LCfwC5XX73Osei2p95cZLMO4pNNMZdxT6kXYb67RzL/PYJ1xX428qtzCLYfBVuWp1GoOxju4Etg0eMEAlPE6WYBsFoHvTFQI1UWqw3w48f/2zrRGmNOk/iUL1tKIPLXXCgUSZQA3moGj+RDjaem/CmZdyYOAhtsgTju8Rjn8XkNvEJ0hp4R12GmDp7aGM0qMJsoDR34VsFzE6hevZaAXIZFfrW38FkD7FCS0UAIg1uetCaMQHnZGx7BAEvFyZW0eF7kIbgdN0IUUPz+Va67jYfEDhmiFlE4pIpjsJgCeqV+LAGJzdAOUmr9+T8NFgj8SlHdMPmJdSGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V4qZ7PEXZtJmEgdK7tUr0Mfzd9d3L+PBPYeKQDTFxf8=;
 b=e0ABuLA57cj5qdfY24YL38nD7mokNTJF+fCEe108JfLoNF9Htgc4y2KHkoJYLYs1Zldva2KELXnFTHZxBUFTbCvVxf2SCVuObhY3PBRgJg3LUVTZ4/W6oMoALkTtyvG/2jqGZ4Wu1vVubiRUwbzRpilxJmshxULiM6LMRZcfHAs=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 DM6PR04MB5017.namprd04.prod.outlook.com (2603:10b6:5:fd::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4087.44; Fri, 7 May 2021 07:15:03 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::ed2d:4ccc:f42b:9966]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::ed2d:4ccc:f42b:9966%7]) with mapi id 15.20.4108.029; Fri, 7 May 2021
 07:15:03 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] mmc: core: Move eMMC cache flushing to a new bus_ops
 callback
Thread-Topic: [PATCH 1/2] mmc: core: Move eMMC cache flushing to a new bus_ops
 callback
Thread-Index: AQHXQohQbU2t6knJJ0ekC7MrgMeyk6rXm8yg
Date:   Fri, 7 May 2021 07:15:02 +0000
Message-ID: <DM6PR04MB6575F19B881A75752E23F6B6FC579@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20210506145829.198823-1-ulf.hansson@linaro.org>
 <20210506145829.198823-2-ulf.hansson@linaro.org>
In-Reply-To: <20210506145829.198823-2-ulf.hansson@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [77.138.4.172]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ce751744-5eae-47bc-8359-08d91127d565
x-ms-traffictypediagnostic: DM6PR04MB5017:
x-microsoft-antispam-prvs: <DM6PR04MB5017F205F53EB0D555782160FC579@DM6PR04MB5017.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 50XmpE/tarfFT2xvaasMDtZSjt2lkJBS0f3ypQkYYyE8B5ur3xF/rhvjLQv83qOYfqe7FxG+X1xGysNxgZEL8AX3q7ov//ZnRQA8jtYc+m2or4HyxiYEB711nFcBhpW8zd/kqGo7TlYeO2if0XTsAI/NUpXsBLDCqCXhFuykE1Td9/00FoiFvdzHm+fjYdg8Z8YCJmQS24FXihGwgfQyo3K8wYr+nChorbDjPjLkPAiDye6vEhTOVRaECzl3Ena7riY6xdFn9J8c2mjnbFBnM5GzS+bQV5vYrlFd2fwPiES6KEZ9b6QlDJg/aBe6SWx+YVgQxD4u/DPaWraFp1d1E/BGswqkk2hInadzaFLlmIWPmnY4PoAlk8pW90EIglExwrr3IGdPx3iatFVhHWKemTGKo+UuZ+p0NDHUMUeZBHXnJt1w5PSlSH7K5NzZpFVeswT6b4cueZrRTqG1oONn/P3d/6menFf+uHTQetN89T3tGqxv7gmc+Yq9uEp26HJ21rNsCIvaUq5mmcebLvkxY5hYDuM+v5Y0+uEW8eSg/z6pu1MMgdf6KQfRWXTLk3gBabg12t1ygkVP8z2aBiCZ/pHPb7YKtIocRafCWRI5510=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(366004)(346002)(39860400002)(396003)(5660300002)(86362001)(55016002)(38100700002)(9686003)(66946007)(66476007)(54906003)(26005)(33656002)(316002)(478600001)(122000001)(52536014)(76116006)(66446008)(8936002)(110136005)(186003)(71200400001)(8676002)(64756008)(4326008)(4744005)(6506007)(2906002)(66556008)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?omCnzepxAOQNz5sm8Dpvhg6n7/BjVIwhqKE1sDyhnZOtEhVlOgG/BZ9GrOap?=
 =?us-ascii?Q?co8cNMwY1L4dNPJoZ3Uw+spq2TIh7Hn+E9NlnscxAWzowDSDn9we+dSKzHXr?=
 =?us-ascii?Q?DFOzf+RMsezQz0dkO+KIbxLjGxCXzhNzNieMqU1az0cm+tCYND7rrNSvYubj?=
 =?us-ascii?Q?b1e2cdGpwRe4R7YHDi1602z1Ky+3BAtrPr37SrGG17tcs/NOX51Ybon5WJun?=
 =?us-ascii?Q?a4tizITLcBbo9A5qmFdrqJa2Qh8n9bjlRtF+qS6tGItBHlnDl0kQxEp4w/MT?=
 =?us-ascii?Q?lj+MNe4w40JGnlm6si+lQ/6brM+OVq/K+t+/TrdGuRJLCaLMmmweIg/Aqa1u?=
 =?us-ascii?Q?qzRatXGvlyv1yLmDioQ/58f9q0gcp7PqW8TlkTxPPzKLUoFMGIZjPAF7XyBr?=
 =?us-ascii?Q?adhJJNZJ1T8k+i/uc+eWLEXm1FnK0d5/Ta88pEulZDpsSAekAHL63fE63j5U?=
 =?us-ascii?Q?a2rmtloAlhBcLOYN8UpSUgCmSy6lMAQjTFmp76yF0bmz4fdlw4x2PwdKLJea?=
 =?us-ascii?Q?FDo/YIhBFkksqRJ9uRo36n+hHIQ79LsLtCPcIjuXqCp0vipy7Jm9Ie/nO+h3?=
 =?us-ascii?Q?9Vmr7D2zkjHQ679f7BNW0vnT9juYyAdm7QoORevNJOEuq6DRMwWxgw4oO2AF?=
 =?us-ascii?Q?UbR6UzlruCOP8xs0F1FJaBSx1/bAgTSEiGpAAjQhxTjxHZugoop9c5ZfaRsD?=
 =?us-ascii?Q?9dvYmS4XYgjPHU5/8jIzHN4/ByMq8tcJsb2nuaNUSgjs97kJKgK1osJn+od8?=
 =?us-ascii?Q?EsczaVnUiNVBYAbcEo1NufSqGJugVZVlWvIypt7EXoHkHM36wh8EshxjU6iN?=
 =?us-ascii?Q?VyesCb4fBl0dPuHA+oBLAJ/epnkSFHdGSp6UkQOeVnOqfJaoq8Z6Utevwkgm?=
 =?us-ascii?Q?9AZNEVhbcO8MaMC66cp12H3al1yMWdWsw7k5waIJR4j4Oe8XjOWWEcuD+pgZ?=
 =?us-ascii?Q?oy2iQAQ13j02iKk2iz3gVgdfsEMn0G/AjkAEbTQY8snTlF68NAVgqJP/yZBZ?=
 =?us-ascii?Q?71X7Afh9dMvExlYwLdNVertBO1HdjwUSesI2HEwQZmZCrp6voWTfzRGOc3jE?=
 =?us-ascii?Q?zQ64c4okHUfbQnur3Zq13uvoYrSew9jmN4XwGI7/Fhf2u3WfKA7BKsA9DALA?=
 =?us-ascii?Q?cJtxwl5a0kBOt2iA34jCuntGGssYBm86SVQ8f2xL/xJRuXvhCABmkhFh09gM?=
 =?us-ascii?Q?pHkgfudlg08ZpP0CNoNvr8wMLB3T3XvNdXr0OQFH2wEkUS0e1kIfHtbCXGar?=
 =?us-ascii?Q?JMIvz/E7yc6DbAWpA4oVOcuEVVSMkb3Z2qMasMkQv6z+rdh3tF6vcSKKhtcF?=
 =?us-ascii?Q?pKk=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce751744-5eae-47bc-8359-08d91127d565
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2021 07:15:02.9753
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VGxVDroOPVal6vv5Wao1GjkU2Kbq21jqZCiTm+VBpRKNRvahnmgMf5pS0N3Xxhf2IWZUHtao1qn2zwggcVUbCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5017
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

>=20
> To prepare to add internal cache management for SD cards, let's start by
> moving the eMMC specific code into a new ->flush_cache() bus_ops
> callback.
>=20
> In this way, it becomes straight forward to add the SD specific parts,
> as subsequent changes are about to show.
>=20
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Avri Altman <avri.altman@wdc.com>
