Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A5ADC4743C
	for <linux-block@archiver.kernel.org>; Mon, 21 Jun 2021 20:14:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 375F06113E
	for <linux-block@archiver.kernel.org>; Mon, 21 Jun 2021 20:14:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbhFUUQT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Jun 2021 16:16:19 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:32495 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbhFUUQT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Jun 2021 16:16:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1624306444; x=1655842444;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=CqIS+5qZu1ivpgCjnMpgo1ibdHmTlpXD4Pu3NkXCRao=;
  b=UkcbKYM3NyFoqkU21CWSIEBAdS4dKQkbt61hrN6CjhBAdXDHNRzGXlMq
   qqcT88JNztOzvtPTExyvb+eVfxt1iTCUt0OMdFlFAIBS8rG4xgRUW91vx
   nYzLjeBp6hEgEfmcHZz/+zGtqlZkoWoh/G1na7Ud60TxPQmzxSYoqG5El
   Q1qt8QgVC7+/bVwGQ6RGnZTfuLVIVLIa8Z2/n1SBgB8NhOorK/fwe8MTC
   rPtjrIHtTYZ8qCbmnxNRQw0z/tFQP6neWQP/B0kWEA7wvWY7Pf1Kw6/Co
   4OeFjRnF+0Kptq7eXm0ZbAKak1lkzp52gwuOlATVGR2WiYQYHxv4eAwcQ
   A==;
IronPort-SDR: lwypp4RTdiiCK6W2GqjUT6kes9/58ldyzHNqXpuct+iJLO+tvOAJQml8bUU2bH/A8l48CUk95J
 1iHpUciC+As/N12IoG2cpGTUnsbGSrOkr54A/yKb/+NwrmVXiljk0Li7WfA9lBO5DSENVlm8Ay
 XJJ3BXJDHJr+A4wUzpcQSrwHQS+FPXfpbhAWG77T2rzYO4uIQoDH7ZsW2mjT5X0IOHtkDHPjlx
 lU1U39Ndsd2p5W5Md02l9q80dzpBJFKDptBOBlOg4WyHJm9fm0bIN2tO6N9FCRmo5gg22lJ4qC
 0bQ=
X-IronPort-AV: E=Sophos;i="5.83,289,1616428800"; 
   d="scan'208";a="177307934"
Received: from mail-bn1nam07lp2042.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([104.47.51.42])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jun 2021 04:14:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ND3X4L/nMBynQyaEPPt2WcLg+7REzroH4lSbilfPtY+oDvqlwjU6oo6Csy0rMG7jGyW8DOONpNuzGm8LniJOwwWCjfdtKgsVNrJrW5o62q7pOnTbiuthFELUiCKtzHX6J8jbdx3Pp5MKc2qhz55bv9IXXzR4qUFOuPoXvDLoY00Fi9wqZbHgIYOZguURz1GHGyB5eA5NuA9fKI8C0LiZi/eD3ajywMXivd2DzTODeYgwgo3U3yEwGYP47IJ7SZB3uTYfcWvQ+24ya12Oc8plc4NR6DSwFNcTkwkoBX5inxXruoYvuBNdP5M/qlBc1jB6nlQqN64rK57fw5e/yBvlAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0JAQMXvw3m2ZlffLNAUloY3+8zMcBna7PTGVQKNwA1M=;
 b=EGn3czNmmj7TkeDhHFOdSffkrZJVtz6WPep1sNvrcHAAHI0TcuKakP6scFeppXlW1YGu5tKQYezQN5h9L71aJcdc2gReF8Ku0mAEONDAIgGCOZS2BwBy0uCKFMXzyBzCz/SlVKkHauzFCMULk5ik5VYR2NspLWAmiMv/4yHi2xvqi6tKEQLQrzyUAeEQahTS78PmTds8wI6DuMCXPakOkqFMcz83a2m8cMLCJu9s+17of+A8wqqR+oTzArvUC/VnIm1hAJqaefpy1d5zgDDSZNTc+5aXPASLolhC4ls7BKQ9sjtywtY8BPexz9wH2eEMeNJNpThLhmjUJQCL80pJjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0JAQMXvw3m2ZlffLNAUloY3+8zMcBna7PTGVQKNwA1M=;
 b=O1wjDX6RG4b1dKYdiSMEnLtO/bqvhwy7+YQWkLKhQ7wpk9yey2ACT/JU9Oyl3XwVnTqgNZTOMHqugdaJqgRdXcQ9dEuDuO4nmnw+JKVipHJxtWzWPW8Ppj+DmG5XfY0kKEPeJu7dLdouSYBiw6KSbxFMKuO+sARVasA7lQ30Njw=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by SJ0PR04MB7678.namprd04.prod.outlook.com (2603:10b6:a03:319::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Mon, 21 Jun
 2021 20:14:02 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0%7]) with mapi id 15.20.4242.023; Mon, 21 Jun 2021
 20:14:02 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 5/9] loop: split loop_control_ioctl
Thread-Topic: [PATCH 5/9] loop: split loop_control_ioctl
Thread-Index: AQHXZoinKpPeSNyc0E6bsMsPzp+RWQ==
Date:   Mon, 21 Jun 2021 20:14:02 +0000
Message-ID: <BYAPR04MB49652A38831579161645D283860A9@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210621101547.3764003-1-hch@lst.de>
 <20210621101547.3764003-6-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8bfb8dd5-3d94-448a-9c69-08d934f11cb4
x-ms-traffictypediagnostic: SJ0PR04MB7678:
x-microsoft-antispam-prvs: <SJ0PR04MB76783FC692F87D732406FD51860A9@SJ0PR04MB7678.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b9sLQewOn1XYxjVFm2wB0j2mNnmDEDjqYS+Q/Qi72vI05g3Lar//KVt64e5v0xpe57RIwTEjJkWUPFmJP2OlNFJs7woD1E1N5Rf7zidoT9SaInbTC/j+tRPQThpkQiPytl2/4dyllhaLBl9edKRSPmyGK/4yCYvUT+h7X/ObCXdeTbbxtrCu7Bjfvp7u9D/PE93yf6HwiO7tXLQfrz9VgAcxg8Yrk11kvZHHfks+zALXjvuaLWPmL1fKvpT+VY3mnVj7QvFcOmbi74ub1iqrFIIe24lF1KSexjcSouR3s7hnl6qRedPe17/dQRZW/8Z+0RszO2oBDCUP9PzymJ8SgnOwKEFY5ickj6j0J/h5i2eH9vm8ppI66oFEcrXGApK0WwsZemu2hXtKuliu1pefr4inSBkZRLl00TqLyje76aJHsYBynVva4PyPovIyVB1wZlUBoAWvLtZXtqzqA2syev89A+iHjUJProWt03cNapdLd2Y0BffhRu2nRaS8BbsOR9LMIn1GZNN7dzTcEbV5apZJEI0xIp+0z96wuAgonyeP/oD3aTXpXIcZhZqXnRP8pf66otdk3EW3n6Im4BEZtaqn8A94bLQSI9PuHd3/sr0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(346002)(136003)(39860400002)(396003)(8936002)(316002)(7696005)(54906003)(8676002)(6506007)(38100700002)(53546011)(33656002)(86362001)(9686003)(122000001)(110136005)(71200400001)(76116006)(91956017)(83380400001)(4326008)(66446008)(64756008)(66556008)(66476007)(558084003)(26005)(478600001)(52536014)(186003)(55016002)(5660300002)(66946007)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kIKEPaPMvaMFFT0kJ1Sp2fpxc15XOPsqtdK7LWlHTLwkyQP1gOZ+pKKhhEWc?=
 =?us-ascii?Q?oyTNUI7Zslrc8Ap1oR1YnurMmIWp1zatWA8hbxm6XEufArkj5xzzCn+I3iVS?=
 =?us-ascii?Q?Mj8bCKC+FOYQhHwNesx2YQr7RLCGezvzhbB0YDK0J5E3L/jxFT9bHYSBh0LB?=
 =?us-ascii?Q?oSLrICdDKmoMEg3r8xP2D2hiMhFIBWt+TL68iB1DmTT1y5aGVVfmW/HbbV2Z?=
 =?us-ascii?Q?IotSzvr47kNTUcP0MaHQKTy1uy9pioB9nTnP+a6ycPlsPgBV6JOv/Iwc4vyV?=
 =?us-ascii?Q?vry+CYoVEkpJWy6VajRgNvDm8/7uCgGxlxUOC86vC2AniRaQROMp8Qh12WiX?=
 =?us-ascii?Q?urUvpQqaCIHqG7UzY1ZljoV+4gCRHsi7CNAO300BCHFkrc9i+vb/EbnbLZaV?=
 =?us-ascii?Q?F+Cub667i7QLX7wodSKRHNDfqRuFAsiyJ/PZP/mJ2Cn2cHJsB+PN+yjBTcgy?=
 =?us-ascii?Q?YYeKeqVuQvICnlA5lXLMNvdwJUj9tLEBw7VulF7vPKdH7KvvFHCdLaagvHal?=
 =?us-ascii?Q?byQ+HkHO/jc7VtJJHfz9qqkXfyiPPitfUteOVzBlXhsof+hhYbdUE/iFJDXg?=
 =?us-ascii?Q?HM67Nw2uv58Jh1Xs7MZi4f3qklmn/BnDgd80ol9JHxzM2GmxCORX2I4OTU8e?=
 =?us-ascii?Q?p+Asa8sgpnmt1P2oyv78omlKW/pp+3qZpgqtqQzra9qYKxt2F+0hVQhONWtq?=
 =?us-ascii?Q?7ZdfBzhmcBwu0Q02mnVIlAjXR14LMTdSzBP48VX/YZ6AT5BxIk3Z2iITEGmQ?=
 =?us-ascii?Q?1mRJseK+oERgk5q8qdd/GK/L2DjwE0VZ30SKDz2RRVSltSR0/GtlMe5UaLvI?=
 =?us-ascii?Q?gHszXaFfmPjeWtZTLH+aEVTKCJ9LQW+cRwhZ4LMCmTqjdx+oI4U5WZvTHuES?=
 =?us-ascii?Q?B9d9pXI9HeugiXBZhSJVmQY83AVoImukWpRxD17q4t2Q6KvCPyFuCcl0xZaI?=
 =?us-ascii?Q?Wx+KM1lYu4oFdA0WMUdMoJAEUh6y6RxsphoPGJrVxehyr/x8DrJGAFSfZats?=
 =?us-ascii?Q?NBvnVL56g4hPteydqIOiUDrhsd04yOlM1/9JRv8WEMyOMPSfFe5xX6Izrga/?=
 =?us-ascii?Q?ljzQOGjAAsF071zY24M+JZOxVXnMFemdwZ3MHOW3X2MRw0XY0BSNSCe1LWSG?=
 =?us-ascii?Q?c8mIiJR+Z1IxyDL4ldpbFWP+eaYH2huqXo2eWCCgbPe0FIXVzXOqbsUsyeH7?=
 =?us-ascii?Q?wkzpnBX2Ob8LJSkE8WUfp+zqYzQP5v1GGAr3MHI+WTZwhcxpJ5rxh2e00cSL?=
 =?us-ascii?Q?yAu0eE0JuP9XZkrJ92Z6glG6f1S2O1B5FPZRU4M26JirTBeHTVXO/4bC0K3e?=
 =?us-ascii?Q?nBQs0h8e2Krb7AJCmWkHc/rF?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bfb8dd5-3d94-448a-9c69-08d934f11cb4
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2021 20:14:02.1837
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m0PTNM2IdG++mgVDRqb88XaQAjjd/Aa4aE7aj8g9NS/nl0NRpOAsnmpnYTD0i3YP8xtXvZQm0KiXeTa4qSJvwRpRFzyxTXf2HkduiCxjHng=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7678
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/21/21 03:31, Christoph Hellwig wrote:=0A=
> Split loop_control_ioctl into a helper for each command.  This keeps the=
=0A=
> code nicely separated for the upcoming locking changes.=0A=
>=0A=
> Signed-off-by: Christoph Hellwig <hch@lst.de>=0A=
=0A=
Looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
=0A=
