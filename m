Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03A26C47089
	for <linux-block@archiver.kernel.org>; Thu, 27 May 2021 08:43:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8C9B613CC
	for <linux-block@archiver.kernel.org>; Thu, 27 May 2021 08:43:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235530AbhE0IpX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 May 2021 04:45:23 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:53650 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235496AbhE0IpW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 May 2021 04:45:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1622105029; x=1653641029;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=5rJKibo9Bd3pNEIrZ/kFtYQCFwYihoej8qmsVyUiGo8=;
  b=Q/SEFchImPBmNH4oXp894b3okqadNFvfwhRQmLdBgNSCSlztfNBTstFd
   IIt/8NcvG4ZjyuuEHezDT4vy4NZWFcd1xSpFh9pJTezFdRi4T6MmpgrPY
   RyFM52rCfQ+sxG60cqN1GP1jwbjiJlChQAxduJg3Im+0mqqkYaAAKhCoS
   pZ7u8IXcOjpEqH0RQreg78OKdld9ZcYXYA2h/MA+21Rlaq9tHFnTfbdAh
   QZCvDF7JIxLtgbpOMDnE0mgy6qFJKp4MBqcOeEFmPFwgpWt3dJyIz6bSF
   TkcKMQC9UXwXUx7TZp40AdWrxXK/szEpNCKBuJCclytrsnCoBo8GJDRGD
   g==;
IronPort-SDR: I7UM6Y4yU+88Ml8lx/v1sN4NKpplu6LBnXui5eVbIMZzX1aXv/esaLz095GbKo6IHcO8MDhgeL
 d+rVkGfoOzKaAnmLXq+DdoyyoWSoyorOuKFWrBQuWLDibqLip14QIvnGLL06MR9P40Xe9eRfBu
 qse3vColf/KRLZOq9OW9yKdO80xqfB7VS9JMYARNhjILEis9a0J+QRUpF7bFENh7PyXjvTZVTA
 LE3V9iJCEi/8euJntOyeEM8Hx8gCc/GpXiNSyf9BW4sZVewcTtlfyBPdQOwx4Ixib/Dd4mjTtk
 OeA=
X-IronPort-AV: E=Sophos;i="5.82,334,1613404800"; 
   d="scan'208";a="174309774"
Received: from mail-dm6nam08lp2045.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.45])
  by ob1.hgst.iphmx.com with ESMTP; 27 May 2021 16:43:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZNLfjMJ4bogJsF35Aw91K9rTeSWcfDKTevfbJws8zE04DvgNzRh+7zMMV2dFVjXkRzAb733iKn9eepJhdMqastmKl/iOdVFhkaDduVKt1uW9M67ge7xYML0zgmy2nrj3dcU2Dk72QoHwbowpfhI8/89CecNvRq7/DayzgnbVccQdUsksaNKbwqaxXf3/nmUKJNMHQ+Hn0M/KRZdqdnI2fOY3f8dRXHRhjX/a+qtEBsv0H80WeN0Jh6my67kNyhgP3wiVooZEQkOxJ2AkIjB+3J38uaenSBxhOCxAvmHvhSzZ3la7itIhtG2gnkAgsFtBTSA5sC85zTb2oC4pFTxlpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5rJKibo9Bd3pNEIrZ/kFtYQCFwYihoej8qmsVyUiGo8=;
 b=gvOYngeNfL8tg7mur8ohid4vCVrH2wHajSM6pqkBcP/pFwJnPKhRhWDz+acPSEkiN2TmICNceido/2KseTZpSSdxKFDIDhhsvcThvBZfBcrr4WXk8dxPheIqUdVrdysyYwFGrAk/1jeCo+NffgeQaF0LM8pfONQcTR6sXvKHiNX3nfTCXR9E7nlZP6rRtIdLfkxSpV00CX9V+DQheSHdNryeeTL/3LXRI4nE3KLU2TUhLVP7xvJbm8SckAcHOlFF7EqcY19VwZBNDLeT3nBKcpqT61ObBGU4YcmTgTyDiw6dy69o2ww/rOr/0p0gRsLteNRdul5RMIeNx7AKfacVVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5rJKibo9Bd3pNEIrZ/kFtYQCFwYihoej8qmsVyUiGo8=;
 b=zoKJELYHrsnRRrEoIWeNFiVDfBYIkPVCll5Dnc1D1BZbAVAt22tnPobc34uPyTJMd1tWhlrX/FvDTAgxNDf7W/vEt6QudQF2M5ZSJNnRjPKuip+8Zl2i5H1aaRVQ0Oi/7PDuLA+ZdCGBbaLmJqk9SNGA0sICEA++TXkpBzEO++s=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7622.namprd04.prod.outlook.com (2603:10b6:510:4f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.24; Thu, 27 May
 2021 08:43:48 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3%4]) with mapi id 15.20.4150.027; Thu, 27 May 2021
 08:43:48 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Adam Manzanares <Adam.Manzanares@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH 1/9] block/mq-deadline: Add several comments
Thread-Topic: [PATCH 1/9] block/mq-deadline: Add several comments
Thread-Index: AQHXUpPm69d+T8F0e0WW+uHcgzKZsA==
Date:   Thu, 27 May 2021 08:43:47 +0000
Message-ID: <PH0PR04MB741685956668B11D2636A34D9B239@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20210527010134.32448-1-bvanassche@acm.org>
 <20210527010134.32448-2-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f402624d-4b5c-4c15-be5b-08d920eb8b93
x-ms-traffictypediagnostic: PH0PR04MB7622:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB76222B22EC1AAA2794CB9F5E9B239@PH0PR04MB7622.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fERAHhvUa9pwT45cye+S+2KExzDa1Lgdr1+6FCEvPEEFtV1AJHzElWl7bhPqi95YMWnfUHRcF4hyqsgzc4GJOTPCUM2AkSoBzOa4/j/dartyD1ERZMAck7NVmPRgzO0AeXk8VEZu4076lpilM9Mn7n+kaOLI6ULVd397d4c3k+0aXD6yx7Fz/jvtvdF9x1ZNI6iozKg+e6A3MtgBWyylRGomL/pvP0+dBbTV7oHKY/DR86Y80bACDtdd+eSAB5Wzw5vVODEsF007H58iUAOJlVsCcifCOQnihJF4g8g/NM15H+URQg76vzEuk5K1ifdnnm3tZfD1ogxGKOV59EFGQatOdgu4RqT7xFa44/m/M4dLVk4JkUmP7d5+wye9knFm0+MmjZgZe/kLboBA1ZMQH4VMe8hNodeOa7eEPmuPivIlbhgAKpAua+yyKyXfC4+/Zp09pE3Ilrp7j89o+D+E4ZCumbLTXt+0/BAg8fyaVJoRyzvb+LShc0d04Ky/QGVOoeFWjOjDpuV/vmTn6WfSkA63rUQ2Pt5KwG3gMZm+6NfmssqOtURqMF6oNcj7PkCqqNw8ctieQ36BmOL7VB40CUkpw1GW3DoUnTVAmNd6GB0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(136003)(346002)(39860400002)(396003)(26005)(7696005)(478600001)(6506007)(86362001)(4270600006)(55016002)(186003)(558084003)(2906002)(71200400001)(9686003)(33656002)(54906003)(110136005)(316002)(4326008)(19618925003)(8676002)(8936002)(5660300002)(122000001)(52536014)(66946007)(38100700002)(76116006)(64756008)(66446008)(66476007)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?ZwrS1GXmLzkTpmS0r7jjlAWF2DKXQ1WKzQmBG//RmtfoGBMUMCLnt5MeUWuE?=
 =?us-ascii?Q?CkOb6Z2ZPCjOqRLGkJzVRHaACORuMeAOKFuw7DR9GZn+Xf/yHDxiSaYONKuO?=
 =?us-ascii?Q?7jk49X4RgaXkWWJKR+8hKANjpfr44sV1XvEPRVX7R+u7q2GmGLHBy82aSz5N?=
 =?us-ascii?Q?Jpaxqq/KsgjIq2xD91uaOhN+MTA6gdEukFSvQvqiDvaj1fWeWX4R951wT2dj?=
 =?us-ascii?Q?139DL3SmeiLTYYsPppbQ6RhV6y1c1ljPlFcB9nRegDzkADsqKC6zxpZb20TK?=
 =?us-ascii?Q?O4Wd/P5sHOlR/iYvboqeIZrIoBtMQi1Zw8+uA8lGjYo72Zw6iJACRsJQfVXI?=
 =?us-ascii?Q?bQk7RC5d6p/KG7m743d3ZT2scpgyJe9TCN9X2ZP98Bu3Vg9hvMQVA3IuWvaj?=
 =?us-ascii?Q?1izqfo1EpWuDd/E1XHz3fs/GxhLdORS8It3g4shn9kzkAf3q7WO+i6/v5d9G?=
 =?us-ascii?Q?pI0Jnfr85zG55Bdty3ZFYAdcfdAHZjeEs99AhjoR8m0oqqihFE/QlMIEJkxR?=
 =?us-ascii?Q?Gp/IwLSG34uKqfbVqQtiZ/sbIYaDQ1AVqLuXCIjXMfQoCHVwgIpbXAp17qOs?=
 =?us-ascii?Q?vRYD1jk9vIk7qiM3mlx2iCi+e+zvkiVGihr/wiuCP2pScPZLWryChHdgBI+U?=
 =?us-ascii?Q?2W5MK9phd2jB0ACaq+M5QrBZ9MSO/r05gPwRQVrzM0bEyzDerHeAub22PfVj?=
 =?us-ascii?Q?VHzunxANF1+RbNN99Ibuo5dTfO6fxcGAtjLktTDYvflVdDx38gFtlW9+zpHx?=
 =?us-ascii?Q?IkeVde4gKIMcgcIe7uGwXSFFs+GS5DOwl4bABEFDsLKA0rkdwY0HDTgFgloa?=
 =?us-ascii?Q?0kFsvkZ/hMuO8JFMf6vNIavR6G9xU2VCPmkvz8uEeayumQRY7J0g/7KVGLhQ?=
 =?us-ascii?Q?Scd6mwg40tANN7ymf+WunFiXZtsfC7MVhD9hOdApc2mDfTgo2xSke5yYBHia?=
 =?us-ascii?Q?cQ44A8kxjkwxMwqZaZdx64nPfkTfSgQphU/qq722/S6CIfw/q3zSw7cmaME0?=
 =?us-ascii?Q?StLKoEgjurGNYnFXeEec6SClFr/P861B0uj6IFst0HeTEJlmgDsO6VWb+ly/?=
 =?us-ascii?Q?0kVF6wmY5xwHqJvtmJjdn0i/HsAc3/Ukt2tlk6tanlKqfk/VAs4U2Z/PhRbr?=
 =?us-ascii?Q?TXG17CvHJRZ3kZXMul5w9q1jmdGASxjFAmmbcslFh3dfQgaboApSMMJZ5rw1?=
 =?us-ascii?Q?5/4GrCNDL/Open/4NBjfb9gBQMRzPjZZ3UMAsimkR9YQNdTZTFmv11mzy2l1?=
 =?us-ascii?Q?OwKxNCbWDiNVVka1Xxj/pKZKXNgMaW41U9ZB6Dlu1oM7FMVJcioB+CTmIQIU?=
 =?us-ascii?Q?NzDXyWtM+okTWftmGIn7EEbAx32o3OhUOKJ4+n9CzxQ9CA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f402624d-4b5c-4c15-be5b-08d920eb8b93
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2021 08:43:47.9271
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JbjPzC5OKuHkMGSvfQjsW17vCVEw+7pBF+wzkQqHNHGJuXMAFhaCEGdAntUqDcXk/t52uNGL01AwCmdxwmNuzZqzH0NQR4/KuxMDWXXPX+Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7622
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com?=0A=
