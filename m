Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E223C433ED
	for <linux-block@archiver.kernel.org>; Wed, 19 May 2021 07:36:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD5D861244
	for <linux-block@archiver.kernel.org>; Wed, 19 May 2021 07:36:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239612AbhESHiA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 May 2021 03:38:00 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:4873 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240535AbhESHh7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 May 2021 03:37:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621409800; x=1652945800;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=i73cQScyOXtQNhKCgBM0j0yco6YrKjuowVHgFUDbKic=;
  b=boz8ZCBHTp5T6bk5vRNTespBS71bjd0+xzKAtQGbDPhY4o5YpznxSJ3R
   9lryfo9uhD+s4HpoTSNNObjsc7s6ghIS80QM+z3mPLCV/5Jx13aIwvGUq
   +SZ30P2rtKCIof1MiQzFPD7haY1pB+y2QPnusFq8LdWxTjI44iMtrA0fr
   APdVzXFEK6RRY3TS3bOsycLOUktBnDeop62S2LuaT3gv0xQHoXQOogCYu
   CXl2mVC1uEL2BQY9Zd8jAc00ElY/THTn2i5mrJ0sGp81Mmd1M0hIt5C9R
   lL7Qgv6OJnc8koSDgiNEFdyM4oRUpFbGBYLo/NaqbLSuI075FEG7kM44j
   g==;
IronPort-SDR: Sg1Rvi9YvBu0x6sHHPSlAn+7yeHO4/mPDVlLqa/hYOWpQbRB0OQgaqBdQ5j1BqYWZJIvevx0AU
 LfA/U8jKi5QxjXjuntev8Y6c/RulH+EHnBiO9GTIJIdRDmOc4/U3jKCCM5mYI+OraaQZSQgTye
 MfVBs088xBs4fpustCUwwwBbi5yt/n6jCpong8mI0zGsmVNf0oq3iXcsFbvkBgAbSwQL9SeNVi
 OVYfBSJFySejGvCKGOK8Ykm+XHvlVC0Nhi3dk0u2joMZZzXUqal7KLFseaIg7sTk8IBj9d75xJ
 rZo=
X-IronPort-AV: E=Sophos;i="5.82,312,1613404800"; 
   d="scan'208";a="279912595"
Received: from mail-dm6nam10lp2101.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.101])
  by ob1.hgst.iphmx.com with ESMTP; 19 May 2021 15:36:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ulsbw09L3amMgsqYPZjwPEF5PGhGag9H2CUhirJc8sp6ts4fWYp4flDCzRzc1Vu8+ymPiHNTGW22igzp65zacAKsfOWMpL5iDkcoYy4ieCHvAEShr3+a8ssfSbx5hZgPOZoxzs6SzcDhPA2nyaHpu6tMQL5qUnRxXXeS15pHbZuwP2X8fI7WvOvZdXt/hONPHWU/qELlKXFYBy8//Q9VSvB7L/nt3CR+t+TwdRvwjoYgFcHXIxyq0FuIhQNZcziAhBrkvMXuYdrUWR8A8HCqNzme6TKRxpo2RClN8dh9pdBCQ2Pg4LHgrEwtkSULK3dY+MaIHaC0Fo0sCY+9Ahi2+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i73cQScyOXtQNhKCgBM0j0yco6YrKjuowVHgFUDbKic=;
 b=SDWNDN5wQnrQhOMqCdW8PWa2R+2hBa8MCkrmTlQHoW0DB92uU0PLp+jAci8j0bWadaoJzA/oHji6oHOnCSB5xOcWahfBz6nrbggtKEle8z4cTEW7jVEs6yWq0N361w9sKnHT/EDx2aFrEdlQPLZ6Uegim63EX3G7xieg2xIdJGeoJtqnIBhNuz89AI3+hhUo8ARBs2xUkf7cn1ii6kdXVBaKlTFXFMN0LkAMoBhl/3tYZ+79fCq7jg7affGzerS8pzKXT95ZKhIvMi2h6p0X4Muz1SRNFan5AMse5XTcrblAuRBDV3zYNlcDJhOtpnm1/5XhZ6coU0GPU6PY7JJaPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i73cQScyOXtQNhKCgBM0j0yco6YrKjuowVHgFUDbKic=;
 b=Aa3m0+QOP1hjk2sOFhPCgMwuolaKJwcaZNkyt/1XdOcRYaJpeMN/ZAZRNOg4FeHJk6nQYau1stk+/j+s1qLW/RdmR5QTh4lM1oqOqmW41jyt3I/e4WiBSFkmb9nayXsyIJ4LnmB8gvEAKrSv0h7fYWz6+ZaqFD0Z2aJjioxwweM=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7493.namprd04.prod.outlook.com (2603:10b6:510:51::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Wed, 19 May
 2021 07:36:38 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3%4]) with mapi id 15.20.4129.033; Wed, 19 May 2021
 07:36:38 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 05/11] dm: cleanup device_area_is_invalid()
Thread-Topic: [PATCH 05/11] dm: cleanup device_area_is_invalid()
Thread-Index: AQHXTFqCCP/2Ogsa3U+NRbmUC2YSrg==
Date:   Wed, 19 May 2021 07:36:38 +0000
Message-ID: <PH0PR04MB74161DA3B6ECE23F9CEE945F9B2B9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20210519025529.707897-1-damien.lemoal@wdc.com>
 <20210519025529.707897-6-damien.lemoal@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:152f:cc01:95b:718f:422f:1ec2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ca815c5a-c660-45b7-aa4b-08d91a98d6a9
x-ms-traffictypediagnostic: PH0PR04MB7493:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB7493A07C6B490AED56E31B1A9B2B9@PH0PR04MB7493.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zTf02mu1omwk6ylNdhFFckRL653yd41NN71c3SFSZtXQZveVh2TWCDob6OjHzCoU4sOxb/FRq7hO/lZLPxl7I/grl7YviFBygHkK+sdWs6fhXz17A8a7NpIfy9F5zevAd8SpAN1JsfnQ147eV+gO2buulTH4DSd8fsBK/O7B7Ld0uvT2qwa2FHyPEDT2vvjN3KTkC+NVX96HVuFRFgnNbLqKQUYY8QiNgaOOLq5/X59DJObBiacFKNzh3+mp42/iRT0ivZArjG0gcfThATTXcPZ1e3brOUmKczcPr2rJCkULZJ0afihm4y4JFvO1+xRBEqHIZHGJxQiC9nay2k5untqGYJ691GPVpVbmS45YZDUxr62eERrkb/mIewvZKxyjtZD1LMcwKhvmRu27Ek1mIEPeGGEqQoW75gOvcGp3oxpmNYh8PZ4/W7FqEuHtqa1gVTrQgOVg9JSRIPlACvlnOe2FdU+eiFhXC3513QuMzKAHWFOfkBSMz7tt+OWxf22qboyKL6IeV2JhuM8c8GEUA6U9uyfcComRLcMP3LcHM3HVAgC4F411mGa9dTRZuCPOc4v0Dxk4gZE1qnwJN5qd0yBNGy4a9aQe0cM/Mt1ADYI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(376002)(346002)(136003)(366004)(7696005)(86362001)(71200400001)(33656002)(558084003)(6506007)(66446008)(8936002)(2906002)(122000001)(478600001)(91956017)(9686003)(38100700002)(19618925003)(55016002)(52536014)(5660300002)(4270600006)(64756008)(66476007)(8676002)(186003)(76116006)(110136005)(66556008)(316002)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?eQz1vH/bq7I7AYlgZm4h34bBnGGAQZ1Nrslqj54TRqWsKsjKy/aY9/FeY9l/?=
 =?us-ascii?Q?CPAwk7Fi/qjSAUKqs1iUPu3myPk7/rQJfSy7zdFaXKPYvXEFqAIpkW5PWo+K?=
 =?us-ascii?Q?0GbvB9behUWYWPZ+Kb1KLSIWoZbtz3K8ff64sQ+BkqIBgCTSh1yzrCcnvA9c?=
 =?us-ascii?Q?P5+meILqpaIaicOkxfEvnnJ/kAeUtDB+c2OvU5hQEIgRrhs0tBxRyPN49DK1?=
 =?us-ascii?Q?wT0fIV/8qXav03U+ArBhf3A5I8j3Sw1/ecjFK5TJKyWnTMOEtZBlxa5tKBbY?=
 =?us-ascii?Q?F2WhvY3siSFTBtNGABAwAkXuwHGpwMcnkeKJHzyZK3Leo9T0fn/zA5D4OW3G?=
 =?us-ascii?Q?vSACHFeqnTlALh2ux00ND+ArEIQ601ZFzqwPgsvscXxUXCRxbKilPpBmqFcK?=
 =?us-ascii?Q?x6l2uOyc8Rbq5f082eRvNLiXA6p98ZCyJhrz/Hd54WrZiwir0C97yY7rJYuG?=
 =?us-ascii?Q?HobJZXVq/P3W+2DkKhuqnB4zG0RAhO7fTI4jmLCugamj6keYErl1lOHyFUwF?=
 =?us-ascii?Q?p1jAu4NOFXig4XWKRg5NV4yQx68Y5t+YcxSAChfIAM+bOjYUJ+VdrAA5NvDq?=
 =?us-ascii?Q?V0sgUgKvfNUdOfPcBjbb7/IqtykMtE7rwHUuJVlzmq1DqfBTEfw1ua/anFeH?=
 =?us-ascii?Q?bXuIREVFUxJ3EP6oNE4pZcZ4M+FQ/yzywrq4Aof0/PT+JJ/4uskgaDSg8puS?=
 =?us-ascii?Q?wdyzq8vsIypznm6OHXCNDjuDQZR+3R1vb/WgsQIN3iMckJaq1VbRCGa5yXl0?=
 =?us-ascii?Q?LERFCgbLBcuZATdqfnz78GXgEd7Hd+GLDwGggf5eoRhyEQ0oG1hE0yIlklQh?=
 =?us-ascii?Q?C274dg7XoCkmUQatIZtY+3e3ZWbP9eOCwOly8LkkE21k8iVQrIUPnpopoTLg?=
 =?us-ascii?Q?ah8u2H/vAHUSB+/TMfhLrbkrNuisSS+mKcua4ufBrgzV6uC2U6AP0R/KPKvK?=
 =?us-ascii?Q?Nf/em59gfH7WdCKU5t7VL4GoPXloiOa0L4mcKzFAJKFqTS14pb+T1HTIS6N7?=
 =?us-ascii?Q?jg2CxYC3fEkN+Vd8n4WTAKJcSm2MHdZynUYYlncDBU0HLhjW3ynPpovYbZnk?=
 =?us-ascii?Q?YTMTW2xU3Ocq8itbk5dPAT5jOyRNq61XfAw8dEdNGBk6XxM+KOFIwWyHvc3u?=
 =?us-ascii?Q?vSHKzDWVgz5JWfz9aNRMYNq/tWPcCczf8QC3lzs6c0OImUxbuqtawFwjm3yX?=
 =?us-ascii?Q?d/h3RiqPYxMasOjB0TZE5l8zqJLE0BHyF0NqLsfS5E3lt4/43JgOv23nCs7w?=
 =?us-ascii?Q?WMLZhLTVLwqdHRP4YFvOn5Jultg+rZFgM8SQmeeHkmgpbVI6lmnUz7FVn+WX?=
 =?us-ascii?Q?dSSQsQrUC7hOlFoD7OVZQb66sHWKawH1tHND8oflqAh7typ0oyTidB+uP/4j?=
 =?us-ascii?Q?Y+hFftJFXlJK/7Tk+JNEJdB0/LTB?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca815c5a-c660-45b7-aa4b-08d91a98d6a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2021 07:36:38.6936
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0Mamkynejkp5bwh12AcSSEu5Kt7IvJexzmx5re47RcZKA/dIDAlTPxtZei7pU5S+BWZZBV5Dj4JLTwvjWZyzJbBDUq7NuTGvTJBE3mPhYI8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7493
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
